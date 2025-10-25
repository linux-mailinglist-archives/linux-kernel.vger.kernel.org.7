Return-Path: <linux-kernel+bounces-869934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F7BC09081
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4951C235E6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A3F2FBE19;
	Sat, 25 Oct 2025 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqQyoq6a"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8E2FC88C
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761396252; cv=none; b=a7tJcHfV31xKaQIWLH5Ci/5XTNApO6NY/8H1TQ+kw2GTNlccpnwmFg/t9GDGQuKT5CKsOtcz66itcOfQFZnL9CP96Fso4uB0zywvKnCoRsgdwPt4cViyTLNZWYCXUISCtRMHcZCtQiVXUOUPwSaJc2JcSrenfG8gz04Lt9nszAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761396252; c=relaxed/simple;
	bh=uHwEWGWussA5vwUdmTXYqVWHoUC1FpOBR1zr7bgFbpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h940ZubXY5bryDpJujq1R1ago4pohvl8zxkJr0uj48CH0IJ2emhqgZxLrNN0hI7kzcL9PVQIdhMBH4eECvRQ+ibyzNWAdemyymRV6fuycyiNLahyRvHTffbORw7803RAhiGp+te75qNMgSHKO5gJqBt+9zTih2x/LWuWcgxgqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqQyoq6a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47106fc51faso37271825e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761396249; x=1762001049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HoSJRtaYL1tSrAroXfLuV9j/PINsSdOeSgQvYolSDJo=;
        b=AqQyoq6a6+EhnpsS6ka4cquaYWGOvgeJ8hShMxPVkIYS643eN+2L9+jzTJO+utn3Hn
         7MK602Nvpii+epVPP59ZOR/kyW6GDiKy6Q03W0OFj+5oc9zg9k/zjc+KBM9l5D5rNPtI
         Zvt0m4IgeJinggHGGoCdHNGbgVFGteOmaOm1iz8B1trpoUMsgTqpCGNHdqUXwWITQ6tX
         QM8cF46GWKxWKlwxlv0aqHVVQAkzRLLTVfnXMPS/eNpuWOVsCa4TyxdEaZZvsrMAckrI
         s3Z3U8zgwr7LSqEypFvqFys7DkS6OI3eXEljnIVsVS2BtMS+u9jmCwDPGhMO6280vA7c
         INEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761396249; x=1762001049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoSJRtaYL1tSrAroXfLuV9j/PINsSdOeSgQvYolSDJo=;
        b=I7bV719v2IIuSCVG376bTNN2Lv518zpnTLzji4OSQBFYnwndJ9aS4rmCBKIEaJTRBZ
         XculzgR00vdfjJCpZgXjFrQ8ky1sRi7P4MthqNtxEYMgooLMpaCGRVFsHOJzVKdLToF6
         VfDvROW1vhAb1mpFsmSQC2KIuQY2DOHxifdXz8RJuaReUUTV4vr4vnEXtmN3vZ3xN3Dw
         aSNOa8UuVtBND7lIMVLZYdYlzMPeuTZXaIfe7jSeuS03mJS9u+mf/r22pb5kxq1AaXpG
         IpMi5uMJIKKTltDOpKJdS/+bzAXMZW7V1OmTx2osfewDYtfe8xQt2Q+B/YhvLUISfv77
         YR7Q==
X-Gm-Message-State: AOJu0Yz3zTcx0OrZvYTmiaY7tuFz75e6FEDY/U17yujBh2WgvvxrfkuY
	d6a4bhumZJN/kK9i1BuGAx9JCPNSXzLCtw6TeF422mmcu9uVdgCFtE9y
X-Gm-Gg: ASbGncvOZwHb+WumQakN1/3fxnP5em8SMuOtvPrLJNhoS6cpPVSUy8yRDQQzgtcJFEL
	8MYtrocpKeO8LG6EzzqBIK5Qr0VAmHozCORaM46fSD5I2q8eUE7MBFDu4KhiiA9zDIEg13d0Ut5
	mSbP8rwFzDdKCRHfUTS5Fc4Bu6cPoE224GjtZ5E9lOI0Zc3wNKUi3szh6OuZta/zNoYplBljMQ5
	vsDE5Ws7i24EJlr1fWdd/xUXAgNkoHvnImeizULaHIC7XYRcGjgXpL62nGFEaNVAtr0xgUs3Sxv
	TISllXwmDxjyMQ2EfXLhf0SEs6yC7jp6Eiv98e1TV3i2wJameAUzftvWdqC4OLsMzCt//xs8Aho
	YoNEzanj0n2wbNRZQzwAj0PO0FJNp2mOu6tzvPXKtRP49dnGNHZTRmHhUiVCpHEXV+5zp9zVYkS
	faWmrCfXAHqZHPXyMS/S/t6B6jrsy7bg0zAOCxOLoSy7v4fZs=
