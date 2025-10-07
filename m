Return-Path: <linux-kernel+bounces-844664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A976EBC273C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BAC188C32D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BF12EA15D;
	Tue,  7 Oct 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhekp05x"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918582EA15C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863343; cv=none; b=Oc1tklE62b+W99qUJlVR7EVsJArZxKqLBDOP8Glc+JFhd/XasBtZ5g4ZnDwTGPVEa8L5eDCInYTJ111BWyVLfy8GTkVxWFnE1lc85Kd9gBBLbNInxAHmXw8oRgZOunEE4UXFFEMpqWWA+zE9ISOkXleJOVH+iz6NZu8MY86mSis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863343; c=relaxed/simple;
	bh=Yj6qFGpRJNJDFP2ncNEzgdlCNrxdDvojcj05gRJtzaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqkepuVHvJ24wm4FHIuvqdLfWTgrD+ijqU/bE0gtzlIRP84Q6A9s7+M3bwMObBrp5EX7UVpmW0blpGPrJdOLWV01KXty9rL/mm5dJ5GUCzwqEtRKRRVIZWozN/S/hYGt+Ay+IdgKlmbxRy4mO2O2vLwvfljq/3t8uwVOwBl7/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhekp05x; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so126636b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863341; x=1760468141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoECoCP08BHgzCQ48qCknodyteaa9PDghFpXIE55+JE=;
        b=Bhekp05xjipuzolMaDss65bhEcl/85WOuwx8le4i6a8M0UwA0BqtKnZ8k3VnankSG5
         ueJXBfvhpKifVAmqT3KcFTHmnR5Mt0/LSLYk2xRlvOSUZr8Gopdshf70AYyZajGTcZdW
         fyTwu2qSw/pdGSg9STsn8jktJYZOOJfdgqtYXj5d5PijDyfd7Ga4zNP3n9A94ri5dh4J
         GJyA3haSaSPxPKsM0sRNWUnv0UnxJK5Eps/3g3ttyrZoVQw3f59X1TeF5fJgRMTm/al2
         7YWf3Nq4FiFNr7qaHhH4gmu9CQMclcHZFJ2WepXJxpuVww9Y/ao2EuSAQ/T4KorlVucL
         1sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863341; x=1760468141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoECoCP08BHgzCQ48qCknodyteaa9PDghFpXIE55+JE=;
        b=nCLwLY/gvQBCAAS3WyvRNpeLnNWVd8uEX4+rw+wU0cqaR+Kkm6eI8U63xdisTcekly
         a3BFK1GpDlWub1pr/B6nEvDcjzQeMRdiGMGz672gDgN/TX/fYgWiBpSYyWxTFhIQY4UR
         fFnBCf59OR84Ypu5c4h2Qh6luX6vmhNBeriM3Ap+DEmQbgNE+dUQBinKE7RUNB+9rHqU
         4SNfuxIJnjS/SKnmhGG3o67wGDsSQgW1Rf0lY4Xz1gVIERIshp15w+MhRmdw9Z7AOKQB
         NIOToFeFX6u4xnHqwVbbqINo+ya+kr+Eff4JE0g7P7eoQoWaGvCrpV3LvO2OiISKTZ7V
         RhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnKq9mixkhbMVOgKkm5MkIgaR/e0Q5oGMsv+92sKIeP5BATVRCSP6yfdrz223ttBSJUBzRsMO4kRa6P9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOH0OwAH/atiHkZAVW6ftWe/wHo5JsLED9p6Pb0W+KoF+ZrHh
	UW8xrlQ888D469vuyHpADjw8gS5H8L8OAIr/bONBA/nAzMEF/yhueCjb
X-Gm-Gg: ASbGnctCNJqAPh9UF0Ki7uLnNdW7HpDyQb37edShOKr+oQc6rmun5j66J+qGVmkdM+6
	Bvn4aV6vyBDX5P3xzFaIXVEewcTFcHwxO2Pze5W7B7EWq5+bzt/tA8fvTANZFNgu3nKERKKu5nb
	LQcx0yynMSyJusznyvaf+zWORONgOFEnIy4EoXCmjBgEEArRzKTps+VfWWGvyfGRN2hbKG5DJo6
	PSc4l9b2BDW9s3U+dz64TNY93dLBpqwPVcC9A29Ns/6lUN2kUMSk+TqY1abDU7m3w2dOKARslbG
	XaaoQG2+9F3vgXboXZ4IZR4bP+7MJ/pPyVdvAd8QNXsTj3KInl/zioWeXvEnwnhd+LvoPvpAyX/
	eKiVUT8AejxIvwiGMyzuhyQa90vvEJveA1KWTDa1HOQtfspPC1LYMK3ZSCuGSc07ACw==
X-Google-Smtp-Source: AGHT+IFJamQeAOOdQ9dqsKsLUKxoiyUO82ESK8nEp/zyoxNnQPXrmUGH61Q/EWQgGDEZfqVMdB2aHA==
X-Received: by 2002:a17:903:1aa3:b0:24b:1585:6350 with SMTP id d9443c01a7336-29027e78f7dmr3818745ad.11.1759863340793;
        Tue, 07 Oct 2025 11:55:40 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:40 -0700 (PDT)
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
Subject: [PATCH 2/8] Documentation/rtla: rename common_hist_options.rst
Date: Wed,  8 Oct 2025 00:24:51 +0530
Message-ID: <20251007185508.40908-3-krishnagopi487@gmail.com>
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

common_hist_options.rst is intended to be included by other rtla documents
and is not meant to be built as a standalone document.

Rename common_hist_options.rst to common_hist_options.txt to maintain
consistency with other common_*.txt files and prevent Sphinx from
building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../rtla/{common_hist_options.rst => common_hist_options.txt}   | 0
 Documentation/tools/rtla/rtla-osnoise-hist.rst                  | 2 +-
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/tools/rtla/{common_hist_options.rst => common_hist_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_hist_options.rst b/Documentation/tools/rtla/common_hist_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_hist_options.rst
rename to Documentation/tools/rtla/common_hist_options.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 991c11d6210d..a39285817566 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -26,7 +26,7 @@ OPTIONS
 =======
 .. include:: common_osnoise_options.rst
 
-.. include:: common_hist_options.rst
+.. include:: common_hist_options.txt
 
 .. include:: common_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 20c1315c21c6..43f99bf0f1d7 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -27,7 +27,7 @@ OPTIONS
 
 .. include:: common_timerlat_options.rst
 
-.. include:: common_hist_options.rst
+.. include:: common_hist_options.txt
 
 .. include:: common_options.txt
 
-- 
2.43.0


