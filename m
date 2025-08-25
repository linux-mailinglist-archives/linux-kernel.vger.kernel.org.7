Return-Path: <linux-kernel+bounces-784266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF137B338EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A35D1B22FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48E29E11C;
	Mon, 25 Aug 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FbGIMlTd"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0828BAAB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110652; cv=none; b=hzgx6JS4utL19km1vor60wdvfcOl3X13OwLMGy6lfLBt03oyk66UrVUTGcHy9GwwTKwLF1jAEPz+HR/s2ggZMpo4ZIa46uVaJOGQZaYl1BezGejpyFZduCkA+WXglwStKEOhtLh7lSzlZiXH0nCahzVjA4oj0x3JspzRz5E6QlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110652; c=relaxed/simple;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=hvDUAZZghbEfYwZkka0OWbi9lZt5qNTVT2woUuCWbGcxVKBhxvOLdNjRjGvCMmk8Oinp0e0RPtQ/rnPWQXKcaPdayB2p/bNMWz5d8Kw+7L3r0PAz0+mS9xf4n2VZF1rutBVJTzp4Hi9o69TBjRWolx/m/K9I4eTThg5I59MXp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FbGIMlTd; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756110641; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=FbGIMlTd2l7IxQOc7aiGeYvNIgnK7mK3owzHC/xKFUbCzrMmm59ofJGhoaj6rXnLpxJ4ey9k0L5ev2tCUWAKiPQQ4XLbw4N/RqmCJgS68gZWCg5jMXl0ZCYxr2zeYZgWZFK6n4FeR3ugnP5acC+SvBoqVgQROLaL6Ma1ce0dUU4=
Received: from 30.221.128.208(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmT1xUq_1756110640 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 16:30:41 +0800
Message-ID: <1ebebfcf-99f7-420d-be00-606204aeee29@linux.alibaba.com>
Date: Mon, 25 Aug 2025 16:30:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in
 z_erofs_decompress_queue
To: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
In-Reply-To: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

