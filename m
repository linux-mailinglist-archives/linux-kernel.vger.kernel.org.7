Return-Path: <linux-kernel+bounces-771192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B197B28400
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DC2AE87AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8A30EF70;
	Fri, 15 Aug 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIPNUljs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5A30EF62
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276002; cv=none; b=WcFCH8/b80jTL5OWprXsREtucL8lDugFdYj2tmdOird9VWLUXczCzHg+Op8kjLV2RdAaSTOQyRXKVsULaau5Nrn0vp/BbmbKY9ddDfB8m+9pExtUdLDL3FWESS3xq9RfI8UqlrMiGu1IrMRfyOnx6z9yTzExRG8sibrEbCbUomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276002; c=relaxed/simple;
	bh=43pPEENNXF3rrozebD8tpAprb8WYEupLBf5ph8opWWg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VL0BwQ0l59G6xQQzC0Ms6kq3zkJYirHpOfSXE/lD7IwVDuHriQ45NfIpKY4tJDAsinxvAYUyQcKR6aeDjiPt1PFf4aM3j9aN7ECcbTLXMmbzdc8l5qUwIzCkAGNc2XwakHlyMXpLSjl1xZ2cSbCgRpAUdCVwedxB+bXOBNa0U+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIPNUljs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C741C4CEEB;
	Fri, 15 Aug 2025 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276001;
	bh=43pPEENNXF3rrozebD8tpAprb8WYEupLBf5ph8opWWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SIPNUljsKH1bCp/QlnjtpndZH6dEgSkv50GyKZx+Ou+gZrOdIo2yUYWGbEY4UwvIu
	 SkSEr58RHet+qHyD2auMBdRqwLbyxnFuaD43LezU7w7m/rt7AYlyRhNKLtgg3xAKFE
	 n9u2J95ekvkqsE3r66Kv31tyGJZc0GyVfTzCsI+YKLC9Izl9IYA+wcles0ON02nuL3
	 TCcG9/ki3/BUSIt9l/09IxpJYuIgnyOfHgH9KLbLjMfzsUjK7hw+QfqqXdxQOD+5Nv
	 xp4JpvTqWWK2y58lP3CrN54dRU5yQC6sGYZ9jrlFWkVys3fpZuY1retttW2Vyw8+3w
	 GAPSaTM3HbZEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB6F39D0C3D;
	Fri, 15 Aug 2025 16:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add timeout in
 f2fs_enable_checkpoint()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527601249.1161945.287054981363094697.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:12 +0000
References: <20250807040026.3834543-1-chao@kernel.org>
In-Reply-To: <20250807040026.3834543-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  7 Aug 2025 12:00:25 +0800 you wrote:
> During f2fs_enable_checkpoint() in remount(), if we flush a large
> amount of dirty pages into slow device, it may take long time which
> will block write IO, let's add a timeout machanism during dirty
> pages flush to avoid long time block in f2fs_enable_checkpoint().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: add timeout in f2fs_enable_checkpoint()
    https://git.kernel.org/jaegeuk/f2fs/c/da63f609094d
  - [f2fs-dev,2/2] f2fs: dump more information for f2fs_{enable, disable}_checkpoint()
    https://git.kernel.org/jaegeuk/f2fs/c/347ff7d828c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



