Return-Path: <linux-kernel+bounces-821792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6EEB82421
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0029E3279E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE5311C3C;
	Wed, 17 Sep 2025 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+0Iz+j5"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D531158F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151371; cv=none; b=jCeQTBqTsQcEtMX/mL2/GTN1GA3V2OeDPQdtL6kysyGcZfUBmlo4uDgIWZzbSYy8Vp/8Tscsl34NtwaYLz+QVeX2HONdJ7YNsuQpsoKOLRl3DbAz4GExikClWEf4AvOgrRX7ehBds98qvlOw0NiUEEbuKXpDpX1/DRqjKGfNjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151371; c=relaxed/simple;
	bh=y4sVjPFCOLu/nhY4gHPbP0uzuUQZ2/XUuRZ369WfgMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTYz+r8hWYmoT6FRv/2JiutI6SWInFVROL1vZgYM51mWk+I4t0Zay830QaIyhn0lcpniUjkdA2PehjJZXFGI+Hsqanh0Efqusy4EINr4GDBb60WzpfA6ulrE55rtQQXWr71zvQ7ZU5cwU3MtJohUJsIyOwhXCjQ74BwPNL9s5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+0Iz+j5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77b0a93e067so373181b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758151369; x=1758756169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pyh6L/CDh58NqcgV+cNZzpnbcjZLCCpL11ClZ6n2P6k=;
        b=M+0Iz+j58aFbIl2GJFZgqoUQlqGNFfovfPEFBaRvV15qOReDf44/1rtYyNKODega5d
         Cg8J2FRogF2XndctA/XYZJHGVpPuakVhnCKUQAwFF6p/oT1gpUqYVDxYukU4Ayrk+KWb
         impfMhUrEKSMQG7L2FAyCyNxjroOKwB7qhEShihsTCBnbt9v+/OH+YInlClkrY8JO989
         MvNRFii7780O9pyCxc5JqugXWEi0ZpZ63YUcD6teHhSmrzVIQa2RlVYa/93QhwUR9KJC
         1Fe1rpXjD/LkojUaksfAgrX24XvdCkdVlD/8F74vGNn0YFHjOBkU0CBa6aqG+1h92jOb
         dxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758151369; x=1758756169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyh6L/CDh58NqcgV+cNZzpnbcjZLCCpL11ClZ6n2P6k=;
        b=k3JOQcmrDUTe5jJhpvlnphJm2NzYFxA5HzCYlM5dgS0TR2N2a2fHFYvWnnpS0CveW7
         QIaYboOoVIFT2E3X4nQm+iJxb+gzKGF7wZq0ZVeDXmFYfO67ekoD+EuQ+IlNuVIherqy
         tiRTGEkYxH+gw3iSFQMDYwh7HDZpKfWGfsb473nXDPJHkbGGEqqyhqcVmJP3BpGH3uZs
         CKxGYD+GkWNVy0pz3nSbWCcXekY4CXRdYnrj5L4cQID/90BZ/L8jSR04XVNkpxszi9dE
         WkstzNZjFrJjDMsqFd3a89QcR2BXkaEw+ZtikSm2QMVmyXEBkRaqV+NV9/TqChQvS6ix
         70bw==
X-Forwarded-Encrypted: i=1; AJvYcCX7OchRFHoUvAfSuasaZafOZpO/jPlDkyyPPrlZSDgmrWdBvnxjL0BFIxmja3V7O9vN8FZ/NH2Ky51iqvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYACZTpOSzli3H+GBQHs/n4MjnDSYgoCY1e+JqDcj4JMa2QOD
	e+EKtOFrgwJYbiCFFySTdbjqGd59zmLFL+4OrMsG0PWr0u9AHhmIwECdwuNOzQ==
X-Gm-Gg: ASbGncusB81VgKyzIkYfpgUUzan4qEpEofWLErhe7I7FRS3iAX+Z88ufGee0lNeEGIS
	T97dwkeVTVdTOqWn1QA38QAz8SyotxXa9Q/+PbCKc99FGk2kw4ieJbtuhGi4FO8WJ3Lat88qqb/
	uKd+MCnhqa8Vo2IAnrZp5nQG4B6drWvLTARXhjaWU1uXndypF/BRk/jlw9fgb/nbIzFlpuQ2igg
	AgEj8TkgA5zvsU0cYq1J26L1bVoy1zg5d4iFwH+gr4p5hYzIA7y8YWnh3Qs3eHt2hjNnhFanGqP
	aoOkO/V8uvj0hJt3hoASQafsKZ1XU21HLRs+3M6XnJJTheQ9oy0DW1bNEQQ2lN/Wvz6O/197RFR
	RFdqTsUORUT2DeU4+igJP/H5lbIAg+MkZoVoFkElEGizzFVVt3g2yCcTxYQhQo7xeIntxGm1Ub4
	q1Npfh41vWflA=
