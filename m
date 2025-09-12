Return-Path: <linux-kernel+bounces-813422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8A5B5452A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D381B204F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD62D3ED2;
	Fri, 12 Sep 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8Xku4Jz"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5578F4B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665373; cv=none; b=n65aUCF1xK75UjCvw3eGphvVs1tLnkz0Qi3RG9kWUF90Q2RQynsT0QH/48GxhWnKh9uvGVzvpEOGi8RUdJDZVu+CupyeoXn7lUDxVH80hPtaOY4oRkyfkO+KmGC+xh9WA6qQXVCyPoQt71q0TPPi1bPmhp0JtDQct4tYYFcFDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665373; c=relaxed/simple;
	bh=XyDD7Jo0W4AdFRNe1yLtzRhoLlETra5gZPYENiy92+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8VCaIoZJVwKd/+B6O7fRLOvtmR4CjIMjQdAhqJZXSeHuddl4wJLi8TMndBJArSONBut13+qSXzLCfiGNVj0s/O2uy9EKBAqeJ7sT72yOhXLEBIZ+YDn/+z4yZA2mWBUXNUYfV4mN2QUNwxRDce28ogNoqqZ0DJSEkySqMfd13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8Xku4Jz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32dd4fa054bso1350379a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757665371; x=1758270171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyDD7Jo0W4AdFRNe1yLtzRhoLlETra5gZPYENiy92+w=;
        b=P8Xku4JzuI7Q39LjhzPR46r2RRjXrqB/qTqLA2AXiB4OHe8tejd78LFwOUXI2YRNGH
         r0pM00Jro6md8oSXQK2yoXZBoGqLChcSOHVfBLFlk/CpCPq6+oZ+ElHvha92DXyb82M3
         /YbtlEb4RJqbMSyqKOeNyd6LMAf9hPVZinDmfd4ahWgX7uRyESBv3tdc4SY3PFuA23k/
         IboFQKHaTf8gxLnkcHCzeLspicl93MVL8Cln8axTa2YHxOS/+CNcIXIjvLshLm85q2Zl
         GBFffIQXSl0BHiltVGp3RtXacIfULzuTC1WwvQMl2Ea5wvPv1ldfxf/tUMy39b1NZqg+
         h/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665371; x=1758270171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyDD7Jo0W4AdFRNe1yLtzRhoLlETra5gZPYENiy92+w=;
        b=ppxmDJ9+2lVxla0m0mHBJOWqo7q4O0ey+vxO6Ph16qRiF8IdsLTxI5BdE5Dxd4Nmu4
         fHfEeQhBdWVlb11P+YfH1fi4zCDiAw2Pea2k0REqykt38e2wB68iWtEIt9cvt1l4eQ2s
         djGk/DZLe7+K7XQTAhRVAyUj5HcXzlckS2SAwxGYupG5Sa5a5O6cx2LL3oLJMqO0B2ud
         irRvI0AmShsfdS7hBeM9o1sQyWVvPG0UdkSMWz6QJeJ/RzmHq2O7k5wTHxiy9eKnvPDX
         kFTYSm7PlRctflA3c6gcZfWHLSkeuF/8uv9fmWv3htQU1j5zRSfXswPtNcfCKo8Pctso
         iS1g==
X-Forwarded-Encrypted: i=1; AJvYcCVDFvKcJSJr/jNCF4OG2E5kT/iupZrxxwqmWsq/iQUbTAM8HUhfKuk+Hb+CjC9rAZadGHlTtE8/hM3q8vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpsjC8MuL/3A3xw2kwS3HV+iHQcShEkOUNxVYQBF0RP81ACNY
	sY2LqCeKKXZ8zbbHZPQ7TM1TIFHKgCCISWIig2m9DL97RNcPVSt70CcLKi7zUxcT23/WWGhg+Zh
	sfLgFqwva4LAzav/PfWMdFmXNlBMHJ3E=
X-Gm-Gg: ASbGncsIXSJxXaJ652tCCi8FnZeoAAAeqiumohPRiMHDiRYySuF/o0w1LtqVkfslslG
	+M5jM+njTNa4ZYKoe8XQswk5DMtXSWmwilWw3IU2Xu4fITgoka2pf3vdE0Lrni/IVlmLPAfCFbf
	vGrtIIiifzQvlW3BhTWsLRzMeVm8eLzYkk2PK+VzYux3HaKZ7osCM6oZbaHlvDPQprrc7gEJDfJ
	UdgDobTygqmiqYP+/hf6nc6YNv6Spc+4j6aJCSMA8qQ0AnH5V9q6mxbC2coMqbjQXJgW4P+xoYf
	qijXBRaY3TlmbaZg
X-Google-Smtp-Source: AGHT+IGRRn87hEmlT9BlQUhlxEPbl6k3VycuY/RrB7pBvofYdWVal2EMBRbh3UEM9B13lU5iAXJfH6w5EUP+bGrbUxU=
X-Received: by 2002:a17:90b:2802:b0:327:c583:add with SMTP id
 98e67ed59e1d1-32dd1d3b2b0mr6031421a91.6.1757665371257; Fri, 12 Sep 2025
 01:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812051949.983040-1-linchengming884@gmail.com>
 <152133202.103367.1754981828821.JavaMail.zimbra@nod.at> <CAAyq3SaEqYiKhbjYwLH0p6F2G=UR-MwZF28AG1xVMoKhznS3Og@mail.gmail.com>
 <608935583.115196.1755171013804.JavaMail.zimbra@nod.at> <CAAyq3SZT67uwggdNX99qEc4bwSkUw2U=sCc6mon064D=f7oH=w@mail.gmail.com>
 <1899901955.27456.1757663848457.JavaMail.zimbra@nod.at> <CAAyq3SZmuTPrEb4i7QR-4Gi6YWsLFGOGm9=a0UvLR5rMLiLxsA@mail.gmail.com>
 <579487457.27484.1757664285819.JavaMail.zimbra@nod.at>
In-Reply-To: <579487457.27484.1757664285819.JavaMail.zimbra@nod.at>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 12 Sep 2025 16:19:46 +0800
X-Gm-Features: Ac12FXwvjQ1mvwEggYpp-IioBQeWdKmzQ1UXyOy3YM8CYGEnfJ-CTCA_VLOcqXU
Message-ID: <CAAyq3Sbv2uMnoqC1-jCfMwzs3pNRrDbT4UNkAtQTBKqYq8MAwA@mail.gmail.com>
Subject: Re: [RFC] mtd: ubi: skip programming unused bits in ubi headers
To: Richard Weinberger <richard@nod.at>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Alvin Zhou <alvinzhou@mxic.com.tw>, 
	leoyu <leoyu@mxic.com.tw>, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Richard Weinberger <richard@nod.at> =E6=96=BC 2025=E5=B9=B49=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=9A
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Cheng Ming Lin" <linchengming884@gmail.com>
> >> Thanks for the detailed answer!
> >> So, yes let's apply this change.
> >
> > Sorry, I need to adjust the code a bit, since I just noticed my
> > condition on vid_hdr shift was incorrect. I will send a v2 version.
>
> I expected anyway that you'll send a non-RFC version of the patch. :)
> Just in case, you ran ubi tests with various different nands?
> nandsim can help.
> Especially with and without subpage support.

I have already run ubi-utils such as ubiformat, ubiattach,
ubimkvol, and mounting UBIFS on NAND flash.

I will also run ubi-tests with nandsim on different NANDs before
submitting the formal patch, and cover both cases you mentioned: with
and without subpage support.

>
> Thanks,
> //richard

Thanks,
Cheng Ming Lin

