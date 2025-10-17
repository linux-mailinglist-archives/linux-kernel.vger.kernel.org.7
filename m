Return-Path: <linux-kernel+bounces-858099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6B0BE8E02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 614965471BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE5E3570DF;
	Fri, 17 Oct 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q9Vup/W8"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AB21B9D2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707931; cv=none; b=sjRtc7neis5esF+pCUjzxL9c5EwtZsROxXCytMWyMizItxxkKgLBsNXIDdrHf89xCY/LJo2oi1U0dkQfIb3lj/MZrDFgNrC1mjuRa/bKfSuhxjxLhrvAlvLzBxWyVSNk2psXz0pp95zkR6X6hITKVQSdOyDKK/xcmqGAObWxoNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707931; c=relaxed/simple;
	bh=fEqOZHENW101nyGGVFWjFzdvuWu8N9VFgKe0ZBvX8uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0L1s8dNgnmYE9+htioImcDyRuVqEu5ixFRatu+NdqNwbMAb7XINY0yTnenOVSJyZsL1eQmYtzbCMD46ANWGVSmqVDdR995xCi4ADPKLovQPSo0bqoruCSHL1seFKfc8yC7VvsdMDYWqhNYL33daGJCSLQTs2c3tLjM0H4iui8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q9Vup/W8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 17 Oct 2025 09:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760707923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f71h8Ye7tXtrUALo58XOTWsmozwAwRWfYyh/tabgjOs=;
	b=Q9Vup/W8a9cmOFck47SPsREgIvYAYt7cHBTLPtr8ym96HlcL0QzoMMSjlUuMJTGLxA4rUl
	il1wzkp4YmtDah+1LZBlY+k3BNVD8ZwovZadjXQD3bOSxYK6B6HO4TLmZ1g6DjurCCF5ef
	LBbC0vbMDe2RZr0X+hivKOItG1fy9JI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
 <aPHemg-xpVLkiEt9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPHemg-xpVLkiEt9@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 16, 2025 at 11:13:46PM -0700, Christoph Hellwig wrote:
> Umm,
> 
> besides adding exports without in-tree users, this is a patch that's
> never seen any relevant mailing list, in a pull request that the
> maintainer hasn't seen.  That's now exactly how Linux development works,
> does it?

Christoph, I wrote that code /for bcachefs/; the rest of you decided it
was nice and started using it too.

Then you removed the export talking about the "abuse" of bcachefs using
it. WTF?

