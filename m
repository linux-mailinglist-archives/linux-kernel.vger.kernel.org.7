Return-Path: <linux-kernel+bounces-737875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A2DB0B175
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04E11897560
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6C221721;
	Sat, 19 Jul 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bfAwzzOL"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278FD1EF1D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752950230; cv=none; b=idPJJLSMjXBcySpQv8cH+mtRmjYEXhrHL/8sE6kRk6/gVeVmyoK+5b7oja65G1T9pN0hnFeiClJ/A+vOxkkwrvwIKp2f5k88mve+LSlq/4we4PJ3gzGdS05cRdDMF50+kCN5hTMizpy4a7xzMD/NAybH9nht6la/zqWmhjAwzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752950230; c=relaxed/simple;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohBqVFrGy/4d+PAuIOXFeoC7+YHUQo83CK027ifcTatszHAj0Qttp09iQ2S40mS6eTSBlk9TQIdOXDlqzQGerBcmATvoM+m/kMmYZtCD2Qt4t/lXgo+dt8P920GhjkE/kK65cpY5BNhAvpvNoTtIZjLMqcVFmAzKeAtxK+s9OMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bfAwzzOL; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 14:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752950216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	b=bfAwzzOLu1UoPvA8FVLn4wFRKh1B7DLuMox+dcMFW+dn2eq+elTbriYIWfXFtrz0N9vSKW
	eb9o5GnL1WRfLrX3JFie5wWfURzwFFrST2wzdkJHZQPPO5LEU9nnJIQ5shTzRnibX9esqT
	+BREM54VCP+Yu+mGw6RCP7NsPtLh+mE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+4908f37148402680dfec@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __bch2_bkey_compat
Message-ID: <eyrfxraou57woqsf4p56zqgvg6fsawaqe4tvu67am34xtg2moo@izxwy3a3fcly>
References: <684c57c4.a00a0220.279073.0015.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684c57c4.a00a0220.279073.0015.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Don't build aux search tree when still repairing node

