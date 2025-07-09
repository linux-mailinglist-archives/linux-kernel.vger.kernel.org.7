Return-Path: <linux-kernel+bounces-723722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9235CAFEA4A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E936188B62A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ABD2DEA75;
	Wed,  9 Jul 2025 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="mB291evo"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F44F2DC32D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067962; cv=none; b=KkWls+2wEJKwHmtAn8NnsG/3YZ5C2RuzSEr3RpsOH05XUKL0YKdmrxAW/1OWFgtbDuxYWjPkdlPI7ZHqiugvvgfuEAD9uFqVI6PZ1//pwszUTZNe1/ZSw3rRpz4H9u1IyFuokM2DbPbFgfdBwI15TXE0CGS/zHAmxtU5bKK3rVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067962; c=relaxed/simple;
	bh=PSO2jXwZuhOy+5DN5W/w16PXI/TzYoh6pmcRfalr4xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbNJmb35T9ps6IOWr3TPki/nm4i7KcwOEEDHuRANtbOYsBXjhBjC8q0/VbHLYylq8iVQuda5u7m80oR4a9SV2KtN3b2NjAZxP4nylrCgTacvpkV2epuudlhRaW8sd5i+r90iSGESzaxVR2UpRxL0fFU6sRTTPDeYDSNIAqdK6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=mB291evo; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [10.10.2.54] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: t.guttzeit@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 8D8A32FC004A;
	Wed,  9 Jul 2025 15:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1752067956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqQNZscvBRCRP9/rke29cXpIBFD8z8lxDJ2+7V1iRvs=;
	b=mB291evoKMb3du4KpEXEtYCTV6shwXKhbZGHLuE4oWGksu2dnsZSN0TpcrxLiXHIs9AOE2
	aENj5cj5teeQx4J7/lqiaVBjt6QnTjqzoBaaAcXDIG1PTKU+vA6qsJeoeKGUeTBr1cLHLS
	GpqXf7xX2PFfRWZzsvk9NELdikd3qlY=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=t.guttzeit@tuxedocomputers.com smtp.mailfrom=t.guttzeit@tuxedocomputers.com
Message-ID: <881d51a5-bed3-430e-a3cd-aca5f17e16bf@tuxedocomputers.com>
Date: Wed, 9 Jul 2025 15:32:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] drm/i915/display: Avoid unsupported 300Hz output
 mode on a TUXEDO device
To: Werner Sembach <wse@tuxedocomputers.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250704192007.526044-1-wse@tuxedocomputers.com>
 <aG2IL07UtZ4YICMn@intel.com>
 <513aa035-8a00-4943-abc1-d68824a5c0c6@tuxedocomputers.com>
Content-Language: en-US
From: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
Organization: TUXEDO Computers
In-Reply-To: <513aa035-8a00-4943-abc1-d68824a5c0c6@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

 > Tim can you follow up with this? Reducing the communication chain to 
avoid dropping information.

Yes, here is the Ticket: 
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14616

Best regards,
Tim Guttzeit

Am 09.07.25 um 13:49 schrieb Werner Sembach:
> Hi all,
>
> Am 08.07.25 um 23:05 schrieb Rodrigo Vivi:
>> On Fri, Jul 04, 2025 at 09:03:45PM +0200, Werner Sembach wrote:
>>> RFC because I'm not sure if this is the right approach.
>> Could you please file a gitlab issue for us so we can get someone 
>> from our
>> display team to take a look and see if there's anything else that 
>> could be done
>> before we take the quirk route?
>>
>> https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html
>
> Tim can you follow up with this? Reducing the communication chain to 
> avoid dropping information.
>
> Best regards,
>
> Werner Sembach
>
>>
>> Thanks for the investigation and the quirk,
>> Rodrigo.
>>
>>> The flicker manifests ever few seconds 1-3 black frames in quick
>>> succession.
>>>
>>> On windows 300Hz can not be selected for the iGPU, but the panel 
>>> advertises
>>> it.
>>>
>>> A cleaner solution would probably to go over the pixel clock, but 
>>> for this
>>> device there is only one 300Hz mode in the panels edid and that is 
>>> at the
>>> nativ resolution. Chroma subsampling was not tested as linux afaik 
>>> offers
>>> no way to easily enforce it for intel gpus.
>>>
>>> Tim Guttzeit (1):
>>>    drm/i915/display: Avoid unsupported output mode with 300Hz on TUXEDO
>>>      device
>>>
>>>   drivers/gpu/drm/i915/display/intel_dp.c     |  5 ++++
>>>   drivers/gpu/drm/i915/display/intel_quirks.c | 30 
>>> +++++++++++++++++++++
>>>   drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>>>   3 files changed, 36 insertions(+)
>>>
>>> -- 
>>> 2.43.0
>>>


