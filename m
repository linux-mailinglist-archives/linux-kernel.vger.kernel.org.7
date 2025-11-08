Return-Path: <linux-kernel+bounces-891358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4B3C42865
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 07:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C018188DCC9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 06:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37102DF709;
	Sat,  8 Nov 2025 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="OWvWzgPg"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860A253B58
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762583937; cv=none; b=cR2AxgZzoqUzJQts99YzhGAD7iw9NVhMarPAElfc70O64qKAlGA7cmALFvjHgeB6+q+55iEnVKXALsE3sEWlmNgYuskJMb23/7CgpWoEsoFccARLhwyN3u/bTsmnbFVyk0jD+1VS/dHvUPGzsDrLG/7T5Y1pFXvB17CpScowp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762583937; c=relaxed/simple;
	bh=zF6NFIPhancgZwzI+bXc5KtjO3KI9qIp1pmV/zh2+AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAIXwqGvl95ikE+Ljpr4PRmvGzTejfxmsRoAKmzcc8ohtcc9Uh0LPpfny8qNPNSAJaPUA2/oxZd8u+dlnHMR1DkSezlZqbFyrt1Gpd4H527hEYCvDnmKeYB7iWKfxh1nR9Zj2qFn3upBxvuJZ+WujZRtSuBntSu7TlP/9Uwr5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=OWvWzgPg; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762583932;
	bh=Hhl6lRv0tgLFZwJJkwrly+HsRbncDvU6qYbvV6Re+Xw=;
	h=From:Subject:Date:Message-ID;
	b=OWvWzgPgT8RenOizOLLeMIyEtQOHC4wY0Dun5DjKNEg3VUgBPK7k9cZ8AIc3ll6m9
	 LM5Tus8eRbW6QjQwxOAX3PYYc4b73pJflTeUd5TpZCzP7jpFUSZHwx0mchHdWouAPo
	 XW2aA5n3oI4sXI5JBjDDz5wHTsp8cFGZszOGbqlg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.32) with ESMTP
	id 690EE571000056FC; Sat, 8 Nov 2025 14:38:43 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1975514456628
X-SMAIL-UIID: 8F3D1C4BDE524BE8B6F4EEB69C07B80E-20251108-143843-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
Date: Sat,  8 Nov 2025 14:38:30 +0800
Message-ID: <20251108063831.8984-1-hdanton@sina.com>
In-Reply-To: <690dfca7.a70a0220.22f260.004d.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

> Date: Fri, 07 Nov 2025 06:05:27 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    17490bd0527f Add linux-next specific files for 20251104
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c09bcd980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9995c0d2611ab121
> dashboard link: https://syzkaller.appspot.com/bug?extid=553c4078ab14e3cf3358
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1500a532580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e0a114580000

#syz test https://github.com/brauner/linux.git namespace-6.19.fixes

