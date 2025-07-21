Return-Path: <linux-kernel+bounces-739441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446E0B0C651
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513AB5441E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E32DE717;
	Mon, 21 Jul 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gGKh0sBy"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050A2DE1FC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108181; cv=none; b=tsQz+Rvbs8lsQcIKeDkM40IT73QnAngzUhhuO0RUYyjTq6fNIXVgF/26DQRv7NuQgnJCKXpZlbN6VqCogrnwJpG5viDUjtP99TVdx+2GslluBBTV4Cj5liBQnyHN23rc4WkweVrm94TgE9shLUUYNbhfC6wOBgst1ZnCK0/4EXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108181; c=relaxed/simple;
	bh=1qRXyIN+3+TFXy30A4Y/3F/v4Qgs/YpJ1iDImQB/Tcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJ6sYnre2YJC+ZH+B9I07Ml0bi7nodiR5IPkeh/rEL7bomelpCmLkEx6CKKcFOUTj9nrW9jhSdHTUpO5A2cBdQOHHfX+scP4naEtHwzQnHan8OS79q8psBP35lJyhGm/lK8ipyqtJiSDk4A9iAuWx3YeFDIomSE4PGi2Vx3KRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gGKh0sBy; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4b5e4fa-45c4-4b67-b8f1-7d9ff9f8654f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753108177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEUThsSpCMUbwMYhQ5KetKy8D1sXeNWxSdmUlfQSjfQ=;
	b=gGKh0sByoEfCusDPYDneYqYDDtCK981D27SuDhdK1Ixp787h2480p0CgfM/vjALi68PWt0
	zP91EVutwm8w0xObTCjpJ2olmJx3SK3q8+WFB+Fep0wyQv4Fx+QwckhdeTVMgINSWDoBq0
	69KICTRAgIckMRGVMUmR9aWZqsf9IvY=
Date: Mon, 21 Jul 2025 10:29:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
 Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 Ira Weiny <ira.weiny@intel.com>
References: <20250716000110.2267189-1-sean.anderson@linux.dev>
 <20250716000110.2267189-2-sean.anderson@linux.dev>
 <2025071637-doubling-subject-25de@gregkh>
 <719ff2ee-67e3-4df1-9cec-2d9587c681be@linux.dev>
 <2025071747-icing-issuing-b62a@gregkh>
 <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>
 <2025071736-viscous-entertain-ff6c@gregkh>
 <03e04d98-e5eb-41c0-8407-23cccd578dbe@linux.dev>
 <2025071726-ramp-friend-a3e5@gregkh>
 <5ee4bac4-957b-481a-8608-15886da458c2@linux.dev>
 <20250720081705.GE402218@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250720081705.GE402218@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/20/25 04:17, Leon Romanovsky wrote:
> On Thu, Jul 17, 2025 at 01:12:08PM -0400, Sean Anderson wrote:
>> On 7/17/25 12:33, Greg Kroah-Hartman wrote:
> 
> <...>
> 
>> Anyway, if you really think ids should be random or whatever, why not
>> just ida_alloc one in axiliary_device_init and ignore whatever's
>> provided? I'd say around half the auxiliary drivers just use 0 (or some
>> other constant), which is just as deterministic as using the device
>> address.
> 
> I would say that auxiliary bus is not right fit for such devices. This
> bus was introduced for more complex devices, like the one who has their
> own ida_alloc logic.

I'd say that around 2/3 of the auxiliary drivers that have non-constant
ids use ida_alloc solely for the auxiliary bus and for no other purpose.
I don't think that's the kind of complexity you're referring to.

>> Another third use ida_alloc (or xa_alloc) so all that could be
>> removed.
> 
> These ID numbers need to be per-device.

Why? They are arbitrary with no semantic meaning, right?

--Sean


