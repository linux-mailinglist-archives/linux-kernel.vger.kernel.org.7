Return-Path: <linux-kernel+bounces-873146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4FFC13381
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 622984E95A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5516B2C1587;
	Tue, 28 Oct 2025 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="jWJDhr5q"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89111248886
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634728; cv=none; b=l26i9g7QL785LQLBfEzg/ZbItfKvwxAEfhUrD0A//C1ebEL/09QQDCjT+F14uMr4jyURxtycnFOMmNTVtFyXmtCqtVklQEqQVq8V1HilbGKmTMjP0kELMyHwwperG3S3S9qJkEwXk4GZL/YDSb/6joBQHGPaP5PKNgyfy9sFCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634728; c=relaxed/simple;
	bh=IcpcehS5Fl0yImjYpIaQdsh2MtDqwKJCpu0+KpAln1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+OjZiW7JRfQFqn5nmv57a7nLh27w+81+BWiLzu2YktF6+236FMaVL/nJy1yoUDGXFKeTPBv1Z2XwbItAlfPeCJSggzHW62xogScg0ZnXD4pRSIIqRaCnmDvUa43zf845qIiqD4P4ccBWbks0mAG0JTfBFD9fOswmGZnD27eyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=jWJDhr5q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-269639879c3so48274945ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761634725; x=1762239525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQ7p6xtC28C9VulZxo2oktqaX1uTl7IBrRCBfSYBTAg=;
        b=jWJDhr5q0gPLs8HF7sgH5yMPPez5imPdJ3wQh/rtFZqynn2bwF+jn1byZtbWUdPAG5
         78uOzYB3eFWxTDq/k7JqZHROoAXTuUymUGMbjGF2g81DBXTjIi+JW/NBOBWzmNC4fMXA
         HhbfuMhZhBeWeHgApSthiGUuVRnQ40uk/Wuv4OF3g0ze2xVY3/+DyBO/HtaitwrEZUm5
         Thx8o6ekIMc66EIWfwUjq7R+a6jC3fkYjDWq/civHTzoGCt7Iu+D7G6Gzx4YICIBUBgp
         AxDfQpJe7eT8w1SN+dRdpzPvdZEgcw1mMsChvLNV0JsYBfqwePtMfAVWnAlUftgbbmZF
         GD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761634725; x=1762239525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ7p6xtC28C9VulZxo2oktqaX1uTl7IBrRCBfSYBTAg=;
        b=ONfvEkleS10tcEx4ZHpQDKlAZSFDV+AQeyN2mPybJHl3OFT4P+Atqgb1HH5vfU5+fH
         8IS9aqtH9dohy2HOZRpKcFKwR58r7vXDRcCs/Vjeksyhy141J+JyPu14Z0JdXS5ivoXx
         ZalbxGFO97LWXEvGAglYb9O1BiXhZbRD/vmRBV1DJG9ekaRBN8WusJp+Nz7o74ZQSpfp
         Fcxych2KmLEqPUuccFjJI2RC158/zi2qKJfX8V4E1UClk1CEj/vQwH+9NHXz8fC2pwJY
         DIQZC5rLDfFPTluz3p6k1FOtlDQ5uD2eX4B50nbjslJDasD+N8MG4hFmD2zWiAoPkPgZ
         fA1g==
X-Forwarded-Encrypted: i=1; AJvYcCWdVTSYRjJZCc+5LAU0mHgy/OMhps3hp0Jtj8bjoYs3FNK+IlXvurujhLVMtW9Rb0HF9FlGzYzxu1Iud1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6fcprnTNz0Dz7vzXzHCxgXU3brjyCZ6OqxiRhdFOo7FAP7Ul
	2usgy+oN2631SiGpPQAtUHh/CO0HnkLNIkDKjkapuTBRtRpRAcxJuTVeWYhMC9ieY4w=
