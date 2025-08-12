Return-Path: <linux-kernel+bounces-765355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF3B22F28
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777C562800F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59082F7461;
	Tue, 12 Aug 2025 17:32:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91322ED845
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019961; cv=none; b=AmHRUSCK6gKQI2d93LgFJ/2ODAWviqSi8L7MQ/pXy+C7bgW/C8zofkTJ7QBpjQN0UfK8UAXbnFzZmTKPf2l2e3Pgt3kJSwoiAzqruK6AtuwoucsroehTJA8lmSRbmMHNupNPYHdAupRqqlShUQ/bTQnctsVQeXQktsyqmsjgl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019961; c=relaxed/simple;
	bh=qLErD7Gkr3On10x9Ih55F8nNlLjTdbcj3PTP7+xqOvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTH1iJ/KxRB8XXD/YiKZUzTCx3bbuQlOn3jFmAnEZhEAtnZT37Z4/eNI7vzw5h93W+CMDs9azxZ4gmAn3FM0vPbWW2AGghzciJJUSyDAgOw0L/oedVZFc2Ubu5EDqZtNI2pHufuddO9kinjJano87vsbXga0L5/B7Adzi2OMhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAD9C24E9;
	Tue, 12 Aug 2025 10:32:30 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0903F63F;
	Tue, 12 Aug 2025 10:32:36 -0700 (PDT)
Message-ID: <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
Date: Tue, 12 Aug 2025 12:32:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, patches@amperecomputing.com,
 Shubhang@os.amperecomputing.com, krzysztof.kozlowski@linaro.org,
 bjorn.andersson@oss.qualcomm.com, geert+renesas@glider.be, arnd@arndb.de,
 nm@ti.com, ebiggers@kernel.org, nfraprado@collabora.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250808025533.6422-1-shijie@os.amperecomputing.com>
 <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
 <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:33 AM, Christoph Lameter (Ampere) wrote:
> On Mon, 11 Aug 2025, Jeremy Linton wrote:
> 
>>  From what I've seen, SCHED_CLUSTER seems to be a bit of give and take
>> depending on benchmark and machine. I'm not sure if it should be default
>> enabled or not, but it would really be nice to have at least a larger sweep of
>> benchmarks/machines in order to be sure of the decision.
> 
> If the hardware provides a clusterid then I think this clusterid should be
> used for the sched domains. CONFIG_SCHED_CLUSTER does that. So it should
> be the default.

Hi,

The problem is that this information is being sourced from the ACPI 
PPTT. The ACPI specification (AFAIK) doesn't define a cluster, so the 
linux cluster information is being 'invented' based on however the 
firmware vendor choose to group CPU nodes in the PPTT. Which means its 
possible for them to unknowingly create clusters, or also fail to create 
them when they make sense.

> 
> If there is no cluster information then these domains should not be
> created. I think that is already the case?
> 
> 


