Return-Path: <linux-kernel+bounces-830020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A3B98767
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A3057A4AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27700266B6B;
	Wed, 24 Sep 2025 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFFIwC8S"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53652264C6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697445; cv=none; b=l26qidQ0i0kZc81q32FwBCpUnaqpQm/oiyFf4gCjbxzZhRAr0B8likMH+EexLsLhtv5MVCWPQ3gQUofVLt9cvz64pzSem9bD1jbNhlk+Hl8uj1XbOlBqyPZYaR/RkPK8TvOK4ghwneB/L7qqfJLTbIiANg6jVVOGPKjzIig8Vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697445; c=relaxed/simple;
	bh=vHInUFA/21jXeXYB0pBvWcx8+QtN1a9JKfe+GJENm5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGnGUFqSHeqEh/umCNIGYAnLSfWFk2XMJFkwFllPKeFbrll6Cc+Mme0iGZzCzOxXzB727qycz5kOQFOv5mRd1bbdCFJaMf7WeEg9c0e1zhhQjN4hSDSR0S8mu2NcljZ7QWc8O0mccQrNzeZiQQXtZyHmJ/ZZ9e0rWnmM5/Pu4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFFIwC8S; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f207d0891so3099942b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758697443; x=1759302243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80/y7kJeYyFtHNuChSDuRM+MtquT8UzkqNHwK0gZjcc=;
        b=MFFIwC8SxpopQl4XqtF8kAkmWSX25N/bznjW/hKUn88/VasFzKNDuavf3QCVsJsAmU
         jtmrGhNGclHzQMlX2zEcwFgaCak9T5GnALrLm3+wjXvDiHc0wH1XXGZjKQCDyc4Q+Dq3
         fY9GK3CY6fRzeYVjbJ6/AUy/341kqVWqhQM+WXfjSuP544GlYzSkW9z3vRI1QqS2YmeA
         OeBdSrY93W9ZCmJ3ltDChFisTSnYy/17NLO8Qfz5y9CRrPz8D+P3C8U0OyiiM9X56IKj
         Ks69VwpJpgVpOd4V9IBMm+LIC9vtNdxf+rhWMJ1A2HD9d8CDc/jLbQ3q4K6knDdFsIt1
         SpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758697443; x=1759302243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80/y7kJeYyFtHNuChSDuRM+MtquT8UzkqNHwK0gZjcc=;
        b=XnVteHgatW/JdZs+ITXywpY4QNGRaC4qxUoZv9ENfQpaZQJwlTqCXJocP/9FtiU8bJ
         xwyGMIRfIzDQPK1D4aYS4h9IMJx37FX7N4rx2QmHQFbWZWC0agYpx02yzrOYrJXMbHJJ
         28Omr0K1mgVh3DOgmeC1VNlQgpJSTGEOgnONe72t59r+v6KbrpvAWvObFDjfA0KNQajB
         69hpPr6mApIP5AaqKDoiJr9DPkFqYkrLutq6z5GhwkZNeDKJXS/IewT4b5sdonTOxA40
         bRATkvcQi4mumuzyD6DxYtdP6Vmny/J7Gq4qZ1H3PVSA3qi5csoivj0s+3WJuIoEr/66
         qtWg==
X-Gm-Message-State: AOJu0YwJ8ovZ16hnODcFEo89t2qMT+W1waUCpcnMqKtIUZThMnRsmMy/
	48Egc7BoS30HtE+NxaWHQdwsXx2s5XNQTyKaB27Iic52JQLTqKEfto9v
X-Gm-Gg: ASbGncvvypn4h8+nFFnoN+VgNhVKsYX+SbnX8coXtyQYxBzjeew/eOQcuA+T0rPEwTR
	90835hNAATrbCBKw35gJgtMX7vcBh070tgRTfmJCO1k39UjVhY1GwMKlx538YG62+Vv4MJyP8D6
	T9ywc7ou20Bvfih4Oq87635/Z0TfLCCt8UHtA/+GDf+6GIlfEdgA7ZrAE1TRn3btsFGbld4GcmJ
	9hOcnHohdPrxfzPN3srdqycpgD7FJzWJd/mC//hQxLRhckagK1oMDUR1E3xCF0TpFjBRoC2RXGL
	kmCR7G4eLw9uNDKLmRWcvi3OC+ZvU+d3AKO8kxemm6AKlhG9SOrJ/0O8JhawOen6vAcdRGJ8I0r
	kmokRFGBUM2uE3ET+R3cLmusiVEXEgd0Tug1VaY9PXkFJqau6Mr9l+ni3VGUgc8Io8v9u
X-Google-Smtp-Source: AGHT+IE7b4+4P900FBrAt2skoZSZdAzj79wCaQaJINFRZmRqunjKNgCONWtya/Kc9Ic5+xoc1SOr0g==
X-Received: by 2002:a05:6a00:1990:b0:77f:1a7e:7bc0 with SMTP id d2e1a72fcca58-77f53acfa71mr6433020b3a.31.1758697442807;
        Wed, 24 Sep 2025 00:04:02 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2f02c15bsm9071133b3a.95.2025.09.24.00.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:04:02 -0700 (PDT)
