Return-Path: <linux-kernel+bounces-731284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACF5B05231
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57CE7B26F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746D26CE14;
	Tue, 15 Jul 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj2czy5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F5180B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562384; cv=none; b=CwNiDjx6vG1rSxM93Ovu6oBwQkcREPJTsRNkmpIEzo4zDyndaeL653KAYZejkpccB9jcu/WGax+t2yL9EiGlEJcBEzBBCHEPLuEEDS8vAtcYwIuJ91QBbUCJvurR+Vcpk0e0ddyDe+2VNqrReJe4vM4YUr1rR43IfvPM+5vS0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562384; c=relaxed/simple;
	bh=gctr3UrrZmHgV9GHXNCIpomEZVRjbpV9dPhmuF19aVk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QywsIe7ooI8t2oA4iSJ7OJyUNi5KrrA5iYDOzEiPIVO7X+VKyxXNTte26I2O480+q1mxnGJtHvaEbcp/d/Q/d4gViIEcQ3sSZJ82+PHkkVSbpRk9ArrsAEybU3eH+zvorBWYNppmCBxdoyAbX+6MD5W6OGJhkUavtFA0vYoTPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj2czy5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A62C4CEE3;
	Tue, 15 Jul 2025 06:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752562383;
	bh=gctr3UrrZmHgV9GHXNCIpomEZVRjbpV9dPhmuF19aVk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Hj2czy5GCGio5UT1hG42ewYMU/KLvtTssahBpdxXWoOiKxfX2K3zLpLRv9H3mFlZF
	 e0IWn4y/sn98HpemFMnaDh9g82DePoZ7ltfgdcRNvRd+2+47JSNlz7USxEdT7uk3oB
	 tpn9fcAllaNJHvzKUgusxnASC3xOuPfIZiixyWAbXY44YyL7X/WB3DEkpw1hv4O+kx
	 CQO5wt+goiilMybXlUd9Kz3m4bAnLaaSkVr9OOBGfE+s+fSwoxXprjyIEaOV7BswVa
	 2eDfRaSuqoVlqyjm1r7IHldTppGTRyxQVCYEwbD4ORp4ik35NoJ9c8c0nWLbyOaBwK
	 3FgZu+Ne382Gw==
Message-ID: <5982c766-5170-4d0d-b49b-8f1adf6f506a@kernel.org>
Date: Tue, 15 Jul 2025 14:52:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH] mkfs.f2fs: adjust zone alignment check to correct
 position
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1752486705-9498-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1752486705-9498-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 17:51, Zhiguo Niu wrote:
> Should check these after c.devices[1].start_blkaddr is assigned
> when c.ndevs > 1.
> 
> Fixes: 316e128fe3dc ("mkfs.f2fs: adjust zone alignment when using multi-partitions")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

