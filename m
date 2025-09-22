Return-Path: <linux-kernel+bounces-827898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C5B93619
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B72119C0FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B21D283FFD;
	Mon, 22 Sep 2025 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lD0HyuGA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CA1B423C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576849; cv=none; b=FyBL2uK6947YmPc4dwov0a2COdflCvfHQvcz+UkUd8gMDIhfu1Biq4dkhYkK9UpsBp1kuG2/ka+JsK68Vnjs9+wbkxaQ6AgtRRdUxtmzs2BHElLt3PN+d4VHlhRdNR7VZqyimXBxX8vbL4r433cjSLO0ZIVuMCwnjpYyyrg3j9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576849; c=relaxed/simple;
	bh=eJ5VtR70eO4BCYnBNWbIL5V8RzRuhAmch8nOpB/p+w4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KRt8kq5N3XYpby165U/c2/YkMmg99cXJfBVgRztHwfS8CNDk3X3UWyzdMOxqdFkuBL70bS4T3Ns6FUY7/g54cBFemyX0BedOV55RsTEYsDpjuYLXP1eeaqOGeSvb2EFMfBqueZFsPHV9j3BxGeuMWMF+Jj7+IXBc3LizmYF4R0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lD0HyuGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B04BC4CEF0;
	Mon, 22 Sep 2025 21:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758576848;
	bh=eJ5VtR70eO4BCYnBNWbIL5V8RzRuhAmch8nOpB/p+w4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lD0HyuGAiwZT045i1LqSR7lGe85sOzhllEa5mANNVoQBlmcrWKihlL7PNnRI5ITQm
	 ayJAf7l5W/qL0Mm0zBsJHAHIQZuwhkR4wlQd9eerZM5G/5d0MWVyS+Uddor24T/2My
	 hOoSI+h02LD/otpDWssYUFft6+oM/zRtvMMahYv0=
Date: Mon, 22 Sep 2025 14:34:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, Chris
 Li <chrisl@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
In-Reply-To: <20250922131948.GX1391379@nvidia.com>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<20250922131948.GX1391379@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 10:19:48 -0300 Jason Gunthorpe <jgg@nvidia.com> wrote:

> > +static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
> > +{
> > +	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(kho_vmalloc->first);
> > +
> > +	while (chunk) {
> > +		struct kho_vmalloc_chunk *tmp = chunk;
> > +
> > +		kho_vmalloc_unpreserve_chunk(chunk);
> > +
> > +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> > +		kfree(tmp);
> 
> Shouldn't this be free_page()?

Or vfree()?

Not sure why this code works - I'll suspend the series from linux-next
for now.



