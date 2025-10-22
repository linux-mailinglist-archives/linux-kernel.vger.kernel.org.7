Return-Path: <linux-kernel+bounces-865314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8110EBFCCB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD114625E95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770C34BA52;
	Wed, 22 Oct 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rC4li3AO"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C46280318
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145525; cv=none; b=urnDSeEYym+9mexGA+79xfkQJAcirETLD6VB2VV75ghi4ydp9sKS+dubBy9h2cggAFadGskhusFKAmjIDpr7UF5xJBAQiS0aVRoXTfTAuDsTBghTBZdd2+cnYrOLMGUdBSRj8enmUS68c6QBW9M+2OixHC8S0kxBKCXTgc+gDyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145525; c=relaxed/simple;
	bh=Ahk+TCPWpF0SHs3iJElrrPc0xlReNlwCDGgYHcFG7/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qePzPjQhhPkDyyuZnWipVk+UrklUrH7JPZLhJ+bySLQ9mbaDMaAq7TeCSEPc6ywk0Vq2jt3etebAMzbEyNOJzo+A8FpUsmmNycplgnyP9fg1mLsF9THoB8clVy0m+QpOIixpUaXcn6KINwX4wsfd9fYraRncqkGVEPVsDXxiGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rC4li3AO; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89018ea5625so1787624241.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761145523; x=1761750323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lkfsrx+l4jlC21dncenmKeHGGdvtV/ZkD7EyQedUCLY=;
        b=rC4li3AOzZvvy7/tmCsmWMMTrNDDzoR8To+81FnmwnUDuEMNUIknZhwBRBuI62GsHY
         m64S/NLeAtScowKwpLjbQcv6jH8kV3f677UWtBb6eFl9uyla3yL13kQaxCH08dcHeZZK
         xXArYM+WQPbQTQtbeyVTGUHE/TueWL5P0zxg9Gl7hDxTLqHyJaeradiUYYR1tPhEQYYP
         j3JaWaWRKKkwOs9IkaiEGSnD2hw3EkrVig/Oej3/jDcFaFOWG7n0u3UAgmywdbx0rc2A
         MszH9dFh4GTowSY+tF41lXnNH9KDqzhOfICqebdwBPeAvny8nTGxg0QkdQ1wtR99ZX6d
         WT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145523; x=1761750323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lkfsrx+l4jlC21dncenmKeHGGdvtV/ZkD7EyQedUCLY=;
        b=OLdFuYGy9g/ersHTLb34ijYaBLwYgShKPqRAiHBf3Wm+rOpweXOZaS5IZBuq2RvYOu
         AdFeR3aldSKVy+N/ijp9EVWUcgoO3b+lajMLMTvkr/3SyUh04KgZjEqQJCHP4TzSm7sf
         qoL604p9qKXSr03diPgvTcuRYUAfBme8G2aZMg3ePb1GPidrgkC8wN3Shayok9o6QUje
         XM5/GUcxd8R5pbN1h6f6SjugXEUeRfx1sEUzr8dYgj/4reUPbLI9Te0cUumXfC4v4vbj
         hBY2D19oYBQiw/3PZRvjZ/4k+ykvfPPnCzni80ZnGkf53DWqx3ADsJJqQs/q1VJeUgbA
         AOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9OOfkK+rgegpZ0kPRL+/i6+ktAMgYG60QohaSneifObtfZRzvEPK11s1gPxOvS+wQ6t50O94u0BMJyfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkrNlNtxAOHL1A4npFakvRMJPteIrcYSkoeIo4nv2VK1Y1Ubc
	n9wA+wpq7bUGnjwHiLyetfA01ZRxWEqmS70hnctz3EiExlhVufrDFDbw8JR8wAjDQ4E=
X-Gm-Gg: ASbGncvjg0wqBlNZXkVYhGjAC22fR7/S69A8vui2rJWzrunVx7m4ArFmPGS9D9NjwcZ
	CRXW9xqLqe9e45EsgL8q6yNTgHCz0jcdzun7lFDFwSJTdQCVjZjnwhu7GUI+wYDqAnfZR/bNDqL
	xbdFqe0O3LzFJJ5uNfaHUhGPScHuTk5T2s2Rb8+kCnXdYckMS8K3riJ87su1SiDT1KaOR1ieUMc
	4cFT29dGAeEE9gE70fs/3u5ECyGmqgVLVd6CyrZ3i7QXOqyC2Po9vEaiEFekAP9eC61peQXwNSQ
	sMLfPHpYExD8lPcMo5gspcxwZa3p/vKIHcUKUB7oLVby7UI6V1Ekp2OCLJEbibPhQXjqClfk3Rd
	B7m/YDknxv2aVytZpBWXL5GRqTlARUnTp28HxOIHRdGoxA+Ocy6IE/lZJzsC6V78KNN+LAX5Rwd
	102A8GnXrb6JRkrhCuwYx7C6i9zcRfp+iu/M96KQBk2Qwq0xfgf96wqUHfPjc=
X-Google-Smtp-Source: AGHT+IHMiHw+ozU+ptUdJ1d41xCzcfvQEjYcMBu/Kjjs0exhxm6ev7st/P+2mBHa/ufJLrkmED76uQ==
X-Received: by 2002:a05:6122:1d8d:b0:54c:da0:f711 with SMTP id 71dfb90a1353d-5564eeeb319mr5696564e0c.7.1761145522360;
        Wed, 22 Oct 2025 08:05:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf5235384sm91023196d6.28.2025.10.22.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:05:19 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:05:16 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: hannes@cmpxchg.org,
	Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>,
	Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, dave.hansen@intel.com,
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org,
	raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
	nifan.cxl@gmail.com, xuezhengchu@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
	balbirs@nvidia.com, alok.rathore@samsung.com, yiannis@zptcorp.com,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aPjyrAo5LdC5pAqv@gourry-fedora-PF4VCD3F>
References: <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
 <aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
 <CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
 <aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
 <20251017153613.00004940@huawei.com>
 <aPJZtQS4wJ1fkJq-@gourry-fedora-PF4VCD3F>
 <20251020150526.000078b6@huawei.com>
 <aPfWePBq8d3v979f@gourry-fedora-PF4VCD3F>
 <aPfXloRQgplusnce@gourry-fedora-PF4VCD3F>
 <20251022100950.00002785@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022100950.00002785@huawei.com>

On Wed, Oct 22, 2025 at 10:09:50AM +0100, Jonathan Cameron wrote:
> 
> My gut feeling is the need to do dynamic NUMA nodes will not be driven
> but this but more by large scale fabrics (if that ever happens)
> and trade offs of host PA space vs QoS in the hardware.  Those
> trade offs might put memory with very different performance
> characteristics behind one window.
> 

I can't believe we live in a world where "We have to think about the
scenario where we actually need all 256 TB of 48-bit phys-addressing"
is not a tongue in cheek joke o_o

That's a paltry 2048 128GB DIMMs... and whatever monstrosity you have to
build to host it all but that's at least a fun engineering problem :V

Bring on the 128-bit CPUs!

What do we name those x86 registers though? Slap the E back on for ERAX?

> Meh. Let's suggest people burn host PA space for now.  If anyone hits
> that limit they can solve it (crosses fingers it's not my lot :)
> 

+1

~Gregory

