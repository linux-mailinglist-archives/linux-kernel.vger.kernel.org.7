Return-Path: <linux-kernel+bounces-798487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01DFB41EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824DF1752C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F42E6105;
	Wed,  3 Sep 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9e+XDHj"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE72DE70B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901887; cv=none; b=ZEOUz8oANQOxhdaBhQ+qHLHRGGVZy1U8sw64R2Qi8ziH0SWh8mqzelJOIIDnHq/7woaxSTvPgZkFn5ik97cFre/fKz2e0NFtMsCTEosGrxTVHeBnV5eoMnQPYZTbbBq4R/DpwPxdZl/2Cr/2fzuiK/ocTeJ7eucO+79NwVSLhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901887; c=relaxed/simple;
	bh=95OBpDFjrMZLWP7l6nQotjdku8KnlWrTHo+gw7ZdET4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvrxrYSLWXSMLUNjAckRGka0ZS8mlg/TYtqfEGuXgZ/WzDOAcJFuQCDlNankf2SfKSrHzvXCHtrbFi9h062JibLylZQH5dL0HiLJ27VIsAa4UbzxdUxGsBmT0zF2Od0D6G89bTdLXPaD+wZhzodMHAciNHMlvaZ2ktGqhs4Ry/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9e+XDHj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77238a3101fso2844850b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901886; x=1757506686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AgtFd2zd49CBSr/rWNwpzPccn2qZ7bpb6f3yzM2Jf8c=;
        b=B9e+XDHjC+YAlsFZc8Bp+IYcjMu+kfcRpB5UO6StZfZtVim5ukFOrso50E3KcvrMzc
         +5VUJzi4K6NStuWs5QUHo7pAr+O+wDRCtyelQsptQ+YLfvsNjUXPKlmJdVa4/wb8gbXC
         Fn61PBIw4yK++5OvPUv45xDncPcsMlnLvyYhWRN+pR5gxyENlCK/1y2RUD60bs7sijc0
         z03v8RRHfZbC0eyQLRP2+duP9nVZETXTqFXdw3FrZtsu/aiQwwIJyMYfyMOhDNEJTbqR
         7YlAiPke/NEKmcVt5ViOs9WJbrHrdGOGdEfgxQhLM53M7TQfSDleAi1iVSd0lp9abuF9
         EulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901886; x=1757506686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgtFd2zd49CBSr/rWNwpzPccn2qZ7bpb6f3yzM2Jf8c=;
        b=LoSdJTJ7aLR22GQ9LuvKQ/yujM63/URduQhEC2VlimxQtIZcppXaYBCWwzP14B/q9o
         0j95a8MQHNlAcrDeDyfhhRTLeB/JD5Y08m3DiDYqsztkYA3vo2MpOHMTuV9eLWosnnJC
         q8GQ9eJdeOuWZtKA+UZ/bmPNjQDMw7k2TibwkNx6n1epKEs4um43ibs7RPhBM+F86HHb
         N9uUrcUL/aRj6SfFOG57pK4oU7x95vVqGbiuSva8LgQUS1zDy2QsI4UNulfLcoh0DuAB
         l4HBAhehnL70CRrHDo8Efuwpz+3Sa9ihQCc3BnFF19cNPXRGH2A34Fv3w+p5TNbT04Tz
         BqTA==
X-Forwarded-Encrypted: i=1; AJvYcCWQV5B9jaiokLB6eO0Mv6xHhCdDVrPVUsVNtR7cuouiUT7haXDX/04S8ah56wsE8I7BxWDul1HOvNtMGJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5C6korILPL69Wh6m4eIJKlu8Z4R845nNxAMoqoAnUQkd+tqRk
	k+9B7/iygBFV3wdxGI15IXi0KdyLIQmN9S2ql/iV/ZRJQH2nhIwaBwSL
X-Gm-Gg: ASbGncu3Z3eM4HDHnoPPuFlzX2jCDDB1Ol1VYbKhjd+vv0fpg95RPxSsudioECgkKsx
	8pHXidMwPriVqYaH3UK9zuVKuG9whU6ieqqcMdGKG9O/k5e0GAZGqgkUegSFgv0QHSkCgWjGxPx
	QYWxD9f/6FyBGX6nKoZJEjuThDCHoz9/GYDd8hNvmk8czCYxxfn4yuPucfA2HBc8FP7Ot7BT4L9
	zfMcIQ20Ox/StbNYgL6rjiPwGACcdAY+IF5yGXbTmAz2MHvVltUlNCsWvCSs+QgiKG9VTpc16mm
	lJshBvqNzhCriuvJPXQefFpTGW1BQD2YQxQCGHQc67ioNVmi0c1jAffoXlm+rjnkFGjesohziyV
	qmOf6RMSA4miG+Ctjxh2VuDHtvkgSEEN7GqfI
X-Google-Smtp-Source: AGHT+IHXlQs3naooWGZvpcsO/wbHJ5kA1brIeIBq6OMurJmwLCXCEAjzel1TdBQ14vLml2G96C56Lw==
X-Received: by 2002:a05:6a20:938c:b0:249:d3d:a508 with SMTP id adf61e73a8af0-2490d3e1f8emr1791836637.57.1756901885674;
        Wed, 03 Sep 2025 05:18:05 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725ad1e9afsm9061010b3a.11.2025.09.03.05.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:18:05 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] mtd: sm_ftl: replace strncpy with memcpy
Date: Wed,  3 Sep 2025 17:47:46 +0530
Message-ID: <20250903121746.2527046-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strncpy with memcpy in sm_attr_show and explicitly add a NUL
terminator after the copy. This aligns with current kernel best practices
as strncpy is deprecated for such use, as explained in
Documentation/process/deprecated.rst. This change does not alter the
functionality or introduce any behavioral changes.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/mtd/sm_ftl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index abc7b186353f..575e137ce8f3 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -44,7 +44,8 @@ static ssize_t sm_attr_show(struct device *dev, struct device_attribute *attr,
 	struct sm_sysfs_attribute *sm_attr =
 		container_of(attr, struct sm_sysfs_attribute, dev_attr);
 
-	strncpy(buf, sm_attr->data, sm_attr->len);
+	memcpy(buf, sm_attr->data, sm_attr->len);
+	buf[sm_attr->len] = '\0';
 	return sm_attr->len;
 }
 
-- 
2.43.0


