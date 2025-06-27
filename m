Return-Path: <linux-kernel+bounces-705763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E28AEAD7E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 05:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCAE3BFD1A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 03:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070A19DF4C;
	Fri, 27 Jun 2025 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fOrM8CqI"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C718FDA5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995726; cv=none; b=TUtiVzORtLCzbmL2GgEPht55+6JjBsqMl+anMG4i4q/CBWhvTNbIO9uDBV4V6Pe3PXFpCHtnQ7YERRtdmIZRxF6tjEQcEGnCW16Yd/Wmv35NeWWy2nA2k2LP3oZODh2Qo+5Jin7jPZaDZFLUKviAsxhopn48351zUHP5SKIRkh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995726; c=relaxed/simple;
	bh=pscJpDocHzQEwfM0ISB9o23WUvu3qh0oi9KEI3rLjQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P/YFFES3EF8Hsc+RksxZg4fnNgxk1GZ3xvVyOjbys6+SyrOkJ6I+lslcqIR/Is+rKb/UQQT5+jfoXTYUPkF6ldfugqMrTaJj5Wm06A2EKGO1oRTKwQDJsAJIQCEoHpJnaSkN+Zh/aaspDAgc2xY72ZV8lhhcbxpwj94UvCegiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fOrM8CqI; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <95a8efa9-eca2-4b07-a762-e08de6ae61b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750995711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcDbBYNskwk3MUaCY1HljWelTu7lN93TvRLSopaVW7Q=;
	b=fOrM8CqIucoMF6doyEXmS8mMCfA9GapUq8o8gsYdF3fQM33ghqaynd1s1H9G7nh//n192c
	C+/Ieh/5O+7wQ9ZltnCTQ3Yk9YlOWy21a02ORexxMKpG6GdwsV1lePIvAzptbyecwXynia
	GKsb2NEct6Z/+akar/3JzMR9v2JnuVI=
Date: Thu, 26 Jun 2025 20:41:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
To: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com
References: <685e0bc7.050a0220.d71a0.0006.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <685e0bc7.050a0220.d71a0.0006.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

#syz test: https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor

在 2025/6/26 20:11, syzbot 写道:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
> Tested-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         f648fc0a Revert "RDMA/rxe: Let destroy qp succeed with..
> git tree:       https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor
> console output: https://syzkaller.appspot.com/x/log.txt?x=14372f0c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
> dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.


