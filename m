Return-Path: <linux-kernel+bounces-749847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53147B153A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830645A26BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC8129826A;
	Tue, 29 Jul 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNPES/N6"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5867295504
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817851; cv=none; b=esVW48+wzNam6JeJi9qshgr12iboYyo8A8MfzBaCqa88cDui9zcZop8lW8zIK2cgVCO/DoGi6CWCD9JxWTOvStkNrNWZ9HufgBcNb0oM2yvt0BAOqxlC+ZECO5B6wd2eJpOX3yqkXPWgO+mLpuHQLHdqls62RWy1TehtBdo/CZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817851; c=relaxed/simple;
	bh=SZc94WgT3oH3BVba65A5Q6CTpCyfy574wO1W8pERtAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c1XfGE/9BrOJdotTnwvz9arxpKtNxXcvUfOZHqLE0wf2m5ImL+2P8nhIjk5pxn+Ig7ybyQ0Nus8kqqEsrT4c+W31VEHy0NPl3/n/FHxF84W4++8XgH43t4bmEYffJj0sUexwhi7ogZ3zfFm+7SI6jX9eWAScMUl9yOHK6JSOYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNPES/N6; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c790dc38b4so39043785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817848; x=1754422648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1gbKWHstsqjpQUrskmEj35TBdlQ+Ks8m0MsBKhxomQ=;
        b=jNPES/N6jclAmASv/H7XjBmu1Tok+e2hnXWuIRSCO8ZuYbQCWAa+YvCfLklZmEK5hX
         K8ZXDgsleYJ/IT8Itmlpnq/919VdRkOQpQB4LifGmqlTlB7BK/6f82O6WitmSenw/09H
         hMGQFMs+9YqN8pEWv3c863d+K3GasOz+ytvpgLKRdLVz1Jlxp6nVzDbv4QXF/Xlr24R2
         Pw43LhkEJxTYNMXkR06TS2pznSE2w07vO8/Hu8JrtP3wjAIlx1GdOBA0fF3ikLcgmavE
         o12uD5I+3MFJczXhlQRsrotVVWMbmIAkiRY7PzttwUqzC0iNE841+YBSEpismSYiG3Q8
         pO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817848; x=1754422648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1gbKWHstsqjpQUrskmEj35TBdlQ+Ks8m0MsBKhxomQ=;
        b=fTvpE+98Lg2GI26J5iLnCP/xxkYzlTMoE6BKAD926a/tqmU2bGB4G4ylGFgSpUhFL+
         H0Aq/jSl438JbriETMRXu9kUuL422DdaXAcrz9G8GQVvm7yvyltt4jVQAblsxpGOP5r1
         iXcNa2NRBMoysZYrluNwE0VTfHMi3LFeFirCKkzQ6EhR51VvlKRv0RKxh0eESafK2i1C
         sam9fJ/FWgu7PVNhbRDMOMDz6t6P5CucSGtXOhEsfw0Q3Tzr4ZoM74MHK8J/OQaINAFB
         lvF8gI2/+G2aMHQzr/KYpoX4maFB2VBagcCWKzT3fOTS5wSOu5xVNd0FDL3Xy9aj+bcW
         rQvw==
X-Forwarded-Encrypted: i=1; AJvYcCX9gRVUVP3gskuqpzWUw7FsCkJWIKMI4TozQN2IYmrWTRyF64wTJiZELVU15n843PKL+fxBSOYum8iWw+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkbi2ECIGZvg8lIDBTPakyBmHIdCBENtarfTrUxdi0M+vtFIs4
	ZturuVsVv4IcDKpBfgnJkxocL9naDcTSBfXU/oP7+09/UnGPlXACU/3S6Hs+mjjANL9UFemIb89
	RqDDu8hD4srVlZQ==
X-Google-Smtp-Source: AGHT+IH49q8FwE/ekxv3FeoZfBKO45/GCZY6ANFvVAwiH31rvsPrQpAAJiadtmnkP06wHNdCbESTk/zdijXtfQ==
X-Received: from qkkh15.prod.google.com ([2002:a05:620a:10af:b0:7e6:4e45:e180])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:57d8:b0:7e6:5f1c:4d78 with SMTP id af79cd13be357-7e66ed5c00fmr119271185a.33.1753817847731;
 Tue, 29 Jul 2025 12:37:27 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:43 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-6-marievic@google.com>
Subject: [PATCH 5/9] drm/xe: Update parameter generator to new signature
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch modifies `xe_pci_live_device_gen_param`
in xe_pci.c to accept an additional `struct kunit *test`
argument.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 drivers/gpu/drm/xe/tests/xe_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
index 1d3e2e50c355..62c016e84227 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci.c
+++ b/drivers/gpu/drm/xe/tests/xe_pci.c
@@ -129,7 +129,7 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_fake_device_init);
  * Return: pointer to the next &struct xe_device ready to be used as a parameter
  *         or NULL if there are no more Xe devices on the system.
  */
-const void *xe_pci_live_device_gen_param(const void *prev, char *desc)
+const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc)
 {
 	const struct xe_device *xe = prev;
 	struct device *dev = xe ? xe->drm.dev : NULL;
-- 
2.50.1.552.g942d659e1b-goog


