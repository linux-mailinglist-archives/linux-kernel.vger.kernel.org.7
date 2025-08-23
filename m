Return-Path: <linux-kernel+bounces-782981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBDEB327F6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800C6AC1BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE151238C3B;
	Sat, 23 Aug 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tTXMDNQi"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA68393DEA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755941841; cv=none; b=fyKC9bCumdIwfRFaicnUNZbynsvVwkchqoc9qda/NAnzmr8QY6m13mg14g2K6SAfm5TkTf2aIiDY1Oj4+f+EvFhpsn5PIhPOxbhcrdtFPd52iud6taRJBLj+Yoo9o5oTi1NJ9lHL2vUxENb0e5QdZBn5MY3eov2176Nsaw5VUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755941841; c=relaxed/simple;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CcEv8UtUvVn32nYsJaabgFzXMvugdX1gCf8MprU6wUxS2QWbQS7Fnjdp59bZ5v3GIoXYEFg2n7WTRw/a1Mbh9tf9+X7OMeDQhY8AVkqUgWLH2dVs2BudjioluI8DlpZFuPDi9ZXZYKSJYlLW+Uw6ma3/ZHnL9ycE3kfkPcxwBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tTXMDNQi; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755941829; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=tTXMDNQi9EO3sAzpqNgwZNSGi4Vx/op8ABxpBQSwVUYndDskAEWYYQ0yJW564VzGMNJi3I6DFBG5/wknbqmNDwfKaHQnuUeip0S4h9EwHejygbZ3zNnK9/VuU6JHX++wvMXag9KNpQO+Lx8PIrY4x3oWkwoXB0+NiFJN53vLYms=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmLtiKk_1755941828 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 23 Aug 2025 17:37:09 +0800
Message-ID: <2387bd7a-0abc-4c3a-a547-cdaf101cd555@linux.alibaba.com>
Date: Sat, 23 Aug 2025 17:37:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in
 z_erofs_decompress_queue
To: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

