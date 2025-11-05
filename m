Return-Path: <linux-kernel+bounces-885687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1698AC33AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FD018C5B6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52E6248F57;
	Wed,  5 Nov 2025 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mfs0e/ft"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304023D7F3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306818; cv=none; b=CFe5e1qc8xpMsp/s4eJUMDA3KKQdBQxUEfDotEMJTai3C7hEtha0j7duSDRVMelNdMp3dTFPipIAOhslMh1AN0ruBQ1in7OgbmxUhwyJsnxe65+CNoWvZEDO9cYBaDKcRTqzMcH4YdHfhrmXeLfP9mS0ut1p5gRRa8tsm+i0h+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306818; c=relaxed/simple;
	bh=GqDi5GkFAwbTiD5BQkfKO8wmpRw7mEjoIkWIofJtPwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtM9COIQyEXXVlqMTgYhvKoaNqgndFAqNR7OOAuWhSeUkZIDcuUlNt5LNukCFVG+Tji7UbjF4gxviSKo5rR9E/TSDzkKMF2SppMt72jSh4BCW4HgIi1Vtecu1MqbgMPTMuQWrHwW3svyl+kKZGcgJ/Y06Vxu1BKE9DFDkdaZAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mfs0e/ft; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762306812; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KAltNraqZrxDP4Z4ttzZmN1l8i6KuuWtzoXbQ1bixls=;
	b=Mfs0e/ftP6PMZAtK2BtCeDbHGouteEvhkuB8Nqp3YR5YbaYQb9TF8lBALwXZ5QfQQJ+Q+O5KgZF1i+g9mcCPCe9/UeGFikN31Hb48jZpOV6lTdKDaBbY+uuU6OAIe8iVqDVj7VRxKmmW/w8aYPPs0xYH6D3v9pJPtu2ZqGmEr2c=
Received: from 30.50.176.188(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WrjCNa9_1762306811 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Nov 2025 09:40:12 +0800
Message-ID: <cadde0fd-e99e-4306-b9c8-327822756a95@linux.alibaba.com>
Date: Wed, 5 Nov 2025 09:40:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>, ocfs2-devel@lists.linux.dev
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, linux-kernel@vger.kernel.org,
 Heming Zhao <heming.zhao@suse.com>, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org,
 syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
References: <20251029225748.11361-2-eraykrdg1@gmail.com>
 <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
 <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>
 <qfizhbe5rwzddwnoekr6xjy3gozbqbtl64c5xmfeuudxvficmv@onazesxv4ur6>
 <aQQ0DLqL0iVN7D15@arch-box>
 <leys5guzkcvlilaccjmsw7cvncm6o2vqo2wwezhuz7r6lcfjnk@va3cnphl4zf3>
 <aQS_oUDXGt_nF__d@arch-box>
 <stmj7kbqis2idlscf5iwch23ft2azuyyr7q2kmelavjk5lnug4@66in667d6bym>
 <aQTGFvVX22RmDhb0@arch-box>
 <CAHxJ8O9Yci6QzGckrsWhuoDHatYyOOok++ySmYc43WbEhFy3xg@mail.gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <CAHxJ8O9Yci6QzGckrsWhuoDHatYyOOok++ySmYc43WbEhFy3xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/11/5 06:31, Ahmet Eray Karadag wrote:
> Hi folks,
> 
> I'm having some trouble getting xfstests-dev set up to test some ocfs2
> changes. I can't seem to get the configuration working correctly to run
> the ocfs2 test group.
> 
> Could anyone share some insights or pointers on the proper setup? Any
> help would be much appreciated.
> 
The basic steps is:
1. Configure a ocfs2 cluster, e.g:
$ cat /etc/ocfs2/cluster.conf
cluster:
        heartbeat_mode = local
        node_count = 1
        name = ocfs2cluster

node:
        number = 0
        cluster = ocfs2cluster
        ip_port = 7777
        ip_address = 127.0.0.1
        name = localhost

2. Online ocfs2 cluster:
$ /etc/init.d/o2cb.init online

3. Then run xfstests cases, e.g.:
$ ./check generic/001

Actually we prefer ocfs2tests to test ocfs2, which can be cloned at:
https://github.com/markfasheh/ocfs2-test

Thanks,
Joseph

