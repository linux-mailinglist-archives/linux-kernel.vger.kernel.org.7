Return-Path: <linux-kernel+bounces-891613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA64C4315A
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC54F144A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EFA24418F;
	Sat,  8 Nov 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnrstxGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D1240611
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622148; cv=none; b=Dd9aq/84TkeGSuQbVBZ3LGC3Qgo3gRQGtNolK0hru5Z3AgoMnFny7IobhqD8TGaWR7/SOiCnYa3Jqtn+CPG9GqNop8LkZmwslwe1QWJjHyeyyHJK89CgKgfyWjl+DmXFZtMLEbYyJZIEmBwp9VIVxVxpjruLTx+zASFLJPUe3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622148; c=relaxed/simple;
	bh=6R4JRRX2sNG0fEEsddH8VtNLqKzWjWGOor3qIIwN014=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rLFva2IWvdipNm+INNntml7qNUYiB5nywSlA7GXfAa8IScXGQat+J3alRCoIGci5cnKxtg4YN76EtFbXuPCcRDGP0fdNRuvujOvUFqERQVmf4rX5SPff9JkI4y+2HzK/tJs5Drq4dXlFrTvg4XiI6z8Q7F47IY72YS6gv3v0qEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnrstxGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2327C4CEF5;
	Sat,  8 Nov 2025 17:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762622148;
	bh=6R4JRRX2sNG0fEEsddH8VtNLqKzWjWGOor3qIIwN014=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bnrstxGUhrfJ5Lq0fDfJX39vJOsBjlp93M8bEASYoOJXKhtLACO4P0gCmuUFqChe6
	 P95BgnyNbAJqkmd5ifQkgIIEk/tOuA0iHdk485E1o9pMGy7qXmQt6RKTQIUvayzx/G
	 1jZ0+YW8ow3V/v8dphvajBmGWdddIAuUc8TlBnlMnliw4y5ZdNIjOeLxgd+hylw4pr
	 lsN+Vvil84IulqyUp4wuiaj3ssiuZqJ8a6L8dkGy/ldXCo2HrG/zMHJr1Cbf4c3rFG
	 PCUHAwCYUkVNJKsaGMZohr3XhSFJWmeygvlH298P7CAnWkp04VOQ7xncXvpmMFcLIQ
	 iMPyiSHuvfmWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACFE3A40FD5;
	Sat,  8 Nov 2025 17:15:20 +0000 (UTC)
Subject: Re: [GIT PULL] locking fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQ8_0mAj3AUGgguL@gmail.com>
References: <aQ8_0mAj3AUGgguL@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQ8_0mAj3AUGgguL@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-11-08
X-PR-Tracked-Commit-Id: 4cb5ac2626b5704ed712ac1d46b9d89fdfc12c5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6f55fe790a698aba6f98bf6ae4f1c04246c5040
Message-Id: <176262211963.1365123.3174479621096225771.pr-tracker-bot@kernel.org>
Date: Sat, 08 Nov 2025 17:15:19 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Nov 2025 14:04:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6f55fe790a698aba6f98bf6ae4f1c04246c5040

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

