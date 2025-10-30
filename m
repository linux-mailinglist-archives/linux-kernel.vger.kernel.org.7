Return-Path: <linux-kernel+bounces-878125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D751DC1FD74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 204A84EBCB5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC8C2EB86D;
	Thu, 30 Oct 2025 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6noZdYd"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969F2DE1E4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823985; cv=none; b=UarW38nRP1YQT1qVoKmIed/KNXRT3V4b+GW71s9mOPBlcLMBupwPibc8d92+IwvNwolbHA2DTlV0GgWXJBvoQ0wTxAKjMgMMvK+CsCF7PnIr6s2Wzh9q+aYmLdiM0TucYwzQrOzvqH+O2B6+G/VEBx/4xj5fKpVZKiTmabg+gLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823985; c=relaxed/simple;
	bh=kI1JbXfoy6fCJFGf3nA1WTWB98Xqq6C3u0D/Hl+KGCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DDV+u3hZgpesP5ewHTjb1xdzTtc476FMaVB31Bego/Y/UhLEf2CzqMb2nXrs0fsuzmwvldLbeQNL6bIiUwyZ3/1ytivu1I4+ylvJmpI+w1HYpayhOyLPdnuntBGHV6l4edpszl0g0MMbGD0zIt3B2tCOHHTObq/iQcwVphm33WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6noZdYd; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2907948c1d2so9340785ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761823983; x=1762428783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5x8ZW/bCx1AcWlOIX6ult73c0t0JDKbFQ+lhTfIP/8=;
        b=F6noZdYdmrLJMiWs69XlhyZ+6OYwv8bDxc/Do1pfo30NFOGPe4R326Do8c8hvY3QVk
         42dP+YlNnbrjYnSOy0SYhPM0OksUxbwHtcT2v77t6VuS5jh/YAUwiHu03DkjvIBDHXnk
         Fg2Egsw+CnjyCOSzLN8E2oGrso4YJFXcKlBp+hZoCXk5MOz4i63ablX2VbvnhC6+1VbS
         2FPIPi8jjUa9e9p/DWvHAXhHR1eGxsEahP7bnWa9yhU925d+ij2wvNRxJwz4PRxbKgzK
         aaStLi/6kyfxlLpTXBk/XfMJAgsuWuixSgHYmtrcma8xzcUJxiSxw0rq8VPXXduy90dQ
         urGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823983; x=1762428783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5x8ZW/bCx1AcWlOIX6ult73c0t0JDKbFQ+lhTfIP/8=;
        b=YELHRNOjyDSvDfnGhS2KGhd6Zp0nUwRmue+H2c6DEX0wmGLpJbyNXHfpOvlgFXpv4r
         uRAnphdf8G6XACfbtfb9sClN7TqJLsyGmivAUHc6zJnH2nrMa9Atj2TpIiaiVz3eeBZg
         s6G64KLT7Hyb/7+jwcWEy2HzHOqCT/9iLRzmZOUCoBr6O0GLXvBecZ0ferAgZDa0WRRk
         A0B4910qQMmtzTQ4JYBGOUpR94KEAP/ty0teHFo+lhtpkdrUfaMYye+DPamhxNBmRgff
         c42B7mswWhwBgj3CnNoecH9BiA3c+kMj9XQtknb0SiJRhYhc0+73Q9hlCYPih6ZMV7q1
         v9Wg==
X-Gm-Message-State: AOJu0Yxw3Mjifo5cxzfQ98seH4z29wCi7bUEmDMLoSdQZKij/MebvDl4
	PLwQwX4Ode/OSwdF9i/5ZaQCAyIQB3eNjQ7LsYalOAjDYFtdVSwVPIGgmr4Vbjjs
X-Gm-Gg: ASbGncvd0FIxLuKg4q88pL51skw3i8bznW4DO5GyKTPDIR5QiAAYHz0Ja25uA3GcdBw
	gPOeOeE0lgNfGGKOa8wVkODzh1sw6wt112ZzxFNLRgCRqrVQiicmf7cXhwDRXdu/E3Z2/Bvilex
	80Cjh0YA6vwCFtbBTFDlLNYORnQ8pmsDKQsty5pH00eN9NH9V8U5kmufWFZJyaoiw2CcS93Z+vO
	eYJ5U/xcX0/EDBeBMdLZfh/DuaVBktarSPaLSsx+3Gm3YSioRFXL6jC3mOArfThHo2iw86A6Zcl
	W7190obfeHX8C5RMLcfE8nAJb5Pl1xHgXlh85+a7XalFsfYByVUdltZ1+jfmKg4XPp0P7+MkLQm
	a1AkSOwHNizkQAj8JSF9N2Ub3ydofWajQR9OQiad4c+CyXMURRPLYS+IeUQVby6ZCNL2u/s2JR+
	NUaA2UnInikSFIjigWz2k8wcAQYC/+
X-Google-Smtp-Source: AGHT+IFKTx/OOQsQ+B/HWtEJMYFmWFeWuSDXceaLNFDKHVM4zMzg0kPVNDmWFu2wIsBMcLtSCCZV3Q==
X-Received: by 2002:a17:903:11c9:b0:290:c5e5:4da1 with SMTP id d9443c01a7336-294deedaeafmr72375355ad.38.1761823982558;
        Thu, 30 Oct 2025 04:33:02 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a40sm187493715ad.0.2025.10.30.04.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:33:02 -0700 (PDT)
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
Subject: [PATCH] libbpf: Complete the missing @param and @return tags in btf.h
Date: Thu, 30 Oct 2025 19:32:54 +0800
Message-Id: <20251030113254.1254264-1-jianyungao89@gmail.com>
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


