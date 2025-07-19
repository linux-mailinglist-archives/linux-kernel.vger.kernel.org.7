Return-Path: <linux-kernel+bounces-737488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD167B0AD57
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90E51C2559B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 01:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30A91487F6;
	Sat, 19 Jul 2025 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I61Ceuf2"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDBA11CA0
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752888741; cv=none; b=sIBI8aTC1DAjUUAtSizZVuFaqqWvdIFfxaHydnAXx93IqF+PLzMIxY5nhFzpRVEKuwY2JizdgFVwrkPQ9gbLA58x7rsFPeTS/ZCgvcp0cvxbdCUMjO1zMiAUQhhaGgRhuked54Tru2hViW4mwaZN8qiCTn1+6ZjRyIc6Awqqjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752888741; c=relaxed/simple;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFmI+VwvCeW7B+WDh7JVQdVoMWUh71Q8+EY4FdAYN9zfhepy3rQOBX8jtAdcm/UOeb/WNbG7ILAsPUr4YIFxSRY+BJi3pbqSrGfxW/JxGpSqsHVUsIKYAoIjOOayg37DiqJDiL3xFmE5ympQwYyuhqePRpnGWtqTk7hm1SN/NzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I61Ceuf2; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Jul 2025 21:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752888725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	b=I61Ceuf2qSgpZEwtfpnF6UFQJnlS0DcOak+lwoY18hCbZg/WwWOq5z0zahBL5AlewyU4T6
	Ij5Sum4vPsMe8S0M5d4pVpq9s0PorCw+Rx+PSAsDGHQtO9fKeOeOLbhmI9vgBVb2WO/rLH
	AYw3QbfoaET25sioipAT6m/ArTpCfOo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+5824b2660896028cfe7f@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_path_level_init (3)
Message-ID: <eu7ychmqiiteykpoq3knoa6hi2a6xlpf6fgjcp7luhowe24jxn@7iwldfn4xtcl>
References: <6766dfca.050a0220.25abdd.0130.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6766dfca.050a0220.25abdd.0130.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Don't build aux search tree when still repairing node

