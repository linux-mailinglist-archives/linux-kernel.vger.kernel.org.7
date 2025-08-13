Return-Path: <linux-kernel+bounces-767601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE4B25698
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5EE3B5E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C9302750;
	Wed, 13 Aug 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtagT0no"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459CC302757
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123937; cv=none; b=bNtV0WmMgfxEThHJWjkxds5b09C5aXqHJjv2WtUBz7KzCa+RDHMFaA6KhjN1w6g05/i/TKhoFcsbZOja7yDTetCR2319qdnq/SRnr6sdri4fSbzd+PZRN5AAoa5gamtqhu0nArjYzVm97OPwQ0mLuLlRQ3bGyMxyiHKTK3fw+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123937; c=relaxed/simple;
	bh=raUBW/Rwb08ubnoczjUwuWKQXa9m1IdVItor+BrO4Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE7lI0t0DMGF7QRJtSfMfN5gaZolSbuV8ISBH6fmtXZD8DixDVqmcohkAbgyUJrmVbpnSeqA9KOUVD/lqc5apHzZT8Tno7kgDkA6NFKZnW4cY43JPhCFSLXa9/EzcAAoS0fjecL+isefg7BYsTLY+Ruw9396K5DmGygY3d2FXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtagT0no; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-242d1e9c6b4so80015ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755123935; x=1755728735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=raUBW/Rwb08ubnoczjUwuWKQXa9m1IdVItor+BrO4Qw=;
        b=YtagT0noN2fkCae1O1KpXmUbwK+1MYhT+oqDmqnRKgBBfW5BrfoxuOD3wGN/QBWWE/
         w1myyY7rTo1NMomNpwKrGB+nk7l4rq9Txy8fK1gSOOr/Mc+XiFxHaUtEM440eZB3uMuY
         ysF3M7C/rAw+F9ALH52QcbSAx417Hmzxj7NNxtcmLRXRsDbfObipnnDHggOVT6DXTEgj
         Kfff2N4u/buv/8ddDzuNXJ3MJ6PXBY5nMJDILOtJkw+SODumDqsAwhbxv0aJi/F+OhY+
         ZjnNxgCb+99FpqKYuC8EHEBLUaEoR+b7AKvcb1kfVtKA4ENg7lDTLGFHWNIyh5nD/lw0
         qRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123935; x=1755728735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raUBW/Rwb08ubnoczjUwuWKQXa9m1IdVItor+BrO4Qw=;
        b=bO7MEEgx8LZHd3FQmH6eqLV0tQTVOGdyPEpMJYrZci1w59RzHHGrO0R6r7O1HUsgHN
         FPb38jT/T1rSjc1KMnMyM135xfO2EI09LGDvDDDbdbd+zeJvL86BWBVNQ/EOW5Q+v7QJ
         TekHAHKWNSNBs+U1yPqYzDaTUH/GaPzwXqFSyVLs1MLGD25uPFZX1JeEe4znCWAbqRZP
         iA3dGx34Wi/kSQfwj+FHAO/gM5+qxXtWaTprDDvei4yTKBUQuik7cm6uYZM2dzwW5f4w
         Y+TnsWMVSntoT16V7htSPcGymzTdTEHTo/ZIK1/n2oqmpn7a4GP3Cb4TIbzkYzZWH1if
         JpJA==
X-Forwarded-Encrypted: i=1; AJvYcCV3G3MWm1bNQg3+omtN76z5HhMq7tJMsjUPXbZDzPD5pr2yrqzZoNk9CUMSK8HkN6B+4kOg/K1ZpKukJKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0ENKMPsBCYmoC4Tp/qSBTD2t3XHzmICrvj+qBWlBh1aJW+Eo
	MA5RB3MgcHHzdsim7BSDx6ynG0aGG5EdRxGB7wDElE4D36snJcWJ8gWGGQobaQLKIA==
X-Gm-Gg: ASbGncsvM/rsYPbZ+eVIVzzRjaDh6KAdVqKR0SCi5oinqddTP3mSvAvpvXRS4cKNlrB
	D+Cp+sEhP3bzEZsJAT57DbOModQjjFAmQkG7/ArdQ4vk/TXPLua7ECAZl9+SQHjrPG1Im1QR76h
	9CN5aQEAQfZhtVq321QDkxuorphcR1YBhV9BkaMsjeE/rVSa1kd6tWMicJBogLBBnJFyil8cnnx
	CuVdERRuZQLqp26ymepsx9fLM7RbO+4JQ+6cKrahe9FZnnqe/jDRDKjlkTW7Q8g2k8dLJb5pEXw
	qgK8Ia5etn8d6MjwmuyRverrFj0pkMiNQEZt+xQE2w49AqmH8LhXYTZu+KKR2hz+IryJVbJUCNb
	GncuPQUKpAAZml9wFgAV9VfkcuJvequujfhpDva1Vxyb8d6H8SWiYZfgnkKXqKw==
X-Google-Smtp-Source: AGHT+IG1N03rQpeAx72+yz9CMGd4rX7g1DTxOuQnxcey3VbI1ylZABro6XbAD2gbqzuQi9feBogTOw==
X-Received: by 2002:a17:902:d491:b0:240:86b2:aee0 with SMTP id d9443c01a7336-2445a702649mr286615ad.1.1755123935216;
        Wed, 13 Aug 2025 15:25:35 -0700 (PDT)
Received: from google.com (167.212.233.35.bc.googleusercontent.com. [35.233.212.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232577eb37sm1075365a91.13.2025.08.13.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:25:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 22:25:30 +0000
From: Prashant Malani <pmalani@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
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
Message-ID: <aJ0Q2uEQ03P9Nuf1@google.com>
References: <aIso4kLtChiQkBjH@arm.com>
 <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com>
 <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
 <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com>
 <aJMCgGt5zu5Dhrd5@arm.com>
 <CAFivqmLSp6RwfsPBK0d=zvRd6M_5GoeU4jHb-0OM9BpaDeSrzA@mail.gmail.com>
 <aJR-4J-sTpLaNIJB@arm.com>
 <aJVdjwU-qkdDIXaD@google.com>
 <aJxlvMFD2hHaKdoK@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJxlvMFD2hHaKdoK@arm.com>

Hi Beata,

On Aug 13 12:15, Beata Michalska wrote:
> Ok, that's not really good.
> Any chances on sharing which platform are you using ?

Unfortunately I can't share that info ATM.
But it's the ARM standard counters in FFH, so it should be reproducible
on any platform that has that configuration for those AMU counters.

> Remote debugging tends to be rather painful.

Totally understand. I really appreciate your patience and help in
figuring this out!

Please LMK if there are any other experiments/patches you'd like me to
try.

BR,

-Prashant

