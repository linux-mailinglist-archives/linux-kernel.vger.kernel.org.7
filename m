Return-Path: <linux-kernel+bounces-844663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C32BC2736
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BA4189CBF7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE382E9753;
	Tue,  7 Oct 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/FJqmx5"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15EE2E974A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863337; cv=none; b=IFj7AgJtR03Xi9DJDy40aBdt3yus7wg1q+fMVUOCG9WcRtMQ8FJIWryXyyhzrsDLCjW5wMJlAwJExijm6JPq6q4/gNgYejRTJtJwMCnc/90Lp3PnGnE8a9dhUKTvHwQ5kaZPmGt9Iskh7KQCDYfB4ORrCU33CqaqinpYnHnlg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863337; c=relaxed/simple;
	bh=KWXkMIAyDYXJL9ZYFoRhKKia2rw51cLLtwlRksRSZ8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRj6vMpTPkFlDuVzoFiRxuGbwJ0vxllExP4qvlX0i3ewKuDbWewZStzfY+dbZZ+DchyF6F4L7fxWI9ZzUtaGGIyrOqJg5zvgsEMiu3VwwRqW+rB3zPKscQJS/BzFMoVKCIr02MEZE5a0LutiCftEPzQV7E7Lb/tIVPjaMs4y2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/FJqmx5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so5631253b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863335; x=1760468135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiI8ma/H7AR+p7UC+KuFxeAt/GicErH37Q1yChqPrPA=;
        b=T/FJqmx5OhgQKXHuf5oRZb0KHh4ZXA7VOkFavBchSF2pjlQAsGGknYn3r+Ws/buU7y
         uDGwCvfCoQrf5H13vZfvupS/PzhXYb6hUwauM2zuO9KFt/6X1lmDg+WiXaLKZK2YWDV7
         4R1Y0Ih/R6v/01SCfTn0uwEddsLFdtthD1+FUVVCPNKcBToAdLzOGkuYu9Vzqsh8ivp9
         qx5skZjYao8qwO6TBXgWU/5jOksNmF2OIXkduEHm5R37J1VXf7Ot9Iv7bxFOxDpoG9U0
         IgdOLghPvZfSXwq2IKETUsHHkRFvVFukBlRNRaEb7F5GqWL+prTJ94KE0CMKBgGUGOvB
         JxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863335; x=1760468135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiI8ma/H7AR+p7UC+KuFxeAt/GicErH37Q1yChqPrPA=;
        b=Y/mmlGHp3fID2nbc4+yUfEzySjHH3fYBQtsp6sywGQrL3kp7tDUQSo0MYtg736Otte
         shqXJWuOHlZ4NIX8BGKAhnJCXRPyYL06z+9RmPwbECoh2VpNHwo7LHBOET33oBnHwzoO
         hZtaNsidt/MtStKAA3NyQRSq8bkI7UEfUV1X34J2i2gmGnN8artgtNHik5pxxiX7Ngk/
         /7tXMi1bRMT5E+DSZ/I81Ao1tgH+E282rFCchKmiGey9ku/cg1hVyyBmvh0QkmABNUd7
         Xv7tR/AQxFop6sI0Jf4xLxAI4NrjR4gjHyaZMmffwM1bSEXPIGllaCptv99+BUvrP81+
         uH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQDDjQdnPo3CLvHo/qfcC0lLDUH9Agm5xYHyT1LSh5nUuAlXfBIYrZT29FpWiT/I9QWC0ejPAj8ANMy+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7/Gx1wD/wmR2ASqW6XKYugOpk1opKgfcaUVh8wwvg1zqHZ/p
	9jMm6F07C3MFR05aMv4F90TEWs8NfHOulZfkESqVwUCKt5nMi51qXPC4
