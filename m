Return-Path: <linux-kernel+bounces-739080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E5B0C18B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8394175574
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2E293C56;
	Mon, 21 Jul 2025 10:41:42 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5528FAA1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094502; cv=none; b=GRv8FJIkrB8o0vvyJS/vvww4/4Xs3AQZTPsNUq/VW6e9ehoHHgOMh7GHbGjyw5wygytPHSQs3X/KlUuNdDCzVVjoyoaiUaKHneS3apbONHqakMvbOYV8rTo1xGFH9F32CYCmUGXxENmKqi6EPUz2wBpMNrD6gp2wZhh1B2JXPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094502; c=relaxed/simple;
	bh=AXwLKODyVfTLHqvH6czchRUOkdCHI15YAPl5NF0muKU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vqg6sR/NRQNbEdR9gSPur2CFmD99YynEVkgvnMzwKhC1XxrAWw6U8JzRAV9h3bQWa7iPvBsfZatOKi8pVR/4X++9kZbC1wC+hCjGdfuODZSCllkDK60SkWu8Tbs/zX6rijuw5tc7LPLkBbmaCijYTZd2NKtjcTdW9JPkL7mVJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56LAf2RG043693;
	Mon, 21 Jul 2025 19:41:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56LAf2T0043685
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Jul 2025 19:41:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dee1a0fe-7846-466a-a08b-4967929b5f6e@I-love.SAKURA.ne.jp>
Date: Mon, 21 Jul 2025 19:40:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix lock acquisition order in refcounttree
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Cc: syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
References: <20250714221552.4853-1-djahchankoike@gmail.com>
 <5957f94d-2521-43d4-ba0b-7b98576167a4@I-love.SAKURA.ne.jp>
 <6e49d04a-4069-4cce-9f49-fd63983ae658@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <6e49d04a-4069-4cce-9f49-fd63983ae658@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

On 2025/07/18 22:54, Tetsuo Handa wrote:
> On 2025/07/15 11:51, Tetsuo Handa wrote:
>> On 2025/07/15 7:15, Diogo Jahchan Koike wrote:
>>> Acquiring the locks in refcounttree should follow
>>> the ip_alloc --> ip_xattr ordering, as done by multiple
>>> code paths in ocfs2; otherwise, we risk an ABBA deadlock
>>> (i.e in the start transaction path).
>>
>> I noticed that ocfs2_reflink() in the same file wants similar change.
>>
>> 	down_write(&OCFS2_I(inode)->ip_xattr_sem);
>> 	down_write(&OCFS2_I(inode)->ip_alloc_sem);
>> 	error = __ocfs2_reflink(old_dentry, old_bh,
>> 				new_orphan_inode, preserve);
>> 	up_write(&OCFS2_I(inode)->ip_alloc_sem);
>> 	up_write(&OCFS2_I(inode)->ip_xattr_sem);
>>
> 
> Moreover, I noticed that e.g. ocfs2_xattr_set_handle() firstly acquires
> ip_xatr_sem and then ocfs2_xattr_ibody_find() might acquire ip_alloc_sem.
> 
> Diogo, where do you see the ip_alloc --> ip_xattr ordering?
> 
> Unless we unify to either ip_alloc --> ip_xattr ordering or
> ip_xattr --> ip_alloc ordering (or replace ip_xattr with ip_alloc),
> this patch simply changes the location of lockdep warning?
> 

Since I couldn't find direct ip_alloc --> ip_xattr ordering,
I tried effectively replacing ip_xattr with ip_alloc at
https://lkml.kernel.org/r/687be24a.a70a0220.693ce.0092.GAE@google.com
and got sb_internal --> ip_alloc v.s. ip_alloc --> sb_internal
ordering problem, as with other lockdep reports in ocfs2 subsystem
at https://syzkaller.appspot.com/upstream/s/ocfs2 .

In the team network driver, this kind of ordering issues has been
addressed by simplifying locking dependency at
https://lkml.kernel.org/r/20250623153147.3413631-1-sdf@fomichev.me .

ocfs2 developers, can you simplify locking dependency in ocfs2, by
killing several locks and reordering the locks?


