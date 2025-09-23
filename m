Return-Path: <linux-kernel+bounces-828750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25648B955B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB7189439D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A681E320A08;
	Tue, 23 Sep 2025 09:59:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47B320CA4;
	Tue, 23 Sep 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621593; cv=none; b=VsXOTZ2TYVFG+jnUGOhXMZkv4T7/G9H194b2/vohtZx0/BmjE3H35K2uMVw7xdZZi5IQ2VfRpEgnq+S9boaPyKq48E0AWW3wpXlGHjOlxEWmqWH30I8MMKlrajEffy0gZQdJbGPguy7Ce2kMXXUX1JXR+eUJ2CiEVKtCjc0P39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621593; c=relaxed/simple;
	bh=WlM1UNKJdjEPQROZEe0K8me5Dwhi2ipouQ0Tu7WciJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDDblualeyfUF/EitSN8D8DXEuBIZXlxr6uUCLoS2UougpeK6MpgcLgLgKIM8YQk9hSP27cBTD3m8WLYogWWbSMtsiO2E09Zy55kHcdk3RGVfN+/mMueBUnEZrYzBXn3jcHaKmcky1VaSgwnUftYclPwZyGd0X8PGC88snBjSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D03C1497;
	Tue, 23 Sep 2025 02:59:42 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69613F694;
	Tue, 23 Sep 2025 02:59:49 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:59:46 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org, rafael@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Message-ID: <20250923-lurking-gaur-of-flowers-bb68f6@sudeepholla>
References: <20250923094514.4068326-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923094514.4068326-1-kaushlendra.kumar@intel.com>

On Tue, Sep 23, 2025 at 03:15:14PM +0530, Kaushlendra Kumar wrote:
> Fix incorrect use of PTR_ERR_OR_ZERO() in topology_parse_cpu_capacity()
> which causes the code to proceed with NULL clock pointers. The current
> logic uses !PTR_ERR_OR_ZERO(cpu_clk) which evaluates to true for both
> valid pointers and NULL, leading to potential NULL pointer dereference
> in clk_get_rate().
> 
> Per include/linux/err.h documentation, PTR_ERR_OR_ZERO(ptr) returns:
> "The error code within @ptr if it is an error pointer; 0 otherwise."
> 
> This means PTR_ERR_OR_ZERO() returns 0 for both valid pointers AND NULL
> pointers. Therefore !PTR_ERR_OR_ZERO(cpu_clk) evaluates to true (proceed)
> when cpu_clk is either valid or NULL, causing clk_get_rate(NULL) to be
> called when of_clk_get() returns NULL.
> 
> Replace with !IS_ERR_OR_NULL(cpu_clk) which only proceeds for valid
> pointers, preventing potential NULL pointer dereference in clk_get_rate().
> 
> Fixes: b8fe128dad8f ("arch_topology: Adjust initial CPU capacities with current freq")
> Cc: stable@vger.kernel.org
> 

I wonder if you missed my response on v1[1] before you sent v2/v3 so quickly.
The reviewed by tag still stands, just for sake of tools:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20250923-spectral-rich-shellfish-3ab26c@sudeepholla/

