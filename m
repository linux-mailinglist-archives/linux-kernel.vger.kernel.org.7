Return-Path: <linux-kernel+bounces-852424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD1FBD8F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AF054E83B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7E2FD7D2;
	Tue, 14 Oct 2025 11:12:13 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D902D248A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440333; cv=none; b=SMo5CSQ08E+oRM0X6+Rn7AUYRMDadqcbE7WNcxFNfvyDXZSkkZNhoFryteYS5wAIhClBM+ObIL2nxcNLXuZOvgKkCBkKyYGkmWcY9v5x5KQ4kbjfm0xO0RQhOydUPP/H5my6qTnKcIrt20VeVgZQ+YMIbBnNzs05sd1WaTLLeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440333; c=relaxed/simple;
	bh=k6TfWJvmB8MXgeqLe9zAKOfPL0QDGvhv4chyQ0Bl8FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XuVUZt8NSe1ZPlpRJ7dn/LIavo+TfpxVnJROhJCxMAqg5kjJ4nCUCnAR+xq/a6aR2HYCz/ZJ4IztydFA2dfqH11X5luU9I1twnorYEi65vevdhi+6hVVbejilVn/M68enxoZqFd7bJIqpAqxzJq5f7fouwlsTZNGFTai38GUEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59EBC5Sr058457;
	Tue, 14 Oct 2025 20:12:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59EBC5Ts058454
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 14 Oct 2025 20:12:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8a2fc775-e4f7-406d-b6dd-8b1f3cd851a3@I-love.SAKURA.ne.jp>
Date: Tue, 14 Oct 2025 20:12:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
To: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org
References: <68794b99.a70a0220.693ce.0052.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <68794b99.a70a0220.693ce.0052.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean

#syz test

diff --git a/fs/hpfs/Kconfig b/fs/hpfs/Kconfig
index ac1e9318e65a..d3dfbe76be8a 100644
--- a/fs/hpfs/Kconfig
+++ b/fs/hpfs/Kconfig
@@ -15,3 +15,14 @@ config HPFS_FS
 
 	  To compile this file system support as a module, choose M here: the
 	  module will be called hpfs.  If unsure, say N.
+
+config HPFS_FS_ALLOW_NO_ERROR_CHECK_MODE
+	bool "Allow no-error-check mode for maximum speed"
+	depends on HPFS_FS
+	default n
+	help
+	  This option enables check=none mount option. If check=none is
+	  specified, users can expect maximum speed at the cost of minimum
+	  robustness. Sane users should not specify check=none option, for e.g.
+	  use-after-free bug will happen when the filesystem is corrupted or
+	  crafted.
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 42b779b4d87f..558093b2beab 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -285,7 +285,9 @@ static const struct constant_table hpfs_param_case[] = {
 };
 
 static const struct constant_table hpfs_param_check[] = {
+#ifdef CONFIG_HPFS_FS_ALLOW_NO_ERROR_CHECK_MODE
 	{"none",	0},
+#endif
 	{"normal",	1},
 	{"strict",	2},
 	{}


