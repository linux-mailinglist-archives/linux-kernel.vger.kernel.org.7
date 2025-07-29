Return-Path: <linux-kernel+bounces-749349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A43FB14D37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B6E3B12E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559CF28EA72;
	Tue, 29 Jul 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie/sTbnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1F201034;
	Tue, 29 Jul 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789946; cv=none; b=R1qzOtuIMsqs6twlq/tu4m+/dCVvFpN/VpN5ptsZn/Fr7aAvuWKORwqAyuxm1/RqdEMLV51bErfoUulJGT7MJ7r9byyLLmzcRn9ZjQXM8neUR8nWS5sffxjo4S6zsYbBgAb5Kwh0QdYyKnOJ3tg/1hdGAAoOFlsQW8wVz8jdpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789946; c=relaxed/simple;
	bh=iIvWnm6k3tgXTEe1jKMPT9SSwm4LxNun9kBcLV/m+dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ut+4t+ID4RZjHNs/yPpUPTlr1CXGmUrfdhmsSDiy0iYOYF9jAXgwNA0LdWnrLj07ZBVKCWtBXHXszt6pSS50TszVE0nV/kCPWAQuxryTzrcU6rChf3RkJW8DEA+NsJzQRpon1kM3dbg8fFWw9vHnI9fEAJD/GHBCRArDQVMt/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie/sTbnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92504C4CEF5;
	Tue, 29 Jul 2025 11:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753789946;
	bh=iIvWnm6k3tgXTEe1jKMPT9SSwm4LxNun9kBcLV/m+dE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ie/sTbnbTM9/MDi7lfi5VK/Cg8CTNGngkAMUj0uhF72Pe/hzDhxSFuG4RZCRqpQHt
	 Udkip3YHULpKXZMB4K+zFlVmLvbr86Eh4NK0TSYbTzAdm9yuA08pd+JnL66JWfFCPb
	 C37V1BHJA1DRgE4QYKzHuP4+QdCK2b3pgp1PLfO304YyBmidhI4E1hrIMllddcDfpU
	 P6EGGgt0lSkEQknjTLwzrlVHRe5RcfhHxw8Hn/FI1wb/Z+rDPymqVdpbNrzRhMMMs7
	 vFp8l1/ZsCpQSO31CZ1GBvCPjgLTZptZOvDN6g6SorYfQPyjX+LbfpVOe6Hm8QbZnD
	 GD+DXkFNmRreA==
Message-ID: <3c5ff789-9a90-4233-8a91-4b3535d4d29e@kernel.org>
Date: Tue, 29 Jul 2025 06:52:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -resend] edac: Use dev_fwnode()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, bp@alien8.de
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org
References: <20250723062631.1830757-1-jirislaby@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250723062631.1830757-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 01:26, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Robert Richter <rric@kernel.org>
> Link: https://lore.kernel.org/all/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org/
> 
> ---
> Cc: linux-edac@vger.kernel.org
> ---
>   drivers/edac/altera_edac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>


