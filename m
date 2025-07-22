Return-Path: <linux-kernel+bounces-740128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E851CB0D047
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EC23B98F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77228B7F8;
	Tue, 22 Jul 2025 03:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mdKj2z+m"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768E22FF59
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154853; cv=none; b=fZGlSbBSGakCbaPmB5mdDqT0wDQLJ/zGpjqkb60oI6ZWAfxAWHjWYXAqUd9V4QE6LBCJJn/++aRBwY5Q7T6rGRo/w5I6MXAcbmUOsijZVzA8+8pa0gn1O3LldZ3BFS0BDVRAKLDBKziY45D+EPERXOUVx41us4UWYDFe2D3OK6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154853; c=relaxed/simple;
	bh=rybnPHNQaWtEYh9P8NGg87PYwoHOjTqXZlA3TioA/Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK+MEGcLATvS5HiCowVBCYpnTa1rBdxnnqMvGXGGaGcAfMche1D2DO4YTIEXsq3xFWDxpbkZsZ8+KoYVObr0mKF1q0dAKnuAFN6RIFyNWzUp7jK7ECiwU7s4PsHvWeBjg98MZbVZVzYRGbaJsqtNJtVNxse3tt8HGWAnmC4D0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mdKj2z+m; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748e378ba4fso5850592b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753154851; x=1753759651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9n3vZldR94+dA+R993bdHJdlDsdK9CxAgbpvmVuXZ7I=;
        b=mdKj2z+m/MS1sZlSlb2v+5p6LgVIyg3+uji4XxCkOmFbrJD4OnacMwnyUfpj7FbbVm
         3YfT4LeaQew5rBQRF8PbI83X4SeMNP42SJwRELP5GN88p1NXH3pfjVbWCJ67Rl2DINeS
         /CkiUPgTMnTMLBItxSQQAzNRFP2OuyUoSfZ6E122Mz41w7fO93Yk3PEZvZ/7Qb0qNNhE
         ZxJFrMABwRcnce3pPTEBznzFviXFyErc61PDEIXGHMfRyn7qtBQdYmA7N+u0doql26OR
         1SVFz/gN4pGOVuB4bxIVthw7aFdY+1WciovaHA5wqRv73j48RAKuFjGREymNTHyCsmi8
         vs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753154851; x=1753759651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n3vZldR94+dA+R993bdHJdlDsdK9CxAgbpvmVuXZ7I=;
        b=Fg0SVYpL+L9s6Tx/RxDHOicaFNIHyMZjFSfxS0R5Tl+i7uiwf0HBEzom4XB+ZPJCxm
         pUzM3zFDu8whY1g1s68dd2nCwukt3GzsmFz8y3XpJVHV95mDti9+Ft4RdYMfh62jkjbT
         /9czTTMsXT49K5yNmW+7Hn1gNNA9FrLH2tK1zoL1+5IfSdxll4u7U0BepCg2xtv6SIuN
         /D7FfaaIGYJ9CYXuro6d//GvpMW1KShKlEhPvj6lt59tBAtR6vLmFyKbCDtUhqyJEDSF
         aei+qN57Q192RBqnu75YTr2ivgXKtlarPTOf7YP3NIQoHH/vlWgF4Fw/4KzomiZ4IohH
         daEw==
X-Forwarded-Encrypted: i=1; AJvYcCXLysxKka5tdUvBgs2N61AnK+nmoPBtnJpeNm20mvtODi3j+takwRN8p/XAIP4bd1FVwu1L3X2Js1Jpbew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvqo13oe0Uqn8Bdpt8iFsWX9Wn7sNIWB9pxvXb3hYX09/b9+3
	5Et4ro6c6K5KdrMuZW5+uTDG/GcPPJvaed+YkCAvsVUg1VVX07zJ/fJtxDT8eimIOjk=
X-Gm-Gg: ASbGncsnO2ziKHuJ/Cbokn+Vq54B0IoDxmDzhLpHtsS0CBrXQV4uEK+jNFHbwHhso05
	C4veZGxkFYfUjPJlQuOVz4Ny8P+ffMn5Tfax5d8+HtFOFQ7UT48/LKBRZKL4CAlI1O9RfkXIUcP
	IuIGqke8rZd1TBghH3f4s+i/JeqQUAGhdhm2dXl2LQwBXk8rHGHZL+X1EmpUFHd7o/iU6q6yI/N
	sap7BTFzVNsn36uTPndoeC6iD0aSIHMEFjVLliyrdC2bEqaK6Feay3kKUD5+cS7Z7IRcHSEJ/RQ
	LL78In+SJHkOxPXZaGH/TP7mtmBGKR75EhOJAte+raTRumj1HOVGooqyyt0wFXdNkrlqZFf7DHJ
	oGWnPXrnFogZ6mKi3joye9UA=
X-Google-Smtp-Source: AGHT+IHMk+QFzQv06GlweYpnpIsiItziaGaige6hONJgvfku+e/v14Yrznf2Rog/c8HhV/kb3Rh0tw==
X-Received: by 2002:a05:6a20:1583:b0:231:a5f3:4d0c with SMTP id adf61e73a8af0-2390dc2dc9emr25205981637.26.1753154850730;
        Mon, 21 Jul 2025 20:27:30 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff61ff2sm5020397a12.35.2025.07.21.20.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:27:30 -0700 (PDT)
Date: Tue, 22 Jul 2025 08:57:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Prashant Malani <pmalani@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
References: <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
 <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
 <aGuGLu2u7iKxR3ul@arm.com>
 <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com>
 <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>

On 21-07-25, 12:40, Prashant Malani wrote:
> On Mon, 21 Jul 2025 at 10:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > Why don't you flag the driver as CPUFREQ_NEED_UPDATE_LIMITS?
> >
> > That would kind of make sense given how the driver works overall, or
> > am I missing anything?

+1

> Sounds fine to me (it doesn't fix the lingering accuracy issue, but at
> least frequency
> setting will get unblocked). I can put together a patch if there are
> no objections.

-- 
viresh

