Return-Path: <linux-kernel+bounces-887373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E0C380E3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20453BBDCF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5C92C0F97;
	Wed,  5 Nov 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1TG/tgX"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F423F424
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378140; cv=none; b=Tk39lPmBvKMzoyJJbuzvDkzIi79Isfc79TwH0fDGYkVOfLJ0EoHo1YjyBQfwywGHKh/PTU4x+4WHaRBvzdF/V7I6ATvQzJWPUu2jmncZXiAVcoXolCTrkTC4z7pw8qgnzUd/oiHnl5ONPWqyqicfu89yijb0mL0oiGlKJPiGNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378140; c=relaxed/simple;
	bh=+HEydyOW1lU2ALcOZDdqPBn4aGTT1nlZWPBmPwdNamk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBVC23Tx9YOWn+DM0w6Q4WSkV6ffA3zZz+LGcyDNCxdBT4mZK/X6a8nfJ2txLHfvAr+QpcpJGN77C+qzwWDermrg2tienW0xC35VAu0OBI3eHrO5cejO1ix2+VG2L6XjWLNLGMlNmaOZkhm3FBSZL0Oyt5fb/odNwjjbo4plA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1TG/tgX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7260435287so34560966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762378137; x=1762982937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKVAByp1/+LkpfKD4KN0974hBK7mn9fIh1iZgNrqkQU=;
        b=L1TG/tgXV8gaYZQ5w1LWsOauPPbWn+/muZ7GkPm4RuUHyR3jGWVDskwcSXaTpXKA+L
         q/716nhvndZZN2HTGky0JWHtGb6NKLzPKrKJLPvpE3HhrV/vQ9Ig4afTbc6gKdXsEFGU
         jo+gXOuicn9xNJeUmXjnBrggJauE9krzeTSYeEDJw7ebj8t9aQkR1TKsYeIIF2WDMK4i
         PgQLTobzYLVmsIE0A6FjL+Kly1TEkFIT8FysU3ywJe/NwE5iO+WLrvQOWcvDTfder+1K
         s0mmBeWUFY807krc60yeStZ1rbDhlwiMC/Tc3rWjuZcZ+hpJWq2Khd18kVO1wVrtwIrY
         UNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762378137; x=1762982937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKVAByp1/+LkpfKD4KN0974hBK7mn9fIh1iZgNrqkQU=;
        b=izSaEJHJhAEUHaraOQoRa1mgEoYVrIK01sUmI80GtMYihNwrVi+HJk802dGHsu8o11
         JgwKDTY51qF5LjncQsVrTX6rWLp+KyIJerxVBgcJCa55g+w3Q/NUKDOHx6WiGoKO62nC
         LxJJ5URTqYcn8NO2wWHRD8yAFdmellWOMK7NUkPD4ol0ctbKP7qoYUzTuv6HV8qbV29O
         8csZ9izvG4TpT9g5myy81hvxza2k5GbXonPAi8d3qWbfczMWvjFPs60M97bHh9iaa0XW
         ht13j+jPhFus4uiuS2ZqKnlTL7p3ZXrqeDob7xuMmvA2KfKJVU0w9gxtXS0y/sf4xqfc
         TULQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9B/ynDfyuqDlqGE5pcEqyh6GoosJIeEp4e7pyZ7Ln5nEoZ2Sw0tfvfbGs0pT++8fTi+EEzdDTonPeZtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JhEMFuWGugwpjBQtaRahsiT6e8JNC+xg6xj2NnAAO1tGeVmS
	G7osCFZyGE45bSlDOHaQo5N13HivyGZkH4M0TuT/wBfKjCR73Q3rvPs8RC0ju9c1g5elzQ==
X-Gm-Gg: ASbGnctVN7s87ymMJehGQQu3LQ3fH7bGdKJ7dM6kbQNAQYwQGGGaogNBl0WMbB4DNR7
	1tDAYEoND9dVzChgNyYibGXdE1w/0nBT0h2MpsSVINhFBdWR7rOaJ5e4hcvF5vG5aB/GW22fS0w
	psd4YTXpBzh5yCyHJNUdr07OuHhFUOV7mjVSPPEoP3zBWV/faTHPVeyFA+ceasakfYeTo5QVesq
	4KqadkdOvfavQSixxT50MMoKPOD00Ot+0MV8ER+rvEMDqzRwuaUWe/ylZ43mmSFfmLsjalEODxx
	q8XTkopDSSYh8PN2bw1quxochP1Cg2458KIGKNnJ/im0o3IDJLcsez4xn964qCZJ2A8w4I4a22d
	LvKlfAQTT0+0QP9im423GHhDS+0n/jToRzCgRZHkVon5nbPr3uPD6R//kYHsWM+vzsrsefiWjm8
	hwpzxtmcbFuSiZhzReJeH2SEyvP1kqzAVDUJrQVOvdZjA=
X-Google-Smtp-Source: AGHT+IEUf4Irfo3WXUTbyMeP33gFkpX21nJc4K2bsAo4h2zMwVIw3b+fLJ4IkerZJz46FY1W6XtlWQ==
X-Received: by 2002:a17:907:6d27:b0:b6d:7e01:cbc5 with SMTP id a640c23a62f3a-b726567f8c8mr491291866b.53.1762378136693;
        Wed, 05 Nov 2025 13:28:56 -0800 (PST)
