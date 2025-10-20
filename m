Return-Path: <linux-kernel+bounces-861666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B80BF34CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 401E04E70D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA932F74A;
	Mon, 20 Oct 2025 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WosQrjZC"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534A28DB3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990316; cv=none; b=HhwMwuXHObCL5xwKD/iAbh7d4Z5vUcFg9Rlr0OQKNQW0jyF6TfRDTU3NpFJJNaschV/TXSzlkZUG482Mrn/1SU/+h1Vfz6DZHt0OALl8k54arUgocIf2GfScsyP7cnVRy4FXcj7Dm/NosLe8tjWs6SusmmI1JVp/luxcyUwR+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990316; c=relaxed/simple;
	bh=ECc0Gm31kH1b1W/CJ3+R9BAT4riLGZw7HOJDFCtfOq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDq9KVl7uQhZdFZbjOAc9aswR/evt/9rs3vp5GmPUJtj2KfGGF7dyvAfiCeHet6nejl8EPbnRdvlTUIOniFOQeOgJwz4qNMtweXoXAks3UVgEdLiFJNS0qNDFhIeAldRKNHOqQlhRj75gEwAr4SEFldL98n/e7b18oOnUdaYjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WosQrjZC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8923b2d9954so227546685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760990313; x=1761595113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KpSw95obqMwiMZRj2XKUmKgB+9nrGEn9Iqfz2fDFxTI=;
        b=WosQrjZC+wSBbt5mG6zVaHaqOm/l8QF/06pyGMn+yxaJNyYUSL7GUA3ex6AdI0grP8
         80T0yShpx8Fajw0Hz63daPf+db9eRYFXNYsyNIqjQI3zbAdVMUd4AfHg29BUqsmCmcE/
         5I6qQ9M7XZ6NfHkqq11M3i6kxnNJ76znaXQwm8aTFBSyPr2JK2dqIJuRHxSnkFP7IyeJ
         2avls9anslIplOrwvS79wPOfJs6Owra1Sx4hE0T9h1FOr3NXHNKOU4Z5N8gBGOIJduuT
         rgn2UtVGSVjx9va4Bmii6G8pw1DepG6a8ymlK31O7caciUloBfJwlDVscAIGud4o/2kK
         CZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760990313; x=1761595113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpSw95obqMwiMZRj2XKUmKgB+9nrGEn9Iqfz2fDFxTI=;
        b=G+AUbREG1meqWJqP6HAHxJ/S02ssUBPr5v5gOUhis6NTRo9UuaYQC/zCzJTO3pzX8o
         arf2tkx/gqpQhramcOptiNUWLDZfJs9cVUybqo6cSmOfWpNdm5b2Ph+mO1b3bLXM7tiK
         Ok5gx9R+7Oy004qJk0BQ4fGZ9i0nvI773Qox/TNQyjuv3KrgmJVuk9eLlUDCrUxod2OH
         0oyeH22X/fPtFvX6JCv3MAqz4vhy5e5AZx9fWPM2SnVdKKEIgTf3S1mR/7XdAGWeh1wP
         TyiQ/21jgPU+eUVAkWAP78IYjHXQyQ1wR6PzkPaPBXW8FuY5Xg9KNbNNf06SHkyrR3v1
         YKyw==
X-Forwarded-Encrypted: i=1; AJvYcCUEpDUB6rn0kQAhSa3xKptopkyVu8Sgcz2FZ38yVeER9SsX4F21G+MrO4oTeK3fDnJ8aSJwx2k2ruIMWxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJtU0qzJlAurkCcby+0ZZBa7woOHvQfA1FLiNh2OYbYk/2Ye8
	ywIYDERlJskMPRA59qjuNiKoY5K9Xhu9qmJ4OFXPfzFb1m7225uMwJseH0HgI7LGje4=
