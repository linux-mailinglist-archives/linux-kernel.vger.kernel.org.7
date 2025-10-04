Return-Path: <linux-kernel+bounces-841941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B304BB8974
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC2654E4739
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA391E8342;
	Sat,  4 Oct 2025 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LYUDZjXo"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257DC2E0
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552165; cv=none; b=Sp5UqaZ9JSeZn2GEGXzgvlRN+LH1lNcreOBXN8Sy086ZdMvvEmwH4vNXTw9pX2GIsrB6sJo+Nmk3ezwp2Vkn4W2H/o9Lg9TyYTsr7tehCPsiqkbZaLUnAfP8c6KKLTjFMMiUTucBq/KNzArAEPlQJSIHw6wwdklPQsOAWURhmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552165; c=relaxed/simple;
	bh=wpCsCutZmJDKw2pBiFjMUEHMKcMxgC+oJ8Iao3k52I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvpdZc4cBai16d0PyX9gq2rIXyCpOrVQucaQRglehRmlfSChYjGMIWIr0nUiULIpLmnUchkd6AAXbMRT+qhU4U3zQg8UF2FA/h7GsxxcKJWXd4AeV2RkqClBydv4IZwlBrUkegMsyZ0GPI74bFgyOP/8oQmRqI75KT52iE864gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LYUDZjXo; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 4 Oct 2025 00:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759552161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwcPX+6RQVVabt7UEg+6HxqU7ckIKfXRHVe9mKmG0dE=;
	b=LYUDZjXocwMAPBwjNibs97F1leizimrr6YlsYok0AfGOB1bNavciRFCrrZfBzhNTySlc6e
	UtmZKCJ+tjME6RQxhVTSbyUgX+v03yRAXnfIDOmrs7KskW3O8nw/50PDb3SdgE1r68Ei6z
	MeYYkS81+v9XyP7tavwqIiIcG8zImuw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6/7] lib: Give XOR_BLOCKS, RAID6_PQ config opts names
Message-ID: <73o2borvbdhb7j35zigv5ua7vgjjtt4pohbb77eolflgp5q4zu@bawkl5ykytce>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
 <20251004020049.918665-7-kent.overstreet@linux.dev>
 <aOCfLTDYR83WS2CB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOCfLTDYR83WS2CB@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 03, 2025 at 09:14:37PM -0700, Christoph Hellwig wrote:
> On Fri, Oct 03, 2025 at 10:00:48PM -0400, Kent Overstreet wrote:
> > Give these config options names so that they show up under the "Library
> > routes" kernel configuration menu, and can be enabled by distributions.
> > 
> > These are needed for bcachefs to be built out of tree.
> 
> We do not add hooks for out of tree code, and this applies to you just
> like for everyone else.

That's been the primary purpose of the lib/ kconfig menu. The current
language is no longer quite as explicit as it used to be, but here's a
recent example:

config CRC16                                                                                                                                                                                                                                                                                                                      
        tristate "CRC16 functions"                                                                                                                                                                                                                                                                                                
        help                                                                                                                                                                                                                                                                                                                      
          This option is provided for the case where no in-kernel-tree                                                                                                                                                                                                                                                            
          modules require CRC16 functions, but a module built outside                                                                                                                                                                                                                                                             
          the kernel tree does. Such modules that use library CRC16                                                                                                                                                                                                                                                               
          functions require M here.

