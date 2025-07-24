Return-Path: <linux-kernel+bounces-744422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A06B10C96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B4F1CE4B81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4952EBB8B;
	Thu, 24 Jul 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+yP+DjN"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DB2EBB8C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365412; cv=none; b=R6hz+Drd+m976zBAv8rrx/OPZjvkOk8Uwaf8Eq/vQMy5AkUJ7KTNDGE4n1aVb7WKNLrBqe3/Rbtz5qcCX5riO838mHE/ght2fEA1A0Tqwg+c/bmFsKAKAJH9f2pvITXTmM6klTcUm+07o1sq7C9f7mCS/Y2CxGLfHIlTr+8AnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365412; c=relaxed/simple;
	bh=SQxu0R+MOijEBbbV34mwRJA/GN24qy3N7mFo2kprDqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCpfrfe2i6F+1PsM8nHYWSddz+dQnlYzbsYT/wHpLSB53ldGhenJDVuKdwY4cgPtKJs3OXyoBdwnNuWLMwv6VS0QrpVK1VOffI+418CDz4v5w6D1Nw1IF4CayjwMhJ72sHt/drUExK2OPyAXOaVGnGy60U61mvRLCkWnlNAOKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V+yP+DjN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso7185145e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365407; x=1753970207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVVaZTfA71hNG0BSuf2xrM/AfoVAw+w3Csdp+8nmO5Q=;
        b=V+yP+DjNiFBdmZX0+X+1GT/0jSDVJQdpQWqF0ppRaNQzc49toUn7rWNbIPLNzBTV3v
         wNWkiexWDjY63ikTVsoU/ILyqacQjZ8QacKphScsC4/f5U/YePpcxYSjHSY+u+V5+Ltx
         sskxvykF7Bu6ijU8AFPBb6/AO6OoNgxwzH9F4MeY4v26sSuSak4sPl62uaKzjx8DkVRd
         jLbvBD4ef/mS8ygVvLqsdORg8bSZCWfz5Gmfn7oatkWV7HvTa84xItdTnRbb2envSyQ9
         LHRe94Xf+/ggX86LXMsDhr6R4dQIHDZ2xL7nhc31q42I1RLqBZCiOXI8TCGbKrwR9TTW
         712A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365407; x=1753970207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVVaZTfA71hNG0BSuf2xrM/AfoVAw+w3Csdp+8nmO5Q=;
        b=u3+9sxmrCAxv8cOp1WNAWtkYpSktMjISz+mwWOxpE++/dKOolUfc2nsRT2GmiA4KPe
         LoXoh6+TS6dqZ4XylBqlvKYlLnMBwPN+WJrDQjAIDPU2kRUAlrgcN3txx6r/iJ8V0wQc
         4AtMDtwW19JPa9LiZSubTHcUM303HIDHgnlCQqLMBYYGVW2fJikV48xxQwEEIDxcT+ce
         k/qU31S87830krJtSK8s357EJCdILqOakDDEhd37zXnexL8l6FuXCA0Bs+ejFbsKmkUc
         /9WlQfT1fi5qWG4SDybu4qVJYFaBd00pcMvE8EkcGN9j35ykzvqcpulV7qJe/0zcJQNQ
         okkQ==
X-Gm-Message-State: AOJu0YwxrpAE83uG+r9dRf6CT/9UnannKmm1SxI/6Q46vwL4HPB0MHwH
	Vq18KL9ivj3Tl7Ca3GethrFsgesRaOt5PtvA3tkykXa/3kbROaIBf4hxNTWnfw2ikUSEv60yQpz
	DI3OzTkc=
X-Gm-Gg: ASbGncvRyLzu+G2fkAdAZrFd1TZolAugduFhvXIFdl5qSsAf+H11M8mCJqTHQAueUhb
	Bv2YI4AA3Ef3vZvo+zB0bmdaNkXsL5pI8dRGKBkUevr4skZNoeO6nIpIAFGuTugtkJUv+cem6q0
	6Of6V2jc+wEE9H5X/aJuLlXdn11UT4tG/PWMaquw0E2nucW+ARPIgQpvp+RaMHZ2w6zI4ZB22Hf
	QMUiFWc40XsC+1C7fpya/aoDE8ZDr2vAuox8UkITDDZLaBx5AYwmTbnG7+S2ixbY8n169MyWrrA
	KExiR7t55E4ZOGQrFkk1f+CGk3zyOCQ7mHFus7NK6u9cL3HRrOSgDXNr8zql49t48WKL6vw7nrU
	Uo3z4FIj18psojQ+6AfI/X/JdA97qIcr3mLOq35eemP1oH6HMH7k83PzjHTVyhRUZTuBEr3b31A
	kkXiMilmGmfCfm
X-Google-Smtp-Source: AGHT+IEY/sSxRS3Okztem0YstmxIRhVbZi0Ba2eKMOhhVazzTllUuYgXqZyOH8eoFni3mxJ7gmSmCg==
X-Received: by 2002:a05:600c:630f:b0:456:2bac:8f8 with SMTP id 5b1f17b1804b1-45868d485b0mr79331075e9.16.1753365407522;
        Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:47 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 28/29] mm/init-mm: Annotate additional information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:11 +0300
Message-ID: <20250724135512.518487-29-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate additional static information into kmemdump:
 - _sinittext
 - _einittext
 - _end
 - _text
 - _stext
 - _etext
 - swapper_pg_dir

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/init-mm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index 2dbbaf640cf4..01ff91f35b23 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -20,6 +20,13 @@
 
 const struct vm_operations_struct vma_dummy_vm_ops;
 
+KMEMDUMP_VAR_CORE(_sinittext, sizeof(void *));
+KMEMDUMP_VAR_CORE(_einittext, sizeof(void *));
+KMEMDUMP_VAR_CORE(_end, sizeof(void *));
+KMEMDUMP_VAR_CORE(_text, sizeof(void *));
+KMEMDUMP_VAR_CORE(_stext, sizeof(void *));
+KMEMDUMP_VAR_CORE(_etext, sizeof(void *));
+
 /*
  * For dynamically allocated mm_structs, there is a dynamically sized cpumask
  * at the end of the structure, the size of which depends on the maximum CPU
@@ -51,6 +58,7 @@ struct mm_struct init_mm = {
 
 KMEMDUMP_VAR_CORE(init_mm, sizeof(init_mm));
 KMEMDUMP_VAR_CORE_NAMED(init_mm_pgd, init_mm.pgd, sizeof(*init_mm.pgd));
+KMEMDUMP_VAR_CORE(swapper_pg_dir, sizeof(&swapper_pg_dir));
 
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk)
-- 
2.43.0


