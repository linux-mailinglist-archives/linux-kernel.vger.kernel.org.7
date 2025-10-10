Return-Path: <linux-kernel+bounces-848667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C187BCE4D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CFE19A1D44
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0602FE560;
	Fri, 10 Oct 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Jxu7m7px"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA620A5DD
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122416; cv=none; b=repqfH/Iz2gEoO/bkLXSi92nl9XPRCYurNexP0UWlWS+wLEgQxRwXXpk6rC/Fn03cVxr8CozYPRaVFYt8eDuVl+k91mAQ/P1+eK6HqmxZPIuXvDHLr3V+i874Vegew/np4r5Xeex+fWlSCDl7IIGWIXG7a3fARyKZ00JAM+ZstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122416; c=relaxed/simple;
	bh=1c9xpjEAyzSHEbTovQnqawRw2MZSunBs7oFhwkGp6IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOGVuW3aQkhrFRXEqTaKbTIcKQlwEB4nU/h5EB8xWj3MfirSBI+IMNIUPyH7tOmUm9GL12S1TGN0K1bupLGlfWWPqVjCegQiCrrriFTcPRmDAKfS4nz/4RdVQr/QRWVgRHtyYEqBu8m4IJDBCDLOdllYQTML7HKtSQ39a0n6pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Jxu7m7px; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-869ecba3bd2so287115885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760122414; x=1760727214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvk9+2uf5Jy110s1EexKEDqunnlIUh4JFbrOdrqUH1o=;
        b=Jxu7m7pxX092VH2TA771cV3O8FsblFnpBDecm18yIpEq1XXcTSka8IRHIyoqsAx4xA
         2YCQqeZHg6o1Xz1yrLAtB67OSSjQm/I5y82gdsmvEHwi4d0rbzHN0F0R/y/9y1dGqzrB
         NUOLF0b6/7v+RPBmji1GIusX81AznCOzZnyNT7ynqfz55bnyW3IwelBZ0JylBDlnNgqA
         NFXCfol0tnhTlCDK1FzI8Qa2IIfqb2FKVuqLnf9JJIHYxnkPi86cvZxQ0Rrm44IFIITJ
         8Y4GSDmBLU3P8mByqFWOeqcKWVrBP1tKSHafZxG2piZKNEkOcf6OXFrszcESGSHWhCJI
         2ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760122414; x=1760727214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvk9+2uf5Jy110s1EexKEDqunnlIUh4JFbrOdrqUH1o=;
        b=YDUIOpYvgfrq0zvsHnXGwYMx1hLEGiWnHSnFpB4Nkra6dtEBEPt8FHrMjJrPX66gbB
         RaOqhYgkMun1fAkdU4PqSZ7HNrtodBLAI28U+USGl0joDo+2jqbMIyRH/t63FJj3yVTY
         a8j09Uf/aswoAnRbVFHQmxQY4T2yCNlcbojjgvy/p/u/MF7By3eS4wcBgX7YnLHvC0uq
         DaTT0zDCT7zKL/EkYa2M1iCg2TQaZGmdscDceBxNxzNNO2mNiH2Ng93AoaaxTfg2Aa2i
         xBJAcQWz2sq7BBTVBCcOC0n3BFIxMcCpVjam1x+uEvqscpl6yVtmxCAfvykjpPkz+iJA
         O5jA==
X-Forwarded-Encrypted: i=1; AJvYcCVyAkeGc+cH2kmDK5y3FhM9uCaa1ha66WbCs+swRaq4lYCzUkISOow3NqpTPldRlAg/vd/iyA44hmECyp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Ulm5AizvzWTjIsJMH1fux5KURUCJ6dNNKZW6cdSjYqtAfZn7
	0kopQQISbwi7zmV5QbXztaGSbhvA3vpsp/4LX2nvoK6NSJtHWCGBIazgb0Mt1fkz57E=
