Return-Path: <linux-kernel+bounces-767539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FABB255BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8355F3ACD90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4DE3009E1;
	Wed, 13 Aug 2025 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mE8Qar99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CB3009DB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121307; cv=none; b=Bsb28BrScw/Z0pgdO2+Ok0OjaxLwMr3OfztiYj8l/p8Rw6p+u+ud6HgLCque6tNJVffRr67xYJYx5ipuIAYi2swsvHqxYPoT9Lp4Tkh12eR0waXNpxa9MipvrNGAdRQuN3/NmOVHtxUXvxLBWyzSlC1XST9dzhZYDqfmQ+tNWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121307; c=relaxed/simple;
	bh=6KOUN/JH6HdNhm0YMe6IlrFj5wMZhwJdq0fhZ9DLOn8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bQrz9sIz8PZeEd2WxqP6IUPjbFp147kOb8H7dxx3anKgX2u3ky4SuP4J3AxxID366O816K2ppvFgVBsVJQKY2WHwGy82khaqbySjFllivSreBXVPwprDY2C5oRu/Zi8mLK0/hA1JzMtnKOiqXncUdSd2FRrGIeLU+VlIJrvc+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mE8Qar99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E828FC4CEEB;
	Wed, 13 Aug 2025 21:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755121306;
	bh=6KOUN/JH6HdNhm0YMe6IlrFj5wMZhwJdq0fhZ9DLOn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mE8Qar99IrxUWq0u7Xc04KPMLhXRmMS3yOfUzDG2vmP5OhSPvC6Ow5+tsaYKxZlY6
	 wqMhh5RKzkAxv7b3qTD2p38mkewvPZNyyioxp8RLvfChxoJpNL5l1irPMZiZX3Cht3
	 470BetnhywGXvAWECOSx7CWn7S5A9hbaFE2xNjPc=
Date: Wed, 13 Aug 2025 14:41:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>, Qingshuang Fu <fffsqian@163.com>,
 hannes@cmpxchg.org, mhocko@kernel.org, zhengqi.arch@bytedance.com,
 lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>,
 Yuanchu Xie <yuanchu@google.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH] Fix the data type inconsistency issue of min (tier,
 MAX_CR_TIERS-1) in read_ctrl_pos
Message-Id: <20250813144145.cf6eece4d1d746568c39bd86@linux-foundation.org>
In-Reply-To: <CAJHvVchDq-p77VbzO53nNxMTZ-5okMp1SUSQfw_VD3f75fFgAQ@mail.gmail.com>
References: <20250808072106.153449-1-fffsqian@163.com>
	<91d72c49-22df-43ed-aeeb-0b93a9da3bfa@redhat.com>
	<20250811214053.857168fd35e70e73dee1583d@linux-foundation.org>
	<CAJHvVchDq-p77VbzO53nNxMTZ-5okMp1SUSQfw_VD3f75fFgAQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 13:03:42 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:

> >
> >
> > (cc mglru maintainers, who have yet to reveal themselves in MAINTAINERS)
> 
> Sorry for that, I took a look at adding myself and Yuanchu, but it
> wasn't clear how to represent MGLRU in MAINTAINERS, because there
> isn't a mglru.c, it's bolted on to several existing files with
> existing maintainers. Should us two just be appended to the list of
> folks for vmscan.c, or?

I think a separate MGLRU section which mentions mm/vmscan.c is
appropriate.  kernel/fork.c gets a mention in three sections.


