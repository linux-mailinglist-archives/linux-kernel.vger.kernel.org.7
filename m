Return-Path: <linux-kernel+bounces-875921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8C0C1A232
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2ADD4EB2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6878338F52;
	Wed, 29 Oct 2025 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qkcMBYK2"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247A31E0EF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739641; cv=none; b=QqobeYscOJ3Bb4JNY+031PHC1xr4CsGjsTCVlUHk2fndbuTpOJeEZpx3flu8fYdJJC6rpQTiOtwCAabPJ/yaAx2zDMPOLkTnZJ8YUh9mtV6fFcSob2rmiyEEqN0UYO1FmlHqpS8zJH9gtnSzFa4G5njZ/Wv6vaJERSOuPYjhW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739641; c=relaxed/simple;
	bh=SXNlRJuMRztIhZArMNvfUXa4cbUPwsnfpPheprXZEo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdJLAVJGjrvvFi2ISIXsAOjeaiGm6SKx5BxnnLOTRnuX60CVaEEv91gyCWYCFMUPDVf0LeoxPR0FPYlypN3BLuIThGnYGP6qly7UlCqXkNq9n25Hp/3u6qVGv1/PEEFs/gMU4MbnmKnYYZQS/twYJG4lpfMw/6njbHDYLVd3wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qkcMBYK2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so45416215e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761739637; x=1762344437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yAOyQz1MXdK8SlnFu+v6U3hIYAUX7Z7s9vr2irumEk=;
        b=qkcMBYK23u7/puNmCZmDcoEDquAyuIHh3U30HRHhyHael7bXnMJIHz5gOtO5qcIq6g
         qOHanzfr/odCnSZFyd69qr2ci8IS2oF3lYyllCcHGogVGww2LacH9JVikZoLFF33WTA3
         mKMZVtY5weImXTip7DntzYVvqeJEGpPN9TaJikaZL5dSzfxqYJWurdw11P80+kPjyova
         YOKzNqItTRtfGqugTXhKIs0Msd3rZb7IcrhuwlP4s43yXLOAJSqypYn8sfKgQN4ibTWI
         kqKNJgemwebDGV/L8lAfZJoGMiRAgdRHs/21GvZ4CzsSIgLyUdCHpQXlS42vl8dvLVM+
         1RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761739637; x=1762344437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yAOyQz1MXdK8SlnFu+v6U3hIYAUX7Z7s9vr2irumEk=;
        b=Sg92P9AweiyeDc/uvV3BcmCECEXbVVuPdSq+jevnjnnyDNbP79gRaYYdkY1SZf/l8M
         /18hmGHmzEatjU49L/PFPBS7I0folAr4R89bj/IvIZQY9naLeR6XI4GeoleI1JBwBFnV
         ze1s6MJs01QVNCgKppV/lawWTiViiasY1wxH0H39mogRqJa+dHVRSSKpq4HqgBQXyaQ+
         HDxJ48Lmm66bXnTxApw89SiS0bzT+R3KdyJQEJKP76JRfSMk/98ZbvYCUtm2LYkUfi50
         CUD5YQli9zP4A6g6Pw6adK4tceIp8I4vlv8SFEeWWxDPQW/6A/8fIbGZLHPklaRNNNSv
         ibDA==
X-Gm-Message-State: AOJu0YyHsBXrTm1MXfL8CFzjyJAARoXxUOKsjp772UStTXciGWyeAx5/
	nXv6N3EuOL9gte3rqE89FLVmfCFMEfwyeGLGW7EOHKSz+O2Fet2gT/WCswol02LZtzU=
X-Gm-Gg: ASbGncsqhWlxXaxzduVh3nfHLziwkzUTrWdy9sobgB4eDSaJDDl/3NPkCv7LPEcGA99
	a0upPRzjzQAeaX5AYZw/80zkVWVMVDP3/qgEiL//II4TDLzhcrpYoJhD+ePgrq2XakVy4veY9zp
	ZaEmggykWz3PZGEXjAaBYD6gbC+DCDx03sMOcq/ChKtBixQ5apPgwwzc088ZqgWIuNtgoDPnZ/a
	9xt/v01HtkCANeEa44XbhIThIpeV2Ce85Q6SoCWxbSwegiFUyBt0cnYRF0YCTelrs3xV2pOXC8c
	dOmZF0ekK0GlXfaiIQw1PkKtBjCZgYcncOfi2/IkZ12rQi3tqAG5PcPfmVv6ibKIgcyYY8/3Xxy
	E/nwDxJLAkBm1RdFQDfbqxtwkcbHnyZ0bTp5SFG0oKagt9UGQhJkitoZC2hkqvwnumi+tb3QTG5
	p2xA==
X-Google-Smtp-Source: AGHT+IF+rqdkcbqdL07Bdv5PZS79zbqhxFEVUuVUCse8w5ApqjU7mT/C6mHr1t+Lh8Kq12xoqKyMLw==
X-Received: by 2002:a05:600c:a087:b0:476:a25f:6a4d with SMTP id 5b1f17b1804b1-4771e16e4bbmr22868315e9.1.1761739637426;
        Wed, 29 Oct 2025 05:07:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb2bsm26413764f8f.13.2025.10.29.05.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:07:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] scripts: add tracepoint-update to the list of ignores files
Date: Wed, 29 Oct 2025 13:07:09 +0100
Message-ID: <20251029120709.24669-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The new program for removing unused tracepoints is not ignored as it
should. Add it to the local .gitignore.

Fixes: e30f8e61e251 ("tracing: Add a tracepoint verification check at build time")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 scripts/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/.gitignore b/scripts/.gitignore
index c2ef68848da5..4215c2208f7e 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -11,4 +11,5 @@
 /sign-file
 /sorttable
 /target.json
+/tracepoint-update
 /unifdef
-- 
2.48.1


