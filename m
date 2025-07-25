Return-Path: <linux-kernel+bounces-745861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9584FB11FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A289D17B979
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01671F4CB6;
	Fri, 25 Jul 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO07Zdsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F510FD;
	Fri, 25 Jul 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452277; cv=none; b=ZzknTAj+RmoZm0P0t79H1m2DM+qT/PTr8crlxE1N/gw86BRwnTQZtlPbCJx3VnJiioNwaG34Z8BRCU87tOCyQbY7Q0oaJrwrU4mP+NO/Nmje4tpuLFkFIr3wZGe6+3JZODmW8ixiqGbagTRzNswPbb7vkIjXyJQIcV0zuJETeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452277; c=relaxed/simple;
	bh=hny5WhFij0Jp2laNX+g6PMM1MYWHFRk2ugCOMxF6+bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MheJx7K9DDelX0COI/4d6xhJvR2J9uDkEjijB/1xUGy18px7vPnu35CTHMm8vV0CDPkahoSaJHzyHXYdvhOVlSkug5HkuDBPc4p3VKxlDi5fmg3qG2qB1OgN5wPYuntdpcu5Ph8xmB2Wqu8vyasPXKiVfO1qmJOE/61kfaDfa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO07Zdsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D41C4CEE7;
	Fri, 25 Jul 2025 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753452277;
	bh=hny5WhFij0Jp2laNX+g6PMM1MYWHFRk2ugCOMxF6+bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QO07ZdspzEMRhl83JYPt8OdnMHrRSfP23YyjKoOBIDcJojDyJXjdwHTY4IzuMgA6F
	 zj/9h8Yy0B4C0mjhn5Nld6Q4sCA6C/17TyczKM51UAU9mudpt7kcgZ3CklcOlDNe8O
	 EtX4o/rrik5p2IgvaWe/eI9I8MJu4+ON23tMzmXDNxz+F9N8ErKOTF03MX/S+IRyhl
	 FtktPolZfb89K/dOZmgqjs899Tc/F8mPiDSxjVnKEVEehbtZ+w65pyfVyk7686GRGW
	 mPs9jyHoD3QlERDktVkAHjdMljK5Chpu1zlGVMcY4IiG5hYl6MQ9Jq+HVQY6qkD1w5
	 0MCgEfUXvoD6w==
Message-ID: <ab63103c-3b21-451e-b450-a1755b452d77@kernel.org>
Date: Fri, 25 Jul 2025 16:04:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: vbios: use offset_of in
 PmuLookupTableHeader::new
To: Alexandre Courbot <acourbot@nvidia.com>, Rhys Lloyd <krakow20@gmail.com>
Cc: rust-for-linux@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250718073633.194032-1-krakow20@gmail.com>
 <DBL6BUAHZ250.3UCFP2OB3UEIY@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DBL6BUAHZ250.3UCFP2OB3UEIY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/25 3:35 PM, Alexandre Courbot wrote:
> This chunk does not apply - on nova-next PmuLookupTableHeader does not
> seem to exist. I think I remember you split PmuLookupTableHeader in
> another patch, so can you send all the relevant patches as a series that
> applies cleanly on top of nova-next?

If otherwise the series is ready, please wait for -rc1 to be out, and rebase on
-rc1.

Thanks,
Danilo

