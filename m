Return-Path: <linux-kernel+bounces-724263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6D5AFF09C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DC41C85393
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586823958F;
	Wed,  9 Jul 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKretA3q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52026243379
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084604; cv=none; b=uhpiYZ4blit6vhSkd/TlIWjgfiqSFzoA7U8Dehj4pptih3Ub8UqvQAdt+8+FyvvI+aFOWQUBD9lGtALV5BDgTYKiAAMGu04PsdQEDrBDDej8UrbHFBZCq/VIs3XPn40czyyDUHUEdR1q51Z0vVNko/W3RIgdZTcZgQsIRqxFbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084604; c=relaxed/simple;
	bh=VPulh4P6ISLOw+0LS9hmPcv2Gf3kN/vqdjjmzU80hbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvUkeIbTDS4aemHyUBvUfiOP6BgpbxgxKYIvHjVenUn3oeFC7A5OpVLARCbxuX726x5y+WI6t09X1pJKI7DnimS9HrG8tKx9BUhOJtuHwmV3Kwj177+JDEHS7jFV6IQeSAlElr4yRTs7sTpA4Yp9gGruzKsf7z19aiej6dht1lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKretA3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E90C4CEEF;
	Wed,  9 Jul 2025 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084604;
	bh=VPulh4P6ISLOw+0LS9hmPcv2Gf3kN/vqdjjmzU80hbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKretA3qVgCzvvPFFissribziz+b9vNXf+no6dJtsc7lKvhZNjNqqhoWp/TFbXJGS
	 2qUtja0l6RxJgWqCdPwDRq8LhKhwf7Tj6vAaEqfsFKW2nvGFJv0lFUjpMC/8KCAo8n
	 YozBBZIGK1XIwuk9ktONfk8035ZICt1gP3zbR80ddzkGoAQwMqS5Z3UrES3ZH5AaJU
	 2ZwI2qbzSxLjc6jcwHH57QE5YNvzD0HHbnI0YIW6LVmfQoWTNibU1iLeJhMmYpLapF
	 pM0DEdh3ZzAPd6bRlfEOI87Ppavxu8wcghSEKxsJToQL84At+ptV+EyZPAKq6Wut5v
	 cEGW8aBtvEBSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB48B380DBEE;
	Wed,  9 Jul 2025 18:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to check upper boundary for
 gc_valid_thresh_ratio
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208462650.806926.161695644855019722.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:26 +0000
References: <20250627023818.146534-1-chao@kernel.org>
In-Reply-To: <20250627023818.146534-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 27 Jun 2025 10:38:17 +0800 you wrote:
> This patch adds missing upper boundary check while setting
> gc_valid_thresh_ratio via sysfs.
> 
> Fixes: e791d00bd06c ("f2fs: add valid block ratio not to do excessive GC for one time GC")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to check upper boundary for gc_valid_thresh_ratio
    https://git.kernel.org/jaegeuk/f2fs/c/7a96d1d73ce9
  - [f2fs-dev,2/2] f2fs: fix to check upper boundary for gc_no_zoned_gc_percent
    https://git.kernel.org/jaegeuk/f2fs/c/a919ae794ad2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



