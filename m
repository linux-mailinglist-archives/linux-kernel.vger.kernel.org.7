Return-Path: <linux-kernel+bounces-890801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD2C40FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7149934B845
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAEC333733;
	Fri,  7 Nov 2025 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS1FkbWd"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85E91CAA4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535600; cv=none; b=QM77o9sPhvejo1+Fb/hstkEsXS4sFC60LFzen6me2DLt9sDV8GMLB64tUf9Q9pamo/CyHBuqB+xcbcJdYWBvqhTlQw+m/VgDdWAAK7BqrsyNtkkk96/e+mEFt0wwWSmUh5om3cNDkXe4ukySgT84jv21vE9/XI1QRYy+2H6F/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535600; c=relaxed/simple;
	bh=+foSY7njvUrejdgPjbH4fKfq+HP7j/XFMPQuEafrKZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YxJSRL6D/2E8VUIjpMdGS0ev0sjOLZLsy+iWEJDz0YaGRSHuHqo3te6e+OC9mXTu2o9lDJhA7po/ibMemvnO9CAFPI4jxojg+JsVVclWchkyn81Vfhvkn7OAUGMcA14yNgPmuKSI/QFPnOVqxbXeDgNAvPO95ne4Jl2P1JWyfPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS1FkbWd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so1289860b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762535598; x=1763140398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMmbEyqyLZZJZwZ+03cq771i48PrvXqZEJWareDoknY=;
        b=KS1FkbWdZRbr9mbsisq1bdAmYCWet7PQOYgEKyB5OcjU7S2gNxFtH6ILguc0LD8fzI
         fRMRgePNNTfEnaXbJVqGMzh3fGdg/K7va2ZYNa4xeqq20r3C43Nln/oDk1FmhItjA3Xf
         bt1CoBAxXwE+vPF7m7uFJVoPPsaej4wDekF0MHHAgefg5D6Mz+KyPgExJXy2dxjWR4vt
         fPCQCx3lWIdnhEhADFV8hJr59vWO+3YgPJN3XAiVKq6hn1vBcJvuIFM1m8WRZ5teDYo7
         8QD6P3yXi//3zTVBQqxynvzVNnshZx+rz8pMCvstDMkKvccut1XJZ1St+wqsAvIeQgNu
         Xbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762535598; x=1763140398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMmbEyqyLZZJZwZ+03cq771i48PrvXqZEJWareDoknY=;
        b=NbOSkaj0cQ5z0/wEIBvK4mJcVJStp9LvecnMXszYyG7G10lCf4PCSUBm7yvraKPXOd
         vmjn8GTPOQ/480WRUgBHONRrRbFhKgeiRLl83tHZ/uhZ94OQNAY+bzJwfetYc83PB3vz
         J6XyFWTw42QnmM7Thg+zkp6lQKKUGGgTOmKawncn7Haqs+RQMFxRD2xLs5OLocNVRJ5M
         r8gqepvZRo4MPNR39OuuT25jMa5cv/H/NYXrPKGKNT/6BHOMT8TjdHSl6+spwK1JEw8q
         fB4ercwolBXTJ9CCC2zQlb1gQsc2sj85CUAAySwtRsWsLbJD2Hjw0lDbMN4hqBAjfUPN
         Yrww==
X-Forwarded-Encrypted: i=1; AJvYcCWR0J0UJER58+aACxkmlcJOVjdijj1Q2/G88Bg02uejQoLdWK7ZRjaLzEcI4h0PWrp7CjrCwB38HINiJWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ksb+MHODBqeFy6+Md2OyAxWR8yiALtt2yJLyVe6zB/iEdEWj
	LhM4TrZqHKw7w8srW+jGN5ZYsupdPSOepCZEZXBEfyYwZ4/7nqsI81L5
X-Gm-Gg: ASbGnctHVUCJtNfpXBmvT61xm0beYaz2JcwUg7ouPVsQuWeTPDnCJ7gDxAPUbQwklrb
	HLoLNc/EKYdPpmnHtoMXreJFVbXRhJ3ANk0Ikp05HUQUw3rKXDyUu+FZzEjKBIIH0aqlXWa2kfI
	6cZcVF9trXMrBKEWRzFtdcxsRJ0KJOWQxPYSRIcSFaI8HffM/pFjGGiw2k7uGo4H7ozd3gFolUp
	KSMCigWD9savolM5/ULCM8M5jMLXGvVpdV9IAA0Rt2W9URsYaZfionbIaB3XsaJg43VMiXLq7n6
	7r/VXufOBUneD56TnGQQ0RNyUL0DvcRpQXZhHVhjT7ITQlM6m12Pya1JPNdNnsI1WBWsIDzrw2S
	0sKDwiZnQvjTw/nB+pRPcEkSy8IRzfCUz0PPv46/1eCE7ib7DJ5htHz7qxSy0MrNkr5pwiCx++p
	va0mMYMGx4ldJESe/eewTmlN0gaz5rZJGbf5V9cih01qMoAKLg0UXJPps/GkyI
X-Google-Smtp-Source: AGHT+IG+u/D2ojHAFZCIpbCUQXejiKa5TSmyEEakzXpWUyiNnYGjczDrzbWmmSlnUvwW6TozznD9fQ==
X-Received: by 2002:a05:6a00:1250:b0:7a2:766f:5198 with SMTP id d2e1a72fcca58-7b0bdf68b4cmr5140598b3a.29.1762535597807;
        Fri, 07 Nov 2025 09:13:17 -0800 (PST)
Received: from localhost.localdomain (61-230-132-96.dynamic-ip.hinet.net. [61.230.132.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff848bsm3502732b3a.29.2025.11.07.09.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 09:13:17 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: luca.ceresoli@bootlin.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v2] ASoC: dapm-graph: Handle sound card with space in name
Date: Sat,  8 Nov 2025 01:13:02 +0800
Message-Id: <20251107171302.2228-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the name of the sound card has a space
between, the script will fail to output the
dot file. Consider the case to generate it
correctly.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 tools/sound/dapm-graph | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/sound/dapm-graph b/tools/sound/dapm-graph
index b6196ee50..22993317d 100755
--- a/tools/sound/dapm-graph
+++ b/tools/sound/dapm-graph
@@ -174,7 +174,7 @@ process_dapm_component()
 
 	# Extract directory name into component name:
 	#   "./cs42l51.0-004a/dapm" -> "cs42l51.0-004a"
-	c_name="$(basename $(dirname "${c_dir}"))"
+	c_name="$(basename "$(dirname "${c_dir}")")"
     fi
 
     dbg_echo " * Component: ${c_name}"
@@ -201,7 +201,7 @@ process_dapm_component()
     >"${links_file}"
 
     # Iterate over widgets in the component dir
-    for w_file in ${c_dir}/*; do
+    for w_file in "${c_dir}"/*; do
 	process_dapm_widget "${tmp_dir}" "${c_name}" "${w_file}"
     done
 
-- 
2.34.1


