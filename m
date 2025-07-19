Return-Path: <linux-kernel+bounces-737878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C8FB0B179
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303F3189BAD8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD152253F2;
	Sat, 19 Jul 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qa2Phvg3"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50119924D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752950400; cv=none; b=Q939G92Juy0W+DpzW5AJnfgZjfF4RmTpN9e9yD9oRGNN/SUddgTIaVQ3KCo+22xPvlEjMI0MnqJ5OckDUstTdPYCunVG4kpUQR/8lAPszXSaw0Y6/y5ZnXSFgp7PphjSsyaiMCo9DPxWX6EbJ00BHX9mzQDVyq8Tb9AGQOCjUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752950400; c=relaxed/simple;
	bh=5p+PZ5SsqDHnWtLXR9irbtALlXuRogq/81ysSPWwdfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl3EcBzxTS6d2XxVoqntufkQP6ZbWRS8OTuN6GymxNoKTLkCVDf1ki3mbM8fiKlgaobpu6qF5kFbqq4Y0+IH4GEnbUdvAqb6Gt3sHDNkyyAZMovL1XWMspWLSO+OQJ0B2GkRfXPGBuydUQi63NQngznMpC1wwYxUHS1Ea54Lt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qa2Phvg3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 14:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752950395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5p+PZ5SsqDHnWtLXR9irbtALlXuRogq/81ysSPWwdfQ=;
	b=Qa2Phvg3v070rK/OqJEFCGzfTW3x36A4WpvrnqA2KvCc/jgmADvYaDQei2PeifxM64vBnr
	KZcH8GRAY8JVywEhm6GSkuafZBXaNn6gqOMcHX3JNm224N5WyFEv65Q5MKG+BTQT+4M5Nc
	USckaXblJmwGyqU5dZsI6dSDF4T+5Y8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+5e43fb34e0478e83681c@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in
 bch2_journal_keys_peek_prev_min
Message-ID: <2mlpcljan4o4m6fen2z3x47qwudifc6skxvld3atp4fybfm3we@ssuovfsd32th>
References: <68616ffe.a70a0220.2f4de1.001e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68616ffe.a70a0220.2f4de1.001e.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: fix bch2_journal_keys_peek_prev_min() underflow

