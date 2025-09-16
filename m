Return-Path: <linux-kernel+bounces-818047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6CB58C10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9624F1689BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95722AE7F;
	Tue, 16 Sep 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dSmG/y6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236BB1B7F4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991395; cv=none; b=lR4bPF1kCGLNKjJZUQvIx/3Msfcbbe+oZ2XIJgx+357VEKOyagw6tp5FInj9E4uFLXtEdrCg4twaBaD2H6Ap2ARo3gCJjFsekbqqS4jA/YmFzU3vEr7pjcpOt7rzuk0DPbwxGrh+X7a37YAJ/o5832hkIuuKKCOtj+QjzK7GeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991395; c=relaxed/simple;
	bh=Lqqfdc/Z88iITys6vH5nBM2MADoPKk2rVcW4PfRKyKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qbnjNOFemaB9HGU1kczubNLEL716pBuwYdHUt5B7TIqtaM2lyPr3xJKIMmf4NAVaZ/iQrTsvCCvdV0ksJJuMBzCa0mRyKYFttWlJx6Gu5uyBbOhUeehUb/IktbVT/JM0iEgn1zoE1seocCqh/E1E5FV7/58fCk3KMMVoZE84ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dSmG/y6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E00C4CEF1;
	Tue, 16 Sep 2025 02:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757991394;
	bh=Lqqfdc/Z88iITys6vH5nBM2MADoPKk2rVcW4PfRKyKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dSmG/y6YhD5RgWhr6cymEzxGPDHaRKB1M5O9QzE6dUQ4IJsjHs8VyuB2adLQcOgf6
	 Fj64P01S/491B0OBeAzu+I6qcHfcXqzpkEaXgZT59os1J+LxvaNatQHG0h5OD+XLGL
	 zJuYij4mJ8NY1soUO+8BgDtHEYHFis2nAq54wUtw=
Date: Mon, 15 Sep 2025 19:56:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org,
 usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev,
 harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com,
 pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters
 in /proc/allocinfo output
Message-Id: <20250915195633.96236cecebd8777243a770bc@linux-foundation.org>
In-Reply-To: <CAJuCfpFQCgQLSrzfVjV+J4tkYbOx_W9v-kWmoo-rmh5hs9gEXA@mail.gmail.com>
References: <20250915230224.4115531-1-surenb@google.com>
	<20250915171112.f71a7606a7f9fd3054662bed@linux-foundation.org>
	<CAJuCfpFQCgQLSrzfVjV+J4tkYbOx_W9v-kWmoo-rmh5hs9gEXA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 19:48:14 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> 
> > Perhaps we can tell people what accurate:no actually means.  It is a
> > rather disturbing thing to see!  How worried should our users be about
> > it?
> 
> Right. How about adding a section like this:
> 
> Supported markers in v2:
> accurate:no
>               Absolute values of the counters in this line are not
>               accurate because of the failure to allocate storage required
>               to track some of the allocations made at this location.
>               Deltas in these counters are accurate, therefore counters
>               can be used to track allocation size and count changes.
> 
> 
> If this looks good,

looks awesome ;)

> could you fold it into the existing patch or
> should I respin?

A little fixlet would be preferred (by me, at least).

