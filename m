Return-Path: <linux-kernel+bounces-740725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E32B0D857
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15443561FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62B02E49AB;
	Tue, 22 Jul 2025 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEasT2lT"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AFB2E4988
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184223; cv=none; b=airONM6PnhBgRwkcG9dR3u1+Wk2te6JPq6W3buBWbdcm+LSIhhVtZn+HRK4ZPlee5m4Yr+CB66uvhUMwCNUz/TAX5TanAcaPxhvGgJq2Bz3Ch7swlnV+YK6uGbpci25Y8VLg8xlHW2MgBvvzBkp3RCUbOVGCsFBwxPS0/Wcd5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184223; c=relaxed/simple;
	bh=FxUhRO8siJvOTTuikBGiHpZjK7xNb3oVqmZfj15ctk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mwd3mJrF6DIW0ucm1Q9Tpn+FhsNAlgpUz5IG4nTZozAbic/zLlj/ZAjwM9xp9y/YXVT7FFoWWBP1z4vckDfPgO2M2tc0km65CTnL9ke20RT45JZehaKXcIiT1ErKFIEqPGJq657HMqml8sIAxohjD47lHrMPhXWo9hg3kuny3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEasT2lT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab39fb71dbso64218781cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184220; x=1753789020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxUhRO8siJvOTTuikBGiHpZjK7xNb3oVqmZfj15ctk8=;
        b=mEasT2lTicuNmHBaZv9f5/HTHTdZg0oV2P8c376CtgDQCqnnqKwDxSkMS440KNDGrr
         gnd9YpazOcXOcAZqXvKG4ex7/8dBbQ6/zv1ITjX51nQunEdxF8V0H2RrQqPZ6mL6fh1B
         AAetredM18iynr3e00LWEpcXTR2omppfeVgfg48Ygumn6jmGc3LTx/bjlu1OKT+x5JAC
         /xpXyPr7UvToKZv2eDX9KQ3Wi0wwHjTJMZNdDC1qahnvFCizVeKei2FEoFP9afpiQhlB
         dTUWWMc9/WP61rh4VLhBXeZ0X8E/rM235+rY84G+WiP0rHatbfYVCddkyqTtbtvhgRK0
         EOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184220; x=1753789020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxUhRO8siJvOTTuikBGiHpZjK7xNb3oVqmZfj15ctk8=;
        b=DYl83YOp80i1IlnRyxidTE3LacbbUJ5eUj5UY2en+sdgETX4VeM1PHGDtkASSkwcPc
         ztLf8a6GJMl83mNvbqkEHsVhuBABJA/3iDVLgeQrziKcQuZYKvog1EMEsX7xXAAWYmyw
         M0OIXB3sdRjwl4KrCWfywJK/rEeO2B+Nu0fi/taNU6WBKyNJZo0xHeXzLq5JrvE6dsfV
         P8sC+4OlL7Uoy37brAbtgZkBdKxwZ3VeE82giU+Q3mf4nHnOF57/3HQ4UE1Doa9baUBB
         pztXcT0z5zL9CQooddA40J6EuFZqNEKzKiofJ70g5lfTCu5x4Ay03ht+4eyYxnJY4KAf
         ahQg==
X-Forwarded-Encrypted: i=1; AJvYcCUXPwKy7L+AxOyXCPajL4CPo1HxgxXMoYL/brEzXT1wgmdx4cfrP/mPQB2y9W6vj7v40vWwUDItWx7kUAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbELPNe4mMtVWYMCUNo4IiDEbflIDuxJiTXyPRvJ+3OozxZuYS
	1uwLKExX1iluyuuANkwLbYVT+Hv80PXp+jZo6rR9b04jqBFPF3RwaAbfV7x1ajAC3hU=
X-Gm-Gg: ASbGncva89X6Klkddu4mvrZ/92YigtIbpf0nfuEzHssPma/7AOYTJduGPSw11exKGi6
	YCp/KUMQ2YWfuhI6SW2T0USvLkvLfXzAIlbTOpVTpGInA1TcnBPlhV9vKnbaH0CznTYIY47QLU/
	nKEGVVMu1Fa640CXM3J8lqjJ7mFw8CRsOdmXutDFfcyV2beJK+6YaOi88X6JjucmGYky8viYnfH
	BylArHyTHpUnUMBO9WJblpZ0y9SMEq2UojQxCurjDj0JxqkCbg0yeZJDRJhDa85SbTKtX6zpLux
	5rhxabA1VnaVrh0a1WVURDBfS80zvAW25WxMhdGddxCYzHVvhvLnhFHUJXTtzxeB490pL7+oiUm
	JUUjnarraqmeoJKHOFMY3TNIZTwuyko3F3g==
X-Google-Smtp-Source: AGHT+IGrsflevlfX23vLokdcnMNed+OrTIDjMwOm5v28UB9PCFgRg2ifqmNxS4DiR+KG0BlcAh6kpw==
X-Received: by 2002:a05:622a:85:b0:4ab:c00c:250b with SMTP id d75a77b69052e-4abd1d15312mr122559931cf.40.1753184220478;
        Tue, 22 Jul 2025 04:37:00 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:36:59 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 03/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:46:59 +0530
Message-ID: <bf92d1928aa59de5eb88dd6fdcc3360c6d028c0a.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the shebang line at the top of file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/features/scripts/features-refresh.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/scripts/features-refresh.sh b/Documentation/features/scripts/features-refresh.sh
index c2288124e94a..a908704fd149 100755
--- a/Documentation/features/scripts/features-refresh.sh
+++ b/Documentation/features/scripts/features-refresh.sh
@@ -1,4 +1,4 @@
-#
+#!/bin/sh
 # Small script that refreshes the kernel feature support status in place.
 #

--
2.49.1


