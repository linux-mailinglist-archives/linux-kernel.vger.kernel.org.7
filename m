Return-Path: <linux-kernel+bounces-782225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D64B31CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B8A7AC0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4DB305E31;
	Fri, 22 Aug 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D9bjwOaH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C67308F17
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874392; cv=none; b=aWhk49aTk8zu/yVLPzROy0KKPOdLe23NcU8sO8BGoVJWAEMFGJ/ylZaJ50JhEsygVSiMsnHDt70RFaeMcGnuCAK9IdYV1zMrnD03qg+fsq+kiiQ4MSlykH8sZNkAWPpfqKNx0Rz70mB7poercT0A5nAadQDbwPOzdDZTNcAibak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874392; c=relaxed/simple;
	bh=GHxncAKFvPCFGYOr2G6sIA0x8rJXcyoG88ilFq4s7HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOT7rh2EeRk/v0YUgEQb6Z3+L1ujXHmyVhYOwNlamZ7CCA5pqlEgvx7nzfxZ2MKWR8VrcU2vWiRHkiYMrFlqQ3NMCJ7M/C17avV3jtomREOEhjoWC+KIFRYZ7DCD5/ta9kHit9HFPKYFjKybY+gRAsZvyG6tQ5zrP6tdBI0xmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D9bjwOaH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A+IxoVzr/Gy0fVsugG6tFwzEXcy9WeUzEa+V/jBW33E=; b=D9bjwOaH6v0mvIcZ78K9PHY6S2
	sVK41lkk9SDAUkVmdwB6MNjDvBAPnOgjgkjSg+LJzzeWnyeuwZHsFUk4w6cqbliO1OH9Jgi1qSyAQ
	HqKz95OKnlZvwaXvJGWIrlVKJ4Tv4ipIr4Cp73O2f8mNWVofEilUF/tl0S5lDWDMLRVDaBI5yQ+Zp
	FTAzi9aUTV21lesBnDXZ/S6WanmNCLHKCoaHWtaflQI4gOkWGbT1kgwXFdjxNwnOU2+f4O984JKD3
	Xz0O6AmuUC8jLYhhCY+vN2btbtChUyDsysNUDzfKxIJ4l+ot505CPIwgdekTdBsILP29xvXt1wwUn
	Bu1/Ldcw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upT8c-000000097PU-3xNB;
	Fri, 22 Aug 2025 14:53:07 +0000
Date: Fri, 22 Aug 2025 15:53:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch
Subject: Re: [PATCH v2 0/6] DRM IDR to Xarray conversions
Message-ID: <aKiEUlldVf2YazK9@casper.infradead.org>
References: <20250821145429.305526-1-sidhartha.kumar@oracle.com>
 <f69669c873dbb99c239e9f2ddf154e983baa61e3@intel.com>
 <e80a3fd9-56ca-40c5-8ac8-237ce14cc79f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80a3fd9-56ca-40c5-8ac8-237ce14cc79f@oracle.com>

On Fri, Aug 22, 2025 at 10:36:24AM -0400, Sidhartha Kumar wrote:
> On 8/22/25 8:33 AM, Jani Nikula wrote:
> > It would be great if the commit messages mentioned whether the
> > identifiers are expected to remain the same in the conversion.
> 
> By identifiers do you mean if the name of the previous idr variable is the
> same as the XArray variable that is introduced? Sure I can add that in a v3.

I think Jani means that the actual numbers assigned should remain the
saame after the conversion.

