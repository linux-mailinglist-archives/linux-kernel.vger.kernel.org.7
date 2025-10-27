Return-Path: <linux-kernel+bounces-872256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B041BC0FBDD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9852F188DB1C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A5925A2CF;
	Mon, 27 Oct 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGJ8jYuf"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050F1E502
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587148; cv=none; b=C806NeuwyjtEbFZz6QDwuZZ3a/fo5RsbZAejw+UmMZviUCjf+jwauYZ+omk9nWwT8hVlofYbNKh3Q4Hg8eBnZmcNvZou2f33dGxDeKCmMt1GP5WB5qH3u46L72+95ovS1qoIL2RcpVPBkMCKfDNREEXbBOeK1DUFAU6O7wviMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587148; c=relaxed/simple;
	bh=o669fjd3dDVU9cn2su/jPAOMdfyTHDst9tkSlUsrzt4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CJhIKzFpZ1CUWmP/U8jtUxEB/ibFiVEwo1lF+ieNRSgjkHPvcWhNtRK1ZlB8x+hIk/i75fEEIZSVi8lD4tDlUWTXL9M8jPk5h4wPRp8JvxK4B0LPlahYpL2CBF4prpdNzjKnM/oKjmpD/UZn1FH+uJ7hOeCR6gEIlLQZGjzCJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGJ8jYuf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-426f1574a14so3267797f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587145; x=1762191945; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LBJAwN+hEhckPiJl2/YQkICj7IvpHc/sgZR39cQQqw=;
        b=lGJ8jYufp2kTC64Du3Oc1Puvw5a9dT5EIzAjp22a8npdcQdUldq73lb2qj06TDbpBc
         etAFZNWBgJ8DF9TS3dxHlsFz2AKhkj+4WpPYkJuYa4tib+MwRtgVkSW/i3z92qCwrIND
         0jg4GUt3rQJ4Qvd0giRxAquFaoqE5CDDf7XhsB6wruaJibVXLkMrYaknFD/p73QNeGQr
         sq1pDdEo3KvbevqqKw0J0Yr+/nc1+s+XkrOaKxccM/zIlAeJNZy3306B4O25mjmE9zVF
         xOi8Zp7GIC6wNbvLp1EzEGLHVjMa+phLR4LG9NkD67q6x9hcwj7jAvtUUOaJzdMEkORo
         rOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587145; x=1762191945;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LBJAwN+hEhckPiJl2/YQkICj7IvpHc/sgZR39cQQqw=;
        b=kKzO+MIg7OXJIR2zrjoztqnkti1pD1qGD5qJtltpN+6kRQmKxobYRZxyFdg+e3cIKE
         R9zO560m6cBJo4xKydc3tH7Hc5aFhIPGQFvgRP2VMsIviP8ltuj5kOmQFwNKhSnhaXTc
         omrILtj8zg68VQ78KE9hWYxZx0ibuO7Wt+RvzHf2TsYtV/UHIyyH18GSZQ7FqysPGtxB
         nGO2wvihXTlSxPw5pl3iSz830qqx7c+39j19hTRoZm7+NkDz/uDyt7+bnCZj+lsV0u+s
         fUIGV0cKJhYdvwKkwVLJfbLUK6A/rHVcDdEfwYiWVnRyS9nalmCie9bxgKT8/zyJHneV
         xqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8zpRz2UNyRQQMWvRwGX5n1J2M9zbesan4Ky771ZW03RQmpqSPorlL5aQ5Be5aSCfNS9imGwZiix9LLIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13keFzjeYTnqks3Nx4imNDYiS+xTN9mZHDKjcRxsaXAUhq3D8
	wRz3Wbo/H+96tDcy7sUbV0192hK0LY8BBHNBRRLLN2oW8BuASc3HVMSx
