Return-Path: <linux-kernel+bounces-869553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78879C0826C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE97C3B7C52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F732FE599;
	Fri, 24 Oct 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgfNfEVO"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C402FFDD8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339946; cv=none; b=ZltSyMJ+90dGpa76zfBW2cKX8IdxcBDB1Dnze23Qz0d90yPVuQcUGdpdAgQy60PJE/zHgBLC0swJm9k034v/PTrgZWYpvhrocZOEiZ32nK6FK0nIT3z4eP5j/58IkZ6QgGfub8bVu6Lu4oYUMEPD9QqJN048IvXdLeCXiWz39kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339946; c=relaxed/simple;
	bh=Sk7FXCfhyYx52fhTC+oVdW7154ngTvS7Nom9mMmbUho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nsJ9GMSYvDg5WxoIWJgz4kk1pw47vgR+5rz8xrsxKrTzgippHpOaXNzNzXRldiNaNW5W5aNUTVRPwv0ueZjqqUyzTeoK3r2p0LCd7ukMbjMvLPzn4SL966PKCsSOTE0ZGTPXldICjKiz/Gs15ZTFXLmrmQmxLSUPC32r8XelZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HgfNfEVO; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47113dcc15dso14236445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761339943; x=1761944743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cr+Cy44AYBoCkgjbDfs6NtFid05XxsG/awplIO2CaC8=;
        b=HgfNfEVOKS3swW31oFAEB+QbtFIFSmrcxscl6XXwLSw7wbz09kksKJuLVBe9EQZhzl
         a7uVbk6JmxCO8h9pFJsdGa0yK5F3BujtAF5v9orQGMI90tPY+8mfpRLj3iFYq4Srh42h
         JyUuMxZ1CElkT8yyH2UxwtetFA453Ss8+0CZjbbfgvF9kYn1mB0s9zUpiPed9bthWZLx
         bsj5pN3WsicvO7n56tVuKmdDXCyGWEeDQFZ4yxwq9UTL3enEcls40vmQABub82xIhpfP
         m2Zi5sNnFrvfqV8ifhPan/36EK6ruUPorOI0nWFWaXq7ZcJQFWNv0Ti9dym/UlwX0+py
         QDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339943; x=1761944743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr+Cy44AYBoCkgjbDfs6NtFid05XxsG/awplIO2CaC8=;
        b=RcwH+ARL7Vjwd98ETFGGDjTRaRNdaYpW2ppCBBIfnlIaUlWV87eok2KJgr6vJ6D4xi
         /N4+MGIiVttVwhAjpJT3QA20zv3DUG6HTVaQHSocREh9G6/ais5QNBaDualfDQ2cTCX8
         rCrXdd32i1tN+bjC7P8ImluBW/tS1WbGDln6ufUuQFs/ckvNvbbXPd3lprAo+7SS9TSs
         8e+rERHt7Gq+M+z274eQAvd3Pngn6iS9ICYRVsUM2v0QheIo+0NGTOFPnLXqKtEqGunR
         0kiQSB23xt6+6JbMnGRXzCIyhUQwW4xK/Jufiu6IR2K3VOncri9NPk0wQq1E4YlwDOnO
         vqCg==
X-Forwarded-Encrypted: i=1; AJvYcCUj8wXTHJGT68k6Dt1f7vVkt7pnm6tTcqJ342Mly4TdCqaZ1VWmDNllH2cIODyig7nWme5OKgA4sGzFIQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGIkUt/S4FB+vr7lQQmf5TzLTV8Lz5/q66Mpxi03n6Y+v71vj
	91GWsvfwqaDaI1hyZtAduzOwyG8sNojRHOll58hZ8y/7BeUIOGAbWVHebiMxTkn9Z21kJFmGRD8
	4rQiX+ZcLOHx3iuMP6ngODA==
X-Google-Smtp-Source: AGHT+IE0VF5/lk9M0gB+9FwFwSpgfvP2xoVnB0QJD8xhVyJZbghsyqA7z63NaA5pNd/HN1prAz26F2QKnP+cnxCu
X-Received: from wmwr4.prod.google.com ([2002:a05:600d:8384:b0:46e:3d73:fc5f])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b0c:b0:471:58f:601f with SMTP id 5b1f17b1804b1-47117912389mr234934035e9.30.1761339943347;
 Fri, 24 Oct 2025 14:05:43 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:05:17 +0200
In-Reply-To: <20251024210518.2126504-1-mclapinski@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024210518.2126504-5-mclapinski@google.com>
Subject: [PATCH v3 4/5] dax: add PROBE_PREFER_ASYNCHRONOUS to the hmem drivers
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/hmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index c18451a37e4f..5a6d99d90f77 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -45,6 +45,7 @@ static struct platform_driver dax_hmem_driver = {
 	.probe = dax_hmem_probe,
 	.driver = {
 		.name = "hmem",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
@@ -131,6 +132,7 @@ static struct platform_driver dax_hmem_platform_driver = {
 	.probe = dax_hmem_platform_probe,
 	.driver = {
 		.name = "hmem_platform",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.51.1.821.gb6fe4d2222-goog