X-Gm-Gg: ASbGnctTyw4RXEURacQxeJN38rdxk3hH9v+kBg71gYF7KueoNKmkaI/lY4pk6bWExxX
	ZQFBrK1cv6XNcEfoOwEMYkIjvimFqkIvnH7OhZAnjob/2RJPW2f0VZWIplKga3gqAZZCUCH0vHH
	uDf5JMwYrMKoAw2DgcTXVAHpYU6P57Hn2kR7/sgkLryB120OHX5EjXOrxbexD6k5sJCaLNpjnp1
	B5Nx7cqqKDW2DapsejMOdJV9gzSGXrWyxxY9SJVvbWj1sIeo1oEJHoq4b+v+omcTXHWko58TtFP
	3cNDO0JCyQhZ3hYHkX2N9mFDqewnBA0hIf3wOHb3WXHt7LbU2Eun4NIp43oajpnk8AXu7fPO+lU
	UUOZchfRTwwqAUecv9KeaU8ZKDpvs8ixhFIESwDehzMKyStuWv9y79eyzocBQvvUIw9dmmj1Wk4
	PMCMJayeZVssgLGZMk6+TDOwJcvgNgRpvQRog=
X-Google-Smtp-Source: AGHT+IFw83apThwu3Bu6mVESZP4W93bdkR0fqUQg02zKaUQROrWdoFXC8bV8nX7m1XqGZM4W610+FA==
X-Received: by 2002:a05:620a:179f:b0:849:21b9:478f with SMTP id af79cd13be357-883534624f4mr1914757385a.35.1760122413577;
        Fri, 10 Oct 2025 11:53:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ae48fsm459499385a.24.2025.10.10.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 11:53:32 -0700 (PDT)
Date: Fri, 10 Oct 2025 14:53:30 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, corbet@lwn.net,
	muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
	hannes@cmpxchg.org, laoar.shao@gmail.com, brauner@kernel.org,
	mclapinski@google.com, joel.granados@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOlWKqyN5P_kaoHc@gourry-fedora-PF4VCD3F>
References: <aOZ8PPWMchRN_t5-@tiehlicka>
 <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>
 <aOaCAG6e5a7BDUxK@tiehlicka>
 <83e33641-8c42-4341-8e6e-5c75d00f93b9@redhat.com>
 <aOaR2gXBX_bOpG61@gourry-fedora-PF4VCD3F>
 <aOdSvriKRoCR5IUs@tiehlicka>
 <aOfU9YTKMPWzYOta@gourry-fedora-PF4VCD3F>
 <ac0393c7-9c0c-4b4d-8b35-5e6369e5431b@redhat.com>
 <aOgpz6no2Jx2-Y8Z@gourry-fedora-PF4VCD3F>
 <1d7476e6-5c6d-4175-b28d-3622222ea8e6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7476e6-5c6d-4175-b28d-3622222ea8e6@redhat.com>

On Fri, Oct 10, 2025 at 09:40:29AM +0200, David Hildenbrand wrote:
> > 
> > Seems like this is pretty stable tbh.  Obviously if you hack off the
> > node0 hugepages migration fails - but I feel like you're signing up for
> > that when you turn the bit on.
> 
> Right, just needs to be documented thoroughly IMHO.
> 

happy to make any doc adjustments.

Better to move any notes every here though:

https://lore.kernel.org/linux-mm/20251009161515.422292-1-gourry@gourry.net/T/#u

---

Maybe worth finding some time at plumbers to discuss block-level
allocation twiddly bits.  Still not quite clear how this would pan
out.  Maybe it's as simple as adding GFP flags to blocks and having
something like:

echo NO_KERNEL > sys/bus/node/devices/node0/memory1234/eligibility
echo PINNABLE > sys/bus/node/devices/node0/memory1234/eligibility

folio_to_block(folio)->eligible(gfp)

The issue here is obviously that it's clearly racey, in that a bit
twiddle can change the eligibility mid-allocation.  

I'll think a bit more about this.

~Gregory

