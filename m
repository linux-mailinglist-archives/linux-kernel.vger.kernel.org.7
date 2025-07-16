Return-Path: <linux-kernel+bounces-733767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0FAB078B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9484A0436
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2657B2EFDA0;
	Wed, 16 Jul 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="jnxU7/Qj"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684DA2D9EC9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677689; cv=none; b=lgJjoFY/k2oCH3fWwpZI25SNkJ7Flvjov3F3FLr446sjxzAdL0m4ed4UDD9vCipIPJOIr90FzcV/7g1KUZR/DAr1tSHdF/o4e7RMe/yxvqo4SUabNsgo7bUyyYBN5eoBqm9O2TvX9N3IWih3hBFet8Eeox2jmDZ71fV9G0TI8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677689; c=relaxed/simple;
	bh=7TMmULX4E+0XAKajA8GZDnGzNcCZyNcUZdKdIJQ18Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0SAaKTVaz0pfmo6a8ZNzPaK14Rp/7xMGLGk8zOZ8Pmynk44q+JFqAPd+x5+ijhJ6zsIfi7RFz4CVHskcxiVftsSlBuklATjCsXAPFgLK3+M0aA2UWqOf6xo3fHYTaKncecVE4DZWmI0nPFWFMU+g4KcX5M/AR/yK+ja7CTckRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=jnxU7/Qj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-701046cfeefso91086d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1752677684; x=1753282484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BcBE5y7Z/5WHswF3tKytNwZgjxEI9R7y4BDvXlYqcAc=;
        b=jnxU7/Qjq7X97AsniGRVR5skbzUeQqpT7Lj+gaHTq37gkhsCd25d8Der5z09s9fHfo
         fhcihWsbcrfNAtyd8SV7grLa1TZIJ3QlpF+SQ14PfUUNLCv8N6LuLWtPQggV8GxP0xaY
         D1WWwSwnKZaymwZmH9UOeFEUjJolqn+aKT9+Vt8qVainZ5FpvNi7qqYY3ni+o+VsMXOx
         EbUc4GIsc0iinSsWfD3EYusiuwYM1aybTOSRnmMiqLEAtRdn5gHa+M9kPhjLJu5j3tJ/
         ErjSGdYpK6743t6V57xc4qD0hsOmO03Lp2CvVcVOmzvMSWjxziRr0A+pbosv3NUziB0d
         0x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677684; x=1753282484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcBE5y7Z/5WHswF3tKytNwZgjxEI9R7y4BDvXlYqcAc=;
        b=ZXK36ulQ9Iwc5yasRf5PuQaVA7pMCHYfdLBHpdt2r50YdjT1M3etiAVN7rlGu8+Yx+
         73zn4cqf5ZNdY0vBJhPCcwYJo10UKNQe/hrklZHQODDXDlpEzLnBtrZmwP5CL+i4Iv3r
         E90XHgIlrSLWa/uvVS+XcI9zTlK0KSYA0do0gjNIBsNRO5fbhTdnu30/LYQnIzpit7I+
         3DJ7kwejj5jrtJsprXrTU7vTRoKFIvSzNy+CwkN+PR1yC1TcP0r4gVpszFwu3BbWkHPr
         4bt0qweX0d6btEf34irvpEIHzaf0fr9nyWgEfCJFrzr+cYUKMKZw2B/EXeNAYN0Rqx2n
         pu0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3whXJo0MdrYbpbDq6qZYpWUCIlHayAV30EaIcPKf0nEQajLUYZJHbtygN+jschy9Pj9UFaZzn3Yt1xvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3ZSVVqD45dNEaGIdPVkUBToysmsJ6gppa2GgdQTHFEAXnroi
	b0Kg9bEmHmTGKXsJu2JjQvRcvlEMztJ5XfxCRvAkY/aslgQM0JZPFc5EmP5oTAutsIo=
X-Gm-Gg: ASbGncuZKR0yjknf5qzvJYSFpHEbL4anZCVwGnJ6QyclXX6PXK8LLdtvsEp2v4inssQ
	amR+qAd7UR15nEdFC5eoOeUGqU+mS2ZlT6+ZT9RYxSh6CYQ5ez2Pf7s6FEKVAuasZE6iS75SYET
	LoC3OEF9Ky/0VRNh5BFOE8wiCMdaN0UDIc1Vlpw+sf78NhEboDCtCc2R6quoKoTvSsLwssHVLka
	kI4sq7hLoNc2tbziLWtRKOm5aknmXyE0sNYPz3cRI1e0L2hEYUfd4TBvq+y3Gz8XLVhrECRgx+g
	axKOGaAGwYjQN63m8pgSaRK1i1PUst3Je1vXMuaL0GTRUVVdcRiARPeh2QmmZDvz5XcPNbQSa0M
	lsK8nVOb9ZyUYSZsiHdXkFg==
X-Google-Smtp-Source: AGHT+IGZ7A5H3TwiDzPpQ3GjEgsS5nC/PFudwStfFIwbRqyLSXc722ngl72ralhhT6WmZIHvam4Bdw==
X-Received: by 2002:a05:6214:800e:b0:704:f952:1884 with SMTP id 6a1803df08f44-704f9521f80mr18354456d6.49.1752677684128;
        Wed, 16 Jul 2025 07:54:44 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70497dba9absm70823666d6.111.2025.07.16.07.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:54:43 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:54:39 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Beata Michalska <beata.michalska@arm.com>, Chris Mason <clm@meta.com>,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
Message-ID: <20250716145439.GA54289@cmpxchg.org>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.350561696@infradead.org>
 <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com>
 <aHdMTdPeQ1F6f-x9@arm.com>
 <20250716104050.GR1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716104050.GR1613200@noisy.programming.kicks-ass.net>

On Wed, Jul 16, 2025 at 12:40:50PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 08:53:01AM +0200, Beata Michalska wrote:
> > Wouldn't it be enough to use SEQCNT_ZERO? Those are static per-cpu ones.
> 
> Yeah, I suppose that should work. The below builds, but I've not yet
> observed the issue myself.
> 
> ---
> Subject: sched/psi: Fix psi_seq initialization
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 15 Jul 2025 15:11:14 -0400
> 
> With the seqcount moved out of the group into a global psi_seq,
> re-initializing the seqcount on group creation is causing seqcount
> corruption.
> 
> Fixes: 570c8efd5eb7 ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
> Reported-by: Chris Mason <clm@meta.com>
> Suggested-by: Beata Michalska <beata.michalska@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Argh, missed that during the review as well.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

