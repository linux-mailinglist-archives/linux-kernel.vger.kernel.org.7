Return-Path: <linux-kernel+bounces-896271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893CCC50035
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C035189AB68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B6C2F3C39;
	Tue, 11 Nov 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtypXIUl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1A2F39BD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901446; cv=none; b=Ffkj6x5e8DTAM2geuswWL95dpX1N8dmhB9efD4VtS+sy+SSssoKfZoA4lX4vsfPFU04b9j5zj86p1ONtZJnDkaVnNDXkAwrpaCp4K1a+MIqjdzYR03Ms97jQo3LC2wiT3yZTT/JcLBZ5BukUm23D08dIyRnjnm0YerHJNnfkKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901446; c=relaxed/simple;
	bh=PkQeE10i+YBFZ5WiZA1VI2jsBQK9p0pMKxURzlyc4Uw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c7K4lttk+ly6rYqAyDPzSpP3R/1Ay2Q1jerZ0vwdGWJsb27bi6urHu9fZBVyWvov/s8DxYqSh3/ubVcmfWOHQnRcr8v7yUiFFjcmJuN4fGSzoF7EF+h2Ti+Mbcsl/Oq3tRfhUFDYYTp++Alblh3eQG0lZcameUbXbFZvpN5kyLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtypXIUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27013C113D0;
	Tue, 11 Nov 2025 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901446;
	bh=PkQeE10i+YBFZ5WiZA1VI2jsBQK9p0pMKxURzlyc4Uw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VtypXIUlEPgpYS6yiwAUuJlv7yEVbVRjo2q9CaXWnwUX4Rkb91+eM6Z+BPVYAZGe+
	 VxL4SqfoK4GvsL7jW5fYUTywlZO2pekimSugWZBk66xM4NvzYES0zPcgjOsTCzHe2q
	 oVEnf1h8yru/fFkFAtxBoDnYH+KY56lm32WTHqJmpe6h0KRfnJF9XDApHLCn/ksuOK
	 4ajJKdRSClOKArcbKc/edymzUvfuq3ZWDkwjMsrGOtLINHoaamO2OinG90JipdpqxM
	 rsxez6vgn59nI/CwhP1eKQS6SpNqQ2GHuQijprF6ZjrH3LLOICAGE2vqQXPJJRbyhL
	 IqrZ7x5p94YPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D8E380DBCD;
	Tue, 11 Nov 2025 22:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to do sanity check on node folio
 during its writeback
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290141623.3596344.10698680340121924794.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:16 +0000
References: <20251011123016.715964-1-chao@kernel.org>
In-Reply-To: <20251011123016.715964-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 11 Oct 2025 20:30:15 +0800 you wrote:
> Add more sanity check on node folio during its writeback, if node footer
> indicates it is an inode:
> - i_mode should be consistent w/ inode
> - ofs_of_node should be consistent w/ non-xattr node
> 
> In addition, if sanity check fails, let's shutdown filesystem to avoid
> looping to redirty and writeback it.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to do sanity check on node folio during its writeback
    https://git.kernel.org/jaegeuk/f2fs/c/b63e02895b26
  - [f2fs-dev,2/2] f2fs: fix to do sanity check on node footer in {read, write}_end_io
    https://git.kernel.org/jaegeuk/f2fs/c/3bae3cbbf1a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



