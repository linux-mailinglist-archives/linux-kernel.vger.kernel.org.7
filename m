Return-Path: <linux-kernel+bounces-737872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E16B0B172
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936DA172A08
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3434121FF4A;
	Sat, 19 Jul 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VqiLH5t7"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C319924D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752950121; cv=none; b=VhXRCa56pemL5YwEQES6x6CfWr5UB9mNfh4wn6ypYKgQPz2Ea9+LVDkMkxSvr3Mst7wsqhkkr++AwYEh1J7JwrPzhCMXqhBowILkUFTlzNak+qIHz2g8W3wlBcHFC1xF1a17OXiZgQjIQlv0MLQVNUNSKp+AtHrBLqAba0cjKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752950121; c=relaxed/simple;
	bh=vcQLjCPsJ6QGJeVa8vFck5L4jVlpAeMNWF4/zfnIILQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoE8SC3WWU9+ejkCf6f91kl8N7z22W/K7/pmigBeqeKSt78qeFtBhQRCnhDqkNS7NwuiT4ZEj5TEgjeIPLU/CVI+zLbp+Q9+pLW5+zY7luUEXU2RCcsaamQ27ZeoOeM/liKDDIYCUBFJ71K5WgmCVBhO7LdL3tQsIH5vKXGLBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VqiLH5t7; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 14:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752950116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vcQLjCPsJ6QGJeVa8vFck5L4jVlpAeMNWF4/zfnIILQ=;
	b=VqiLH5t7n1n9ienbUNGIoQRUBk8qpB/3J/8tpUXSr+bIN5I43NpXbn6qfi+eXQarTgistC
	/iQKnoHEISZ0gHhESF+uV37upt4gxld5Zr+9M5lrYmbXMSaPMOgx5aTb1bdvcCUuYGbiY/
	nGj7ZcIRosFCiU0+A8iTHQ2ngEmc4go=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+8eb51728519f6659ef7b@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in
 __bch2_alloc_v4_to_text
Message-ID: <t2rrvrm4o2cc5ch54rubvta7wynoq7npa2jflfp54djooepd42@jlz5nqlx6j4l>
References: <68512333.a70a0220.395abc.0206.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68512333.a70a0220.395abc.0206.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix refs to undefined fields in __bch2_alloc_v4_to_text()

