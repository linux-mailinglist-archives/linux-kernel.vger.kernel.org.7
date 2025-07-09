Return-Path: <linux-kernel+bounces-723964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172DEAFED03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4C61C81232
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE42E6133;
	Wed,  9 Jul 2025 15:01:30 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257B2E62B3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073290; cv=none; b=kEwl6Txo7OVQuoEta8/7Twym6f0FKe+mWZfltOXc4CuJ16FmulPqWInL/XpfTt2gr1FnF/CqzXXJ3m/ye5Gfaj2ncXtVlfG8fTYsXb7MUaXEbHi/ZjzCKh+gsYeKKW7RDqrZGlKqH0ZiJkTMP3DAEgPxn02LZ66MMtEIcL72TUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073290; c=relaxed/simple;
	bh=bpO9znUDIbSsza7bwxTch2D/TEZi98z8BaN6fWJvxQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mBsMdi8BmZ7Ocihsijzf91ulKQT/EzAFzzOOOldjgEwCpHpMcbh5oMOQGoAYNFA+d7NGfD6M2umnu5hR0w5Z4FHoFHh8bLy2wErAiZjSJ2tf1ULLY8Vr+v/UYlsswqR4wkd+cdBYP2l2dW+ExWsZw7o4cV7mhzoHUeU+iC9IKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 569F1Jkm074764;
	Thu, 10 Jul 2025 00:01:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 569F1Jk3074761
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Jul 2025 00:01:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <455c8f47-58cf-4046-90ef-31d8774ea95f@I-love.SAKURA.ne.jp>
Date: Thu, 10 Jul 2025 00:01:16 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
To: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <686e8032.050a0220.385921.0006.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <686e8032.050a0220.385921.0006.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp

Hmm, mitigating stalls caused by printk() flooding is not sufficient.

Anyway, this hung task problem was addressed by

#syz fix: Revert "drivers: core: synchronize really_probe() and dev_uevent()"

but we would again see https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a
in near future?


