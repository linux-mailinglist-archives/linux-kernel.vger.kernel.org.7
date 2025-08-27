Return-Path: <linux-kernel+bounces-788744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D16B389A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5950F7C1D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DABD2E11D7;
	Wed, 27 Aug 2025 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSbQMlDZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399ED24CEE8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319669; cv=none; b=paHTFsktq0zMuBUbVPrvZNYkIf4x7VzYARH6tNBFiwrwC5o+FypIZ+ZNNQW4UcPc9PUQb0F9W+0ah8W0BSk9m6uUfDufWHen8mH7Qjaq9vMxPDtRWcnpOoc7Art/UtYLeH3aUxAD1bQt8aKtxsIAK/nWxyKpI9Zf7nU0AgyxLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319669; c=relaxed/simple;
	bh=Rm+NKlY2TPyPlqks5oVADvOEWm0Jfq+5H2RrlsyIHnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAQ1aPpqmRZ9312biAnSjY6II3TMVdaePL4Erh4XXObuqxXxIkfxCeGc7ZNfc/fPtN3RjNzKK+5UY1/mR5EK6UK5K28QGS8x60DwQwUdKOaJmdv+9/+ddptl8X2aeRjdDMEQdgJYbiKXy+Ld3d+SuEXoyyBUKwlYRBpZDMiRIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSbQMlDZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso648445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756319666; x=1756924466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IntdueGNmbqsonxIGWPXQZZdSCFC9k/C0Gxs2L8OAMA=;
        b=bSbQMlDZmWL5BiJm4sv0wjYM98n8A7s3FFKJJasuIPqR37p5cbKlkgNGQomxxkjwtd
         +EXa7Qtl4zv3YOn6XTNHZSy4ROgi50qUEbU/D0tCXKvl1Wyy3kA6nwl2Yn+zW/+V7AJy
         e40b7hO0YfJtPWxihR283qaKyU0YnVo9pHPZleQU994Rfdw8mWWp0v03OV+6L9izH5Xs
         vkrLGmacw8wnTkBghPP491EmlQt+xd1G7JCwpUQS1lVcFv8AdOtQm/NAc8i7ByG5bXva
         32b0DF7H0w1bC+PDK6OgxeyOZSAgB8DIlg2K6z5ZbKLJVSyGuxm7SQK/kBBH69UTgHJ1
         YXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756319666; x=1756924466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IntdueGNmbqsonxIGWPXQZZdSCFC9k/C0Gxs2L8OAMA=;
        b=pE3eNZflJrxVgok7nEwa666vLyw9HjKttlZ75LRJx2gQGj02O/q0XWcTkihBsGBDvJ
         WRdWNmP6tQi1pa5gNLxZUgOByc75bgYgPIcu7oxCzgMNOteF6h0dbxs+G5rucWRxYsPF
         2LLzsqa7T0jy3UpFjnkEIDriCTcfmgj/dQRam9p61VFh1rdJr1mKD5pj82nr2IPH1LXs
         vIdXcU0n8LcFMsYAt30vKRiDp5QaNhzX1ndDPszGDMyfHnTmsbFU3eJ/I2PWUoC9d58c
         yINgrH74hLrUUWjApBr5PULTQMnannGGaaKeLU5GlZpSxxRN2WOKpmKWLkb+og7EoaTM
         WGgw==
X-Forwarded-Encrypted: i=1; AJvYcCUNA0GGPwkDmzxSIQmis9UPgy4YI4e97wzoA3l5QaC3n7lin1hbtW4+jJvFUEBl7Hbxc5Mksn9BiHO8JoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXyuudk18B13DAlZMVJpkfP+VDNCHYfXuNJa6edMGFhIaNaXX
	gaaMcgz8J4bhxfNB2bFp/Wt8Xhpc3SJ+kNaO1JFF1bERYKpzjRmnG2mpspROraAfUer5tg==
X-Gm-Gg: ASbGncvCcHgQf/lhJ6JdsurR1BZTYQ0vZqGKo91BgkGmNDPM0Uk+B/IIBb74YEnoxsR
	FsBOTAxWuwfBHq/QmdzrapNCYr5eKTICV9El4IiwVjkCnyoEhEbeqobGg88gcF4T+AJ/G8MKAxR
	VgLWxwCmC4LdYAJwaobk+5nzTdehbqxMSGGdsEpoTC+skfzZzBsHc+HDQhtvhxxKQHCiytBZHNT
	Jnof2aDAQKguX/kV8TSTNa/96Yw0fkGKAVWjzFoBDt1DHW4K3cRI1pcND53AwlVYuXb8FCTapcY
	4tF+brpmDshS7SDO3S3wnK/LRSOq3FwcZGTaF83bg1oBOZct9ulOu2Dm4DNKO+Y65tuhFDCjSUc
	OOhqiuCaKIAdD2jg/DhFHLFYp
X-Google-Smtp-Source: AGHT+IFpUR8b9fvTNq2Qug4jd4Uwz8rry9LmQ0JBLOieWly9E/eJQluuoWaNnPRcfSqVFiET0281Eg==
X-Received: by 2002:a05:600c:1906:b0:459:d9a2:e920 with SMTP id 5b1f17b1804b1-45b5179ccc3mr180127615e9.4.1756319666289;
        Wed, 27 Aug 2025 11:34:26 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0f3362sm40614335e9.17.2025.08.27.11.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:34:25 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>
Cc: linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] mm/show_mem: No print when not mem_alloc_profiling_enabled()
Date: Wed, 27 Aug 2025 11:34:22 -0700
Message-ID: <308e0293e68dfadb2ca3ee5b4c650fc3d09d7a35.1756318426.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756318426.git.pyyjason@gmail.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes print kernel memory allocation information
controlled by mem_alloc_profiling_enabled() so that we won't
see all zero numbers in production.

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/show_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 41999e94a56d..b71e222fde86 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -419,7 +419,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-	{
+	if (mem_alloc_profiling_enabled()) {
 		struct codetag_bytes tags[10];
 		size_t i, nr;
 
-- 
2.47.3


