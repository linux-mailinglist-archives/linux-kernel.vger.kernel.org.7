Return-Path: <linux-kernel+bounces-720849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF639AFC129
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190024A65D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838C22F386;
	Tue,  8 Jul 2025 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcJIwqGP"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE642045B5;
	Tue,  8 Jul 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944197; cv=none; b=niFmfm2Wh5nk6k5SKnGNcS+RRbd9qX5JQX6T76bAQpzhiWHL2I7/XOdRBea74c4EtblztAjPRHGN+c0Zy3lqzSLmN3P0m9AGiVo2Jgya/NDj2GI8bsnB3kup5FN0RUxJldgbQmmSGbErKZayajrnI44CqOMY93Oa3ZOCy0jx6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944197; c=relaxed/simple;
	bh=dex8jPJr2jeHC34OS7609JCjzkSuaDHu4sLqeFIXjws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUc0DDwThGR5BaePfl+qbO9CP4ThNH8xuD25p9eJhlb94UIbff9Hy4UykBbGLYQAdoPgEW4X7tFy5xYllH0Coo6G+fq/k5bJ3r4xHKGhhBCO81K530ojnJGYKYgvgRz3w/Qm6QdCSnlExShxaS7mdmWbywLgysWQfL5N5Cv3Uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcJIwqGP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748d982e97cso3495897b3a.1;
        Mon, 07 Jul 2025 20:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751944196; x=1752548996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZI9cZXBhYZ+74XL3B4bLHJL6+tXQn/AtLSswzp7G3c=;
        b=AcJIwqGPG7b1D2R0zH/k+/PW3hgYO24TG9rd+mgFBpASDcpM+3teW4EnSA7wRKXskj
         8GS7lw+7l3m65bLDaF+eUd/oMhg/6pAhsfWP4U4WezJ0hpaCvV2E7P24B4IWg8FsXA8S
         ntxvaQ8OEz2RappXtFCEn632j6DKhMNj5wfnojBxhpjPpO0w9Oul56g+ruwrd2D/ZPsV
         mcQxvRfMeDdvgsfDMUfNM6mkFBzvkP7Jh8Jjuos6II2BpcnpdoyJ17loigXq+ESkT81o
         pEyXmWyDzfcVq91wwsyPszLJpfZgGpqbpswU84vy+x52pdgdhcqaPf5KG9oXQBYT3SOs
         mLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751944196; x=1752548996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZI9cZXBhYZ+74XL3B4bLHJL6+tXQn/AtLSswzp7G3c=;
        b=W7vg9I/gOxof2yVwNMiAyyjI/5DI1mrjfLZQx+3W34vArOwLB6+AzkZhcYsSZ3Ss7y
         HkaRIb74FvFWuNCOHMZP2J6aHmQ9hSHIYnNN4WZ4ir8UTgVU0W1L1iJL7K/gnDBCT66S
         Xjt8icWM3HcdS7G80N1+iwoDMzecHh+v7UHfMJmYxMXDoovImYiOcTE3QA6kGnuWmr2u
         e2JwPhbY7Uw1d77hqRL/RH5/O9/srnkP4xK7CmY0fThD4K3rVuYZJPqsjcxL2ztKuD2+
         oEPuShMhIYg4W412Ikvnh6rBgoyJ+ha1Ha7/Vg124peJ96vsqKnhJCN8XZy7ry+EmysQ
         KWqA==
X-Forwarded-Encrypted: i=1; AJvYcCXR53Qksm37BjbVrwioruJSTY20nhyeKiQO5ymx63QO9IED87TfyOW9AFOi2jRqIqXiW1UbLlFIocg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxchkSD6YYMi751vzNZBJArlFL9al/n60oXevgGPfSnHR6501Ps
	fNtk/C8YERt3IjINCyfrVDSa7jliKba1NMRojLNBkbQ88xPV1q+Q9gPk8KKMHg==
X-Gm-Gg: ASbGncvh/5EvjtbCXTmQzUETgzrnWb2Cqd60kx710iuMsS6V1fatgf8RVVg6pWTw3H1
	MKyGtIroSMAos83H1ByhLGHMYNeWGWcMrVr/mHp0aGLkb6BzKXFTA5a7iUtIrTO6u/Oqa0mRd7E
	6Qzgmir0OpjYjExQcUpofVjaoGvvtJjuQzICYxBEsZmX4JNqmNVIe5JEvImp0hTKx5wepUtZspZ
	0vWzpenf19Eb743JT2E3MCZ2DRRiAlO/kofAk1Fvegs973Fzw09bxUm3ojGqbzvhl/HZfEmtoQc
	p7YjM+cmqmdjn5S4Qg6cLCfUCaNDmKkTq558s6tzO8Z5DFHDX7f4dg3z7iuYplxsyPyPkZfMPSq
	GIkwPUfFv9EZlTSpHjx6wlS0PEUUIyRR/
