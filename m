Return-Path: <linux-kernel+bounces-779339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C417B2F2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F207BCF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FD42EB85B;
	Thu, 21 Aug 2025 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="u8QbfY9E"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EDB1E7C18
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766093; cv=none; b=Ca2h6rYOJJfB00D48rSgbOJwCpbV474ILwcg4SZxQ1tHpeZI5WHIlau1RSdTTdWt/scHvil2XDl8wZ7rF9+hSo1qrvL6M/7PD6ivu23SFsJ1VHhraqwr6plW+63dPB/5DmQzOJUjSo974yYtpNQSdE2YKr1aiUtRf41XRdYAPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766093; c=relaxed/simple;
	bh=OsKkrYP2K1kZ5nL9zj3zSGW9MW+lhOQxhduKnhMKUJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFyPYbRnkIKCjPb2uPYpMo4J7SRAz6jm8VyZYhtLdShZF88fgBT14CgLEdblr9c0qtCU8xctrd6IDb58Tyo9fSGoqeJZLTRJVpwmVs6cZeUZk4OT6MiP1PcXwO5o8FjWz/BqcYGGYlgifERU/xoQ6z7YXkcxTdT6tTtxl3pWvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=u8QbfY9E; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755766084;
	bh=ASmlOtkq/5yE7hsUC/gPgPV7oXsMfgZPITdY5ZzM4xg=;
	h=From:Subject:Date:Message-ID;
	b=u8QbfY9EfduM9O2kYCYWym+r5b4iJYW8PHp0YW4wBbnzQpf9pcqV1Kbpf8CwoTCjx
	 hj1taMc5pW7xj2hyak0UI3vwWexQTBYc45yDR790fe7qn26n51kGzhYKuzPGZizfW8
	 XEZwTLHVMiixmyxQu21ru3hCsHJMN8d6dbgof8Es=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68A6DD3800005A96; Thu, 21 Aug 2025 16:47:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8702004457044
X-SMAIL-UIID: 55F76CE797EA4A61B7127B1AF56606F0-20250821-164753-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
Date: Thu, 21 Aug 2025 16:47:33 +0800
Message-ID: <20250821084742.5216-1-hdanton@sina.com>
In-Reply-To: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 20, 2025 at 07:58:31PM -0700:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3ac864c2d9bb Add linux-next specific files for 20250818
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13706442580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d1acc6b9e1fca1b
> dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141586f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c9ba2580000

#syz test

--- x/fs/9p/v9fs.c
+++ y/fs/9p/v9fs.c
@@ -302,6 +302,8 @@ int v9fs_parse_param(struct fs_context *
 			p9_debug(P9_DEBUG_ERROR, "msize should be at least 4k\n");
 			return -EINVAL;
 		}
+		if (result.uint_32 < P9_IOHDRSZ)
+			return -EINVAL;
 		clnt->msize = result.uint_32;
 		break;
 	case Opt_trans:
--

