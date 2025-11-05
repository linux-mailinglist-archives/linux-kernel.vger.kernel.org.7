Return-Path: <linux-kernel+bounces-886468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2BBC35B12
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2EFF4EE793
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3561313284;
	Wed,  5 Nov 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKVh3K5e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BE2FCC02
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346762; cv=none; b=c5NMpZxtm6PTnnseYqMP+za8wmlhMXjZnQ6l3VAIZvEqChqgQahc4bU72vz7/HhqWE7WCvjT9UH1fiUnT7pSL2LhtjGl2yYT1LrrHYC5jXb6rh2qmD68E6of4Pb82dsgDbuFdwnQQiv7B7eowSkqMAlCAXWsRqEqwwOjSIwQFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346762; c=relaxed/simple;
	bh=T0CQ54S8AvRXVFvwznykPHWI9YH1Z4uZ05kU9Er3Yag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPApjg4k+0XiQzqvGOzTje61tYvTEnlWTIxUwOwhRd8tJXKsDOonGexIdAM+1rhkv9kYKvj/TGrh0NtWeBcCZdcUgTRMQ2Zn6qq9Lf1WHczh1Ap3dJ47vNnXO5/33tXm8f2N9TSylHisxrWa44suqdbKfNZw/kd5jxBEpxX8gMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKVh3K5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EFCC4CEF8;
	Wed,  5 Nov 2025 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762346760;
	bh=T0CQ54S8AvRXVFvwznykPHWI9YH1Z4uZ05kU9Er3Yag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKVh3K5eTtDSwidztcGuRpLmSF3iSGSQoV5gfyaZHeQwGc1V0lN69ZpOV6QMRnh+m
	 pB92v9ZnLTwjqgOvfs74LeuAmpwArsdSf8OiEuFjj8+ddpOyloayS2eaqsPsYWV9Bt
	 xfNUd/o5Iewa0Mvs2AsTZyXP/qKpzOc2Z42GproVfjFPaUBCqQ5nxKoLIulvryTAqr
	 Cphg81tA4UWzkmV8AbVu9GnRGasAkMgw27ds+AHzUI+zzMq/KhYg+FJlrqBxPLqORl
	 3mzwedXr2LHKpgjJ9F3nVh5cYDVoWDupJgv/xeyflitvaoyqqomLb+pwdc6592nk2z
	 Kl8Zd2nfkereg==
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH 0/3] Fix two syzbot corruption bugs in minix filesystem
Date: Wed,  5 Nov 2025 13:45:54 +0100
Message-ID: <20251105-postfach-ortung-24f951c72583@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104143005.3283980-1-jkoolstra@xs4all.nl>
References: <20251104143005.3283980-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=brauner@kernel.org; h=from:subject:message-id; bh=T0CQ54S8AvRXVFvwznykPHWI9YH1Z4uZ05kU9Er3Yag=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyuzNfdT35b928v3JsZ0Wub25PkbV2n1R62Uft07Gm7 GW/557m7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiImALD/wKGal9HgaVOvbbe Bfcj6id0/1Hr4C3N/vjvl6yZX4iIJcP/oKb3Ws9Xqu/kU72lbPnP++tTRVc/cyVt08O9qsu96j7 wAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Nov 2025 15:30:02 +0100, Jori Koolstra wrote:
> Syzbot fuzzes /fs by trying to mount and manipulate deliberately
> corrupted filesystems. This should not lead to BUG_ONs and WARN_ONs for
> easy to detect corruptions. This series adds code to be able to report
> such corruptions and fixes two syzbot bugs on this kind.
> 
> Jori Koolstra (3):
>   Add error handling to minix filesystem for inode corruption detection
>   Fix a drop_nlink warning in minix_rmdir
>   Fix a drop_nlink warning in minix_rename
> 
> [...]

Applied to the vfs-6.19.minix branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.minix branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.minix

[1/3] Add error handling to minix filesystem for inode corruption detection
      https://git.kernel.org/vfs/vfs/c/21215ce7a95a
[2/3] Fix a drop_nlink warning in minix_rmdir
      https://git.kernel.org/vfs/vfs/c/d3e0e8661ceb
[3/3] Fix a drop_nlink warning in minix_rename
      https://git.kernel.org/vfs/vfs/c/009a2ba40303

