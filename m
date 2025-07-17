Return-Path: <linux-kernel+bounces-734547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF9AB08301
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCFE4A13C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BB11C84CB;
	Thu, 17 Jul 2025 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="BzxfPEz9"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99B186A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752719709; cv=none; b=p1rmyCMq9PmG01dbn6gQ0bq/8cv8G3xLc1a69PoXBCHzTFEyR954YZWQN6a44f6x3XVqlvBj9NguKhVAF0FA1X+jV+tOIv+ryeaxmD+i0ac/NUEnFHzC/T4fUS/aAqeujzCG95i+NfGEIVWqI48xi6N7cMTS5AbB1kb6x3DCJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752719709; c=relaxed/simple;
	bh=gay+Sus50BgmwKGPcm1KbHWNEyvMYFfx5hlx2wspIKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxPlx+C+aEt2TXyUsr8LR1h5gdBsPfj/NbyozZQTjN4ERM+XDeRGaKXoOT3ojbtFM0s9KH/UL9Jw3DphbytElQtvHodmjkrMWePf6e61W7z2I2z11Dxok3tm0i+Ip/npuLUpatrfcEoVH6K4KQgDIIz4TkU1hZ2L/Ej4qWh25+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=BzxfPEz9; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752719704;
	bh=pCGSqhifANmuVexEvcBMyZ9h8zSqr3EKeB79/SdXj8M=;
	h=From:Subject:Date:Message-ID;
	b=BzxfPEz9HyUe9rSTksv3OWj/D4DigHMOuahM8nJrP7Obfohg51sr/8IIHZB2YUhyG
	 TIaHOUmxH2rS904EqUzTUbVokfmWh7EUdoc5XrmvgAPw8wxKKo1p5habz15GYx9sII
	 gOXYeveW16Ea+4EODDeLB5kgB9zF1IYX06c8tJpc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6878614C00004502; Thu, 17 Jul 2025 10:34:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6027666816292
X-SMAIL-UIID: 8F031F8849444089BCAFB00EFB6D803B-20250717-103454-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	lorenzo.stoakes@oracle.com,
	surenb@google.com,
	linux-mm@kvack.org
Subject: Re: [syzbot] [mm?] possible deadlock in lock_next_vma
Date: Thu, 17 Jul 2025 10:34:43 +0800
Message-ID: <20250717023444.2281-1-hdanton@sina.com>
In-Reply-To: <68753289.a70a0220.18f9d4.0003.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 14 Jul 2025 09:38:33 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15cfb0f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=be9e2082003f81ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=159a3ef1894076a6a6e9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1003b18c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11437d82580000

Test [PATCH v7 0/7] use per-vma locks for /proc/pid/maps reads

#syz test:  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git  mm-new

