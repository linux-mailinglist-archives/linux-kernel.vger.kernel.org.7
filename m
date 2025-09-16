Return-Path: <linux-kernel+bounces-818110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07820B58CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3022A3BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907B223B605;
	Tue, 16 Sep 2025 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cb7MFG2o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB622A4E5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757996495; cv=none; b=qPaAYLWRsI/FQ9Pb7cumF6muy/ovQOiZ8OOS+zSj+1AiOoT83Ea88RYaJxqoQ8Hh/pZyCA9ev5bjamvIJg4xtuqjwlziSDAQLJHrF+IVwt0FfD2OkhXfA8K5cOE0+1KDTVm0hitytbLynt368ECTP/vB7q/HH1fOs0jg3fM0qaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757996495; c=relaxed/simple;
	bh=G/Z5ifHDwolGtsQspjGTyjUZxMgScdgLSVhJoHQXb5A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iwAxjAcn55L+8fyA8smxKrOT6h4wFELBIaAkBwRottdC6xLqa/9xjsciv7EgoS9lbkLh8cHxVMmjrmDQnDXAiQIuQX6uQbgSDPwHeVLVirKze1zVitTcTkoFjB0OiTjOO0lKIWZ41d/rHRVR3BvFMwu8RmyPEXI4N1FNLeQSjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cb7MFG2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F7DC4CEEB;
	Tue, 16 Sep 2025 04:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757996494;
	bh=G/Z5ifHDwolGtsQspjGTyjUZxMgScdgLSVhJoHQXb5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cb7MFG2o22DQBwP+aWgNGe/EYSb85/ZZVoydPgU3NyYefQiJvxaC4xxYFqmzVMewh
	 V71N/6ZuskZwVup/KRcrJs5OChrQNNvBFFavU6CvRMCFmDgxX8IVapTe5/6DekT/xc
	 +vybv7bdd7UKZorLXUN6e6f1cEuc4aSrJUkhP8hY=
Date: Mon, 15 Sep 2025 21:21:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
 usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev,
 harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com,
 pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters
 in /proc/allocinfo output
Message-Id: <20250915212133.de5b8522137a5ed30efe956e@linux-foundation.org>
In-Reply-To: <CAJuCfpH1JW8vwOFF2H2SOxZqoJHadXsTc6C=LUS_=twcf=k9qQ@mail.gmail.com>
References: <20250915230224.4115531-1-surenb@google.com>
	<20250915171112.f71a7606a7f9fd3054662bed@linux-foundation.org>
	<CAJuCfpFQCgQLSrzfVjV+J4tkYbOx_W9v-kWmoo-rmh5hs9gEXA@mail.gmail.com>
	<20250915195633.96236cecebd8777243a770bc@linux-foundation.org>
	<CAJuCfpH1JW8vwOFF2H2SOxZqoJHadXsTc6C=LUS_=twcf=k9qQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 20:34:33 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> >
> > > could you fold it into the existing patch or
> > > should I respin?
> >
> > A little fixlet would be preferred (by me, at least).
> 
> Ok, should I post a fixup patch or you will do that in-place?

I think the former, please.  Your intent is preferable to my
interpretation of your intent and we get all the nice patch metadata to
track everything.


