Return-Path: <linux-kernel+bounces-868341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43929C05053
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7775442092A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB74301498;
	Fri, 24 Oct 2025 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdNmI4qA"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50AA302154
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293301; cv=none; b=rSOeo8scEgGbvdA7qVa8FSOJxssegYDtubxN6iBCTyYO90SpTeDkyUWt5nynkcOt5V23wRMM6eJmbXxZytApZdGexE0bVPCjKe6u3MXeL1NRWzSm+8dJG9iQu1I3Hmz2pO2GpmbhLX11GM5VCewDgH3DsKRkw3pv2kTL950q144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293301; c=relaxed/simple;
	bh=7nsIjxJWbWE/evrRetoYMmRlti7SQG1A+Mfv2lnGeKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UPZ2yAra+nDh1olQMqRMmgSDty2yuW5G3bhTDHL2lb03awhJTgrf3jKUatykfBTYicRNbYkzLZjuQoeTkKKTSelgMY1AnFnkZryTof1Ncve0VEOMczW6rU6F2jbPTyJXdIHv+LnoMi6XE/syc+s5m9fHZz9pDP5q4MwKv84s2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdNmI4qA; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7833765433cso2321517b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761293299; x=1761898099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVhF+LS/VFIVfRVK60hqpDN69wUmvTRnXE3X6JFK5lg=;
        b=mdNmI4qAsw+nHRMgzOO5YQvprlxV7GXHT0VIbsCcZD2eiGx8NGoRMC4pPdqLOYIGuJ
         XXQpZyxJ0Wjuo8LWgihjjt+wktRdVKiKCWcE92OuJNmpkryudbA7YY9RiikUNySiYten
         VYRyzjzn/G4w5xF67ok4lW3e2b9KZY7ajnKOtb9fVf58mckC0n+G1bsV63SYjsMN2eWR
         z7NSHcLfHq9OrK27D7niirZCRzfmFTsz/Fy642XgRgmUCCXCjt0SdDaeHHZAVIkRyduB
         NwG/W1hdJqqo6OqmjsObkctyxB1hSGfKTSJ5E+kfqOc7w+38ZEFQszvC/nAaGwpBjwev
         Ba4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293299; x=1761898099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVhF+LS/VFIVfRVK60hqpDN69wUmvTRnXE3X6JFK5lg=;
        b=NT+QKg7QwwdxZc4WA21TxYQJGAccsx/xVeePX+NfuP4jJcwkOeUe8p2TTOWB+uQ7+1
         5rV+6zI8/cRdhpgWDpsTn9IZQNI/nvMSLyNwJ1CX0Ffqz6NSRL/vpq1WJvX6SySl16jC
         CfaD7CtDBCFMIJPC2z/Cr06h4oLzOPODbt/hHsk3S31ohHB6xoEfJEP5EuMykzaEFq6L
         cFVROtX5360KehkNt/scF1HZju45HAr/BslAl++tNe9H+ntFblwr0CjkwAYrxqq0wpye
         D1bitn+g4oTAgAQ0dhbfn0iEcBP5/TeNbF3T5/OoR3zHBFPxvJVOSXnVrQBZ8vOHBMKE
         WCSQ==
X-Gm-Message-State: AOJu0Yxqss+I3pKDW5hpa3/2v7FhxMFI1Bq7LLcJ+5loNn3xmy1xsHHT
	rYYnJ5K+uYqPPhyRD9PEidmWAERezGKCkdgRUWJKbPPltb2LdnTarhD++PIOAEuS
X-Gm-Gg: ASbGncsor8psJtlvPrOgWSp720mkxsnGEBKQk/Fa5Fs9U9I0AyQbIMX6yrnj9S6DjZS
	GFKIxttk/dkVKfxYLjst5b0tZxjzZX312atzj31xjIv8693BO6BwVaMgm4Q0ZEHrzN4za76MvVS
	lkE45qEb6B2tiy5/iX88CH4s+RM4615loLdJruH29Ol3YpM/ryQhwmEDRqZYBaM9T99aCtClKvU
	joou/YpKanJiUqH5M7/8fMPGMPPTi+gGBs7etp8hwIlqDBk+l0OydSETu3pE/JZTVIGA9nQLgXf
	imaXYvoMMOev6pz33TR+eC4IfKDsmZjepKOZGkLueIk0ANiVaUaCiguvHheeOqAtpYYVYEpa2sM
	PoUoeNh0ucim8piNY6gBkY4livKMGuBx7pQliGCZsiDnZ3YLui/RZDIPTdjDGoOTiXQ+QgSeFt2
	wA8nSCJUbn5tpcbYlVWRsW9orS/RMP
X-Google-Smtp-Source: AGHT+IFqbf59z458q6CV//wwrkG2YQyZ6Muu0CoQS/MrqfCezuYg7MN1x7yE1WmediLzYVtk9nXIwQ==
X-Received: by 2002:a05:6a20:3c8d:b0:2fa:26fb:4a7b with SMTP id adf61e73a8af0-334a8650347mr36367003637.57.1761293298709;
        Fri, 24 Oct 2025 01:08:18 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc33easm5011581b3a.68.2025.10.24.01.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:08:18 -0700 (PDT)
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
Subject: [PATCH v2] libbpf: optimize the redundant code in the bpf_object__init_user_btf_maps() function.
Date: Fri, 24 Oct 2025 16:08:02 +0800
Message-Id: <20251024080802.642189-1-jianyungao89@gmail.com>
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
v1->v2:
Fix the compilation issue caused by rename operation in version v1.
The v1 version is here:

https://lore.kernel.org/lkml/20251024060720.634826-1-jianyungao89@gmail.com/

 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b90574f39d1c..fbe74686c97d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2996,7 +2996,7 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 
 	scn = elf_sec_by_idx(obj, obj->efile.btf_maps_shndx);
 	data = elf_sec_data(obj, scn);
-	if (!scn || !data) {
+	if (!data) {
 		pr_warn("elf: failed to get %s map definitions for %s\n",
 			MAPS_ELF_SEC, obj->path);
 		return -EINVAL;
-- 
2.34.1


