Return-Path: <linux-kernel+bounces-585188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED4A7909E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6C11886D4F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401274315F;
	Wed,  2 Apr 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BmhCAixz"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE61096F;
	Wed,  2 Apr 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602476; cv=none; b=mJOUMu9vBygG7xXV4+Pao6ZhGvg0ZhuH9SPlLcjX+Ca2WJlZWh58avQXCFy3puMq0CGkvZqHwjE3CQcFtVIm3svH1awgUHJzdYlPPKd/9hdtru0WV7wWlm81fED+j3l17kD85vreVEorB9WKSI5VCvdMsbuaCog41DMD8bVCIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602476; c=relaxed/simple;
	bh=Dr2t55OpW1GrH/hocApAIXTppSrYNfmY6dXRSidyODc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3BGOfGsOMXQKr+Xr/oz1h961ySkK0j1cg5zw6pE7gD1iq1olZJf2YmnIrwmTKKpkelrNp7zbUVTrzCa/Kx2sf/mdSwgS4dwuhVcROdT9cCmZubqVxs195CgrolQCcm2OJWckxUHU8uK5bMhe00OFMN6Ob2Cw8Uz3P9Ny+Ip+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BmhCAixz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 10:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743602471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8oHVQ5oCNgw1ju/7pFOtSR61vGXzimnYD1atSgbbvrM=;
	b=BmhCAixzZkdSqHpl07myyEhniPLMn5v0Acer5VqiZK+nk9EedZaV/6WvM4jMDHjoXzvMcN
	GXJFU3xYt4dd/MvCWFk+2G5dJV2F+MjCi8JB9KfvdPBw6hOztK2/WvuHystC+iemxsLago
	b5AZ5fLy4yTnqX5fcF+sXBKQewj2OsE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] bcachefs: use library APIs for ChaCha20 and Poly1305
Message-ID: <icwysnfc3v7b2hpwvm6ay6567sb5zcmcctmlt44cag6gblaylv@ubrzwcmphci2>
References: <20250402043333.352723-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402043333.352723-1-ebiggers@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 01, 2025 at 09:33:33PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Just use the ChaCha20 and Poly1305 libraries instead of the clunky
> crypto API.  This is much simpler.  It is also slightly faster, since
> the libraries provide more direct access to the same
> architecture-optimized ChaCha20 and Poly1305 code.
> 
> I've tested that existing encrypted bcachefs filesystems can be continue
> to be accessed with this patch applied.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Fantastic!

Applied, and this should go into 6.15 - this should get the strange bugs
in the poly1305 path that I wasn't able to reproduce off the dashboard
(and if they're still there, they'll be much easier to debug.)

