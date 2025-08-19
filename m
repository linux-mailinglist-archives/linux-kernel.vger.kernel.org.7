Return-Path: <linux-kernel+bounces-775955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68316B2C6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5375F188505A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BBC2253EC;
	Tue, 19 Aug 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2eQCiOi"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9D020FAB4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612875; cv=none; b=Tu3Xsc7lYUWbdgOn26vClC3Rv2ghZk4q7Wq1SDJRitMnVlk+IjXRzztmEldzIjknhJn2irh5+fyqOlBjmwbiBwxLeXGjQvGpGZL/GDiH43nJPOcl4UqqOKUPEFqcB72N1xvR5feCZ7EPVPfL8MRWU6L5bUmnjArHzMim6mZTlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612875; c=relaxed/simple;
	bh=hiTMmbSS/+FfxgDyUqFCpyWUcwgOBRKgn2qJFZyqxes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMlYVNTJWhbyHGdrDmTfvSoabQ4vol0bCD4JaJ5ezQX0nFCQI590n0foVzuAYr7vRLBYdBMdtWqDE8WJ0bvt48GxdPB3Dvy2xdl+rfInZi0Op/lrI8c3Wmpi2TL3R2Z/e/y4Yllsb+PpYzC7NTKnY1rpy7xp4afA25Siiatn85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2eQCiOi; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e933de387b0so2743566276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755612873; x=1756217673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6OXVvsJAqwWj19qshRwBn1RGNqG7oLB/rfLq/U8waas=;
        b=f2eQCiOix3OJ/P1Yri8NxC7uFuTpLVp8t8whJOUo479D7Ckg7rT76aglPyFMsMEmJn
         l0CPI+KHaGo1Qte22fj6OGqVvT2O82XAPNJjfC3mx8bRjjQzxy0JQsKNz9ERimVq2P4z
         OX3ZudRDqPk7F/T13wplPJSeNt8BhOgy8LM0JGhbEqnIk6o4FG8MLMSD19kz5U1N/6LX
         EZYvyRZa6mUHMZyRBbPUbTiKl1rCm0SfGufNS90CGxwan7i9My0g3KVUbI2oHG0NbRnY
         68U0v67Z0CBy7KVflA6xxYtLll50OKs3m17tkptoLSuiLgX3Z9Vf2CUDOu7DV1IxAPZv
         Ip3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612873; x=1756217673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OXVvsJAqwWj19qshRwBn1RGNqG7oLB/rfLq/U8waas=;
        b=gh/X7WGnJ9rfCeImhUYeFmBGpPx9A57HY56Kdr24j4JzdMfmObz3uHcIcFc8QvdHIc
         uyTteCiGfay6Imxv9szr9mjsHQtieLuY9jikilfigdDHp483IvFmkjMMtve2PJWL7bjB
         JDGWH8/8nZ2j19b65bmEfw3odczLiKtLltivrfbFSLbOlTksOKFSosRojn5Mgm0hgE47
         vjdFErA+EE10FH0oUNlfVd4/WJG3/cdQ8WryYeEUagRd2dJ7UkaVjbek36waCWkljPlo
         NUxffylR4zu8GgS2PndhU5UgsF7ScA56NZUjIiuX6FvfcRUhHg7V7mihs5UterumLVaS
         UQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoRbmrUxWrU4/RqXriTXTeruvFqe9gAwNckSBWC97GJyJoZJwAvCFziCMTm9eRGQjqi2SxDDwG7lFx4m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUzlKWC4xojVvbEVANvjp8EbqURbF5382egrN1y6t9tt/BKoS
	5NQAfv7QUnIqMmd5sD97Q9rDPB8kK+zEr9xUzeF6quoHSv4TIq0Aw/pX
