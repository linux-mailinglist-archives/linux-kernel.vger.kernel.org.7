Return-Path: <linux-kernel+bounces-860495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E3DBF0464
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BF494F4034
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02F12FBE13;
	Mon, 20 Oct 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtfMpC4h"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434A2F83C9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953202; cv=none; b=XCyojrMM/3jCLnKCrnekuG2kTD4BQm8tpjD7TsojOe9/0iNchFI3KsN8Rj/ZeJsxV6Oft4HI+87+VplACLQZ69QqrzMDXkNjRBNVwVllJ9U7axTc3vSvr54mSUXs0uDwv5MLhiJY93qZXebUx///o6Jvbvo/BbshHZZwJB5i+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953202; c=relaxed/simple;
	bh=JiMogRgbGInBSVOsYygafwOmjgI5Wy/DT/oysvwSgB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+/UX7DEqXRSMDidfEvqimXsvt6E1YrFE+5pEIThuL8cJOOeEqszM9JQ3rN9GLbJKzlG6Xwhoaj45bboOYQAEKxoN16uMhsX0xaCt+TOD3YD/sQFAlA0WTdl5O/iSeNpknV1JAVsE8AbCo/3B90opfgS2z4J2DQBwlsXbIgwmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtfMpC4h; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso3619078a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953200; x=1761558000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+GuI+F+NaWE59KJ/k9RtDwOss9C7K5SDMuWex2KGKo=;
        b=GtfMpC4hrDbaFi6uNcfeZGjQ10k2P6U0iAPd6ePnvnDhCSnPp9TT5+mbGx3gY5qhw0
         dSX0RH9WywbL6x4hhnUh6bNsLpqj9LL/TY9GAqrhXoNRjdNQDaxch4PIS7PYiUIixWmU
         mOJ9/+AZTsD4Y6nRt1OakoibY7/wTjCjtQKHZM0V6A+wHOBOF6J3jP2lTjZPZ+Ptxjq9
         NSYB4h+oXpKjdUgJ3OBLtXODaxA163vOLy8xubv7LXlv1qfgQhOvn40Oyi4OfMM6AHws
         ISuU51VDn1WGh8b/bLr6QV3r3hjTHRoOxmj3vUv51AjfBzey8ttEtUBL2Oc00f4key7V
         YHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953200; x=1761558000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+GuI+F+NaWE59KJ/k9RtDwOss9C7K5SDMuWex2KGKo=;
        b=knQvlyl/V5vX85i6+RV289mDX35UyohgqMfhnRI9PDBNhfk0lrNzO0AHoaE7Ve5P2w
         cIRJaJbQWKiWasJgRGcY7NIKtWDLskmvSeplTnMLG/iQ6+X1rbHYGUReoK6gZN0Fj1c+
         tQgjqkBezmXQ5bG2n0B4K4FR3hv7SqgHD2LJhRSlWOvNyUSZC6GJW03zzINUlIn5i7j2
         jagwqyyD4xlR1kQN3KvVWe4NzNljZaVQq7JK5/kHwQC75Mz1m1Uus2oO/et+Q5JD7pOw
         AgFe5zL1PaUy7qjk2vQMeB2e9TsUxoMNOBhrM0haszysx+rloSEgiweTyRqp2aGUx76h
         +tuQ==
X-Gm-Message-State: AOJu0Yxt2d7BfRSw83eYS/rmV3FLDLOY3tKIGWRSTYw67sizugtTlD+5
	k6Mn482dVS++wnLDyFYlMKMCzFwrYaR+4PV6WtnliuPMC35RelqP8l+t
X-Gm-Gg: ASbGncsRcnBi3tEWJRFjZWtVp7dwd1fBXf1mm1pFNGt7l9v7UlkG6Ret550g4YLeZ5U
	6kbOG4j4M683pSch3A8IlNtcZK3rFI49W4njL/2pWm6Ut6cXXQwU9oMN3yC3BmihFapuc4aLyPM
	jEgu+/bm4h1SSIFfQX8dr8M6ZH4YAureclFNxJ5070+gT8NkMeYuNWCYBLngdI+aALW/rrcwsB0
	tYPVfp2GltDeVdkzWu6dv9nayHrWUMhI+kDPOef7L5zVp3PX//k3yF/YG2B222KWzLfqa/zbXsO
	TBkpfM2PEuWExDLrhnxNrdPVEzR5QNWC9UJAZXSPp/RuZXEnB1xPQzK8qbbj7+dgih8paSGHTMr
	xQSnv6Gb0Rte4MawhNOe/JjMoqkzsz/XcE9Nv7E1Cl6nGUY6oN3c3tHXANTCa38EvuMujgnbLMB
	O5A24hiRIcbS/lqfBpWD6hrxfy5WU=
X-Google-Smtp-Source: AGHT+IGe3SkLpqxFGaI/6R57SnMYrFhU59st2Lrt2ihDY77Hqt1qbILgggp368MUDEPo1pjndWr6mA==
X-Received: by 2002:a17:90b:1dc6:b0:339:a4ef:c8b1 with SMTP id 98e67ed59e1d1-33bcf8f7802mr16406334a91.22.1760953199716;
        Mon, 20 Oct 2025 02:39:59 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de8091fsm7617200a91.19.2025.10.20.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:39:58 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v2 3/5] libbpf: check if BTF is sorted to enable binary search
Date: Mon, 20 Oct 2025 17:39:39 +0800
Message-Id: <20251020093941.548058-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020093941.548058-1-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that libbpf supports sorted BTF types, add a check to determine
whether binary search can be used for type lookups.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 87e47f0b78ba..92c370fe9b79 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1091,6 +1091,8 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	if (err)
 		goto done;
 
+	btf_check_sorted(btf, btf->start_id);
+
 done:
 	if (err) {
 		btf__free(btf);
@@ -1714,6 +1716,7 @@ static void btf_invalidate_raw_data(struct btf *btf)
 		free(btf->raw_data_swapped);
 		btf->raw_data_swapped = NULL;
 	}
+	btf->nr_sorted_types = 0;
 }
 
 /* Ensure BTF is ready to be modified (by splitting into a three memory
@@ -5456,6 +5459,9 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
 		}
 	}
 
+	if (d->sort_by_kind_name)
+		btf_check_sorted(d->btf, d->btf->start_id);
+
 	if (!d->btf_ext)
 		return 0;
 
-- 
2.34.1