X-Gm-Gg: ASbGncuPszFGavAOe3Lkenx+FpVUEFpYdQlZJBKVGeNQ8h/RTHZo7gEoZrvtR+dR09g
	eBcmJyXPwctFgCet8rIK+SL/fmcQ24qdWc7YPDxQLILM/d0RcxMQKnhLf6QGfhmJO+3VgcwGYw0
	+lDi50lBMoCS/x/y2ojVYKxqe4nRkcmUVmt+q61Sb0Y+Kja1N7nOXtyKHXfK+kaB4WehQmVxzzg
	aItwlZvJ5TSNxghxhTbQmQdQ0gya/1NYSlC35l/xtrnU76j8xzbnDWaLDheZQ7B0rg1qBfhjEeC
	EO28Yyx2stSG0zcj6aUiQJMKLX0cDcIjDcZiNGxhrOZdNWteqqDgt1o1yp6PF9+ALqaYdhxROmC
	oDBnaN7KLjJZKCKQImw1vylotmI02Tcbypyjr26VlFF/K7zE4BFYK3trB7sRDupIf5KuPou9OMc
	XMVrJ80whtU/7Eb6R9C2mtVg1oFK1b09Nn/ko/cJ7YlbPK7yv1Rvc6pn0tb0oadVoftA8r
X-Google-Smtp-Source: AGHT+IEptkSeRjmkp008huRQkOlM+f1dkThVyqxjPThNja3/evUbxE55EXn1v0MFXcbIJnFXV5SMXg==
X-Received: by 2002:a05:6000:2913:b0:427:526:1684 with SMTP id ffacd0b85a97d-429a7e52f6bmr618840f8f.25.1761587144388;
        Mon, 27 Oct 2025 10:45:44 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:7ad3:93f6:d1b5:4923? ([2a02:168:6806:0:7ad3:93f6:d1b5:4923])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7ce1sm15214644f8f.0.2025.10.27.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:45:43 -0700 (PDT)
Message-ID: <4419385c114b344ba5c1d5b0a817a322b37624cc.camel@gmail.com>
Subject: Re: [PATCH 1/1] PCI: Do not size non-existing prefetchable window
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2025 18:45:43 +0100
In-Reply-To: <20251027132423.8841-1-ilpo.jarvinen@linux.intel.com>
References: <20251027132423.8841-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 15:24 +0200, Ilpo J=C3=A4rvinen wrote:
> pbus_size_mem() should only be called for bridge windows that exist but
> __pci_bus_size_bridges() may point 'pref' to a resource that does not
> exist (has zero flags) in case of non-root buses.
>=20
> When prefetchable bridge window does not exist, the same
> non-prefetchable bridge window is sized more than once which may result
> in duplicating entries into the realloc_head list. Duplicated entries
> are shown in this log and trigger a WARN_ON() because realloc_head had
> residual entries after the resource assignment algorithm:
>=20
> pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
> pci 0000:00:03.0: PCI bridge to [bus 00]
> pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [io=C2=A0 0x0000-0x0fff]
> pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [mem 0x00000000-0x000fffff]
> pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] a=
dd_size 200000 add_align 200000
> pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] a=
dd_size 200000 add_align 200000
> pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
> pci 0000:00:03.0: PCI bridge to [bus 02]
> pci 0000:00:03.0:=C2=A0=C2=A0 bridge window [mem 0xe0000000-0xe03fffff]
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/pci/setup-bus.c:2373 pci_assign_unassig=
ned_root_bus_resources+0x1bc/0x234

With this patch on top of v6.18-rc3, the boot log looks clean again:

pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400 PCIe Root Port
pci 0000:00:03.0: PCI bridge to [bus 00]
pci 0000:00:03.0:   bridge window [io  0x0000-0x0fff]
pci 0000:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:03.0: bridge window [mem 0x00200000-0x003fffff] to [bus 02] add=
_size 200000 add_align 200000
pci 0000:00:03.0: bridge window [mem 0xe0000000-0xe03fffff]: assigned
pci 0000:00:03.0: PCI bridge to [bus 02]
pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xe03fffff]

(and no WARNING thereafter)
Thanks a lot!

Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>

