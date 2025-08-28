Return-Path: <linux-kernel+bounces-790033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB90DB39E88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEE13B4746
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DEF3126BD;
	Thu, 28 Aug 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AA6aZicn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9F42056
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387114; cv=none; b=DlehRs4o/FbUCvw368l24Itjtk4+7evHsXq7qWMP6WSYtDGomSFG2FhOttbpMUZIkRTr5tP81DN7rmwzgsj/wY6xM2fkkpL6CHhN5ZVkeFVNgyF5EJj1eenn/NpSrEyoGyE+d+op+uhAZD5SBEqLed427SatakeYeKegDzcyswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387114; c=relaxed/simple;
	bh=XcoBo3H+BNQNRNov4HOkN3jYNXFe/WXV6FincB0nhmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+Cna5EL2/VxzDaG7CMkR4tdvXreGCCaThkJlC9qDOqVmPdFDHrQb5XhiPhzzItVnqzIFSi/Bexs2YSOZyIZ5By3shzzyG82u6IAl4Jt4rw6cldcPrIQqp4LZqosZb2C6sKPB6LM0cqd5PkmWF4KxceMHVoKmnl3Gk4uOFHOScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AA6aZicn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+vvOf6v/zjtRXt8HqZtrkk44ara5iQUCVMYQ1W1HNYo=; b=AA6aZicn3N6vtpboZCKputB0E1
	l7qoAXL3SPlXrTrudVNcijrTEh24g4k8lSNmeoJPxzC2OB/DuGI+tFtTWAyN4b5EblAGJE+hVhWOq
	cG53g4C1D6Rh2mkDIf63sKTnmyuR8IHsCUevTJ6ZWVk6ib7Z6rCJ8UQOnaI8Dco+xfqg2nd0RkJeM
	QG9dFdM8LfvG96nE+d2vrE6ZBLVLWmZoaL6Fb4snY/lwjPJRZQCzY8Aid8lgazvWFmQ6NO2dVXXXw
	VK5Bqqz6wWB+w+/KTW9UftbIQ3Cmw1JONy+6OUvVWb/zH1n0Y17hgeXqL/JdrH1LjJVSWH2F4wVIp
	yPVXwBaw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urcWD-00000009ubJ-3fJg;
	Thu, 28 Aug 2025 13:18:21 +0000
Date: Thu, 28 Aug 2025 14:18:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pagevec.h: add `const` to pointer parameters of
 getter functions
Message-ID: <aLBXHUSRAfdl9_HZ@casper.infradead.org>
References: <20250828130311.772993-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828130311.772993-1-max.kellermann@ionos.com>

On Thu, Aug 28, 2025 at 03:03:11PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I have a pending patch which constifies compound_order() and page_size()
so you needn't bother with those.

