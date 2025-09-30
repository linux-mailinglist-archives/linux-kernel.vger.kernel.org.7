Return-Path: <linux-kernel+bounces-837358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858EEBAC202
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560B67A2B99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE82F49F7;
	Tue, 30 Sep 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9dh15bq"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB402F6563
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222021; cv=none; b=EswqJcT0vGpREccJPUX1+BhWpGOFmk0yUbR5PMTL+s2lsx3QYAilNoKEGI4P1OBTE5kMt1Qc+R1BDJg65J3GV3HLrLzxnwExLFDlBDEwjtfwLU6EVDEbn/jCVjU1Da8JzHmA8EjR/gr6I/+q3GlNyRTQD+0lY98eS6IEzTmUQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222021; c=relaxed/simple;
	bh=p6iwdyUUP5W8+77ExyG+J/4KTfuGbStSzXc5YQJ6uQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqnXfgzYQm80M91e0DJbd3nJUKi1gMvMJKjeFLDBsk9s7ixC88rPFRNwDpoMeEjEzqq5sdr/I2suJEYAR/usr/0OB6R72dIk77K+2dcX1xJGK0OU12HN4PzUe4HKyEiizRKWwEW7/dUuwgnyOQSzsbaZjSNi4bvw5FE4veLyeMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9dh15bq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so47519685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222018; x=1759826818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zz313f5+9XsH5+Eb3Bh9XStxpTdiNn9ua8EWNmWWJg0=;
        b=f9dh15bq/TIr5hGuMsYYaq8g8FVEROOC21yX3JNqal3LzK1rwDh/m4xC+zHmKmJbm0
         PfaARLi9p7iKXAkSn8/2NMiDJ2xw5RO7nffl7xPmBa5Vu4PnziI2hYe6Cv6o8XWyVG8m
         SMzK9UQoAyYwMxTGMRRwvdhZxyrue7n6J58UTG+yJbJ8u7LAPpbBsxKSZjAxIvf08Qei
         EUC2zbiH36fyhRNsIXjdo+c+2MDtfkTqq454XJhaeKglm++iLmiqNih2tg7qpq8I+rTl
         OW19rTRMONTNKwL8f15flj2/KnyZM+vtWIiJZsMBPEZFSX5l0laJlj36sJ1ewZezkpR7
         z5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222018; x=1759826818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz313f5+9XsH5+Eb3Bh9XStxpTdiNn9ua8EWNmWWJg0=;
        b=Z8jPpcuspgE2GU5gWKlMFNhLKYeqE/LKa/IONHNwOoZBmxqH2Ih+Swfp0xMd2Xq78s
         IVEeNrD0+SQJp3iCmcrjrXYEBZg0O/FrocHd3rH7nwXSqXoekBZQYOjx9KvJ2z3RqVeR
         LwEYvI1NlP/cmp9/n646ynxLePhRIUPqwe3nHF3RxtTNFUHXshPGagjl+4zROf7lG4Bx
         EU+QfUGwFtNjv42Ap4JaRUPhTOTHimSEE/Ykyszny5uoa2oDyPZ+QiKDRkshF+4rIhXj
         WJSrOfKyfcibXtkTFx5esAhvWFN0azyNbgbeOqCzypaPJ0A/k/Nqd2kJ69hwGBuaIZdy
         kUgw==
X-Gm-Message-State: AOJu0YwUGqAosPhuZQdE1fFxqCFdCGFxFPrvwqQyYpslwZsEK/NHLosn
	qgszsDiciudD1dYIJ9pEEKGtuaK/h4Ek2ZjQZWLFcIuEZg9YGhZpZWrn
X-Gm-Gg: ASbGncvFEPymgSE0zS4XwQlQeeM5MJ3TUzXZzg7m/Cm/DrKEoad3Ip8tXHe0ri10Dii
	uWy70zljUejYkf5pmM868GvmRAy9yhs6bFORuiSMlEsWA5u2T+uFrd/wZS/toGLEAqxdiFhaBGQ
	5G1WF8S/jb3SILJtONzaVRA5djIlK3CN51SHZmd8UaOBTGBIVhmzOAyc85KbY+6qqyumxvOTcyy
	+Rt/9SQQhzPIbgNrgkY2HnYPYFMsQP4wGJjBqBIGNxO6YYHdrSz1sAzb1JyaYON+FlmenHKNDYc
	w2mYL/RcSk0pDul7JjatV2Qgz/1h+ftkbsPejkFp3rklx59OYeTHO6nzYi54ftCc4EekHSFXEkJ
	1fmgl4n3cJw/+69N2x+kE0PsLy3aUWYNvDtFTPXTwA9zObJv4pA+PjBXscax+H3ikDX2dihWnxO
	MUlbvqiWrn6edWvhyst7RqHA0A96jD/nuetUt1bt7c
X-Google-Smtp-Source: AGHT+IE5U4JjqYd6xwd8FJayS/jcOVFVp9zMugNYrK4b09ZbxPm2ncnyK5wWqHK+ARGFcMuJfSBjSw==
X-Received: by 2002:a05:600c:1986:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-46e32a057c2mr162105605e9.27.1759222017757;
        Tue, 30 Sep 2025 01:46:57 -0700 (PDT)
Received: from localhost (2a02-8440-7149-a758-f461-9bc4-1c75-ebc1.rev.sfr.net. [2a02:8440:7149:a758:f461:9bc4:1c75:ebc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f1dsm258242245e9.13.2025.09.30.01.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:46:57 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 30 Sep 2025 10:46:48 +0200
Subject: [PATCH v8 5/7] dt-bindings: memory: SDRAM channel: standardise
 node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-b4-ddr-bindings-v8-5-fe4d8c015a50@gmail.com>
References: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
In-Reply-To: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add a pattern for sdram channel node name.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../bindings/memory-controllers/ddr/jedec,sdram-channel.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 866af40b654d..5cdd8ef45100 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -17,6 +17,9 @@ maintainers:
   - Julius Werner <jwerner@chromium.org>
 
 properties:
+  $nodename:
+    pattern: "sdram-channel-[0-9]+$"
+
   compatible:
     enum:
       - jedec,ddr4-channel
@@ -118,7 +121,7 @@ additionalProperties: false
 
 examples:
   - |
-    lpddr-channel0 {
+    sdram-channel-0 {
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "jedec,lpddr3-channel";
@@ -133,7 +136,7 @@ examples:
       };
     };
 
-    lpddr-channel1 {
+    sdram-channel-1 {
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "jedec,lpddr4-channel";

-- 
2.43.0


