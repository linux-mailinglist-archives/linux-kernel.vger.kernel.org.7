Return-Path: <linux-kernel+bounces-865814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB666BFE1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49B9634ADC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631772F5305;
	Wed, 22 Oct 2025 19:53:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC27929B776
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162784; cv=none; b=LY47hcu/PUQeV19KvaHzsiU8IDqK34G5XCw8/cgQm+69OnaOp0u0UhC6SQfRuTyHV2cf33FzreLgOwYHL38eRkNZbvF5DDu6VsHe4i6WW8IXA9/RlcblODg2nK+KE6l89N7v+F0xB0uDM5WQF3eZbsupnwbe3jmoL5+Pv8vGyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162784; c=relaxed/simple;
	bh=tpVOb6QkpdgoPZOkBejZmQwCibExnOlIcGIa793DBi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCYL9pEJBT25WLeV1P/4TBw+1dshv+SJSLNTNNlYE2xxScKPEf4zhk77IjFd0I5JaQ5x9jaFiOK/RP1PCoQGkXMJhqRGQ4//ehz5mO4pIsBNSbB+M8Zpfl1JM6f0w4j4SfultNbm1kxyCpwLjDHnpNKPg5GdMO/bu8KLFxxSaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F19B1596;
	Wed, 22 Oct 2025 12:52:53 -0700 (PDT)
Received: from bogus (unknown [10.57.37.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C44893F66E;
	Wed, 22 Oct 2025 12:52:58 -0700 (PDT)
Date: Wed, 22 Oct 2025 20:52:55 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Cc: linux-kernel@vger.kernel.org, peng.fan@nxp.com,
	cristian.marussi@arm.com, shawnguo@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, s.hauer@pengutronix.de,
	festevam@gmail.com
Subject: Re: [PATCH] Subject: Modifying mannual to manual
Message-ID: <aPk2F5wwYgHqiks3@bogus>
References: <20251022194527.71189-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022194527.71189-1-biancaa2210329@ssn.edu.in>

On Thu, Oct 23, 2025 at 01:15:27AM +0530, Biancaa Ramesh wrote:
> -- 
> ::DISCLAIMER::
> 
> ---------------------------------------------------------------------
> The 
> contents of this e-mail and any attachment(s) are confidential and
> intended 
> for the named recipient(s) only. Views or opinions, if any,
> presented in 
> this email are solely those of the author and may not
> necessarily reflect 
> the views or opinions of SSN Institutions (SSN) or its
> affiliates. Any form 
> of reproduction, dissemination, copying, disclosure,
> modification, 
> distribution and / or publication of this message without the
> prior written 
> consent of authorized representative of SSN is strictly
> prohibited. If you 
> have received this email in error please delete it and
> notify the sender 
> immediately.
> ---------------------------------------------------------------------
> Header of this mail should have a valid DKIM signature for the domain 
> ssn.edu.in <http://www.ssn.edu.in/>

Thanks delete as requested. Please post the patch following the rules stated
in Documentation/process/submitting-patches.rst with proper $subject and
commit message if you expect it to be reviewed and accepted.

-- 
Regards,
Sudeep

