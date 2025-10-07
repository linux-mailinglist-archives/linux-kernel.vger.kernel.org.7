Return-Path: <linux-kernel+bounces-844668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C946DBC2751
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99F304EBE69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30902EAB6E;
	Tue,  7 Oct 2025 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHxmo1xV"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728D2EA159
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863368; cv=none; b=hoeHCPKWiIJZmOX6Aee6NhKD+20ZV1pl2wB1Pd/tUPiURKzFZWSL89KdFkBkvvj1PAWJXnsivvOH1ApHPnz756EbeD2Yd0hadH24h1MXq8J+gCoj7Cd6JCiMzKw3XCepK4eNZukJU0VlUAZ0QyCEn79lnjhvIldSej5qWOIkLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863368; c=relaxed/simple;
	bh=pSc7gPSIF4Ju9Vbb1RvH3FU3+BzuQdiE/nwuOb/8DcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Caf1yVQ1OSs7ufqVPP2D1JH3FNldH0RinLlyUdeVRjbauFD60syu3ObgJRDaj6FrWqRCsVnJEXcKPMjYM3hqP+/eTTV8ijkEtVAoPvvq1DqFqBhGlcPpGWVX/Hzt/p6235CM+qUj/oSzWu5m7skjfxQJr86PsNqO3wgWKBLMWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHxmo1xV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2681660d604so69893295ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863365; x=1760468165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWXmB+0eRU50OqdMozBO7Gp94A6Xe9er0qbuUMERDjM=;
        b=LHxmo1xVA7D/dIEE5rrb4+dUV+uU2OoocMEPzeNdE/WbjmeOW0KP9POgp+9E/aaHAE
         pnlvzoAYLF6DCNnkiRC5LIpcZzO/axt1ZGKmuCSvPcgnfAsiQPFTKzqfwBiVU1+j4aKf
         voAtXpVaoZFEf6xI9SJvvfTivMERMVn0uNi95IExgttkdGfjs9Mka0dJrkEoIU9yb6tb
         Y2ixev7OKy5yzOF416PK0NAdJ91dsS5nA4WFt57kCmleiQgzKUTV/HBe0gn1eGOtOK3q
         hOsD07mm9MYJ0qmCjMj+NtSKvxaZMHHdRKWwj7Ds63YfrpqW4hWhLizgruEliBj7RvL1
         XlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863365; x=1760468165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWXmB+0eRU50OqdMozBO7Gp94A6Xe9er0qbuUMERDjM=;
        b=bBOMA5o+E6c3dyacZjti+TJyKRL0ViEi+V0qIyZXZ6Y7Vvmb4iIfjg3RqQwmUz0Pb5
         9lbAT8IP63TsYqI84okC9YAR2YUD7QSfmw4nq5BdcXbec9Poo6WRZjlrQN/rjRV84D8s
         sBgryLdp/mmt6p92jmjIMHD0bP4RksGuo7HjxfHG9aLZi4CyNxgfwL2KoFX3wtlTvCP4
         gbrHQ/TvrQUSoMbAWdxY0kJJP0pj5cUZmM955+QXttpbCwZg8mID/cVtgNFfGyG2FTip
         sifgqwGzw52eTdvwDa1UzDeg/7YHaLyNQAcFGIQsrPgPhbLUKT2XOAXZVfIPvoWgzg3a
         KCtw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Wd4VmLHUCQVyPkeWfl/AGITN41ODW/vW6PSD3evv7qfTMYxKXbUdu3977O6sJhNlkPCamoVfFBujRUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ep/aWMfhvDoSW/h7BAfJV0tbDzRnYhFraW41BFCjI+bUvLnT
	huQqpZpUreHYmbxWyVhOqsvhO1ANAdb60K4hBmEspkm5DDUGSFcxS6N2
X-Gm-Gg: ASbGncv6J7qhjUOpseb6TmlsyfBfFpH8gnjMS1ELbxQw48C6EXuNQw0D1/+mrtA3UkT
	ZC+ghxEdGS2G7aWKtnFLePoZKejFNHXpMe/p5mYMC0HTTeBzUqOyD38K1vtm12WJFJ4Wst4RPUw
	WhLtT0ux3m6lMekIqKZmigosz9ytpYQFDyx0qYPVYXx74u8TTL/zSnB36+9h0wjWB48uQHS58H2
	SF02/D6kIOJ4p3fhuBmhAOxWv/xKVRjeJSpfeaA+uKh+uuVaG8xIw89VimPXbzGZMgi0USMWeHg
	HZDe6zRB4fuT5OpdBXyEVbbETCeaaD1iy33NMyI+TJC+qIb94pOs4e3bpwA73Orzn9WT0Sj7URx
	5gyr9hWHj4al7RsHI2mySl3JP4DtPvGrlyvLlyWb0qVzwm8dpLjCcWpi+B0H7WKj1Qg==
X-Google-Smtp-Source: AGHT+IGvYA4pseNCxAD0k16xn0xkIZT6WBhqKdCmXY+O/CgWIym5mkyzdw8u5N3F8B4gY3vtazxjYQ==
X-Received: by 2002:a17:902:d545:b0:28e:cc3a:371b with SMTP id d9443c01a7336-290272f8534mr9092315ad.57.1759863364543;
        Tue, 07 Oct 2025 11:56:04 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:56:04 -0700 (PDT)
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
Subject: [PATCH 6/8] Documentation/rtla: rename common_timerlat_options.rst
Date: Wed,  8 Oct 2025 00:24:55 +0530
Message-ID: <20251007185508.40908-7-krishnagopi487@gmail.com>
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

common_timerlat_options.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_timerlat_options.rst to common_timerlat_options.txt to
maintain consistency with other common_*.txt files and prevent Sphinx
from building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 ...{common_timerlat_options.rst => common_timerlat_options.txt} | 0
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/tools/rtla/{common_timerlat_options.rst => common_timerlat_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_options.rst
rename to Documentation/tools/rtla/common_timerlat_options.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 61b5b55be96e..f56fe546411b 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -25,7 +25,7 @@ occurrence. This tool uses the periodic information, and the
 OPTIONS
 =======
 
-.. include:: common_timerlat_options.rst
+.. include:: common_timerlat_options.txt
 
 .. include:: common_hist_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 6f09f30c74f0..32d33c792dcb 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -26,7 +26,7 @@ seem with the option **-T**.
 OPTIONS
 =======
 
-.. include:: common_timerlat_options.rst
+.. include:: common_timerlat_options.txt
 
 .. include:: common_top_options.rst
 
-- 
2.43.0


