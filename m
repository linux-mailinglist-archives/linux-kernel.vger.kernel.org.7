Return-Path: <linux-kernel+bounces-870768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B760CC0BA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B327C4E907F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6A2C028C;
	Mon, 27 Oct 2025 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goAbfdta"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6A2874ED
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530368; cv=none; b=SbN6TIVw29hn/xpxmXmoTaoYYLVUJkmUqRep8nJAjqkThkr8+TIduWJtAq6CoWFVRxFzqMqom218utwDcrDTS1c2WSB9o7DYXqaxfWwOCDz2Iv/W206WCkLagCTpZo5fbU8VynivqfMy7GtsbibMkRpLs2B65150LuRSldmt8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530368; c=relaxed/simple;
	bh=HpEPiCN5qYwVqp7BzMb/oBMUXCw/sD9fYm6WiG+Dyq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmyJLAyyq0188hUuyW5Umv1RYDGx/k3/2YWEO8m4mHCP676fFaqIBjTyzV85JJB84W6uJfFkI+k+65ATIUMP1TQnwvjdAz140RkoJao6uUzB2hKT48iZJ0LDZnrrG+r1b0e5hIaGQqL5GtuVJUSeW1h60wPwBYTmWA7+E0BHtfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goAbfdta; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29490944023so23290465ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761530366; x=1762135166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKkagDqvy8vzjbyvf1eBUmABe3ymGzGAkczrB89YTZA=;
        b=goAbfdta1dBYY3EAzWfDurQ1mV5paBdMi1QT8ar6d88M+/eduYtAAU2UrnKgihrkjO
         7BHELWqm1RweW/IkdxbmwJYL30qQNGvLjHHEODqFPRsa7Z9yl7r2/dwuyJe9MjxIIVpA
         KAK5UiMgstJgvC3xpaIpsvfHmIpkyZLWtnaI4RDddKgQ0xBR3fcA2FnK+BvR0hKWk3Ow
         4/qkUCoI9cxZkxKKe04RcE+Zbn+iRvrXkH2Asr+bdoPQOWk582bddbbM4cH8jeybS2An
         V86MhTpU/JPPh/Zu8A0EB7MMgzLaVeJ67/IX9iIFr0PfB00K+I5gplkN2HIXoORfOjIE
         tXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530366; x=1762135166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKkagDqvy8vzjbyvf1eBUmABe3ymGzGAkczrB89YTZA=;
        b=puwzmFI8L5GtU1pE7p0tdGXtqn/5u+cVzQteTzjxc+g0KteXSZeHbyCyx8P8eP8y1X
         b2FC9rk4Khpl8yMyaHZySDs01k3G3q/ptqnnJ29r3qCxYkTtOefxCvQI6kLntdy7ze4j
         Bpxq8YuVZ4pqkQ/7wGuBZ7yKRd8ohX6x2TLRSFWhJWxTeey/1CjkTLReXBDreuG+Va5q
         pGISxghLQ0N/F4R/hDobN9l+AkmLkpwGtYxl6lcE9K8d7R3ZbqIQOhYHATdqlFGJ9aF3
         vhk+OBJOdo6f5cI8r96y0gOTeZ5z/vV1jl4EYBDE+rCHNoXLb+8WPsvM/l3252gguF8B
         WBmw==
X-Forwarded-Encrypted: i=1; AJvYcCXhMkb/31fsQyoK3yRzGa9ma7olqejwE+WcgT3vcHScxpuVM8T+xQqmTq41C+cjwcvvNHxvdGZaMvvrBY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwToFdF2FcUFypTB50ehzGVf3yQGA6wg6WYitpz/TZ4rUvc1nuP
	NmKMkjGFeZhaw8iRMjCulFb3CVbqL+/WJHvlotH+zSxlLSEPH91Ar5Hj
