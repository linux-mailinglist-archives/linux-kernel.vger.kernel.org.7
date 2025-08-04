Return-Path: <linux-kernel+bounces-755072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488F5B1A0F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FC23A5467
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A0187332;
	Mon,  4 Aug 2025 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Melge0mp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811814EC62
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309647; cv=none; b=h+jqY8+M9FyUI9+KveAlYWfnvmLrE7lzTJM/PU5HVXu2qE8IpOanEMF4dh40pKG0OQqgeZnhbIlWMvEHjpPIUsQLrL6Sk2owlbmdvxM8PmiphPetK1pYFSx1N1wEP3x/NIHFxqCC7c+lNg7fc75E7HGBz9ZADwGYTGC1B9ZPtvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309647; c=relaxed/simple;
	bh=2mskliIUaT2oxqWNgq3FFdkxI4hnBKlh8XQFbQdb1Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii7SxxZ9AWC757/PwFiScYitxP3i6Dr1U2ckkmw7tv6TpCRNgAFLmVM+8Pdu9uNXwrXrH6Y1n2Ve187s1lMom0Cc4RWGgLjpQfyyxAwY5y4i9ZpLzfbhIQNNVSOrwavi+XA3Sr3gizFU2LuWcRylqQMzfMOg3v9u7P9Equsk5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Melge0mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031BBC4CEE7;
	Mon,  4 Aug 2025 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754309647;
	bh=2mskliIUaT2oxqWNgq3FFdkxI4hnBKlh8XQFbQdb1Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Melge0mpx0SZ4FVWhPRMc+JwOAO5S5jSbiRQA6CLWJpp1/EPq3teRfqmrs71haCd4
	 HBAuMGxpj96dxbVATAIh6So8B6gar325S49Ar+p4aXhz+sw6qEAdrBV9EFBpQOZrUo
	 7s7pT8zrrxqA/KBqLSt8I/F3Pm3qg419XdHMaZp97iKKe+3cca0GYRYO5FfZK0sR3r
	 jgqtkwdYutWzuNblx8HyUMOERt3mJ1qrBigYUcCKwzj+owow9OeBrPUDNxKlUxnqth
	 MCw0lAVY+ECBIctArmf+1ugHth+HpXymHs5QZN2jpmJrF8fAqytNOlhtXJJbAh3wnY
	 zGjR3RxZ0FyHg==
Date: Mon, 4 Aug 2025 14:14:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Xiang Gao <gxxa03070307@gmail.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250804-gepfercht-delfin-0172b1ee9556@brauner>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802084525.GB31711@redhat.com>
 <80be47cb31d14ffc9f9a7d8d4408ab0a@xiaomi.com>
 <20250804114900.GA6656@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250804114900.GA6656@redhat.com>

On Mon, Aug 04, 2025 at 01:49:01PM +0200, Oleg Nesterov wrote:
> On 08/04, 高翔 wrote:
> >
> >     struct task_struct *tsk = current;
> >
> >     struct task_struct *parent;
> >
> >     ...
> >
> >     info->pid = task_pid_vnr(tsk);
> >     rcu_read_lock();
> >     parent = rcu_dereference(tsk->real_parent);
> >     get_task_struct(parent);
> >     rcu_read_unlock();
> >     info->ppid = task_tgid_vnr(parent);
> >     strncpy(info->ptask_name, parent->comm, TASK_COMM_LEN);
> >     put_task_struct(parent);
> 
> So I guess the kernel crashes when you try to obtain another process's pid, not
> the current process's pid. This is was I suspected.
> 
> This code is buggy. tsk->real_parent points to nowhere if tsk = current was reaped.
> rcu_read_lock() alone can't help. Even get_task_struct(parent) is not safe. And it
> is not needed.
> 
> You need something like
> 
> 	info->pid = info->ppid = 0;
> 
> 	rcu_read_lock();
> 	if (pid_alive(tsk)) {
> 		info->pid = task_pid_vnr(tsk);
> 		info->ppid = task_tgid_vnr(tsk->real_parent);
> 	}
> 	rcu_read_unlock();

I distinctly remember having seen a similar patch about 5 years ago that
did the exact same fix for some out-of-tree abuse:
20201201024811.GA72235@ip-172-31-62-0.us-west-2.compute.internal

Where in the kernel is that code supposed to live? Is this again an
out-of-tree module?

  __task_pid_nr_ns+0x74/0xd0
  get_common_info+0x9c/0x1c0 [io_xxx 39b55c95a0fe9416f7d7be396be0fd1d6f590f17]
  io_monitor_global_log+0x1a0/0x294 [io_xxx 39b55c95a0fe9416f7d7be396be0fd1d6f590f17]
  cb_android_vh_ufs_compl_command+0x304/0x578 [io_xxx 39b55c95a0fe9416f7d7be396be0fd1d6f590f17]
  __traceiter_android_vh_ufs_compl_command+0x54/0x78

all looks to me like some out-of-tree stuff...

So no, not taking that.

The only thing I can see as a sensible addition is:

diff --git a/kernel/pid.c b/kernel/pid.c
index c45a28c16cd2..f27cbc208c5e 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -491,6 +491,9 @@ pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
        struct upid *upid;
        pid_t nr = 0;

+       if (unlikely(WARN_ON_ONCE(!ns)))
+               return 0;
+
        if (pid && ns->level <= pid->level) {
                upid = &pid->numbers[ns->level];
                if (upid->ns == ns)

So that we yell at abusers of pid_nr_ns(). But even that...

