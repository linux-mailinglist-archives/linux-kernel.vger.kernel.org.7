Return-Path: <linux-kernel+bounces-893941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C0AC48F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59693A7F56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EE7333429;
	Mon, 10 Nov 2025 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fWBO7Wuq"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDF2D7DCF;
	Mon, 10 Nov 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800858; cv=none; b=kUrlBNn3OJL4qZz+N/A/5IGATqtucUUpBrjGfE6uccnvbV0/g3II5iR1tK9ViOYr6chZkH0DXj2x1m153t/Q8MjGyfWbisE3j80dK+zFuzFSc630PuSfdFVvtiMzhxSwPEVH6QhIL5dYLd+ao+d4OkUSwwm8yTwBRU0uM0Mdh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800858; c=relaxed/simple;
	bh=E8A4EjpkJOtqoKTqmzYw0a1m+o5R99tFl/FPJNmVpTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFydPLvQJddyADpOwdCEpqxpE7HbZK6mGZdGyh1y3ewSQ1zuVBPJ8hvWwFMuRbcMheMsAnCmqnhxGBvgd7LK0Ddm8U8TLQddoDSMi+6xrbqUYW78LVPFW/Rx3mI5aKc4yLvjTVKMh41WHjobJicLa0p5Cw8cXP6LbemWC6TjQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fWBO7Wuq; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <78d35771-02b6-4163-88da-ceae3146afe7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762800849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5O4K0Zy+lItBVINQVgJOl9eI6Q7iy0eE2LAPlV31V8=;
	b=fWBO7WuqXShLz15+xnJp2wKf5TcZy1LAM8Uo5sQzHz1lUZrEp9kKCptisqX6WUKZUqzcJK
	YMtKMFTN4KvNcxLtTbV9t53j/xyiGDdf7bA2VOuw59iw/WJFD0gNQub9ry0PK4ScsKygts
	FHtNwJj3W0oZAIk1sxH4l5M+dbDf0es=
Date: Mon, 10 Nov 2025 19:54:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v17 0/9] platform/x86: Add asus-armoury driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com,
 Denis Benato <benato.denis96@gmail.com>
References: <20251102215319.3126879-1-denis.benato@linux.dev>
 <6b5d7dab-1175-8096-64d0-fdf2cc693679@linux.intel.com>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <6b5d7dab-1175-8096-64d0-fdf2cc693679@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/10/25 16:17, Ilpo Järvinen wrote:
