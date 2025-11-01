Return-Path: <linux-kernel+bounces-881351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1318C280ED
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97EC1A224F5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776692FCBE3;
	Sat,  1 Nov 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YwXgG61n"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED92FBDE6
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007030; cv=none; b=IGv7y493dYVWYvGz+0DQTEXVQ1dej5dCZ+W2OQRMW2MuVdcw7GP8LfatLGqQuxWjAP8Co2h0S5tu93eP9HwGDgHmYAI05NLHTPBYtrvk+nrQb1p/CYZZqw9cpWMmSmXEzMhyXcwlJl0xy8w+QDT2jWOUs13x0Y9ZmaPv7+OPPgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007030; c=relaxed/simple;
	bh=KY8qnH0TrVjhNGmZIwNjdy8NbnBQP/+RCC+BIUEXvo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSnNl1b3cUZLqobbJcWcE4lPUbUtg1oY7yL0fKOUaUP9YMMqT1Ui9XETml0IMPHHVTIFb413YJnnN98rYlNiVDOzS/AoU351JweoLtzUW8FaX1XqRtMs4lapSFVQBDQok1v3mDcWLhiB5OmAKAppinuAh4pNXQ6YqOh1SVE9+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YwXgG61n; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9351ed45fb8so280770241.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007027; x=1762611827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSrsMv9vHZViaOOimguQYKUYT4fHRN671HybCTbnJQs=;
        b=YwXgG61nEjNDMKgQUO/WwJafAZP9oLDVnssvz5kckyJakhbeoqAw4e1oXInPAoykhh
         MMzm7Ox0VnhP59uv9V/pf8SYzXRicZ6lq1TSosc92JoCSzePSMvDjN8RBHABXyu/MuTJ
         g1Le0wvH2q8gFJkHDDplQ/eUassc1F0XVGjekJKM9/V0n7DNLXg3iKWRZYEahMnJOku+
         MPycTsueCojkEfApi/zfEQXvggAl+/mkCZ0yrUpVc410G5ClHs6XX7PBjm9ISuktgBI4
         5gARohsJGqi5qm2OQMYhnZERkNxBh2Z88SkDmS5u9okDRZxGXZQthbaIpoh6DpJygvyc
         F5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007027; x=1762611827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSrsMv9vHZViaOOimguQYKUYT4fHRN671HybCTbnJQs=;
        b=ocGAT9KlQqT/nVzVq5PeTroxkKcdTzzDW0wbcw+tfxHQllxRiak+tXoE2b9B6Odtn5
         xEm70291FVmhWnKuYU/GWDk7HHdhx7Mcp9thba8diDRR6wuIwdpKRKgV1am1JVOWDA2Y
         A3pNarZvkSPxk9mJObafxVq6Dz0eDTP9Uuvt4qbzP1fZ0ficnNN/Aj9A3RKGgratefEQ
         ZawDm6dIcLhggN3ibm2GgBk8mroaFeI14m995nFZxtzpwoThKuL6g6EU1PSLn+Q+ltyT
         pLXWB2DMjq2htEs06h9Gw6KkJaU+Bk03GlR9TFVuS2xGusPFEAjmbFVUksQjRPz6MYqN
         LDPg==
X-Forwarded-Encrypted: i=1; AJvYcCVf5mmuwBpWxZCNAk3VLD9x61svlM8zCz2nz6P5FE0gr2qD2W4La9CP/cYU/JQjCJpLRO5h2ETfvl5/7xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XKexqGiud2gOFuRXSoABpcPvh7qzKwOkNxw+nn05ZzcM59Vh
	PWosOE5YKOgOT5VAhU6OmGDJ+WiUJbsOEdHq0nOZgYsdhn+RVhb/1DFsA3qEB86ILwk=
X-Gm-Gg: ASbGncto2wBDbuKbGi6P4HQlQQifTRaByp4louy22bedQsZrb4CNc8V45DshiyvTq6h
	7i1GPvwLlMQtOdRg40GjUmxwAAyuR97KRCKLy/ErRfXmV7I+HJbYiphBkl0t/y2aDRHwLY0KB6b
	JFvQmQBbSAhLbFiXMkaXrVoRsX17crU4rEU519UH/IulUD1l/NGJB7y/olpViKe8JL346SwzVGm
	rILyyC16dos6Q+suUwjGwTCJZoTIhXv+z+JmC2dRzkBKJqfDNM4UHcDh2rwYKQSDg4udpg4VlmQ
	0HWmh5mHb+Nchet5c5f6ymi8hNHPAl3x1VjeXSuLAk1YQL8Q39/rEFE2yawHDmvJ8YsZTBNWGVV
	xL4uvWYwipafD3xsPHsr69nXGssQxq9D4meq2ETn9dHv2AR0m6DSMOZiJQdt+zu/81rSCltDjCT
	g+j2h/Zv8OnQ+UWj+8gTzrrcA6DVPCEEPXkK4QG3syB2cM1VScdHo4RM6io579
X-Google-Smtp-Source: AGHT+IEQrc/UahYLt7ANSOW5+mMj6ZVaZ8HuruQYEbIlio2ExuETGUVUCqnEvcl9P/bAjVq8vDxMwQ==
X-Received: by 2002:a05:6123:2e9:b0:552:2c5a:c057 with SMTP id 71dfb90a1353d-5593e548e2amr2464325e0c.13.1762007027406;
        Sat, 01 Nov 2025 07:23:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:46 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 8/9] MAINTAINERS: update KHO maintainers
Date: Sat,  1 Nov 2025 10:23:24 -0400
Message-ID: <20251101142325.1326536-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changyuan does not have cycles to commit to the upstream work of KHO.
Remove from KHO maintainers.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 764df916fae7..6200de2027fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13788,7 +13788,7 @@ F:	kernel/kexec*
 KEXEC HANDOVER (KHO)
 M:	Alexander Graf <graf@amazon.com>
 M:	Mike Rapoport <rppt@kernel.org>
-M:	Changyuan Lyu <changyuanl@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained
-- 
2.51.1.930.gacf6e81ea2-goog


