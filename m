Return-Path: <linux-kernel+bounces-845918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71EBBC67EF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D72188EB48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9426A0F8;
	Wed,  8 Oct 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j/J9SFLj"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB825A2C9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759952649; cv=none; b=mOLJbyOGmtb3ECVRRlU+sd6DwCtPQ2vwMoHns1vTRll6WP+lKkspFB2g6ERvA7XGAwsR1FF1VHzUCcoSWJH/GJu2jDVtfUPef6sAoO92LmzxK8ENy8p7eWdEGPq8goOdyBlUtbqq6eg8s8aLOuiVZ5AnRwXZ4JnLJnE2OR8lEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759952649; c=relaxed/simple;
	bh=0sHxe3ikfgkbYfnXEhUGZNytNU5bsJ5ilzWd0eHp0mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMkmwQpHk8oFE6JsvJEWzcyFxqJNBJ42+zU9u/NRn10CCHRFvbcjC8xdQc2tZWF7aI78Yd1g2i90/8dTOPUSTNAlNvV2cfF79O2ndB6oab298aYV5QVpzVC9cw752ixK0PTze0Gg5ULQVCfaZpnKw9ca6J903eVJiNMYcTL07Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j/J9SFLj; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4dac61ed7a5so1534611cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759952646; x=1760557446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vflrBSpkNsrYFG4aEkF621olmmdCSiqIKbvUazecPWQ=;
        b=j/J9SFLjcOsLVcOE8tjug1oTDxWZYi860fXcMZQ8j9AMeBoi0GO87wyNjkzzShcDS7
         Z98x4p9OpCKwq+ORSA1bUJqnwKoWIsdbYM7gqIQPU6Il59lq8KJqNxoBrRNd8Nnsqp2g
         WYsWJ+0/ioYfoKXbYk0o9wdM/0FFLIzLWqfiT8ZZB5E4AcV3YRFSfA61rsyI0zCxx3oJ
         4oRPNNxLNUbJYb+RP4XiNFPR5ec8EF9RR5138/Q05h306LvB+z/ttfVGjbBjAc0L/cNA
         +koFWZDgKaI3lZ4D+RiHPMrsZ11jMHkRux5d03NH7v9oHHY9SaYgO6TDbTJdc44XopVb
         QL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759952646; x=1760557446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vflrBSpkNsrYFG4aEkF621olmmdCSiqIKbvUazecPWQ=;
        b=lR70UtdraK6jPB9tgiWMBn5xvp+jmhaYPRaFBy4gTsXEm6JwUZ4UUrSPrizQoKVk+M
         bo5sUJ7xe6FjZWyh1SdWs+NFItD2TwNbu4hIXkLsj/7o2sPgA99PIVpTdR34MhTIQykP
         9FDcNxWF3+GZHoFRJPcGHB+ZDHdMedTA/nATqO25w5NK5Ex9Ea/36yqwMPtMHFUrwBge
         mewDc02zraCvVdGoxYVAhOUARAtDmMWv43F/4GcrXZ9HZQdLYv+fTGWQn91JpqTxK9ds
         RRezwRFEJCsNvOeko0qj6CEtrn3prKeC1pMT498/nK/8/FBZLx471sQrdId1d4j409gt
         2Ypw==
X-Forwarded-Encrypted: i=1; AJvYcCVRxQXzyW4kSVPVZPtrnvxMlTU4fhdjiJmfMobpbjTCPz8c//H+TU6FOcWMIkYVmHKVSFq66IzfnwzGqfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoqia3JoWefEElE//9n6UM+CsfO4KB5YyZLb3Ho0ANRaIGvZYp
	54tGX8MqJ7wsUgCabhjwlS3k/ZXlZ4bq/OYvm80ck5cmxMeqrBtuaNBJlWYmSWJTd7U=
X-Gm-Gg: ASbGnct5HwFZVWT1wNw4X5soLR5KRb/BqfHrPaTFymZq5cltmEY098x1uN1frj21zaY
	fuHnyQl3ZBL+2nN6VUwsnkAuhDwKClrbpX9aQHXbCey/DYKMmW5jqRTeMAoGOUVcGx0kkOg7Qol
	ZG+1ibY8F5S3l6J9kK4daFPrjAenh8jLOg38V4mVrDVwzGtYygXwzl3NS82wAytdmegOG2s1a7T
	rCK6RE2h9Jr05B/9LrGBY/gZvUaWRpM1JL9ql+3DauYjOvugsLF1M1HDFac2QL8yadj1NG358dH
	cvMQMXW9vEOr2cyBA6H/udWkydX8xpvFjEvaTMaKB9EhT0CJLLcmYdCZlnUj8EEF7zlcV6Kq28i
	SVDBITELtm5X4OXAJFXJhQDKPah++ZSuUrs+WdY2Xowkim8EmzWbtSU4RD0TphWS7OYtjFwFnZ1
	V1NiM3Fh0TrxvfRrPrmg/3a3vcb93I2oDJLLQGqMSf
X-Google-Smtp-Source: AGHT+IEt2akHgGZEKwCwlTLJzKYM/iMK/f7JPmuxQehpQT5vGVvCZLvTXGY+F0lhMaWM66A92qQEEg==
X-Received: by 2002:a05:622a:590b:b0:4df:bba:5acc with SMTP id d75a77b69052e-4e6ead7788emr71769211cf.79.1759952646315;
        Wed, 08 Oct 2025 12:44:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55a34c6e5sm170740411cf.6.2025.10.08.12.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:44:05 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:44:03 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
	osalvador@suse.de, akpm@linux-foundation.org, hannes@cmpxchg.org,
	laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
	joel.granados@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOa_A_i1HUt1wzCj@gourry-fedora-PF4VCD3F>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZyt-7sf5PFCdpb@gourry-fedora-PF4VCD3F>
 <f4d0e176-b1d4-47f0-be76-4bff3dd7339a@redhat.com>
 <aOa0UPnxJVGvqc8S@gourry-fedora-PF4VCD3F>
 <b6d472ba-e6cf-4c96-935d-88c842ab3cd8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d472ba-e6cf-4c96-935d-88c842ab3cd8@redhat.com>

On Wed, Oct 08, 2025 at 09:01:09PM +0200, David Hildenbrand wrote:
> > 
> > fwiw this works cleanly.  Just dropping this here, but should continue
> > the zone conversation.  I need to check, but does this actually allow
> > pinnable allocations?  I thought pinning kicked off migration.
> 
> Yes, it should because longterm pinning -> unmovable.
> 

You know i just realized, my test here only works before I allocated 1GB
pages on both node0 and node1.  If I only allocate 1gb hugetlb on node1,
then the migrate pages call fails - because there are no 1gb pages
available there.

I imagine this would cause hot-unplug/offline to fail since it uses the
same migration mechanisms.

Worse I would imagine this would fail for 2MB.

Seems like the 1GB limitation is arbitrary if 2MB causes the same issue.

~Gregory

