Return-Path: <linux-kernel+bounces-737879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCBBB0B17A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79DF7ABF8A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E0221FC0;
	Sat, 19 Jul 2025 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="enQbIFGQ"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66297BA36
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752950561; cv=none; b=adt/SVbrz8ncFUNVfp3KLR5Ps/l5sHmkF/9eAs5y8zeYhZ6sM2GmXzi8Ls+XOzHSjn5G6X4J6vyBGwFFZFPaDx/jnlKnBmbovctYo+H8SnzWt34RB1yqKt3f4rVTsgt3ntaZ4oJXi4yWdNm+IHTKfffhIih1h7uAQ+NimKNogMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752950561; c=relaxed/simple;
	bh=+tLKTgmWoRrvmT4xEkDoOxdZOaWizKtpVw641oljU+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiRVyvRZXGxTW+mHxdScbJ8mvWzgWsbBUEWHafqzsKzUWWzuSyhbCCbHZJoyyhrMME3Tc/ATOv+wixIeXDSkc9VBwv6rJakfSqe1UZQqhQhp4s0O7gFa5N357cekKr2Qhu9mAHDG2GM3cVxd6tCp1wtWpdiNaL3rg7aAGMaPk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=enQbIFGQ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 14:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752950554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+tLKTgmWoRrvmT4xEkDoOxdZOaWizKtpVw641oljU+w=;
	b=enQbIFGQXEm24p7siKBCimoGFRpZFi/ZJAIbF240w0leKHU5mHTDZHgyPG1KgdFNqwnzjr
	6rGoK4F2gDc5L/grwQiqTSfbAqS8KE/NzFthhkwaBgX5wWIT7N5xrpEu+PFCmDFWYpnSCv
	xXjV+ATB97nLYyHOTLnSISYOJWzP/ZI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+7b5ffa68b7af11821176@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in
 bch2_str_hash_repair_key
Message-ID: <nsk5nvwh63cjeapu424wqw7kwqrd2f7ugh52dgporratk2fipt@6menl7nk5a6v>
References: <68488453.a70a0220.27c366.0066.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68488453.a70a0220.27c366.0066.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix alloc_req use after free

