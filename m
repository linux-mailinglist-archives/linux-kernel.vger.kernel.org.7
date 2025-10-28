Return-Path: <linux-kernel+bounces-874297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EADDC15FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338A11AA62BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF346347FE2;
	Tue, 28 Oct 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8PJobDZ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1934889B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670320; cv=none; b=CyiWHhMrBhE8o7UrGpm6zOVvpruRabsUH72ZN3g6fE1eA5Y6HhQd5LDs9I07a1FZOkbbDOIwuPJzKDH6F73csZqjg4Y4+qu6+onDFC8AYoF5+QVJ70rtOsyZ+MJro7qMAD8hwLUAbGIUBawTKhtjElR0LJE1lUGJUjH3BJ6CQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670320; c=relaxed/simple;
	bh=jm7MH9Ljx0cTCbjQdKH8TcdeIcQckUbKzdjt/I870Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6KXIRLi1iu1J5vMjPB0MfnuDXCyvPtcYyhV0JePVtjUSNnDVzHdR55/5UwCQFEBNfv71LwcWumH+AqJBN7W4wDultv3Ufk//bjja3CODXRysQN+ZksVv4UQAQrO+Z0RllyqjC5hQvPOiLwWO7vDphrmfskSbxqvhseNTcZ5qRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8PJobDZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so4777716b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670318; x=1762275118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbG5IF2Pyn4vpsrN2z3h5DzN90lM4Q3eJY7tH5/4ZlQ=;
        b=A8PJobDZwLOY3tEW3UMf70olb365xaHcXViLsLC+F0HZAqOzlvaH0NZPIDU6BY0U51
         UVJ2D75bqgf5wr0Erz7h4Ddytw8/320fJV4XxTMJjWESnFOWv2z4aZTR1sGFkfNDKF1Y
         JI+pc7aTqbiebQbXp2U9r6WGu/D25UMoULLJJ1wGqusnIuHuZv+GgbFa5Uf/AxeYPgjf
         91nJamJy52T5gdZd037KzX4EFN0bMgdt/FGqtdX2JvDRjRI3ew72h9KsZ1fO2cTvGVmf
         pim0Xp37tbrIKNUlqWkA/i9VYvE2bNtjIvSHv7cAYm9ZO2Sm/IGKY2HZTOQ5d/zJ/voe
         9J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670318; x=1762275118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbG5IF2Pyn4vpsrN2z3h5DzN90lM4Q3eJY7tH5/4ZlQ=;
        b=gelcw2ryfF946gs1FNjBOUEcfEdceQRBSIkLZcOWoCsC4zUgcBXa+0nj0Y9RKvoMh4
         XWVx8P3r2ibA2Sol23pDwdCVHs4rZZ3REe5/tn1U7h11tlLdkdlnHG3aA5qsv7kT+Z8E
         YxKxuupabOPn6mS1JqVsap5XvZSwIasX67SzdvVux/r/ZOl43RDWVxE09p84yb/ymPcf
         JyXVrPNxrJrNtNO2u4jE6499OGne0KdKhciJGsUvGPa2i/ohkQQwkdiMFQ9oqHDguRzl
         bZ2k7E0i4iclvgkufsVUOyOWjVKBO3xZrXAqhKsAJz37n7TbRaObEC98dJ91/lAElSMY
         Z4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHI1WcS0ixPj8gvn58nYNaAZGlJhU9YkHEsp2vRVK23V1yZ2OXrjTW4N3SP/FdOlWPriKWYbV7zeuL+Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVM+62zzImagOuL7L9mxxi0koKv2TgU2ijVYVmmLfmUraHiIhp
	7jNVan7SGeyM+Ol0SJcyUDOtFJaxUdabSmlEvzmkRpBn2LDkUU3DrIfM
X-Gm-Gg: ASbGnctOWCuHVYHbO1bJOu3v+T+6JWxUKk1qra4iEIV/Rbj0aMPpzGqaoYRNzNulFhX
	6I0TRZspnWT1/iirsuqzKQ14iQGLds+6AnxyqpUw8R+5Ur0+GAbw6R4Je5Xag6uX1L3pfkBTzzP
	zzTvDeukr4u4EnCijR3YiSza4VnJPHnlBoWDsFbqFEFoPhx6jyyb5vC51jlWKj6Xkarti0P4+CI
	kYw6rwdO6J83jMDxQcvN3GimI/gyK7PJr6/i/cVJkiBui9/fw9y63yX9Eoc+E/tidyHs2HEWBWB
	LjYzGk0WmCy25d+LqF+Y5ii4K4etwgol8hLiFx7NTKmUXTQYf+06QHHDRBj8WNXPz2c6/Gz/Bad
	dYKlBYeOA9aAom32JCrF2SntKAeXiiGgDaD6SYlZXH24p4RxvzqN1G5JxT/e9s3SOx/99BJSCww
	Mf9zUeZtMhrsS5OuTf4sasPw==
X-Google-Smtp-Source: AGHT+IGLPUOqrtiYYL5ZsbQtjhr4Ba9uzVs5+UtmtyU5aBfpQMCGhti+qksrxXmMXxxHrhHcv4F1PQ==
X-Received: by 2002:a17:902:dac2:b0:290:c388:e6dd with SMTP id d9443c01a7336-294cb39572cmr51488595ad.7.1761670318095;
        Tue, 28 Oct 2025 09:51:58 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:168f:479e:bf92:ce93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm122123665ad.96.2025.10.28.09.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:51:57 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/5] clk: renesas: r9a09g077: Remove stray blank line
Date: Tue, 28 Oct 2025 16:51:24 +0000
Message-ID: <20251028165127.991351-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove an unnecessary blank line at the end of
r9a09g077_cpg_div_clk_register() to tidy up the code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1-v2:
- New patch
---
 drivers/clk/renesas/r9a09g077-cpg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 1cb33c12234e..666fc16b9a81 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -240,7 +240,6 @@ r9a09g077_cpg_div_clk_register(struct device *dev,
 		return ERR_CAST(clk_hw);
 
 	return clk_hw->clk;
-
 }
 
 static struct clk * __init
-- 
2.43.0


