Return-Path: <linux-kernel+bounces-776958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483A0B2D379
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87549164B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411224C07A;
	Wed, 20 Aug 2025 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Io7mAX+1"
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1868353368
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755667388; cv=none; b=a1mqC9hXo8mlSK1/j7kPjNzCB9GBNqgygnAE+4gszMF0Bz42Mrkho3OTy/plT5nBIAuoE0l88g3wYqY+Q1OAN2EBiBgzkMCbNzjGijBA2+c/KwmX5l1k0isrIXf9U6hldDcJVXX9fIlw0GHaYMjDp/bT1xtDVCz++KsjqdWCY/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755667388; c=relaxed/simple;
	bh=w77BiIof4v3uBhxmRBtqS9B3e5N7Z39axckLRi8redk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc1kMPciHTh05jsKaB8k30q4BXmJpFw9V0ABp6aRCVDmgY5zBNu8mxGM2fu/fEcEa9xLaSOufCIJ5T7qNbGBv1zAzWdbfCvDHQo+Dw0f7Ue+wYXSKCq/Emls3oaW/VLRkxlZTzdmtg1Q7g7euRpXbrf+otmu382COLFufVwzG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Io7mAX+1; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=z+SOVI9UtvZRb0bUVQn1FdWo9HOAHuaqFSeTJHOfcfI=; b=Io7mAX+1reTKtZ+two6iAc7Lgi
	xzlJzGFOPtLMQH3YDf0brG9TzwGncuymfFgIIfQ+SXFrdmk8/uN5gbuojTWMVl8SwZjq3GPldQjnr
	gDG/GSs3YPLhLVUDGo1nVPscPoDadjmnuJE0g+iRUrG5j+Kys5qrFoDFKS+jyPfiZ2ANoXlBsmEJI
	Rjq8b8XSLv7fmlWWV0fXxqlaOZhxQq0IGGy2Dn1Wk4K9H7RFpuDcCY/5ZMcazGJ21/yODhRWbdM6e
	KSicES0zw3khxF2cKXICxfbD2D2faGxWFVyT9X8EsEn7uSwBlakeQPOyI7kHm1IsqbZok7CLf0Phf
	6nS6cfqw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uob2D-00FiBO-2w;
	Wed, 20 Aug 2025 13:22:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Aug 2025 13:22:50 +0800
Date: Wed, 20 Aug 2025 13:22:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chris Li <chrisl@kernel.org>
Cc: Barry Song <21cnbao@gmail.com>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
Message-ID: <aKVbqi6wd3Spz-TM@gondor.apana.org.au>
References: <20250819193404.46680-1-sj@kernel.org>
 <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au>
 <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
 <CAF8kJuNJ8s2D9NBdXDQ4vpBP0a-5k7r_=DdFuJJ95nMKmm6LBg@mail.gmail.com>
 <aKVYyGWiWRYgxfE-@gondor.apana.org.au>
 <CAF8kJuPPsLzWu8+xm2A_UPHMBhb7OTjJNErM1Kp3hPmvHXNDUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuPPsLzWu8+xm2A_UPHMBhb7OTjJNErM1Kp3hPmvHXNDUQ@mail.gmail.com>

On Tue, Aug 19, 2025 at 10:20:45PM -0700, Chris Li wrote:
>
> In that case it is fair game for the caller to check for the error
> other than -ENOSPC. If the return value is -EINPROGRESS during
> synchronous crypto compression, it is a bug. We are not encouraged to
> use WARN_ON, then having an error count to check that something truly
> unlikely but possible to happen is better than folding it into
> incompressible and pretend the error never happened. At least we can
> know such an error case happened.

Sure warning on -EINPROGRESS is fine.  But every other non-zero
return value should be treated as incompressible.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

