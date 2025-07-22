Return-Path: <linux-kernel+bounces-740763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8D4B0D8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E762543944
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E02E3384;
	Tue, 22 Jul 2025 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJRQPUQy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1C23ED63;
	Tue, 22 Jul 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185844; cv=none; b=kGxwspdNNFjj3JqmMQQSjWT8OmpbwNekoZTgeTUllKccGqOdmk2mkz/15CzXx2zIAMRcEc/SsXTkqr7oXFn8ZajBGmnH2xunz8YkYFhKUc1MohS/N0qscbO82uWFltYWsXGtJn9z1dHM4gFzuByzS8iD7acUzIEkTOdns1UY8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185844; c=relaxed/simple;
	bh=VRW4Q39IN9B81DzSm4+Kq3xY4KocEOVF/7Rdp7UYXvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R3oowMJqh+pct8xH4062q4GEakOL2ULw0ykv5zmqenxerw+MvdyNQUfVV/Y/pGvr386xzlXsqhYMRYmPx1dEGVrgmogCPwKjXyVOexy+beiYnsLTYhPTjNlwt5z1UWJySXrOvg37TMVfOovV0c/2O/fUf+ZUkqT6PziVqLfrVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJRQPUQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BD1C4CEEB;
	Tue, 22 Jul 2025 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753185844;
	bh=VRW4Q39IN9B81DzSm4+Kq3xY4KocEOVF/7Rdp7UYXvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YJRQPUQynEpHnwc4W3vQBvC8WPgcrJcJJVXfkIRUt2ade8P9QOJQ8wZ46iX3sBxo4
	 m3x8qJY3PWnXmd20b4FG5cr9NYcRPYtODHKLHJH7I3GYGB5YzZZqrwJLM/MTTY+h7k
	 gfhM9f6wsKxRj1DMBCcV0+WOsu7+17PFbjUhkqgiimXVu4PdWrmMDM17vrYc63Xb1h
	 SwSrotKlWE/9qXcWJkAxJZC6z8QVCBDXPXnABkDaDIdMgYKfolMrc4nj+SX1fW3AbC
	 /XlM3osyQCKdncdKH64gOoByvrK74WRMqrBtqoIxfRNDwXlWvh4wEU72KRyEc0+cju
	 FGt/kVVBCQo4Q==
From: Vinod Koul <vkoul@kernel.org>
To: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 sanyog.r.kale@intel.com, Suresh K C <suresh.k.chandrappa@gmail.com>
Cc: shuah@kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250712044302.6952-1-suresh.k.chandrappa@gmail.com>
References: <20250712044302.6952-1-suresh.k.chandrappa@gmail.com>
Subject: Re: [PATCH] soundwire: replace scnprintf() with sysfs_emit() for
 sysfs consistency
Message-Id: <175318584210.92576.11558048141084137155.b4-ty@kernel.org>
Date: Tue, 22 Jul 2025 17:34:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 12 Jul 2025 10:13:02 +0530, Suresh K C wrote:
> Replace scnprintf() with sysfs_emit() or sysfs_emit_at() in SoundWire driver files
> to align with the guidelines outlined in Documentation/filesystems/sysfs.rst.
> 
> This change improves the safety and correctness of sysfs attribute handling,
> ensures consistency across the kernel codebase, and simplifies future maintenance.
> 
> Tested by enabling CONFIG_DEBUG_FS and confirming that /sys/kernel/debug/soundwire is correctly populated
> 
> [...]

Applied, thanks!

[1/1] soundwire: replace scnprintf() with sysfs_emit() for sysfs consistency
      commit: 35323d8ab811cc8a02dc9ae9f60fb22acecb6d59

Best regards,
-- 
~Vinod



