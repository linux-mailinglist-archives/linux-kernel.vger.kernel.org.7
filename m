Return-Path: <linux-kernel+bounces-870683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E52C0B723
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BF33B8349
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152E3002B5;
	Sun, 26 Oct 2025 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4zCOhnf"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475B3002B3
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520751; cv=none; b=I2/6pX+/2lDAUntt+GQRL4RzN5Lt/crHkq+kDaS0m3HovyzNlIn4Lt8VXwPwG3hK96nhDBzx1xHSFwODx2eAkSHe3cYAN7cHbSMLdUxl1m2fXCdJH9ObRzlE7+7i91eFmlqsevNL9IfdoHr5NsYroSalKb3c30vkWNOutB38DxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520751; c=relaxed/simple;
	bh=/WJ8idmdTVW0xynvaxgMdxuq6tLbTzgU7ly7Ov4QECY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2sgzPCPiujvf6H5X5LECm7GfUu12buhbPCEyzsYExHd6o9Dy9YRkA5MM2tYxMSfD0eiWFscAlCTMBBJlZQaJU1cbvscooyfBigqd22af77pYG+UTS62k7yR8cV1qNCSMGs/sMXa53nLYEDQXfzExgrW7tWJtoDsltsJrhuTLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4zCOhnf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a1603a098eso2284834b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761520749; x=1762125549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+4rHLxk6jb9+WTlkBO1/v2Aj724T4zzmauAn+prGgM=;
        b=k4zCOhnfMWdvMNdATvR+lZrelGH029R91TbJIaNm/js/eKlikY0X3I+psUK5F7TnHF
         n0Fsk2zSa+XbPAyzwx/8b4EeNzLyZ2gzUM2xI6kjszRGhkg8mq1vQl+Ys1miM4waLxpR
         jHQEZmVo3+v9gHWEo2QSLBCNMiDz7sVbMpbB47LKU82dfX7xNEV9aQv9XymSBA4RPPNT
         7lodteKLrVpZxvKmF+6KtR4hw6yXuSfVchGrnJPeGmhv4KnXHgBpJOwz+Zm5mDFls9Pw
         o8SVAVibJ2cwGuuKRv82oev8WzK8GYXrKJz7c1AFwcejzVxrGwtvFPcITTVtqHSVDITr
         453A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761520749; x=1762125549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+4rHLxk6jb9+WTlkBO1/v2Aj724T4zzmauAn+prGgM=;
        b=eHZBH/HXLVWtuDEo5AYh4FmZvF//Q85DVl1M8sykqFd1g+o7CZ8s0AuptKGLk2CWWs
         whOE4LqmlWg/2hY1uqXAfV7ap8BniC/iVv79y1u9JGlQhbkn44zGYO+u65O3Ua6+RNVN
         uuZRMGQOWTosYQUFmESxxa1CT1kd1NC5BW9SgcOujffFsoTy7YWaLb/9/zTVQm4vAzLy
         xxLhhun2MGP09pwAWgnFi26/fRg1X/1T6c9XlpqGNp8WsBH8m2POWBpnbnfbvvRwqAL0
         Iwa2xXKRgLmHTFSTb0n1lz4hywE7jXp/QLjOxs3CzWXzJdEqIDZj0UBmQkqxxwmk3T2C
         ThRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjfoxZj8ZcZCDQ9fcqH8C3mOy4CJPW6mzwn0ZpRbqIv9BV+sU+gUMWauns6rNWyRGwm3n8oQzStTDyvlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQtHIeW7iQpdQw6TwLy1vYBRXf1YNSiHWxSzYt7PCdYtJ4kcG
	Gr2MVoIDTDQMaeaTDg2BPjY2km28t28airpNuxuj7Gq7KBF6jj4E5I/J
X-Gm-Gg: ASbGncvQq8qOf1Dozd+h17eSrAM59UWvvJb7tLiI0VZ+VDHM0V4j6u7PGjeQol8L1mE
	nwWlWih+kR4VX/wLyCYEwOQ2NMdKKQXHzmOQjG3ED/dE+qd83zb5RR2HsfCEkqIgCxtBZTd7geo
	wU5KJLIhisWsuWU6hzwDuSMe6WAztRD2O7sZcojHpJuDLnAHWwiMmxUmGM9j5TGIDQhhkLA03bI
	IOADZr+o/s4/18izsQXRgS0NlXjSc4WKjQSfxE3sgVmchm2zojo670IdBanaK8qldgNg51Vej6/
	5zy1+z9fblmGwYoMg4tLjG807VGeePh41T9YXX4Bu2LftShKyFix2k1jyVi+VB3PkOT2xeYTTL8
	wvz5ftfH+VDHvzwOioQA6p2w3tqhKmLKJaDE5UKpa/USW6Pq4qD4x7wwem47G8jJ1rzYOazi8d1
	7gNi+MO6Lx5UZl6cQsNI5Khw==
X-Google-Smtp-Source: AGHT+IEN4o7iKPho66M4NW9RdMeb44MBPT3fDS+h+9MUllLBI3rDk+XvZ4kv8Y7LCuF6ZJtVcrt2Nw==
X-Received: by 2002:a05:6a21:33a7:b0:2dc:40f5:3c6c with SMTP id adf61e73a8af0-334a864aa37mr45862799637.54.1761520749111;
        Sun, 26 Oct 2025 16:19:09 -0700 (PDT)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e9571sm6242596a91.9.2025.10.26.16.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 16:19:08 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: pdeschrijver@nvidia.com,
	pgaikwad@nvidia.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com
Cc: linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1] clk: tegra: clk-dfll: scale force_val with coefficient according to whether cg_scale is set
Date: Sun, 26 Oct 2025 16:18:59 -0700
Message-ID: <20251026231859.823231-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

force_val was hard coded to use a coefficient of 128,
regardless of the cg_scale configuration. This should instead match the
DFLL_PARAMS_CG_SCALE bit, use a coefficient of 128 when
cg_scale is set, or 1 when not set.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/clk/tegra/clk-dfll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 22dc29432eff..3362983eedcf 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -882,7 +882,7 @@ static void dfll_set_frequency_request(struct tegra_dfll *td,
 {
 	u32 val = 0;
 	int force_val;
-	int coef = 128; /* FIXME: td->cg_scale? */
+	int coef = td->cg_scale ? 128 : 1;
 
 	force_val = (req->lut_index - td->lut_safe) * coef / td->cg;
 	force_val = clamp(force_val, FORCE_MIN, FORCE_MAX);
-- 
2.51.0


