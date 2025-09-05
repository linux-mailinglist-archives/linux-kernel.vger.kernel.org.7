Return-Path: <linux-kernel+bounces-803891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C14B466D5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30511B26786
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D72C1780;
	Fri,  5 Sep 2025 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enq1WSN/"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D02BD030
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112468; cv=none; b=Hv/bcb7j7OtJ0mgBHQgW9L5VhwVM2S+itEWMnExCO4x4UavA8zf4aDVxpsfmQP4ffC+Ebg/FGuDgm08h7VTBv2FSffcM+tXpMYAK2pK5MAZ0PMkGQRaOBO5KQxRsrvcTwB59DhYsUTxcDcN55QPY4OAw6u8yg2o9axr4EewUT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112468; c=relaxed/simple;
	bh=kDf2PBFUBHXl016g8dwIQvjQR4iisda19HAybZxyWgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FsvzNkA3l+JdIihZy/eGUldtQUpNVNfSHN0pM0fgJqcCeQ+OPz/w0Nzy4W1qvkx5k/XBt65BRvWV+E0Uh3uzeh5HhQ7824xC8Up0FVoR4QLlRGZU9Ytt/xMYEgibhHbSaRXeftxVs8CLh4IpJ4gEkJqHqnGCdN3ngtArfh0HHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enq1WSN/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24ca417fb41so32162375ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757112466; x=1757717266; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1mAO5A1gn91KXDnH98r+B5g3x8oPbaMvEMjp5ywFmI=;
        b=enq1WSN/MY6K4k78KuiPkUCrL2ksdTAbeT1TQ7q4vBvRv6VcCpEcMqgu58baHPw7EY
         EuB9mGy0BBoJZGhMaPBnh+p79PGQgVf353RoUmmvEySy8jl73Iat/UOF7Xz3C46fGdvt
         Zwad2MQSXytTwmMoRnVrHJu3nK5myGmwHUZBXX2gfLuPHKc3F/jzu9YXkjhX+7bbARVh
         JTs0Fo8ZX0JczimNB8w4vkZ6UITtoZ7Ajg9VZvyjvPSovdE+goZQqIKzFods5eYzMGHQ
         A3PX18aT3fXjneSd5fQiGxYNd9nKRql3tWan/fEoRFX7F3jrss/54SgEyLErIxJeXFew
         cXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112466; x=1757717266;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1mAO5A1gn91KXDnH98r+B5g3x8oPbaMvEMjp5ywFmI=;
        b=P/cyCPyo+zAxmVGKZRZzkHtYB0MKzxPA8wn3By2bEMjlplv4ROrgpD0rkqYMjW0XZP
         NjSPf4+j92VuqVlUScvFLKh7nw+2XOyNEpo5HBxnpb3HqiA1ldI1fzSuaD8jfy4XsrjR
         7oWQK16OOlTyORcfy/Bny6sJRxbfmImkiYmCDS8f83h1w5rav6hK7+OR90cFJZ/FDQkz
         JgHgbdfPXVfdEJxMsHwFhMTGiZ9jNTGnUJQUKnXSa4o8Q5jDB0yvRdQ/UURp3WHlCsLj
         WsLZ3vovtEOVN4r31XkjwNgW3pfkCPhSqknEC8uctaOEiUwP+M4fEZ5vlVLVXnOihM51
         svgw==
X-Forwarded-Encrypted: i=1; AJvYcCX38MngW/+X4L55YnV+tflqYky4d6pkrfm/tHIytywKd/I2Y8m8P7awvaadu5u6VTp+WIyD3/wRGZEt4w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4f+Lxt+i1YvJQSuMmC4/7NkxU8uWavxKwv0cfXEFbnlHoSh67
	nHg0VcmheTV9mdz9INsyUgvO4ljpXvdyp2Nmktt1cwOGRRogrddCQkaXFGhrX9qNePZsn1n+/i8
	PKxo98FbzAA==
X-Google-Smtp-Source: AGHT+IGP5tyQbAz6/a9kr27M1VLSua7UJmD76sbYZ8gqjEgBJ+ixv5i48QkWZvjdLFaVw5r9391d9KQRui1V
X-Received: from plbcp6.prod.google.com ([2002:a17:902:e786:b0:24c:8f0c:bd97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f706:b0:24c:7bf0:6e6b
 with SMTP id d9443c01a7336-251751ea241mr3179395ad.53.1757112466196; Fri, 05
 Sep 2025 15:47:46 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:47:06 -0700
In-Reply-To: <20250905224708.2469021-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905224708.2469021-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905224708.2469021-3-irogers@google.com>
Subject: [PATCH v1 2/4] tools bitmap: Add missing asm-generic/bitsperlong.h include
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

small_const_nbits is defined in asm-generic/bitsperlong.h which
bitmap.h uses but doesn't include causing build failures in some build
systems. Add the missing #include.

Note the bitmap.h in tools has diverged from that of the kernel, so no
changes are made there.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/bitmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index d4d300040d01..0d992245c600 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_BITMAP_H
 
 #include <string.h>
+#include <asm-generic/bitsperlong.h>
 #include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/find.h>
-- 
2.51.0.355.g5224444f11-goog


