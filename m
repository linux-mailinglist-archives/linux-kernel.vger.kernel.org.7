Return-Path: <linux-kernel+bounces-780304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64106B30039
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8386C1CE577E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012E12DFF04;
	Thu, 21 Aug 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="OuMw4xET"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D32D3229
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793972; cv=none; b=KtZ8BkkIYa6Y/ieJqD2A5FNAFWCIXzxp2Nzg3ZXx8Ma5C+vjX+ptlXylwEsnbOq4nsEEnUZl6HnpEAxTN82jNjTS/536YTLlNdjAhKhOyCbtUgMWiTgtUeRm/bPvp0hmrnidS9tVuVRDNbbtAC5E4zJmNhO4A1z7lpiwuhs4P2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793972; c=relaxed/simple;
	bh=zXb8mzhyDAOiQRlFkVttGoiYZ12TJHhDipvTCizuKy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0XIoeR3zzQotngv1ov8VgKFiXUK8oE2XvFk913UAF374MV7WEoROTaLDUGDA2FUD7GzpG/CQHSdqXJhA8jcTKVtttYw0juXOPuHSG5rnlCSTXQ4dKySUP3zUxuiN1XlgumCk5uNgLEpI1gqEon2FgITgtHISmSB835u5U8KZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=OuMw4xET; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109a95f09so9055481cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755793968; x=1756398768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJBIccdGfoJ7TBGZwMZmL6UTufIbSb7K8pHwnbZxKm8=;
        b=OuMw4xETQIGKK91cRdVtR2INRguALbp53dq9osHSpwBVBebH++UamP5XmL6bBH8DlM
         Q2ukoejJkgbMzralRGGw5KI9c17LiHreNocnXdL1Y7O3spUndq0uJ4P/WNQb5fbUd9N/
         kStK5z+Yn//+UoULDtW85t85Rytdus2X5pIgnu8opZqa5n+UDU/1hCJwm+jDx9Ze4Jo7
         yhR7MPtbBK5BeTZY/G5p73a1ayiwV36myme7QwjXl53fomNaopUKQ3s1CYo0HpZrwJ4R
         NdmeXtkdXbGrMnZYijXRZLw+2oFqHu5LA4ySIO+7tzW/lcHYrSQfB53ROvEWutWQt35W
         az2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793968; x=1756398768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJBIccdGfoJ7TBGZwMZmL6UTufIbSb7K8pHwnbZxKm8=;
        b=hM7brBcx4c88WD/z70yev5w0w5llHI62ESGX2IH6+JKSF5avR8T1VZ2DlL6nRoeYaI
         h9gFixcusSoNxoU2D6qZgqS6E7bo2dEYk7E5ypsQIf0pKtTJ0fojpT1e95A84XxArmnG
         55t8It+oIZ8TYP7M3Yc5XHdHg9wIM07LWucoUZoAnvoaZcAxc03g/lzY81u06EwwJAki
         HjLix+daaIHVeTY4HCKylJIRQStPQidlKhCjIb14Nb16KuadHvDeQLcp3ioufTtcSIE3
         cpA+6PwKCo9reqMk25cwkyUIwQ0/VEzuGgQNjcPsCqcLM+Ss+twUHCUg9XPM9T+7QhRo
         Fp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK2oy1razPaUg+6uJEXXVZkHlRmL0W1wBwfkyxEVB4ZWPwJQMqdJMsJRwoQJV/JNbscUAXKuv0turhjtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZJRUYylGjX63UxwoJ57sHbSFGC1gFL9vrejfnpa4IpOlqJkx
	ONptJAHt3Eqt8RZDkUDLiteUuiGj85OWMHc2sHUsmSNGl/ux8i1rLNeZSXeL9cGu2dg=
X-Gm-Gg: ASbGnct12LM95u/0gPSfjHer9Dsa84v8HWwJg56vBc9437uNZ1Kb23ipKDO534BAQxU
	wptx6/FDjtlIY5RcTN9pN3sa4WopD+6gLsVZOfwvR+gNwg0hNuxNAyrVdq5ibuBkQYTevgue4so
	mLPFxFfyGQuJoVazINemAOLLvCMcYmFSCaSRN6WgU8xpp/zb7ohzUpEq40uqrVGlGYgsD7UErVg
	cmKQCIARI4NW/Rtzz+AoJmw7rFyCtlUrXFRsSpBIIbV11mGPmk/ylsidj1MR/u+xPCOg0s2w1+O
	PiU/IroxsfWuuZA20Qov5CFdVGtUmxThoviDvaugFJtj3cTCpjL8ZI7VFxzIeh4S3WZRie1ybS0
	Cqxru3LI/nSv68uk0LvqAFQ==
X-Google-Smtp-Source: AGHT+IGzFmxFGgD1qjjvDRMkuysEk61zJdizJHSCops/dSlcfNFa5m9ubk3r2HMYPciXBSNmvq0umg==
X-Received: by 2002:a05:622a:2:b0:4b1:fa5:c5f6 with SMTP id d75a77b69052e-4b29fa3c13fmr31056661cf.25.1755793968196;
        Thu, 21 Aug 2025 09:32:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b11dc584cfsm100798581cf.14.2025.08.21.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:32:47 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:32:46 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove is_migrate_highatomic()
Message-ID: <20250821163246.GA133370@cmpxchg.org>
References: <20250821-is-migrate-highatomic-v1-1-ddb6e5d7c566@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-is-migrate-highatomic-v1-1-ddb6e5d7c566@google.com>

On Thu, Aug 21, 2025 at 01:29:47PM +0000, Brendan Jackman wrote:
> There are 3 potential reasons for is_migrate_*() helpers:
> 
> 1. They represent higher-level attributes of migratetypes, like
>    is_migrate_movable()
> 
> 2. They are ifdef'd, like is_migrate_isolate().
> 
> 3. For consistency with an is_migrate_*_page() helper, also like
>    is_migrate_isolate().
> 
> It looks like is_migrate_highatomic() was for case 3, but that was
> removed in commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
> accounting").
> 
> So remove the indirection and go back to a simple comparison.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Oops! Thanks.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

