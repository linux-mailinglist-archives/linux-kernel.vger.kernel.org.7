Return-Path: <linux-kernel+bounces-819240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA513B59D32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B96189F246
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF976261B6E;
	Tue, 16 Sep 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c2CJmzf/"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7529E0E6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039146; cv=none; b=fr+rz+LvzFT+BblZSoNMnANb5nVDpNVuLvqh/kuQ7ml+oAJej55VBT3Tgoz1SvgUhVN3EhibgnxzgEz85QqrdxfccbyuAaH9q3KlETzOFORWAR8Pg0OLAQNwBgd7ummk+ww1PkhdqQ3Xcz+iqcdYxXXBEGCpIYi4+aIT/m/alq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039146; c=relaxed/simple;
	bh=3HhiLsyeum/ghf4jQlf5L0DSwAfLUJFR6O0x5ha1FcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BUaM2b5MRem154y3ZBWmzH5U+huL0dwZQXgbww+GodCwiqcIUBnM5FH/UWaOdfDJf5E8ATnIHdJw7xQo5zP2qcQ45OLfBwTE17JUlXDb3WYUSWWqrlFNyagLYWfuolERz27vbV5wnkHPrAQL8AFyQZ2jsLRCjzgjZz1l5iiNqtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c2CJmzf/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6bb7aaf6-acb0-4130-ae0a-3d2e2f1f14de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758039141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZEcQoTQDPSmAagwrHkOdXWgn9ssRRfpv/33nsMW05o=;
	b=c2CJmzf/s/2tHyNmo821h4fogjWaLwdZNd8CrfuE7cdSUzNxd9g21ANjDsWjgCC9kuyx61
	m0dCRcc1aPDNKrSjbPS1GwcTW62j25WhhtCpsZDX3Hs+6JBrivpDQ1vCJldis2gPPg7BHx
	MQrZunhsFuinfAfCmJnA7rZ9QwjCBM4=
Date: Tue, 16 Sep 2025 09:12:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68c986b4.050a0220.2ff435.03e7.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <68c986b4.050a0220.2ff435.03e7.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks a lot. I will make an official patch for this and send it out 
very soon.

Yanjun.Zhu

On 9/16/25 8:48 AM, syzbot wrote:
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
> Tested-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         cceb4136 RDMA/rxe: Add logs to find out the root cause
> git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
> console output: https://syzkaller.appspot.com/x/log.txt?x=1242f762580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

