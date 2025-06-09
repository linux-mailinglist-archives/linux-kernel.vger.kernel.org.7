Return-Path: <linux-kernel+bounces-677203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D2AD177A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 05:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F67B3ABFE2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 03:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37A254AF4;
	Mon,  9 Jun 2025 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B+DI9QXJ"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113ADF59
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749439141; cv=none; b=YBfo+RcNvllsWwovbEp9Pbo9xln8p6Jt6aa81wVR0LaRSlHNInqcM9ay2nacA8GqgwJ5BuAQYahOTQrfwk7cDS4FebuVxkrIGW1MfbGKl10XbDjm4Lsu2Vsz92XN2eQS1ih5sktxocZXdxqBt09DcUm6nZMgy5zpPTfbNUQ3fMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749439141; c=relaxed/simple;
	bh=AywIOjbbUcuQi1uyIa9Cl/kZJv4bwm/u8Gmf7oZaOV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpG/sKDK0hhJKNzUK67Sauhw58RYONbN1bIAG8OECUl1Lf6Up0VtZGMdBLyEYJK4HitBXN4zxL9DccxWc4q8JnFJtKc4hIQ7m8tsd8X9rxNkEF34hWEZE9yYFtgzEzfX6PediULmIrP1/WVhvmZOaGQtwbQTFTD1pH2Yo0WXcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B+DI9QXJ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 8 Jun 2025 23:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749439137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YymDTXPcYia5YG7vkrdN3yPoUHlGdwfgqgPigiYUebU=;
	b=B+DI9QXJD0bgV7Fm47583f2cPC98J/ashGQRJzoPuOM+LFyxnM+3DxvjyMQAfZGsQGzS2o
	dF11yVWFL698u/yfCcf58nW1fLVQhhswCFmAEe8clc1GPHQsz9te6NxBJe9QmtmMiJXnJZ
	Z9Lr1V6j2TDm213urhUD6Qako2gdT1o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+e37a1730d63d207fe403@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, gregkh@linuxfoundation.org, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Subject: Re: [syzbot] [kernfs?] general protection fault in
 kernfs_dop_revalidate
Message-ID: <esjz6hewatxgaiqdluqf2sdorpybqxcwr4c77y2fozs6plj3yx@bkpt7rrtzdid>
References: <6745a8df.050a0220.1286eb.0015.GAE@google.com>
 <684650c6.050a0220.d8705.0018.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684650c6.050a0220.d8705.0018.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 08, 2025 at 08:11:02PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit f7643bc9749f270d487c32dc35b578575bf1adb0
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Wed Apr 17 05:26:02 2024 +0000
> 
>     bcachefs: make btree read errors silent during scan

syzbot bisections have been looking _very_ unreliable

