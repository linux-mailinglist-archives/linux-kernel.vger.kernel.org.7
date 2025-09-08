Return-Path: <linux-kernel+bounces-806476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E02B4978B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBAC14E1FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444E3112C8;
	Mon,  8 Sep 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UuLquz8a"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6297E107
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353755; cv=none; b=asaaih0Zy1WVassDOoVSQh59XxkOC905dC8+v/0X+2P05aUQZB/dgXcqLu+Zpg2IDv0ml/GgKCwel+uBYUl3UWmd4hU1XXY6PhbELE3BzLh1XBl0wTRsX6lIVuR3F39Hi8JjINo8UOKPCKHlKdiVPrpr9Z9IJYjf5bHsHL5basM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353755; c=relaxed/simple;
	bh=7QLH4KMagjgfNO0NejHF/vT+Y9PWdvp2h3e0uW+njAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXZfOR7q7hN5eDTkh+Xrsv+S7NaHQoVsHTx9h0TlGTh2kX27CAJI4ycnW0YT6Eqi43y85Ten4U3tozSaPMFf9sfln8Ap209LQT7RigDz24PinuZbbxnialdi6QsU4mh5v+toJRGc1fX/2mXbmtIM2jrfibQCfJ/1Wf585G1Qh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UuLquz8a; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Sep 2025 13:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757353750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQg8gEFZWs/W0elemBVUBKG6Hh3kGDxreEQh4an/F3A=;
	b=UuLquz8aTIdheUlo1oy+JJbjcaPc4x0UA0/t5TkXgduokBYwTu1dZqeQH6phSKTNEop3QL
	eHVJia0mS2WEPE8MBGFFczFzSPjwljkxlfXQsqKh9hpgZ7Ot8MfRkgGMltaganW0QJGPvO
	sh7B4O+5owx3zgj1B+yoNYDxqrKbkLc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>, Yueyang Pan <pyyjason@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sourav Panda <souravpanda@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <uoyjzkybkqd3wkvauofmorv72gnjisoq3owvijsezpt3wbrazz@at562ngtvszd>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com>
 <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>
 <aLFKHGe2loD657fu@tiehlicka>
 <zerazodfo2uu5az4s6vuwsgnk7esgjptygh5kdgxnb74o2lzjm@fkziy4ggxrxc>
 <CAJuCfpFynEuwBSu28UiRDjWrayN-raX4Nqqh283MwRoJLi8bMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFynEuwBSu28UiRDjWrayN-raX4Nqqh283MwRoJLi8bMQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 08, 2025 at 10:47:06AM -0700, Suren Baghdasaryan wrote:
> On Mon, Sep 8, 2025 at 10:34 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > I think that got the memcg people looking at ways to make the accounting
> > cheaper, but I'm not sure if anything landed from that.
> 
> Yes, Roman landed a series of changes reducing the memcg accounting overhead.

Do you know offhand how big that was?

