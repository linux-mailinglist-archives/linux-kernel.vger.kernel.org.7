Return-Path: <linux-kernel+bounces-731057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA57B04DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD811AA4A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D18E2D0281;
	Tue, 15 Jul 2025 02:51:57 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8118C008
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547917; cv=none; b=SEjEv9hNEV7Ht2AytQJ7h11vifW5n3/C0ngIhiisEoIJgrY4vra7dUqundME27hdxvU421WlP1OX6Q2tJYV5CrWs9y+z1LXY9IjjH7WQZxWEyYaeXjtPLUxfie6F6K+XsRDNQHS+Au+odGgOK0p+fsKfAYTVeA9HZtzD2fYeo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547917; c=relaxed/simple;
	bh=iobXdl27H6ZJuLcQAu76AzTvRyaj+23LsNAAF1/ti9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UURUOWiPeYteXLkKmc7IMu/irslr9LtWAqUq4Tw3fSLyKnmHqkq+nOieBRcTGGK3djU+62t9e4ovbX6/stwU7vm4+ml1FypCCD15jotKz0bYvmzM+1+EmM+uWuWQ7u2ntH1qQHPDIr0+0XPEQlFmKAGIZlqt5iG/VbycpK90Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56F2pIgl034051;
	Tue, 15 Jul 2025 11:51:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56F2pH3W034048
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 15 Jul 2025 11:51:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5957f94d-2521-43d4-ba0b-7b98576167a4@I-love.SAKURA.ne.jp>
Date: Tue, 15 Jul 2025 11:51:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix lock acquisition order in refcounttree
To: Diogo Jahchan Koike <djahchankoike@gmail.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250714221552.4853-1-djahchankoike@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250714221552.4853-1-djahchankoike@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/15 7:15, Diogo Jahchan Koike wrote:
> Acquiring the locks in refcounttree should follow
> the ip_alloc --> ip_xattr ordering, as done by multiple
> code paths in ocfs2; otherwise, we risk an ABBA deadlock
> (i.e in the start transaction path).

I noticed that ocfs2_reflink() in the same file wants similar change.

	down_write(&OCFS2_I(inode)->ip_xattr_sem);
	down_write(&OCFS2_I(inode)->ip_alloc_sem);
	error = __ocfs2_reflink(old_dentry, old_bh,
				new_orphan_inode, preserve);
	up_write(&OCFS2_I(inode)->ip_alloc_sem);
	up_write(&OCFS2_I(inode)->ip_xattr_sem);


