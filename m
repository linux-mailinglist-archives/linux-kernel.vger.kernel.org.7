Return-Path: <linux-kernel+bounces-741277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C45B0E255
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AB61AA7FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79D27BF93;
	Tue, 22 Jul 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qSuKYSqN"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9E27C17E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203709; cv=none; b=MSmMecEET9XXsq3kC3oSU+FoIgxb1plb/hTPySU6SI1W7NqHt48EM3tp3KOSZ3ZdFyuVczxzlCjwWKE23+P48QWTW4YV0mArDgYXqbUtKtGh1Mw8oUvbe4Rv65rHkuWxT0XD59KacPGBU4K7MvgXkNXmZbRh9zK/JcTeNoDNKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203709; c=relaxed/simple;
	bh=vK/01zHaEb7rQXNVgPmV0SjAJ+RqFTCi8Dw4/oQ9KnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdDzahS3sTvNMBC/OmdUKaqCpXimzH4gmMGXNJ89/x+ZLT9W1UE+AE9CzqJ6P+8WKDifng0uDq74cadKDpbgjQhbAcqNRHmqF5j5fiY/9bCn9BZs3s6AOBpwIigj+3ct95apOH+qaxl6UcZvBsF2YpQuinHDxnieJvIS3y5ofJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qSuKYSqN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 13:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753203695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vK/01zHaEb7rQXNVgPmV0SjAJ+RqFTCi8Dw4/oQ9KnE=;
	b=qSuKYSqNf10j5b+cihA/2+klt+XGV1OG2CptgAQsDdGu/Ddu2/NyFRWf+M3IwiSJV81Buq
	sR7FaNAMQ/hNFXku74kMZhEbeVRTd8fTrTtfLIIWU+Uu6PU/hS09mf7Ct1XbzA0MRRhFKw
	Sh6wUJ9YJGTdL1Z30TUBel9IroamtHE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+4e41a25632658c77b441@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_prt_printf
Message-ID: <qdgygvgppw6vqjvyxi56tqfkdakctxzbj6gly33655idvkzzju@yzxuwegnlff3>
References: <00000000000090ebe40618212a25@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000090ebe40618212a25@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: journal_entry_btree_keys_to_text() is more careful