X-Google-Smtp-Source: AGHT+IG8Uqfk2NQ6FznXcxC01buxFU9txTa1Zwn5RgXX6drqjMZ52ntQwpjHiL5uFzK1Huy5kx1VOQ==
X-Received: by 2002:a05:6a00:2e19:b0:772:5b74:c270 with SMTP id d2e1a72fcca58-77bf8e6d3f3mr3986596b3a.20.1758151368989;
        Wed, 17 Sep 2025 16:22:48 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7c3bbsm493940b3a.7.2025.09.17.16.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 16:22:48 -0700 (PDT)
Message-ID: <eaab7ba4-f23c-4c33-b9d1-faae73c136a4@gmail.com>
Date: Thu, 18 Sep 2025 08:22:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/21] scripts: check-variable-fonts.sh: convert to
 Python
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <8a77212d5459eac2a98db442691930425a2cbefd.1758018030.git.mchehab+huawei@kernel.org>
 <52932ede-eb04-4275-a051-952bc2859cf6@gmail.com>
 <20250917104818.62862b48@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250917104818.62862b48@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 17 Sep 2025 10:48:18 +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 17 Sep 2025 10:09:05 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Tue, 16 Sep 2025 12:22:40 +0200, Mauro Carvalho Chehab wrote:
>>> This script handle errors when trying to build translations
>>> with make pdfdocs.
>>>
>>> As part of our cleanup work to remove hacks from docs Makefile,
>>> convert this to python, preparing it to be part of a library
>>> to be called by sphinx-build-wrapper.
>>>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>
>> I could apply up to 05/21 of v6 and did some quick tests under
>> Fedora (where Noto CJK VF fonts are installed).
>>
>> At 3/21, "./scripts/check-variable-fonts.sh" doesn't say a word.
>>
>> At 4/21, "./scripts/check-variable-fonts.py" complains:
> 
> I got a little bit confused with the above. I guess you picked the
> wrong patch numbers, but yeah, there is a bisect issue, caused by
> the part reorder I did moving this change to happen before adding
> the script. Basically, I updated docs Makefile the wrong way.
> 
> Thanks for pointing it!
> 
> For v7 I'll ensure that all patches will properly print the suggestions
> from the script.
> 
>> =============================================================================
>> XeTeX is confused by "variable font" files listed below:
>>     /usr/share/fonts/google-noto-sans-cjk-vf-fonts/NotoSansCJK-VF.ttc
>>     /usr/share/fonts/google-noto-sans-mono-cjk-vf-fonts/NotoSansMonoCJK-VF.ttc
>>     /usr/share/fonts/google-noto-serif-cjk-vf-fonts/NotoSerifCJK-VF.ttc
>>
>> For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
>> Or, CJK pages can be skipped by uninstalling texlive-xecjk.
>>
>> For more info on denylisting, other options, and variable font, see header
>> comments of scripts/check-variable-fonts.py.
>> =============================================================================
>>
>> Of course, I have followed the suggestions in the header comments.
> 
> I didn't try to follow the suggestions to solve the issue on Fedora yet.
> It is on my todo list to test it.
> 
> The new script has an exact copy of the instructions of the previous one.
> 
> So, up to patch 09/21 from this series, there won't be any change at
> doc build, except for the script conversion and some code cleanups
> and reordering.
> 
> Patch 09/21 moves the env logic of FONTS_CONF_DENY_VF to the wrapper.
> So, in thesis, fixing it before-after the series shouldn't have any
> impact (I didn't test yet. Will do on my next respin). Btw, we should
> probably document it at make help.
> 
> If the instructions from the header is wrong, we need to update it
> on a separate patch series.
> 

I have tested v7.

With v7 fully applied, it is now possible to build translations.pdf on
Fedora.  Nice!

HOWEVER, running

    ./tools/docs/check-variable-fonts.py

still complains.  I'm not sure but there might be some minor issue (typo?)
in the translation from .sh into .py ???

So I have to keep the NAK on v7's 7/24 ("scripts: check-variable-fonts.sh:
convert to Python") for the moment.

Please run the script under a terminal session and see what happens ...

Regards,
Akira


