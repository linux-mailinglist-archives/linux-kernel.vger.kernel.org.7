Return-Path: <linux-kernel+bounces-737363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B680B0AB5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D2F5A57F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DA121D5B0;
	Fri, 18 Jul 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqHNJFJn"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE3C2C9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873765; cv=none; b=axXcO3B1QELmv8dsz+211O5eR8V8L4SIdeHpTdQEerKfO7TL+8hJtzlxdRaMR9U/sX6GquO3jIQ0nus+ihVFicMMfYMgtYvMQ61mnWb7bx80+dQNeRfFh0A8FJ5o/h4TeBXAh7Sn3esD8NHi+t6T1kdsushj7SqLFk0fSC+kIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873765; c=relaxed/simple;
	bh=tSTrgPIpnpGNk9NG4NpmpQ1B9Z+0uOo8Jk7BbP98nVo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mlc+8fvqRxVz+iGA4Xhvi8RqR5VYuCVoaJqcb/5xM7Xvo5tfNZSKqK736ETIX/avoWzDcAw8F1tOihjz/RdlIkrbUvfw5I/4SN/OyUFACzaBtVTQnuMX4OeLBVLucoiVcXDX2NBWgcEMh6DSWjybzhLpB+W7saW3+GUinJDyoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqHNJFJn; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-401c43671ecso1322154b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752873762; x=1753478562; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsvoKg06SgJJI9+VuR9QTODLjTqy09owpIVoI3UQeUs=;
        b=lqHNJFJnIAE/xDx7uJU9Te8OTDiojxRoiHqh5sQqne6FMIGj9JT8bOX4dH2Z1vvYdI
         GT/UVGi6zELgO9GJBP3+5XW8Jv08Z8hEWe0M5Lu4GPs/tKGRyGjraT2nGp48slJzRANA
         yf1ygijYkx6MqPVSWeDzV3Lkel0ZImZSqDdw7Ins5DjAtLEC2o3oJkNPbl9t7X2DuKa/
         B8ErO+Rv/uNw7/v1kiG4HgbwqQd94FejR6lwphwlJCkONVnd9yfo7RNSxzilxOIc/NWx
         wUPL+9ZKWgSKXbs384qiIs1MOXL3lU79gTQkm5Cxana/lCbq6JcVp6iJGo1haPXPmjin
         xz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873762; x=1753478562;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsvoKg06SgJJI9+VuR9QTODLjTqy09owpIVoI3UQeUs=;
        b=SDDs2/V9pFh2Phywz3zNhEvw4qvdWjz3evuQxtik53xKLGCI/oOjK6nxP+oZI6wHUL
         dcBlJl9P5FTeSOBeBX965NlaeR9v3SNqOHFQWVEN/BuAlp08ZGvqrB6HIXMXlG6p2m8v
         TUlFU9Z06qExTs6/UOtASGpqP4uaErsbOI+0+BaozQ2Kt/cDbZW/XgI57f71h9UU/U6L
         W9VMdMVDlcaXzzmvZwP5FbRLgx87oqglSw8HMht6smwR2ySpB1q4EfraNEZLmJs5E45J
         GbhZmMAWGmuzRAb8tpBveaUKxgBdgJmfa/W7GaFenq8+LMrHRFEVIZzxltlAFTzPD93a
         TXBw==
X-Forwarded-Encrypted: i=1; AJvYcCVwlwIDbCSy5fDe2KAHdiMacitxU+DIfxwxKun31TGyqGDM3zXAsoHPsW2sn7fT5BzG+hz4tGJp161d6E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzAeAm9r7ESe4qPI3izKzmA44TKBbCWNMaNrWAl4SQ7VGCG1H
	xqChLZvE9cAnWEHodLbCKAAqXfG8U2baDLZ2Tt+TKFwgfopqguS+Wh79AgajVr9ddhY=
X-Gm-Gg: ASbGncsCpGxHPFNcxaCm7jkuR66+ktMbyfUI1N76JSgyilKuYFTXGye5UAL8MrLQZcT
	jxkCr/aNzxxwtcRuMnHg/hO94yefuE7LNGYQeR+Sq6B5Zewj7Yr80skcQULBSYi8K2U83FpM1JN
	uZEdIpInkUOBCcCHw2ROoCHxLi9eFIQ8QKe2vVX5Lzg5wt4Zb6HdUWJrtOnNeDRTwZtzzWzu/w9
	GoamD9XJ8dq+ulc9K4vMOKyHRqPEimVpO6fRFbE2rFdWJ50c1MltSYJVPs0p0lgw62QXMK4yX1b
	udGR/Y/+th6449MJ+eMoIu91Yilkw4ufxi/VjdPSI+HdVwzZLpRh4FnBjvhU79+Q3poMEjZz3Y4
	0rRzULz2TwU4=
X-Google-Smtp-Source: AGHT+IGh7lU3JyUSFdh98iTvsA+uq1G9ywwnUkqJkNKmpyQmKR/YnU9/CQLlNROcG3cTeKKCoijI1Q==
X-Received: by 2002:a05:6808:2388:b0:406:6aa1:38d9 with SMTP id 5614622812f47-41e2ee52148mr6250832b6e.13.1752873762342;
        Fri, 18 Jul 2025 14:22:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd10c0ea6sm751747b6e.1.2025.07.18.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:22:41 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:22:40 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Robert Richter <rrichter@amd.com>, Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] cxl/region: Fix an ERR_PTR() vs NULL bug
Message-ID: <7def7da0-326a-410d-8c92-718c8963c0a2@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The __cxl_decoder_detach() function is expected to return NULL on error
but this error path accidentally returns an error pointer.  It could
potentially lead to an error pointer dereference in the caller.  Change
it to return NULL.

Fixes: b3a88225519c ("cxl/region: Consolidate cxl_decoder_kill_region() and cxl_region_detach()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f0765a0af845..71cc42d05248 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2108,7 +2108,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 		if (pos >= p->interleave_ways) {
 			dev_dbg(&cxlr->dev, "position %d out of range %d\n",
 				pos, p->interleave_ways);
-			return ERR_PTR(-ENXIO);
+			return NULL;
 		}
 
 		if (!p->targets[pos])
-- 
2.47.2