X-Gm-Gg: ASbGncvWaL924j8t+5yezKJ1oLqfjGDqlPvJbhVSd7OAiBx4DpfpCLhMHhD47Ha9+6r
	j1JQCeP/29+68M2XleK6a0dmc25ynMAavFloRnMhjp0GzPR2VO507rFcgvYrSyd7vKHpnanfMf5
	Jwr1oZmdEOTG6VzXDOIN7QvWds8vL8sMpCLXOxsPaSoCgccuWJwf4aUCEJpWE2d6t9pm4eUlEv4
	KC65NoHoJVTG3nEeHMvjHTl40V6BAZECyGgXKlMkp9o/Qfc+WyhEF95pHRte4A6MLqX2Hz/fRkr
	kwYpNGjOYf5Y6zYjqJ2fGsCBLoYxw+RH4jfvSsddQr1WIR1t3GCKwnS+EMFTFsgH9L44qBVF8bq
	OVjm0nnAD3wExInNMYS5o07MnC0H1n4Gf6mVKHxj0b7m73Rh8ZTABLoOw/FxrHAVqRBpCzgT/Gt
	jBaJqDK76M+DWUa1r6lrAN8g==
X-Google-Smtp-Source: AGHT+IEQUls0hQ7f0z+eHUlXVig3EP8vmtgVoNPcCaAzKcFm3wz2AgyR/G6DDFlaIKDkK5sA6SsRRQ==
X-Received: by 2002:a17:902:ea0c:b0:269:91b2:e9d6 with SMTP id d9443c01a7336-294cb5196eamr33134075ad.46.1761634725462;
        Mon, 27 Oct 2025 23:58:45 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:d6d5:e94f:6bb8:7d7f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d42558sm104262595ad.69.2025.10.27.23.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:58:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:58:40 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: David Laight <david.laight.linux@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	akpm@linux-foundation.org, axboe@kernel.dk,
	ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
Message-ID: <aQBpoI+93UZg1SqN@wu-Pro-E500-G6-WS720T>
References: <20251005181803.0ba6aee4@pumpkin>
 <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
 <CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
 <20251007192327.57f00588@pumpkin>
 <aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
 <20251010105138.0356ad75@pumpkin>
 <aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
 <20251014091420.173dfc9c@pumpkin>
 <aP9voK9lE/MlanGl@wu-Pro-E500-G6-WS720T>
 <20251027141802.61dbfbb2@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027141802.61dbfbb2@pumpkin>

On Mon, Oct 27, 2025 at 02:18:02PM +0000, David Laight wrote:
> On Mon, 27 Oct 2025 21:12:00 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> ...
> > Hi David,
> > 
> > I noticed your suggested approach:
> > val_24 = t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18;
> > Per the C11 draft, this can lead to undefined behavior.
> > "If E1 has a signed type and nonnegative value, and E1 × 2^E2 is
> > representable in the result type, then that is the resulting value;
> > otherwise, the behavior is undefined."
> > Therefore, left-shifting a negative signed value is undefined behavior.
> 
> Don't worry about that, there are all sorts of places in the kernel
> where shifts of negative values are technically undefined.
> 
> They are undefined because you get different values for 1's compliment
> and 'sign overpunch' signed integers.
> Even for 2's compliment C doesn't require a 'sign bit replicating'
> right shift.
> (And I suspect both gcc and clang only support 2's compliment.)
> 
> I don't think even clang is stupid enough to silently not emit any
> instructions for shifts of negative values.
> It is another place where it should be 'implementation defined' rather
> than 'undefined' behaviour.
>

Hi David,

Thanks for your explanation. I'll proceed with the modification according
to your original suggestion.

Best regards,
Guan-Chun

> > Perhaps we could change the code as shown below. What do you think?
> 
> If you are really worried, change the '<< n' to '* (1 << n)' which
> obfuscates the code.
> The compiler will convert it straight back to a simple shift.
> 
> I bet that if you look hard enough even 'a | b' is undefined if
> either is negative.
> 
> 	David
> 
> 
> 
> 	David

