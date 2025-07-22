Return-Path: <linux-kernel+bounces-741348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BD2B0E30C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBF41C85AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9609280331;
	Tue, 22 Jul 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J/IILUcw"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE128000D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206687; cv=none; b=uYTQrhlqM0pQMiuRVHvJDWVOB9I8Cz96lWQewcpCrGR1YmwYeg1h1DzgH45vun7Yy9h/FPCvpqEGxx4kHQIOhFR7nEciu+ssf0bSmlyV2AqmoNZMOHTEvimd2IudRwcVsB0q4UPcjvAi8ibwYTrxwX0m9l3NpoZi0XzzgZxtV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206687; c=relaxed/simple;
	bh=NVoGqW08S7WUYuM0Cn/NBmzlwZZ09oOVBf/8xv1lG7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fvyyp6prpBxF04EZi7FH7fQtlNfkxyGynsy7FcuDt3NTsu1thSENDhQh8b6bVE59r6CgSFf/ho6Iq9hzr07l9o6bZ8CUnHHYug+bDiMtZW/CwPkiNHuU4l6qcK8Jtf6KSOQE8TMmIVNG0khNUg2BbNZWGZvQgQar3YQQvWNdbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J/IILUcw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 13:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753206681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NVoGqW08S7WUYuM0Cn/NBmzlwZZ09oOVBf/8xv1lG7g=;
	b=J/IILUcwh/FOrwHHAM/LXOdgtqV+KTJHPMKfctfvpEimvSVLG88av2H9nfhT6/GI86ewc7
	hiu6p7jYwCD6JGQ0yeJxfpCZrui2KYgAgK1DsEVmmc3ILVadFNYC+1Lx/bV4vff+4Ldx8s
	R+LXaMFU4Jv160WxS2KdcLKoL/j6qdg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] INFO: task hung in vfs_rename (2)
Message-ID: <k7mpottkzjgdpjgagsw5vrmvgwyz6n2zg3m7b47utazirmhqui@qty6qmna726g>
References: <680809f3.050a0220.36a438.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680809f3.050a0220.36a438.0003.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

Here's another one that someone incorrectly assigned to bcachefs (and I
can't find who's doing it, they're not ccing the list).

But I've got through the logs and there's nothing connecting it to
bcachefs.

#syz set subsystems: fs

