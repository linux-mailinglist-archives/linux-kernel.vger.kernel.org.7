Return-Path: <linux-kernel+bounces-869882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8A9C08ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24FD1884D15
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F462EAB78;
	Sat, 25 Oct 2025 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgHHvBZB"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAD2EA480
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387083; cv=none; b=Lht2XkAqxfk6aE5qyC/xkm5lg6XmUWdMSy2BgTggtafR0yxXJPKc+yYTE8zoDL6VOO0j4uNxlRJP9Hmb8+j4AJeADOxmkZMIs8mWH6P4dLaW42BsN9hvv/EHN6HQzTmmAJXeo32uCHoEO5WRFaR2zW6VHdawYvnwVL7E4nYJ2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387083; c=relaxed/simple;
	bh=0nttiORIlAvHv5WtRRqjrF4cMesKYVIkYZR+vwF8Z9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TP26syTie7Rp+YY8BH+QYPcvSDzZiFPrYTQQfKO4ejW2AYiglP2sST+ZO+GAFQBVRZQVKU7Rd75eFTh0jeyFWJsvRNqon/jdMRxhhGT5DEWc/emooCn/ajY1rKaC6bZp7K8LYoJlnEWyfWmthAhkf7vtWSuAbsMqknkNqgTr84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgHHvBZB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bca51so2627977f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761387080; x=1761991880; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=egj/7WjRwjT6riGuR0koHtTyjN24c/LRgAczk/OnsWw=;
        b=HgHHvBZBmXFecfLdAJXTNhYeCvjdhSbtWXwrwtx+X5ZNNyDLP+RSAuqKEmG9bLtV3t
         9wHEvI01s+tYTPBp1Lx/9B72t1DmN5W1BYhcPfVUY+UgTsr4YBK0mBtKr4ks/0LEOFST
         QRcFOQ5UuN/ZERtpvcrTJB5FtG+xSQkywimig5R0n71+Sv9fsYwGbxo11A5d35gj8sN/
         zOW80PraL51kr+eudNgCruntRDDyfRRR7uJIQxPax7+JuL6xU0g6Mn89HM2r0RSWmqK2
         QDMPb2gJk3llajzDXoaBxXyG+AUxwm8eNyH6xFEVOaZObnd8wvYl7pikU/o8MMxEUvkP
         mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761387080; x=1761991880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egj/7WjRwjT6riGuR0koHtTyjN24c/LRgAczk/OnsWw=;
        b=aqT2XnPXMRnNWTsxGda/GxYUxdEIcfV59Uy2tG9oVzNEaDR3sJjM6l5vWb931Nx7+V
         adkFlrqKsNY66f0iOh5EHve9hesC26PRkUzP0bXqhgT17Kxc7mS37pLtEo2ySLX2RDQ0
         e7ffGJS35VnM0Aynfm0wk7NTVReBPFvQ89WuFmWVhGqYF4AXiUzbM9FRdItmy7j5Opd/
         GGkkvSzVWXVaX0W1mEKiyJXnIr0wkEvKDfQvI+q9HboGOk+HxPCc8k/bdH2XO5rJnDht
         bRXE/vaF39NfpBp8kvVZnC/vmCWfDz3ULpBfsemfeCI+eBqQ9CgdO1tfnto8zcUsfbKT
         JYrA==
X-Gm-Message-State: AOJu0Yyh0hePetnSseHj0jWin3vO1U9Dbplhd8+goQOh0a+lA0zVNEgZ
	dvlyCvydA9PbRnaV1frkcA1GVHDOuojGup/dxej4RyaTBJF/ueoj3Q87
