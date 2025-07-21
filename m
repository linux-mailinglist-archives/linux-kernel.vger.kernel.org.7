Return-Path: <linux-kernel+bounces-739679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D6EB0C99B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7D51891455
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C342E041C;
	Mon, 21 Jul 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SigRHZHW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XCn0tmx0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9062E03F7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118574; cv=none; b=Gdyb6YnhUDd3H/lOUPaIvBN0j/vkSVAd7KazvvCBrYNygRG8DcnczYuOe3DTZzHRJ913Cpi7mJTbyY6BiTf9/c1RoHcOaXrw0FJg3tfVUyy7U/Wi31RLvtLQroG9Q6grXxOmEmfHfOEHN4PtZu8YeJcc26Gw+/DRu8FT1Uwvxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118574; c=relaxed/simple;
	bh=B7Ps+LKAb3AbMjuekHyLup5iS/pxSTyCAOTXYje2UIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kiLkCear+8MUPi+sP90vRAYgFtDGVHxxOF/bmGLQoSNWMGhpim4sG5bVGGVMz91jR5Xfa2EgyCvojYqgvL8ljDbBVNFedZawvvh8HK+MjcU82rXvN9gafguLx09YtEmQt2hh8pnZpPBGFQmu97bT4p2yXzNzz5EbyoGtNaEufAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SigRHZHW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XCn0tmx0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753118571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85b9+Zrsl4Cn8pUf/pnbXRelbaHnJeq0GSW3DRdJjUY=;
	b=SigRHZHWI/6pMh2uwVqZNEQ4MRTCs2V0nAm2zqOE5U8Mq+PFWWa3GEuZumyOFOBD5TZLZP
	UJTxE5YdBkrrDNhO5cxNsm93kbm8yKg2EWeZ9ywVZ/XyrjTtW/4+OgydWaGZ3ltgJeRDYe
	ysQqFhuqyytO0h2kljUC6pWdmYbXfnFkpc3L/Mb+of5Urqc7/g4DQRDxLYw29NtskU2Xvf
	JsCxLCCyCaUnrelG1Z/pfRihTllOTDaIbjWEtX2awVqP8MLjP2HeNRTTLph3/hJsbS9Hap
	9q3Ly5pZhB0V8/srfnrHsJ8XTZA83PMf/Vo2i2UyhDLVXoGwlcgz+YXuqo4npw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753118571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85b9+Zrsl4Cn8pUf/pnbXRelbaHnJeq0GSW3DRdJjUY=;
	b=XCn0tmx0eSTpzxldFYKypgyBUfhc2h8rarTYXHShe3ukqlYh2Sv5q9C+W8xxy9E8wn2gn/
	I/W6HrI13pdiTJAw==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kernel test robot
 <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] selftests/futex: Compile also on libnuma < 2.0.16
In-Reply-To: <20250715095203.vVbUIvob@linutronix.de>
References: <202507150858.bedaf012-lkp@intel.com>
 <20250715075735.tdXLHcEA@linutronix.de>
 <20250715095203.vVbUIvob@linutronix.de>
Date: Mon, 21 Jul 2025 19:22:50 +0200
Message-ID: <87h5z5tq51.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 15 2025 at 11:52, Sebastian Andrzej Siewior wrote:
>  INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
> -CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
> +CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES) -DLIBUNMA_VER_$(LIBNUMA_TEST)=1

LIBUNMA?

>  int main(int argc, char *argv[])
>  {
>  	struct futex32_numa *futex_numa;
> -	int mem_size, i;
> +	int mem_size, i __maybe_unused;

Why this unused muck?

> +#ifdef LIBUNMA_VER_SUFFICIENT
>  	for (i = 0; i < 4; i++) {

if you can just do

       for (int i = 0; ...

?

Thanks,

        tglx

