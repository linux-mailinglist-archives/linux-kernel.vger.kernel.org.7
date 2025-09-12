Return-Path: <linux-kernel+bounces-814123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DA4B54F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BB53B6E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C952262FC2;
	Fri, 12 Sep 2025 13:30:27 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64A13635C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683826; cv=none; b=q2y2qQUG/NURR/OzybzXs8180Pa3LbtIwGqGURRsb71vQlfzC5cOWA78dYb71FZINWAtDpSo66lsK90WQKYmmXXOvp+2Ws7sY/kUshaMjk8WI7K3IDkOYmUbXPZH7h+oKtiqKnZXjB+AxIRxlLosFtQWkKBVrb4UbO9xKAzVRNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683826; c=relaxed/simple;
	bh=Phvf/+4TTzo2+XZPAndnu+kUC9CkpgD9w0ZXtkj7VI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fing5mrYg5JPBhZkBq60hReqV++B/ZeR3Qw8+V8/nZpGbrTVK+wJZQ7W+mVntebh0/+jImT2R3An//4Q8bTWphx9N/aMx6FQW9B+gwCwh9xGS8QW+NB3ePD6Sg1UDbqY+BUn/yBJoZjbJP3gGUxKm95ZPhRZTTqjtlSZ898AVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 58CDOWIi048951;
	Fri, 12 Sep 2025 08:24:32 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 58CDOVJU048950;
	Fri, 12 Sep 2025 08:24:31 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 12 Sep 2025 08:24:31 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/32: Fix unpaired stwcx. on interrupt exit
Message-ID: <aMQfD5M5yNmYxLho@gate>
References: <6040b5dbcf5cdaa1cd919fcf0790f12974ea6e5a.1757666244.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6040b5dbcf5cdaa1cd919fcf0790f12974ea6e5a.1757666244.git.christophe.leroy@csgroup.eu>

Hi!

On Fri, Sep 12, 2025 at 10:37:34AM +0200, Christophe Leroy wrote:
>  BEGIN_FTR_SECTION
> +	lwarx   r0,0,r1
> +END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
>  	stwcx.	r0,0,r1		/* to clear the reservation */
> -FTR_SECTION_ELSE
> -	lwarx	r0,0,r1
> -ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)

Hrm.  So this is for V'ger (mpc7450)?  What kind of issues does that
old thing have with unpaired larx/stcx., some performance impact?

The extra "dummy" larx has serious performance impact itself, on most
implementations (also on all newer stuff).


Segher

