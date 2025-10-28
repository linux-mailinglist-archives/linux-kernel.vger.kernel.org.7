Return-Path: <linux-kernel+bounces-874184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BECC15B56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF011888755
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E5622ACEF;
	Tue, 28 Oct 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElNDTwTX"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABDC2206AC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667632; cv=none; b=Pnr26z6teCbW1++nUTTZKzbX4J7eWCroimR5m6c8AGa+fPih8HVEb7QbEC4Sjf95IfWb1I+XfX4v5G9TPEg0OZsyZtzxsF3gOLw47rDwuzEHzBZJ2UViQ/joP1x120cXpj3N0FrcBtceur7+XNcP9FoeqtneRnXpfytx2S14E60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667632; c=relaxed/simple;
	bh=MWE1wHQwpJUdg+s6GjvQ4xmCBSj0KgbizOmtjag6m8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NbXijQQAWqbwxzA8K2ZeNGvQz0OWJrNhw9KSxLX83QVQZ9BRSJLcOFaP/z6LfE+7I9pOEuXjNjSC4bmSz1Xx9uquOdBCwWM+HEV8tvYYf/ezDcRW/yOfzlMKQ7Qgp6FxQn0BEDrvCBqrAjWisIGZKF4jDmGNhE8Qy+SAK4ULDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElNDTwTX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso4749704a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761667631; x=1762272431; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uN8oYIJ23vMsGy3r6Oa4DcNCIzaLKJCXZ02PFiN70n0=;
        b=ElNDTwTX2c2RvMkA7uxPnuAwCAeTD28NIHV3mvyhnYTy9UYTPJaVu03hGvBiqyWVH/
         yNM1lgCOtB9LgxSd8TUG398JzHbhG45NAuWtlnGKH0WYCuos3Pkyvyw0iUwDkxfG0aXQ
         hgnN0pADNBz//Cfspl4vNce9GdyvU+kNwoOps0QQzMewDBmGX3+t7jFi73vD1a3RzYxW
         nD50DIi/c+Rhe/oogCsE69qS1dD7v7zxp7gU7rHFHDf/gZvlCbrqpfuXk3vnvIaaaIZy
         qwJqQWX8xOk2VMFLNOszcHBmmfe+umQFX/dqrFMG8RprNz+e93TlApzJNZefdimoSbhp
         iXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761667631; x=1762272431;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN8oYIJ23vMsGy3r6Oa4DcNCIzaLKJCXZ02PFiN70n0=;
        b=WyyA8Kj8Q43qT7TTHiWo4AtYkqlS1dhYJa8wPDCqp3m4Rp9v6Zb3niLM0NmGd/Y8l/
         U1AcwWew9yan/G2sniXF5KdPstBTCCuTuylDebyt6sCxBU+BTuVtlzhClvAioLqR3cke
         Xzamn1johLj+VrbUnqLBO+t+O+4StgsXuHcOBzG4AqzbHFcnKFzk+Bj9y6xr2iR6Leo1
         S/m3BmA0bE2qMYmh1zo2tey355ToU4Jue12j+NG5v8ktEDNXMPTQtfKgDilrq1mgPZNt
         Z/qzsG44TEqOhAvaTwBptErjXyktqUtKz3YU6MKGU+EWUPQWxRH4R4BohhDXSZx+wQRr
         3iEg==
X-Forwarded-Encrypted: i=1; AJvYcCV9Xvxr4pCjTJfGRBR7P4Qw2J2fFqlYSyN3rZObYXs0Y18i0OGXnmafBgEs/Qlt3RSLgNbpqza8LeJBsL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqXFFhePZM48ckPIc9dMvkN2LSEj3Ekl2JjqUYipyNwVONRkbn
	SoFQ3qsbIAGWfovvGB1sIPdDSWPSPUmkWaVtWzlQ8f/HQGMOxhduXXNE
