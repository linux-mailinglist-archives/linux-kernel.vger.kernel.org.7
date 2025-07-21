Return-Path: <linux-kernel+bounces-739681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BABB0C9A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F99B16F248
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B472DEA9E;
	Mon, 21 Jul 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pC94KJnz"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A10421421A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118829; cv=none; b=Pij2uIAja98nmqU2u1HsdSpIkWDLNqqBygb9KqyHktG1JvdQcbEfe1DxAdV9hVJUJvNlb1A2posc5XN6jgMYwo3Xh/W7BhA/+jIMBhdhccv7OLmlLOUSZji1ofpFDtanNIzdVcWMDAUiZqpmDTiLrG5VPQ04SbBvd8S4gGJ099M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118829; c=relaxed/simple;
	bh=XmLEsA1svCSnY0PA7EpZBfYIb9SRHpQRMP2dkszVMBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZBIvuqkijyZJUxDVPEgAfO14aFT47u1g7KOGGuzYP+rkwW8SF5JMikdHGJl0kEpVvdjCBgKC1oiV5odLZ5UABSc9P3TDzOI1LBIoX97SaNHZcMa22FaD6GC5b/wdoyWy5/cjdIfXS9SCQTkzoNJ/K8jkDyecmJ3FhBQiQ++ok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pC94KJnz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86BFD21175B2;
	Mon, 21 Jul 2025 10:27:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86BFD21175B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753118827;
	bh=xmub9aFjvw/tMVjGdDoWaTJsjARmDuiOsiPPDj+ZHGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pC94KJnzta6iMqNqUYaCSQV4FmFEG6muwIv+Ul3Kml2rl8YX+6COamsbOVfmaeiln
	 iA3hgjNLDefPnXXkNEDhAmDXqGYB2jUUkDhsE5ZWQKN3AibF1VwuiE4kTavpYvRm6G
	 jSP0Y0HxHnQQ0/YFG0mMKbyV/YL6pYQM+XswYtJo=
Message-ID: <9f39e539-3216-4f5d-819f-9500f76a0154@linux.microsoft.com>
Date: Mon, 21 Jul 2025 10:27:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: kvm, smccc: Fix vendor uuid
To: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: Jack Thomson <jackabt.amazon@gmail.com>, mark.rutland@arm.com,
 lpieralisi@kernel.org, sudeep.holla@arm.com, arnd@arndb.de,
 wei.liu@kernel.org, mhklinux@outlook.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 oliver.upton@linux.dev, kvmarm@lists.linux.dev, roypat@amazon.com,
 Jack Thomson <jackabt@amazon.com>
References: <20250721130558.50823-1-jackabt.amazon@gmail.com>
 <86jz418rh3.wl-maz@kernel.org> <aH51jfOmPfF3XEke@willie-the-truck>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aH51jfOmPfF3XEke@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/21/2025 10:14 AM, Will Deacon wrote:
> On Mon, Jul 21, 2025 at 04:59:36PM +0100, Marc Zyngier wrote:

[...]

>>
>> Irk. This is remarkably embarrassing, and needs to be addressed ASAP,
>> before 6.16 ships. FWIW, I've just posted a quickly whipped selftest
>> that shows the problem[1].
>>
>> Will, is there a chance you can pick this up and ferry it to Linus?
>> If you do, please add:
>>
>> Reviewed-by: Marc Zyngier <maz@kernel.org>
>> Tested-by: Marc Zyngier <maz@kernel.org>
> 
> Sure, I'll grab it. Thanks!
> 

I'm sorry for that, apologies for screwing things up :(
Very much appreciate the fix and the test. I clearly missed testing
backward compat. with the old kernels.

> Will

-- 
Thank you,
Roman