X-Gm-Gg: ASbGnctL8taMdN9oBaHvHaxEFPJw8+F+n9PTtimVaqlYhrX/6gWsNJ8mUgp9qVHccRS
	H2SadZRpR8ksJD57aAa9Jv7OF1qTg3rZ1vyvpWO7Y76rjIBjIiAT7WKpye0yoQWG3Rmxf3rPcQX
	Q1ipAFGLjI/FhIM+Oa9xlPqXOgZtWAdLnMYngdGFrzOx5X4arzcBjQJup/7v6fTZSWpiI7iKhfr
	1GH1WglVLvmt5phmRajTDZuMGQcTcOR3H8ThEuy/84vm/9zIaxzdXBbZQkxTs/GV+uZFbslk9vy
	myFRcFH2YViU8LrtKgni8spkwVKXH6Q7Z1+o5RyDStay6cpaqpdfpR17zCjtY5qK5Q/lcYX3O/z
	SfksK8a6XW+yG62cM6h2q5GjyvM+lv894iS6M+wR9r89nEclEjnoKhiP/c6QEz4IxagGJYC6ooI
	imgHTg3Io3Pd8SDJOeqxFUdR/i9a6XevThm4ZlFE9Tz+9yO7+cvi9oD/xxOzc=
X-Google-Smtp-Source: AGHT+IEH4inZHsGMB2ZYEjkr5WDEu3rWhYipUwUtCdoFFkQwAFe+FMZe38IwTo5y0Tp/IMfM5gz4aw==
X-Received: by 2002:a05:622a:14f:b0:4e8:9984:a139 with SMTP id d75a77b69052e-4e89d292b33mr195411141cf.25.1760990312985;
        Mon, 20 Oct 2025 12:58:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab10bfeasm59829831cf.37.2025.10.20.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 12:58:32 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:58:30 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org
Subject: Re: [RFC PATCH] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <aPaUZm0ZfIEW3gUr@gourry-fedora-PF4VCD3F>
References: <20251020170615.1000819-1-gourry@gourry.net>
 <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>
 <aPZ0OKx_VnQ4H_w1@gourry-fedora-PF4VCD3F>
 <609E7E01-33A6-4931-AC89-1F4B2944FB64@nvidia.com>
 <272c425a-b191-4eef-af6e-2bca1db7a940@redhat.com>
 <aPaQNYsN_YPDOwQG@gourry-fedora-PF4VCD3F>
 <0d92a675-ab24-4b1c-be71-956f09a9e973@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d92a675-ab24-4b1c-be71-956f09a9e973@redhat.com>

On Mon, Oct 20, 2025 at 09:46:21PM +0200, David Hildenbrand wrote:
> On 20.10.25 21:40, Gregory Price wrote:
> > On Mon, Oct 20, 2025 at 09:18:36PM +0200, David Hildenbrand wrote:
> > > > 
> > > > Basically, what is the right way of checking a folio order without lock?
> > > > Should we have a standardized helper function for that?
> > > 
> > > As raised, snapshot_page() tries to stabilize the folio best it can.
> > 
> > is snapshot_page() even worth it if we're already racing on flag checks?
> 
> I think it tries to handle what compound_order() cannot easily handle, as it
> will retry in case it detects an obvious race.
> 
> > 
> > i.e. there's already a race condition between
> > 
> > 	pfn_range_valid_contig(range) -> compaction(range)
> 
> Can you elaborate how compaction comes into play here? I'm missing the
> interaction.
> 
> pfn_range_valid_contig() should be only called by alloc_contig_pages() and
> not out of compaction context?
> 

I've been digging through the code a bit, so a quick shot from my notes

alloc_contig_pages_noprof
  if (pfn_range_valid_contig(range))        <- check validity
    __alloc_contig_pages(range)
      alloc_contig_range_noprof(range)
        start_isolate_page_range(range)     <- isolate
        __alloc_contig_migrate_range(range)
          isolate_migratepages_range(range) <- compact

Seems like all the checks done in pfn_range_valid_contig() already race
with everything after it anyway since references aren't held?  Any of
those pages could be freed (get bogus values), but i suppose not
allocated (given the zone lock is held)?

> > Seems like the correct interface given the scenario. I'll poke around.
> 
> Yes, avoiding folios altogether is even better. As documented, it can result
> in crazy values due to races that must be handled (like compaction, yes).
> 

i'll make this swap then.

~Gregory

