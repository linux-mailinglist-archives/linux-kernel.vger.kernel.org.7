Return-Path: <linux-kernel+bounces-899450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E921AC57CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC01A343A40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E8208994;
	Thu, 13 Nov 2025 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWTVc56K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELhvdV3D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E8132117
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041657; cv=none; b=qToVfHx9TzxYVNMuHayU4F/GTmoIry3mQ7GlSQq7IC/hCMjUXyAqkb9DwiX9OjgCDiPfKdi79I9xPa3CDHbCabyGT+/WmFF5wCSmFXg2TBRk0tXTO8/omie/TrymT9dSqxc1utW0avkI/a/0dfBKlR3FTnvV+K3blCYYsxWEQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041657; c=relaxed/simple;
	bh=zvuIv4KSuF+si8ggFN8/0vj1DwlbmFSr98IuX/PJuyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S4osplz4ySEMuvfolxmEpTUwG08GjJxUXznaKh7ekwffjYSozyRZ0jff4rkyu9kua3g5s+P5xvRXUKQJ1Ui/ILQpzYLOnUO9mXthbWRLO8v3tckJSr97kaD7lp3H9C0i37+nTsBhPpLvLqkXIBpaicCxSL2CM53zsfj9piiA0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWTVc56K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ELhvdV3D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763041654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bfgjqdkl3nu+9pQIon0tTsyOOqARcFrleejnJYi0Q0Y=;
	b=jWTVc56KxZbmXe1taBYMHCSbYo4zm6D8AMfU9tX91XEPf6g5UD5IRvOeCmomfvjUeLu7M8
	uislhLoNSyvnqbsXiiP+33KMUfjI1QsUQViGSqDVOyOWvYO9zTwImczrBPGXsaih/yQ/WM
	c7isNeTMdOryAgpnH/tXXIy8QPuvS7v7CoOsUXBT9b+nUhe6Cj+1MJ3wqzI2M3neLjtC9o
	r7AbSAR4udD0cHlilyDezZOYnHjoSOZtNKrS3f5qD3VCVnpfntjweoaYDs41rxIQ4B3THC
	EaM5rZl9N2jDSETZh4dSSi5paMEFGM0qXHl8h3WW9HvjdWPse6AhNL2gkj0KIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763041654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bfgjqdkl3nu+9pQIon0tTsyOOqARcFrleejnJYi0Q0Y=;
	b=ELhvdV3DeaDjKc8cHTwMQnDebj60FfxKN7bQU8V3vR275fxFNvyqtY0HMVONFr70k7firl
	yMY4pxLjHNGHjnDQ==
To: Troy Mitchell <troy.mitchell@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Troy
 Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH v2] riscv/plic: assign context ID based on hartid
In-Reply-To: <20251027-fix-plic-amp-v2-1-f077b9439112@linux.dev>
References: <20251027-fix-plic-amp-v2-1-f077b9439112@linux.dev>
Date: Thu, 13 Nov 2025 14:47:33 +0100
Message-ID: <87bjl6cadm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 27 2025 at 15:03, Troy Mitchell wrote:
> The PLIC driver for OF-based platforms currently assigns 'context_id = i'
> within the context loop. This implies an assumption that all harts are
> numbered contiguously starting from 0.
>
> In Asymmetric Multi-Processing (AMP) systems, where Linux might boot on
> a non-zero hart ID (e.g., hart4), while other harts (e.g., hart0) are
> running a different OS, this assumption is violated. This can lead to
>  different system inadvertently sharing the same
> PLIC enable_base register. Consequently, this causes configuration
> conflicts and incorrect interrupt handling.
>
> Assign the PLIC context ID based on the actual hart ID provided by the
> OF node. This ensures that each hart context maps to a unique enable
> region within the PLIC, thereby resolving conflicts in AMP setups. This
> change preserves the correct behavior on Symmetric Multi-Processing (SMP)
> and Uniprocessor (UP) systems.

Can the RISCV people please have a look at this?

Thanks,

        tglx