Message-ID: <e76e4f31-dc95-4d79-a922-7f7d1b68417f@gmail.com>
Date: Wed, 24 Sep 2025 16:03:59 +0900
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
 <f31c2169-cd0e-438a-9e59-d6ebd8eaea6e@gmail.com>
 <20250922142330.7a654919@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250922142330.7a654919@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 14:23:30 +0200, Mauro Carvalho Chehab wrote:
> Em Mon, 22 Sep 2025 20:30:40 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Sun, 21 Sep 2025 11:13:24 +0200, Mauro Carvalho Chehab wrote:
>>> Hi Jon,
>>>
>>> This patch adds support for not running sphinx-build at the wrapper
>>> tool. It was requested by Akira, who wanted to be able to ignore
>>> Sphinx errors during latex build and still try to build PDF.  
>>
>> Thank you for trying to figure out my intention.
>> However, you failed to see the point.
>>
>>>
>>> This patch is against docs/build-script and applies after the 3 patch
>>> series I sent yesterday:
>>>
>>>     https://lore.kernel.org/linux-doc/cover.1758361087.git.mchehab+huawei@kernel.org/
>>>
>>>
>>> While Akira's original intention is to have pdfdocs target depend on
>>> latexdocs, IMO, this is overkill, as probably only Akira and a couple
>>> of other developers might want to have such behavior.  
>>
>> I think it is only you who don't want such behavior.
> 
> Whom else wants to use "make -i" to skip failed latexdocs build and
> still do pdf builds? For what reason?

Hmm, looks like you were suffered from context mismatch.

My message you tried to understand (archived at:

    https://lore.kernel.org/5031e0c4-f17e-41b8-8955-959989e797f2@gmail.com/

) started this way:

    Hi, (just got v8, but sending anyway ...),

, and the message assumed the "make pdfdocs" behavior of v7.

At the time, I thought it was what you had intended and it looked as though
you wanted latexmk/xelatex to continue running as much as possible ignoring
any intermediate errors.

You have since fixed the missed exception handling at the latexdocs phase,
but your rapid respins of this series simply overwhelmed me and I have
failed to see "make pdfdocs" now gives up at latexdocs error.

My intention of mentioning GNU Make's options of -i, -k, etc. in the message
was to show you that the make--sub-make scheme is so flexible and it can
even emulate the buggy behavior of then sphinx-build-wrapper.

In normal cases, I won't use any of those options.
But as a human developer, I sometimes use them when I observe build errors
somewhere in "make pdfdocs".

> 
>>> See, after all changes, the makefile rule for *all* doc build targets
>>> is simple:
>>>
>>>         $(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
>>>         +$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
>>>                 --sphinxdirs="$(SPHINXDIRS)" $(RUSTDOC) \
>>>                 --builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
>>>                 --theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
>>>
>>> After applying patch 1 from this series, it is really easy to replicate 
>>> "make -i" by writing a small script that does:
>>>
>>> 	tools/docs/sphinx-pre-install --version-check	
>>> 	tools/docs/sphinx-build-wrapper latexdocs || echo "LaTeX build failed, but we'll try build PDF anyway"
>>> 	tools/docs/sphinx-build-wrapper -s pdfdocs
>>>   
>>
>> Hello?
>>
>> You are the one who is changing the way "make pdfdocs" behaves.
> 
> It doesn't change. if latex is not built, it won't try to build
> PDF files, just like before.

Didn't you mean "if latexdocs is not build"?
Yes, I now see this is the current behavior.

> 
> See, for almost all targets, docs build is a two-step procedure. That
> includes htmldocs as well, as it requires a post-build step to copy
> css and static files. Right now, the logic is hidden inside complex
> make macros.
> 
> The new logic place the target-dependent extra steps on separate functions
> which are now properly documented, executing them only if the first
> step works.
> 
> With the "-s" parameter, one can skip the first step, running only
> the second one.
> 
>> All I want is to restore the current behavior, without any need to
>> use such an ad-hoc script.
> 
> Huh?
> 
> You said you want to be able to do just the reverse: to ignore
> failures at latex build ("make -i").

No, as I said above, I don't want it in most cases.
But in rare occasions, I might want it.  That depends on the situation
at hand.

>                                       If you want to have exactly
> the same behavior, you don't need anything.
> 
>> Sorry, but I think I have to NAK this.
>>
>> Furthermore, your "cleanup" is obfuscating the very fact that "pdfdocs"
>> needs a successful "latexdocs" stage.
>>
>> I believe Documentation/Makefile is the right place to describe it.
> 
> If you want to propose such change, be my guest. As I said, *I* won't propose
> it, as IMO it is a bad idea, but if you want, feel free to submit a patch 
> after this one similar to:
> 
> 	-htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
> 	+htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs linkcheckdocs:
> 	+
> 	+pdfdocs: latexdocs
> 	+        +$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ -s \
> 	+                --sphinxdirs="$(SPHINXDIRS)" \
> 	+                --builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
> 	+                --paper=$(PAPER)
> 
> and let's discuss its pros/cons in separate.

OK. This looks like the way forward to me.

I'll prepare a patch (set) and submit it after v6.18-rc1.

In the meantime, I think we might be better off if we could root-cause
the "latexmk bug" you repeatedly claimed you had observed, without providing
any steps to reproduce.

Let me continue in another thread.
It would be far more interesting for me to (try to) figure out what you
had observed.

Thanks,
Akira