X-Gm-Gg: ASbGncvSxjBBXITnKf9RklUFmQWbE4BoqGCkzOpeUfaS1tL1tQ712cVmcfhp3dt+qr5
	hMReaIi1TQyW7xA81VxlnueNZYA2vvoAZt0AZrhINf2Xw1ryJE/dlCu5tLAzaN+Fv/ls26LTI9M
	T++yj9LAkHHVhVqv2NstgSxqDgHBCZE/8fvWnJtgfV/PQxXX4S2DGvgPBuo7eQh1mf9LJP5Fnzy
	EHVvVPZRNaIkxa4IYS5YM+06rt8qp4K/MRyCbdkhcpwIkhXGZyUGwdlAzHtxo1X5nMdz5qOL2lC
	5geejbn6ykSSmxXVTs1RzcrUjdq6uzcasx/BMjBuC38VodFuOO1JiBfDgDZIagNrFO8EZAQpY0f
	/yeHfQE+M6kkbmzQbA9Pcpwu6eiRD5toAwi1XgS81ILn/MKhgqe1v7yduHFUaHCD9NjmQflG5
X-Google-Smtp-Source: AGHT+IGyT3KwH4uNk2S8o5U+iIhprzitxR3BDiviNoBBo/Q2/S/fxc45ypOS/S3o4J1sE0jtlwrDTg==
X-Received: by 2002:a17:902:ea05:b0:26d:58d6:3fb2 with SMTP id d9443c01a7336-294cb35e795mr49845185ad.12.1761667630674;
        Tue, 28 Oct 2025 09:07:10 -0700 (PDT)
Received: from localhost ([240e:440:d04:10f0:5748:527d:6b58:a56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e41700sm121030795ad.95.2025.10.28.09.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:07:10 -0700 (PDT)
From: Encrow Thorne <jyc0019@gmail.com>
Date: Wed, 29 Oct 2025 00:05:39 +0800
Subject: [PATCH] clk: spacemit: fix comment typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-b4-fix-ccu-mix-typo-v1-1-caddb3580e64@gmail.com>
X-B4-Tracking: v=1; b=H4sIANLpAGkC/x2M2wpAUBBFf0XzbOpcKPyKPDAG8+DSOYjk302eV
 qvW3g9EDsIRquSBwKdEWRcVmyZAU7uMjNKrgzMut8YV2GU4yIVEB87K/d5WNL4gWw7sDWWgyy2
 wNv9r3bzvB5vukgFlAAAA
X-Change-ID: 20251028-b4-fix-ccu-mix-typo-038c19fe30c4
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Encrow Thorne <jyc0019@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761667622; l=966;
 i=jyc0019@gmail.com; s=20251009; h=from:subject:message-id;
 bh=MWE1wHQwpJUdg+s6GjvQ4xmCBSj0KgbizOmtjag6m8M=;
 b=W/Nr03DugBRDanEde1X5Xv65lFXEPtYoAFcNg3Xwe4XJbUI2CxrjAH2YEeDNx85xNZJnWBfsm
 MjxogSDotZYDEXJJXvdlCNntvVzBXTXCZU3Vub/F3pyPxu1m33u9CXS
X-Developer-Key: i=jyc0019@gmail.com; a=ed25519;
 pk=nnjLv04DUE0FXih6IcJUOjWFTEoo4xYQOu7m5RRHvZ4=

ccumix.h was copied from ccudiv.h and the comment after #endif was not
updated.

This patch fixes the incorrect comment to match the filename.

Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
---
 drivers/clk/spacemit/ccu_mix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
index 54d40cd39b27..c406508e3504 100644
--- a/drivers/clk/spacemit/ccu_mix.h
+++ b/drivers/clk/spacemit/ccu_mix.h
@@ -220,4 +220,4 @@ extern const struct clk_ops spacemit_ccu_div_gate_ops;
 extern const struct clk_ops spacemit_ccu_mux_gate_ops;
 extern const struct clk_ops spacemit_ccu_mux_div_ops;
 extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
-#endif /* _CCU_DIV_H_ */
+#endif /* _CCU_MIX_H_ */

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251028-b4-fix-ccu-mix-typo-038c19fe30c4

Best regards,
-- 
Encrow Thorne <jyc0019@gmail.com>