X-Google-Smtp-Source: AGHT+IF7e6WOFHtX8jp0vmafYCygArdhlSPOuGK2hxmppXbb4kli87dnDcBqHPodr23l/WEHJnUqRw==
X-Received: by 2002:a05:6a00:3490:b0:74b:f639:33a6 with SMTP id d2e1a72fcca58-74ce658a5e6mr18008520b3a.2.1751944195503;
        Mon, 07 Jul 2025 20:09:55 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc32fsm10409145b3a.52.2025.07.07.20.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 20:09:55 -0700 (PDT)
Message-ID: <d37eab74-a034-4be6-b92b-e0da60a99477@gmail.com>
Date: Tue, 8 Jul 2025 12:09:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Translate sphinx-pre-install to Python
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Sai Vishnu M <saivishnu725@gmail.com>,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1751318230.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <cover.1751318230.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

On Mon, 30 Jun 2025 23:34:48 +0200, Mauro Carvalho Chehab wrote:
[...]

> The test script also ran the install procedure for system,
> venv and native Sphinx install.

Which install procedure did you test?  The short one with the "--no-pdf"
option?

I am asking because installing the full list of packages in podman run
of opensuse/leap:15.6 didn't complete successfully for me.

And by the look of things, you stopped at installation, because you are
well aware of all the issues in running "make htmldocs" and its friends
after the install.

I assume you (or somebody else) are going to update the script once this
series is applied to make the suggested lists of packages be useful for
newcomers.

> The tests were done with those containers, obtained from
> lxc download templates or via podman run:
[...]

> It also properly detected RHEL 8 string:
> 
> Detected OS                : Red Hat Enterprise Linux release 8.10 (Ootpa).
> Installing venv            : WARNING: No such file or directory: 'sphinx-build'
> Installing package_install : WARNING: No such file or directory: 'sphinx-build'
> 
> But, at this particular docker container, no repositories had
> python3-sphinx nor python3-virtualenv, but I suspect that this
> is a problem on this particular image, as I'm almost sure we
> tested RHEL 8 in the past, so, I have hopes that this could
> still work with real RHEL, if it has Python >= 3.7.

FWIW, almalinux 8 provides python3-sphinx in the "PowerTools" repo.
It installs Sphinx 1.7.6 on top of python 3.6.8.
python3-virtualenv is in the "AppStream" repo. It also comes with
python 3.6.8.

> 
> Yet, our goal is to support the latest LTS version, so
> RHEL 8 is out of scope.

Yes, I think it is reasonable to ignore RHEL 8 and its clones.

For the record, here is a WIP scorecard of suggested procedure by
actually running "make htmldocs" and its friends after installing distro
packages (if it succeeds):

------------------------------------------------------------------------
* debian:12

htmldocs:  OK
latexdocs: NG

Debian and its derivative prohibit convert(1) (of ImageMagick) from
generating PDF by their default policy, so you'll get a bunch of:

[while building userspace-api.tex]

WARNING: Error #1 when calling: /usr/bin/convert /<srcdir>/Documentation/userspace-api/media/typical_media_device.svg /<srcdir>/Documentation/output/userspace-api/latex/typical_media_device.pdf
WARNING: Warning msg from convert(1): convert: attempt to perform an operation not allowed by the security policy `PDF' @ error/constitute.c/IsCoderAuthorized/426.

, and if you ignore them and try to build PDF, you'll get:

[while building userspace-api.pdf]

! Dimension too large.
\spx@boxes@fcolorbox ...dimexpr \ht \spx@tempboxa 
                                                  +\spx@boxes@border@top +\s...
l.54887 \end{sphinxVerbatim}
                            
? 
! Emergency stop.
\spx@boxes@fcolorbox ...dimexpr \ht \spx@tempboxa 
                                                  +\spx@boxes@border@top +\s...
l.54887 \end{sphinxVerbatim}

* fedora:latest (42)

htmldocs:  NG

Container images of fedora has stopped having "which" as a command.
You need to install it manually.  After installing "which": OK

pdfdocs:  OK

* opensuse/leap:15.6

htmldocs:  NG
After installing "which": OK

latexdocs: NG
Can't complete "zypper install" inside a podman container run using the
full package list ???
------------------------------------------------------------------------

Having look at these poor results, I don't see any reason to continue
testing further.

Regards,
Akira



