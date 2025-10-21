Return-Path: <linux-kernel+bounces-863330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D56BF7925
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D884C348BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269C345CAC;
	Tue, 21 Oct 2025 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AsZJe1hJ"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08536345CA5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062624; cv=none; b=RT8KLN17vmgBBjNYsrKDATMtfikqxew+7638Z6C9wvQGGaeh3qK/CnV+nNxGbTMzBu3yhOoNsD93jffPWtIP5jH81oAPuP+ItS9r+V1zOFBwsp2+13j6dtceSavX6dwTUj/yz+KivXVJ84BEgxjywO3BXweF5nv5rBhEup6EKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062624; c=relaxed/simple;
	bh=8b+ivD/qKIKh9ITbIH+/2QBnSTcWyjBPLowxDg9px1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJaUjDcud/jYRdkVqO4DmosDJbk3zB6hQbtonDw4hI55aVJr5mHge4moiXRANHLOUbR4YRU9xrpZfGo97s5QFGJh+4y7OSu9Hk6ESX7HerCz30UdJn6E7BiyCHd6C/8xsHrm+P1TJqUWqFMW5jeLgWR1nPhpye2Z81QF8XlWpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AsZJe1hJ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87bb66dd224so79704696d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761062622; x=1761667422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKnbdWGyzTwBQCjdg/pEGTdIkZhea5mKIOTouuBLY+Q=;
        b=AsZJe1hJeOATp44OKsAemHFGMvh8vI6DAcku0J6zcw/01UApMwUrJyBFlczv6MPUiz
         EQEh2GBgnBiM5+LnyFGsptMB91zOTxBYhVd/IFFtTfM60CIchnQ+eM++XYgSGsT1SV1X
         PUFxUoFYhQSXEcRGv+CU9Qk86Og3IdM7smyByn/dL3Gz3wOuESETTJdWq259J9kQgICp
         idFp/fwPbS0enNGlyh4tMWHcR6oZAMWv/MNRNPhhZyWV0oa6nnpH1yWahhSfSUMjyNiY
         usp4LxcAYaPe1dPEnaK0w9WVYuulExZbJsS42uhw8ypAEThVBBU99kF+A9ydPyL03cGy
         dzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062622; x=1761667422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKnbdWGyzTwBQCjdg/pEGTdIkZhea5mKIOTouuBLY+Q=;
        b=YdBTGXtrs2XEtvE9iH5OMF3TKB1riycjJ5qGKDZhWNW5nV9Bwqig+UOu16aKOcuu9n
         BGXFx55xt39Y4zBm5uFTuLx4pToICMalzC24e3fe9j7bwIUiKyFgi9weUGD8SAWr06cu
         TT7FwBSaXDDw9MQrY05Jka9kzWotvLinvtTpPO5PiPfkhRbUueBiXC4potI/2f23skVI
         ELhpPrGw4i/+nTV+z/FA0T1DSMVxclFgcSL+XQoWHinBjnX9Ppqp2qIQ5Pz3h6cF1KcL
         bnNIc0r6WHgE+0oSRX6JSJez76RDhu9kAV4U+a8qtASALuHfNL8KSZ1vE0xmAXXbVzCQ
         OJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWigmZtXzUWenKYQegMXNQt7qzp/G64CYBJYZR3pd3LxcKnnW0VR724VO7n+qXu5cuK/T+g0URIlnCEgN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3a47oVBsFv3ui3gN6OMhT+SQQSnt9Ws3Lj18D3dsKAuBeXRiP
	YTWgu8/iFyheAK5sDuLF5/X2kb9yFgJG9xWrXAsV50lne3/+o/eMZ8e6/gRVsxBmes4=
X-Gm-Gg: ASbGncsMhCEnBptxjIJEUALThFLaM+7vUDmW7Nn34Ao46kGNlDHMd/y48JkPfZHDtUz
	jm7mgpigFJqON8kdzKTdS4HdEU5rItOPl5ueTAS3uFUNQMWDZtNc2oimkKQDuceh/Bh9hu8ljaY
	h9EssYkNNz+/+Dba9gP0vqIfo3yboHOa1JTwXweNbZvnA9WTfEfDA6USexXflFD7sKBwZAARGvb
	aOQo92afO6VQUEE9C1XViSBQn52bEGjgvf6yFa23N1axR5Rm8xZxCUoM/EIAD26xDagXRg8IKS6
	hRcM4E/jUdUXP1UwRmcvg1f4AtBW5WDdZo7nNIOcfdewFjCZEzVyxE9R0oQR+W5FDYNf/I36yRf
	0SxsdzwUd3IxetyrxJPisgrQB/LYYozanKJe72E7fp6yb0dmvaazA5F9RZKbzhz4kx79DjDEwAn
	tZTZVN3oJkxX+2rqLOw004FWnkuHP/ke9DHuZy7r6KNfZTLr+tY2g0gJ3iSVDUTpMR5GmxVA==
X-Google-Smtp-Source: AGHT+IGgeylxOlDNs0Nyv0EXfOepOKkvbjU8Nk3X+ci7ChYcRQpmyM7uU0DKfyt/R0deuXN0pKprPQ==
X-Received: by 2002:a05:6214:19cc:b0:87c:2967:fd52 with SMTP id 6a1803df08f44-87c296800c8mr190050176d6.17.1761062621646;
        Tue, 21 Oct 2025 09:03:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d890ffsm71384816d6.54.2025.10.21.09.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:03:41 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:03:39 -0400
From: Gregory Price <gourry@gourry.net>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages
 during contig_alloc
Message-ID: <aPeu29qbxdn7dmjD@gourry-fedora-PF4VCD3F>
References: <20251020210816.1089910-1-gourry@gourry.net>
 <20251021012533.56rdl6v76plkw4nl@master>
 <E787AD03-DC67-4B5C-8BF6-C79F3C583D00@nvidia.com>
 <20251021091443.5ggfmvl5jwyknjnv@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021091443.5ggfmvl5jwyknjnv@master>

On Tue, Oct 21, 2025 at 09:14:43AM +0000, Wei Yang wrote:
> 
> The above code is expanded to:
> 
>   page = _compound_head(page);
>   order = compound_order(page);
>       folio = page;
>       test_bit(PG_head, &folio->flags.f);
>       return folio_large_order(folio);
> 
> If we use
> 
>   order = folio_order(page_folio(page))
> 
> It is expanded to:
> 
>   folio = _compound_head(page);
>   folio_test_large(folio)
>       folio_test_head(folio)
>           test_bit(PG_head, &folio->flags.f)
>   return folio_large_order(folio);
> 
> These two seems expanded to the same code.
> 

folio_test_large drops into const_folio_flags which does
a VM_BUG_ON_PGFLAGS, so not the same logic here.

> Maybe we can use folio_order() here?
> 

