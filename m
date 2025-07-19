Return-Path: <linux-kernel+bounces-737896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23729B0B1A4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C341418877AE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861A521770A;
	Sat, 19 Jul 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bm+6URyd"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3A1E0DD8
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752952757; cv=none; b=L5hardeCTDcJekw9jam+F8yavOltXblgnlzysW/TTYShohkl774691FtctcMvPCytr3HHYRaxM7ne5Y6BGPrvpTDGvZiCbBrw+cgGVM6wGD7rJ/vEZcNlZ3OzrMD2Gkx++g8QtPidQPo6/kQ1j3K/jFILnSIq/yxQmwYhXeeLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752952757; c=relaxed/simple;
	bh=7VomRB47AMR5tGJ88m9LKb3S1UgMpd07gsPZqIg+Ko8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYFRKE60UpnE70BqJ/Zh1/wCr/fpUtOKPRjxa1C6gyWyNQ58/v6tEfbqk68T4u9oMoBicQnJoDsNBE7MexKoNsSf/0VtXwxs8+vfTayvxX2Dd6L4wARSl9kGkBtxZhtWRqupncaaTj03Iww+jhBu/jy53sbpjKFA1cJnW6EqdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bm+6URyd; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 15:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752952752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7VomRB47AMR5tGJ88m9LKb3S1UgMpd07gsPZqIg+Ko8=;
	b=bm+6URyd9+jWp0pcxc5xvX3XjwuO145KBN3r12XFqFZNoKlyBD5dXvDQP2902VjNE6AMGv
	ep6UNyljSYkK/kXX34afgMy5l/aX09NwRAM+Lazs7b+TXM4VwYZvYSjcjMJDxnWQ9yPyvt
	nGCBfGjR8CN30SXeiFvgLBUxXPFD430=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+87078ad27cd8af3263cc@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: use-after-free Read in check_dirent
Message-ID: <igoha74mbp7v6wkxv5pfgremooewlj7awznvptg6xk4ju6mjcn@wyndslsikfux>
References: <67b8a9a7.050a0220.14d86d.0578.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b8a9a7.050a0220.14d86d.0578.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix UAF in check_dirent()

