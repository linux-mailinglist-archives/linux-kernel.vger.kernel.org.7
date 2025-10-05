Return-Path: <linux-kernel+bounces-842386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C9BB9A98
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285603A8BB7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F541C8629;
	Sun,  5 Oct 2025 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MtoZUlxl"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA22326ACB
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759687555; cv=none; b=i+ig6sau/RUA8CMS0VZJwnGftwxr/D8zb+3sjOknMVN57WTT+su9u8UwK2+RUdzMRC+1COxpbK9tT4yo9/u7RGh15UkTKAZbMKJFaeqqzd14SYyiRFwET7az4vlbCO4WvK+nsLnH0MGCexTUa5OxVBqo8QbS4PAsu3APbG8WQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759687555; c=relaxed/simple;
	bh=3iRdRzVvK+x2gn4CN/6E93Z0mSk0RocWi5FqX/YO4/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtR03/KfUK5UycXfrV9XgzlhQ0l7KX0nVPgAltb+Y/PalRgI2RMhGZ8ENSDUxWkjw1hUq1MFbI/wOyC/KkqkSfWEYAjqCilIQLJ3bwOPxFKrMj4GQUG1T0jV3EVMV9wdpy4Soru0fjTKWUVUeLHac2FZ9pIXaYwjEvN98sbzEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MtoZUlxl; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 5 Oct 2025 14:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759687540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3iRdRzVvK+x2gn4CN/6E93Z0mSk0RocWi5FqX/YO4/0=;
	b=MtoZUlxl+xakPfzG9Q7QJnQVErP5OPihblorOMemKhPpoKkAStFfeLA0iXYkmvBx6LSkTS
	HeIDmXC/cxmEpL1hveVPfbuJZG6IhfAmIncvOrqu1BmmIpeL35Q0QlWzUDmVNyRHlDUWC1
	WSmxoqndNYwJcQ2GGmk619tem8eFCQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+55c84106264e92ea9ada@syzkaller.appspotmail.com, syzbot+564efbe31172fe908429@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs:fix use-after-free in __bch2_bkey_fsck_err
Message-ID: <nsj65dhgvhta45hng2ouj2vq4hclu52bdvlkvpzbucgmkqmacb@w4g5qzmqr5of>
References: <20251005160518.10000-1-ssranevjti@gmail.com>
 <CANNWa05YhQ9Ycr13e3SOYgD=cms5iskSENUwXUgk0T8zkMy97Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNWa05YhQ9Ycr13e3SOYgD=cms5iskSENUwXUgk0T8zkMy97Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Oct 05, 2025 at 09:38:25PM +0530, SHAURYA RANE wrote:
> #syz test:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Instead of having syzbot test your code, please try the ktest syzbot
reproducer test:

https://evilpiepirate.org/git/ktest.git/

build-test-kernel run -I ~/ktest/tests/syzbot-repro.ktest <bug-id>

I get very nervous when people send me patches they've never run
themselves. Always try to have eyes on what your code is doing, try to
look with your eyes and see that it's doing what you think it's doing :)

