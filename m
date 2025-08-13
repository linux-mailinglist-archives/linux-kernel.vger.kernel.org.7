Return-Path: <linux-kernel+bounces-766304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD32B244D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4D684BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6CA2F0C5F;
	Wed, 13 Aug 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFu5YI9m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16872D12E4;
	Wed, 13 Aug 2025 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075575; cv=none; b=k3C1Bao/csCHPwSnclbpbITUVj9LBPvZpq2xTAZdAAxuAtdkm7jhibmpc4Xh7e8tA5u+XlUxeBhmkVMDHa4JdOqlqVy/J0n4ys4fcgNMWtBe6fuqDcOhqhJgQfETgtJ9GkyOGikL3YnCUb+43m9Oh+7oc9VbJcVHZe90flSnwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075575; c=relaxed/simple;
	bh=XmgEE2r9/03Htllgcwpg18c5MfZ8FEI0JOAF6sFxxKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ0rR1QTzl3i4dsubBmb5jNAC1M9Aj4SsjpuBrPy1+cSEzlDTD2m9Epcl+6ZG/hvqFPF5GMu6zQtZj9XHGnaTJoskpzkEh2d1TtBVXDREWEI2jc5yRLE154VXaU1AugsbwgxpTFcVsN93WAARwcT8yrfPVoF1dGU9s790Ou3Ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFu5YI9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701F8C4CEEB;
	Wed, 13 Aug 2025 08:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755075575;
	bh=XmgEE2r9/03Htllgcwpg18c5MfZ8FEI0JOAF6sFxxKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EFu5YI9mwImluA2LuTvGgHPMWyR/bSWgPuEhbfBznuDalHg4kTg+x0roHajv5AHg4
	 D32HX/mrgpBryIOnX5aP/C+ChyZzzknuJrJlFWqhgFfUcmFpjHw1N3ZZ1UobJXGNMD
	 YpoxbqZ7vcYXwjGi2VlcV0eQqgN3pnMMgGgrkUL3tcY0ImqL5zpQ7w6XAz6wY6wGcJ
	 SF1yCyB4cBg3HrLdQLnlxB1yfLiiXg/rCEHS3z1YtA7YEWMeww9xARP4xkq1U/rb6q
	 lI4HTQdA6ERBEayxeYrD6XYWW19PCgC78Jkw1bxmtmxRib7oXl/5hasQVnsnTfJsZP
	 yD3XvXnlc8tsg==
Message-ID: <066729ba-bd9a-4328-a813-9ef73620020c@kernel.org>
Date: Wed, 13 Aug 2025 17:59:31 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs: admin-guide: Correct spelling mistake
To: Erick Karanja <karanja99erick@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Christoph Hellwig <hch@lst.de>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250813071837.668613-1-karanja99erick@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250813071837.668613-1-karanja99erick@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 16:18, Erick Karanja wrote:
> Fix spelling mistake directoy to directory
> 
> Reported-by: codespell
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

