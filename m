Return-Path: <linux-kernel+bounces-740133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8FAB0D064
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E0D542BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6628983E;
	Tue, 22 Jul 2025 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v5lAizIr"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314D2576
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155484; cv=none; b=gadl73PuWCFmrMj0/ecezzC/8fHoboFowLh+K1o8VcA1Iu+1vg78gIddyTAAw0cWSHu+Fn5dITa28Ffhi+591VDSvGLHDa284egKId0U6ariZ5nllEE0S2EcuM7Fj0Cxdibbt64trVGYNKJvpqxdOMDAGr54FEIL5X9vCX/k7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155484; c=relaxed/simple;
	bh=/QByd6lmAgHfdlrJrctMfYFSZ8M2I3T28B+PfZ+eV6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnbTO0SApl0EJlx9Wc/qslUWu48/D1BVSBCXk0r+xv3aqpfJcCvF5aD9vKvXzWATw9jDD9taE6iQkhSRZsJgYyT+oijD09/1Ig6MjPmglcr/r0cK6ghnWofi6YvoQpp9wyUv8WGDvo9Gy2lU3trcePxn9E7T+0c0SkE5WIOV7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v5lAizIr; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Jul 2025 23:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753155479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/QByd6lmAgHfdlrJrctMfYFSZ8M2I3T28B+PfZ+eV6Q=;
	b=v5lAizIrdZFx3b0Jaz/NrGUTrLr+MNS62SnILt3UztPRSmpM7pa05Da8M88zP3hiLD7X58
	AVLo17HGfV4Tz/0tkznBgMCnzWUXZ/mbOd5W6torhnvqZIG1gnfukAY1IRsANAV6tdS4W8
	Z2m3JlglWAdsoz1thxcBHLiuZiwq9Xg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+8e47e16c9fe5b95a3a88@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Write in
 bch2_do_discards
Message-ID: <xjpesph7xntlkzxsuad6gs7rimdaj7yajfzohh2vts7fxexbzz@szbjvp65o32s>
References: <687edfde.a70a0220.61950.0089.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687edfde.a70a0220.61950.0089.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix UAF by journal write path

