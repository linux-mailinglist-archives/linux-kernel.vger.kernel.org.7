Return-Path: <linux-kernel+bounces-775498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB56BB2BFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FE81BA860B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7361326D79;
	Tue, 19 Aug 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgNIohIh"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8249432254C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601706; cv=none; b=QQkXH19XIP759qHHgPxtfWwZgwZisyAs9Gh1Wm8O3KRGqHh+gBLZkWYEHGve6IF+mO0Q9G8bSW6s0ZQEcMYuQrcyMvVtrNvoITzHoO/U4DCCYpMj/PptlU2Oo7jLpEsal3H6WvwENa5EA8QJEScVXOL0oIhze1aiNDdzmzrXzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601706; c=relaxed/simple;
	bh=FDAp9yWzU6h2a01wyYHSgRU7k3MWfcA551Cze90JEG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0HFyJiR+UzUN0WTB/YPg0D0bHvyNitov/PHD9Ah/91Nh57GJAVlme8NhHiaWcSPDmCQOZJkRmycjtMC/1Q6slb/dSRXen2TDOzjWloDaUitrK0ZtBHSL9RIEF/Z6nGZbxT6lDZRLdvJP5UlrPU9uf+JkSyBxXgKhyjE4SBlbuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xgNIohIh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso734848166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755601702; x=1756206502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqqWuSSSaSs4/5B548uIsqcez7udu8s/zMuVb9X/jRU=;
        b=xgNIohIh+9ndLl+Wl3N64y7YH3Y3/TbI6SrWuwMwHho3k1uclPbHPkdkgYXlY07cx4
         aVj81yWjAvTcHifWJhiCuwG+pOIrvKqJlGafSTHGNQ+QMUcDkplpkA4aWViStPOphzxc
         tbgmkM4Lj76BXLd1qfmcFLD36Wa+dB7vc7/mBc+Kep4vnnl+u9pCEPn+c46aggRcKYbp
         vAil5mOJ+bURC4uL6ke2DasKa8YTwLpTa6shm+8g6HxvihtpESUNlHy8ZZ3rl84sfL/Y
         dMcIg+29Z4Gu0oV2/PjqEx67ZSaG4WA/jTHrpO/0j4RcyqIxYE8AqsRxrfB8BsTcECFA
         6ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601702; x=1756206502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqqWuSSSaSs4/5B548uIsqcez7udu8s/zMuVb9X/jRU=;
        b=MZzbWu7lnl8L8CywZQC/hnvXPilkhGcuNlyBWILaXLofYssC/gd4256J/6mvzLykEl
         kU4kw5wp5u4NYbgIaLN46pzyAAFAkz9P1pMa/VEmV6p3ZUjFfY5D7DlCzFy77oBXL0tv
         hitdQtTcBvEYU3qlPdnwiysxBkiZGo3YKRgvf2a49mBGW9+Oiit1J8njlGGiCv/M/xsz
         gtmXMv4mCEF98e2LDP9bxwH0kqwFDyRJbt3qCHv5ogV02M4dreSeD+U7Ugj2/ZDSBOt3
         yhEK1t0v/x1QF1oth6NSFHovpEG+UKFa21zAtjnxXfxfbk1CbAdpovrRN3mWQXvdTZdu
         5lfg==
X-Forwarded-Encrypted: i=1; AJvYcCWHco1emXEqZuemyziOlsMpwl60S7KEq/tNzESrCk6SXdgt5Cl0hPGBQFeIV89rdTf0rbqNsfLerNcvjy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8p/dn6ncpu6kjgWgf6MoQ7fh5L150HzCDTttns+Y7FNsa1YV
	+w0e4JpAoW1VjDdhCGm5GOvPgo94PDYjBjY3LbAwkFB0DfnKi0zG8UHoek6rnrUw2O4ivE2nfOG
	QVL8L
X-Gm-Gg: ASbGncvF8erVYXulu1bdXWa0kRDjjUJrDjg2KFJWeUrQjJjKg+Fds3vShgx0RGoMxmh
	O3uu3HE/AoBglS1m91oWNifv+QFs+aq/eU1wIlg1FHiGsOkXL14WKtoZt6iGm4PBSzB6E2npIhb
	CRG6MAO/yzCeiY5lPZRmtbpnvjTXLJLWhcZXC/igteOWp80bt5QD0fEnJJVwLeJhUfrUYQ+QQMb
	80FejqHxtLDtpQSZTZEIFl3PozsEgj7Y2KkLFoMny/W8ygkmEZYvbU9yDG+V+2u4GDEkDkHEWbc
	JrjOzG0I38zBDVv+UMoHXDjD7n0ALIL0UlKKsQZ/ZmXg+EbxAyvYA8dLIbJIyqxqQiRQKrJDJvE
	PgC5Gfiqa4z1/SSDMBYeHamxfatZlhgyxi1+eZpSu8XIHv31L
X-Google-Smtp-Source: AGHT+IEu47SOpD2q0+bOP6DYIa6GuWe1e9d5W3TXltO+50fVmPfaG/a5eVbK0rgp24zmwdwtvRU6Hg==
X-Received: by 2002:a17:907:3e10:b0:afd:d9e4:51e9 with SMTP id a640c23a62f3a-afddd24e9d1mr167513266b.65.1755601701738;
        Tue, 19 Aug 2025 04:08:21 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:db5f:8096:4609:9b24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01096csm974845466b.88.2025.08.19.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:08:21 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 19 Aug 2025 13:08:02 +0200
Subject: [PATCH 1/3] remoteproc: qcom_q6v5: Avoid disabling handover IRQ
 twice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-rproc-qcom-q6v5-fixes-v1-1-de92198f23c7@linaro.org>
References: <20250819-rproc-qcom-q6v5-fixes-v1-0-de92198f23c7@linaro.org>
In-Reply-To: <20250819-rproc-qcom-q6v5-fixes-v1-0-de92198f23c7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2

enable_irq() and disable_irq() are reference counted, so we must make sure
that each enable_irq() is always paired with a single disable_irq(). If we
call disable_irq() twice followed by just a single enable_irq(), the IRQ
will remain disabled forever.

For the error handling path in qcom_q6v5_wait_for_start(), disable_irq()
will end up being called twice, because disable_irq() also happens in
qcom_q6v5_unprepare() when rolling back the call to qcom_q6v5_prepare().

Fix this by dropping disable_irq() in qcom_q6v5_wait_for_start(). Since
qcom_q6v5_prepare() is the function that calls enable_irq(), it makes more
sense to have the rollback handled always by qcom_q6v5_unprepare().

Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource handling")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/remoteproc/qcom_q6v5.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 4ee5e67a9f03f5f766f04396b9a3e45f77293764..769c6d6d6a731672eca9f960b05c68f6d4d77af2 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -156,9 +156,6 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
 	int ret;
 
 	ret = wait_for_completion_timeout(&q6v5->start_done, timeout);
-	if (!ret)
-		disable_irq(q6v5->handover_irq);
-
 	return !ret ? -ETIMEDOUT : 0;
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);

-- 
2.50.1


