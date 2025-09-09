Return-Path: <linux-kernel+bounces-808148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95BEB4FAD5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147F01C27A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7C31CA57;
	Tue,  9 Sep 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="WFG0R2Ys";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxHsryW+"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D34322C66
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420963; cv=none; b=R5lzkxMcLITb5nU2yYyxgurLrUAwUGLaLaJKy6H4B7RR6F4HIpJ4lDc0SN7OxWX+lGS+vFo0ffGqfUwME8zkYy802wxiJ0qpxLOK4mFB0cy66MYNw12rDdNEUrAdun3Xaxw2MVsFtsUzv16b/kaFWZNy0SoyA8TpUNAgEaAc29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420963; c=relaxed/simple;
	bh=hI8LYwkhJ2hsvMSHofs0BWyxXSx1uhBWD1aDRW0j71U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GCbL614gZLuD4zXbPSnTJ4F23Nz7taahPea6PIorogPiGPxjxKM12UxfoxYdNNfnqFmWn+Hk9DffoRrUy2PqsLPeww59H18yuP2xm0L9cKSxu0ZyQYdPpKojNcXYJ0KxQivGA4af4Aw22OnescP0E4eZo3EfCPXi0gxR78tSekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=WFG0R2Ys; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XxHsryW+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E3F6EC1D1D;
	Tue,  9 Sep 2025 08:29:20 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 08:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1757420960;
	 x=1757507360; bh=/5QUYul75LVf73bnFi+E1ia3JzB02v3UT7J4baXowV8=; b=
	WFG0R2YsdUIIn8guSOvzcR/576lHa3/Y6WikMO3iUnXjD/9KGH8xLVPfZ6cXxUBT
	6tnfFyHvzQk+sWYc7Gr7COiv1wZtB8XgnGO/DhvXBtt6kqk4LlIR3KMK7JWiC1Hj
	j2KDgA4iPufJ3yUxe9roZLdA+MrCcjGx9woeyu/zIXOK4Hhco/SPEjwwiIcn4AUL
	kzrAhL2dp2OPFD87Rs8k8dMg0NyJiix/xrZXSTbUGbwI+VpqpDPaHvW/gI3PePgx
	sAEI9/ZU+qUbNKDNa8a/azSJIu+fCq+3j3W2u0Hd1P2xRZsj3U30x8LWcrjgPqB/
	gkKPdI/y7EvW3zVjs1EPXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757420960; x=
	1757507360; bh=/5QUYul75LVf73bnFi+E1ia3JzB02v3UT7J4baXowV8=; b=X
	xHsryW+M2k1jilg6p7frTmtwRMfNY0SUYPbHr1ir1/jhH5Kxem89BBOSPOeOCiyH
	rJ4lUCVrZZAMPPB3cBrGKBcK3BiWLNP3EPeZjVPgj3W7Y4RyjYiJqVzBRiByKZpe
	xcnBYsigYXKTkNDlBa9Nesw/34kUxV+kBXvSuLITxBckTf6fhk4COf3cGVL58pOP
	otPwxlhJlu9we2mygy5l5c5ej313bWKcMLLoaHeyzZ2vV7bzbbDsVyt6hf3CaZRK
	MkL4sbRtnzi2BSOKiPUlf34NMID8IR6tdblVzvZ2g1K69GaxwRvOU8jk+K21WVY5
	fX1tu6en+jyy2kbr6lWRg==
X-ME-Sender: <xms:nx3AaDMxmZis_CXxAvgm6F12Q1Cgmxbgw7kBOJTydfczqzbVf-nVFg>
    <xme:nx3AaN_gZ3g2NfQIso-fNSMzwgSY-fm3LKqaT4JlkIuVD2FcFrS5sTwXhf8QciP46
    EQNNfMyPkhid77a1QI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflihgrgihu
    nhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeejheefuddvtdfggfdvffekteehhfelgfdvvedvkeeuffefkeeh
    heegvefhveetjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgvnhhhuhgrtggrih
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhrvghnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlohhonhhgrghrtghhsehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtoheptghhvghnhhhurggtrghisehlohhonhhgshhonhdrtghnpdhrtghpthht
    oheplhhigihuvghfvghngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopeiihhhouh
    gsihhnsghinheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesgi
    gvnhdtnhdrnhgrmhgvpdhrtghpthhtohepgihrhiduudduseigrhihudduuddrshhithgv
X-ME-Proxy: <xmx:nx3AaDGjD9vN-S3-z7_PFNUW1_V0FhiV3yBhigTFHInmiG9bZ_Vu8w>
    <xmx:nx3AaB5-eQpFa99C-QJ8nhXH29cBbRkwSgGac9-RASyhz6b-umQikA>
    <xmx:nx3AaLeNfVyM4r_eVGx7YA_Uuo-pVFoBiweFta3CvL95etyF6fg_Zw>
    <xmx:nx3AaM75IfkcYmrReEM4cD9c78Qj4tj7eJ4l97iIWAogw_FZtSSKBQ>
    <xmx:oB3AaEf4wY5kC08FVQ2P39ZVskazm6NdkWs_elRA-5U0d_XdCtkbZKQF>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D9B72CE0072; Tue,  9 Sep 2025 08:29:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW9Y6xjD3IRZ
Date: Tue, 09 Sep 2025 20:28:59 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, "Xuefeng Li" <lixuefeng@loongson.cn>,
 "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
 linux-kernel@vger.kernel.org, "Binbin Zhou" <zhoubinbin@loongson.cn>,
 "Xi Ruoyao" <xry111@xry111.site>
Message-Id: <07042615-8fc9-476f-b614-46c8b9f148ab@app.fastmail.com>
In-Reply-To: <20250909095320.4083749-1-chenhuacai@loongson.cn>
References: <20250909095320.4083749-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82025=E5=B9=B49=E6=9C=889=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=
=8D=885:53=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> ARCH_STRICT_ALIGN is used for hardware without UAL, now it only control
> the -mstrict-align flag. However, ACPI structures are packed by default
> so will cause unaligned accesses.
>
> To avoid this, define ACPI_MISALIGNMENT_NOT_SUPPORTED in Makefile to
> align ACPI structures if ARCH_STRICT_ALIGN enabled.
>
> Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Suggested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index a3a9759414f4..a86de4f26264 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -147,10 +147,10 @@ ifdef CONFIG_ARCH_STRICT_ALIGN
>  # Don't emit unaligned accesses.
>  # Not all LoongArch cores support unaligned access, and as kernel we=20
> can't
>  # rely on others to provide emulation for these accesses.
> -KBUILD_CFLAGS +=3D $(call cc-option,-mstrict-align)
> +KBUILD_CFLAGS +=3D $(call cc-option,-mstrict-align)=20
> -DACPI_MISALIGNMENT_NOT_SUPPORTED

This is a little bit hacky.

Maybe a better place for `ACPI_MISALIGNMENT_NOT_SUPPORTED would be
`arch/loongarch/include/asm/acenv.h`, or `include/acpi/platform/aclinux.=
h`

>  else
>  # Optimise for performance on hardware supports unaligned access.
> -KBUILD_CFLAGS +=3D $(call cc-option,-mno-strict-align)
> +KBUILD_CFLAGS +=3D $(call cc-option,-mno-strict-align)=20
> -UACPI_MISALIGNMENT_NOT_SUPPORTED
>  endif
>=20
>  KBUILD_CFLAGS +=3D -isystem $(shell $(CC) -print-file-name=3Dinclude)
> --=20
> 2.47.3

Thanks
--=20
- Jiaxun