X-Gm-Gg: ASbGncuJVMBflDKKI7NYh33Zk+b+H0fcb7Vrgg9KqOeSDLMXMUs+Zg51PN7XC6higng
	8QvpIz5wqa2sFjVFDGhR3ft2G8owvfzKp3rbnIFJFfZRQCL9pU44rPBm5uHRR6PqAbuAOFSAPw1
	T7HnMgqQesNSJkXUWieIegR+yUEwciWlkjaxhFZoJ743G2vyPG5RFN/DEJtWLjNQ+AGBeBlG4lh
	LuETOUFnJKnIGsBDwySJoCS6zeOb/LNfZSOax4DfSSjQWumIKJvrssN8L45UXZFFOZrWOiy6djt
	VAWgo7hhFk+wFw4weemGqLENCVbGQ3bmy3wpD64AqleIksVtt3GVUyk6pI4gBpLzdnrMEiNPVQ6
	EtR6aPq7/yZncT/hRTHmQmIT9Wd3Q69IrAat7z/CDBT+MGa3UitmotNb/hhat2ZX4Ug7m8u2UJX
	j+PxVyY8yI8k1CM9diVUp7g2xZozL4Rvcps0EHVgFSfoKfkw==
X-Google-Smtp-Source: AGHT+IHK1+8wkUkZrlVKyHxSIkxWM3L2OtLqZLkiHtzswKb2EhNwF5bCPQ8/IEskBtEZBQzHRol8dg==
X-Received: by 2002:a17:903:19c3:b0:270:4aa8:2dcc with SMTP id d9443c01a7336-290c9d34dddmr430271895ad.19.1761530366334;
        Sun, 26 Oct 2025 18:59:26 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d42558sm62269595ad.69.2025.10.26.18.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 18:59:25 -0700 (PDT)
Message-ID: <cb301be6-8d51-4872-8722-60d0accb7387@gmail.com>
Date: Mon, 27 Oct 2025 10:59:22 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Collect documentation-related tools under
 /tools/docs
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, Akira Yokosawa <akiyks@gmail.com>
References: <20251024200834.20644-1-corbet@lwn.net>
 <d3f4c7ee-6351-4c6f-ae93-f423245c4c9e@gmail.com>
 <20251026073405.0672c9dd@sal.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20251026073405.0672c9dd@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, 26 Oct 2025 07:34:05 -0300, Mauro Carvalho Chehab wrote:
