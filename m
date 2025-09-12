Return-Path: <linux-kernel+bounces-813685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D5B5496B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D55D1CC43C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979C2E0905;
	Fri, 12 Sep 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efqxVWK5"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E42E0B5D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672149; cv=none; b=qf1Fh8HU66ExBBtYkeOUVz2DfqHR6trW3wdK2tGQwEhYZsXJqxl+ghKJT9r/H+u9YX2oOcUY/d19DDN6WMGLIu5O78Ubfksa3KZwWF2Mi7uX5jN5EK+nOp2uxaj6/1K+uy7WRefJrqCCKGEZPjY4ZRe55BBG38MKNV2cu2x2Xp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672149; c=relaxed/simple;
	bh=DgARuMX8C0O9vD2kEMxsJ443swuM1qSfJ7gGYtB/ZDI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nFywT2cZ9TEeTM7LGmPoUjhnYVd3BKkVP/EH4oHOPhzOk/y9QOQx9ldEZYQbAYcgLcxPHO0S21hy+QhXt/FLotVMc66w0NUzFkzRcJuIBhXYasmhxfLZyFzQLpHQAcawz256jFDEvk0qHpZQgsi296Pj2IUaCvp3sQ62dz+mJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efqxVWK5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32dd1238843so1697822a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672148; x=1758276948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8NXrRzKlLIo7IaBcJ7TmPf9N4NNGYc7glWmcDTSRYnE=;
        b=efqxVWK5IZCYUif8/2oiuaWp8tQDSBiioh9/UuDY8MvjK0UeXWkXngk5YWvYidVn5F
         ZKHNsVF/E7vb/nE9CT0g0lrkm7d2OaElZqWGC4hzOMS9VdOUpKtjnsAYC0qCrtk3x4fA
         vUIzQhbA3ELiWRtwzc77gzWm7J1ZNKYhrWWYsclO1XtNABJm6ZdJZJZmGiuL8Yw5OxDH
         fCN40hGlEx7jjJ1GK8hSBtVmSmqg1htJPxvNcb1C7QAvfgWlYaFfS7pDTMuqPFuAtG3B
         agmeWWZVPS2UZSRCtMjjUnYqKU31O+bJpXfAd1Kv03rGUkA+2/Yc8eZe+hH57p46zx/n
         9xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672148; x=1758276948;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NXrRzKlLIo7IaBcJ7TmPf9N4NNGYc7glWmcDTSRYnE=;
        b=jNdcFmtzs2Bxs28RdeLXgib2r8uQOHE0gSwiU8Uf4TdvdBpDjdOFkvQfyTbwLuO1qd
         rcwMQpYUvDyyVnz6a++jzwN5aPKYDOCEV+vWgG0CPpMLhp4I5axw2BxkuMofeK2y4h3r
         ndDkCXMEUFzfH5LUd9yYH/A0zupLl0fysAleVtOhJZXT8Dp+FwH3HTpRYZiZiRG9RoDL
         zl4ks90z6x/X5BTs4jAGEwUWFcVZ8cFmuJtKEzxGdwqGpGdDhwGiLzbC+cGqEA3e7T8m
         yjxezdQAWIskCP49XQoCNt2n0EeAMsVRVr8XvXGE+btXl5L6h2xdQvhTm8GRDcRKwM80
         SVGg==
X-Forwarded-Encrypted: i=1; AJvYcCWWQT+DxzjKRwQyRbqqCYq5WySxQyf0AiZCwXF9xrmGCp7Jpn4yhgGG5gHN7ns9rtvyzxC5ZOhMHk9o3pY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9MJkpdrMCwNuhgBuQUPQz5kIU34Xkz79wxtWBtE+LF1iJTD1A
	ws2zKeY1Z0y/jnLSLce/NTCnX9MLCu/J/zkkMkhrW90wSd05wvlCP0Lb
X-Gm-Gg: ASbGnctoNbuU1pnYiuteenXN52khv+CIWn1+pBy4YTYYNrkL1r/HYv98W+hWQ5gDSUT
	a9VBcB53rV8MNPjlfnCOsFpIN3Z5rbrTjny7wq3kB/Ws2zk1pyKqfZt5tkxEXUfE++PhdV0tFqS
	Dj6pzrA4Ru5dLkqBBYvtoNCoTLmT+c9/S75XG4DwmW60JfjthIQxHlqmHyMbLEGDqfN8fOxvMDX
	sEURS23DEjLda55gvjsMU7M4k7KHlV9awvVzAnLdEhgT2ifEptpugpM5GRTE4IQuYzQrDCVDYYI
	OLPYcIvLE9cx8CzDzQob1aGhOxLq3nCw/5PkxNV1Hua3pCygVOwseQh6VR+jRJf7DwljZh2+WND
	ns7XwcdRAXnIhfxvyNd9bnCS3moulWqPBQEVgnzH2klOcI32ctdmDbwFF0HRvbnfw2SenPHlnhZ
	eSS7s=
X-Google-Smtp-Source: AGHT+IEP4elHK2bgf/EvKfPLSn4gKjTz8zosrFitg1+GsXCX0OcrjCDjoP/DIGJVbK6lII9nIYLyUg==
X-Received: by 2002:a17:90b:1b12:b0:32b:5d8b:ea43 with SMTP id 98e67ed59e1d1-32de4e7ba28mr2768770a91.6.1757672147574;
        Fri, 12 Sep 2025 03:15:47 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa9234sm4393676a12.54.2025.09.12.03.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 03:15:47 -0700 (PDT)
Message-ID: <28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
Date: Fri, 12 Sep 2025 19:15:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, jani.nikula@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, tmgross@umich.edu,
 Akira Yokosawa <akiyks@gmail.com>
References: <20250910153334.0b3e1440@foz.lan>
Content-Language: en-US
In-Reply-To: <20250910153334.0b3e1440@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[-CC: rust people and list]

OK, Looks like I have to bite.

On Wed, 10 Sep 2025 15:33:34 +0200, Mauro Carvalho Chehab wrote:
[...]

> The current approach of using LaTeX for PDF is dirty:
> 
> - Sphinx can't produce a LaTeX file from the Kernel trees without
>   hundreds of warnings;
> - latexmk hides some of them, but even it just one warning is reported,
>   the return status is not zero.

This sounds interesting to me.
As far I remember, I have never seen such strange results of latexmk
under build envs where all the necessary packages are properly installed.

I think what you are trying here is to paper over whatever bug in latexmk/
xelatex by always ignoring their exit status.  Am I guessing right?

If that is the case, I'd rather report such an issue at upstream
lagtexmk/xelatex.

Can you please provide a reproducer of such an issue?

Or you saw something while you were tackling issues you claimed in the
cover letter [1] of "Fix PDF doc builds on major distros" series?

[1]: https://lore.kernel.org/cover.1755763127.git.mchehab+huawei@kernel.org/

Thanks,
Akira

