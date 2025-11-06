Return-Path: <linux-kernel+bounces-889399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142CC3D746
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69E51893AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1888304BDA;
	Thu,  6 Nov 2025 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7pmPyhw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A82926E6F6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463344; cv=none; b=FY/RCjExHPeX6xJO/B5iQ4t7C7gQxaoGP9hV+ie+EwXA+jEUfE5pxrTDURxPS62o71SYpf/oheyWSWJHRqVZ6LojOKRigeMIQ7Upnz5iAnQwK+1mVk7cnL0eGot/TuT9EcMqmz1w4PP1sqXXwc9jTNTnM85HQAIVZo8ZUyoaHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463344; c=relaxed/simple;
	bh=NJj9/t+gNJr+vDdyBNpiibSut3OUg0RSfdxa5GXVBOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imwc0OQEAtdRX2IqrWNjN/G2YpLk/PPdF8Aw9SKdA1iFH+tfH6mAhvpxR45Ygvki50sl0v1HElnCV88NMI/t4VVThwes0I3+ayNXqNR9MruNbk5AcwGNMKGxjRRa2HOxbL2Mf2qOOKWawAWBIRcV16Xg/ZEf3MALmds8ngYAv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7pmPyhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D91C4CEF7;
	Thu,  6 Nov 2025 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762463343;
	bh=NJj9/t+gNJr+vDdyBNpiibSut3OUg0RSfdxa5GXVBOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V7pmPyhwR1NHuXQ/SZbGykER1QPu/pdUavbqQl6lMhdn9SNsP0Go5SI0PwXrOFvNf
	 dhwHYwxhSY5AklnvDVpA+307VZX9vB8ApKlaMW5AKmXUWI4+ye35gNVQTAaNKShC0m
	 mtLvFsqUb8PbK7hujQbA8riepBt3KA+z/SebXLsdxEFcGS7HVxOnnmEz9hTm8PtrSx
	 3qykHLv0EfwMMr9AGOmStyKD1KoOoUP9wRrNSMr2qji2FaQBbRsPNP9FXy1fUVNIrg
	 E7A8tZlTz49SIoS8OxWG5sRdU25gnaR4NgNgsI1NbvtPQozTLVi3wuqhGOuUs27V1f
	 SUl9Zc6jk6WcQ==
Message-ID: <4356959e-102c-433c-b1d5-3fc7102ea593@kernel.org>
Date: Thu, 6 Nov 2025 22:08:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: mm: Tidy up force_pte_mapping()
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, yang@os.amperecomputing.com, ardb@kernel.org,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251106160945.3182799-1-ryan.roberts@arm.com>
 <20251106160945.3182799-4-ryan.roberts@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251106160945.3182799-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.11.25 17:09, Ryan Roberts wrote:
> Tidy up the implementation of force_pte_mapping() to make it easier to
> read and introduce the split_leaf_mapping_possible() helper to reduce
> code duplication in split_kernel_leaf_mapping() and
> arch_kfence_init_pool().
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Reviewed-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

