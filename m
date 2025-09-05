Return-Path: <linux-kernel+bounces-803889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11062B466D1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA463AA19E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E142BD5AF;
	Fri,  5 Sep 2025 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5pisFY9"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96429B8D0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112464; cv=none; b=L77wgshA2PlVzyTqlzzSyYrevVKuW7sus1wzClgpRXyi5J3WF2tqruMJnjS4HS12KLjugtlSFSGJfhrVPQ67vvnIQ31z7NsfO03NMsi5IWZRaVjeuSTN/WENjcfHuiVxzqA4Pcvij7QFpAZbIqLu3bqlaQcSBqnAf42GxEAfFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112464; c=relaxed/simple;
	bh=1qEENq51KcrDUXNZwje7lxyTf8mqEp73otnktCFs+yQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=h3Y9gHMK1qULcUbW6kTN2aa3gZMQrMeoEJkj8pQmNb5DvFj0goJAol9GIy00yXc8ia2hsrWwZKJWLhIbxLd9u/rcJ4OUeNQblK5l+Az+2bMRNIv+desVIfun6Frh5+U1SA8CvyQPLP/1DMpeNoS08wqd3FhTGnzhQB42j8a0URI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5pisFY9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24c8264a137so32989225ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757112462; x=1757717262; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmx3wlIJ1eDwZ4XBZbMsVjYFEQidwm1ewtHh14rsYe0=;
        b=R5pisFY9lvoHzNh4dY912OmPpT1W8MNywn5Pi87aMnrj381/m3LXokmXLh4af/pkcB
         Xk5CrV/OCnoTfSk7k4/dMG8QI1ycLTFKK2ku33NiUa8+VkGr1RdXNSsBE/PbmNF/lC/T
         zcOU8zEGQ4zTg6YYK1zC0nrJkEaxthrTdk7/kpBYa48Bjwrn7uyL8QXrrcxdwmdkqni9
         gBaLj7CCL7NcQyubifz4RGWslINF7hZKvDR6QijQYT7uRoWnV6+5IF30fbfKECtqaxPP
         ae/RELbZuiSdMMvs91yE14bYcpIji47JtbCh7ExhLABu385a/P1t1qDzdhlIDtt775S4
         tbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112462; x=1757717262;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmx3wlIJ1eDwZ4XBZbMsVjYFEQidwm1ewtHh14rsYe0=;
        b=AstB9E6W+DOnn3Gr6gxD0Pc3tAqC4VkN8slrmv7FDKvwHSz28FGK4e8qUuf6mbXudv
         NMERmDxz8KE3oC4S0Y+pt4a6IwnY0uwDIzKDQsaAbcVgjcE1y9HD1F6WxUl2LJSQyZcv
         nhZaFA3Q31zkuviG6OKyCeqWIuPcJAvF01vclCdnjBk/zFiZjI/TDu2p0I17S+CEMNp7
         96XB2gorFBZN/3TkVvJ7gEwJvL6lrd02iwJjPs343lcaZMTKiQ5SBfJj7rNFbb3H1z98
         bcKE6a9nkcLhNoTMgFZ8eV/rCbfUD1oGZwDeTIHJLgJ3vGEXXOmb52mZxC7t8o2w+iMJ
         bi5A==
X-Forwarded-Encrypted: i=1; AJvYcCWOcOgLfBHu44PpPakMaihrg8o6knRoOHtKBsW3ECRdu5rOXpllTuT3K8H1nfliodBzzhQbLGwzVckFpr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42E6zJXY9vMliHzpBz2uTv/y+UjWyMYZopmKh4KmOqixaJQdl
	ievgMkUevBP2nAU5CReHx0kktSxG+4e9CejrHVWKe7h7Jdr/NpeakorNJH0r3TXxjUA88uXHRm5
	gDI72Lmd0xw==
X-Google-Smtp-Source: AGHT+IFxVMXZNiowTRquBEGq3NjyT+CYIXxvPnTvjh9qSatvFbQBMQOwqtw/9eKbbSMaD9wkYdEdrABaLYAf
X-Received: from pjbst4.prod.google.com ([2002:a17:90b:1fc4:b0:32b:5e07:ca10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce89:b0:24e:229e:204e
 with SMTP id d9443c01a7336-2516da05c43mr3530465ad.16.1757112462153; Fri, 05
 Sep 2025 15:47:42 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:47:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905224708.2469021-1-irogers@google.com>
Subject: [PATCH v1 0/4] perf/tools build related fixes
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yuyang Huang <yuyanghuang@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Petr Machata <petrm@nvidia.com>, 
	Maurice Lambert <mauricelambert434@gmail.com>, Jonas Gottlieb <jonas.gottlieb@stackit.cloud>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing header files and #includes to fix the build in some
environments like bazel.

Ian Rogers (4):
  perf bench futex: Add missing stdbool.h
  tools bitmap: Add missing asm-generic/bitsperlong.h include
  tools include: Replace tools linux/gfp_types.h with kernel version
  tools include: Add headers to make tools builds more hermetic

 tools/include/linux/bitmap.h             |   1 +
 tools/include/linux/gfp_types.h          | 393 ++++++++++-
 tools/include/uapi/linux/genetlink.h     | 103 +++
 tools/include/uapi/linux/if_addr.h       |  79 +++
 tools/include/uapi/linux/neighbour.h     | 229 ++++++
 tools/include/uapi/linux/netfilter.h     |  80 +++
 tools/include/uapi/linux/netfilter_arp.h |  23 +
 tools/include/uapi/linux/rtnetlink.h     | 848 +++++++++++++++++++++++
 tools/perf/bench/futex.h                 |   1 +
 tools/perf/check-headers.sh              |   9 +-
 10 files changed, 1764 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/uapi/linux/genetlink.h
 create mode 100644 tools/include/uapi/linux/if_addr.h
 create mode 100644 tools/include/uapi/linux/neighbour.h
 create mode 100644 tools/include/uapi/linux/netfilter.h
 create mode 100644 tools/include/uapi/linux/netfilter_arp.h
 create mode 100644 tools/include/uapi/linux/rtnetlink.h

-- 
2.51.0.355.g5224444f11-goog