X-Gm-Gg: ASbGnctNva82gPd4kSVZkK9rNRACCni3JWgIRElOGfSOkvGD4IdZNWW7u75TWKM/uO1
	H3SRTb+w/i9BcpJskIGYmHCIQKaBhEyDB5uvDaG61fJHVShT5YARl+D6/XWASzxfN6ZXSI/aUWa
	Qxk9QGK1onjMvtRGzsM6dMdpMVlJW5rTdCqVlpaBD1PNYsDFGuF9TsewZZeWiANGz3oAkYixl+f
	VEBiTwL7kxbI+q1oD3Yl2FEsoAw0Xb5PJpDBETOwciw/WM+rChhSQlbXIeJZs+jUf/AGrWAr3aH
	eaMgqcR7s5ZCHDofuV7moYqNn85+zHhZuHb7TcILFjRpDturAO3xUxIPUizV3cdVVr2Zqa3T3ny
	/xMsFSI9H/ssErexFUsLUsKBHSWQwVOWF8NRfwnF8s2cmfIHGbWDxZSJK+g==
X-Google-Smtp-Source: AGHT+IEwoBjfZUcU0Qo8x7NY91MD6b+QCV9ORzg3kRpnhUgIcF3Y++/MFV4JtUz7cd7PRljcqyFbOA==
X-Received: by 2002:a05:6902:1383:b0:e8f:d14f:aa with SMTP id 3f1490d57ef6-e94e79b1c54mr2402013276.14.1755612872953;
        Tue, 19 Aug 2025 07:14:32 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9342de8fc9sm3158696276.18.2025.08.19.07.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:14:32 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:14:31 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: simplify sched_init_numa()
Message-ID: <aKSGx_86_Fo6sYZ7@yury>
References: <20250719210753.401129-1-yury.norov@gmail.com>
 <aH37LDGeNHoT9abR@linux.ibm.com>
 <xhsmh8qjfith8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh8qjfith8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Tue, Aug 19, 2025 at 10:52:19AM +0200, Valentin Schneider wrote:
> On 21/07/25 14:02, Srikar Dronamraju wrote:
> > * Yury Norov <yury.norov@gmail.com> [2025-07-19 17:07:51]:
> >
> >> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> >>
> >> The function opencodes for_each_set_bit() macro.
> >>
> >> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> >> ---
> >>  kernel/sched/topology.c | 7 +++----
> >>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >> index b958fe48e020..7dc3c79aa480 100644
> >> --- a/kernel/sched/topology.c
> >> +++ b/kernel/sched/topology.c
> >> @@ -1932,10 +1932,9 @@ void sched_init_numa(int offline_node)
> >>              return;
> >>      }
> >>
> >> -	for (i = 0, j = 0; i < nr_levels; i++, j++) {
> >> -		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
> >> -		distances[i] = j;
> >> -	}
> >> +	for_each_set_bit(j, distance_map, NR_DISTANCE_VALUES)
> >> +		distances[i++] = j;
> >> +
> >
> > Dont we need to reset the value of i;
> >
> 
> That.

Yes we need.
 
> > Also now we may be iterating for NR_DISTANCE_VALUES instead of nr_levels.
> > It should be okay, since NR_DISTANCE_VALUES is just 8.
> >
> 
> DISTANCE_BITS is 8, NR_DISTANCE_VALUES is 1 << 8 aka 256.

I mistaken this DISTANCE_BITS vs NR_DISTANCE_VALUES. The first one is
8, so we can benefit from small_const_nbits() optimization. But we
actually iterate over NR_DISTANCE_VALUES - and no benefit for using
it over nr_levels.

> But here the use of for_each_set_bit() means we'll get just one extra
> iteration compared to using `nr_levels`. That said, since we *have* to
> compute `nr_levels` to allocate sched_domains_numa_distance, IMO we're not
> gaining much by using for_each_set_bit() here.

I'm not sure I understand that. If we switch the loop terminator to
nr_levels, the for_each() will be the exact functional equivalent.

I'll get back to this function shortly and send v2.

Thanks for the discussion.

