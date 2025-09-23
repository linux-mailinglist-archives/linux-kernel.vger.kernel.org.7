Return-Path: <linux-kernel+bounces-828773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A63CEB956C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479167B230E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1831E0F0;
	Tue, 23 Sep 2025 10:27:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E685130FF21
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623272; cv=none; b=gvR2OhYMW/JgsxB8MIOBmho3C4v1t9OVtUgoE03cLGMeMgVpfCYQRqaFA0SRw7oTdZrrDSCoMBB5CqUweLx0K0DD7tdNWpaBmVctBqNLaxyPRkZVZcNDbuG62RoxKJsFbB9w2DTqvoEp83qTnPJvOZVIjBA82fPUKT3yz0bdrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623272; c=relaxed/simple;
	bh=6uzYAkqcZY7up6Z9yeIc9M2PzLa/cL35+C7OlEQu1FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAwcT1kkorv6mz9b6VBB8SH1TlEhL5VdKpX20SbSsQQIk0Q/8AfDbA+crXgAzgGKRvKrgYkUTeOWAKv8g16Wx43zHLUc29PZX8Sv+CLtwFgjpxVUsMQIuA3U1KT2Y9AqX8ByY/GuFzIWuuHBnzkXHpctqv4KIACajHf4QoOdg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 144D52F;
	Tue, 23 Sep 2025 03:27:41 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E216E3F694;
	Tue, 23 Sep 2025 03:27:47 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:27:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>, gregkh@linuxfoundation.org,
	dakr@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Message-ID: <aNJ2IX2vuF8ZOmGj@bogus>
References: <20250923072520.3964688-1-kaushlendra.kumar@intel.com>
 <20250923-spectral-rich-shellfish-3ab26c@sudeepholla>
 <aNJ1aY0AuATEKjDN@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJ1aY0AuATEKjDN@stanley.mountain>

On Tue, Sep 23, 2025 at 01:24:41PM +0300, Dan Carpenter wrote:
> On Tue, Sep 23, 2025 at 09:40:28AM +0100, Sudeep Holla wrote:
> > On Tue, Sep 23, 2025 at 12:55:20PM +0530, Kaushlendra Kumar wrote:
> > > Fix incorrect use of PTR_ERR_OR_ZERO() in topology_parse_cpu_capacity()
> > > which causes the code to proceed with NULL clock pointers. The current
> > > logic uses !PTR_ERR_OR_ZERO(cpu_clk) which evaluates to true for both
> > > valid pointers and NULL, leading to potential NULL pointer dereference
> > > in clk_get_rate().
> > > 
> > > PTR_ERR_OR_ZERO(cpu_clk) returns:
> > > - 0 if cpu_clk is a valid pointer or NULL
> > > - error code if cpu_clk is an error pointer
> > > 
> > > Therefore !PTR_ERR_OR_ZERO(cpu_clk) is true for both valid pointers and
> > > NULL, causing the code to call clk_get_rate(NULL) when of_clk_get()
> > > returns NULL. Replace with IS_ERR_OR_NULL() which correctly identifies
> > > only valid pointers, ensuring clk_get_rate() is called only with valid
> > > clock objects.
> > >
> > 
> > Nice catch, wonder how it survived so long unnoticed.
> 
> I don't think of_clk_get() can actually return NULL...  It's still worth
> fixing but I don't think it affects real life.
> 

Ah that explains, just looked at PTR_ERR_OR_ZERO and wondered. Thanks
for the details.

-- 
Regards,
Sudeep

