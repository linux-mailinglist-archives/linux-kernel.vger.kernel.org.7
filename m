Return-Path: <linux-kernel+bounces-738030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69EFB0B36B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 05:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3CE16D6CE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2719DF66;
	Sun, 20 Jul 2025 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cmK6IOM1"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE228F6C
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752983959; cv=none; b=ntEy3GH/6+iRvD6D8Duk0pSWJfIhaMaCgdD8VfwG6p52F0cWV0Kg5qgYLbUEcThjNJ0gJLv7VtntfKpILiktpmg5K20dQdwtL8kp+K4akPblHaNHeus+FyuZTxW04fsFgTUaK9ue8xSMfcihLeM0QcdFDZtMM8QUVycs9HRitU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752983959; c=relaxed/simple;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2XfwXlfPN+HrMaaB87DPUAGy/qo8xqHiwSoobxoyf/7eb7KoZotorQ/vedPXrDA3CRCUMnOwun2bWi29lQPSf5hWwHktYo6FFQly2G91IC2ipjd5jEtNrwA2xko8Ufq+FgypUBrinxLDvApxboTpppd7chO6aeNxhRwaXUpN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cmK6IOM1; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 23:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752983944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	b=cmK6IOM1uc6aK3L3uDeT7kLarCZb9jc/bMgm3iwd2+sKgwH3MBG32q9g8JaiBAA+nGYLcB
	XVO9yCFeAu/OUR1pubXEmIKBn0T4KKBnzf5mbCHA9vLVOM5alS019QEby5K1MObfhqvhdt
	tIFuWl9oQUV48bUahh5gkgjLPq56tUE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+9b7e20f8ff98aed7254e@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] BUG: unable to handle kernel paging request
 in __bch2_bkey_unpack_key
Message-ID: <kof6sydvzhjz37rqtfiiah7bop2pbyocuodhic73qkox2zndwf@ieowah26hqq7>
References: <6835d715.a70a0220.253bc2.00b9.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6835d715.a70a0220.253bc2.00b9.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Don't build aux search tree when still repairing node

