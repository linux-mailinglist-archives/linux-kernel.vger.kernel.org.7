Return-Path: <linux-kernel+bounces-676369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6825FAD0B63
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jun 2025 08:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E604188FA2A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jun 2025 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637BF2594B4;
	Sat,  7 Jun 2025 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAEfyFTW"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976D1C6BE
	for <linux-kernel@vger.kernel.org>; Sat,  7 Jun 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749276796; cv=none; b=POWSqzdaI9jSZ3wdbVwQbwRb5nTj6T4NBgPT1KbP30PvAKQ1I0hemHDhyxaeu4Ks0HxfWuSgvC9ynHTyDcwfa4hP7BnOvTaBMGp3tUGrZEIlCT6XaAXm8aofyWi4acmopwX03a2I5OW+lzz+S/7s2mckPyCL3AKxZnj8i5a3hjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749276796; c=relaxed/simple;
	bh=SfzCslTg7FUskHtU5qkqJT8Z1pqMrqj5+kjaJG91nS4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=s/5+JTogUjvlQm5iSQgE0jl2I9AoIsinLcpOtduZyDZkNE5XuFyRlBMbS4NSBfCQCbTmZKvZqQ5l3e28L7DtaOz6E0a+EKEyUFSaxpKaIPhPBKBUqgg0leN4bhOfz2FiIuxtMVjQg/9dk67VVWqIvrh2CrLN3LEFGGOtoxV+loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAEfyFTW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23592f5fcb0so43822655ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jun 2025 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749276793; x=1749881593; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sJD5E+0Fcbf3IjrC3jfxv5TUMepu7Kfa9Vz+4EtPR9o=;
        b=EAEfyFTW5ycJR/YNaQlihNhPHyXwRAjmavu70csiM07ZAEX655LA5Bd+JjGrFk3jC6
         OpkUw+HeiNfMKZ1Ip1bBi3PNf+gxfmu1ibjHD/8xlnRZ8199RVvi2PhQhZqLCTtoOkvi
         L3ISN9IEzFiJDYUbWxN65ODDXLlD9vErfOiEKPgZ9E8MNApLWKvprcWtiCBBcp9h74R7
         t0w97Wnsnxb0y11DggMKiUI5XUcw54twLupI51CDDA0W6gWc/06LSLLombTlO3S/B0ao
         yuz+eBVbs8Ry/Vjnv2xzwzZ7cnXaP/2xOEj58S68hnrBNDZm6j7Avm2NFaqNsckSHHy5
         irbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749276793; x=1749881593;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJD5E+0Fcbf3IjrC3jfxv5TUMepu7Kfa9Vz+4EtPR9o=;
        b=hfBM93ygEODL3s63m1Tc/Ymjwx7oyUfbSq4UWuhTdushceB7u3Ku5cLeHi4dm9ysAS
         z+q+uYqe1r9LELBuUx85RXaE9G43SUQxn0pXE/Fo1heFO4eGr79NRqR/mLG874pBWubA
         NMHUcQNQ+g3x/NPbk060Pv9hxuoy30hG35PaOOUGo7Gal4T5MbOb4rl9S6kv5/F0XFbf
         oG0H09vdpAigbzqtsUbVHYzGOUYHblJcnKoc08k4sptdJYiOfSk7MeSH/2nYdsWmbd5r
         U4HKI7hvsMWZyqwCXcy4LW28UBPLtjl4l1ACRdDnBfe4S7tJIZIt19+4slwgCKD53YEi
         PB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVx70KR2yr+kxd8LrbQ4aKtAgnIcfZdaJXWnW4C/aWJHTLfjTrXfivtsPkr+T46bdufIzp1DbQNIoZHAUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmhQE48M74a7gOYPfw+q8RvkuwGh9rOpurbNxRxrP9yiQF/cTw
	THttyWqUTnNak9h4x7KFrRphijy37zTnpLiORvzN8FZmNjXDZSMYrBCm2sd6bo/+H5bB5g7JsbT
	Jq6yW1hKmUg==
X-Google-Smtp-Source: AGHT+IESG86lWsGrnXT531aY5QwFbMGojtb44hgC7bu7eDmJoYZRQjG61FmihcJMS90FqH1Z2wMc0nypTnrs
X-Received: from pga1.prod.google.com ([2002:a05:6a02:4f81:b0:b2f:5c37:666b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f711:b0:235:e757:ebd1
 with SMTP id d9443c01a7336-23601d18701mr96634415ad.28.1749276793580; Fri, 06
 Jun 2025 23:13:13 -0700 (PDT)
Date: Fri,  6 Jun 2025 23:12:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250607061238.161756-1-irogers@google.com>
Subject: [PATCH v1 0/4] Pipe mode header dumping and minor space saving
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pipe mode has no header and emits the data as if it were events. The
dumping of features was controlled by the --header/-I options which
makes little sense when they are events, normally traced when
dump_trace is true. Switch to making pipe feature events also be
traced with detail when other events are.

The attr event in pipe mode had no dumping, wire this up and use the
existing perf_event_attr fprintf support.

The header's bpf_prog_info or bpf_btf may be empty when written. If
they are empty just skip writing them to save space.

Ian Rogers (4):
  perf header: In pipe mode dump features without --header/-I
  perf header: Allow tracing of attr events
  perf header: Display message if BPF/BTF info is empty
  perf header: Don't write empty BPF/BTF info

 tools/perf/util/header.c | 46 ++++++++++++++++++++++++++--------------
 tools/perf/util/header.h |  1 +
 2 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


