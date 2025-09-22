Return-Path: <linux-kernel+bounces-826981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92E2B8FCD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F8D3A6F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC657288C34;
	Mon, 22 Sep 2025 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YvUCEHa8"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB1D27EC80
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534114; cv=none; b=dnTLtAhFDloKiZ1xcbnqtF6s5NpIyjjBniXAF+2+zwppNh8Fy69kXbC5asyho5B6pnd/zHaBqohhKmnZ+pNo55BtCQxZllTov+H3rMey6F4gjiE361jW/Rk9UA52OnEBRVnUISxT7KIkffBq3Pvn9kRNoaNgJzhkDpH+JTz+WZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534114; c=relaxed/simple;
	bh=12T+kg1WEnlpjNWioyO2nSnxhTXlq9cORsKc6oSrE8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N0ObxESejDihsdIc8DxXE8haAoQtKcFN5gB3UXXgvo1mzGoPldMUSF4EA8UFtWKw2MgG6tcm6dh9W8Lb56buaIa9CwjCGFGJvk9fkqCNABZ+UI6cvOsDvUG1LmR6UTLxsjHGXSe4j9WnHuKosy2rPNN9o5um5jma5sdTbxWAOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YvUCEHa8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f454c57dbso261906b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758534112; x=1759138912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb1Ubbq8FQD3k+io1Te5PTmdOjRv6gyQY3TYHgxdom4=;
        b=YvUCEHa8HybVy9FglsCF0UZ6GrgLFKvLE24WKb6fQEeorKyHS/+Lamn7BJFWykgb1y
         70OLy2MACIV7QyI2l/3R/pvgpAJ6b5T1AXFYIPl3Usg/Re8m9lmtvQcBcX5E353Cr7pk
         bvsFSQRZ/wI7jBCmus07/BN0IuJzSb5EJ2vpwhTCGFYzsHT+b77xevFM7dOY1vQmJc/O
         Bj40Dtt2XwyybQoX9CSNI4MdRrvu7DlRNf9HFhGwPTglhaYrzajW0FqAmLXmmgxC8S3U
         HvQJcrb1bHcWd22DlsFy9ErqTrqhECM+zv8qMq2owfkE+1LT1Bm6rgn9qvUe2mLy2FZC
         ECKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534112; x=1759138912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb1Ubbq8FQD3k+io1Te5PTmdOjRv6gyQY3TYHgxdom4=;
        b=bJhwV9AVEgDUgJjwl3e8mMNKjVNQu2VucPqrHjMlrqQ/vyaCGRL/I/3X6YADkdTUTh
         ePfsndKMqn2KIPy95P/3pPcUjvUzUfDZG4fPWz9JTi/nU8LnrQ43fDj+gCfQSQDPnijP
         hKaoYWoic8ZpkbOjfkqW81QXhdoYrGun1upFdNeIEpePKELNCw3OOwBA+ZDpsYkvaUfH
         VkIByDjBpNmHCFicZ75mQ5UJ3F3mqRRw3bfI/LU2Zf1C9zHTCCU1Jk2L0DugT5MtWR/j
         /YAUzJJ2iuBVI5xzsuSTRRbkNHsUrwPCgZJxpQRLEA3wcWmWs2sCLRYouy9CtHGJOX7o
         HJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp4ZzJl5maz6/t1226CYu4QHsAVv6z+j3rsJEHLh6JGfeRyyG1Jf9IftGTNgevqZrD1Uh61qgkuBNh2xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cwK07S9AGoofakv2jwYWOtOspA5Cs1Mo0TLu5ILZx/lm3/fb
	LxSkpFs5MS4czHSdId05ECX1sTLtlaS8MowqPHJGM+v3C91gxMuFp2kuLZkQJ8hKnKVHrLaJ19Z
	NWrHqSB8=
X-Gm-Gg: ASbGnctegke5HTV+C8euvQQh0/xNGHrP9oIFNVgZm+cq5n8IxkWWpHwwOnqFKxlcsai
	qsWoc4/E8cM2Gw3P0MJZ3Cxu/aPVKx2/LZXsiBiW5J7HhXC9syVySzGINFbmMx/I7wNpi0Qsz4Z
	8W5llhKQ3jBy1AU8EVGyZONwBor3XbMsKt0JmYoOrzBR5Kxp6XlmH/fote9ffYArVTSU7fFlP+M
	xe+J5GnJfQrFKg9c2PwBwqErvV68+1Hqfp9krvwr0tN86bIOF+qLmLW/mW6jcWotdAW8a/TeMei
	dMktJWHhT2fPRcrtwhn/H4YFJIWOY1j1uHd0iG10sUTba90smbjpPrsmDvFZgN9hSLFfHDx8G/q
	b8WRI5HitjjVPLZIUxOezWZMrkoPzGXO5wK4ybA==
X-Google-Smtp-Source: AGHT+IEtLgg4zeHMXHyciHj/+jOxGNRUrmic9Rw4+/nHq421LNnyymvdUyXFF6AF8uBt8EQUhHOCSA==
X-Received: by 2002:a05:6a20:728e:b0:262:e568:b92b with SMTP id adf61e73a8af0-2926f79d12amr19017914637.31.1758534111814;
        Mon, 22 Sep 2025 02:41:51 -0700 (PDT)
Received: from localhost ([106.38.226.108])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b552882b177sm7455391a12.11.2025.09.22.02.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:41:51 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	agruenba@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: [PATCH 0/3] Suppress undesirable hung task warnings.
Date: Mon, 22 Sep 2025 17:41:43 +0800
Message-Id: <20250922094146.708272-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Andrew Morton in [1], we need a general mechanism 
that allows the hung task detector to ignore unnecessary hung 
tasks. This patch set implements this functionality.

Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will 
ignores all tasks that have the PF_DONT_HUNG flag set.

Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_hung(), 
which enable the hung task detector to ignore hung tasks caused by these
wait events.

Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg 
teardown to eliminate the hung task warning.

Julian Sun (3):
  sched: Introduce a new flag PF_DONT_HUNG.
  writeback: Introduce wb_wait_for_completion_no_hung().
  memcg: Don't trigger hung task when memcg is releasing.

 fs/fs-writeback.c           | 15 +++++++++++++++
 include/linux/backing-dev.h |  1 +
 include/linux/sched.h       | 12 +++++++++++-
 include/linux/wait.h        | 15 +++++++++++++++
 kernel/hung_task.c          |  6 ++++++
 mm/memcontrol.c             |  2 +-
 6 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.39.5


