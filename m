Return-Path: <linux-kernel+bounces-868135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AD7C04713
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B1F44EB825
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC116246BD8;
	Fri, 24 Oct 2025 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNaH2Myk"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187C239E8B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286083; cv=none; b=CABTCFwQ8e2Y9Hv6XZphETTX7spsYEgyfSMepnZzHFFS/0h75TggkngdnTrAkGvwe/ZP1IObcbS1yR22SCEb/tCrjb1QFSKFLYLuY+m/sXtqCj+is5CvL3WEZFC4fSDth6wUwODQODuAVUFEnrlmsr5osKYyQG1ztjUeXLdP/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286083; c=relaxed/simple;
	bh=etiiWQcSY+zWyfyvDJEnJIqalx73o0ier60DTEh3nzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CQ6rEDjqL58phy3cToteltXevNNbJOXysXuosfnCOtPVo+75f07/Qt2dHt40cDkiBrfsl4nO7r4ouZYQKdSV6FCBlY441zTUsrgkeZix3M7XNdzYAEQDCuxgvtenF7ZOHUlxlBwAtiSPMf8cp3IvclQi+aP/vDbhX+RGAeUZazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNaH2Myk; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-290d14e5c9aso21774445ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761286081; x=1761890881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vk5tKMojX80fyzbsDK9Px3vsmzEypSeIpUP4WMWG8aQ=;
        b=DNaH2MykdOVfApIxzwdFsAUpRIROy2UgxCTX8giw6QFFJHMWF+DsJl2ZbpfT+mAAKN
         rnrAV4KCg25B2U9LdqSAvMlz+JF9TU/mnyK2QsTn8AiMF9p8VoOZDy2SNqNGaDvvKgYp
         i7xU4kAUT2nTWLE0fbk3za6t/tX133dj/rajOK4Vs1L0OYlCmntcgCqjxBBFBoiF3LI1
         dHgNwR6JgXxHSTBCtpP5iu3dEy8bzhKUw7cWgnu3srFTkx0kaQoMh+KwpqYXHw+B997h
         MF9yobOI49xQWrJ62a0GevjF1kgK+iu2+pjp5S+upwQA7nUbEJ483WTmYUpqHgjSq5A8
         y0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761286081; x=1761890881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk5tKMojX80fyzbsDK9Px3vsmzEypSeIpUP4WMWG8aQ=;
        b=QX/ZeDVysyZpl+tbvuM8sd1J/w7fT0hgr9EqChyc4KB/itHAwEblUORFs1dFdWGnFY
         mBZju9ZDxnos+EZjYWVznoQmfN3bisIPI6SwndKgF2PCQquvWHJXJk5fcMKHMUZptiGe
         +pz1GMXyVQOgjQdvoZ7TZ92jD5Z2LwBVA8KedGXenquYyKsKiImGiwApNPRqvuBKF7tA
         DdJqGHs/Aqo7SEU05GZVlIzqK3u3XvyRNAoNBBWiOotwLFb7xBzwney/vOSrg+lXYw9G
         OgUsxokx2k4nsiWA9pEI6JaiD87FbRNwepcZuThCIXfa2wrV3FBD//6IaCfofUudN26A
         GAyQ==
X-Gm-Message-State: AOJu0YwKNW/XA/LLNyzamoESpDBjvK2p8ow96frNU7kVpyvQGHlLLOxV
	yHp6w4Aghn8XQztwa03pbZOeuOHQt9rDIXTcrCmWHagwF1LqABCn+AvRDLrlSMIw
X-Gm-Gg: ASbGncvQbUX+IVhm2pQ1JnmPDOEvJGyWacpSchhcd9yYSjmCHEm+J2MKgm2CY3xgH9w
	emiA1whRtpJk+VgusqtZ49jDG48W9kaA5zrJE4WWP1eXAeQb2i03P3aFa3w8cjaexA9EFKlAAZi
	ZuIXnAl9GOzWc9EHsB2UI814ICh1JcFnwHW+ycwdwTGsYcMLr+RmP6Aru96EAwOSdv3mxnrEkKE
	StZKYe6+GdC7mQpHLGK17Y/4buzT6C4ZNmX2Yt3rYt9tJPhTu7/2xOW+aOr36mJz0ttx6lImLze
	vq69rdqd8VA3MGAi45vEfl3s63IbbM5QVJilOCjSVeJUrDuY+4kIQHjwbx/QL7HReKFtl++lOHH
	rkMmnIo7/zIXyjvh8oX3Yu8gWO0nquS3TSA44aC5qG7/DI50LMW/S19UQPJrd7CnAdPNBZ7ptMr
	0JN1qioPYO/1h9QslS2g==
X-Google-Smtp-Source: AGHT+IElmlafeEeVB2WMsQSk+MOjUdVM74P9RdyjOAxP+L5479WaOzgegwsZ3NGbdtJsAl1i/ejKrw==
X-Received: by 2002:a17:902:f610:b0:272:2bf1:6a21 with SMTP id d9443c01a7336-290c9ca72aamr370603485ad.14.1761286080969;
        Thu, 23 Oct 2025 23:08:00 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e25bad1sm43308915ad.105.2025.10.23.23.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:08:00 -0700 (PDT)
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
Subject: [PATCH] libbpf: optimize the redundant code in the bpf_object__init_user_btf_maps() function.
Date: Fri, 24 Oct 2025 14:07:20 +0800
Message-Id: <20251024060720.634826-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the elf_sec_data() function, the input parameter 'scn' will be
evaluated. If it is NULL, then it will directly return NULL. Therefore,
the return value of the elf_sec_data() function already takes into
account the case where the input parameter scn is NULL. Therefore,
subsequently, the code only needs to check whether the return value of
the elf_sec_data() function is NULL.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b90574f39d1c..9e66104a61eb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2988,15 +2988,15 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 	int nr_types, i, vlen, err;
 	const struct btf_type *t;
 	const char *name;
-	Elf_Data *data;
+	Elf_Data *scn_data;
 	Elf_Scn *scn;
 
 	if (obj->efile.btf_maps_shndx < 0)
 		return 0;
 
 	scn = elf_sec_by_idx(obj, obj->efile.btf_maps_shndx);
-	data = elf_sec_data(obj, scn);
-	if (!scn || !data) {
+	scn_data = elf_sec_data(obj, scn);
+	if (!scn_data) {
 		pr_warn("elf: failed to get %s map definitions for %s\n",
 			MAPS_ELF_SEC, obj->path);
 		return -EINVAL;
-- 
2.34.1


