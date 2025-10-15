Return-Path: <linux-kernel+bounces-854438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779DEBDE5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970F33B4C54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47F32D7810;
	Wed, 15 Oct 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS694sIf"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF652C21E8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529651; cv=none; b=Iuzu0PyWaTmw5HttRzbnI6cE57vmF3yFQ0gQ9a9IuJjswFPhNeAam4nWcXbKiAKU0OYvkBr0Ci0qZa6nWz1dlu9npdWLC70IZqURD+e4fH+utrB4uLYKgr5OvY5DLLNXajQatMcEusMARUSGr5fv6n2F9pTKgRHUjEopD1AAGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529651; c=relaxed/simple;
	bh=kLZr9sVPGysJ0WQNoZMtdptiRKlUbGQ7h3wzqBzYq1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=en0gHyMT3o1Un3beeLZBUnVOVP14aOouXas4zlmJYoC+Eaea/W0LHAofq5vD12OpfKnZncinUImqZnK1H2QqFgigK9w5Mi4LB/ri7oxrrxLeW/m3NcmvNbqBL6wMhpgAsjNBOxSznuLnOxalMXbv5GKsvxdhoFPL4uwJfbbL60w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS694sIf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso5597391f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760529647; x=1761134447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlCxjgb1MucHfxVVzfW5HOJJxIf6rICYOJSm1xFlMWI=;
        b=QS694sIfTd1baPvqfukpQG0xmzeTkCbOUo7542vNRgtwAGMTNypfwLOVKNNKc+Ou/+
         CjqOyUsRSocw6d/PQhaFBXd4R2QB/qBOJt3biWpmidR/nqdVNM/uYLhfeHraCcDoxHXF
         BmG8b3bW6xfS/i9qTDgLopKW2Mgr/pG3k/0WRa1SeASaAU8YW8tLMLfFQlQ/jQrozYkl
         SBCT+gweRauxLm3BDL2uvwyN4O7D9mHpeNOR5MQFQBg9IL0HCPd2qCAJvZGB3329ssE4
         tJr0e+ny8dyEZQ9DYSHdHwVI5qDE/juLw8Wrw7pDsjFFDGosn9X38SNTNonWTyefIb5Q
         joDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529647; x=1761134447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlCxjgb1MucHfxVVzfW5HOJJxIf6rICYOJSm1xFlMWI=;
        b=eRA6TOE20msulpoX7LVJ5Lkpd+ZXYpr4cflpimSCmEyKhcyP7fIyQ25cUwLgBbHkg4
         i8AtI1sKxIdAdxXz0MaHEJOlmqQSxwWBzrvrFZ1zffUdjdtGnpcS5/t/X9cDNk6BvdMV
         f1PeMNy+029xR0cAJhNr1OjBINl29AUhRUNcDQmD/zsbLtoz30Ey2EDg2hE3mtk+Tdv9
         gy/pQIRAQTicDabUbWe/FWkLU+F4YsjeOx+UQDPDCG8AHkr+aD0M/vIEId2CV5XjbG4e
         Q5B3PAjjX70cmIOgRMdMo6YkPl7oPcsql1kJl+ZtBhJDps3RTOUUcI57abC8s1bzfIZj
         h0tw==
X-Gm-Message-State: AOJu0Yz6l/FIh7nkQTmAKgEGNMg4e+oXQizto/tKECVwTGKWMKhfp7Nl
	Mzu8AfhjK1fBXb5Lr+iad97fUrLKSOCHPwlkl7PLzIemIauocR+XpmsbRLjOeA==
