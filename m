Return-Path: <linux-kernel+bounces-726901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4FAB0128D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08055A2984
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA51B413D;
	Fri, 11 Jul 2025 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="cQ7RWxLS"
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C61111BF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210572; cv=none; b=ZtZ5qXvNLHXTUVLkbXDZlxB8p/9I2V4CoweewFRNDitEFg9Pl+dxxDcTCYQhp5plSH6F6TYiioN6O9yJg0q2cD/Jr5SSaZcQnTr6a2W/TIJz/NRqnQj9gTAiXhCMl7fdFDCIYE0G/QqWH5160ErOQAcxM3CXfdm4xPfj7bvdEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210572; c=relaxed/simple;
	bh=A6CrZaHjBawYaUGpM2LphRg6gKDhDPGQWh/MZ5jw7Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWE7yjRbKj80IWXCLOeH1tKCP3sN5+iu7xTkJwgWD7VT9C/tmTXXS6dMjZCPLxx6buc4OcaIcxKIAeBMgzjYWnXVLaPwlMaUzo3spMVwueCvD9CQHeGb01QaBAHYbXq+0PwgmDOhi8pFDy2QkvLA/o4ZijxdFULxwAw4CT4HDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=cQ7RWxLS; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752210568;
	bh=0KvJjLRCAc51kK6nLlsqC68Qvmg3ZAkvtJy+9d8/hEQ=;
	h=From:Subject:Date:Message-ID;
	b=cQ7RWxLSrff2IWGTIkYKdZak/NvJmlb5IjBTtEUSXj+RZTrBRyLHasc5bqhO7agEv
	 9YJWCslezfbQmfs0q5o4OQrxMV7GwaPVXXvyxgGwWGMaKOfTo3tVBM6DcXnd2EIcGq
	 oOootqdr1qtdfwyHqnzeKmlYMzWh5qWG35COKQHc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68709C82000048F6; Fri, 11 Jul 2025 13:09:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4527316292012
X-SMAIL-UIID: 73E75BAE39FC4A7D8A148DE32ED3A07B-20250711-130924-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
Date: Fri, 11 Jul 2025 13:09:12 +0800
Message-ID: <20250711050913.3372-1-hdanton@sina.com>
In-Reply-To: <686d5adb.050a0220.1ffab7.0019.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 08 Jul 2025 10:52:27 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1719df70580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
> dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1124abd4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1099df70580000

#syz test

