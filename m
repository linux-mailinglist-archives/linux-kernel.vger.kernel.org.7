Return-Path: <linux-kernel+bounces-820246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB0B7CFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F98485075
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C352F60A2;
	Wed, 17 Sep 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkbu0d4M"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8AA2F291D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098141; cv=none; b=IYXnm59Q1WL8beuyqdrGsA6RyJjwaGp3748e7yYsGxgJt6HHFIhT/rf31uCOLLbFxNCFrjnt788WJxqKPmC8U+YuuLLx5lKMpO95n0zFVQmDZfpu4mwQ0o3KwSwoSlYMHON9lQ31f3LY2hsYFE35oDR2u0A7xvoFaMBr3lmDTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098141; c=relaxed/simple;
	bh=/n/2Ydq41NthRlscbsdT3fErliiWg59u0VfLCJtALsc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NCBaPZYwUL4lMpwsGOZRohH66Orxx687L0N7kCgaY3Bi+NadQaBYP6yuRDooWI3MILB5KI+rcA3wO/182ZOTkkq3UZHhhChrE6o44boRGWj0siftdl2lTo426+AlUSob5X3Kz62cRK0rHDPTHcpxI/wnFOtcvMHd/DcnXJUDqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkbu0d4M; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso5675664a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758098139; x=1758702939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lmYNS88JeZ1WvUffFPJleae/MPP4g3/iZCdg2JbMw0=;
        b=Dkbu0d4MVHd+c6GHrWLYOg9rxDCs7kiqtUmVqTieIMyxLqO6hBojDfQWuEk1KXdJW6
         llzTdltVzHCiA3r4tDNDnrOO5oh7y4RsUVMUAPFlqomQ0HEE38kLRfO2I6ZKah558Ikn
         9Kh3FxmJudlK3C1L5SzrQrLDm3aWuuOMPornXKRQ7dISLn7c7kqTa8RilTbM73MrJ5Ax
         eT95RNhcg/ABGgQoqdSZDLk/L/3Veil0XE0p7EQY/+c2oxWeqqBAxqz/874cOKlKexNU
         2FEBMzj7H6gRtNceZl2tyBQmv0Toykq9LJ5Cfx1UaEf+rjjKjl0MnHVtheh0s6eWjDe2
         JyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098139; x=1758702939;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lmYNS88JeZ1WvUffFPJleae/MPP4g3/iZCdg2JbMw0=;
        b=oX/7c8DiSVRz8IgvKf1KLpn4oHUBVjol4mmNo6da8xibgqwbXoBFmtSUOowBh/+hZG
         5oZ0F+SvC6HokDqulXPb1UbsJCzLY81MDgHkHefzhTMXAbJWtnz4BJ1lSBRBGaX0KFfS
         KNNieR8WN4vqI5XxX9YMug9a/o4RwQE/CXkLvaYKiqKjEIYYrnbRKoQYaF1tPZoeFrrf
         f91gmaM8biAmYsnkqdFimOj9GffOiHa7+JMJt7/p/4JRNY5uHtS8uq2JAre8Ayfpn/dS
         ShEqGi+yiBKgG71qXk/ZLieqH3lsliqazAT53Btma6Qdbb/OO2nOG0SpgWvcd6lgc6V6
         3ZIw==
X-Forwarded-Encrypted: i=1; AJvYcCUYPWi6jR0seB4EnJJhxy+h9ujyt2gRsxnIvR1w6qfq/ekklVSePlJcuKGBWjCSqne3LKjZWG/AwE8Z4H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRWyJPtzvGjBstk0v/hUU3j0eSkZ89eiEnoDOcpax7KAlOhgey
	jcYdzxwClxHXn0PodCGf9y/5AkF5gJ4lK80fpaV9+7yXi/7mS/5Z7FDfDbUP1g==
