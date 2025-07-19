Return-Path: <linux-kernel+bounces-737873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE1B0B173
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D631897656
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04324221721;
	Sat, 19 Jul 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OKD1G0WW"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68E1DF74F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752950182; cv=none; b=ibunuHG+DKfvxpXBI8qPj7ZtV+R56KGozmoRL9kiPxx27aeN+2mqzYXKYUDjo7vpyMztc5NHBSzCWrCf2fXjeh99f1v9XeFiZktJ+KcSFdRboGgxeU6OX0DEcnZlTp57jzGWQMQwOOphVlBRh5HbLXIsKHRwPsozNKMJ1qdvTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752950182; c=relaxed/simple;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj8UuIX33QxS8mBZHKk6JPm2DEcNfc4M5QZHR+THDG2HGe71vPvkxxOlA/+SEJ+RrjEPzT0kFqBLNq46St/EnE6mShdG7OfYYn7VJ69fn048OutjLl/GG5WoUBx1wdB2Nn/p4rVE1XM5nFrg2n92QW8AlbjbGtYN+EbRBnkA7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OKD1G0WW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 14:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752950178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	b=OKD1G0WW38y6uau3lAXVj47fg73+3aEg5/pGDF4eK/QrRilSJ51hBFID/01amtDbHDLZ8o
	vaodGVLE5G5DjFrnLWg5YOFQjQTYgjUOBLkkjX6AeDRVXxJuZvBi1NE3SdgH1HrUOcv1Bt
	eHbUPv8B2q2F9fG77Qzc6HVmcRlfSnc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+d78b3c996e2381acd902@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __bch2_bkey_unpack_key
Message-ID: <r6bi5awjusaxgmc73nn7upic7xn24tzryrtcl4mcnxt6si6gdl@oyazetidjkxy>
References: <6835d715.a70a0220.253bc2.00ba.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6835d715.a70a0220.253bc2.00ba.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Don't build aux search tree when still repairing node

