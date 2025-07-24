Return-Path: <linux-kernel+bounces-744503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720CDB10DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E041C82E72
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5ED29188C;
	Thu, 24 Jul 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BUINWzMQ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3C29A322;
	Thu, 24 Jul 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367613; cv=none; b=Luivb/2rwXKrNEu2npZ3kwq3SHR67/grD9qplkkW2tl8G4M1zKfOkgwZKYkI1RQ9rNhNuQ8evwECjUcTO7VbgnLYsoSrA0aDvQZE4+nIv6gTCVlpNKo9G8SKwgjUAFaq0UfNNvkGo9jjdQhmiraEdezi1r3JyJiYO9a9XSgjTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367613; c=relaxed/simple;
	bh=rUJwBBAUQEEqyKlpjVDavNcXrFv5Cy+99Y9n2/LQFf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PF+WhrrvHxW8XeyTM2Uf0zsfVN4kt9Osy7UDMgOAqbVf/YBBCvuth9vlyuco2f6izDNGBIjvlC1sh8jl9BMQEFkt8e5MVB6Cg142UecKPae6aomJJxHzeUSZEk3hRwfHLxIoZIz3BEAEemGaVzbWtMhbPqQKVtTXxGONRriMWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BUINWzMQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5E4F640AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753367611; bh=nPoIBJN1Ou0uygaKOU2F3YgTZVT9cVGYPIf/TbVDYH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BUINWzMQg1pJvWvVmOK8vVclG2xk6Kgp1uAMbs4bzxV+mlrJoG1BJH+XzGYb+pKx9
	 HTi6C2tzngRL1w7YJPgybRdtIHT4Eejw4jf5vo7h0hAyOQgoSoKoyLIE/qUX5ULZaX
	 KGgYygmE050hxzfdz7nyo6dyBrXfS8kYViID62/RbTzE2EgMJS7mIKvG6oYWVQMB6S
	 M9k0H7OsIucHWUPO+OvFrVbawQeTywB8WPJolov+oLR67og0/Qj0SjJudWw7s46Vvy
	 s87wP8O/KxO0HUdwCmWOkOMdJUo4KxF++GF614Ti3rlq941DlhCi0HK7wTOQ5OolCz
	 Zh/4bGoSVAfjQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5E4F640AA9;
	Thu, 24 Jul 2025 14:33:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andrew Donnellan <ajd@linux.ibm.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Nicolas Saenz Julienne
 <nsaenz@amazon.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] Documentation: core-api: entry: Replace deprecated KVM
 entry/exit functions
In-Reply-To: <20250723075134.105132-1-ajd@linux.ibm.com>
References: <20250723075134.105132-1-ajd@linux.ibm.com>
Date: Thu, 24 Jul 2025 08:33:30 -0600
Message-ID: <87ikjhacat.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Donnellan <ajd@linux.ibm.com> writes:

> The x86-specific functions kvm_guest_{enter,exit}_irqoff() were removed
> and replaced by the generic guest_state_{enter,exit}_irqoff() in commit
> ef9989afda73 ("kvm: add guest_state_{enter,exit}_irqoff()") and commit
> b2d2af7e5df3 ("kvm/x86: rework guest entry logic").
>
> Update the references in the entry/exit handling documentation.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
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

Applied, thanks.

jon

