Return-Path: <linux-kernel+bounces-825214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2FEB8B4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3FB5A8009
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA92D322E;
	Fri, 19 Sep 2025 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fpZuJVBb"
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440162D29D5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316222; cv=none; b=nwgoRP8dgWQHEV5I0BO7RyqrEHP65mlNCpY+qdfbLMPP8L1xX7U+20GdwETijmQqxLcAjE97zZhYsUwQxzkSNcqq46+jgvqbcJkNOG4/RfWvP8n4GQJYB4Ncth4kl0cd1Ic/QsZmeZzu3Y5+YehOFupDftNMdPu2oZjPFFAYQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316222; c=relaxed/simple;
	bh=9O/mYVm3rlTMJz+QEyobbi99Nm4fjTo6dG+H36IOUmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjXUOo2qaz4VDnDCsPak5K0X04c36B4NEai1CNtxgQqHEiwXA09H9W7vbtw+QVLE8P3nE7HivM5qHqYiLXz3fDGxKgGGFFryigbQlkgBRhjFRm3aDbnYeOHXdLru6re1Mgjj6+reDV+fpeNgXlR8+LX58h0xaCZFndNI65OR+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fpZuJVBb; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-89737fcb219so191745539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758316219; x=1758921019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UxhaBuaC7q264UUKsUJVW5OUbIqA/R+5FTafCFNdtk=;
        b=fpZuJVBbuH9xxIzA0qRW5gTGh2o3XPAkT07DbxrRL554LvqlmTB0Bdyc8p8yi5okmC
         ujXjG/1jBpQPPEyxlDlsPycTCYpoWExZp+dlpev4QIeGKVA6uBXh8DFG5l80uubq16Ot
         SR5MyaSCc2BU7E07Dc5E5m4dGX6DXZ4vnwJB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758316219; x=1758921019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UxhaBuaC7q264UUKsUJVW5OUbIqA/R+5FTafCFNdtk=;
        b=cXcpZJ5mZHo5ziIz+TQySafCl8TyXdCu5aC/J3t92NHX9dBSgMutHFB1A+RnFbUuAD
         6z1RJKu7OanukpRzTh3ghCsM4Fhprj75GE6vvV9F1lu9E0HlAZQ/TdmJX2VjxQavxYRd
         bhrFVmtVorKzh87CVomkBGNK/vAZ+HHrIkR/ruQLY9FgR+dUzeoA6imTXPAUDGiEclHn
         LvgaewgkiN+e4k28ek6RF7YaBipK2788003U1HY00qCcn7cKjX4JGg27d32Er3X170h1
         HaI6TP59VCgDDsLRkV4k9WJa5l9j7KW22yEFPeskXy/p5mhXXAYmjS2bDoTn2MoQC4uw
         uoQA==
X-Forwarded-Encrypted: i=1; AJvYcCUbUD0i7m85ebgHew3ugi8h2g5RjWm3FLs2azRARzR/Ng5WID6nOmr5Vog5+unEJg/AIy2DIU8/T6j9t24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TDrI4EdGgXZsNupDiNcofvMlRLHMLM3hEww8MEaQWlfyGhVv
	habMFQNfs1dsaUFL92zBdksDSS4Q7D7wL1v1S3LaLuBHfbPH1p59ekJ5bidWOs3NLA==
X-Gm-Gg: ASbGncuyH0IBMCoQrRdEXLz8MzX8TBor9SNoYwkmAYfAV8OpWp3QLtqxHiSRozANJzA
	T7Fina0qjK1ePKZZhVJIO7rExFpmm+mreZtPMonfCy1Y3GMXJbvOwa4ZaQAXKjN1JASDsD5D2HO
	e8JUKxU7ZJe7133JK17F4pkl3DSKUnKv83G7GErRbQVWw7RI7bKRHKSIA0+CnPEHJj95YRYJ2ox
	2VR1ogqDgXhfajsWpKYfQSEkSq3vmnZoAWcaWjFtcik2AxsqXg+00zisTkFq0oeiarWkWFfTNlb
	eFatQB+aI6+j1/3lkoCUEzTzS2Jz5EDVQ5eZMGJZed7QfjI055Sq9KVTR1+BJ/JRCa+FlASipP8
	FwuKDhMQtPv2etNq8
X-Google-Smtp-Source: AGHT+IEyFLXaC5Y5KS/njQ9p6SBYpgmleLVwj5VVwDmLYgKztxHwdMcd0U4JQzV9WEe2+IwhzwTg/Q==
X-Received: by 2002:a05:6e02:1aa8:b0:423:fac4:d8aa with SMTP id e9e14a558f8ab-42481909d99mr70513475ab.8.1758316219490;
        Fri, 19 Sep 2025 14:10:19 -0700 (PDT)
Received: from chromium.org ([96.79.232.53])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d56e41ec1sm2513604173.72.2025.09.19.14.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 14:10:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	=?UTF-8?q?J=20=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Tom Rini <trini@konsulko.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Simon Glass <sjg@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts/make_fit: Speed up operation
Date: Fri, 19 Sep 2025 15:09:58 -0600
Message-ID: <20250919211000.1045267-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919211000.1045267-1-sjg@chromium.org>
References: <20250919211000.1045267-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel is likely at least 16MB so we may as well use that as a step
size when reallocating space for the FIT in memory. Pack the FIT at the
end, so there is no wasted space.

This reduces the time to pack by an order of magnitude, or so.

Signed-off-by: Simon Glass <sjg@chromium.org>

---

 scripts/make_fit.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index c43fd9d60809..a8ea41fdaf08 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -100,7 +100,7 @@ def setup_fit(fsw, name):
         fsw (libfdt.FdtSw): Object to use for writing
         name (str): Name of kernel image
     """
-    fsw.INC_SIZE = 65536
+    fsw.INC_SIZE = 16 << 20
     fsw.finish_reservemap()
     fsw.begin_node('')
     fsw.property_string('description', f'{name} with devicetree set')
@@ -331,10 +331,12 @@ def build_fit(args):
 
         entries.append([model, compat, files_seq])
 
-    finish_fit(fsw, entries)
+    finish_fit(fsw, entries, bool(args.ramdisk))
 
     # Include the kernel itself in the returned file count
-    return fsw.as_fdt().as_bytearray(), seq + 1, size
+    fdt = fsw.as_fdt()
+    fdt.pack()
+    return fdt.as_bytearray(), seq + 1, size
 
 
 def run_make_fit():
-- 
2.43.0

base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
branch: fit