X-Google-Smtp-Source: AGHT+IGE/ePaRlpeqp31jgCbwX547WUuKY96Od/s+DN2HDRytz5H58spbiUrGnbS+FBuiBiLsfE3sQ==
X-Received: by 2002:a05:600c:811b:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-4711787dcfbmr221625375e9.14.1761396249181;
        Sat, 25 Oct 2025 05:44:09 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:c4ec:4cfd:1e64:7a3f? ([2a02:168:6806:0:c4ec:4cfd:1e64:7a3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd478202sm33465995e9.14.2025.10.25.05.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 05:44:08 -0700 (PDT)
Message-ID: <af6f0f2e1dec9053c6984139b8582fc6ceab6813.camel@gmail.com>
Subject: Re: WARNING at drivers/pci/setup-bus.c:2373, bisected to "PCI: Use
 pbus_select_window_for_type() during mem window sizing"
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Date: Sat, 25 Oct 2025 14:44:08 +0200
In-Reply-To: <990fe39da66ad23df4c85ef247b274a0fc6c2336.camel@gmail.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
			 <20250829131113.36754-20-ilpo.jarvinen@linux.intel.com>
		 <51e8cf1c62b8318882257d6b5a9de7fdaaecc343.camel@gmail.com>
	 <990fe39da66ad23df4c85ef247b274a0fc6c2336.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-25 at 12:11 +0200, Klaus Kudielka wrote:
>=20
> > [=C2=A0=C2=A0=C2=A0 0.027107] pci 0000:00:03.0: bridge window [mem 0x00=
200000-0x003fffff] to [bus 02] add_size 200000 add_align 200000
> > [=C2=A0=C2=A0=C2=A0 0.027115] pci 0000:00:03.0: bridge window [mem 0x00=
200000-0x003fffff] to [bus 02] add_size 200000 add_align 200000
>=20
> So, this part of=C2=A0 pbus_size_mem() now seems to be called *TWICE* for=
 the same bridge window:
>=20
> 		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
> 		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %=
llx\n",
> 			=C2=A0=C2=A0 b_res, &bus->busn_res,
> 			=C2=A0=C2=A0 (unsigned long long) (size1 - size0),
> 			=C2=A0=C2=A0 (unsigned long long) add_align);
>=20
>=20
>=20
> WITHOUT the offending commit, I see only one line, and no WARNING.
> > [=C2=A0=C2=A0=C2=A0 0.027405] pci 0000:00:03.0: bridge window [mem 0x00=
200000-0x003fffff] to [bus 02] add_size 200000 add_align 200000
>=20
>=20


After some more testing, I think I know what is going on.

- My device seems to have only non-prefetchable IO resources.
- In pci_bus_size_bridges(), pbus_size_mem() is called twice, once with IOR=
ESOURCE_PREFETCH, once without.
- This seems to be the intended behaviour (with or without the offending co=
mmit).

- What DOES make the difference, is the use of pbus_select_window_for_type(=
) inside pbus_size_mem().
- On my device, that function returns the ***non-prefetchable*** resource, =
even if being asked for a prefetchable one.
- End result: b_res is valid (and identical) in both calls to pbus_size_mem=
().
- Honestly, that does not look right to me.


Indeed, my device goes back to the original behaviour (without WARNING), if=
 I go back to the original use of
find_bus_resource_of_type():


--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1312,7 +1312,9 @@ static void pbus_size_mem(struct pci_bus *bus, unsign=
ed long type,
        resource_size_t min_align, win_align, align, size, size0, size1 =3D=
 0;
        resource_size_t aligns[28]; /* Alignments from 1MB to 128TB */
        int order, max_order;
-       struct resource *b_res =3D pbus_select_window_for_type(bus, type);
+       struct resource *b_res =3D find_bus_resource_of_type(bus,
+                       IORESOURCE_MEM | IORESOURCE_PREFETCH | IORESOURCE_M=
EM_64,
+                       type);
        resource_size_t children_add_size =3D 0;
        resource_size_t children_add_align =3D 0;
        resource_size_t add_align =3D 0;



Comments?

