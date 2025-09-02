Return-Path: <linux-kernel+bounces-795630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25EFB3F593
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3181A861B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492562E54D6;
	Tue,  2 Sep 2025 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OW+QmvWd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F672E3B11
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794823; cv=none; b=dHiTOqYfnO6rx8tpDlR1COZY4pKlxoH9NnIc8Y0P9KtC3jCW9jTMvrqyYGKQJ0Ex62y+r8NWCXiu7R+WiOnRPAHZ8PztBFCRoOXwZiJP6c3hIpiFY1CxgyxGuHf4n900qf9/6HuyUnQE7q91ksBt/Rf9Ze79fzSTKfJsZvtVJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794823; c=relaxed/simple;
	bh=MKo8n/x52MPOw7BrUfoyfV5mi9Zpix6Gd7w11RHjJxo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cgilO481htm6EX8X3WYtxm2yt2XeWc2uP80AhKltAadostUJYL6XIS/Wzt86VPEdaAsQNE0K0cKwDleu1zF6qVUKLLgUJgjQmQ5OOw3t2wS+FHvdzHGtpj7jEpjrE7MPiKfWbhiwiCvi4RbCKE5xiT1yjwzGWx/mEqkw8JNuJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OW+QmvWd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b8b2712d8so20865785e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756794820; x=1757399620; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=losT/kfGGLPsjGybv1p41hnyyy7EMl3u0Mtb0w2e7UQ=;
        b=OW+QmvWdPyijoDUNn/b6n9Ok/x3duEO0BLJ+bq6MsDq4cZuhp8QIIBqWuafnw6jumn
         mkuk5CZ1/MedVVi/YehIWBuEwKsrGWfG826AW460YFbgVI9MTT7xBJgAkNBadJCeLPgI
         8rsol1Q8JADindc25txhwyLzc7X0GSJFU3PTU5SDyKaFLJjM8lX7G8RbI946QOFGdMvP
         5QabQ2NmU4nilDM17n35MyVLjsJ5NxQws/+FV/2wOQkoaSBGnsk3BJ7G6OrKiweQjZiT
         BALBeJN4oZCvCN9Ayq//rtMh57PatRxSoptS05nE1D88A8oevznx8cvt4JyI1+8GpbLW
         ZYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794820; x=1757399620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=losT/kfGGLPsjGybv1p41hnyyy7EMl3u0Mtb0w2e7UQ=;
        b=Fb37xiN00uxD1t4QzZay8AJ8XYkHwel6XjmZkBwXGKB+IofN0FQZVeVmoXymz8mhID
         j3bHlIg0WOnefTyAC3bDnqHNv/ytOPlnABq/bxVbgfJmWOUfJUoM1L+PQrTuptjmXobH
         +lkU2UOe+3+79XAu7B0H9EukbpEYIJCFJ2bsQS2KZNVTtDtILCiyYwXAKC+UjoQ2YNSk
         Gi+Y3enAX4Mfg8s61kNiohxAk8A3T9rK4en03kuF148EM/FD8gc/d4jE30moaA/BMFWJ
         0/RbM1ah/LLtcB2p9Z50LpZdFeZ0lSIsoblxuSDptbFuXnJGRKc/4v59bVZrYXI/K6i+
         J0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUJGRPZ6SNK77bTnTq7jsluFBM7R4N0IOEZP54eBZ/XlYGP5CMp2FTKpUP2gsmDuLYHey8wsI82E+F3P7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqALQphebuqXEUPc7IpcNxpNrj0fjbv+Y/OnuFIF1T9E3OajR
	0Lq1eH61i0Vs3V7meI/x3GyT90eDKZrCy9juGDp4nAqSy5Vu4efo67jlbAcaSPjRyKA=
X-Gm-Gg: ASbGncuU4jDVPsQDFBooMeY95wU8Eoi/z/e7iDW2a5ipbwZTnU77WPnN7eMs+TbJmaK
	Eg+1zxdMbpa+NGzy5noFPxnqi25gWP3oabxqq0osLJGhtDKpW2v++0x4Vd6n7VJuEYTVnEj6YI9
	MpHVeNqNC6FhpJhNmUq+xbuZtdI7F2/P1Qe7p11+r2hVXFs9wvAiCaEMIvxYteT5vKnPZZb9A6t
	s8QM3Zl/CTSi0Kh207qtushGGq1+zznEhUJWQNZIWC1Z2XQYVmy0YPlWQ+DOI0N9sm0NOLqcEF6
	15fWjPy37JQ1JYMOywWCJmgqi5y1CgKtLUgK98AbXAg2gEizQ5MYCfnijHKqBBuTszf1Uzp8W0G
	E7HlcoPf/lIEL6nwcYCe38b7R2sSFAEo0ytXEZA==
X-Google-Smtp-Source: AGHT+IGTC4jvhc5wtr9AKkKmGa0tiEpKXwEYpezAIz5zGfXKE+mLDpBMK8tQiURoKbOUDB0H5J7XFg==
X-Received: by 2002:a05:600c:4fc1:b0:45b:6163:c031 with SMTP id 5b1f17b1804b1-45b9353ed8dmr24223305e9.24.1756794820456;
        Mon, 01 Sep 2025 23:33:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm265828005e9.1.2025.09.01.23.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:33:40 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:33:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] clk: qcom: common: Fix NULL vs IS_ERR() check in
 qcom_cc_icc_register()
Message-ID: <aLaPwL2gFS85WsfD@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_clk_hw_get_clk() function doesn't return NULL, it returns error
pointers.  Update the checking to match.

Fixes: 8737ec830ee3 ("clk: qcom: common: Add interconnect clocks support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/clk/qcom/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 37c3008e6c1b..121591886774 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -277,8 +277,8 @@ static int qcom_cc_icc_register(struct device *dev,
 		icd[i].slave_id = desc->icc_hws[i].slave_id;
 		hws = &desc->clks[desc->icc_hws[i].clk_id]->hw;
 		icd[i].clk = devm_clk_hw_get_clk(dev, hws, "icc");
-		if (!icd[i].clk)
-			return dev_err_probe(dev, -ENOENT,
+		if (IS_ERR(icd[i].clk))
+			return dev_err_probe(dev, PTR_ERR(icd[i].clk),
 					     "(%d) clock entry is null\n", i);
 		icd[i].name = clk_hw_get_name(hws);
 	}
-- 
2.47.2


