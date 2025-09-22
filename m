Return-Path: <linux-kernel+bounces-827123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF2CB905DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A0F17D480
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D172877DF;
	Mon, 22 Sep 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4AsqHM+"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA5256C88
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540646; cv=none; b=Utj5iBJmy/Yof9X/aQIpprjIHME6VcrInHdLlp3YMPOGFxumSdKrkWM+i8uevj86TF93YB5bu4KGhKsioyvotq0wtlrAiPCuUysKK4aINjCptjt6idH3GtC7f0CqcxsP1AsjvfAGUaZ2/Avf5uZHSYbihrDgNz0506orN59zInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540646; c=relaxed/simple;
	bh=exJIaGVZRA41ft1d8kldxrGWTT6BfUiUQXmXRuV8u7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwpmWgjOCD7zeH9OGkLAznxD30voLiRnZiJHPNrHSDx23b/2Q5Ejdb2kL9uVgEp4R6+2LiPCa4lUwB3ZZECAOAEIFOaxAVXd1H/fOpB5aYf4++wWpexUjw3lch0cS15XinxuR9A2R6MhloU/pNZaNIx/Aj54mnuJHk8iNgbMuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4AsqHM+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f454c57dbso334609b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758540644; x=1759145444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d19kgaF4cF7llUtlCB54elxTKW7Xa+l9+r8wNmLGWJc=;
        b=S4AsqHM+5vJgfCvIG50kpNj5WK9bfsWFJg3HYHbsOVzydDRH3dFyABCKqncyWEZADo
         j0r9J1bMGrywAWKaJjUELcjLDtwAPHlxTFvhlMbfuQ7PriBJfFT7/aoOEgGY77ydfUs6
         HIkDXl7EizSTWRQeQtiNS9FH4mATWvcLflZnCQyaYav+dlBq8v602PlihUzOPP2sBsmc
         dGtwJ50L+aF85IKldEpQtLJKVD5RFZJyBr6oAvHuDRWhJTal2uG8GBJnXh57s7/luke4
         Ic4H7CCWl6eSO4suZpNwvSNjJZQS/82UrBMKbuhsRNXKKmzXz2arpJE5dc3s+wWUxXg1
         4j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540644; x=1759145444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d19kgaF4cF7llUtlCB54elxTKW7Xa+l9+r8wNmLGWJc=;
        b=f5oSezX2w320b4WhKC6486VXsXEo79hAFqfXABKqVeUeJKNP1lSoReBT6xF8seAZrR
         fJZJwwoiLOQOyKxyYB7yuHle76Hq1RDJ7Ptuo5CiUNuLTUlB66Z+Kq5aCYeRDW1dG3zp
         lW4MYVM+l+kAigi9RbcKEwq1fzt3g8XDf6v/q1ZzRhVUZcztSKmSsf8ozYvA/EMi+0Oh
         tppG9Q0N1QqoQfMsPpPdiD24cqjeSHJloC41w8hKxoHbkeNtPhf58vbSaP/xVTVbg/54
         Wlql6b8EwzTZucmBMiw07NxWX80m6Iyx3y0wUAPH3y9PWUiB5FlwFv++vO8udhxrM4E5
         iaZg==
X-Gm-Message-State: AOJu0YwxIdXf5y1Sh6E/Oru/croIJ16aqwdxR9CWGo15Ljg9TgSQfEHd
	7mrWau5tKROOi0NvZ40y0yFz/sWEikoSEiM7QlxlsDodKqbZfnhEx78I
X-Gm-Gg: ASbGnctCTylDhpm4TYVCdajrpLSEsOPYv5XFWfapT4neUo1/GaPeIDqsH9tMKCxsiNL
	yI09xyxtIK+daDdA8RGE0RWDf/wTTrfw0K+CyoF0pC+nt+E8U6jtO9mRngLXCoaFQ+zUkPbQPYE
	Ms3NBkFJQiLlAlVPcqSzPOVdso9EznmRY360PhBsAyF0Ms+oONu/va22NFQxAx/86Ee2N6Jnhll
	ItZLKYiIGfFUZFXvams9hBAXSaHY+U9WVho7QBSJ5EZy4eMydRcz9pdH/2cMnf8+uzBWYqhEGL8
	inFYEEDqaPpqhWsbbRZr43v6XTFlYHDgEFAMwBMSrifuJ/T5l/BgyYVwXZxbt2sMOgl/L+lfeV7
	35OIFPNcXBMrxujb+f4LURGdLQzO1nnjDyVX+/C06C0SNVL86Tk9f+jvx8VFpIUUIu49E
X-Google-Smtp-Source: AGHT+IEmGQ8ezO3TtOdftc+mCIAJ6aLgEsQSmxgVxjQfrvzQONfiVHgyQHAP9sLiLBgvDFkwTF21oA==
X-Received: by 2002:a17:902:ce12:b0:274:5030:2906 with SMTP id d9443c01a7336-27450302a03mr76858975ad.46.1758540643820;
        Mon, 22 Sep 2025 04:30:43 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df852sm131071645ad.87.2025.09.22.04.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 04:30:43 -0700 (PDT)
Message-ID: <f31c2169-cd0e-438a-9e59-d6ebd8eaea6e@gmail.com>
Date: Mon, 22 Sep 2025 20:30:40 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] sphinx-build-wrapper: add support for skipping
 sphinx-build
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1758444913.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <cover.1758444913.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 11:13:24 +0200, Mauro Carvalho Chehab wrote:
> Hi Jon,
> 
> This patch adds support for not running sphinx-build at the wrapper
> tool. It was requested by Akira, who wanted to be able to ignore
> Sphinx errors during latex build and still try to build PDF.

Thank you for trying to figure out my intention.
However, you failed to see the point.

> 
> This patch is against docs/build-script and applies after the 3 patch
> series I sent yesterday:
> 
>     https://lore.kernel.org/linux-doc/cover.1758361087.git.mchehab+huawei@kernel.org/
> 
> 
> While Akira's original intention is to have pdfdocs target depend on
> latexdocs, IMO, this is overkill, as probably only Akira and a couple
> of other developers might want to have such behavior.

I think it is only you who don't want such behavior.

> 
> See, after all changes, the makefile rule for *all* doc build targets
> is simple:
> 
>         $(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
>         +$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
>                 --sphinxdirs="$(SPHINXDIRS)" $(RUSTDOC) \
>                 --builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
>                 --theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
> 
> After applying patch 1 from this series, it is really easy to replicate 
> "make -i" by writing a small script that does:
> 
> 	tools/docs/sphinx-pre-install --version-check	
> 	tools/docs/sphinx-build-wrapper latexdocs || echo "LaTeX build failed, but we'll try build PDF anyway"
> 	tools/docs/sphinx-build-wrapper -s pdfdocs
> 

Hello?

You are the one who is changing the way "make pdfdocs" behaves.
All I want is to restore the current behavior, without any need to
use such an ad-hoc script.

Sorry, but I think I have to NAK this.

Furthermore, your "cleanup" is obfuscating the very fact that "pdfdocs"
needs a successful "latexdocs" stage.

I believe Documentation/Makefile is the right place to describe it.

Good luck,
Akira


