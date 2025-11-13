Return-Path: <linux-kernel+bounces-898722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998AC55DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6C264E365F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9345830215A;
	Thu, 13 Nov 2025 05:52:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BA3002DE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013154; cv=none; b=nsYMYrkSccTw4xM5lggOlcMy5gPIgt9Cg8yISkU+Q+ZO/gp9Ln2skA6Z3doIEIBRa2xYlEL7pDwVEaoC2SqeyI9lIe03Y0FXjdDqb0/SZKBmGXoNyfhHb7/TX2IdWiNjFCubFKnPw43FrkUbaCMisSO5blwjwdy/gcvo6Z/STJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013154; c=relaxed/simple;
	bh=bw567ZUR0Hz47Pqemu2n8kqjoeM89fkOTQMvUCIgltU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJWKP2BjqhRafdetOkpqEBaSWJyT4IrWc3rMtq2OVtMiwIkkrL3DuEl9NEtmDD5n55iuNIqN+go1UHSn3drYMJMKfbOo09H4RpGQ1LJLvDmD5FhJaWMKvG87onC+5pnXzyJFP8lS5oL+FlZL3yBahWMytb4CNIDhs5+PIjoY+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CADC967373; Thu, 13 Nov 2025 06:52:25 +0100 (CET)
Date: Thu, 13 Nov 2025 06:52:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: mempool_alloc_bulk and various mempool improvements
Message-ID: <20251113055225.GA28909@lst.de>
References: <20251111135300.752962-1-hch@lst.de> <48e45106-f76a-421d-8f9c-645469076ad4@suse.cz> <20251112155011.GC7209@lst.de> <20251112173405.GA2935281@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112173405.GA2935281@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 05:34:05PM +0000, Eric Biggers wrote:
> That sounds good to me.  Sorry for the slow review on the
> blk-crypto-fallback changes.

No problem.  I've got enough on my plate myself..

> How about I also take the two fscrypt
> cleanups "fscrypt: pass a real sector_t to
> fscrypt_zeroout_range_inline_crypt" and "fscrypt: keep multiple bios in
> flight in fscrypt_zeroout_range_inline_crypt" through the fscrypt tree
> for 6.19 to get them out of the way?  They don't depend on anything
> else.

Sure.  I'll resend them with the review comments addressed.  I'll also
see if any other of the API cleanups from my experimental branch might
be suitable.


