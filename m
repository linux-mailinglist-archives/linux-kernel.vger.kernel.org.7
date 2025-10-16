Return-Path: <linux-kernel+bounces-856974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E4BE590A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922D7487E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9875F2E1F01;
	Thu, 16 Oct 2025 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3qeeEkc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BC2DF3F2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649895; cv=none; b=qfRyXN0vRrhU3kPZmJqZ6ZK8/aE0oXKSNkqMOvr89bJ1OeSU6r1W+X9IpLDPYNDqaxJAlU//v7uY2XU5LBXPzCrfJjSErD2cLehIdkMOjEU6mdas965fiB0O2aiaYaYQ6bfoZAU5X6Q+X5tmCDGArm3T+9Xl8nFxKm/uLzWZU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649895; c=relaxed/simple;
	bh=CUOlHwzmLFdqzrDkoKcYzLB4X3wtvoftco/zy4nsQ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLFS6iSnV55OHu0n6wrhKSwjMINNDst9/vMX6PBjVvyy1x+VCd2hLOnV3XbNlSZzSXxVzq6h56oLwJJ8F/6exuumA3qsH8hq3qofhg2GbEYQpHxScZ24jktQl3mQMQm1EOBWkKd/75QsqEXFCwY+WZO1q7JYdOiQhgmogPtnS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3qeeEkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C66C4CEF1;
	Thu, 16 Oct 2025 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760649895;
	bh=CUOlHwzmLFdqzrDkoKcYzLB4X3wtvoftco/zy4nsQ/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3qeeEkcOfPk9pZMoq3pE8CHmEj8NULoZCIOXSoq+0rCFXMoHDp5yikBwu3vaWYdD
	 IogKwUh8Ru91FoZ3OUyLeS3Hx7CCCRqMdSrKb+CBjscit1eaEmv1ubHD5q0/qolavM
	 Cu40xpdAiCM9HGScwNH+q7uoey4ohJtL12Tuy9vt6ok88506ty+iE8GQ1KsHvRJA0Z
	 cV60iMnu+p35yb+1pPZ5uVeSjcze0oigWyaHj/OMF2GYBBJCdoy75+bChAjq74PZ31
	 nNRMl79+jc5ecVuUgTAjhNE2dX1b6TrvWa6RHkoQ98QhSHuFPgmua7zpNiFvBY/OdM
	 1vqMKWo/l/GsA==
Date: Thu, 16 Oct 2025 14:24:53 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/56] Documentation/admin-guide: Add documentation
Message-ID: <yyzwkqzv2njelf3uhuy5x22hl7p3nvl6nilcakyjvxscccrpcm@zqnol2wanwey>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-2-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-2-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:33:49AM -0500, David Kaplan wrote:
> +Runtime Limitations
> +^^^^^^^^^^^^^^^^^^^
> +
> +There are a few mitigations that cannot be toggled at runtime due to the way
> +they are structured.  Specifically, kernel PTI (page table isolation) cannot be
> +toggled because of the complexity of this mitigation.  Additionally, SMT cannot
> +be disabled at runtime.  Therefore, if a bug mitigation requires disabling SMT,
> +a warning message will be printed.

Is there a particular reason SMT can't be disabled?  There's definitely
a way to do it, see /sys/devices/system/cpu/smt/{active,control}.

-- 
Josh

