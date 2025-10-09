Return-Path: <linux-kernel+bounces-846818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8DFBC91F1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2D7D4FA180
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA682E2DDD;
	Thu,  9 Oct 2025 12:51:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE5ABA3F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014285; cv=none; b=KC9y+I+D95B6yhB5iFKRFGeSH4KgAbhzbGatHaFDUet1z7whiqie++/NH+zS9C7p23YhPGb0OO5euaJMJ9AmYvb3+ZXy2Du28U+FA+/Xzenpn+6KzhiehSziFvkQwQZsg4qLAaWbS/2IiF+m7p3frsA4FPdiM+vBrvCD80hFAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014285; c=relaxed/simple;
	bh=L2lYR67yrdmGoAFNwPBlzuhg9P5hTiQEPES1NfSMUVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4nMDuvzrtT+/4s73U6CRPjaRkmUmeUDQeLyEI/b8s23FQwJ607UYmyV/btUpc645rvpG6ZW9ddgH63DzyAkFPYqjEdjSc7ILoTHEkGu1NbsOMKZuCSYtRRHdNuMko16WI3/5RfgPaUPL7rudfv89QZhP/p0HRqB10s21TNNp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3C51176A;
	Thu,  9 Oct 2025 05:51:14 -0700 (PDT)
Received: from [10.1.34.29] (e122027.cambridge.arm.com [10.1.34.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0CA93F66E;
	Thu,  9 Oct 2025 05:51:20 -0700 (PDT)
Message-ID: <f3b04a09-561f-4eb6-9730-7084e5b9697b@arm.com>
Date: Thu, 9 Oct 2025 13:51:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Ensure MCU is disabled on suspend
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Ketil Johnsen <ketil.johnsen@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251008105112.4077015-1-ketil.johnsen@arm.com>
 <d526aaed-b29d-4e19-aab4-aa735282055e@arm.com>
 <20251009134544.4502df0d@fedora>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251009134544.4502df0d@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2025 12:45, Boris Brezillon wrote:
> On Thu, 9 Oct 2025 11:29:14 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>> On 08/10/2025 11:51, Ketil Johnsen wrote:
>>> Currently the Panthor driver needs the GPU to be powered down
>>> between suspend and resume. If this is not done, then the
>>> MCU_CONTROL register will be preserved as AUTO, which again will
>>> cause a premature FW boot on resume. The FW will go directly into
>>> fatal state in this case.
>>>
>>> This case needs to be handled as there is no guarantee that the
>>> GPU will be powered down after the suspend callback on all platforms.
>>>
>>> The fix is to call panthor_fw_stop() in "pre-reset" path to ensure
>>> the MCU_CONTROL register is cleared (set DISABLE). This matches
>>> well with the already existing call to panthor_fw_start() from the
>>> "post-reset" path.
>>>
>>> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>  
>>
>> Reviewed-by: Steven Price <steven.price@arm.com>
>>
>> Do we need a Fixes tag? Or is this only actually an issue on newer GPUs?
> 
> I think it'd be good to have a Fixes tag, if it's known to be the right
> thing to do after a HALT, even if it's not needed on the GPUs currently
> supported by this driver.

Yeah, at the very least it won't do any harm. I'll add a:

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")

And merge this to drm-misc-fixes.

Thanks,
Steve


