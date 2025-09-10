Return-Path: <linux-kernel+bounces-810534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B4EB51BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FEE165A50
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F4C263C8A;
	Wed, 10 Sep 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kzR6a25V"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BE321F4C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518773; cv=none; b=jERRh9//D26hxIrDNOLUfG+vOCiJbbMwEs9JzDRP2fjQyMBMEf9C7d0jL8mvuz1GSWLtsDcSPX98wiEEf6Ad1y4UB3d1wCXumxJiY3K521DbBKuiPMGbe4w3NuVFURxhf8UDq3QUPyTvovAFmLG0zw3KcVq+5zH7w5dP/DaDuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518773; c=relaxed/simple;
	bh=ScGfjgTqFriy4iKUBi4MfpAdnEin1NzVLHFkLtuzPEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZGB/alTMdGXb1sTrtE2+G7apRxjkC61zFTbZ3o61p0onQtQzOn7mJ19PLRncehMUKN8bMZxfb+m46ri2RslYqDvdeabDS1vJxT0Mh2mHghOlM+YLM5lTfwlqBJiJOZU3PHhb2fhk9DjMbUJdBiM1bsRxH8V1D2R5edRHClQIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kzR6a25V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CUutveEyfKqm5cx/LfUOapSR3j4/ulAO8at0Pp1NTFE=; b=kzR6a25VrUvMlMmbSCZhp+Czc6
	Sak7r1ylr5JNvroWqy7LTUK8Gz4Xaw4CyeFBQsOpShvsb4P0kjH2FW4KxqyUfGPl6BLsL2lAzfL1Q
	OzyoFj9V/erJWmxACdvpYck0kfmymzPEJa72mnSJDxrUCJ7Bbfz59NA0qaptSDfCS6Yr67CRdByxF
	EUeCMdMmTx3dMwpsPGXVBiKLVM1PwTga2ZazfaS7vi4p+AQ5hCxT+xKv5MZ8o6pEYOOJ/eALxvSTc
	1DEjj5nw1CdGpy9U9SmKkQgS6oEpYh5L4PhWXQKirs3U0GtL+uea7X1+aY6ynLAaVVPf30+JvV37t
	GT7DQ4Wg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwMui-0000000BFcE-3PjP;
	Wed, 10 Sep 2025 15:39:16 +0000
Date: Wed, 10 Sep 2025 16:39:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Bharata B Rao <bharata@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jonathan.Cameron@huawei.com, dave.hansen@intel.com,
	gourry@gourry.net, hannes@cmpxchg.org, mgorman@techsingularity.net,
	mingo@redhat.com, peterz@infradead.org, raghavendra.kt@amd.com,
	riel@surriel.com, rientjes@google.com, sj@kernel.org,
	weixugc@google.com, ying.huang@linux.alibaba.com, ziy@nvidia.com,
	dave@stgolabs.net, nifan.cxl@gmail.com, xuezhengchu@huawei.com,
	yiannis@zptcorp.com, akpm@linux-foundation.org, david@redhat.com,
	byungchul@sk.com, kinseyho@google.com, joshua.hahnjy@gmail.com,
	yuanchu@google.com, balbirs@nvidia.com, alok.rathore@samsung.com
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aMGbpDJhOx7wHqpo@casper.infradead.org>
References: <20250910144653.212066-1-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910144653.212066-1-bharata@amd.com>

On Wed, Sep 10, 2025 at 08:16:45PM +0530, Bharata B Rao wrote:
> This patchset introduces a new subsystem for hot page tracking
> and promotion (pghot) that consolidates memory access information
> from various sources and enables centralized promotion of hot
> pages across memory tiers.

Just to be clear, I continue to believe this is a terrible idea and we
should not do this.  If systems will be built with CXL (and given the
horrendous performance, I cannot see why they would be), the kernel
should not be migrating memory around like this.

