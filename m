Return-Path: <linux-kernel+bounces-821876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04131B8288B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E101C20FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E86235345;
	Thu, 18 Sep 2025 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hrQO9Dq9"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11D54673
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159730; cv=none; b=LwZDVDCLD4ndKzVShOV+QgeqqkpXUR7Ab6/QXR1dHW6oRAMo30uUk0MmI+ZNCpuXU866F8xGp7rVJoLCXxQPliwvGKelozIayXhhhgs1u7QVBfmOZQXjonumUqw+DW5lgSjt6Z0dMCqV1BrkaTDkr2xX9AQv6A6sMdEwcES5Y7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159730; c=relaxed/simple;
	bh=rdfZa8jgCBx0Z/kzJWH1cObTBcN8b20ZfvsfOn2m9eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuPK780+CuqWjg8QJFgMLFJRbilsoPv4TauvKNcfZcImeEExDbpKPc4WsuVDiRGulmvhj0Gix+2Jjm8MqiMDwCrbyIMkP/nbGm1griKVCYcTF7cWA+33wnpJrkDNaosGC7S/gYYIcdqoHp1H2/eykDnFELrpdLiOrRyGLnJJ3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hrQO9Dq9; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5df18d21-a451-4261-8606-8faa41149028@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758159724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VK0aNf8yfpHz4wwNcRBOG7PZ4LEkmtROha+wWS9FpmI=;
	b=hrQO9Dq9bMzluTVloFTx0iPFN5W5c7NwX73MJwymgHVsjC9uKhV3UV6Gi/plzxmqOiQ39Q
	LSLT4gwnPIYTnlOQ6uAdLqJYwR3zhoUBwzuzJz5yxHRIvbCMPCGubCRTWrJqzOo249v7nL
	4q7EIHNA24aorORBSO+DjiwfI9r1lc0=
Date: Thu, 18 Sep 2025 09:41:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] selftests/mm: skip soft-dirty tests when
 CONFIG_MEM_SOFT_DIRTY is disabled
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250917133137.62802-1-lance.yang@linux.dev>
 <20250917153046.b781f65ea9a54875f4ddd02e@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250917153046.b781f65ea9a54875f4ddd02e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/18 06:30, Andrew Morton wrote:
> On Wed, 17 Sep 2025 21:31:37 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> 
>> The madv_populate and soft-dirty kselftests currently fail on systems where
>> CONFIG_MEM_SOFT_DIRTY is disabled.
>>
>> Introduce a new helper softdirty_supported() into vm_util.c/h to ensure
>> tests are properly skipped when the feature is not enabled.
> 
> It's pretty sad for us to ship kernels which have known selftest flaws
> like this.
> 
> would
> 
> 	Fixes: 9f3265db6ae8 ("selftests: vm: add test for Soft-Dirty PTE bit")
> 
> be appropriate?

Yes. Thanks for providing the Fixes: tag!


