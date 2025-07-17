Return-Path: <linux-kernel+bounces-735841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66699B09454
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF95A4740
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C0A301142;
	Thu, 17 Jul 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q4e1vqJs"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E071E0E14
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777972; cv=none; b=BgSfn28LC8d6/qqGEXMsr4MjndFrJ6rNp+JlSBODOFATU5HLdWGwjH7+QpfwBJrzD2L/OlqwzW1qs5BpqYdfiIcbC4No1VdsLhs4B0dP6Ux7znLd1lRwzYh0InNHw76bACZzn/YmNMy6+JsmolIEVxq9RkkOkwzSNVZ44eqJXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777972; c=relaxed/simple;
	bh=E+4SqUCbQLuEGZwpCKJXlrX7BQDj4eMJKDjWXBfRK1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD0AjkqImYLeHSnXvNE8jl+uTvB+HgxkdmPIEhpifiUrZ4fCUe4qyHKtGGTUx4C8qRTThB3AmnJoOr2f13X7Y98xeOK0IuMfKF20jVQhA5xtt7z/vxQiDaFkJouQnc0Z3fmMXjItD7aGwBOhrHcy3DcKPN1DAdIuJXYiI0AG6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q4e1vqJs; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 11:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752777968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+4SqUCbQLuEGZwpCKJXlrX7BQDj4eMJKDjWXBfRK1M=;
	b=Q4e1vqJsP5DPSmHJAzynSl8K4rC2Co/T8G0/JUwh314SYi//zQ6P7r8A0UNBukNfozIDRM
	D5K8CNImenwd6svjVtBvJz3m7iCCONYflr9p7QC42KOvHJ7YCgdb3xOvStyfdjyV2Pdb0n
	iVGCNrCEMo0uULNXaCGDHRF9eGKSUCk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, 
	syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
Message-ID: <uenvth6s5pfulsz36nxfgg7s2nfi4wm5334edyogiicq4x54mg@kh7keqfyrihh>
References: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
 <2b10ba94-7113-4b27-80bb-fd4ef7508fda@gmail.com>
 <ammabsnegvc5m5qdj3xmydq3vhzw5igiy4fofpzyyzcwz5y7ib@rgbbbvxfxrf3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ammabsnegvc5m5qdj3xmydq3vhzw5igiy4fofpzyyzcwz5y7ib@rgbbbvxfxrf3>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 17, 2025 at 03:28:27PM +0200, Michal Koutný wrote:
> Thanks for looking into this JP.
> You seem to tracked down the cause with uncleaned rstat, beware that the
> approach in the patch would leave reference imbalance after
> init_and_link_css() though.

Yeah I discussed the same with JP and I think JP is planning to move the
css_rstat_init() before init_and_link_css() and a second param to
css_rstat_init() to differentiate between css_is_self() or not.

