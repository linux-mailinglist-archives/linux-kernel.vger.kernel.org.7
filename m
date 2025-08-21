Return-Path: <linux-kernel+bounces-780804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E47B30999
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7351CE6857
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F872FC00A;
	Thu, 21 Aug 2025 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uf+yKkk0"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025D2ECE8F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755816000; cv=none; b=TDDeGEkPAd7L5proFXwT6WVJoH3t5Re4A0nGZ45sHQ/B0JwYc8jd+nvCK8g5VfgrfQSBX4B3afT1ohIEC8SoH3Q/7tYMRZGXGynNdpPxLDY1CnasCRLDWgiwwPvts9NGOOViVy7d3FtsY4RosJoQYeQ0T5ZpK0WUmACZ7G0C7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755816000; c=relaxed/simple;
	bh=Be3ClH60P/H1hZLxj5XwyRV0BIbXHp/VxgZ0pSuY03k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAmqVJd0Jt+NyuezYuUy6qvyas3B4qk2NZZe/XJ8U1U1cuui7YXvzbBeMSzJrU5PO5zDnDXdBJINvsFnc3DsNy6GQe9P0DaxS118Vhuvj5qyfTwYaKyo/fQvnVN7lfA6YTTe/19TjxfU24j0Kz24eGY71TEGpEO2yCdLVt94RlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uf+yKkk0; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 15:39:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755815986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8XicYgOjiTvvGGkoe6RWU7q2u/gG9EiLOqy/Vb5XKI=;
	b=uf+yKkk0lkGd+LdPilwoJoT6fqhHqMP/fkewlLpiiG2lFzUdETqfLTLzi2b+NE41mz1azY
	7Vuef5ZskjXR4AsBJPQaepxaFMN53Pg1JtVAdE28ie1oEpQbgm/e3lDIf6yP1arsITF6y6
	831T4jz9a7i4vLtWE2OkvPeS6koNX2Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	James Houghton <jthoughton@google.com>
Subject: Re: [RFC PATCH 00/16] KVM: arm64: Add "struct kvm_page_fault"
Message-ID: <aKegF0XyrDF1Z5w4@linux.dev>
References: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 21, 2025 at 02:00:26PM -0700, Sean Christopherson wrote:
> Add an arm64 version of "struct kvm_page_fault" to (hopefully) tidy up
> the abort path, and to pave the way for things like KVM Userfault[*] that
> want to consume kvm_page_fault in arch-neutral code.
> 
> This is essentially one giant nop of code shuffling.
> 
> RFC as this is only compile-tested.  I didn't want to spend time testing
> until I got feedback on whether or not y'all are amenable to the general idea.

I appreciate the improved scoping around things like mmap lock, so this
seems like a net-win in terms of readability. Just want to clarify the
way this gets consumed from arch-neutral code and actually read in
detail.

Thanks,
Oliver

