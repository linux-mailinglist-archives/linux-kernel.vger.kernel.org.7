Return-Path: <linux-kernel+bounces-863333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DBBF7934
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87143B31C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2233451AD;
	Tue, 21 Oct 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fbg7UWdi"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082C3446BB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062763; cv=none; b=T3b3Y1a2FtbrEj4Od4duV17CQCg6CTx4yrGyXZ9cZqAykSyae/Uj80dabZcBARsDk+jWqVxTFgiyrB+aKes2pe1RsGe2wX/+VRkak2GE+ZNE86BEusPDm33XcilHBTmvjs927DzWCjfN0TxT1f/DOeQWKzV2OUlV32yFvg1oveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062763; c=relaxed/simple;
	bh=tw709WIkmAxRtz0DIOsHEsGKUbgPL0PGBvCW9qWju8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF6W0Hsh8P85dFWnRig/hvdYAFBCownhdw7puQIvWB1QIX2kBOTbxx/NVS7NcJjUVgKFmOlW4YchPQtCjCHv4aVWH2N4wPDjvhoH4YLYqaAMdgMS3u561hbUOqkrc/ui++WSFbnFs+QdPkP6L8hIV9/z6IRjem7pG2K6mIBVeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fbg7UWdi; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88e456972d5so1081388585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761062761; x=1761667561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xSrJWJ2WsVEF027THRDF2lIxxafjbZSNr6O9ZfI3lw=;
        b=fbg7UWdiZ4Met/0uRqImcT5cp/zl4YWFdzJSimQ/kfoHHSEn//Y762auxlmbsCHZar
         6UfgJaA9zX6ypwQiaKqCzQ29vnlt8Fz+fPCrweYogkYKYU8L91ihKtVGM+0lIBPYQSao
         qqxnigno9ATYtqYwJWmbUwag+TTs4m0n+E7y03NhayPln6fQUb6HqzV45ZA/L3pWCgrA
         gfmkUTQQve2tXWIcqV/5ToThyhqctGZ7b6ZGOcGIHOvqt8OqyN1t2U/grUzpM2waSOAh
         XmTSe7bseCKf1ImVdu6tvPFEFTYfYL0PwNke5ce/roHoqkfcf9RFE++CY21geTP1/tdJ
         D/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062761; x=1761667561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xSrJWJ2WsVEF027THRDF2lIxxafjbZSNr6O9ZfI3lw=;
        b=GG+Am7GWlddYHfFuHVeRtYs3wSIdjQDkOIlpIJiswpK0/dI/eIO1hLz1akZ+g9FeHh
         dIL2NmVoeS2V3YPCC7ToGU7QUBwEfAtK/qihPMXq1675CZE08qbv5Jb+SjQAuPTN97lr
         z2bE32vD85OuySq9SdFJ2T8A0msJftoceFbu2RSgEmwveC7GQnltEjP77/9OtGOp2tec
         AyONFFN6UVCwtj6d1M+5i7CHP3teDGaiEkui7hIrZGbnN5iCXBYAUzoJr1MK+TsE+kx7
         rWYaoIy8ZcCzuntNKFucw9UMOc4rOhAMkPtmT8aRQSZpD0NxYBaoF/qwI7vHTT25+oxI
         zkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt4ejqC1ueuXS+5ahndxqhE3Bl0Jg5n48iwqK8+JW/B/scMo1zDiIN+VDLWS41oG4GWSZAGngj3Yetohk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5nqYPxOyo7WOn0Kenru72BAvA7yZqCcUk22pJRQPgIdEKfXU
	gfIzLSVH5fxVwKU42bgCiQTj9aEfUFFQ5uEd7ShC3aiv5oo4bipIg1yZc9TQc9tCy2A=
X-Gm-Gg: ASbGnctuQUWpEgP+MRo941wBKupV/2gU+Qqwlq888RvnMYeuDLSrP4ajF1bdMhixXRn
	8A1nVeXB3JlBpOV8MWoSsHwU8wEcITt3dCtO4dArfRAfs/G0PAAKqECZxyT9vy6DHSdAMvXBEdh
	4QVOfIDQqZUTK1ZvrnERKafyiUcrD7G2PArvTrHdSi3YMdsGJL528SJzpMsrEy+LH6cs1UWhvAM
	OK2ldyQoG5WBDz30aabPzgvHaL09Q14hMPNpWv0eBlKGkt/rSbJSAL2yKtCGHqy7FxhawaDkFEC
	rYPAEymfqyx3y6vcvd/rmDZD3H6+OJ7ZKlhi0lx3WPP7CVk3QLRvBho6o/137B7Rt1YojCdLcuk
	Dz9usiKCyo76mePv6iniDLNaN9P/HXQkRjWV9plZWPl/POLkJL6OgD7ArO8mjuDE8gUOFIVIArd
	FNTQPSOH1yRzk7Lff1M+SUOVtbKcXBRciWoGNRsFt+9Rayfb4QQ72UL2p1KYY=
X-Google-Smtp-Source: AGHT+IEozD5cdRIuXKqRZBVnxsUqJM/nYy2kEZY26uogQy1cQex4MnUvXAFA8vicpnFfEW7AKfS0ig==
X-Received: by 2002:a05:620a:4446:b0:892:a186:6b50 with SMTP id af79cd13be357-892a1866d2bmr1219386385a.79.1761062760478;
        Tue, 21 Oct 2025 09:06:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf34313sm75504191cf.6.2025.10.21.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:06:00 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:05:58 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <aPevZplPtDUPZFUn@gourry-fedora-PF4VCD3F>
References: <20251020210816.1089910-1-gourry@gourry.net>
 <10402943-b613-4bd6-ab78-f34efa74a95c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10402943-b613-4bd6-ab78-f34efa74a95c@redhat.com>

On Tue, Oct 21, 2025 at 11:30:48AM +0200, David Hildenbrand wrote:
> > Compaction `isolate_migrate_pages_block()` already expects requests
> 
> Please, let's not talk about "compaction" here, it's just confusing to talk
> about compaction for something that is not compaction but uses some
> primitives (because not properly separated yet)
> 
> Just say "isolate_migrate_pages_block() already expects ..."
>

will do

> > +			/* Don't consider moving same size/larger pages */
> > +			page = compound_head(page);
> > +			order = compound_order(page);
> > +			if ((order >= MAX_PAGE_ORDER) ||
> > +			    (nr_pages < (1 << order)))
> > +				return false;
> 
> This is roughly what we do in pageblock_skip_persistent(), just with a
> hardcoded pageblock size.
> 
> I'm not sure about the MAX_PAGE_ORDER check, though. If an arch supports two
> hugetlb sizes that exceed MAX_PAGE_ORDER, it would not work as expected.
> 
> Doesn't arm64 support that with cont-PMD vs. PUD hugetlb folios?
> MAX_FOLIO_ORDER would be better.

Will adjust to MAX_FOLIO_ORDER, makes sense.  Missed that.  Will take a
look at the pageblock code, I think I was looking at the compaction and
some other code for inspiration here.

~Gregory

