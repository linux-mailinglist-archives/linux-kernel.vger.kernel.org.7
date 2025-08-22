Return-Path: <linux-kernel+bounces-781790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1653B316CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3365177889
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6FF2FAC05;
	Fri, 22 Aug 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN88d8QH"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387392FA0F1;
	Fri, 22 Aug 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864069; cv=none; b=bDtpXAMKMe+ZBJzMgiRJ231dOtigFwhjd0+V25mjLhOELHjkQqJOaCkew+SNOHWPV888mVusXMbKMloDmFza9hCQ1VLxPx6Px3aop1YXPfTUATKejZOf5nxyGETdcIs92SiS9msVcrsSFZs7hbPudHeQYRs1gKS0SsDroixylE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864069; c=relaxed/simple;
	bh=naHadQ0iB1veQ0rfWICX4iDJsn3kxNoq2oFHaw8duPk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FHa5kGdtu+wUhlRylIBufnBk2/582BAT6a1uNMDGCIAGOZ79je96UhJ6NQjGRnKyR1PeWHT9WXNP9f3FzGsk8sBl07Bjx2HA2zL8sBb++OkHWBSVCXYxlCAOizZch82SSWYg+CPu1I6skE3V3vJIt3c+Q8vBMxxPAYlWw4s9F0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN88d8QH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b477029ea5eso1882641a12.3;
        Fri, 22 Aug 2025 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755864067; x=1756468867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLQFhF1ONNLgCKYdQo78cgDkR2gJxQ+WqWy6eV+QuIE=;
        b=eN88d8QH9ZIF/NQrhyi0BeaXwVTkG9QADW/EegtijqrNKW+6j4fbcOWJHpeW7z8Qqx
         5UZhNgRjm6Q57vJFJ3Y2w8oDvlvHH9r7NW2lddfj5wPwEQbEnKz1QziUhbIIrZP/pb+Q
         0j+h0ouHxyyp+r0jwW105v0dHMLsllQR0bejN0gHA//5Uld8k3qV7qg/SAO9fuExZMpt
         EfOVp35g40pTT9BPUTDWsfSN1dE8RO7gIx7Aa0+RAFcKKAzY21D7hYhLIZtM5qGf2tut
         eZh/coBfIA7Fat9Es0pvFj4dfLMm1creTnvrIg8+WXOnr8jYAzQccGzurCPq65PT89YH
         uE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864067; x=1756468867;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLQFhF1ONNLgCKYdQo78cgDkR2gJxQ+WqWy6eV+QuIE=;
        b=DCv/D9RFz3Bk/6RByw5aBiihdWhx49SiwrU0ZNFh7SGDSVqYtZNn9c9oKfDWfstW+L
         jrO6UxCl9ES0Qq6QcjHsaXFXNNCJkmHcFvrRz5hCunBnsWUnYdNfnL+7AwwSbsyf0bBE
         0f/v4Wiq0EFXVkMYbXm+AiHsK/C2Wq6elNqOuO0m4LFlnLrbwgOeDLIjFCbCWSjR6se4
         g++IXn1dH39+ETihwYTCbMlJkEnzsGv4r+n274xkxW9cYoeZSg8rDtVw/tDngJFWMd4r
         4d+EzRgaEe0yoDTqusuHCFelsBFk7C00WvrAxQbPtfKag75loz/wW4Ze+Fe4zxqo3eN9
         1Huw==
X-Forwarded-Encrypted: i=1; AJvYcCXbRW8TdUPR0+swWbekUWkSO/g2afqLYrTXSNqxNA5R7VQog3VNbJaEy9IYO7DOBG+BguM5zhnvgig=@vger.kernel.org, AJvYcCXsdCQeXYVSwvKLBektWRanRUjnQjCURiPOGTycJPgyZGDkmgj6N8ugLx7Xr4DvvS1xvPIFZt/RHLMPS5hu@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDtgr1D2hdpeNfLosq2OI6e8Xn2vT+gLfzY3DR511VrI7DGTB
	nvrRplGrS0i4ZSjMzDz/eEgMQueLGlzC8by1YWY0GUSlSFFJhspSusbtsfbxYQ==
X-Gm-Gg: ASbGncueacxeHNjpFoYuuWAuN1vODxaZCKb0hLcl7Z2VXtAuXvjPiI344W014ZyvV2I
	AIvvgGzIYMMI22gn9hkoKMdk6hXY1xrFxfSfshlocXfKa6Bipg1Otsq2s3mFZ+bhm9t6KE+xOac
	bXcurYYCWaZX9LBkCOz5Foh3wP/WxXo0Npo9Lqtauc4/ywj/qVsdA4YKCWXxuI4/uRhlVq32MfS
	icVuqqmmCHlIFGC81xzgvyiMpto0GftB2hFiG1YY3qnVahIncExhwr+SrUmlvzIRgyswPN9ftKp
	5XPNz4sOY6T8kjBJbeodtTQ2+3c1hJIf7Zjedccdp2k3gcOPOlcH+C+qqUYRkIBPlyq6Tlwaq65
	0jNBRRW9f51ACCMpzGAgiPvIcG/I6eRMYV/PBTl3H4Wh6UcZa8W+zZ2Uq0oSi2atjwrjX
X-Google-Smtp-Source: AGHT+IG2cxE/O614qj74WPGmumNHxThHjVux3SPc7iSKKXoK3b6wko11tgWQEPsabtSCrJrDlJegPA==
X-Received: by 2002:a05:6a20:6a10:b0:243:78a:82aa with SMTP id adf61e73a8af0-24340d5e73dmr4328622637.50.1755864067207;
        Fri, 22 Aug 2025 05:01:07 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fba76bsm7023118a12.1.2025.08.22.05.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 05:01:06 -0700 (PDT)
Message-ID: <f5d4804c-9a51-443a-a73e-d9c043673cbc@gmail.com>
Date: Fri, 22 Aug 2025 21:01:03 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <08d16c2ad817910eb5606842f776d3f77d83282f.1755763127.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 07/14] docs: conf.py: extra cleanups and fixes
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <08d16c2ad817910eb5606842f776d3f77d83282f.1755763127.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mauro,

I see this has already been merged, but let me comment after the fact.

On Thu, 21 Aug 2025 10:16:43 +0200, Mauro Carvalho Chehab wrote:
> Makes it more adehent with modern Sphinx LaTeX build setup as
> defined at:
> 
> 	https://www.sphinx-doc.org/en/master/latex.html
> 
> There, it suggests:
> 
> 1) to add: 'printindex'
> 
>     “printindex” call, the last thing in the file. Override if you want to generate
>     the index differently, append some content after the index, or change the font.
>     As LaTeX uses two-column mode for the index it is often advisable to set this
>     key to r'\footnotesize\raggedright\printindex'.
> 
> This indeed solved a corner case on a distro where the index was not properly
> generated.

This looks good.

> 
> 2) to add at the main example:
>          \PassOptionsToPackage{svgnames}{xcolor}

OK.  So I guess Sphinx's latex builder is going to start using SVG color
naming in the near future.

> 
> 3) I got a corner case on one of the distros was using xindy to produce
>    indexes. This ended causing the build logic to incorretly try to use
>    T1 fontenc, which is not UTF-8 compatible.
> 
>    This patch adds:
> 
>         \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
> 
>    to cover such case. It should be noticed that, as the config doesn't
>    have \usepackage{xindy}, this will be used only if latexmk ends
>    using xindy.

But I can't see how this macro (executed by XeTeX engine) would have any
effect on xindy (command) invoked from latexmk.

Can you elaborate on your theory of how it works?
And which distro runs xindy?

Thanks,
Akira


