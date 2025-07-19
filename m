Return-Path: <linux-kernel+bounces-737836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABEDB0B117
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412B1179A68
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD672286D7A;
	Sat, 19 Jul 2025 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YrqmLRbY"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143FA1E522
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946514; cv=none; b=I7aiJpVjux8zGxT5UCCV/zbQjg1Dvtk7X8ia1MmZvFmHnfdDicH1jCrJrKn+mTA4ttEDfE7pjBzt4X9mgA9/DRdulIeiq+2tKV65w65RJwMCB9YA6FU+rug3wwHBXUU6QMJT4gO5YE+BISixGhK++eckQeI90Em/+s7iBQ/mQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946514; c=relaxed/simple;
	bh=xvRXDi6I7bH838FXYg/+BfhiQMF45sAu4BFnKcKYZeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eag2DSY7ejFomUpe5zL79SVNQiDFodilp5uSKkMZR4YSD6N4BW5OfH70Bwke7LuNxLO19fsMT00S7/VoVIL1JsQiZwzE7wBLbdOFaXIyhuWGwg2BwPepGG/hYtXnUHsLW4u0Rc70V/osQmvz92tANiEGBe5wnXSQe+zj/3bIQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YrqmLRbY; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 13:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752946508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xvRXDi6I7bH838FXYg/+BfhiQMF45sAu4BFnKcKYZeQ=;
	b=YrqmLRbY5uJRvPK3OPwXb5pisE9umsWxB6zNNulF4pTSDt8FYvEGuStQldY6n/lNnqcJ4w
	kNEL8a20hpW+YRGNbKr6f2lTGUnnr44TA2EgpsSSesm2AFj+9I/tTSSDQAlYP23MdW08IM
	UNORLujrKEVtboC8J1kvAawXF1qET80=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+2b98caf09c41174a9697@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Write in
 bch2_get_next_dev
Message-ID: <nxgsgizgeja6265rgz3uezzpgy33toz7aiicwy6uf5g5orhbcj@qmqipkujhg5c>
References: <687a71bf.a70a0220.693ce.006b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687a71bf.a70a0220.693ce.006b.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

Will syzbot reopen if the fix is still in linux-next? Let's find out.

#syz fix: bcachefs: Fix UAF by journal write path