> On Sun, 2 Nov 2025, Denis Benato wrote:
>
>> Hi all,
>>
>> the TL;DR:
>> 1. Introduce new module to contain bios attributes, using fw_attributes_class
>> 2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
>> 3. Remove those in the next LTS cycle
>>
>> The idea for this originates from a conversation with Mario Limonciello
>> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
>>
>> It is without a doubt much cleaner to use, easier to discover, and the
>> API is well defined as opposed to the random clutter of attributes I had
>> been placing in the platform sysfs. Given that Derek is also working on a
>> similar approach to Lenovo in part based on my initial work I'd like to think
>> that the overall approach is good and may become standardised for these types
>> of things.
>>
>> Regarding PPT: it is intended to add support for "custom" platform profile
>> soon. If it's a blocker for this patch series being accepted I will drop the 
>> platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
>> separately to avoid holding the bulk of the series up. Ideally I would like
>> to get the safe limits in so users don't fully lose functionality or continue
>> to be exposed to potential instability from setting too low, or be mislead
>> in to thinking they can set limits higher than actual limit.
>>
>> The bulk of the PPT patch is data, the actual functional part is relatively
>> small and similar to the last version.
>>
>> Unfortunately I've been rather busy over the months and may not cover
>> everything in the v7 changelog but I've tried to be as comprehensive as I can.
>>
>> Regards,
>> Luke
>>
>> Changelog:
>> - v1
>>   - Initial submission
>> - v2
>>   - Too many changes to list, but all concerns raised in previous submission addressed.
>>   - History: https://lore.kernel.org/platform-driver-x86/20240716051612.64842-1-luke@ljones.dev/
>> - v3
>>   - All concerns addressed.
>>   - History: https://lore.kernel.org/platform-driver-x86/20240806020747.365042-1-luke@ljones.dev/
>> - v4
>>   - Use EXPORT_SYMBOL_NS_GPL() for the symbols required in this patch series
>>   - Add patch for hid-asus due to the use of EXPORT_SYMBOL_NS_GPL()
>>   - Split the PPT knobs out to a separate patch
>>   - Split the hd_panel setting out to a new patch
>>   - Clarify some of APU MEM configuration and convert int to hex
>>   - Rename deprecated Kconfig option to ASUS_WMI_DEPRECATED_ATTRS
>>   - Fixup cyclic dependency in Kconfig
>> - v5
>>   - deprecate patch: cleanup ``#if`, ``#endif` statements, edit kconfig detail, edit commit msg
>>   - cleanup ppt* tuning patch
>>   - proper error handling in module init, plus pr_err()
>>   - ppt tunables have a notice if there is no match to get defaults
>>   - better error handling in cpu core handling
>>     - don't continue if failure
>>   - use the mutex to gate WMI writes
>> - V6
>>   - correctly cleanup/unwind if module init fails
>> - V7
>>   - Remove review tags where the code changed significantly
>>   - Add auto_screen_brightness WMI attribute support
>>   - Move PPT patch to end
>>   - Add support min/max PPT values for 36 laptops (and two handhelds)
>>   - reword commit for "asus-wmi: export symbols used for read/write WMI"
>>   - asus-armoury: move existing tunings to asus-armoury
>>     - Correction to license header
>>     - Remove the (initial) mutex use (added for core count only in that patch)
>>     - Clarify some doc comments (attr_int_store)
>>     - Cleanup pr_warn in dgpu/egpu/mux functions
>>     - Restructure logic in asus_fw_attr_add()
>>     - Check gpu_mux_dev_id and mini_led_dev_id before remove attrs
>>   - asus-armoury: add core count control:
>>     - add mutex to prevent possible concurrent write to the core
>>       count WMI due to separated bit/little attributes
>>   - asus-armoury: add ppt_* and nv_* tuning knobs:
>>     - Move to end of series
>>     - Refactor to use a table of allowed min/max values to
>>       ensure safe settings
>>     - General code cleanup
>>   - Ensure checkpatch.pl returns clean for all
>> - V8
>>   - asus-armoury: move existing tunings to asus-armoury module
>>     - Further cleanup: https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m72e203f64a5a28c9c21672406b2e9f554a8a8e38
>>   - asus-armoury: add ppt_* and nv_* tuning knobs
>>     - Address concerns in https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m77971b5c1e7f018954c16354e623fc06522c5e41
>>     - Refactor struct asus_armoury_priv to record both AC and DC settings
>>     - Tidy macros and functions affected by the above to be clearer as a result
>>     - Move repeated strings such as "ppt_pl1_spl" to #defines
>>     - Split should_create_tunable_attr() in to two functions to better clarify:
>>       - is_power_tunable_attr()
>>       - has_valid_limit()
>>     - Restructure init_rog_tunables() to initialise AC and DC in a
>>       way that makes more sense.
>>     - Ensure that if DC setting table is not available then attributes
>>       return -ENODEV only if on DC mode.
>> - V9
>>   - asus-armoury: move existing tunings to asus-armoury module
>>     - return -EBUSY when eGPU/dGPU cannot be deactivated
>>   - asus-armoury: add apu-mem control support
>>     - discard the WMI presence bit fixing the functionality
>>   - asus-armoury: add core count control
>>     - replace mutex lock/unlock with guard
>>     - move core count alloc for initialization in init_max_cpu_cores()
>> - v10
>>   - platform/x86: asus-wmi: export symbols used for read/write WMI
>>     - fix error with redefinition of asus_wmi_set_devstate
>>   - asus-armoury: move existing tunings to asus-armoury module
>>     - hwmon or other -> hwmon or others
>>     - fix wrong function name in documentation (attr_uint_store)
>>     - use kstrtouint where appropriate
>>     - (*) fix unreachable code warning: the fix turned out to be partial
>>     - improve return values in case of error in egpu_enable_current_value_store
>>   - asus-armoury: asus-armoury: add screen auto-brightness toggle
>>     - actually register screen_auto_brightness attribute
>> - v11
>>   - cover-letter:
>>     - reorganize the changelog of v10
>>   - asus-armoury: move existing tunings to asus-armoury module
>>     - move the DMIs list in its own include, fixing (*) for good
>>   - asus-armoury: add ppt_* and nv_* tuning knobs
>>     - fix warning about redefinition of ppt_pl2_sppt_def for GV601R
>> - v12
>>   - asus-armoury: add ppt_* and nv_* tuning knobs
>>     - add min/max values for FA608WI and FX507VI
>> - v13
>>   - asus-armoury: add ppt_* and nv_* tuning knobs
>>     - fix a typo in a comment about _def attributes
>>     - add min/max values for GU605CW and G713PV
>>   - asus-armoury: add apu-mem control support
>>     - fix a possible out-of-bounds read in apu_mem_current_value_store
>> - v14
>>   - platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT
>>     - added patch to rename the symbol for consistency
>>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
>>     - remove the unchecked usage of dmi_get_system_info while
>>       also increasing consistency with other messages
>> - v15
>>   - platform/x86: asus-wmi: export symbols used for read/write WMI
>>     - fix kernel doc
>>   - platform/x86: asus-armoury: move existing tunings to asus-armoury module
>>     - avoid direct calls to asus-wmi and provide helpers instead
>>     - rework xg mobile activation logic
>>     - add helper for enum allowed attributes
>>     - improve mini_led_mode_current_value_store
>>     - improved usage of kstrtouint, kstrtou32 and kstrtobool
>>     - unload attributes in reverse order of loading
>>   - platform/x86: asus-armoury: add apu-mem control support
>>     - fix return value in apu_mem_current_value_show
>>   - platform/x86: asus-armoury: add core count control
>>     - put more safeguards in place against possible bricking of laptops
>>     - improve loading logic
>>   - platform/x86: asus-wmi: deprecate bios features
>>     - modified deprecation message
>>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
>>     - make _store(s) to interfaces unusable in DC to fail,
>>       instead of accepting 0 as a value (0 is also invalid)
>>     - make it easier to understand AC vs DC logic
>>     - improved init_rog_tunables() logic
>>     - commas after every field in the table for consistency
>>     - add support for RC73 handheld
>> -v16
>>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
>>     - add support for GU605CX
>> -v17
>>   - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
>>     - fix RC73 -> RC73AX as another RC73 exists
>>   - platform/x86: asus-armoury: add core count control
>>     - be more tolerant on out-or-range current CPU cores count
>>   - platform/x86: asus-armoury: move existing tunings to asus-armoury module
>>     - fix usage of undeclared static functions in macros
> I've applied this to the review-ilpo-next branch. I'm still not entirely 
> happy with how the cpu cores change does store values without arrays but 
> it's not an end of the world (and could be fixed in tree).
Hello and thanks.

You would make me very happy applying things as Luke wrote them
so that successive modifications are more easily compared to
what those were doing before I changed them...

Also if you have some more hints on how I could change that
interface (while avoiding bad surprises due to index mismatch)
I will try my best... without destroying any laptop...
perhaps... Hopefully? Wish me luck.

> I had to reorder a few includes to make the order alphabetical which 
> luckily worked out without causing conflicts within the subsequent 
> patches (and a need to respin the series). Please try to remember to
> keep those in the alphabetical order.

I have noticed a pair of warnings in this v17 I would like to solve:
one line is too long, I should break it and one macro has an
unused parameter.

No semantic changes.

I have seen one of those unordered includes in asus-armoury.h...
That branch is public in your git tree: this means I can respin
a v18 from a git format-path, correct?

Is your repo the one in
https://git.kernel.org/pub/scm/linux/kernel/git/ij/linux.git/ ?
I see from the web interface that the last modification was
2 years ago?

Thanks for you patience,
Denis


