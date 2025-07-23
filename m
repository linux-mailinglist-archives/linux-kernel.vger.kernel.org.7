Return-Path: <linux-kernel+bounces-742231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6107B0EEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363699682C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE93291C0F;
	Wed, 23 Jul 2025 09:54:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003F42900A8;
	Wed, 23 Jul 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264494; cv=none; b=KvryFqHNq2N7ElXrM0WHDjLXpgnR1smxitR4211Oo46z3sOV4r/1JlbitcIc3DzJZLIL0cB3HUCsNSHJzdnPVPZTxIeWcgH63mIqG3FyS5Z8kF7l6le05n2UlygVYFFwRcrQhJfo0fuztLYp79q4b7ENc9f4yQnNbsDPXzOSsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264494; c=relaxed/simple;
	bh=1+q0bU0NGzD6v0spHkawyd8QAHbSPrTMZC4GiHhVfYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iISIVcKH0c1bQqr3Fc1O4UWPh4kpRYBm3oDr6Ln6UqSEM/gTLeG++CTSmtN21On5AGSOurc/RgOHrY42l8r2sXOs6j3m08yz1y+06nMQZcMVHxN4x23YHmP4a3+sHdk0ub+pXL7t4rGE+XgAS3y9gvueBduE4i0i+Ov/dzeTUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E246122C7;
	Wed, 23 Jul 2025 02:54:44 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2A4E3F5A1;
	Wed, 23 Jul 2025 02:54:49 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:54:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: Re: [PATCH] Documentation: core-api: entry: Replace deprecated KVM
 entry/exit functions
Message-ID: <aICxZxJ4P9YjJJS2@J2N7QTR9R3>
References: <20250723075134.105132-1-ajd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723075134.105132-1-ajd@linux.ibm.com>

On Wed, Jul 23, 2025 at 05:51:34PM +1000, Andrew Donnellan wrote:
> The x86-specific functions kvm_guest_{enter,exit}_irqoff() were removed
> and replaced by the generic guest_state_{enter,exit}_irqoff() in commit
> ef9989afda73 ("kvm: add guest_state_{enter,exit}_irqoff()") and commit
> b2d2af7e5df3 ("kvm/x86: rework guest entry logic").
> 
> Update the references in the entry/exit handling documentation.

Sorry for missing this when I updated the code; thanks for cleaning this
up!

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  Documentation/core-api/entry.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
> index a15f9b1767a2..286a5ecf7cae 100644
> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -115,8 +115,8 @@ Entering or exiting guest mode is very similar to syscalls. From the host
>  kernel point of view the CPU goes off into user space when entering the
>  guest and returns to the kernel on exit.
>  
> -kvm_guest_enter_irqoff() is a KVM-specific variant of exit_to_user_mode()
> -and kvm_guest_exit_irqoff() is the KVM variant of enter_from_user_mode().
> +guest_state_enter_irqoff() is a KVM-specific variant of exit_to_user_mode()
> +and guest_state_exit_irqoff() is the KVM variant of enter_from_user_mode().
>  The state operations have the same ordering.
>  
>  Task work handling is done separately for guest at the boundary of the
> -- 
> 2.50.1
> 

