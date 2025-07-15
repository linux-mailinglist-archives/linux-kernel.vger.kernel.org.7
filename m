Return-Path: <linux-kernel+bounces-732214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15998B06385
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1631AA54B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D527381D;
	Tue, 15 Jul 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="azO6PHCf"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926B248F75
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594801; cv=none; b=Fo5T0pvFcppb7XBssCEHP9e5ikiMUsM3hJERbuGkJs+lSm/SfklrgKeUQ0mvwzPdSLFY51sxgIv9iZUvCwDXUfwJjAOzVlbGjpnNHl0Vmg1C1SkxoyGmUTE34hFDPNWeQDFt6mR1jKDiizBTaJsCsC7ag4PFMfd5xrfWdEAV67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594801; c=relaxed/simple;
	bh=DMMZBdypiE0aGl5V6RQvbo73EzLTuFEwncQQJYrvDh4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gvr63KKuMMYJYoWGsNWRg+0VMyFmfgmKz8HOVS/yMkILkXNGzIafoEH8UEn24AfEdh0TCSyE8FsMdo+HBCuCk6zBgWfKIpMouzQk4qJfWaT3SNu+LhyoidJ+pmgWtgGKYNn/ChYktnl3pB1pFDw0BElQu1dE475tP/Anke1eTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=azO6PHCf; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.13] (business-24-134-207-61.pool2.vodafone-ip.de [24.134.207.61])
	(Authenticated sender: t.guttzeit@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 33BB92FC0057;
	Tue, 15 Jul 2025 17:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1752594355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/H+cQhyZm0Nb3DO7Ui2fMqJqiZh190V9LpxSLFnrBg=;
	b=azO6PHCfU8/53XgEVSD60PDD9d7n/eJwnYNU8vCh3CzaShfu8wy1oUlSHcC3Z+rYWm5EjL
	qlc/SsQdSX+OTrbwN0lP2U7Dcs7dyESTwwHGxQ7tgqCNqlgHee94XbYTFMCxaSPTEaDhnN
	P6clxgns3VDNsRD0uSi/Zi3+W3OqmWw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=t.guttzeit@tuxedocomputers.com smtp.mailfrom=t.guttzeit@tuxedocomputers.com
Message-ID: <95fd3ab0-7fe9-4abe-a57d-bf261064c097@tuxedocomputers.com>
Date: Tue, 15 Jul 2025 17:45:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] drm/i915/display: Avoid unsupported 300Hz output
 mode on a TUXEDO device
From: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
To: Werner Sembach <wse@tuxedocomputers.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20250704192007.526044-1-wse@tuxedocomputers.com>
 <aG2IL07UtZ4YICMn@intel.com>
 <513aa035-8a00-4943-abc1-d68824a5c0c6@tuxedocomputers.com>
 <881d51a5-bed3-430e-a3cd-aca5f17e16bf@tuxedocomputers.com>
Content-Language: en-US
Organization: TUXEDO Computers
In-Reply-To: <881d51a5-bed3-430e-a3cd-aca5f17e16bf@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

added intel-gfx@lists.freedesktop.org and 
intel-xe@lists.freedesktop.org, as requested in the ticket.

Best regards,
Tim Guttzeit

Am 09.07.25 um 15:32 schrieb Tim Guttzeit:
> Hi all,
>
> > Tim can you follow up with this? Reducing the communication chain to 
> avoid dropping information.
>
> Yes, here is the Ticket: 
> https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14616
>
> Best regards,
> Tim Guttzeit
>
> Am 09.07.25 um 13:49 schrieb Werner Sembach:
>> Hi all,
>>
>> Am 08.07.25 um 23:05 schrieb Rodrigo Vivi:
>>> On Fri, Jul 04, 2025 at 09:03:45PM +0200, Werner Sembach wrote:
>>>> RFC because I'm not sure if this is the right approach.
>>> Could you please file a gitlab issue for us so we can get someone 
>>> from our
>>> display team to take a look and see if there's anything else that 
>>> could be done
>>> before we take the quirk route?
>>>
>>> https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html
>>
>> Tim can you follow up with this? Reducing the communication chain to 
>> avoid dropping information.
>>
>> Best regards,
>>
>> Werner Sembach
>>
>>>
>>> Thanks for the investigation and the quirk,
>>> Rodrigo.
>>>
>>>> The flicker manifests ever few seconds 1-3 black frames in quick
>>>> succession.
>>>>
>>>> On windows 300Hz can not be selected for the iGPU, but the panel 
>>>> advertises
>>>> it.
>>>>
>>>> A cleaner solution would probably to go over the pixel clock, but 
>>>> for this
>>>> device there is only one 300Hz mode in the panels edid and that is 
>>>> at the
>>>> nativ resolution. Chroma subsampling was not tested as linux afaik 
>>>> offers
>>>> no way to easily enforce it for intel gpus.
>>>>
>>>> Tim Guttzeit (1):
>>>>    drm/i915/display: Avoid unsupported output mode with 300Hz on 
>>>> TUXEDO
>>>>      device
>>>>
>>>>   drivers/gpu/drm/i915/display/intel_dp.c     |  5 ++++
>>>>   drivers/gpu/drm/i915/display/intel_quirks.c | 30 
>>>> +++++++++++++++++++++
>>>>   drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>>>>   3 files changed, 36 insertions(+)
>>>>
>>>> -- 
>>>> 2.43.0
>>>>
>

-- 
Tim Guttzeit
Development
--
TUXEDO Computers GmbH
Alter Postweg 101
D-86159 Augsburg
--
www.tuxedocomputers.com
Fon: +49 (0) 821 / 8998 2992
--
Amtsgericht Augsburg: HRB 27755
CEO: Herbert Feiler
VAT-ID: DE815420876