X-Gm-Gg: ASbGncuEZaDzLbRwhAFMPt2D03b3tFiEfdtnOTEHhzQ/vALZ4iJ792U4oXOB4zQKA6l
	BWJTTcMiVz1cDMS1XEwTccka9+PTUqLMI/1uX+indBV/F1ivTaXS+ozxjbNFNnjMdd9ur6pwNQL
	JV1KClVHQhEzJsHdQdT1jTp9yUBCxRFg/p+6r1mFi6kiyrRp7IZO5+xrScMo8EdRRJ98fiwH5gt
	o1fP4z9n+FcjlY298YwCdcDuK3xEdqrfRtKdE7jXHwumTHsP7/ozo6Kn3FwlCkZ31XZpJne6bvh
	umEGd3eRcQ5NFRUYuj/arnWitcw3UB7y9Gblc2tPyzNHEQTDLgc9E5ihAEm7nvUnysU4s92u32L
	tgNxklg6wO1A87mgvvWW9/YUVkV0pC441LKJ7GRu80oXHbm9Dpj82YUNBK1JpmFlcX009uce2aa
	P5A+axxp3o0rqDe6pKHaBa2EV9UkV87J8qYtMvvaH/F1+UYrMbW2rm/CRsig==
X-Google-Smtp-Source: AGHT+IG7ABSr4FtdNNEAo2tbvL9ho+vuY3QRO6VXg6V+Dbe1PORYyrFkPG6pems45nomzqTI2u5v4Q==
X-Received: by 2002:a05:6000:2911:b0:426:d734:1378 with SMTP id ffacd0b85a97d-4299071090fmr4006603f8f.4.1761387079673;
        Sat, 25 Oct 2025 03:11:19 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:c4ec:4cfd:1e64:7a3f? ([2a02:168:6806:0:c4ec:4cfd:1e64:7a3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b22sm2915027f8f.9.2025.10.25.03.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 03:11:18 -0700 (PDT)
Message-ID: <990fe39da66ad23df4c85ef247b274a0fc6c2336.camel@gmail.com>
Subject: Re: WARNING at drivers/pci/setup-bus.c:2373, bisected to "PCI: Use
 pbus_select_window_for_type() during mem window sizing"
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Date: Sat, 25 Oct 2025 12:11:18 +0200
In-Reply-To: <51e8cf1c62b8318882257d6b5a9de7fdaaecc343.camel@gmail.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
		 <20250829131113.36754-20-ilpo.jarvinen@linux.intel.com>
	 <51e8cf1c62b8318882257d6b5a9de7fdaaecc343.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-18 at 10:14 +0200, Klaus Kudielka wrote:

[...]


> Device tree: arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts
> PCI driver: pci-mvebu
> Hardware status: The joint mPCIe / mSATA slot carries an mSATA drive, the=
 other
> two mPCIe slots carry WiFi cards.
>=20
> As far as I can tell, hardware is operating nominally, so the warning loo=
ks like
> a false positive.


In the meantime, I stared a bit at the logs, and at the code.


WITH the offending commit, I see TWO identical lines before the WARNING:

> [=C2=A0=C2=A0=C2=A0 0.027107] pci 0000:00:03.0: bridge window [mem 0x0020=
0000-0x003fffff] to [bus 02] add_size 200000 add_align 200000
> [=C2=A0=C2=A0=C2=A0 0.027115] pci 0000:00:03.0: bridge window [mem 0x0020=
0000-0x003fffff] to [bus 02] add_size 200000 add_align 200000

So, this part of  pbus_size_mem() now seems to be called *TWICE* for the sa=
me bridge window:

		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %ll=
x\n",
			   b_res, &bus->busn_res,
			   (unsigned long long) (size1 - size0),
			   (unsigned long long) add_align);



WITHOUT the offending commit, I see only one line, and no WARNING.
> [=C2=A0=C2=A0=C2=A0 0.027405] pci 0000:00:03.0: bridge window [mem 0x0020=
0000-0x003fffff] to [bus 02] add_size 200000 add_align 200000


This behavior change really looks suspicious to me (maybe resulting in two =
identical entries in the realloc_list).
Does that ring any bell?


Thanks, Klaus

