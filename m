Return-Path: <linux-kernel+bounces-763530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A760B2161C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CC97B55A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57057311C0D;
	Mon, 11 Aug 2025 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MiUiKrCA"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709711D52B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942501; cv=none; b=Jk1yr4E9ObDT/qw5LQDiTLVBaYOwpVSTsFcKY2QmYJS8pzQI58l/0ZLz1ApWoRpeu2iRqjshmup/8XodT43SdMIdol8A2+TGEA50KS52CcYK/DKjq7X9KL0tqGeHIsNGLbcuy6G3i3hseNpLfiHRJUhNYG/Do7g7WjduRkQb9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942501; c=relaxed/simple;
	bh=jOX/yi6Sr7HDRcgpvbqyoAghNh0K1oDzjkbmmkbvKD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttjU2DPpB3Tzt7w40xmVSQA47azh128smyZRk8iV7wCYAY+eDENB6HgqJB8wzb2e/Ku7wZxvElSQgMCBkj/XZzveCrSAUB2rsxj6KampCM3Rz26yUrkxZnQ7P8x8CsumSVSgwy4JlJFQYFl5UpsKyzr8XRrKcrDWPFLU8lmfjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MiUiKrCA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-242d3be5bdfso6045ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754942500; x=1755547300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uxu6bAv2s8t/rSMFonYcPqI4bnsiyjgAqz2CcsGMxA4=;
        b=MiUiKrCANQdPAbtav94cJYZnrSi6XyNakon3B+XpW1wejbWbqi25wIP1SpU6r8ohKQ
         BNBozCzlCKyaBM4jlD6oiJMTvCbGFsYgeKFikLi8Vl4PE+cx1+Sy+ZPW1HkFsutZqFpo
         vOzEoVtWi6PX0YPrL08wolfaaMgTnUQ5kBrAk7ulATakJV2zdJ0H48QXiE5BVFlBeCmk
         X0laD3zbhUm0DlrpSGi5x72Ej4KfzaMn+sh1Hyd8Klen4lbY4Q42oWbpl1GLNNvb/V8J
         AkFYxtrn2UklDsRx9asN8o2L7vGgxRSC56yxE/Vudc5QGffapJidWFl81+BnWcKqaibr
         GzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942500; x=1755547300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxu6bAv2s8t/rSMFonYcPqI4bnsiyjgAqz2CcsGMxA4=;
        b=RZ+1gdkrHofgLPO8M+A3dN29fCn3cFpYRc9GE646OlFuGfNtYmlXnQZQ/Dk/EVG8oF
         FQlhFd+bSe/B40b4ypibKnaOlqteqgQIXI6sDOBaxZm1O2WQfFSanh+YEZqArkmwkzJO
         ykEOvnwZVBH2r4KXIVq95eHnWLOqoXylABimZZtGoNi5lVcKwt/02Mht1LwvE/h726QI
         AFVPgrn38GZ8v/JSl/qSa9J2xGLtQkCNPTr9X2DwnLwk5C9AGZn+VAA17UVIPnwldKdv
         K6exYCqx09xFOpVTH/J+ZLr95g8mHc1/vWkQl9ZzvzNWaAMIpI9yUsAC7Sdby2cnq1Lo
         hVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzyT6xQCXG7qLgYYv2sfZ8V1Sf3MQ1I5WhI8E0N6Hf4qnAnCadtS1Zj5GuEIggDsgOtUndZfaug4NFADs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRQuYP98ehysEW1aFGxQGZ5lzvROeFqYJqHWwhaTjRvM2ybzm
	sE8TJN6jEIdsV2jBMoV01xAWVylrjECn5FslhoVqtOjG+WlNdmfxgHI+sQJik1EiEg==
X-Gm-Gg: ASbGnctlWMpbDwHxJcnxA475c4W7dCJX1xvnrNXwg0LUoXDo/s6q4w8tj+rh/1VtLHz
	qTxv9iUS1sKbWpXCV5TIBoxt5JcAEoqWdYSNMQQz+BFgjs4WaoMUgoK7E8cf7zdiEjW2U2NoW1h
	O/OyzDTyiv1KZSJyw3HFQNMRNE9agvx2mvog98QZ5r4E1l+/XoZ8oM8UyQYBSCQAv+gm+aTZiWD
	CIadsdd8p81yH4O7O77NQJE8952l3mNGNghijIPcNFHEVblYgXiEsUtMPQA84t0EN2AFiYvU1m9
	f8eayFeQ9dwgYkvDczvrclEzECbRTbZZxYLogOeROI5pUmvfhokHfR7qd+98/rkih/2995Oevi2
	gocjQPmahdZmmB0JF+oiMxO4WVsGPlD9SVFWvQBNx0/kScCW6TBLJ36EO5syYSw==
X-Google-Smtp-Source: AGHT+IHWVG7hRlBUUjOqMUzLmXjVMwuf4DXMXom2zlwHcibkKbddyA0lvszzB+bNunnpUz4zMDVEPQ==
X-Received: by 2002:a17:903:234d:b0:23d:eb0f:f49 with SMTP id d9443c01a7336-242fd374f19mr683595ad.14.1754942499222;
        Mon, 11 Aug 2025 13:01:39 -0700 (PDT)
Received: from google.com (167.212.233.35.bc.googleusercontent.com. [35.233.212.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm27711067b3a.47.2025.08.11.13.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:01:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 20:01:34 +0000
From: Prashant Malani <pmalani@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Beata Michalska <beata.michalska@arm.com>,
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
Message-ID: <aJpMHkrWJIyHtHL5@google.com>
References: <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com>
 <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
 <20250811060551.ylc6uutni4x6jqtg@vireshk-i7>
 <aJo5vP_mfBn_vxSF@google.com>
 <CAJZ5v0jvYBUPjSmXas+S8rOG2WAb5u7rk92Gbu1s7A=tJr4VPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jvYBUPjSmXas+S8rOG2WAb5u7rk92Gbu1s7A=tJr4VPA@mail.gmail.com>

On Aug 11 21:19, Rafael J. Wysocki wrote:
> On Mon, Aug 11, 2025 at 8:43 PM Prashant Malani <pmalani@google.com> wrote:
> >
> > On Aug 11 11:35, Viresh Kumar wrote:
> > > On 06-08-25, 17:19, Prashant Malani wrote:
> > > > So, do we have consensus that the idle check is acceptable as proposed?
> > > > (Just want to make sure this thread doesn't get lost given another thread
> > > > has forked off in this conversation).
> > >
> > > I don't have any objections to this or a better solution to this.
> >
> > Thanks Viresh! Beata, can we kindly move ahead with the idle
> > optimization (which is this series), while we continue discussions for
> > the "under load" scenarios on the other thread?
> 
> I need some more time, please?
> 
> This problem is similar (if not analogous) to what happens on x86 and
> that is not handled in the cpuidle core.

My apologies! Didn't mean to rush.

Will stand by for updates.

BR,

-Prashant

