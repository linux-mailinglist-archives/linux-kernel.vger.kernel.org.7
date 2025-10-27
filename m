Return-Path: <linux-kernel+bounces-870806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19418C0BBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D75189E66C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2C3F9C1;
	Mon, 27 Oct 2025 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yom07kO5"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC42C0296
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535220; cv=none; b=MBD+s3+DGX+z/eqVbltfPZkIbT8Z9AwbQ+YD6cPkmArdMNligHejwzIUo66dPWL2CBowpUP4OS4gCHE0FYohqVwbxBsvsPMCBvQaDPD2eeQt8vsLB6vQooISl8eVimBJjzM406gK5PEA4JYdD8wZkzmqabG/zmC8b/yMhUFMAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535220; c=relaxed/simple;
	bh=AuU11ztRLK+I5zI4UsmWzBs/U3j0i/HFOVRM2mlnTZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tGsdwXo3NoqixTFbKrlvxyeuhgnDY1YmxvxoXXQUZ7gnabC9TLlOW5EKBtvi9C2QaJgtUZE9sMqYQMWnEIDWEpHpOoibRMMJ0D2OYYZp1v7hL3ucOkGDxPXAgP6P+lIXaYml83CU1lI7iNrqSVfYM6pwlGOqQoYFIKyfaTHjNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yom07kO5; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b6cf25c9ad5so3210206a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761535218; x=1762140018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12OL70/9rabscg9vqPO/maQtcokUUc3ZtNtaJUA8Pmw=;
        b=Yom07kO5iWL51I3wkaPeA/kki5/G2zuxK8EBI3F273AcptEZ8CevluMrqlIq80A1K0
         YqhNXhkkidXRj8E8XU9nSBS3ZCztAiMcR3eTII9wJObjUIqvu3Sj8uSyxJr6e11qhebj
         wAPieB5C5GappQpzTuTPFeFz4VifG2RIu0chS9FhPrECpM2SCib2Mq4MidXtQJKbkwoK
         Q3/Dl/DJSz067JVSkOpVsM3nUiL/oWsMjYWFHYHg2IrLMcwt9ToBgELCh5G0Uh7/Rb3t
         jCKJGTKlic67izH6QZ+EuP9s/h6RzeDxZxSctrwP4zD/vGdVxUg0X+gQQKRnN/NfH3Q5
         y8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761535218; x=1762140018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12OL70/9rabscg9vqPO/maQtcokUUc3ZtNtaJUA8Pmw=;
        b=LwtFoaDtwArLSSkGlatQasakxOC0JmZQYNAtJuwpKzdrTS/+Zvx0QI0ZFIwA5qDpXC
         ru9cEzhO8y2XdpJvpF8u/yw+vsHdJcrn0hfXdrJItqrR5jjFG6NKhc5oyd2kF4SY6Zy7
         at5RoyHI6C4ivqM6eR1Zxa1G27Euf6pZImpKAiO1V+Qir+A2Ftc1fYWqsfH1mUN0V638
         EgR6WY+LFES6fBYltZ+GRRe4zeufQtFX9yiFZ7QpcmApHOSRoCPBhqp1A7uOQlowTzX7
         Ul74wKlqKZMe/C9ye7orQ17hV+HG2nhz+gGWi+/ABgGFZQiK5plEzrtVQj4qEFj6AErh
         CdVg==
X-Gm-Message-State: AOJu0YwtTwFn82xEBhoPv+Zgp6M+wTMCGGf+hUwsjDhDyX7kAststXGv
	EjjpRcvz2LpWovm7lS5ASVzc+01rKCUZb+iSFOZge+e5CUQIBgx55jRwMHWXzXYt
X-Gm-Gg: ASbGncsqpdeU0MTrREKMApoCGxS0SKb0b7PzHh5mJj/wsUyQSi/hMI+axq2uB4+Ro2H
	XwI6Vdj7RE1+dFK2PN7V0TFNluB3u+MANzfLPG+mUK+8b5JG1HzNzjm2f7om7BTuqZBatykMeWx
	j+WNJjmZ2LXTRxpkKQiqZyW731IY18hOu0iTFAyOzBACZ+d0fa1t8/fwl7wP8vjz2DXPMh4jjfL
	75T9zZIby4oU9zyBzi4xL1Q8PFXyN21MNn0tPc/JTtER/pyfqK6Jw4exanwRgEmw03i9ajvXeiX
	yvIKGCqYbSu/+0rqOJEzcRBVc6C1/cNv7PcQs5Gi82oADi2FIzYgLrZ+p2DPHF+/5Adbr4sP1vN
	5krFJmN1GaG8OkUHUlnKYo728ACQDXUptjCnyUKbvHvmQdBo4iz0H3w4doNL22PCeZ1/HKgwUZi
	PTvmxyy1SKTXAWIXRvm/9Pavr+LtS1
X-Google-Smtp-Source: AGHT+IHuLOPOeurzXjn4p7N7tty4UzvfTmJ8rBSm68O+2HbFxuRVi7P8jHfgVtGar/wcCIOxQ2aXrw==
X-Received: by 2002:a17:902:d50a:b0:27d:339c:4b0 with SMTP id d9443c01a7336-290cba4efb1mr468009825ad.35.1761535217715;
        Sun, 26 Oct 2025 20:20:17 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed3e8530sm3454102a91.0.2025.10.26.20.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 20:20:17 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH] libbpf: fix the incorrect reference to the memlock_rlim variable in the comment.
Date: Mon, 27 Oct 2025 11:20:08 +0800
Message-Id: <20251027032008.738944-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable "memlock_rlim_max" referenced in the comment does not exist.
I think that the author probably meant the variable "memlock_rlim". So,
correct it.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 tools/lib/bpf/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..b66f5fbfbbb2 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -154,7 +154,7 @@ int bump_rlimit_memlock(void)
 
 	memlock_bumped = true;
 
-	/* zero memlock_rlim_max disables auto-bumping RLIMIT_MEMLOCK */
+	/* zero memlock_rlim disables auto-bumping RLIMIT_MEMLOCK */
 	if (memlock_rlim == 0)
 		return 0;
 
-- 
2.34.1


