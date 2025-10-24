Return-Path: <linux-kernel+bounces-868619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC1EC05A22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115541C21468
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573333126C2;
	Fri, 24 Oct 2025 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgcxY7St"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F9311C13
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302386; cv=none; b=rHcQuyBKxhSFzd2tgH7FeKn60plyGUCyvUNh1wVvmC3FCi3g3SEK/Z7o9eaOKMkQ9vQPaAfB3Q0gyGxh5IsQuR7G4FwgZZSFsDRyiokoXmW2Ba7Y/S2ANO+6PlnpOwqVKzuyhDGEC++IGkxqiX/AsuL2dqIAydfrJsLcnEjgfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302386; c=relaxed/simple;
	bh=1nfGRu+cQpdVI1u/u8x180bJnux/Aad+7XEoPErLSSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8XK6tkvuxmx/0GkhMNTMegz18agxLts+qEsGMBgZVk76SwCVXAGeTLG7JRE73JXj7BdDEI9Zk3iaOD25kl6n1SAXFh5vBktZlwidppVYnoexQGEh7JBY1II3Dbs3mojwZcSUWwNmcva4Jvi9tts6k7yhBJVImdBbJqNSMa0zQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgcxY7St; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7811a02316bso1437396b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761302384; x=1761907184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWxMkV9WkPnFS2UeBbKIDfqnrrcA5FBPCACezmc2M+g=;
        b=PgcxY7StUt51s63WVQdehNhrOfL9B0i2DztlDlDJQ+4r1b5ghB7R7GhCWZpXZJ6UF0
         HfRUtrJwbKFKAmy59Jmkiz1Jr7uMHzvJzQEezaGEzf5fs1mtL4wyurHaLVtATuKct1wb
         s1CTISWIt094EvZcoHm57qLuzPpiUbkouSghne3Pm3lPNR5fB8agcHxks9H0tSoDhIIC
         PfUScCqm5x/wKX2or0uV3IjoXrLSSJdWWLQ9BUP4UVS8temLEF9lkzB+JHWTRF7STB6G
         W7dOEG95kja30Bui78foFfBMf56FxsFJ6eZ4COEHHLMYrZ1COfYKTt1Aboypbii9vmgU
         Je5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302384; x=1761907184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWxMkV9WkPnFS2UeBbKIDfqnrrcA5FBPCACezmc2M+g=;
        b=TzkvkEHS1zb3PcRddfKyHxEIo1WMRREMzzhnJ0/kSpQSMSne8L7hlfln9+JFr5/xHR
         0nXZZQRYdb4tdNDZRNhm4m3U+Vk2Ygywr7TYWVpgSLKeeGnVaPlDXRolmClp+qLjd9+j
         QlR4AXO3GB1qy0g8J1Jwd8i6Vko3KwrGXmJ57SoF0aiKZMD9wxFfB9+owy5M8Q15s5+J
         GGTSQ3Esb3/tQzLBpZBMub4ua6eqXlfXxm21jl4gegYm9kK1LuEPiM7/UpEVrLWV+FYw
         YNeAadmXm6PBrLn2DEm1YR7YZnE9+VOellHZdMtYkxsyr/xW7/Z22cIqqZRU05ZJJ+3o
         qRuQ==
X-Gm-Message-State: AOJu0YwPzLSvbzhjMBACSbhicgzbxxrHEaBn2tgjUlnEH4vlrhC3ILly
	9tabsKd4atm07YqbB368GpuOJRrNtRQWzQw1LIj55mKi/wcLVL4O2mz7
X-Gm-Gg: ASbGncuQQnGcbDIgvHc1Kw7R2j7Sr4piE/KNXEjaQhrl5wIeOr/WUqjtlrcO2E8w9Mv
	PEHC/Kq9+ir4ZY5PTXCMw817Lq3Ew25LPY7gfw7k3R57F7DgmH4CDiZGvtAf4SqkjoITHYB8y1K
	D3QvGMJSiEuZ0pFGzA4tC0f/E5fwFDpYzNnfu+HkmNdUR6wRlFcuyfKXsrIGERAUJmfKhMIufAL
	xMfQs8aWXGrBT90++wrcrAQTiyTBr/3FWpIuHxsxngIF2P6ZFjtNYohYp1ZLk88p1GKND2nqHM7
	r+bymuKs8SFcP1t/RdMkjRf/3NdV93A8oNimGtZZrgZnZGmcWR2bX/iAFuQxrAl+EfT9DxnStGD
	6vC8PS5CE5s8ynzPLIxrR/j1yuL6ZT7jn2ru4bLYhw0b9+MH7qyBdJ/KAJ/xk8ARGR6sxxXMu/1
	m6lT2jtpVF4yc=
X-Google-Smtp-Source: AGHT+IHEpl3TWDi9ZPhQso4ALduIvZe4iZeYs/TaKEmgdcaL9V+ffUdhwOZmNlpvsTLhO8POUDfQVw==
X-Received: by 2002:a17:902:c942:b0:26a:8171:daf7 with SMTP id d9443c01a7336-290c9cbc096mr4811285ad.16.1761302384008;
        Fri, 24 Oct 2025 03:39:44 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc1cb8sm51175635ad.53.2025.10.24.03.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:39:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A81AE4209E4A; Fri, 24 Oct 2025 17:39:36 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Input Devices <linux-input@vger.kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	George Anthony Vernon <contact@gvernon.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/2] Documentation: hid-alps: Fix packet format section headings
Date: Fri, 24 Oct 2025 17:39:33 +0700
Message-ID: <20251024103934.20019-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251024103934.20019-1-bagasdotme@gmail.com>
References: <20251024103934.20019-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=bagasdotme@gmail.com; h=from:subject; bh=1nfGRu+cQpdVI1u/u8x180bJnux/Aad+7XEoPErLSSQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBm/w0665IjY3ynzumWjmFlU9WajRq/nxTturx8uSVz+5 VahSdfVjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwk6DHD//TLjxf7ybqqsfzR sJX32i/WLXVh1XyRC2GV6gH2zgvm2DEy7N2VLVElw9ql2TLXOE6DM1Xm67zIj2YWa1fuuTiB72I IJwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

In "Packet Format" section, only "StickPointer data byte" subsection
heading is shown as such in htmldocs output; "Touchpad data byte" one
is in normal paragraph on the other hand.

Properly format the headings to be consistent.

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/hid/hid-alps.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-alps.rst b/Documentation/hid/hid-alps.rst
index 94382bb0ada4d8..3a22254e43464f 100644
--- a/Documentation/hid/hid-alps.rst
+++ b/Documentation/hid/hid-alps.rst
@@ -104,8 +104,10 @@ Read value is stored in Value Byte.
 
 
 Packet Format
+-------------
+
 Touchpad data byte
-------------------
+~~~~~~~~~~~~~~~~~~
 
 
 ======= ======= ======= ======= ======= ======= ======= ======= =====
@@ -156,7 +158,7 @@ Zsn_6-0(7bit):
 
 
 StickPointer data byte
-----------------------
+~~~~~~~~~~~~~~~~~~~~~~
 
 ======= ======= ======= ======= ======= ======= ======= ======= =====
 -	b7	b6	b5	b4	b3	b2	b1	b0
-- 
An old man doll... just what I always wanted! - Clara


