Return-Path: <linux-kernel+bounces-890314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91006C3FC55
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF134BF1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8631BCBD;
	Fri,  7 Nov 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjHfKi2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2926ED4D;
	Fri,  7 Nov 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515903; cv=none; b=iUj1fTgoEQq9/HdJ9JQV+YNPh1m4AX1ptHYujE35M6WzpaOA1Ah0SLw3aJFmbMb5udRJK0qq4jCNXM2Y6HZnKgCojSml68+KJTMcRN2Us9rFT0myaaG7ye+Fun9L+FN5Cl5FfpQ0rhpOFpoRF+1YGh44JuJxIIuBVlh+33x4UuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515903; c=relaxed/simple;
	bh=+McGhPRb5DdZk00rlQ5Ayy5G8ZwJFq26blt5i33MCu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r5jsCiy22cATAAp9oDzWRdN1RS2vCZjcivrBdDLEJKke/XJ8n2Qo/mWlHG5EmX6c66x5Bc8Bzbj0VQI69Ji1YsQfRzybiMEOHPG+BkQQhkH9+zy3CiUs+wsPas++ncVtJsb/NHehyWPQhpwSjVGWLJGxgE295AOLQPqjXkJitWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjHfKi2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9A0C4CEF5;
	Fri,  7 Nov 2025 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762515901;
	bh=+McGhPRb5DdZk00rlQ5Ayy5G8ZwJFq26blt5i33MCu4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gjHfKi2uWnxZ5Dh4b3/Op19IrMW6ITEHL4lUR5Cq+m+f6roFi1h3P0K5UFmi28dkl
	 zg4/lxAc2PoavYW1mPZTFL1GxqtlTQ4qMkoluuxAOdWtdi/+oMHNNpumZ+OhR6sYbz
	 oQctf1/E2ipCVOe43ZctPcoLcM4aubqs3qj9V+7voOehxdrOYAABNlaEv1E9VykNN7
	 v7wAeQoQPfsSxT0EoX2rmFclcQ3a6ZDGe9qSnOzMKjpNHw9ZRPKWZMDzlewODr4clP
	 hO1EOkvrNAdoTGCw4xWVrrkmdy/B5n++TDw1GsZhitRePJhX4VncoLlo02iuKrnTcw
	 Fdbp31XJtWr5Q==
Message-ID: <c8a32a8b-f37f-44b3-ac31-7f6d6f608dd2@kernel.org>
Date: Fri, 7 Nov 2025 05:44:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mahesh Rao <mahesh.rao@altera.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1762387665.git.khairul.anuar.romli@altera.com>
 <dc40029c970d33b433e763202e6622a0a2f12d72.1762387665.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <dc40029c970d33b433e763202e6622a0a2f12d72.1762387665.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/25 17:35, Khairul Anuar Romli wrote:
> In Agilex5, the TBU (Translation Buffer Unit) can now operate in non-secure
> mode, enabling Linux to utilize it through the IOMMU framework. This allows
> improved memory management capabilities in non-secure environments. With
> Agilex5 lifting this restriction, we are now extending the device tree
> bindings to support IOMMU for the Agilex5 SVC.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v6:
> 	- Reinstate AllOf to avoid re-indentation on future addition to
> 	  the logical condition.
> Changes in v6:
> 	- Use contains enum instead of const

This should be v5. Krzysztof gave you his Reviewed-by: in v5, you should 
include his Reviewed-by: in this version.

Dinh

