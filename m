Return-Path: <linux-kernel+bounces-750053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2A6B1569E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E32C18A70F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405315A848;
	Wed, 30 Jul 2025 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcyuKJcO"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611612C499
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835884; cv=none; b=FIMbzJ76V2HMqQePu96YcWF1zxOAddikeqfnf+B4J2UnJBB1px1LG/gCl0lsBacRJ9C9u6HuFY1tizbq8olRq7GvdlJ9ZMBrpykg4NxeLvjFYwXNXgdr8xAeMp8/0uwJ5M2927ATGobx5E1qzsl3jqDN0/YHNjr6qjTQbWjeF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835884; c=relaxed/simple;
	bh=PoyA0CcW92FoQ3I73ytTZfPzdZaHEfO3pw0xz04Rz34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uEyGKMntZcmDomPZbflreTuG/zeTKXo1kT3At1yIAiZL922l87xPi5bzDdQzK84u2UbuCdpCIU73mxtku7JnQ96q043eVNohEeAW3np++b3odzPtvj/pHon4WNgiBmOn7FJIw7Zzj+d5uVde3lUlxP/+lk7gGOT2mCYuKhrR3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcyuKJcO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af0857f2so5716368a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753835883; x=1754440683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PoyA0CcW92FoQ3I73ytTZfPzdZaHEfO3pw0xz04Rz34=;
        b=mcyuKJcOLvd4KWcA6XbGTOORwXL7XY2Bymde0/RtCaPOAYnsibjcnompPYeGvyqiBR
         sew8Ad6fOZq3KnLvmMOAK5GwJdtYUuK9nhreVb+xC4wVVwrTKSrCOUl/UZ3ihGFTBLvt
         uNwk/fjxG0yw7vRVNCUtVnW4DKVirBEdJsLUXAh90tXkP0h6BWB6OHO0qlQ2PHs7pnKl
         Hw+3KNmxLdyORTrz9RqYF+1BJKGHqLuQEf6xHNRtMpD5IE+BPcQ1wMh2jtqqow3efMOv
         kLw45fT//yUtqmL7O2ZtwgqSgSvV6oDEEPMqlNeY73Jx2lekTPB88zgjhmnmS1HxFm3L
         E3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753835883; x=1754440683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoyA0CcW92FoQ3I73ytTZfPzdZaHEfO3pw0xz04Rz34=;
        b=sqcP7rWGwHBHL78Jo4PHLYwshtSySEHYxq3A59Sm8yNqUvXzQa8VNISXa1rGn/4kTZ
         vL5PT9lKBiu9BnbB0jgqrSw5bwpYXhzHM3z320ThUJ7t69vHKWhji/P0KFd4yI7GZ3wE
         rQ28NSq9vsPjpfbZMWC2i7QQ81u55q8dQ+1Q33XiLtvi7F382WNPNudRMqixBFkFK+VX
         HaYUNcpezqtjNJ0LKtGNvpfUNoTBpkFWnoCcgSiE1SaI5DQMPDeNIfn1fuKCm5s/sBmO
         pMi08bNBHv7568mVdZYuiXWUXw6Pu7dCDLT+4Ph++s5F5I/xGEYOIg68kbEV+FHjBOYK
         O+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVysxngvm1BGaUhyco7LyylA8zzIoq21Mm2BaNqFrm//Xdc4Wc8XahZ+hunnEuRgjB3Y2/tWrdNLyHj+dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7fWlDCruLjtgBCp0AkXxk5uViUktTmC9cEsvyFCEr+9M6gVS
	qPiktHAICGyQyCFNYucSu1GyK6XLGHzI96qOBlFqx4py7YCHjad4ciDNiennoZe8joGn1yw4gIM
	CfWlqVQ==
X-Google-Smtp-Source: AGHT+IFmEOk3LVUVJNWYxzRPuTmK+e+GHYpOt6lQopxXicjjLZ69T+VUxxaSfay3rEISbglMLxNY+x5v644=
X-Received: from pjbcz8.prod.google.com ([2002:a17:90a:d448:b0:31f:d4f:b20d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384e:b0:31f:2bd7:a4d2
 with SMTP id 98e67ed59e1d1-31f5de69998mr1735098a91.35.1753835882538; Tue, 29
 Jul 2025 17:38:02 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:38:00 -0700
In-Reply-To: <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-21-mizhang@google.com>
 <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com> <aG6QeTXrd7Can8PK@google.com> <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com>
Message-ID: <aIlpaL-yEU_0kgrD@google.com>
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>, Mingwei Zhang <mizhang@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 29, 2025, Dapeng Mi wrote:
> BTW, Sean, may I know your plan about the mediated vPMU v5 patch set? Thanks.

I'll get it out this week (hopefully tomorrow).

