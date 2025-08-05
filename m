Return-Path: <linux-kernel+bounces-755860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 171E9B1AC99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 05:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0368189E0A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263E1B4231;
	Tue,  5 Aug 2025 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZHG82RV"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F72E3718;
	Tue,  5 Aug 2025 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754363053; cv=none; b=p3zexM6Arj40h5rbQ8J9YT4E3SWoShwSF3F8QtYULPYkGE+cZOdM9v17+mgksqO24bQ/YwLSG0MS9QON+Awgrv+5qIY4kmIaQFdRdfUtlVTCemIPmJYsgrTC4qXtBJvjatVAPOSC2YEEYF38bOEX0MnOtxgZO+zCGkXVRuDlREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754363053; c=relaxed/simple;
	bh=BqdNBpG7MRSHoagxQMNQO/b0wQXl5lfiA0CX//y9AUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HRF+UuDSHA5OOfimhBLUdJXgjsiIYTMkdvQfE/5Hkcve/Fjqd6U/t11ulhXuoGnLYre8HSjom8YmkftErHbMI6n8FBmE+6EY5XNBNFBDY5dEkIfwHFu0bsqJz78lZQvYhRTqv/c1Mg1wKKH2AjYopsmX57PxD21zo+4sxHyjA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZHG82RV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2401b855980so37956815ad.1;
        Mon, 04 Aug 2025 20:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754363052; x=1754967852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwKF8zU5dP+B8D7+Ra6l9PAIkPkCoCFD7l4115nJcKw=;
        b=kZHG82RVRkoZvkiO+8SwTv+zJSW235Q9EQoMVLS3JCULmSMAbGu3i+YOIwD7DnHr3J
         K+PgdAShefs8kUtUZCe6T5pBw7RsGnkjMF0uube/oJQxUx8GC4BzBMex/pmT2keTEa9M
         IoVd2PYCbGBYz+YDbmTykuOHoswlrEytDKQOmCORX81uOW2XjHnYCWfAlsAK0fGgQtLG
         DINL3pWs5ayGq+aunB6laOUcbvDMr2XF6VFFtA9fnOsdS/quYGieUXvZC3vHE4y+c+PT
         1lr4Jq3gYXlsGpSNgzj/qP6A2w8//P7rWN5x0qID52F2R/sHZl6VP0N1uG6Dy5A8yYOs
         wmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754363052; x=1754967852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwKF8zU5dP+B8D7+Ra6l9PAIkPkCoCFD7l4115nJcKw=;
        b=T7YM1MysyRUUiDBfV4BDq2hG3uIiiT356xD+jlwxU3JrzHpz4rjui28Pqmc+Zd8RxW
         p2aMiq92aMre+cD/GjNjCCSbkKGazqReuTtB4c3mekJAfThqUQPqWOQi9tbJI4itGRGD
         uiGZG6F9ejmTf9tlZ092sFPDznqLuXJzmwCi73nBFVnG1qXh8ZP8j8xzlZVNpJW3bWUb
         ET4a1k1Um9v15bmusOqTpTgn53140/ipRs9yMKSp5CZ9gLKgv5e+jLkcW7brX+ZcRGTo
         hWJszLJn94JVrRSG2ZvU0axirrvQyuLcJ6cjtMo/2PsVaxXqAWlQV976pTTuSVk6/1gk
         5zDw==
X-Forwarded-Encrypted: i=1; AJvYcCVKdUgcZZCESrYIdeR65oCyna9IEHOneQBn2pmg8rabIcXPDoEt3m8GHmPB9itL9DTXz73GL6qyD4+d7E29@vger.kernel.org, AJvYcCWdtaGOkwLFTjb54pEaGCYKz/FutGVw7kKQIm/mkIrzHO1Wnd8QkZ1em9Fj92MeONKomctQZJ5Lqgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSxUTLez2EsS4RtV//34xt6DpvA9mvT5IRwVmB7sh1vCKyLsm
	hNZWBypqGYy+MMH57ss7hvEpO7EqiX//zdunq4jVm/Jkk5oLlm/QSa58
X-Gm-Gg: ASbGnctBVQxrO0QFOlbSv6VePjJCKSMwfa6lKZSOgL+edM24nBpCvf2B7NF8Qsy+IrA
	bXD3XCrlP9lM48SssLo9HH3BrV/pEPGOxdYtc5042ofheA4LvouFUQMEsTnxSt8vfUQHi5oK6rN
	ofN7r29QD6cTDbVjX0jEPa2UYi8en3W1jmtXURq8OsH8otOERwEl+noA4CKhCLkfa58zVGQvchs
	/oLntalOdVANzvE1ZkirRJJeUVG55EIv3d7KaETb1v1HW91ROe0Dyrlu0LNI50mV7anqibQnieo
	WfcisD1cbV9hXbWB36vFrtSp70KqQVjQ8SucS0iKBmNQaH8eNKGRXKbBL7J+C3ujfrnpzTkf4y7
	lmPt75dQgjOhVb01oGPDY
X-Google-Smtp-Source: AGHT+IEbc9AVFakYZpbdR7rVCLvCec18sXj2vaHTDGV6a2A64i6B073BsLEms/87izlJzKkm/8wFgQ==
X-Received: by 2002:a17:902:d487:b0:240:4d19:8797 with SMTP id d9443c01a7336-24246f8c70amr191050325ad.22.1754363051610;
        Mon, 04 Aug 2025 20:04:11 -0700 (PDT)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31f63f0cb39sm15390881a91.30.2025.08.04.20.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 20:04:11 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] clk: rockchip: Fix error pointer check after rockchip_clk_register_gate_link()
Date: Tue,  5 Aug 2025 07:03:58 +0400
Message-Id: <20250805030358.3665878-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace NULL check with IS_ERR_OR_NULL() check after calling
rockchip_clk_register_gate_link() since this function
returns error pointers (ERR_PTR).

Fixes: c62fa612cfa6 ("clk: rockchip: implement linked gate clock support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/clk/rockchip/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 19caf26c991b..2d30b1e24f01 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -693,7 +693,7 @@ void rockchip_clk_register_late_branches(struct device *dev,
 			break;
 		}
 
-		if (!pdev)
+		if (IS_ERR_OR_NULL(pdev))
 			dev_err(dev, "failed to register device for clock %s\n", list->name);
 	}
 }
-- 
2.25.1


