Return-Path: <linux-kernel+bounces-845616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB5BC587B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08601896FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33392ECD39;
	Wed,  8 Oct 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr8HS9cP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DE2EBBB0;
	Wed,  8 Oct 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936460; cv=none; b=Jl+/DyaugA351evc3WGZvPJ2wTSteMGGx/U0QQGlJs6CKQBEv4+Wefj8dTACTJGvoZGm+K5jMZiZ7XW8CVk9c3BfUDr2AJRiq26tt6I4nZ6KYaUzoAAS+4SPCfIezdn56aFZEoY7a9/SJGGaRJySddc3MSueIgnP1k8jUi7khig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936460; c=relaxed/simple;
	bh=IquE65YNj/eT69m7aDUz1XbxoH/MKuQuQtoN5PtO8x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orVhFme2kC1I4prFhM582lrZ+soyMXX4EGzmZzzgwDOkkgiMWfIrA9DwakhAopXbyppvYVOZK628nyxP5AL3srZMC7FDDTb5cKSdWcp6aspMGuwdmX9dljV1lrC1rFXQ8pwrW6S7Kt6OZsYa7FRzbsxsqAn8Oxl4bQsk2VE3X6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr8HS9cP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5267BC4CEE7;
	Wed,  8 Oct 2025 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759936459;
	bh=IquE65YNj/eT69m7aDUz1XbxoH/MKuQuQtoN5PtO8x8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kr8HS9cP3vCN3NclqWcwD59r1mvmTnNGiVpm9BDLTo8PI/TkCippEhkF3JjuL9rZ6
	 wWVZUHyUUWDo+rkUvHNj8oJ03jRK7IpxNeOLy09mr7ExGz04fwYVt7b8k/RQroiL8C
	 uuxaRPk/52Cvb34//rsKewaer8ApKqdD/3bdWurAgV0AhIbimNF84PHhnIb9He8Hfy
	 XZI9ESOeINb9sdv7jN2XUj269VV2CnjSGI5JebdqJ4/lqiRrI7fTramqpJwLVSWMyt
	 xtdM0sr6m7wZKHSh1HdFnnDJkVVOChWnIDUHxJzfXMApNGv5U+twZRtlMY7tpT8XwU
	 CX5zzLEtOlbag==
Message-ID: <b50be0eb-19c3-410d-839b-65c6a73ab6b9@kernel.org>
Date: Wed, 8 Oct 2025 10:14:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86/amd: pmc: Add Lenovo Legion Go 2 to pmc
 quirk list
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20251008135057.731928-1-lkml@antheas.dev>
 <f6d4145b-3295-4a98-9074-d4d1b7b466ae@kernel.org>
 <CAGwozwGkbJ7qQw6EXF96UjzF5GOi4qRxp2JZFsi4MPbNa97Cyg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwGkbJ7qQw6EXF96UjzF5GOi4qRxp2JZFsi4MPbNa97Cyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/25 9:18 AM, Antheas Kapenekakis wrote:
> On Wed, 8 Oct 2025 at 16:06, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 10/8/25 8:50 AM, Antheas Kapenekakis wrote:
>>> The Lenovo Legion Go 2 takes a long time to resume from suspend.
>>> This is due to it having an nvme resume handler that interferes
>>> with IOMMU mappings. It is a common issue with older Lenovo
>>> laptops. Adding it to that quirk list fixes this issue.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4618
>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>
>> This makes sense for BIOS in the field.
>> If this is fixed in the BIOS later I'd like to narrow the quirk at a
>> later time.
> 
> That would be ideal. Especially since the issue is known and fixed in
> Lenovo laptops from the last three years so it should be easy to fix.
> Currently, there are two BIOS versions that would need quirking,
> RRCN11WW, RRCN10WW.
> 
> What are the side effects from blocking the Nvme handler? Other than
> OPAL support handled by the built in BIOS, which is a semi-antifeature
> for a device like this.

The inability to use a storage password is the only side effect I'm 
aware of.  Given the form factor I tend to agree it's not "high 
priority" and thus this quirk makes sense.
> 
> I should note that there are other pressing issues with the device.
> Users report HDR brightness is not at correct levels compared to
> Windows and the brightness slider sometimes breaks after sleep.
> 
> HDR brightness might be a bug in Bazzite specifically, due to a
> blanket quirk we apply to disable the PQ curve on internal displays
> (essentially the panel that had the brightness bug on e.g. Zotac Zone
> also reports supporting PQ but it does not). I disabled it for the Go
> 2 but have not double checked it is disabled due to not having a
> device. Users said there was an improvement after disabling it though.
> 

Wrong audience for this issue.  I would raise this for discussion on 
dri-devel if it happens on a mainline kernel without extra distro 
specific quirks added.
> Antheas
> 
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>
>>> ---
>>>    drivers/platform/x86/amd/pmc/pmc-quirks.c | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>>> index d63aaad7ef59..0fadcf5f288a 100644
>>> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
>>> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>>> @@ -204,6 +204,23 @@ static const struct dmi_system_id fwbug_list[] = {
>>>                        DMI_MATCH(DMI_PRODUCT_NAME, "82ND"),
>>>                }
>>>        },
>>> +     /* https://gitlab.freedesktop.org/drm/amd/-/issues/4618 */
>>> +     {
>>> +             .ident = "Lenovo Legion Go 2",
>>> +             .driver_data = &quirk_s2idle_bug,
>>> +             .matches = {
>>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "83N0"),
>>> +             }
>>> +     },
>>> +     {
>>> +             .ident = "Lenovo Legion Go 2",
>>> +             .driver_data = &quirk_s2idle_bug,
>>> +             .matches = {
>>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "83N1"),
>>> +             }
>>> +     },
>>>        /* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
>>>        {
>>>                .ident = "HP Laptop 15s-eq2xxx",
>>>
>>> base-commit: a8cdf51cda30f7461a98af821e8a28c5cb5f8878
>>
>>
> 


