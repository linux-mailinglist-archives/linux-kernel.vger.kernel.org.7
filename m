Return-Path: <linux-kernel+bounces-896276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD84C50056
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD34B4F55ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C572EC090;
	Tue, 11 Nov 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYscEzPv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B052F99B5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901453; cv=none; b=E1u/VrHi4rf9HS6khmRDCwlFcoTkWnQnW6Y8/UPOvUCWwopBIVnL9yYx1iVrVetTlP0z92FBiDOFEKMA0sQclpEh7HMDo/uKuaQJ7/CQvF/YZX7/1g2ETcxlFpHBZ5hWE0pvvvDwWQLyvYCN0VeXVORAEyCMikU7opcMoGnTNyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901453; c=relaxed/simple;
	bh=pnYPgV1/kV0KNl2wqSooNI4BldWEB/mQ+fVGd1Z+pwc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j3/zEIbZJQkM32l59nYjNWvBzuP2ydAgrkKEssL/oUxCA4KD8dj+q/JYLfijIHET1cSTeON3xIorsDzIfP026xcW5jihVfZIaPh0ZTiycWR1IqogjxnZ3G6haE/CWxrxkNB7hx9oCki6R98NTnJaRBTjwpgNWtOUwHRe0MzpHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYscEzPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB9FC113D0;
	Tue, 11 Nov 2025 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901453;
	bh=pnYPgV1/kV0KNl2wqSooNI4BldWEB/mQ+fVGd1Z+pwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VYscEzPvG9y+04A1wO6HrUv/TkufhJXBvfcN5mnQ0t0xkf08ulS9RRuNXTh+6OMZj
	 LNC+uGlf7r+cKwcTK6orQlO1UN0/vdjRnaegQPuCC6vncmUFU8iKpTickky4QAlZMA
	 BP/TkJy0Y8XZh8wiGjlW1zM4febmOCEKSB4V8BIDN8HqaV/lTd1k+kWpmaS9pxjOsQ
	 45BdVeo78b5GtS6y9LfmZL2U4lUzGYDGY1UbMwiXlDohhP3Je24WpsrJpoyUcXDnLI
	 JRkc1BjFvEdkQrK86NL+f/IqfoKujp27b1nCW1BMU+hVCq0YVMZtGLK5OyCBFXMB9D
	 m6NeT8Tbgl5yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EE4380DBCD;
	Tue, 11 Nov 2025 22:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4 0/2] f2fs: Add sanity checks before
 unlinking
 and loading inodes
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290142299.3596344.2753827119628915512.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:22 +0000
References: <cover.1762339963.git.zlatistiv@gmail.com>
In-Reply-To: <cover.1762339963.git.zlatistiv@gmail.com>
To: Nikola Z. Ivanov <zlatistiv@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, david.hunter.linux@gmail.com,
 linux-kernel@vger.kernel.org, khalid@kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org, stable@kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Nov 2025 13:09:41 +0200 you wrote:
> This series is provoked by syzbot warnings caused by corrupted directory
> inode with i_nlink == 1 that passes the initial sanity check which will
> only mark the filesystem as corrupted in case i_nlink == 0.
> 
> Tests:
> - fio/fsmark parallel create/unlink on VM with f2fs root filesystem.
> - syzbot
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,1/2] f2fs: Rename f2fs_unlink exit label
    https://git.kernel.org/jaegeuk/f2fs/c/7b4827ce2d2a
  - [f2fs-dev,v4,2/2] f2fs: Add sanity checks before unlinking and loading inodes
    https://git.kernel.org/jaegeuk/f2fs/c/d43f8de77d6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



