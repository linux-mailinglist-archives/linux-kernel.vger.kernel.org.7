Return-Path: <linux-kernel+bounces-761833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12417B1FEF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B76E189A9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E95827A93A;
	Mon, 11 Aug 2025 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0WCGDR5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF426D4F9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754892356; cv=none; b=fReJIvnFwp93L6S9/hc9Xf7ZXbfnAcDx1kWTWZxw8GqdDC6643aAICjRaHd4++DeTIm4a16hK+rHpIpk0ZFz3XETjxGXIhSoG2Et7XEWtnK5tteyvSjx/MpxFLTKxoriHNjbI5m7ES28t6/qyUckmZKPKCIrZnfphGQmlBwAXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754892356; c=relaxed/simple;
	bh=jw07oOfPIIudddquxIbhqqyzg191DRg7M2Uc5HD9xgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG067lAaWC+ISO4gONuOaul2ZAaRbzzLkDw/pe4UbqegiJIb6hX+May+7tTsQBAUnaQmETzzYRLzEJeN74jjZ/tl1ZMVtKsl+myqblNPf47/OUKzqUhv7TU+U9/5rZPisTzlbVhmh5GEOxgs87IdapsnHevmoXKdfd8dJNedvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0WCGDR5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2406fe901fcso40395645ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754892354; x=1755497154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pv4Y9hoI9PiZC02H9KvuEQaXOMSZ/GwCfxO4ubNZLUE=;
        b=C0WCGDR55NcAXFAJXJD4Y0zwF4Ulbp0WQUwfCQBVRU5x+vrzG3l5o+2+5i1nctMHea
         oPl2+thyeHR1uDrzSy68Xw2WQyJNe/Gq7/tx1hD75ritWpC+STw9Nxd+pRdqLgLymt0d
         d7DpwPrtS8bpbsMHmcYb28TDiHmrQztXWZMlSe7HvBCYdn9glbicq4+YcJAFqB6D2uYj
         AtmY8VbpzidU9rDQMEO9KiL/obRl+Vj+hvzgdbFfzRA9K9Lz/S9F+UOfc70iaCXwa6Qk
         D1hVWiOo3+58Su8zUWy0t06bXz3sFreEWI8zbkOFsOr8vFBGAb1qzLMmXQH/d80rqLUR
         4YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754892354; x=1755497154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv4Y9hoI9PiZC02H9KvuEQaXOMSZ/GwCfxO4ubNZLUE=;
        b=B3wuz7vYnBSgjnGQKCko2/jho7TElZVe0jmhYo3lnbdx+7F6StHW4Wr5H+0xgDdZqX
         Gi6YoEpNkwOF9IfAKVP95b+L4qaI7cLfiIgbMbKHKyQhHCJfQPi7jy0FYnKhmQWXbntl
         k5tZ2Eft5NhHXopIIjqGRlBNrGIjHIJYy/47T6s8otI5VFvTGK2v3xmwF6BCo+xrGPlr
         VOjSIycgUxASD7nd5VS0emolezRVKwES2wfZCCttqZPl3L0w+SNCHUQOQE9nJbqEOg+E
         +wfbdoC2Ld0h0+p7016yv9dDwSaa4bZiHmA8W6Wd2xFZ0wF8klEkWuY2Um2fe8AvvU9H
         U4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW8E0IpDslJGsK0tdRqOARnGXYciED+gsM93yXyw385iXKgvLCs6HWVavucsI7zx2hMHrmWv9ihwZO/9f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrS8IWN9vaKr6+tE69q3qjo0JoxO6UIw/OH+xdl/VUy/s2bzg4
	sxnVYR79oo6kwS1p7q5pVCHjQC4+34Tn7hCceGE5+Lw854LlUAChtZetFCW3gSmRAcE=
X-Gm-Gg: ASbGnctV50igddSkcs85IN4mnt+eKNiwb9a7CvjJHLisxDAFm9zWemEKGMOPD+54hYW
	MAQo1gnO2O6w0MYdpj+ZsR7YIK9AUWIR8HKWJWRxZDmJ3831bqlN8vd2bua/+LUg5Sit9OhZ7LM
	S+qTVu15WAxlOztMihPdhqnRXs90jlRrW3ikkAgKvBNdA2PYgohDvsB8StRapYhMK9U8z2OPSBZ
	lyrhgmX9OrFDJHh1NFAA8Pt95qH3vn/cAyenjWWPJJUHWUFBxIwSbntUmQBBSMNWubDdM0J6ykx
	4ra0/kbGR0ASg8nA+noCAgAO50xcxWp3+ODpPhQby3CWeYoBc0ntrGfOfDSG2fv6pBPXnj6Ozxl
	cq1cMYYKiYkt3/gLCbu8Wfr7R
X-Google-Smtp-Source: AGHT+IHYuEeM905+TEPBVEFx8PtIPIWjUz+dbW//zyktdq6/BorfwdhX7ZjxcijwB0tDQa+/72ZIZA==
X-Received: by 2002:a17:902:f544:b0:240:6aad:1c43 with SMTP id d9443c01a7336-242c2262291mr179601355ad.48.1754892354118;
        Sun, 10 Aug 2025 23:05:54 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67e8sm264942305ad.8.2025.08.10.23.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:05:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:35:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Prashant Malani <pmalani@google.com>
Cc: Beata Michalska <beata.michalska@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <20250811060551.ylc6uutni4x6jqtg@vireshk-i7>
References: <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com>
 <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>

On 06-08-25, 17:19, Prashant Malani wrote:
> So, do we have consensus that the idle check is acceptable as proposed?
> (Just want to make sure this thread doesn't get lost given another thread
> has forked off in this conversation).

I don't have any objections to this or a better solution to this.

-- 
viresh

