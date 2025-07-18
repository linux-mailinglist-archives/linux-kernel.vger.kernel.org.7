Return-Path: <linux-kernel+bounces-736880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCA5B0A491
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88D25C04D7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DE92DAFC3;
	Fri, 18 Jul 2025 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="WLuqDgIY"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D52DA75C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843435; cv=none; b=W8I8q51BJ9klQn8y02yMUUYcSnvyMU40kChWV5IJCvit7FqGswx1x/RJHw5attINhqLo8Y8PiQCwSjtTI3YY7fbNrDUS6U3TZD1/UbfViJbp50D4VYfYPiIFrooR6mi730Em+EaXbkOkPcbm3oWZTye9DGR8y4nhKXzZyVcwLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843435; c=relaxed/simple;
	bh=FH1pglRH3yAZRNLGE3tPi+sWRv0MyE01bV+s+YUV5QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTCc4U/ihkAJKfVAhVN9qmOyF0xWW/m0NAuWfjqbhXhGJ2CTWPFYMcZbzbVjI4wJu3PG+zXp9ZeWjfNpQmcpwGC67w+Ine5575lLYQEMWElYoiZ9q5JCFS4v5XQGM6lPot5c6xO19jgHXmxZfoTeyUiLWH5iAlKNu9E5Q2a4V5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=WLuqDgIY; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752843429;
	bh=QsntRwVuTNW3g2lel1bEzTGGy0quz5L7jFv6tl1mAeo=;
	h=From:Subject:Date:Message-ID;
	b=WLuqDgIY4a2ow5WDq6MtHY23Z41L5bBxvfP/lKPzoTLyHD1zn811P19ViqEyz87q1
	 vEzjJzOLZqzVxjUibgoFzlxMRcees2hLUcPv9yn9Nke7Yu8SrAwzieWmAd2JCiIMQf
	 wgoDs5+KusNlIKxnjrsWOiNSTjr9ckS9YclQTcjI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 687A449B0000154D; Fri, 18 Jul 2025 20:57:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2693856816076
X-SMAIL-UIID: F0315DC85F164657BE537261CFB111D7-20250718-205701-1
From: Hillf Danton <hdanton@sina.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org,
	liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot (2)
Date: Fri, 18 Jul 2025 20:56:48 +0800
Message-ID: <20250718125649.2411-1-hdanton@sina.com>
In-Reply-To: <1b307a1f-2667-4f06-afab-a49061129e77@lucifer.local>
References: <20250717014623.2253-1-hdanton@sina.com> <68787417.a70a0220.693ce.0037.GAE@google.com> <8a2f1892-3184-4aaf-91ea-522e9ba2391b@lucifer.local> <20250717234212.2329-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 12:08:44 +0100 Lorenzo Stoakes wrote:
> 
> Go away Hillf.
> 
Are you paid much more than thought lad to do so?

