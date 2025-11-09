Return-Path: <linux-kernel+bounces-892195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD3C44987
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 23:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACD93B0476
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607D26D4CD;
	Sun,  9 Nov 2025 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="zhf17p9Y"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F61C861D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729092; cv=none; b=DiCu9WnRPQztgpCNdIz5rrFhyi48Xs2izX3Xk4dQ/t/Hhozy03qwrunZS0u7SZLnb5bDuIDhgeaYzI/FJpAIaegy+/Hq4oLGkBnzouyUd7NyQ6J8SDzSx76v8aHtofOaodV6WInyCeBaBVH2qJEtz+FM0FKYUVoWKBdgGykp5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729092; c=relaxed/simple;
	bh=zvM5L82UsovszDgGDQwBgPaonvekrGjz9aSleaGG4HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4ixkeZv+CVROu2cB8q0wM0LKv7cUkiJaTaTv2sPzbHFPmbHxN76FOWHahLO0bAkJYtK5t0nJ8D5ITYrWc5yqAGVDPhPInX4Zl9sHrbqq5joC6xOpo01wUUfmw3zkBU2l2as0WjFMxuKkJv5KLUM+MpTyty1d5myXy2CmbWYy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=zhf17p9Y; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762729087;
	bh=X3sgMONdGnK9HZSlZmsqzfDs/H21WbjKzGNdhC1T2Yo=;
	h=From:Subject:Date:Message-ID;
	b=zhf17p9Y5JqH7MRr04fMG2kKHOogKKN5Y4TZaOfnli+FU4G9FfeCoGUm4DCAQ8Stb
	 HefWR/Of/DbL1d+S6IPBS6WhxypyQE2VQmt8sXOZUoHKK7YhsG2aaW4OvV0Rw/+d+9
	 nhBv2bOJQFc2VrRskYuA6dxqgTNd/Pda8ENDQZQQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.33) with ESMTP
	id 69111BE800007E0D; Sun, 10 Nov 2025 06:55:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7950016685186
X-SMAIL-UIID: 211698EDDDFC497485E9AE18BBA73E18-20251110-065538-1
From: Hillf Danton <hdanton@sina.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/8] ns: fixes for namespace iteration and active reference counting
Date: Mon, 10 Nov 2025 06:55:26 +0800
Message-ID: <20251109225528.9063-1-hdanton@sina.com>
In-Reply-To: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 09 Nov 2025 22:11:21 +0100 Christian Brauner wrote:
> * Make sure to initialize the active reference count for the initial
>   network namespace and prevent __ns_common_init() from returning too
>   early.
> 
> * Make sure that passive reference counts are dropped outside of rcu
>   read locks as some namespaces such as the mount namespace do in fact
>   sleep when putting the last reference.
> 
> * The setns() system call supports:
> 
>   (1) namespace file descriptors (nsfd)
>   (2) process file descriptors (pidfd)
> 
>   When using nsfds the namespaces will remain active because they are
>   pinned by the vfs. However, when pidfds are used things are more
>   complicated.
> 
>   When the target task exits and passes through exit_nsproxy_namespaces()
>   or is reaped and thus also passes through exit_cred_namespaces() after
>   the setns()'ing task has called prepare_nsset() but before the active
>   reference count of the set of namespaces it wants to setns() to might
>   have been dropped already:
> 
>     P1                                                              P2
> 
>     pid_p1 = clone(CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
>                                                                     pidfd = pidfd_open(pid_p1)
>                                                                     setns(pidfd, CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
>                                                                     prepare_nsset()
> 
>     exit(0)
>     // ns->__ns_active_ref        == 1
>     // parent_ns->__ns_active_ref == 1
>     -> exit_nsproxy_namespaces()
>     -> exit_cred_namespaces()
> 
>     // ns_active_ref_put() will also put
>     // the reference on the owner of the
>     // namespace. If the only reason the
>     // owning namespace was alive was
>     // because it was a parent of @ns
>     // it's active reference count now goes
>     // to zero... --------------------------------
>     //                                           |
>     // ns->__ns_active_ref        == 0           |
>     // parent_ns->__ns_active_ref == 0           |
>                                                  |                  commit_nsset()
>                                                  -----------------> // If setns()
>                                                                     // now manages to install the namespaces
>                                                                     // it will call ns_active_ref_get()
>                                                                     // on them thus bumping the active reference
>                                                                     // count from zero again but without also
>                                                                     // taking the required reference on the owner.
>                                                                     // Thus we get:
>                                                                     //
>                                                                     // ns->__ns_active_ref        == 1
>                                                                     // parent_ns->__ns_active_ref == 0
> 
>     When later someone does ns_active_ref_put() on @ns it will underflow
>     parent_ns->__ns_active_ref leading to a splat from our asserts
>     thinking there are still active references when in fact the counter
>     just underflowed.
> 
>   So resurrect the ownership chain if necessary as well. If the caller
>   succeeded to grab passive references to the set of namespaces the
>   setns() should simply succeed even if the target task exists or gets
>   reaped in the meantime.
> 
>   The race is rare and can only be triggered when using pidfs to setns()
>   to namespaces. Also note that active reference on initial namespaces are
>   nops.
> 
>   Since we now always handle parent references directly we can drop
>   ns_ref_active_get_owner() when adding a namespace to a namespace tree.
>   This is now all handled uniformly in the places where the new namespaces
>   actually become active.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>
FYI namespace-6.19.fixes failed to survive the syzbot test [1].

[1] Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
https://lore.kernel.org/lkml/690eedba.a70a0220.22f260.0075.GAE@google.com/

