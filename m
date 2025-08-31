Return-Path: <linux-kernel+bounces-793201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA48B3D048
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 02:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EDB1A80DC2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937B1853;
	Sun, 31 Aug 2025 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl7twUDf"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D45639
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756599172; cv=none; b=clKzqePLWDPSSz7HB8DUdNgi/+g5JsZ/+T3ipTeLkol6rOyK/kUziVbxQTRCi2nE6gVF9EIPnA9hFYCsAFMdGB/JVYrMVTxhUpm7hSOVqRi58Wk50d2Ha9MytQE2U/xSFgeJ/NOMPpOR+ZpX6X6Abv+U2kNWBiM9cUWaUxLmLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756599172; c=relaxed/simple;
	bh=0m5UYi3mvkTtM3OKoTfBEdtfguqSSbi5ZJ1TOLMVzM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfuOA5IBulKGlRoaLufPWCXE2Pg1AAcuZV/lR/0IE9P0Jqz4/1uzzD04bo+j2d3OPeoOWsA1iOtGkysUybRGuBXK16ynmESf8+d6CpNwQK8Un74dSViL0lGe5XrFo3IT6xy+Wrs+mXwnbiFkJ9QK8Qh3JszWwlmtdI7SVGEmWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl7twUDf; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e96e9b9baaaso536643276.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756599170; x=1757203970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIpHgZuMEMBIYjGCBCUL23oZ9wiLkUHkgB6ohcFNE1E=;
        b=bl7twUDf3/V6xEJ+AeTCfoiH+c8STdbsjIDybh+z9T8GI1eb312jdf8h/36ZG/5N1Z
         NchdBegYueoDkRfjRfNL27FIi9+fol5tY9J6zZaL0iPddc5IktzIKevY1DmGwdi1JHKW
         lI/oNDBGoZ9fxFJUe813cTV+btCK/uUmDNOxL1E4hOaUJU4QNB6VhRGT2li2O0eFV2Mp
         lZNDYCUfDDTLwD3ZctwU7XKNfi7a03d39LboUTE4r6wyg0SmLBSLL9EbCfSMmYPLQ+HT
         fOCZ03cbVXMy74qzO1xfUKGLxZRcxB6X6RtKHflYvV5fxQitRPMbH9q1msW2dHKqB71s
         wmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756599170; x=1757203970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIpHgZuMEMBIYjGCBCUL23oZ9wiLkUHkgB6ohcFNE1E=;
        b=KkDsAF+pSEMGd83X5c2pHbmdgmI0Zh4uqFfO1Fp+eme/Xj+a/YVZCJK8kBLYUDS3Mz
         h5CIRVPCvBimW9zQDk5j25L7h09qmN4RHk3kSnxJjQKW6X/0S6VNnsqkSYUgaovsl3eX
         Vl+JV7Qs0SYQ8gAeGIZq8YQRIFwMo4RRLaNw9Of2qUCTxFBQV0RHiqNCRdDCRe8Hoyrf
         3MXu/P/7AGLUW/H4nn1orGw5gU8+T/Jv7RFkTFD92lnNo8K5srdbFUZc21b2h2BmTZSM
         2PxiskfveGU6vUdVwslwbiCkFdh+uyaGMYKGvfzzuwueVchQvswFXiLAvcrM+WSiVNtj
         oavg==
X-Forwarded-Encrypted: i=1; AJvYcCWlj4BZaEjS4VkbYEtJr2eLj2yFFYszCHV1vBMvTeaadUluTGwdTZqrtU5l/ZhxkpjNwZsa/QHOp+/QcCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEg1/0etBCk2oEgFw9B1/QaYyoiG0HuWR9Ix5Y+HmozqVHdSu
	eCbZ/nuG3zdc4bM00A3Icn8QALZnHVKZL68TGERZNiPk60jPFlN+JV7p
X-Gm-Gg: ASbGnct+kejzM7LzWsVt8DEfu8AD+dFtnQ8FGJjz5yP+EcrmrfeHE/L3SoxlBOl32pa
	WorDQ9X4iuWGAR/QHiHcOCOnO6qiAoTLC7dO1aG4n5dsAfcDPnjUUkdy2F6JbtMplxzOpKGN2Uh
	z/rR4xxylw6E/pEqlJwDfKbAMkvzyzjuDqSmvAzdLuVg9rQq6q5pRst4N0kKjXHhFea+QINAwcJ
	JNjDTKHT7yTpRS0JabydrXkeXPIWUIu7lS/un/uGgXnIjai8/Mlwrtqxu3OhM49CUGXrbf5SX4U
	rWLgHZAe7ctTZ8sNbQHQzTYKfnUqi70JLMBZnWztKqdqWZLMRPors/i2RlHl7ENccFDQEUg9hiB
	C7SXi/ibQ80c/4/nCPe70IqodZRIvWelLaMF05TaGnCHd5WFA4T7Z4aN9/SuvFUAZrM6u/aFLFS
	GZ1fWhAHTD4YMlLQIaTeb4EM8L
X-Google-Smtp-Source: AGHT+IEB12C1slBWMgDluynqUliRzseU7UeHqm9h/4/nwZXuLSw4J/ZpLk5Mtoh9cu0eTNRdQCHBOA==
X-Received: by 2002:a05:690c:3385:b0:71c:1807:9947 with SMTP id 00721157ae682-7226a3b0062mr44388837b3.5.1756599169700;
        Sat, 30 Aug 2025 17:12:49 -0700 (PDT)
Received: from mamin506-9800x3d.attlocal.net (162-197-212-189.lightspeed.sntcca.sbcglobal.net. [162.197.212.189])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-7227d90301csm4986827b3.62.2025.08.30.17.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 17:12:49 -0700 (PDT)
From: Min Ma <mamin506@gmail.com>
To: lizhi.hou@amd.com
Cc: dri-devel@lists.freedesktop.org,
	jacek.lawrynowicz@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mamin506@gmail.com,
	ogabbay@kernel.org,
	quic_jhugo@quicinc.com
Subject: [PATCH v3] MAINTAINERS: Update Min Ma's email for AMD XDNA driver
Date: Sat, 30 Aug 2025 17:12:28 -0700
Message-ID: <20250831001228.592-1-mamin506@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dc0227cb-7e02-10c6-9790-2e2331ddfd6e@amd.com>
References: <dc0227cb-7e02-10c6-9790-2e2331ddfd6e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I recently left AMD and would like to continue participating in
the review and maintenance of the XDNA driver using my personal
email address.

Signed-off-by: Min Ma <mamin506@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..6eefa494000c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,7 +1231,7 @@ F:	drivers/spi/spi-amd.c
 F:	drivers/spi/spi-amd.h
 
 AMD XDNA DRIVER
-M:	Min Ma <min.ma@amd.com>
+M:	Min Ma <mamin506@gmail.com>
 M:	Lizhi Hou <lizhi.hou@amd.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
-- 
2.43.0