X-Gm-Gg: ASbGncvnEEwRFMR37hd+UkBQjDrkDOeqPZbSc3z1OW7daylcEB2ug6WXxxlSS/sLvvP
	O7qYrgblk7w9HOqhoj2yZCM8djA2qnmKGRZTr5N2vRRW+s4Q4pZLoR+wMxFWRFvpHgFX798tQif
	nuQBnSFoGaX1slRNTm3UN3TfBcrTRZ5SgY332iW9lWGFC1FhqsfuJClsBLPe2rNNuv+TkG++2+r
	dI/6KmvixLcUzgHqjcUXNFH3EsEak92oyJsUJRfnKqMlag49iCmHQgKTjpBFEZnXob1iIbokC0h
	/qGTv1yYdJ+EL5ots+K3i/Btxm5sCv3XT87gtLHyJFGLgsoLyc9vPi7LTTcTy4vhU6ecWIGD0/3
	7u2JxWMtSwQKDqUAAaIhQCHxQsZbOOGfLzq23L2oh6f1GtQF02ChhqrTGDK3oaAMF/z6F
X-Google-Smtp-Source: AGHT+IGRQdCx6ga968qaUYa+JKSfQdk84gpbKGw+D4sGzhjwfk3QKsdlBJsPToWm8mvgfxI5eLXXvg==
X-Received: by 2002:a17:903:2acb:b0:267:cdc8:b30b with SMTP id d9443c01a7336-26813cedee3mr17444115ad.53.1758098138902;
        Wed, 17 Sep 2025 01:35:38 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267fa950089sm20801595ad.100.2025.09.17.01.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:35:38 -0700 (PDT)
Message-ID: <1d454604-288d-4185-8567-836e06b3cbea@gmail.com>
Date: Wed, 17 Sep 2025 17:35:31 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>, Akira Yokosawa <akiyks@gmail.com>
References: <4d4dc78a4e29f2478fd1c1a746378dc61a090ca3.1758018030.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v6 10/21] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <4d4dc78a4e29f2478fd1c1a746378dc61a090ca3.1758018030.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[+CC: Jani, -CC: rust people and list]

On Tue, 16 Sep 2025 12:22:46 +0200, Mauro Carvalho Chehab wrote:
> There are too much magic inside docs Makefile to properly run
> sphinx-build. Create an ancillary script that contains all
> kernel-related sphinx-build call logic currently at Makefile.
> 
> Such script is designed to work both as an standalone command
> and as part of a Makefile. As such, it properly handles POSIX
> jobserver used by GNU make.
> 
> On a side note, there was a line number increase due to the
> conversion (ignoring comments) is:
> 
>  Documentation/Makefile          |  131 +++----------
>  tools/docs/sphinx-build-wrapper |  293 +++++++++++++++++++++++++++++++
>  2 files changed, 323 insertions(+), 101 deletions(-)
> 
> Comments and descriptions adds:
>  tools/docs/sphinx-build-wrapper | 261 +++++++++++++++++++++++++++++++-
> 
> So, about half of the script are comments/descriptions.
> 
> This is because some things are more verbosed on Python and because
> it requires reading env vars from Makefile. Besides it, this script
> has some extra features that don't exist at the Makefile:
> 
> - It can be called directly from command line;
> - It properly return PDF build errors.
> 
> When running the script alone, it will only take handle sphinx-build
> targets. On other words, it won't runn make rustdoc after building
> htmlfiles, nor it will run the extra check scripts.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile          | 131 ++-----
>  tools/docs/sphinx-build-wrapper | 581 ++++++++++++++++++++++++++++++++
>  2 files changed, 611 insertions(+), 101 deletions(-)
>  create mode 100755 tools/docs/sphinx-build-wrapper
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 7570d4cf3b13..4736f02b6c9e 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -23,21 +23,22 @@ SPHINXOPTS    =
>  SPHINXDIRS    = .
>  DOCS_THEME    =
>  DOCS_CSS      =
> -_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))

Wait!  In the cover-letter, you said:

    It should be noticed that it is out of the scope of this series
    to change the implementation. Surely the process can be improved,
    but first let's consolidate and document everything on a single
    place.

Removing current restriction on SPHINXDIRS does look inconsistent with
your own words to me.

So, I guess I have to NAK 06/21 as well.

Regards,
Akira


