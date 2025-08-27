Return-Path: <linux-kernel+bounces-788870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75369B38B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611A87A32FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165F030DD19;
	Wed, 27 Aug 2025 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="jG8goVeZ"
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5351A073F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330712; cv=none; b=P7cZfEFKoFtYWebS3/YluY3PdFn4emwulYVXoVxYBwmhQfJ0B5AeB2W/5jRpp+DDWpx+6sUKJEqtvYR58vAIQjbZezmsUfNMNmQ6y22ns6X8JRc7o249vgJ5LEY/Pp7+8G3FMauVznGYn3RUTzB777dBfy3e9V1GVz5Fz7ieOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330712; c=relaxed/simple;
	bh=ceJYqMUs2QL1j1IFq4CxIZgJit55VEokOkXQ393Q+QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCwXXNAOQwiJJvB7ikrhTzsWLnhYQMQH1HUEJAC9YZerv2Oqnrt7B95TfNGS9NgJRI/Qth88yFuJPdDgtD2n/FmAl8Zf8gWfViaE2XafLnkkGxTKQqqUjfbXEZAKTFxDo/VvR0FPOeo1zn/n1YTA91IzP5VGgWWwZhMdrcEq03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=jG8goVeZ; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756330707;
	bh=dTQHUcYjQfaUFmKNuekDCKJWy/J4bod7ybCPgMo0FtA=;
	h=From:Subject:Date:Message-ID;
	b=jG8goVeZf674zgMQv457n9yQoodrI2Qc3uDecKUxGlAnCAHHI8+mAUPresvkSt3jg
	 doS+6aLLtaMM3HF+/pzd52WXti8zj0mqK7PFMN5/+d66pgehvjE7Zg+jjNjIfTPNZx
	 Z6VGKpO/iFiz9KzHnrETUFWo3iDqKgDzMF4zM8Rs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68AF7ACD0000074E; Wed, 28 Aug 2025 05:38:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6474936292000
X-SMAIL-UIID: 140A3B1CBBFE45B0A7A1CE011947AD5C-20250828-053823-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4507914ec56d21bb39ed@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [ext4?] [btrfs?] INFO: rcu detected stall in sys_mount (8)
Date: Thu, 28 Aug 2025 05:38:12 +0800
Message-ID: <20250827213813.5905-1-hdanton@sina.com>
In-Reply-To: <68af0313.a70a0220.3cafd4.0020.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Wed, 27 Aug 2025 06:07:31 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=16a85ef0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> dashboard link: https://syzkaller.appspot.com/bug?extid=4507914ec56d21bb39ed
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1455a462580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12229462580000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git  fixes

