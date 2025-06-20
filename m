Return-Path: <linux-kernel+bounces-695851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E7BAE1EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 17:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEC8176B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82D2D8DCC;
	Fri, 20 Jun 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gtpx77gL"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76D2EE290
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433056; cv=none; b=lq3HfbHbqfSTNRaiZObM3LtwlmZdJ3hZ0IoeSPXd0qhXCk7b6biZ8iSxoD0DlidEj7VzyDQHFJS3hx1vlnJOeDKtgBdGWbY73mKm2k/aV2LYMRYic1Hs3H7yzAyKFEIRb66PRkmQjsUlQLUDQ/bXg+qi0vlTgJstx8SrWBnS15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433056; c=relaxed/simple;
	bh=Ya3VNWrROgaFZ5bH5z9BWL5PtUUf3ZVrEfyqFiIGvkY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Nb4lOnjbTamy17BJfDj4Tsr3W4FJAfMGUa1VBVuN8W5rzNgkcKstSSyl9vKCqWvUKXbxjha5cHSDYofXw7bddK2h1bX78jB8u6IDppaOBTY4jVYFvmn85cZnREa0SZzrpUt6Rgl/zT5dJckpxdRE5H6QeT+YAosqDyOBREX9Slg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gtpx77gL; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a3ec239-7504-4c1a-86e7-4911be42e0a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750433042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t363sv/PFQaoNjy1pWbaKZu3kCtrGkr9AZQHOKk936A=;
	b=gtpx77gLDK9Fm38E3p6Pi+Wuj/afpDwEXtOVz+E+LgFm0HRy1OeW//Sk0k9zlhRZqKt1Wc
	78c+YmWk74v0cZECq4uNiD4TEnPuOkNVbLxmVsFjhBrmfJlRLDYoV+LmjWTG8QJo9JXW+U
	YZAu0afA+toFD0nY/1JZFRddXFf4Zu8=
Date: Fri, 20 Jun 2025 08:23:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] Monthly rdma report (Jun 2025)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: syzbot <syzbot+list130c9052d10c27bfc9e9@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68552aae.a00a0220.137b3.003f.GAE@google.com>
 <a3781077-5f71-45e1-bd73-1a85d927fecd@linux.dev>
In-Reply-To: <a3781077-5f71-45e1-bd73-1a85d927fecd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/6/20 8:12, Zhu Yanjun 写道:
> 在 2025/6/20 2:32, syzbot 写道:
>> Hello rdma maintainers/developers,
>>
>> This is a 31-day syzbot report for the rdma subsystem.
>> All related reports/information can be found at:
>> https://syzkaller.appspot.com/upstream/s/rdma
>>
>> During the period, 0 new issues were detected and 0 were fixed.
>> In total, 8 issues are still open and 65 have already been fixed.
>>
>> Some of the still happening issues:
>>
>> Ref Crashes Repro Title
>> <1> 462     No    INFO: task hung in rdma_dev_change_netns
>>                    https://syzkaller.appspot.com/bug? 
>> extid=73c5eab674c7e1e7012e
>> <2> 338     Yes   WARNING in rxe_pool_cleanup
>>                    https://syzkaller.appspot.com/bug? 
>> extid=221e213bf17f17e0d6cd
>> <3> 72      No    INFO: task hung in add_one_compat_dev (3)
>>                    https://syzkaller.appspot.com/bug? 
>> extid=6dee15fdb0606ef7b6ba
>> <4> 50      No    INFO: task hung in rdma_dev_exit_net (6)
>>                    https://syzkaller.appspot.com/bug? 
>> extid=3658758f38a2f0f062e7
>> <5> 28      Yes   WARNING in gid_table_release_one (3)
>>                    https://syzkaller.appspot.com/bug? 
>> extid=b0da83a6c0e2e2bddbd4
>> <6> 5       No    WARNING in rxe_skb_tx_dtor
>>                    https://syzkaller.appspot.com/bug? 
>> extid=8425ccfb599521edb153
> 
> To this rxe_skb_tx_dtor problem, I think I have posted a fix. Do you 
> make tests with it?

Should I file an official commit to confirm if this problem is fixed or not?

Yanjun.Zhu

> 
> The link should be: https://lore.kernel.org/ 
> all/6813a531.050a0220.14dd7d.0018.GAE@google.com/T/
> 
> Best Regards,
> Yanjun.Zhu
> 
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> To disable reminders for individual bugs, reply with the following 
>> command:
>> #syz set <Ref> no-reminders
>>
>> To change bug's subsystems, reply with:
>> #syz set <Ref> subsystems: new-subsystem
>>
>> You may send multiple commands in a single email message.
> 

-- 
Best Regards,
Yanjun.Zhu