X-Gm-Gg: ASbGncuaGrMN4tChTkWACUPOwgzTqDycTy5lDBRjM+MQZEtHSphAc9MohLVnppjwn2d
	eSXJO9+Hqiq7mrNl/HgtH0vBGZBzCSYtZ95EBheSvnK7rfoRsDnia7lp3ekivcWyIoHq1ZaAHam
	LPP9nbx+lhkxlzVADklTJ4pRC9kmP7Cu/XoOlz6SitVWQ+z74zo14wKSXpC9j2PDyLDbAG0WEdW
	pxazlXUQ2lYfFaouwS18+pNsx/aY/277wk3iti53CVR5vx0I38/Up6E0UoDhhDvxdgKVPeIW5Xh
	VOAGw4T/yTOvjIDIihmfI8BY8fffkLUzFkg1di6J5iiQJV1LJJrhPVsFoWNEpdduvD1iIk0w0zO
	LfXv2JDJNACmGC2IlOStOuXt8aeCLKx/Eq/o2Mv1aMH7/cEeznwYNzB8BNuI7lN2G3A==
X-Google-Smtp-Source: AGHT+IGsluqt3NGItIElnIoNT1i96LzPn1A4gXtu1b0U/YlCjJywSFxvMtfWVaqSmOialU+8CAzA6w==
X-Received: by 2002:a05:6000:240d:b0:421:a112:4010 with SMTP id ffacd0b85a97d-4266e8e8f53mr17557550f8f.55.1760529647378;
        Wed, 15 Oct 2025 05:00:47 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d015esm29587532f8f.33.2025.10.15.05.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 05:00:47 -0700 (PDT)
Message-ID: <97c56897-ed9b-4d4d-ba54-d6e2abbc8b0d@gmail.com>
Date: Wed, 15 Oct 2025 14:00:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/9] platform/x86: Add asus-armoury driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, "Luke D . Jones" <luke@ljones.dev>,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251015014736.1402045-1-benato.denis96@gmail.com>
 <0752fcde-6c25-4cde-b35f-2204e24ff0f1@amd.com>
 <8e381c36-3bdf-a1d6-8e51-53243ba8bf4d@linux.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <8e381c36-3bdf-a1d6-8e51-53243ba8bf4d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/15/25 11:38, Ilpo Järvinen wrote:
> On Wed, 15 Oct 2025, Mario Limonciello wrote:
>> On 10/14/2025 8:47 PM, Denis Benato wrote:
>>> Hi all,
>>>
>>> the TL;DR:
>>> 1. Introduce new module to contain bios attributes, using
>>> fw_attributes_class
>>> 2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
>>> 3. Remove those in the next LTS cycle
>>>
>>> The idea for this originates from a conversation with Mario Limonciello
>>> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
>>>
>>> It is without a doubt much cleaner to use, easier to discover, and the
>>> API is well defined as opposed to the random clutter of attributes I had
>>> been placing in the platform sysfs. Given that Derek is also working on a
>>> similar approach to Lenovo in part based on my initial work I'd like to
>>> think
>>> that the overall approach is good and may become standardised for these
>>> types
>>> of things.
>>>
>>> Regarding PPT: it is intended to add support for "custom" platform profile
>>> soon. If it's a blocker for this patch series being accepted I will drop the
>>> platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
>>> separately to avoid holding the bulk of the series up. Ideally I would like
>>> to get the safe limits in so users don't fully lose functionality or
>>> continue
>>> to be exposed to potential instability from setting too low, or be mislead
>>> in to thinking they can set limits higher than actual limit.
>>>
>>> The bulk of the PPT patch is data, the actual functional part is relatively
>>> small and similar to the last version.
>>>
>>> Unfortunately I've been rather busy over the months and may not cover
>>> everything in the v7 changelog but I've tried to be as comprehensive as I
>>> can.
>>>
>>> Regards,
>>> Luke
>> As a general comment that applies to a few patches in the series.
>>
>> The S-o-b means that YOU sign off on them, it's like a chain of custody.
>>
>> Any patches that you're sending need your own S-o-B, even if they're 100% the
>> same as the original from Luke.
> There's also Co-developed-by tag which may be appropriate in cases where 
> both have touched the patch.
>
I have re-read the submission documentation and confirmed I need at least
S-o-b for all of them. Is it acceptable if I simply answer to the email with my S-o-b
and Co-developed-by (on patches I have touched) or do I need to resend
the whole patchset creating a v15?

Thanks,
Denis

