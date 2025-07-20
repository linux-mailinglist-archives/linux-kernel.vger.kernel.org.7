Return-Path: <linux-kernel+bounces-738501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8589B0B93A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B70E3B78F7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD71F4190;
	Sun, 20 Jul 2025 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="UfRzgzfy"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D8AD24
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753054262; cv=none; b=bRFa371SGYAHsuTRNvTQPGiXuTasZJe2uwH4qHbW0reTtVd8d5p8b6ZWjSIu51zuJwogp1k1xSIgtGrztJJ+zvsopPpH0RTT5HcmvbkdI52ZErjpBWlwSgOhi7CrLUotEZmbVsPzMTko+vLrFKjIILTRPU96H0ROT6hz6RaKta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753054262; c=relaxed/simple;
	bh=hdnlqTd445D9ouB6hRA4qaXvBNoPe1c9oETR+gF9Bog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTWRpM2sM24JlQgH0P4V029UI7cn7zsBjlUMIPrYycTO8gvjtRAPh8/HlRjLoVdPJx1dEB6XlwVokfwNyXVFNvX+HTw7tLrEHC/TJ1RvYEqvk9AZFCaT2q6vfg1Gv9ztidcHSp+2dg9EsiUfqaf7oDaiVnObMYsnBaxgftfbt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=UfRzgzfy; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753054258;
	bh=l0jDcMiN9DSncCGaXXBVq6ob/ExH1QCf6rJAh1uc610=;
	h=From:Subject:Date:Message-ID;
	b=UfRzgzfyjHNoUlpW0aH9Pf0Dnps2fxy2vGmoMMXTBh4Cg3xNwN1P68taXQ2U2tQdg
	 nZkUCC0f8iXZzXE5r7elshiFvnr72OO1/Q5Ft+lmQjCcQs7/t+1rsJSceGLIpukoV2
	 m8nDyO6Q6lhCnLMlTACcvrO9/kXS9DHRrJYho5NY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 687D7C270000030D; Sun, 21 Jul 2025 07:30:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9683984457040
X-SMAIL-UIID: 33A8750B876D4A7BBBFDF6F55F2D808F-20250721-073048-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4bb2305559463e8f6a2a@syzkaller.appspotmail.com>
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_iop_getattr
Date: Mon, 21 Jul 2025 07:30:34 +0800
Message-ID: <20250720233037.2567-1-hdanton@sina.com>
In-Reply-To: <67f82b19.050a0220.355867.000f.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 10 Apr 2025 13:33:29 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2eb959eeecc6 Merge tag 'for-linus-6.15a-rc2-tag' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16fdf23f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c918722cb7e3d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=4bb2305559463e8f6a2a
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1352b7e4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17499d78580000

#syz test  upstream  master

