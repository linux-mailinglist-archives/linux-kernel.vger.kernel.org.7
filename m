Return-Path: <linux-kernel+bounces-882810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38003C2B8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3163A8F39
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E53081A8;
	Mon,  3 Nov 2025 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMuuswEV"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DF7307489
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171129; cv=none; b=dkqdr+YwaS3/MTcRZII3D4Z19zfs2XXQ+4sXWLpDdUU7gALpXNbSjZiQRTmDJc65tcj5xFI5Lx2488xP3L7QAeGPqkt5RW55AmUt2BWNi9jyAHUGkoOQc8HSWeL0W8cGlJvzgrLkqzsZSeUX2pJStC92F2kUYTTVF27HK3DnR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171129; c=relaxed/simple;
	bh=pMpOTKHGuWFSPBIGEnzVqEdHstlTInYMW+kdV08lPyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hlAg4N2dX03TZ8hT9iXw9oDJam6TpYtqNMFlmjIbannfnERTISEHGxkeYSv0ZX5wrVaQ1N5oUvKOBq89qogorjhgc3RM9+aGtbg4gdUP90Bb6tGjP5eXIHFoeoNWtKFca8GQjm4rLOGL6bOZ2WPAxO6fk0EeI73vCvm3C6kqZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMuuswEV; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b55517e74e3so4173856a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762171127; x=1762775927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYDeaZxJ8Vy/RtTKvUvYMgpW20VocJ4bgzuBiRDeJ4s=;
        b=XMuuswEViDtOjFKRmi+xDJkygKNebsRHd8vrRItMa0kOv+O4G9b891Y6Efo6d9fuDs
         n+Rm9lJ3nXFDqsnXy6x8IqLBiN/0EdNkvjwZFZPqLjeO2vAupqHmX3NChXunwgUUcPdE
         y4JyO3qlpeqZKHmWYsjtNSZHA0/DAQsjurCl04ETEV21Symnu+NdoABzsNaDTYXdre/L
         sqiHyCzuX+r1YmACxJ3SgIqEa6xASZlwE/H/6nRGMd6OIIiKc6VfXxiy2lXo/TkgOgiO
         9VjeC3xMnn2cEv/0UqSofoVlModyuIEdFxJdArUrG6vqZwI+C3z6ndStN2hPtKmOSZ3Y
         y4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762171127; x=1762775927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYDeaZxJ8Vy/RtTKvUvYMgpW20VocJ4bgzuBiRDeJ4s=;
        b=ourkXRYVzrNHWMPNFXAtd+be7OyjAF4semv5741pmFCeW7UXGfmQ9W2s7zfQcswVtK
         s2h4K02DP4grzyqNJyhWbQSkKAcj5vfFnRra+59kXjjSyKP88xDcwRAlfCB7Swp3dkWk
         +Fat5SZrnFGCx3VKv5WqLGNOKm4bkPF1O5Xxtmery+F8Nr6Me+mjPuMWQsV6fbGyAurq
         GUemy41BwQ4/elEsGslYEDbYpcxPJBjxN8xmOgvczdZAQsU/E6m49cqP++0xfsFsJIta
         TZkxVTmRj1Q6Dj1ctKDJaj0iC1VNIaJ8uvnK9MPENZWMQLUqq/z5p+VecIqZDI3RJAmu
         CCHw==
X-Gm-Message-State: AOJu0YyfVC2qBmatuoAnRDTM43IeCA0a8audBuPXbzj/NI0lXprcGno5
	yMtAyAitOfBqOjWNkJKjX+oLjbEH63mO5P/eLyeoLHmmlcHL5m4JEXeZl1dPq/sGxXk=
X-Gm-Gg: ASbGncszDvYKoK8V6KZrPu9A8p2WHLrdxz3DwkSNHjeQjWQoMiVRz885PEmGL0JYrmu
	jcTOu7pLmOnOqCTqGZ3CxO4UC5rtx0OUFcP03o1mhbea1D1DMYd7wXLov4/9QYzZJuUcGA8WJcv
	5IUFA6zwLK1QJfq6vRBHrE304yGM5m0wK8tHvTlQwQhQegM6V1gE6lRLhPYmzK285y7AKulPtw2
	pSMmsXctQZ4GsKaNn3/Y9zWUCZbSqIHlakonHINtViXhKJ5AmCg55havF4ZkhQ+0WZ2oxRRwVCY
	teBZmAhhAFvHu3aMUf2oLtswr2I5wNmznULkdPvn/IqrwuONFMYDqGINjvNc4bMvcEeKyaBSG0n
	8uht7sXRjPdinJOkxJGzRT4DEIJcY9a0fG4EDm52MJypCyPrSyELbstA3gB0905q8H2BC5PwNUP
	CZJ6Pj5usjyD1MTDIz6w==
X-Google-Smtp-Source: AGHT+IFXydWTCjfY7kW5EClVfFYcgTumDC8G1OQBK9cjulV1DvxhDVl+Eev+vOVvJD1GEs1h0EFx3w==
X-Received: by 2002:a17:903:2285:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-2951a390655mr143399485ad.4.1762171126796;
        Mon, 03 Nov 2025 03:58:46 -0800 (PST)
Received: from E07P150077.ecarx.com.cn ([103.52.189.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268ca9fdsm118304485ad.42.2025.11.03.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:58:46 -0800 (PST)
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
Subject: [PATCH v2] libbpf: Complete the missing @param and @return tags in btf.h
Date: Mon,  3 Nov 2025 19:58:36 +0800
Message-Id: <20251103115836.144339-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complete the missing @param and @return tags in the Doxygen comments of
the btf.h file.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v1->v2:
Try to fix the CI FAILURE issue by rebasing the local code to the latest
version. The v1 version is here:

https://lore.kernel.org/lkml/20251030113254.1254264-1-jianyungao89@gmail.com/

 tools/lib/bpf/btf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..cc01494d6210 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -94,6 +94,7 @@ LIBBPF_API struct btf *btf__new_empty(void);
  * @brief **btf__new_empty_split()** creates an unpopulated BTF object from an
  * ELF BTF section except with a base BTF on top of which split BTF should be
  * based
+ * @param base_btf base BTF object
  * @return new BTF object instance which has to be eventually freed with
  * **btf__free()**
  *
@@ -115,6 +116,10 @@ LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
  * When that split BTF is loaded against a (possibly changed) base, this
  * distilled base BTF will help update references to that (possibly changed)
  * base BTF.
+ * @param src_btf source split BTF object
+ * @param new_base_btf pointer to where the new base BTF object pointer will be stored
+ * @param new_split_btf pointer to where the new split BTF object pointer will be stored
+ * @return 0 on success; negative error code, otherwise
  *
  * Both the new split and its associated new base BTF must be freed by
  * the caller.
@@ -264,6 +269,9 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
  * to base BTF kinds, and verify those references are compatible with
  * *base_btf*; if they are, *btf* is adjusted such that is re-parented to
  * *base_btf* and type ids and strings are adjusted to accommodate this.
+ * @param btf split BTF object to relocate
+ * @param base_btf base BTF object
+ * @return 0 on success; negative error code, otherwise
  *
  * If successful, 0 is returned and **btf** now has **base_btf** as its
  * base.
-- 
2.34.1


