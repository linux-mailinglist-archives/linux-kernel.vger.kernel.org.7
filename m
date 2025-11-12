Return-Path: <linux-kernel+bounces-897098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE858C520AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0F8F4FFB50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816182727FC;
	Wed, 12 Nov 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efjNVZSw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE9304962
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946692; cv=none; b=eCQ73JD+39k+n3mOkp90gXVuJV4km3vVnNfWeieORFaSqjwfAtT71likQnjEAPAT+hUCmnwzdwWR0itzzROV9tpRGHHA6Qe3ioBIwbKNrDDU8VQYZKFjLp7zaFa+q82VhRik8EOuRCE0oKA3j0HLKaobm7KF2U6VK91/LtD+n14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946692; c=relaxed/simple;
	bh=r+d6AygQ3JhDlIlZ/DiHSaguhg2aTGerfLns5gDNv7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7UPYYXSLr8kZ86t6j5KSAVamU8Vl88V/eqlM8ljOLJgLexU0Fib7Fc0wp1lny/d9t0U3iUy8k/01t4EljKdV3FsQhZhEeUFokmev5DBASVzeXsiA5EMy/obCW44WmBrfu2rH3MYyMBdBh1SgXw3UskWlFEzNLOpzLu8BG4+JKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efjNVZSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBBAC4CEF7;
	Wed, 12 Nov 2025 11:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762946692;
	bh=r+d6AygQ3JhDlIlZ/DiHSaguhg2aTGerfLns5gDNv7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efjNVZSwH0r/B3bzxOJ1GCZtedNL9dbW42R2/yBAlmQ2+BVjLRDgN3B5wtsp+D4+a
	 iZ1WQtmMJJL4XdLpK0stHMK3oS0ukhCqTpm5jx7/e8mdZ1rcZPtkGhRHBn591j8Fcu
	 cuu3CMJsrIJAOG1AvmbJNbzkjQfkqR19/CK3ArH5XmA8lEHgtDZsKx839Qdsa/psZp
	 nSbyFvib9+ybFDzc8zQgRtv4GC+SSolxikVlOVE8ZkyesVoGFbfbHweOtm/jhr05gT
	 YmPFLZF8YChiPnncRetxQmcajVf71NCoaEFOL6qUWWV8HwkNOcfL82KXJM5l6wGZ5W
	 Qh/5WcDwKJ7Dg==
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz,
	jlayton@kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nstree: fix kernel-doc comments for internal functions
Date: Wed, 12 Nov 2025 12:24:45 +0100
Message-ID: <20251112-ritzen-waldrand-13e6645e0a9c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111112533.2254432-1-kriish.sharma2006@gmail.com>
References: <20251111112533.2254432-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=brauner@kernel.org; h=from:subject:message-id; bh=r+d6AygQ3JhDlIlZ/DiHSaguhg2aTGerfLns5gDNv7Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK5NU/C7puNveoWhFHq+7rOTJ9doz3pkyyeuUZWjbT7 dC7uId/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiupzhf/XOtaKPuHxOnEoo t77oPNVvp2LyrrtJb86VGvQZzHmx5B7DP5M9L5yzu3pvyKXMbJr/7eAdIV6Znsfq6R4WphvO9W7 4zQQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 11 Nov 2025 11:25:33 +0000, Kriish Sharma wrote:
> Documentation build reported:
> 
>   Warning: kernel/nstree.c:325 function parameter 'ns_tree' not described in '__ns_tree_adjoined_rcu'
>   Warning: kernel/nstree.c:325 expecting prototype for ns_tree_adjoined_rcu(). Prototype was for __ns_tree_adjoined_rcu() instead
>   Warning: kernel/nstree.c:353 expecting prototype for ns_tree_gen_id(). Prototype was for __ns_tree_gen_id() instead
> 
> The kernel-doc comments for `__ns_tree_adjoined_rcu()` and
> `__ns_tree_gen_id()` had mismatched function names and a missing
> parameter description. This patch updates the function names in the
> kernel-doc headers and adds the missing `@ns_tree` parameter description
> for `__ns_tree_adjoined_rcu()`.
> 
> [...]

Applied to the namespace-6.19 branch of the vfs/vfs.git tree.
Patches in the namespace-6.19 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: namespace-6.19

[1/1] nstree: fix kernel-doc comments for internal functions
      https://git.kernel.org/vfs/vfs/c/05518c2e7132