Received: from [192.168.4.198] (92-110-11-83.cable.dynamic.v4.ziggo.nl. [92.110.11.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937d2fasm58104466b.19.2025.11.05.13.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 13:28:56 -0800 (PST)
Message-ID: <eac10a43-5164-4ecf-8b56-6099e69001bc@gmail.com>
Date: Wed, 5 Nov 2025 22:28:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tegra: Enable cmu for Tegra186 and Tegra194
To: Aaron Kling <webgeek1234@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251101-tegra-drm-cmu-v1-1-211799755ab8@gmail.com>
 <pedxgtvzfrfzihoshhfvntin3hwwi3znleilbz4abjad74nowb@un33lgiaa26z>
 <CALHNRZ9-XrMUkQE0cwjq-HUYsy5uerhOQ9sNpirp23kKoaPuYw@mail.gmail.com>
 <72llskwvuwyllvz24zoex4ad6v6t5skiehmwylj7exoh7bmzjo@xq3v7vja5w62>
 <CALHNRZ_k6e9ZRmpK6Pzpet=RzUQ0fRYmfnea6U+9E2oZc8=z7w@mail.gmail.com>
Content-Language: en-US
From: Jasper Korten <jja2000@gmail.com>
In-Reply-To: <CALHNRZ_k6e9ZRmpK6Pzpet=RzUQ0fRYmfnea6U+9E2oZc8=z7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

On 11/4/25 19:12, Aaron Kling wrote:
> On Tue, Nov 4, 2025 at 3:14 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>> On Mon, Nov 03, 2025 at 12:39:57PM -0600, Aaron Kling wrote:
>>> On Mon, Nov 3, 2025 at 5:54 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>>>> On Sat, Nov 01, 2025 at 06:15:17PM -0500, Aaron Kling via B4 Relay wrote:
>>>>> From: Aaron Kling <webgeek1234@gmail.com>
>>>>>
>>>>> Without the cmu, nvdisplay will display colors that are notably darker
>>>>> than intended. The vendor bootloader and the downstream display driver
>>>>> enable the cmu and sets a sRGB table. Loading that table here results in
>>>>> the intended colors.
>>>>>
>>>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>>>>> ---
>>>>>   drivers/gpu/drm/tegra/dc.h  |  13 +++
>>>>>   drivers/gpu/drm/tegra/sor.c | 206 ++++++++++++++++++++++++++++++++++++++++++++
>>>>>   2 files changed, 219 insertions(+)
>>>> What does "darker than intended" mean? Who defines the intention? How do
>>>> we know what the intention is? What this patch ultimately seems to be
>>>> doing is define sRGB to be the default colorspace. Is that always the
>>>> right default choice? What if people want to specify a different
>>>> colorspace?
>>> I reported this issue almost a month ago. See kernel lore [0] and
>>> freedesktop issue [1]. The pictures in the latter show what nvdisplay
>>> looks like right now. It's nigh unusably dark. When booted into
>>> Android with a tv launcher that has a black background, as is default
>>> for LineageOS, it is really hard to read anything. Is it correct as a
>>> default? Well, cboot hardcodes this, so... presumably? It would be
>>> more ideal to expose this and csc to userspace, but I'm not sure if
>>> drm has a standardized interface for that or if tegra would have to
>>> make something vendor specific. I think that would be a separate
>>> change concept compared to setting this default, though.
>> The reason I'm asking is because I don't recall ever seeing "broken"
>> colors like you do. So I suspect that this may also be related to what
>> display is connected, or the mode that we're setting.
I have tried it on both a MacroSilicon HDMI capture card and an Arzopa 
Z1FC 1080p portable monitor and run into the same darker colors. Both 
have in common that they use HDMI which seems to line up with what Aaron 
is reporting. I do not have an eDP display to test or another carrier 
board with a different display out to test.
>> It could perhaps
>> also be related to what infoframes we're sending and how these are
>> supported/interpreted by the attached display.
>>
>> All of that is to say that maybe this looks broken on the particular
>> setup that you have but may works fine on other setups. Changing the
>> default may fix your setup and break others.
> Do you have a device set up so you can check? Or does the regression
> test bench have a display that can be forwarded?
>
> My current setup is a rack of units plugged via hdmi to a kvm which is
> then plugged to a pikvm. I also observed this issue before I had this
> setup, plugged directly to a 1080p monitor. I have not checked
> displayport. I can cycle through a couple other displays without this
> patch to see if I get any other result. I am fairly certain I have
> consistently seen this issue since I started trying to work with
> tegra-drm on kernel 6.1 or maybe even 5.15. I've never seen it work to
> allow for a bisect.
>
> I am in contact with one other person with a tx2 devkit, who
> replicated the issue when I asked. Who plans to reply to this thread
> with setup info later.

For reference, I am said person. I have a Jetson TX2 Devkit that uses 
the P2771 Device Tree. I'm running a Fedora distrokernel with no 
additional patches applied by myself. I have personally noticed the 
issue to at least be present on 6.14.5 and 6.17.4.


I'm currently not at home to take screenshots with and without the 
submitted patch, but will be able to do it tomorrownight or friday.


Kindest regards,


Jasper

>
> Aaron
>

