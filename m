Return-Path: <linux-kernel+bounces-752183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04030B17230
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98083A4D40
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D302C325D;
	Thu, 31 Jul 2025 13:38:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAC516419;
	Thu, 31 Jul 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969139; cv=none; b=HNft241oB2QTJYWu+MI49dV51/SuRghT0wcY9WzZD9a5HLfrSZMGZ8taNkBJ5S1cpzKIrjH2rJN/KAzg/FPGG2NFkSxjTPqCr3pwy5TGyqbhHc6tho0K1sbmCdX3cL23x+ZEF+XsXa/QXfm1X71sQdT30o6b0OZfuTbdp7G4viM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969139; c=relaxed/simple;
	bh=ci7e2K8TMiooNRkst10Nb1b1tAVYXkLUB7sPQSBuvXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDC8mzTM9K2E5LlQkkSERgq9Zgu/ElZqDIk+BH6FxIbEugWZ+95M/56vR/FZ91jIyyi0JwcdEM+HAf9D+dBrVdojCoffPyLna5Eqydri5tqWWnP6cWRx7HoXW5Eyl6H/uumIALvtEQDKkMtcHWTlWtX2bi/j6gORE9IRfCJ4yAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A5A31D13;
	Thu, 31 Jul 2025 06:38:49 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3BB93F66E;
	Thu, 31 Jul 2025 06:38:55 -0700 (PDT)
Date: Thu, 31 Jul 2025 14:38:52 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Artyom Shimko <artyom.shimko@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, cristian.marussi@arm.com,
	jdelvare@suse.com, guenter.roeck@linux.com
Subject: Re: [PATCH v1 0/4] hwmon: scmi: Driver improvements and fixes
Message-ID: <20250731-mindful-harrier-of-fruition-e7219e@sudeepholla>
References: <CALHJ+Hw_SDkpz6VpfOvD_=Z2RL6+zYSns4cm9CS889v1gmWHxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALHJ+Hw_SDkpz6VpfOvD_=Z2RL6+zYSns4cm9CS889v1gmWHxw@mail.gmail.com>

On Thu, Jul 31, 2025 at 04:21:34PM +0300, Artyom Shimko wrote:
> This patch series introduces several improvements to the SCMI HWMON driver:
> 
> 1. Better handling of unsupported sensor types with debug logging
> 2. Fixes redundant resource management in thermal registration
> 3. Enhanced error reporting using dev_err_probe()
> 4. Added version tracking and proper contributor attribution
> 
> The changes maintain backward compatibility while improving:
> - Debugging capabilities
> - Error reporting clarity
> - Code maintenance
> - Contributor tracking
>

Thanks for the patches. Please read section
"No MIME, no links, no compression, no attachments.  Just plain text"
in Documentation/process/submitting-patches.rst

I see your patches as attachments which is not correct way to send the
patches. Fix the same and resend it properly with each patch as separate
email threaded to the cover letter.

-- 
Regards,
Sudeep

