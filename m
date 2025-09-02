Return-Path: <linux-kernel+bounces-797374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC7B40F8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DBC5E5C81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459235AAB6;
	Tue,  2 Sep 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="qtswnzyL"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00300258EF0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849274; cv=none; b=SYk9hC2t6ONTBXFDm3Ip6uyGgMBMW9qrQ620mhPnx87xcElBBHV56o+E5Hzmx31MJFj8ZETWJgz+3NpzlwIX/UeeX1TQOd9fUtyftCKx34uxN05pSbTBLyiFQs3lUJxWBH0Onmmu1XMf1AOpaZxDCQvs+Q1t8NjDF+9VQ+WqFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849274; c=relaxed/simple;
	bh=wS50MOhHWsnMiqonPW7eIOg6r3BfOfNZgJl6TjCqs5Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ickqKYkmo79QOOEF44KMwQUZ8/VpuQ0TqQgxWICplcuegFLoOed5L2+/a31haOjCRBAaMcnROgGTymra/oU/gWd96jR39m+ZjHet08DNnlb1iREoMOEsmjvbT+c41U4p3gMX4gBLl3D7nowvMKSi760gCMfwu9z5QKloD25EDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=qtswnzyL; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1756849272;
	bh=wS50MOhHWsnMiqonPW7eIOg6r3BfOfNZgJl6TjCqs5Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qtswnzyLDTa4gDkPdnZ2SlsbCITviKO02+Ope2Po0zVZEP2SNdsf6LULlMADetO9M
	 iSSIlodlZZT4FUxpv2WsgO/l1IxSS+U5aldV32yyepCgAkQykh0U0IeZhu4y3v/Nvd
	 Dv2RiCr7nWASh1D7XaJ5rZHml1HTUnoeJ44MgJmc=
Received: by gentwo.org (Postfix, from userid 1003)
	id 3FDAA40398; Tue,  2 Sep 2025 14:41:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 3D8EF401EF;
	Tue,  2 Sep 2025 14:41:12 -0700 (PDT)
Date: Tue, 2 Sep 2025 14:41:12 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlad Dumitrescu <vdumitrescu@nvidia.com>
cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
    Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: fix race on alloc failed warning limit
In-Reply-To: <84bbc996-27c7-4f83-a8c2-4f88b439bd23@nvidia.com>
Message-ID: <070d9527-0852-e71b-78db-bd9768ba7525@gentwo.org>
References: <ab22061a-a62f-4429-945b-744e5cc4ba35@nvidia.com> <061405e5-8670-2873-9b6f-0f152863adfc@gentwo.org> <84bbc996-27c7-4f83-a8c2-4f88b439bd23@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Sep 2025, Vlad Dumitrescu wrote:

> On 9/2/25 10:39, Christoph Lameter (Ampere) wrote:
> > On Fri, 22 Aug 2025, Vlad Dumitrescu wrote:
> >
> >> +	if (do_warn && atomic_read(&warn_limit) > 0) {
> >> +		int remaining = atomic_dec_return(&warn_limit);
> >
> >
> > The code creates a race condition since another atomic_dec_return() can
> > happen on another cpu between these two lines. warn_limit can go negative.
>
> Yes, which is why I mentioned it in the description. But compared to before,
> it should be benign.
>
> > Use a single atomic operation instead?
>
> Did you have something like this in mind?
>
> -	if (do_warn && atomic_read(&warn_limit) > 0) {
> -		int remaining = atomic_dec_return(&warn_limit);
> +	if (do_warn) {
> +		int remaining = atomic_dec_if_positive(&warn_limit);

Something like it... Maybe

if (do_warn && (atomic_dec_if_positive(&warn_limit)) ) {
  pr_warn  ...
}


