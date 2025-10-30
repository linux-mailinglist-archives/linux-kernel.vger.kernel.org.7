Return-Path: <linux-kernel+bounces-877514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909CEC1E563
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E4F403494
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06732D63FF;
	Thu, 30 Oct 2025 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOBS1ihg"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C6237163
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797711; cv=none; b=F4jsGCqgrpRCIxfc0nxvlFHfzKv4EL0p5SKTru2CqnTxtUY7b1Dr+Cge+LsYj11PRfLfxe7L7dWhzNpSdBhMl7dv9kVbBgu1UCDXVwX08szm5cy/8lzi7tbw2khvwLL9MSefAN62unJL01lVJVUaBCryE4YfosW+KR8S00CCK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797711; c=relaxed/simple;
	bh=aBRTdJV/Cutznnm5Vnl/Wt1QdN+f9b7CRXwerleKGHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CiMJvMPZXMhpCywiFfnPrtslKfJsekyxynPhV5vC8DBG5KYppwCgB2UjWbKeF821A4JF3XFVCqLjflUXN1oye/WFS1vg4VcZe7LaZXUYTjxiGHUd4lPE5zGY/docS1HMnifFv28DTwJHw0Mpgql8r9scSvGjsdpeGGWs/59IWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOBS1ihg; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34029a194bcso721738a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761797707; x=1762402507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WywPhK8rX8KYdEGPRDNQCxYargrpyo9AoIMZ6I9iyXM=;
        b=bOBS1ihg2Tu7rDWPWoGhSTxcJNY0kPySOZ+K6VlWGDDGMCmnzAGQH4WDoIQN0JX8Gb
         UJ6XNLtm7AwN+AHLsNUnELXut9bJRj3ate6gRsN4d3gJumz8efR0icQv7MHCIg65oSks
         CfnB13Sd/26+JG8JtC7i7Um+nLuoYv0FB/54Fmrnq9Px3op6wZAf7akty+rx+pzG8PJi
         G/kn55n5pUhD2c2+mDvjGY+i1obx7scbYZpGK0EkLEfi91rrKk68S9/NtmSSMvGonHbR
         CROWF+/ToyJ507VcjQFijqAA94OlFx1FmBJf1waY07HAX3SB2Cs1Js/2Ci0fsFyqpsvY
         E6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761797707; x=1762402507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WywPhK8rX8KYdEGPRDNQCxYargrpyo9AoIMZ6I9iyXM=;
        b=YdxWYBLFaRdK4ykqJr4wsDh46ESgs46vacQt9WjkKP+DoYBADEdHE1HFXEUVVjWhoC
         lEw7pmmjgzDQHg1K5IxN0UCmi0zDs1Z0deR16Qy6nAh0TQSloVf6KSu7S3ZGm+W93o2p
         ygimJqnI5GVZLAMagtFX3pCkTvaDKtPVEAnDW5C3hGBwAy7O/TfODF4cH+rEix2IMhPi
         p7AddgYGMGU4yTN/57dK9Z8bYXsURebXX1AEoR6HKgdtemXcMwBsuC9PiDpg1FWFt58T
         rfAEjFXtVJe3wbGyXSw3GDedjAF1x6Nyy3et/9AekQjeM7WK3CHREeEYBjdGoEoRsB4i
         p2lQ==
X-Gm-Message-State: AOJu0YxGBXOCTR7ynrmfHIs1u7IHhPI/RjINFrBnffQQEhngtD1iPgxB
	E7LyqnOffpi8tihiNKkQRhWSHWFib5L7P7qxaXrshN+GofRepLRqdzYlMDUmDYzE
X-Gm-Gg: ASbGncvxF0+qnMDUP7GOtmWmFyAoZQRdn0Dzr67Ke90mCBji0QbXylH9zlQgh+mjJ9g
	AXe0bXWX3Af3w0eYqTd+trxhKzxQFqKmSKP2ssZVoa5QU44NUJuktrx7I+zZIE//ZDKUUGAq5Zq
	DkjLVPW2e0n30VsYQDENJzCy5WV56o0wsCILKCIzZH+ckITv9UfObDDUfWLejopuBUzBe2ADC3W
	AnEX0AnlzC/Ml4zlm5rUwf0fXBFW2TLn506A4ibe2+YWgE2kt2o6X9mY6WtOw0Qo0ZiIgJDL8Ev
	SKJNmOhYNtc4Zjv6ADVEPPKT+5w3YBGDiEAAhBDjVkH7K86ULkuxl7jpiu+cGlhoEHKSb9ZqFlC
	0mlr9I+wImQirVRQDt2EiaMFHDRR2ddSdsGRVa1F8PCu+pYFmzI13qTr6xstmbiJ+CQ26UDaQo6
	jwJ6T67ubUxmE0wGU+nA==
X-Google-Smtp-Source: AGHT+IHmVRX2SSN8xFtoHIWs97eLO18pwBpAmDhLc/ti/WeUODi1bpmpP+p4Z1+qnjhH3BvJpXhGUA==
X-Received: by 2002:a17:90b:570f:b0:33b:c853:2d95 with SMTP id 98e67ed59e1d1-3403a2fe505mr6536937a91.33.1761797707315;
        Wed, 29 Oct 2025 21:15:07 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050992f92sm877375a91.6.2025.10.29.21.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:15:06 -0700 (PDT)
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
Subject: [PATCH v2] libbpf: update the comment to remove the reference to the deprecated interface bpf_program__load().
Date: Thu, 30 Oct 2025 12:14:57 +0800
Message-Id: <20251030041457.1172744-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit be2f2d1680df ("libbpf: Deprecate bpf_program__load() API") marked
bpf_program__load() as deprecated starting with libbpf v0.6. And later
in commit 146bf811f5ac ("libbpf: remove most other deprecated high-level
APIs") actually removed the bpf_program__load() implementation and
related old high-level APIs.

This patch update the comment in bpf_program__set_attach_target() to
remove the reference to the deprecated interface bpf_program__load().

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v1->v2:
Modify the commit message in v1.
The v1 version is here:

https://lore.kernel.org/lkml/20251030003235.1131213-1-jianyungao89@gmail.com/

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