> Em Sun, 26 Oct 2025 00:14:23 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Fri, 24 Oct 2025 14:08:21 -0600, Jonathan Corbet wrote:
>>> Our documentation-related tools are spread out over various directories;
>>> several are buried in the scripts/ dumping ground.  That makes them harder
>>> to discover and harder to maintain.
>>>
>>> Recent work has started accumulating our documentation-related tools in
>>> /tools/docs.  This series completes that task, moving the rest of our
>>> various utilities there, hopefully fixing up all of the relevant references
>>> in the process.
>>>
>>> At the end, rather than move the old, Perl kernel-doc, I simply removed it.
>>>
>>> The big elephant lurking in this small room is the home for Python modules;
>>> I left them under scripts/lib, but that is an even less appropriate place
>>> than it was before.  I would propose either tools/python or lib/python;
>>> thoughts on that matter welcome.
>>>
>>> Changes in v3:
>>>   - Now with more caffeine! Properly based on docs-next.  
>>
>> :-) :-)
>>
>> WRT the build error from test robot, it looks to me like we need these
>> final touches:
>>
>> diff --git a/Documentation/conf.py b/Documentation/conf.py
>> index 8e3df5db858e..fbd8e3ae23ea 100644
>> --- a/Documentation/conf.py
>> +++ b/Documentation/conf.py
>> @@ -582,7 +582,7 @@ pdf_documents = [
>>  # kernel-doc extension configuration for running Sphinx directly (e.g. by Read
>>  # the Docs). In a normal build, these are supplied from the Makefile via command
>>  # line arguments.
>> -kerneldoc_bin = "../tools/docs/kernel-doc.py"
>> +kerneldoc_bin = "../tools/docs/kernel-doc"
>>  kerneldoc_srctree = ".."
>>  
>>  def setup(app):
>> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
>> index 2586b4d4e494..3c815b40026b 100644
>> --- a/Documentation/sphinx/kerneldoc.py
>> +++ b/Documentation/sphinx/kerneldoc.py
>> @@ -289,13 +289,8 @@ def setup_kfiles(app):
>>  
>>      kerneldoc_bin = app.env.config.kerneldoc_bin
>>  
>> -    if kerneldoc_bin and kerneldoc_bin.endswith("kernel-doc.py"):
>> -        print("Using Python kernel-doc")
>> -        out_style = RestFormat()
>> -        kfiles = KernelFiles(out_style=out_style, logger=logger)
>> -    else:
>> -        print(f"Using {kerneldoc_bin}")
>> -
>> +    out_style = RestFormat()
>> +    kfiles = KernelFiles(out_style=out_style, logger=logger)
> 
> Patch is incomplete, as it doesn't drop the logic which forks
> kernel-doc script run, but see below.
> 
>>  def setup(app):
>>      app.add_config_value('kerneldoc_bin', None, 'env')
>> diff --git a/Makefile b/Makefile
>> index d6ff0af5cca6..33b1db1cc0cf 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -460,7 +460,7 @@ HOSTPKG_CONFIG	= pkg-config
>>  
>>  # the KERNELDOC macro needs to be exported, as scripts/Makefile.build
>>  # has a logic to call it
>> -KERNELDOC       = $(srctree)/tools/docs/kernel-doc.py
>> +KERNELDOC       = $(srctree)/tools/docs/kernel-doc
>>  export KERNELDOC
>>  
>>  KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>>
>> -----------------------------------------------------------------
>>
>> The change in Documentation/sphinx/kerneldoc.py is needed because
>>
>>     kerneldoc_bin == ".../kernel-doc.py"
>>
>> indicated loading it as python lib into the extension, while
>>
>>     kerneldoc_bin == ".../kernel-doc"
>>
>> indicated invoking it as a script.
>>
>> Now that we don't have kernel-doc.py, loading python lib looks to me
>> as a natural choice.
>>
>> Mauro, what do you think?
> 
> Good point. I'm not sure about this. Yeah, on normal cases, we
> just want to run kernel-doc classes, instead of actually
> executing its binary. Yet, for debugging purposes, it might
> still be interesting to run it as separate processes.
> 
> See, right now, if KERNELDOC is not used, it will use imported
> Python classes, running them directly without creating processes.
> So, it won't actually call ".../kernel-doc". On such case, in
> practice, it will actually ignore KERNELDOC when building docs.
> 
> Now, (after this series), if one runs:
> 
> 	KERNELDOC=tools/docs/kernel-doc make htmldocs
> 
> it will run kernel-doc script as a process. This might be useful
> for debugging purposes.
> 
> Also, please notice that KERNELDOC is used on several files:
> 
> 	$ git grep -l KERNELDOC
> 	Makefile
> 	drivers/gpu/drm/Makefile
> 	drivers/gpu/drm/i915/Makefile
> 	include/drm/Makefile
> 	scripts/Makefile.build
> 	tools/docs/sphinx-build-wrapper
> 
> IMHO, we have some alternatives here:
> 
> 1. completely drop support for KERNELDOC variable.
>    On such case, we need to drop from the script:
> 
> 	- kerneldoc_bin
> 	- run_cmd() function
> 	- remove KERNELDOC from Makefiles and sphinx-build-wrapper
> 
> 2. keep it as is, which would help debugging (and eventually
>    would allow testing two different implementations of kernel-doc
>    without needing to bisect);
> 

So, as far as the build regression reported by the build bot is
concerned, I think 2. is good enough.

Probably, Jon included the rename of:

 scripts/kernel-doc                                     |  1 -
 scripts/kernel-doc.py => tools/docs/kernel-doc         |  0
 16 files changed, 22 insertions(+), 24 deletions(-)
 delete mode 120000 scripts/kernel-doc
 rename scripts/kernel-doc.py => tools/docs/kernel-doc (100%)

in 6/8 considering it the right thing to do.

Let's keep the symlink of kernel-doc --> kernel-doc.py, at least for the
time being.

Further tweaks and cleanups around KERNELDOC can wait.

       Thanks, Akira


