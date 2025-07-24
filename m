Return-Path: <linux-kernel+bounces-744400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B42B10C60
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895125A6BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B902E54DE;
	Thu, 24 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o06eEJlu"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535472E2F03
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365393; cv=none; b=EwWbpskLK9saMhyVngMZiTRP9gk0xHcki3U9Lf+/gLL5Qii4FZmGxVdQ2k76d2Xi6GJc8ogF7OfeJi5d11qWij+i/yFc2l+x2BeQ+W0rQl1OsBJ8oJT1QAGcYeLgQZMuj/7XWAjE5Zs5pYH2wTacZ7KawUvhK8mi32F3wAQMrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365393; c=relaxed/simple;
	bh=MqHhOcNuXJ5oZB2p2GySncf4wGrMH13kPtoLfjjbjDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo5NhSxmNXlsxNmPEb/w5XUEJZ8N1+mEcmCihpTbw0A5oU9ihh1M85ybEXsx68DJCOy0tOKsvKvPOM+4NqhfvAHgvagLQcX/H3VNJLVECk+92QGy4YpqYnJpoeIbWc4+8fpZGiKec0g/bTAVkqhk3JkjReP0I75pqAM6f69UcLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o06eEJlu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so10697535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365388; x=1753970188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/nDqiXo0oPmiwRgkXmDbqPxo4RR6UizLNSv2BWaLmE=;
        b=o06eEJluMpAq6dy3fOCgn7NAaSzuSdLBhZBZaMD6U2xLGIldpXohgymHLeLK9+xWTN
         9+x0DVM9KcOW0fY4UPa1AaD5nV7oIzwVpF86Ej2cHoXm1zIYpl5+rvdOgT3Nwm//QP27
         byvBAXdS/Fi5AYtUoXybNwolzf07pLMWW2vPPD0u5s2YcKeuBP0MFfJcWjzmtYUZSWbZ
         m7kL2edMOTv0Q7FZaKNHgT8kD4xvBPzICoJsgGAxesIxE7W+mMeflzXYeWut6unLzIP9
         NnwKtQwIthA7zFhcSIuGq9GPzo7rCpXXzNpyZyLhxNRncTKJhsKt2uydcdTkW4BEbf9W
         bZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365388; x=1753970188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/nDqiXo0oPmiwRgkXmDbqPxo4RR6UizLNSv2BWaLmE=;
        b=Owo0lHTo6r9aOF2MBk4v2TLvkKr6MwbK/qGXATUGUC7Im92JJpbRxD+nbTp335lKYH
         CuWm3+6pSEGKzXLDG/JuYvssaDZyS1czIC9f284du3biW34CiIUDTyHhlpjM873Fzpts
         PGA0M3W0vnudiMwsvQbmURjz5jf4qFfqGRlflZ0T5fsVUx8o5k2cWGxR4ykWGkMH0NhM
         8iDbQ75YfO4Vs19uwJIxBfLLvykkvGgofv4aBVMLd+ky7UwPlnugq5TWaNtUf8PiD/Rq
         4TNh1xnx9CTpfvJLJGFBvydKC8N5RUiSEa9suwopfKZGwLoOtcjaN87O2OE84IUPs2kR
         9y7A==
X-Gm-Message-State: AOJu0Yw1B6vP4N3K92lXrly7DwWz3Vu5MRIY6zLD6tFDvaQIy1dUb14h
	LrFgWTlCk5RhXuSF+j7/oo49t3DwLfPqOAbwuwp7sP1XDZ6tYmV7Oi4UMvk1BNoigLr8hGku40C
	PCndarSE=
X-Gm-Gg: ASbGnctwM2v147JeSOEtstQhBWIo1cqXVMvG0vO2e8x4cstEk0Kravb32q5cBMYSdFj
	HalTi8UjYwRMkNPmnwX2hK0SHDNDapbcClKHg1ZcOrSvq8Un47WAyVT4ysmbYD0FBPFzLfeUo8g
	CgpiWYyN4jaO7rLddmRMmamWjHjAsnZKpOAPE7qZWseJIxU2DuL7OfDnlBcM3GdpnjPr4k06YbJ
	xtaJtCV9k6GWMhcr4zYpsaUkf7uPBF8m+CylyuaJBp1Cm2JwwuuLHU4SHSMIRPyk8G/3B33J03O
	1sQpr8rW6QJiVjWlll5+HoVU7E68n6gpGKhfvVTkC16hCCbBPPzoluSxKybgn9IpfsfxKBnqXzL
	DUnzUz2DgGwqenKRrAO68z74JK4jN7WZlZyUbFujJOXsExlTZPcjaChvGrmkxrpveuH7F4lEZIY
	5OonZrJlv8yhO0
X-Google-Smtp-Source: AGHT+IFsfIJWNObH04glJtR4VMihBKDX2X1KMe4027IfQD5dai+xqhfpETfw7nG5oExxx5Qg+IUmng==
X-Received: by 2002:a05:600c:8719:b0:456:2ce8:b341 with SMTP id 5b1f17b1804b1-45868d47860mr71077715e9.17.1753365388431;
        Thu, 24 Jul 2025 06:56:28 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:28 -0700 (PDT)
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
Subject: [RFC][PATCH v2 07/29] init/version: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:50 +0300
Message-ID: <20250724135512.518487-8-eugen.hristev@linaro.org>
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

Annotate vital static information into kmemdump:
 - init_uts_ns
 - linux_banner

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 init/version.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/version.c b/init/version.c
index 94c96f6fbfe6..f5910c027948 100644
--- a/init/version.c
+++ b/init/version.c
@@ -16,6 +16,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/proc_ns.h>
+#include <linux/kmemdump.h>
 
 static int __init early_hostname(char *arg)
 {
@@ -51,4 +52,7 @@ const char linux_banner[] __weak;
 
 #include "version-timestamp.c"
 
+KMEMDUMP_VAR_CORE(init_uts_ns, sizeof(init_uts_ns));
+KMEMDUMP_VAR_CORE(linux_banner, sizeof(linux_banner));
+
 EXPORT_SYMBOL_GPL(init_uts_ns);
-- 
2.43.0


