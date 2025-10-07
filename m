Return-Path: <linux-kernel+bounces-844806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC9BC2D31
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 404474E63D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20320010A;
	Tue,  7 Oct 2025 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FSKLUm87"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6941E3DCD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875148; cv=none; b=JLQH8FTcZC6seoqSIjW5UQjTj9o/fCd/00RhiLCbl+bdC5JXy9QmkImjrbvJVmMX/C8w7FnQvfGFWUPZORcnTGJ6mmWp2bHL7PF7VgPQR/sA+a0DyPDiI7qgVKZ0h/pF6lpsIQnqQHw+g8JKZyuG61S0CdqTavv8ZkRyFmy7LAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875148; c=relaxed/simple;
	bh=zD1LPuYYLGObk59ZgrEWtOUqBncuVzaO6DVP1YPJmJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3NRYwYR1GhqvBtpyI6OIHAZOWqHIpmsydrR5buvJgIRd9CDLfrtqM9C9dAHm2z+n5vRpa2jmU04sZHnenhzqSirV24lFMP8WvHYibYq48Tl+DYittOcNyNE5g6L7Ye1IGbsEH/Myq/4m5lmw5OVZQHU2Mbcpq+kFlDPseSn/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FSKLUm87; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-863fa984ef5so822328285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759875146; x=1760479946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebBRD6yGmAnfNTiFyWqKhtyfR494yORKNRgWYunUcoo=;
        b=FSKLUm87KeHKzPQFzh+osGnLQFEZ2H2Kwbk38JbJOPQW4g9kYOZeY7ueeok4d4AnJf
         2xogaYsMXojBL9ljYuEiVz9lC2xf5lInZUEgVn5HdDpig3KpEpZppxXZmJZtu2Wg+Gw9
         CjJ68lhvCMD56sdCC4eEM4KkiNNg20K3BOFSAcb/9BTXmgUomXBN578QAjVK0PIUv/Mq
         Q2plWJB2UvfyefI8gmbdoNr5Lcmbyykg0pBYXEXBNQHTKU4f6zPvKfC19Mpj7sR6BIN9
         vkxMd/d2nZK++RJ0fBlG8PQyanLOKi21WfQZC5YonSmo6bPNE1Ng0MNFBYy8SJMtpevA
         NxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759875146; x=1760479946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebBRD6yGmAnfNTiFyWqKhtyfR494yORKNRgWYunUcoo=;
        b=poOhb2wunpt4hNvhnnorjCx+wo+bb/0kielta6UVI8GcRt/e01mInNgMsIU4OpvBdT
         0FpB+AMwl5Y4LgL0Vpy4VBx4EPlrQ1SmlY2+AFHCzWKu37J5Gjx+2GEzkpDrP8n1PIi/
         G0QwxvQjClRKpy2hInBbcQpZ7Y+NAsm846z7p25BoJZr/4zafmQNtnc+hxt20Ru9OPKS
         rEvZ1JNiK6fOkwXkcNwA+8ue+80rUA2CxFQ4l5pip0tmzf99xY88HNhC/ahehiP0sph7
         EWAYzxODIOJVt+XN4h2qZoslaUy5i6HC1XnWVUm1umVryPPWKtQ5wIbdfJ5W2cPESDD4
         HKIA==
X-Forwarded-Encrypted: i=1; AJvYcCV/TSR/xtZp7usuBfSmURaNFcl5HGJ3e9xpdp7Ml1QdReVt++8DqurKAW50+X6Amc+Y32sYLGjhvOmbRnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPsme2zhiy6gv9H/kbaeil8HEwQKT1r3Yir8obWuawBzW9zS/
	TihlWi3Q8/ZPfjAIPcIyWr0s4gYJOGBHtSePa/i8bd0Cvwe3SQkeG4jDSW5dCk6Hk14=
X-Gm-Gg: ASbGncttkfCTVe72PcVczvLLVHYgzwNeAxlXe9J3Iwo8ZUx3jbqc/PaogDWrt26YM+g
	ifM7j0g6N0Mr49XpwDERLN1N0TLbiamxN8HoHUna8owl2gkWSITrg3GJasbWwjKDGTKh4xULOcj
	iXXACkdrTq6oONcSwDQLu9DmvOhODU8VE98meUndZ4rV4LjtWGcJBXe6TZTnzU4XwHPK205ECjh
	QqgZ7WfWVm+c8p8hWUVj4+nDiGdDYT6XaEbBpBwU+0/3ZtL3lLhRcbqLdlmAY5va5B/jOyY3GLU
	Je5Cic0R+dWMWSS6iBSQCIhDDbsb/vBv3058tHskhA5gCPA/oi7KyXyPlDP77hsLZP4O61HgsBF
	OCnusNSimThqqcmXeZFIjQHzijKoUCSq6/BD20ok9ZUVSKMvn2J4ayIp/kMN2HJsHe0nWSu+jCt
	0ghKi327vM92mjyASrMDXXQ0TZeoPhxg==
X-Google-Smtp-Source: AGHT+IGCq+eGhr6gIxsGpM2pRbfwzcvGwatmmJT+/kgQa0cOOL2MOn7JsQF2sMQyvLhQx3NeVxG6xw==
X-Received: by 2002:a05:620a:c4d:b0:855:24d7:5525 with SMTP id af79cd13be357-8834eff4d01mr214767985a.0.1759875146022;
        Tue, 07 Oct 2025 15:12:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87779799145sm1548566585a.56.2025.10.07.15.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:12:25 -0700 (PDT)
Date: Tue, 7 Oct 2025 18:12:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
	osalvador@suse.de, david@redhat.com, hannes@cmpxchg.org,
	laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
	joel.granados@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOWQR9H2i4J8dZZR@gourry-fedora-PF4VCD3F>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <20251007145955.31dba3afad6200e885e906a5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007145955.31dba3afad6200e885e906a5@linux-foundation.org>

On Tue, Oct 07, 2025 at 02:59:55PM -0700, Andrew Morton wrote:
> On Tue,  7 Oct 2025 17:44:12 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > This reverts commit d6cb41cc44c63492702281b1d329955ca767d399.
> 
> It's been seven years.  Perhaps "reintroduce hugepages_treat_as_movable
> sysctl" would be a better way of presenting this.  Not very important.
>

But a blink of an eye! Will fix it up if feedback is positive.

> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -55,6 +55,8 @@
> >  #include "hugetlb_cma.h"
> >  #include <linux/page-isolation.h>
> >  
> > +int hugepages_treat_as_movable;
> > +
> >  int hugetlb_max_hstate __read_mostly;
> >  unsigned int default_hstate_idx;
> >  struct hstate hstates[HUGE_MAX_HSTATE];
> 
> Could sprinkle some more __read_mostlys around here?
> 

Makes sense, will take a look while I'm poking around.

Thanks Andrew!
~Gregory

