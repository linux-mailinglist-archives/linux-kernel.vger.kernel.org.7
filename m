Return-Path: <linux-kernel+bounces-738985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD706B0C012
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E3E17E6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E77328A70C;
	Mon, 21 Jul 2025 09:20:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270E828B7D6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089646; cv=none; b=S4W+bkSe8IQm5GmE4fvY+JXNiSs+xiDvzvAXrgcw947/gMFnWt3LY+eWOaOhsN+N6g+zBBS6ACStcAMnlC79k2cbyAYLduZiLnXgb3mFlLej8F1g1B7UOEkTvosueoJwuC5dLYM+ZYVEIay4YydmLy02I8V1HsqI8AJvbCG51MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089646; c=relaxed/simple;
	bh=sEY8lm7D5ytUBFxnTyt5Aer0TKDjqZCO21Mswgfd+4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnIOzQAayzKhR97S9/Eze6Wn0ue26cvxnLx9TEH8Rzl9CDBgA2Ud3ZwkTbUx6R26liPT+i4owVDiHROUovlLcAsq2CzghA3CSCKBTJSAAZeWbqcbAMatS2NAGDB7zyEbocSgl3ufvQE2EPttsD0aA3OgHJIL5XiLGoTUmQLqa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77BF01595;
	Mon, 21 Jul 2025 02:20:38 -0700 (PDT)
Received: from [10.57.30.25] (unknown [10.57.30.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D7BC3F59E;
	Mon, 21 Jul 2025 02:20:43 -0700 (PDT)
Message-ID: <807d7899-cab4-4449-aba4-645593b1db21@arm.com>
Date: Mon, 21 Jul 2025 10:20:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] coresight: Appropriately disable trace bus
 clocks
Content-Language: en-GB
To: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250627-arm_cs_fix_clock_v4-v4-0-0ce0009c38f8@arm.com>
 <20250627-arm_cs_fix_clock_v4-v4-5-0ce0009c38f8@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250627-arm_cs_fix_clock_v4-v4-5-0ce0009c38f8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2025 12:51, Leo Yan wrote:
> Some CoreSight components have trace bus clocks 'atclk' and are enabled
> using clk_prepare_enable().  These clocks are not disabled when modules
> exit.
> 
> As atclk is optional, use devm_clk_get_optional_enabled() to manage it.
> The benefit is the driver model layer can automatically disable and
> release clocks.
> 
> Check the returned value with IS_ERR() to detect errors but leave the
> NULL pointer case if the clock is not found.  And remove the error
> handling codes which are no longer needed.
> 
> Fixes: d1839e687773 ("coresight: etm: retrieve and handle atclk")

I would drop this tag as I don't see what we are fixing ?
If there is indeed something, I would recommend:
  - Call it out in the commit description.
  - Move that as a separate patch, so that it can be
    safely backported without touching all the other drivers.

If you agree with the above, I will drop the "Fixes" tag and
can merge it.

Suzuki


