Return-Path: <linux-kernel+bounces-729978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD82B03E87
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39971164699
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6E2459F7;
	Mon, 14 Jul 2025 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDEGXAoF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22071805E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495754; cv=none; b=BroJnB5xBvgDD36ZltjWJSBBHKRhGfxyPFYaG3ic7+qiq4Iac3TBY8Ek/ZTX1shOFVEZdWMRM8gmvbU4uclaROo7+Up+Zr9zzslrSU2S9PX+qEjF7cn4Dw4/BEOWRJXwIso6xER3P4Ch+zokRA463d+rb5sk5m8jNgybyMnG7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495754; c=relaxed/simple;
	bh=2MvVkNSYuM/tNp1ndxOd9pmIvo7FkNREWuauK9wyB28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1kbV95SwQhmLpAE9Lnw3LHof2oKTmZdPP7mweHPWTFiEyRwYcnF1o1BHfDDpeay39HgoUVYMcCKzju2UHBkogwQ09xJ7DuzRWMQXQt4BBTi+Vob/4f9UIC99o4Z1AwDVCs4KauH/pxG/MiMgrJN08wwQVZWmidORuX3ohl3T3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDEGXAoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1E4C4CEED;
	Mon, 14 Jul 2025 12:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752495754;
	bh=2MvVkNSYuM/tNp1ndxOd9pmIvo7FkNREWuauK9wyB28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDEGXAoFtJ6B+ufQImkKYoHr15V2+A7cysa+I8fco7pD0NpnkQH1QcGd6dUL1X8Uf
	 cYoDmq6gzINUWVoaOe0JajgWEEcsjD1Ju1b0O86tv0bMcN/VOKdPCCaBIUjjR+h5yD
	 +ERpz85a6w1wz76S1ow7haegFAdiy/yFjRqP6D9Cxl11kb7rWGnIisINgvET3KMTnT
	 2wMwlc9dGn9VREyt8gKihQjJtmCQor0jII3WKgtE8gUlcqxanE9PVNkMWtuIgS5g6m
	 K9zYxi3d4ZYqgGhRYNl6u4g3q1cav9fxbOPy3w+ToA1XhNe8HceIJgqCBfSLZEoxvz
	 gxAKkY8kdYcBg==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Joel Savitz <jsavitz@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/3] kernel/nsproxy: Minor nsproxy code simplification
Date: Mon, 14 Jul 2025 14:22:26 +0200
Message-ID: <20250714-tresen-konfus-c8ec5f3b6f9e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250530200305.85319-2-jsavitz@redhat.com>
References: <20250530200305.85319-2-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=brauner@kernel.org; h=from:subject:message-id; bh=2MvVkNSYuM/tNp1ndxOd9pmIvo7FkNREWuauK9wyB28=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUfGszi1zwNSPTknd750QG15Ps4nzPU/iN3pc+9LwSr LrgPSNLRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ0ShkZrhgd1AkK+Ha+Kjve 5srBpM4Py6ad+f2xaIbTmdiFkYwZVgz/TD5xL4m2fPa8ri8lVP+UTKXJmYvFaoLdqyb7J/xJFtf nBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 30 May 2025 16:03:03 -0400, Joel Savitz wrote:
> The first patch removes an unnecessary guard by the same logic as
> commit 5caa2d89b7f1 ("kernel/nsproxy: remove unnecessary guards").
> 
> The second patch fixes the total ordering of resource acquisition
> in validate_nsset().
> 
> The third patch implements usage of the cleanup helper added by commit
> d057c108155a ("nsproxy: add a cleanup helper for nsproxy").
> 
> [...]

Applied to the kernel-6.17.nsproxy branch of the vfs/vfs.git tree.
Patches in the kernel-6.17.nsproxy branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: kernel-6.17.nsproxy

[1/3] kernel/nsproxy: remove unnecessary guard in validate_nsset()
      https://git.kernel.org/vfs/vfs/c/e07195e0a5c3
[2/3] kernel/nsproxy: fix put_*() call ordering in validate_nsset()
      https://git.kernel.org/vfs/vfs/c/17e48a8cfd75
[3/3] kernel/nsproxy: utilize cleanup helper for nsproxy references
      https://git.kernel.org/vfs/vfs/c/04555045c014

