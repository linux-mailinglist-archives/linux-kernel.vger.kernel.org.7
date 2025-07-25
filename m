Return-Path: <linux-kernel+bounces-745441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5117B11A07
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092B916F009
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B279E2BF3C5;
	Fri, 25 Jul 2025 08:36:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FFA2BEFEA;
	Fri, 25 Jul 2025 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432567; cv=none; b=B/8eU5cycofv+Sl8E6IWZ3qLQPMRFGWwIjTUlKpMgiQGWHdO40N1YIMN4B3bhKrxneu6caCJVgRglkWEOANSD19pL+KAPtoPhui2gZaP+Yv3t6JydqXgF9ltdFJ062TycPPdsQo1bCZgCtF90SXyYQjol94rKfP2bj1Yl8mVPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432567; c=relaxed/simple;
	bh=cJQS8lbXyn1E0/VlT2bt0JOiVdthkOPUe5hZKO356CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy8SrU7te2/lYPlqU3Q++ZWoJxMiburJiO7eIRaMVV67+nWdXXtg/4lX25fZ2dXe4e95J/9Kipk8RTHrOkwGj5sOREcu2ONBS+cCVH+gGOpQh3pmMkhoxRONt1T7PQqjaRgbC48ZpHdft/M+1/Lp7hbJgtTSPPakh3w64/GtUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7B9C4CEE7;
	Fri, 25 Jul 2025 08:36:05 +0000 (UTC)
Date: Fri, 25 Jul 2025 09:36:03 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: allow NR_CPUS=1 for non-SMP and adjust default
 accordingly
Message-ID: <aINB80UeE9pqKvrC@arm.com>
References: <20250724165639.13926-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724165639.13926-1-suchitkarunakaran@gmail.com>

On Thu, Jul 24, 2025 at 10:26:39PM +0530, Suchit Karunakaran wrote:
> The arm64 Kconfig for NR_CPUS previously required a minimum of 2 CPUs.
> This patch changes the minimum allowed CPUs to 1, enabling single-core
> non-SMP configurations.

Do you have such single-core system?

>  config NR_CPUS
> -	int "Maximum number of CPUs (2-4096)"
> -	range 2 4096
> -	default "512"
> +	int "Maximum number of CPUs (1-4096)"
> +	range 1 4096
> +	default "1" if !SMP
> +	default "512" if SMP

It's been some time since we forced CONFIG_SMP always on for arm64.

-- 
Catalin