X-Gm-Gg: ASbGncuqq/PDw3GPms+AeAsbaKMXX3RQCkz66HzOr84i7iGF4Q7YCHc3dBWyPvmkscu
	zCB91C+Nmbvn2w6BBbKGCo07luPAttXGTuowkNiHTJBOd2yAP+mGnuguhyhz1RtFS89AyWaOjvk
	f6Bw6GCNnXrKlC6mNF2OeTicrIrfObebPN2LnfLeWC7x8t80WI4fvj8b0Q5hUexovUtKGJKWEwo
	iK6uAvhIalRwfhEMG7tp+5hyTp2zTL7C7/J3lc6BMcFF5X5zZIQg+NTbd9rjOmSrwxPbmPb4Qn5
	+J72dNzIaysn5rL5Gck1bcqtObpO4JL7qTJgpTIsP9Uk7PnoE1CH3UiIkXvGAif8CzrOHPxAwNF
	dPNiVuIX3T437s6yg2HBqupJGWff2NhdgjqemVlqvESUDj4Dp7Nl6hN0WwNUNPv5wJQ==
X-Google-Smtp-Source: AGHT+IG2yzS46KJ17xC1D58qrOL2bjUkWL0tVGQSAERrzK3lQkukSFgqqZhPfcQE1JCH0nzmhBPy4A==
X-Received: by 2002:a17:903:8cd:b0:269:8d85:2249 with SMTP id d9443c01a7336-29027240d03mr7980115ad.22.1759863334954;
        Tue, 07 Oct 2025 11:55:34 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:34 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	crwood@redhat.com,
	tglozar@redhat.com,
	costa.shul@redhat.com,
	jkacur@redhat.com,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/8] Documentation/rtla: rename common_appendix.rst
Date: Wed,  8 Oct 2025 00:24:50 +0530
Message-ID: <20251007185508.40908-2-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007185508.40908-1-krishnagopi487@gmail.com>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

common_appendix.rst is intended to be included by other rtla documents
and is not meant to be built as a standalone document.

Rename common_appendix.rst to common_appendix.txt to maintain
consistency with other common_*.txt files and prevent Sphinx from
building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../tools/rtla/{common_appendix.rst => common_appendix.txt}     | 0
 Documentation/tools/rtla/rtla-hwnoise.rst                       | 2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst                  | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst                   | 2 +-
 Documentation/tools/rtla/rtla-osnoise.rst                       | 2 +-
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 Documentation/tools/rtla/rtla-timerlat.rst                      | 2 +-
 Documentation/tools/rtla/rtla.rst                               | 2 +-
 9 files changed, 8 insertions(+), 8 deletions(-)
 rename Documentation/tools/rtla/{common_appendix.rst => common_appendix.txt} (100%)

diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation/tools/rtla/common_appendix.txt
similarity index 100%
rename from Documentation/tools/rtla/common_appendix.rst
rename to Documentation/tools/rtla/common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index cc2721315552..102654cc0c78 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -106,4 +106,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index a11c485f127a..991c11d6210d 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -65,4 +65,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index c7bc716b2899..58321322d24e 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -60,4 +60,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise.rst b/Documentation/tools/rtla/rtla-osnoise.rst
index c129b206ce34..997a981fe397 100644
--- a/Documentation/tools/rtla/rtla-osnoise.rst
+++ b/Documentation/tools/rtla/rtla-osnoise.rst
@@ -56,4 +56,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 547dfc7ace58..20c1315c21c6 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -110,4 +110,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 3740fd386ea8..c620ab16f849 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -133,4 +133,4 @@ AUTHOR
 ------
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index 20e2d259467f..e66d2588a416 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -51,4 +51,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla.rst b/Documentation/tools/rtla/rtla.rst
index fc0d233efcd5..2a5fb7004ad4 100644
--- a/Documentation/tools/rtla/rtla.rst
+++ b/Documentation/tools/rtla/rtla.rst
@@ -45,4 +45,4 @@ AUTHOR
 ======
 Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
-- 
2.43.0


