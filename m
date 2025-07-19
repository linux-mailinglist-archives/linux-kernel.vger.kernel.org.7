Return-Path: <linux-kernel+bounces-737493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E80B0AD65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C714E8111
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 01:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE612E1CD;
	Sat, 19 Jul 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qiYlvQuH"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0017578
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752890143; cv=none; b=CGEilO07VzJWYI1keYQGyANf3NNXI9ehsURmQxjKURa4t065DD5O4e75dVk/gh7k+yazAnk/FYGRzzjhzkSf+9DRDn+kkArWEGl08sUvGAFyzsUX/a6cz4Sfqo/jVO0x1Z+r5wEY5AiGC9mXQ4jT4Wk6hUzo5j3FNXhVGLZI0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752890143; c=relaxed/simple;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppBunzfcYAtvwfJ2EMjd7rpiZAOCayfYoUCZgxqNuE+YgoF8deLlzgiILdGn/3m5zJUAm3S2mhtfCKhAI74+wtSVptNVYoM2ixbnD13+2ikba7KViuNHINQeRdvfK3uw7NxU8dmuFm5MPwsH02wyu0ih6/N4NQ1pX74tB9sHrVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qiYlvQuH; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Jul 2025 21:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752890127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	b=qiYlvQuHqEjkt6dphfFYuZTPK2j0rNfs5bOsrxuy+/h88+w6vqOS/cj7aimvJSXnat0R73
	mrf4kHi+w7IFYMgF/PhDzM5lqtiVuQhCGdYHusM/nUgiKLOrXV9zyJXli6UBTq6FIoxdAu
	AqYZPywkKYLfquSaQ+THMkja9LD//Wo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+3ba6dd3d414ec2296f3c@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_node_iter_init (2)
Message-ID: <65qmqj62ehtkqesre7anmexy7srvnoq2yw5vuk6cmgll3uulcc@hu5icnfydn5j>
References: <686ea916.050a0220.385921.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686ea916.050a0220.385921.0013.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Don't build aux search tree when still repairing node

