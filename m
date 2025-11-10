Return-Path: <linux-kernel+bounces-892808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8AEC45DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7753A4AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286B225409;
	Mon, 10 Nov 2025 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRK2nL+s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC221D3F4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769718; cv=none; b=coSx7cwIizEVJ/jJ7c4XW2wwYtgk8X6je9O46zW6j8nICUC2EL0bRn9NMpUzJ+VHXJs+I7X7es0EHzuO2spzw9WyQQ4oXar48+ciXtu5+Q60uMsjZnlMAFIVu9UYwlCwk/AfMRrPC9OZXbMxDcrIndg8UGThLcW+Vh320+kOa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769718; c=relaxed/simple;
	bh=/rtTEMCWlk5a9mHq0PRXNCsvExHLysVcX2D+JNGWi6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AFJM3MrBYvXKtXEulQq+9H5suRktJTiTDXlpeq2M45qdSFQNR+0buD494MExUG22DK9q5o3+WcnvM6P0SAGQI/l4t/4iyKL+FlFXOUDKNqCVycPfKWcqjkChzIzHs3TtPEHcNZa+3NHuHUrPae17psDQtvPgsETggLpJ4NwCfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRK2nL+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3005BC4CEF5;
	Mon, 10 Nov 2025 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762769716;
	bh=/rtTEMCWlk5a9mHq0PRXNCsvExHLysVcX2D+JNGWi6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LRK2nL+sXLhkBD5L1oOcawpqfQkg+qf/gaqim7gWBUysH1RbXL8O+IebMn5b7+b4A
	 /K908yhfwXYKVT/OcA6DqQaxyy65lzNN7osZVyuhZTncZb2EOHijvQysm9Rjzz5S3M
	 nLK8ImCmQyBLrJO73jQukZFj5m4tJwvf3jmK3xlvLwl1NR1EgP6WsmWWL1bFeUxqZq
	 qzzDEbPZmEZvAgfPhpQhPdbIjyEqsA0OWbV5Rqyhh/n1OjN8tL5QbI1ckxb6AJl+A0
	 rCGD9DlgZy1W1Fp44KM+vpy6QdE8i3IRawthtMgqlUIEFA4RfGr9fpSjUC10Z3ZRfh
	 dXmebYFDMrp8g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Takahiro Kuwano <tkuw584924@gmail.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Michael Walle <mwalle@kernel.org>,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 0/3] mtd: spi-nor: spansion: Add SMPT fixup for S25FS-S
In-Reply-To: <e46094b8-911d-4838-8be0-1a085e04685f@gmail.com> (Takahiro
	Kuwano's message of "Sat, 8 Nov 2025 11:07:46 +0900")
References: <20251105-s25fs-s-smpt-fixup-v2-0-c0fbd0f05ce7@infineon.com>
	<mafs04ir5bynq.fsf@kernel.org>
	<e46094b8-911d-4838-8be0-1a085e04685f@gmail.com>
Date: Mon, 10 Nov 2025 11:15:13 +0100
Message-ID: <mafs0zf8u9osu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 08 2025, Takahiro Kuwano wrote:

> Hi Pratyush,
>
> On 11/8/2025 1:22 AM, Pratyush Yadav wrote:
>> Hi Takahiro,
>> 
>> On Wed, Nov 05 2025, Takahiro Kuwano wrote:
>> 
>>> Suggest new series as the result of discussion in the thread:
>>> https://patchwork.ozlabs.org/project/linux-mtd/patch/20240914220859.128540-1-marek.vasut+renesas@mailbox.org/
>>>
>>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> 
>> Checkpatch complains on all 3 patches:
>> 
>> WARNING: From:/Signed-off-by: email address mismatch: 'From: Takahiro Kuwano <tkuw584924@gmail.com>' != 'Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>'
>> 
>> Take a look at why your git-send-email didn't add the extra "From:" in the patch?
>> 
> Thanks for pointing out. I used 'b4 send' that time.
> I will check the settings.
>
>> For this patch series, is it okay if I change the author name to
>> Takahiro Kuwano <Takahiro.Kuwano@infineon.com> on all patches?
>> 
> Yes, please.

Applied to spi-nor/next with the author changed. Thanks!

-- 
Regards,
Pratyush Yadav

