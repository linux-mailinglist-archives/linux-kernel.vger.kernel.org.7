Return-Path: <linux-kernel+bounces-737895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D978BB0B1A3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BFF17B822
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0AF1DA617;
	Sat, 19 Jul 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WZV7gaOr"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF92E36F7
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752952668; cv=none; b=tuKgF59cvkyXfxJOujrtlL+LSy/K8kG+0Kj0koqCPYpUMsJEsxHamKeZEoLrizd3lHqkWUCqVPtz5DQ/LkJ3963GV06QNFW0c1mya/GqymipyAHVX0jNS2BbryGVktWHxOlIC4b10gvin12CTvxG1/mQ/g7mgEy22+gv32lEzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752952668; c=relaxed/simple;
	bh=OL4UjvTVM/5x3bsVR+xXj20LtMQMJDkHAGwOkWiiy+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqIvw65pLYO73ukVGyzAWqePhQ/ZTmsQXj+A7OIaiOF3DerReLjfmCFUZbUs/Fo/MlTgirnZTRDDbNeq+KcjyWVqLIC15qBP4udka/BMM40waWRJl/ByNUezjiCRrtG6tRwlfcqD9U+gLa+sR6zSiXG4qht7hfxAII2vz6JcL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WZV7gaOr; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 15:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752952654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OL4UjvTVM/5x3bsVR+xXj20LtMQMJDkHAGwOkWiiy+E=;
	b=WZV7gaOrsf1Lte1xGsV4PUBGempj/s1tAsaP0akAEuEOifkVvCiQzHI6Q7AtEfvyV+KV8r
	Of5dpnDFKcfoNqDAB5N/DUXJu8jasl0FfJlmQ6Io/QQJ5AkrSYNd0cAaIti+Xhy8Re6Rvk
	ssvP4O3oGn/2rGitsbuDpe1aniCxRMo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+fbc1f6040dd365cce0d8@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: use-after-free Read in
 check_extent_overbig
Message-ID: <sjfeetvht5t2f2th5a6vswqiirtqnbrhhy7kimb624lkjgt2tt@um3vc7jgondh>
References: <6751e9fb.050a0220.b4160.01e2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6751e9fb.050a0220.b4160.01e2.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: fix check_extent_overbig() call

