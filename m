Return-Path: <linux-kernel+bounces-837178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6CBABA03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6AC3A5B01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9463D219A8D;
	Tue, 30 Sep 2025 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKpLoJBt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82727212552
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212043; cv=none; b=SQHf8VMbS2LTqeWWhKeFXOnj9L1oq4k/wxQBDQCNwRmwTUZ2Sn4QuB2ryvgWCwswzl5quFaSjS4R/14TP89P5APCBYtQNzZ7OI26/tnxWKrz6Br/THuSJwELlZiUXjLoTIKHg2h4hTJCt9nAiz9GcIE52ZxfvqusEOwRaCDgQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212043; c=relaxed/simple;
	bh=M3JDOPbFjkClAC4UX2vhrNDOfN9b6bNYa0hiNAn1emM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Olx23W3ztM8MmCkskJZ6xGkbIKfxd2YBh4lnE0o8ydTDg+wSyb54lmsEGK3Gr0LjI4DufiBGNbmqmBmws9nvYNwbbjcr0AItmoS4REJj5I/NE/bg/DcygljhvTXfvCw8YH+dUJJYQoxQTLy2udSmi358ENUw8061xgTexEfhEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKpLoJBt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27c369f8986so53291295ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759212041; x=1759816841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHmEXjchUo7p5MNeEkw3mVcK0Ae4ArUpPhVglZardsE=;
        b=hKpLoJBtNDECiZjp0VakSp3fmaHyldgcYRJAURPLoZBP4KVhzaYtEzpRPn//5pH9kV
         fHJz7876ZaFaJB65R4/H/1S0qXqY8sxE5KmS+E46Z144B05+1atfc5ERHSbWp6CI2HHB
         QQ1sSt0DKpnu7G1TwweNu2GYKEujXltczKjxte5zVFgGkYVPTVMexXtkIlDIsv2A0FD0
         t86vwWfsgEDUO/6ZM/MXDkxH/rEEUU5JKMt0htG+IS8JwFhEA0j+h//km/whpyax3yY7
         LThza1Da89ochEpmaxbFXFdvttHvwt3DE29t8Bl2OqkbIQqzDxUEboM87T7TN6OKaXH8
         dzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759212041; x=1759816841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHmEXjchUo7p5MNeEkw3mVcK0Ae4ArUpPhVglZardsE=;
        b=rvaFgnu54lr+VLmMCDkVifWd+OAFl7SwemKmetM21PslzUrAfJiOCxWNUB6FNmfTR7
         E76A00ns4azc3KG5DFaMd3YEz7heOdQH/lBpHLTdfyanEiG6toOS0Kl+sy58n/zc6fBj
         /hF53S4uwuSO0i742exmFCRvKb7W15bXHxsAudfb5fUPi5ZjlA8ajyGy66Dwaar2QCGM
         09ssbu1AL6rOOvA9ZVlMwDPNIXQ+DYg1m9DWoO54w5G0w74h9Db7Iqk5rF1ewTN/h9Ly
         0yU7ftZaa815GTbSi1s27Sye8n+rItKQgL0Owf0umWih38GUB2dmPPJM3E6D5W4zZeK+
         cE3A==
X-Forwarded-Encrypted: i=1; AJvYcCUf8zmSbZVzggQFzz3tbH5fefLD7ITXpuH2eudSr2bK34jzI8js626wVy1Tzye4Kz3IBZvVRp5w8KJbWxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cjewBIf1Em+1qqgijVXwlzAfvnt5EHCZbjms9jSxETJ6nuga
	i6C+vic3gJgF1VZ8a6Ekx9xhshVrjO/b28LyVhJjsdgWd9qMZrDe+Zpp
X-Gm-Gg: ASbGncvX/9yPJxeZN+Fm+qB5vsQnWt09K6jF7sMUw8UpRoSro5qd0Ly9vIuzQy8CIuD
	Gv4odOeqeUexQuD9B6V7nmpnTWsrowRngJCg3Rjj7NEm5pbPMK5LZe1ZJwirhpIayUpGCxj3zTE
	S/Xh+qIOaBx2DzTsELRU4LG1HfoHV3CXvhJ+3JPAIaoFqmcAvMhiLtIOEBlymFT1AMHrJr8/gX7
	NUuC+MO/xw4YWQZIAB8rRdl+eZbWu/DumL24eTOkfH1dXJkCLoUpufUrkljpkRoUH6YXUVqiiNu
	TK5lhbo5qbve3dMmFDGBJnZPZpO/cXP7UVJrVqGeAZPwuA9zUaAisA8atF5+7yQLYpZpS1IvWbK
	bnJdZsQMDGqxWdZtbNmphMMdg0OikG0wc8gEXksPs0aym6OrM+fBseKm0M+LbMkqzhnmn9DMukD
	SQywqSL/kgD6XQAmWCUFKR+1YgUtdnttBFZIk7HQ==
X-Google-Smtp-Source: AGHT+IESjK5uuXD6SNUTqXGKn8jpixgQvb75Jnts3CNC+W4F2sDEPtoAZ7lXfxrqlZpJ+kSZvlFegw==
X-Received: by 2002:a17:903:2407:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-27ed4a7448emr222073545ad.61.1759212040904;
        Mon, 29 Sep 2025 23:00:40 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.23.00.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 23:00:40 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 11/11] Documentation: add BPF-based THP policy management
Date: Tue, 30 Sep 2025 13:58:26 +0800
Message-Id: <20250930055826.9810-12-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 1654211cc6cf..f6991c674329 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -738,3 +738,42 @@ support enabled just fine as always. No difference can be noted in
 hugetlbfs other than there will be less overall fragmentation. All
 usual features belonging to hugetlbfs are preserved and
 unaffected. libhugetlbfs will also work fine as usual.
+
+BPF THP
+=======
+
+Overview
+--------
+
+When the system is configured with "always" or "madvise" THP mode, a BPF program
+can be used to adjust THP allocation policies dynamically. This enables
+fine-grained control over THP decisions based on various factors including
+workload identity, allocation context, and system memory pressure.
+
+Program Interface
+-----------------
+
+This feature implements a struct_ops BPF program with the following interface::
+
+  int thp_get_order(struct vm_area_struct *vma,
+                    enum tva_type type,
+                    unsigned long orders);
+
+Parameters::
+
+  @vma: vm_area_struct associated with the THP allocation
+  @type: TVA type for current @vma
+  @orders: Bitmask of available THP orders for this allocation
+
+Return value::
+
+  The suggested THP order for allocation from the BPF program. Must be
+  a valid, available order.
+
+Implementation Notes
+--------------------
+
+This is currently an experimental feature. CONFIG_BPF_THP (EXPERIMENTAL) must be
+enabled to use it. Only one BPF program can be attached at a time, but the
+program can be updated dynamically to adjust policies without requiring affected
+tasks to be restarted.
-- 
2.47.3


