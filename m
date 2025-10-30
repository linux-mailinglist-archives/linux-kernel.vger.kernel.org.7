Return-Path: <linux-kernel+bounces-877584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5092C1E7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A23B2B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C92D4B57;
	Thu, 30 Oct 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0Vljlh0"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40B2405E7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804213; cv=none; b=jkzrK0EqTZJP1dR+ZbT1gu+LSuUloGeY48ye63in9oKw9GeOhs5Ug0oY8DTiJmQnUwXEsMjzfqvbfQ9gzxzIoC2Sb/Bu+hskIEQmJ+K3dBjjuK4bAODEK7VKa5v5B58AbmwivydkeqPc43pISo7pcm+ftt4+ehjiTrnmN27vFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804213; c=relaxed/simple;
	bh=uY8PBstVl8AOna1CjFYpDGnZdWH4OsqJouBCNU5dVx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6KiMqdWsJNY0dD2WA1buBg0XgkzfLPSrUod5g9iD2vilQ2lVNhAnrGsOk9/UPoc2WzzvADbUfKP5W2PEg7DOFUV27PoPQymX4aT0QQq8KlGnOQ+beV4t9DFoL0jOcQp7hhlPPlJy7PSS/roE37rC7sf96NoZGP2C2wUBu4fW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0Vljlh0; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-292fd52d527so6250385ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761804211; x=1762409011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hWunyfOPqPyrT/9j+N72PTU1meMr+xcuMvbrFqo+DIU=;
        b=Z0Vljlh0v/Gc6wrPj1WMfOjr6r6vo5yXdHx/sznzWE75qnYeY4KqA7cdtX9R+yQwIQ
         Vnzu5CbS3ypXv9IobYs8IIzsPSglI1hATfI53v4Eh37YvbJLwscELHa/oBIqOJ0n3qX7
         qmmWQebHXaFAka+UVaz77AhmGjoKdhn01sXvIYc8+Kw3Mzr85IQaUZGgWqG12Hz0dV1M
         K9tnkD2kyUfymzY91uokdudtF7FAPYDKjQPzuTJDzKREABKOCKU57J27NA1l4fP4vYn3
         qtuBuL+X5InOawrgGTtbTLpso9BTnsjzOzL6s62VM3adGy7+cHGG7s4/t9SkpkTxlJwR
         PiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804211; x=1762409011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWunyfOPqPyrT/9j+N72PTU1meMr+xcuMvbrFqo+DIU=;
        b=c2+EE4XYpa25sZ3Y1yyOiFPupXNwV6qzNC2ba4xB4YvsALCTe/h9uBWnNSwwr0SXSY
         Th2sYJ/29zAjCcuwG6g8pUrW1ShNMEUqYteb+zqeuknV2my1uRDU4WPVmDMeH+e1lSHU
         mC4B1alMs8uA3N0x8b/MDXRjUiQFByrknxlAA0F8/bTZNoU0PA9FhqPZfyylWs4A21BQ
         nHtXWBK3cIYxYhNvixIjwUrjipm5VZs9r7Rou41BkrDSEfCmI4mG8H4V/sxJ32/l6fTW
         UyzTDdbjY+ndS5EIIKeTtkJkJSwebQEiNMYHfrYM3Kcd2QGqYnof/QI0b9cExPJnl1lr
         eFQw==
X-Gm-Message-State: AOJu0Yxw7FiIH2STLTshWk1CeYbtfnWAKKSbOiOnvnIMuvUcl8C76PaQ
	ZODTywW4kQk2hEVtEwpmCKmYgv8gKTKX9qsK+31E1UchFljlhchWqOSxYga2Bye0
X-Gm-Gg: ASbGncucGUAmubQ5qQoKUf8dIrD05cQ3ypL2DRb1C4SW5jhFYFoIwapitfG7JTJx0+4
	NmqcZE7KOTMJQ7fG+JYd7XzNwVMSnu0HcKeDm0wAdYlyZ8Zvoa0wGjJEFQi9TdKGiQEJ8I63HTc
	J8v24pI0TIw2RYwDyfBTKUfzM+4oDme9hlCQeLJjOzIZeFG/f8/w7w4kD00pQvf2xWDSyzEctIJ
	+soq8r+dGTIJN4qcEtrZj+9hpugAMIlhUDU/IC6ICvcTt2xada8haURiTW9twriQnO7+5zjQayD
	pLY5kxOyfaKUxfxsiU9sMqf7N9dWRamJzNSMbFPp2IHXSGEbmKJtFeJVhCkFzL/V7s4APhYDbw9
	XRmKapqAKpg9yQU8OEAMTT5V3kubMfFGUx4GxQ6jKzJHRbhS3dHM11/X/xzDXtAo56ceEU1hFCo
	cJdDBBs/dHFVOivraS5Q==
X-Google-Smtp-Source: AGHT+IFaNi8UKPhzHGI61mtzigpk9LsnKA69RlwPmz6ucy7Dt0QzqkSl5dPcEVVwYWUQEnfME/lUQg==
X-Received: by 2002:a17:903:ad0:b0:269:96db:939 with SMTP id d9443c01a7336-294def33bffmr69639195ad.58.1761804211514;
        Wed, 29 Oct 2025 23:03:31 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42ea7sm171456825ad.101.2025.10.29.23.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:03:30 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools))
Subject: [PATCH v3] libbpf: update the comment to remove the reference to the deprecated interface bpf_program__load().
Date: Thu, 30 Oct 2025 14:03:22 +0800
Message-Id: <20251030060322.1192839-1-jianyungao89@gmail.com>
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
v2->v3:
Try to fix the CI FAILURE issue by rebasing the local code to the latest
version. The v2 version is here:

https://lore.kernel.org/lkml/20251030041457.1172744-1-jianyungao89@gmail.com/

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


