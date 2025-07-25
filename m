Return-Path: <linux-kernel+bounces-745178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5FCB1161C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008981CC6EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F41EDA1A;
	Fri, 25 Jul 2025 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWeou7zq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A410E4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408671; cv=none; b=nBU8Xzo3pGPLDKfVs9eu+roa3NIaOefsBKhMIJ5tLPEpuKxWr85BbREdjAA2KVVHXa7rEUUcKLOszTse6d9PJ+ZhHYxP5fbyVkfh5+N+EHth9vTKHTL+qkQyNDoDMZMm2hG1SL3HRUmgjH0LYjUB/0OmF1Ftyn8GNAaCM8ks/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408671; c=relaxed/simple;
	bh=OXEGSolN6hWAZmpwucLokUEPFVf6sVZ8bKkWun3/kJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eD/qH4V/UdOT0nw5Y5YEMoVi26g+0ugumADs/sHmdwB7GmP0aYuMOdLQ08pPaCnyCeGKFEIspl3ZqD10onByb4P+CG5g3SPg3gtjm1RApeDiYjDmFQ30NYPHgcbFqNFgvps2sVAWVfMyQfB9R53omD2smYfhSi7QlcE0vy5JqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWeou7zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD80C4CEED;
	Fri, 25 Jul 2025 01:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753408670;
	bh=OXEGSolN6hWAZmpwucLokUEPFVf6sVZ8bKkWun3/kJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BWeou7zqPx6Z7PvCD94cqSc4ollYNooFEmkRIJ6t8rUqcaJzEQdvkNwAT5VsQbe7z
	 1hIkg3pZoLUlgH8gJZPc6ziLZEl8+kPYT2IOAtPuU3EUaqGHlaOjuvf2vfaXzbKQ1x
	 yBUbBYD0H6xqbjJYb0HJL4fDfhrYaxCe8ZBFurexpxh9wUtTz8WzAlmGTaaDMomWlW
	 LnDoSm22OQGJqapg7R0NCVAofpYIF28SaA8ES1rzcRylg7eERIIr+zEZxvOv6kEPS0
	 PVYDEYpUeQazs45YMmeHEzhhadAOpg1XOqiROQSgd8QBqnj7Si4UH7t5xB5RCX1UBu
	 efNHJoYy+EQ7g==
Message-ID: <1f447780-09a2-4f97-a17d-5489ebd4da5f@kernel.org>
Date: Fri, 25 Jul 2025 10:57:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/nvme/host/pci: Fix the asynchronous detection
 issue of nvme devices
To: Bart Van Assche <bvanassche@acm.org>, likunyu10 <likunyu10@163.com>,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 likunyu15 <likunyu15@jd.com>
References: <20250720185154.138391-1-likunyu10@163.com>
 <58c289ef-770b-4524-b38d-ebdb51ccc8f4@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <58c289ef-770b-4524-b38d-ebdb51ccc8f4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/25 01:07, Bart Van Assche wrote:
> On 7/20/25 11:51 AM, likunyu10 wrote:
>> PROBE_PREFER_ASYNCHRONOUS asynchronous detection has a significant impact
>> on important devices. For example, if a server has two or more nvme disk
>> devices, it can cause disk loading disorder, which can also have a
>> certain impact on actual production environments.
> 
> That's intentional. Please fix your user space code that uses hard-coded
> NVMe block device names or introduce a mechanism in user space for block
> devices that is similar to the predictable network interface names
> mechanism. See also https://systemd.io/PREDICTABLE_INTERFACE_NAMES/.

Userspace can use /dev/disk/by-id or any of the other /dev/disk/by-* for
reliable device names. Using directly /dev/sd* or /dev/nvme* is bad userspace
practice.

Even without asynchronous device scan, adding or removing a device to a system
can change device file names. The symlinks in /dev/disk/by-id are stable and
will exist as long as a device is present.


-- 
Damien Le Moal
Western Digital Research

