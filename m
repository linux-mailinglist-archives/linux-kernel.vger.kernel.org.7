Return-Path: <linux-kernel+bounces-649597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A86AB868F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 14:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34049E6145
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD3298CB6;
	Thu, 15 May 2025 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8qbiz1T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C22222CB;
	Thu, 15 May 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312646; cv=none; b=qm8u6TPujFadCeQyx0xcFKVPapXbsRsLRilsIPMssNRoLBqMma8yJE7+3V3jy2ec9E0nbNxAcmgTFkGzE2cqpsQe7Qnw8mwTDagu+fAD31q+kXPuHXTIQPm1UbvXg5s6ZF4yzDcmcX16CZIj+aQU3DDCKnIxTcbiEqSlx6F//04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312646; c=relaxed/simple;
	bh=SPP2yJvkgto2kJr0c7GNRkaRc4Q7tFHf9iHo4zZiRhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr53zCXnw54LTfoz+RLByAvCm5UV2TEsGdu8F7PyliP+PjVm964eKa95aRhOS5ucXV/NR6/hVg7feOoifKjAvpJTKcxAUHsjaTZ/I4pwwrVj6Is1wne6gUfLhqcFMb0nfTBQZKUmBcxklm2CPtebKk24qOiZ+qHPOScp4KmgN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8qbiz1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E378FC4CEEF;
	Thu, 15 May 2025 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747312646;
	bh=SPP2yJvkgto2kJr0c7GNRkaRc4Q7tFHf9iHo4zZiRhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R8qbiz1T7Z/rSnWuSeuEJ9OtSB1RdGr4ZAil+Sgyizpj65KNOb8ugO116V98RBfUg
	 HUmuRVkASzwiMyob4ChlAfnR96bdzBaFdr+rwk3INSZkzwZ1Y2MvFYyUvkCjYfLpi0
	 KE1fVEh/Cmj6BFnwpPtH0Z/VzMmA22XnSZLd5cZUkMFZIUrxPjPXIYKRtuWfZYgoP1
	 YiPaN6H23OmanKKe/+6cJWBtzYrpkuhEKMppUZyyvYSk0Loh8U/n8el228JX31A4dr
	 prUC3bR0mzDUzbTCokUemzfO55KtI7AlRY/YAIiqvgzZQuDD7Dti8TKwM8MJeDU8f1
	 7Sbf/VRYOQG2w==
Message-ID: <368ecccf-ef85-458d-bb7d-ddee87301abe@kernel.org>
Date: Thu, 15 May 2025 14:37:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: Convert arasan,cf-spear1340 to DT
 schema
To: "Rob Herring (Arm)" <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250512215757.4179283-1-robh@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250512215757.4179283-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 23:57, Rob Herring (Arm) wrote:
> Convert the Arasan/SPEAr Compact Flash Controller to DT schema format.
> 
> The "clock-frequency" property isn't actually used. Add a single
> "clocks" entry as the Linux driver supports a single clock though the
> platform still doesn't have clocks in DT.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied to for-6.16. Thanks !

-- 
Damien Le Moal
Western Digital Research

