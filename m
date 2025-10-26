Return-Path: <linux-kernel+bounces-870623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053FC0B4DC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B243B8406
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8952FE572;
	Sun, 26 Oct 2025 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0FB5yBv6"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC00C284B3B;
	Sun, 26 Oct 2025 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761515615; cv=none; b=sImA4V+ASRl6QXoBy68PGza26rwUagS6forbnleRyaZ4t7d1X85Zb/P2MLhJOlkwspw333J5wlU1hPpzbuEZ8cPEuDBqmqLF47F5PxLxnyh9xOrUxMpk5vTUcehuYfdw8e8yNV5YwS2SZgp7OqVCmHie1BU/s+frkeboRbgbwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761515615; c=relaxed/simple;
	bh=56wAYdgTLFyqEgJB36rUkElP0+rKt2WItLzQ717Ejzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3a8I3/LT9Chu3SJ9WQhWuEaX3kUp0ZtV2shnlWuSO0bUn/fVo4QFFhT1h3/Fa2awcTaUrFz35xNgXfsEWFZC8ywPrAlsS/MdYzXgCNUmit9ysPfRtmPjLEc5wrVrzeuINEiIK7ws2nHSSU5gUgdawFMDXiRYZ0/t1xT9Y5yPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0FB5yBv6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=lWi/AHHJQO5g2tHj1zTmHjbLoGpN/3urNqh/+6C+4Zo=; b=0FB5yBv6RwDVeGWZd5Dtx7xo8O
	Bv5DPswmB6b79TtdNPWgQZcn4nXcPXownpOn/DzHsp9uJo+sZqh3/4SDaM7E7MrCkE26o/EUZ4A3M
	ZTAqACv/Voyv1h5F06Zma/CvoNBLe++IkaNuNfDwO2KTcA+28ItkeqAz8LALLjVRwrMXsCI+VOUZC
	FmMBRr+Oayq+VZNV59ByxejBtGqP2XJzZNhZs9ug2asxh3uGpH2jQ8nIDfCw/UDcRxEuLgQ4ssFYO
	1Rs76NPSZvty1z4i+KNoXDDYvQMg2EH0bQ/0UNrM0lIsXu08Y7SuH8RqMDZwUJpMCB8fi0zNPMWvb
	0JZvGesg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vD8g9-0000000Cmiw-0W6B;
	Sun, 26 Oct 2025 21:53:33 +0000
Message-ID: <affa20b2-b3f4-443c-ad42-735b13d34c5e@infradead.org>
Date: Sun, 26 Oct 2025 14:53:32 -0700
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
 Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>
References: <20251024200834.20644-1-corbet@lwn.net>
 <d3f4c7ee-6351-4c6f-ae93-f423245c4c9e@gmail.com>
 <20251026073405.0672c9dd@sal.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251026073405.0672c9dd@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/26/25 3:34 AM, Mauro Carvalho Chehab wrote:
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

No, please don't drop that feature.

I'm confused by the terminology. What does "bin" or "kerneldoc_bin"
mean here?  Is there some kernel-doc binary?

> 2. keep it as is, which would help debugging (and eventually
>    would allow testing two different implementations of kernel-doc
>    without needing to bisect);
> 
> 3. change the core of the logic to be something like:
> 
> 	# kerneldoc_bin = env.config.kerneldoc_bin
> 	kerneldoc_bin = os.environ.get("KERNELDOC")
> 
> 	if not kerneldoc_bin:
> 	   out_style = RestFormat()
> 	   kfiles = KernelFiles(out_style=out_style, logger=logger)
> 	else:
> 	    print(f"Generating C documentation by running {kerneldoc_bin} binary")
> 
>    this would still allow using KERNELDOC to point to a binary
>    that will handle C files executed as a separate process.
> 
>    Please notice that the current code does:
> 
> 	kerneldoc_bin = env.config.kerneldoc_bin
> 
>    This requires an extra logic at the wrapper tool, as this needs
>    to be passed via -D command line option to sphinx-build. That's
>    the reason why several Makefiles also use KERNELDOC env var.
> 
>    If we're willing to adopt this solution, I would simplify
>    the wrapper and the makefiles to not touching KERNELDOC var
>    anymore.
> 
> For (2) and (3), I would document KERNELDOC somewhere.
> 
> My personal preference would be (3), but I don't have strong
> feelings.


Thanks.
-- 
~Randy


