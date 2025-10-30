Return-Path: <linux-kernel+bounces-877355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBE1C1DEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8181891A04
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDE51D90DD;
	Thu, 30 Oct 2025 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKzyhqTT"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27723A1C9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784395; cv=none; b=lHL726KH8n0uAHZIzxNXD6vhnodXrGUhRfKPoQ71HiILmhwiaVkowPf4tZfyqB2ykibajSRzfi9TzTRJ8lHGisr94f6FgYQosOTot7Pqxmx1mwcWSdPQeCYK4wZ7n6LiyKwz9iwJ8ev7RvvPyDlsTLIjC3i/r2nQ8CEqLh/mFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784395; c=relaxed/simple;
	bh=F+1dmMPKU1EhsOPIiAUwiJ0ziaxA3hjqAkVzPYv5gKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ugl1dBEGHdNoSv58i5D48wXlPbzACRWuvgE89xEiUYHu0kltm0p25omMiixL7Ie+ydkgxYX5jPZF8SMwGC7KXEilVMPUE13HZn8TXjyLo4qJNQ1AWaOY2y6ZWJPTQgl0q0hIjfltr34rtyvqw9fd1fUeluxpij0Yno4GCJrtilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKzyhqTT; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7a28226dd13so472332b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761784391; x=1762389191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1C+kpg11Lr3Fa6qP5rxUJKauqkyrQ3fXbk25+xhKPiA=;
        b=iKzyhqTTfmOyTeWojxYYoHCbIGmvepULvS9sD71jJOZ5x+yuZH3+fE6SRRw3X8GGSy
         6PeWOgyXzMUy90T6JLBlM+PmH/noy9zombwfOhWjC449G00GOCnD149/pvnKM6UgA83a
         P4Aqv3iUPb+Y9BWezfQGSLu5KlkdF41isaJSCpUuLEpIHxo+HbkwKIfJ451SUYXhx+mb
         vP88nfT+UjPToQU2U9LXU/Lhe1VD+kLQiykSBdW7H1JA7qUemK1KsVqWyL79bfhTVtf1
         69SoYXVMdDVLUuX/wTTDDRVyIQyYsweSqz3kAEFm7CLXIl7aH16shUPIae/TrgFUZYRv
         2sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784391; x=1762389191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1C+kpg11Lr3Fa6qP5rxUJKauqkyrQ3fXbk25+xhKPiA=;
        b=V+A7OyiH+Jl5g1vo7Vps44iRW2Q8oeptqIJCt0/ghTsPMdK7OoGZ+OFY+TldOC6HI0
         elYJfDkAitqgK5tmcgJD/rkE6niaQirB/SBTxg7PABFs9WL5JB+oyeNNi0EymeA1s7WV
         mrLOfwLxJXqeyIR3nHNbWFmeIjrdnPuQlJCsmBFBVayjabe6viOkdyVqR5mx0zcpEp2b
         soqjavJ47u/Db5ywEJqFMgQ9G0S9rcKfBkOpJW8JqyJ7ZhGSzeF8WU4BGvUSsYrga0v9
         pJILTp6eA9C1ZewkSVYluSDPMAB4x73kZYQp3PLQ3q1EiXg/NVt3LwYmPHdihYbx8vNp
         srLg==
X-Gm-Message-State: AOJu0YzqvqGrDyNWhidOJhfMbF4m+3FwxUOfsZEv4o3iFqfag9tQYwnr
	LZQNUMN1k4LLb68zlLQ96g4Lcdy2Y/7cVPm43UmSXi5F85Q83ux77pUsedXjSKeS
X-Gm-Gg: ASbGncsQzv2fjQNt7p3K6y8wnECinhwwc43HOdwzGPoMc5WhQZZDglY5Ae0YAzk6vf0
	iny8YxB3oYqH26JAmeghAXMq7unOxHtVhMM9GOIopBTCKy7CCfl1LpvMoDC/9cL6lm6xFnCjm7O
	hPOAK7EMvTJ7hiNheYo2fesWhYCFquJSKUT1hKsBWhNumLH8Iwk9lE5EaGGabQ39bMOv8l3Hv3E
	7LzbdoEXtkGgWDPZpJi6+Cxk4P7vxsr7OEaL7B19w7fego/cQOaIWgcfPxOY11VHJIxdHYeUkOY
	mucZUvkunTfJQyHXdP06+35nKYCliINFRsHFBBXW1cbzxxV4DVIbi9NPLpSsAPUELq9WpusHZqS
	qvT9xvbuF3B53GZmQj8AqapMfl+FbaUy8rvyjQ/psD87NNXDj1VsEI5n68S2qDGmIQ6qqdrvKYx
	1z1zcgqmt5RempmV7iRQ==
X-Google-Smtp-Source: AGHT+IEhCsgLDZ33oU7eKu5WmrCrdlI4CH0spBUGDjecXX03bKx9ED6BN00mwBebude5G/b3JmN9RQ==
X-Received: by 2002:a05:6a20:2586:b0:341:6844:bd9d with SMTP id adf61e73a8af0-34785230af3mr1789958637.13.1761784390679;
        Wed, 29 Oct 2025 17:33:10 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712d3fc7b0sm15419683a12.29.2025.10.29.17.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:33:10 -0700 (PDT)
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
Subject: [PATCH] libbpf: Update the comment to remove the reference to the deprecated interface bpf_program__load().
Date: Thu, 30 Oct 2025 08:32:35 +0800
Message-Id: <20251030003235.1131213-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit be2f2d1680df(Deprecate bpf_program__load() API) marked
bpf_program__load() as deprecated starting with libbpf v0.6. And later
in commit 146bf811f5ac(remove most other deprecated high-level APIs)
actually removed the bpf_program__load() implementation and related old
high-level APIs.

This patch update the comment in bpf_program__set_attach_target() to
remove the reference to the deprecated interface bpf_program__load().

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fbe74686c97d..27a07782bd72 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13858,8 +13858,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 		return libbpf_err(-EINVAL);
 
 	if (attach_prog_fd && !attach_func_name) {
-		/* remember attach_prog_fd and let bpf_program__load() find
-		 * BTF ID during the program load
+		/* Store attach_prog_fd. The BTF ID will be resolved later during
+		 * the normal object/program load phase.
 		 */
 		prog->attach_prog_fd = attach_prog_fd;
 		return 0;
-- 
2.34.1


