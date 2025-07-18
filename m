Return-Path: <linux-kernel+bounces-737308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC51B0AA92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654A57BB26A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA362E7F19;
	Fri, 18 Jul 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BLP1CKiL"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26FB2E36EE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865947; cv=none; b=nd8T5Pv+TY7YmhrqWP0Fi0Rg3r8DOHB7Bc0mPnvjix25XVgYLvnEmmyE4l3uO/Vqy9f2xrYX2EHwAxGh54nzXc7C+yzlQuTNztn2a3vyT9usPYubAGbiqgwysUHLFs4QfgJbGa/2ncsbo3m05CoWgUY6nbgIytYGdlBARBa4wLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865947; c=relaxed/simple;
	bh=bKnN9RrMlAtIOWt48FIcqVDHN3u1j94bB/HjQ6R1QFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2FleOBUMicv11vIYlk+5GihmHdR/B9+Jy1iSL9zpzMijcn/SqWOsMTipvKZAD7MzybwCGPO2fwljzWPtC25ZNODRg825EWok9ONsb/ch6jFz48W/X/lbX2zCuIiX3DuMdeTbKmz1C1lT25c1BhGgHqBwAVwKUmnM9/+7kLrqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BLP1CKiL; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 18 Jul 2025 15:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752865942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKnN9RrMlAtIOWt48FIcqVDHN3u1j94bB/HjQ6R1QFU=;
	b=BLP1CKiLJLda/C2n+z8YOT9NtrEaUpb6zao3AxXxnITmaPxnvaPNlHWY8DktTB9JQ0TRUJ
	u7kd41P1I8bhUTQrprzvvDT6RO7y8pFsrCWE8TpOcKHI5T0FLhLSIfs/z2zlLEqv0zxbWR
	gmgdjUa/OuVd1g5xCHjTXwphDnCEhOM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+6d52ee9afea131b36348@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_dev_free (2)
Message-ID: <aqrnbpyywgfg7t4mq5mfzwfgh3lgzsrzc27mlvgenf3swszkdz@2aj37hqzkbp3>
References: <68794b5d.a70a0220.693ce.0051.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68794b5d.a70a0220.693ce.0051.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

Fixed version is now in linux-next...

#syz fix: bcachefs: Fix __bch2_fs_read_write() error path

