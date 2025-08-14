Return-Path: <linux-kernel+bounces-768735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F6FB264BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE4C17E5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74D2FAC01;
	Thu, 14 Aug 2025 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP5iVCNJ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFF2FABEB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172323; cv=none; b=CiKIwvpVecl2Ql4dyGfJafPZULCIcFzTf6VRLjzTWAHDMjunPJGj6HbmEyxHqBULlpGGAFOE8+iOEu1g0E66UmWJPxsvyspdxiFj0V0BoZWTDEz6saEoTDSEHfJoCjZnZ71Hj2CkyQxM/FZ6IG5uCYwyV/Kbh6jc3kq2L0VonFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172323; c=relaxed/simple;
	bh=OX72sFDDfPChwaVulrfLD4+sI9dymomuqqW0PL0wh/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdfL/gxq3qqeZnGaT2Jhb636H+Utif3tkaf84sTTGV8BkQ1WZcNsVra+UMC3pDNwJfWd7CsgJ4OUww1R4dCXUeGjHlM5/a7QbgkCUmo3fM29sE4lJyzYJ1cBU5w9kR2bN/UfozxiE4dePPE2Fpv6iBgNMVB1voq4b9HwjIdM+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP5iVCNJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0b42d5so5894975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755172320; x=1755777120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aXYz9sti7d097J3nM05X5/YRpdJvcC3EyFw1+LP2Qg=;
        b=IP5iVCNJLbzOgUfZm7+FTlPjR1Sf3A8dJPrzlVboy7RwpxpizNjU2COdvvs9CfVTIB
         IaeqcMU9wYQTLKnMnkgNz76vRUT3hd3vgW2MhFh5qHCQmyx38lHi/oZwJAJPkhqEhU0b
         s4xpiXMu8ckEbaSQ1ibZY1tuddmOHUX3c35lCfalrLAduxRajOeUeR/CREb2aA38sLYS
         fi5WG16yxHgOH1tOVsw076snpR8uaA92JtLFTRV9knNAcyrSyUVblmFhxWw1UzXUX7hf
         v7E8C/oOsKxo64wzinWN5GvJWFRQVPjEjRSRQtnqSBmfLBEZLu1ljXpW1tldSiVwXohA
         KHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755172320; x=1755777120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aXYz9sti7d097J3nM05X5/YRpdJvcC3EyFw1+LP2Qg=;
        b=APyzRp6mJGa1fnJbMjANHOHipah+S1Oe3/hciSut6FLYs41Ej0chSQPnVi+4WtFdl8
         Wr0vmBaOozegqBkM0KLvE7naWsd9WnITqmrYG7oeaAne1NQq6ASaYAPtm47oMmYzZn5y
         FtS/7jJZiZ9KPvxrTvCIuQ87hgGkFoSWGH96imT4u99IVl5OR3uAWOXZ4X/CZb1UOV4j
         gS3Ce9LnGZG0/XiJ9tnnhfxwMAu2CYAkIzAmp9qlcGXiyK1/MjGoMOqs22HYYnrEqaeq
         PSCH1t4iDmPzkc5MifB75+jfzNct9ovTBrIEqjC/iowX8+cf9FfPZhhsyh5wF/FsZKjX
         IOPw==
X-Forwarded-Encrypted: i=1; AJvYcCVRHZpeKgVVSS3NAllnOTEZw66IcumbojYPIS2qoN783/7A5GzaZTlFjNKfHDYFKDCzUAUNFet0PKs5/CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOa5nxWqpDJftFY+euPDDUnX/5I2x4loWnakwzh9gRASRHZmc
	qykFN5hLi1q4HB8qv3St1U4mUMwwErOPEgKqSxt/gbnTnVyRvBy7zKuhbRoqWQ==
X-Gm-Gg: ASbGncvmsfaivi7v7xemTPi3PN2JK1qfmplLl7oiW2eKzNuCFgxu+GJStEkVdsZbQNP
	QwQQC8ggno75NTToG08eMKEmYxoiK6d/oVyAGC4R5rw0aSzgEGRV6ayOa1csr5YlRw8CROs2D8q
	y5i6/sCQUeq2ILDn15n4TlmX+YEOS561n37VMYpUX67Ezq1T5xntTL0003CcG3YPADfx0J+UrZL
	HaL88yOMF0MJgGEbwGtPT5kXPmjM19t/et1E93e2RsRt6+jvNHNQBS47vzwcJBn1qEyyR5iP4IS
	SC0VTUWntEuZjNzll+vMbBKKhxozm407PMolKcZh8W2e3gm9vv4aMHW+Wsh34AN+ljSUjSJq7gq
	zN/r+kJ+E3oTYAR3F+omyILaobrbFL4Pz6ZXUgRrtuzsIfcLG6AXBhFwmoGw31/KHw+rAI0M=
X-Google-Smtp-Source: AGHT+IHQP8EPep7ADC1EPrnn+2NNU3zKvL7PTstarWC09hhGA0d7GWbatSOiEGnCz0J0LGGkKz5TnQ==
X-Received: by 2002:a05:6000:40ce:b0:3b8:f8d0:f75c with SMTP id ffacd0b85a97d-3b9edf2d867mr2713623f8f.35.1755172319670;
        Thu, 14 Aug 2025 04:51:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453328sm53136827f8f.46.2025.08.14.04.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:51:59 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:51:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Qingshuang Fu <fffsqian@163.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, zhengqi.arch@bytedance.com,
 lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: Re: [PATCH] Fix the data type inconsistency issue of min (tier,
 MAX_CR_TIERS-1) in read_ctrl_pos
Message-ID: <20250814125147.483ff378@pumpkin>
In-Reply-To: <91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
References: <20250808072106.153449-1-fffsqian@163.com>
	<91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Aug 2025 09:35:19 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 08.08.25 09:21, Qingshuang Fu wrote:
> > From: Qingshuang Fu <fuqingshuang@kylinos.cn> =20
>=20
> Subject should probably be
>=20
> "mm/vmscan: fix build bug in read_ctrl_pos"
>=20
> >=20
> > Due to the fact that the tier data type in min (tier, MAX_CR_TIERS -1)
> > is int,but MAX_CR_TIERS is an unsigned type, directly using
> > the min function for comparison will result in an error:
> > from mm/vmscan.c:15:
> > mm/vmscan.c: In function =E2=80=98read_ctrl_pos=E2=80=99:
> > ./include/linux/build_bug.h:78:41: error: static assertion failed:
> > "min(tier, 4U - 1) signedness error, fix types or
> > consider umin() before min_t()"
> > And MAX_CR_TIERS is a macro definition defined as 4U,
> > so min_t can be used to convert it to int type before
> > performing the minimum value operation.
> >  =20
>=20
> Please use empty lines to make the description easier to read. Also, I=20
> think you can simplify this heavily.
>=20
> We should add
>=20
> Fixes: 37a260870f2c ("mm/mglru: rework type selection")
>=20
> BUT
>=20
> this commit is more than half a year old. How come no built bot=20
> complained about that?
>=20
> IOW, what compiler are you using and why are only you able to trigger thi=
s>

He must be using the pre 6.11-rc2 version of minmax.h

Some of the variables are clearly the wrong type, but min_t() isn't needed
and shouldn't be the fix.
Even the error message tells you to try to fix it differently!

	David



