Return-Path: <linux-kernel+bounces-818134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921DBB58D20
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AF8525D15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EAD2C21C2;
	Tue, 16 Sep 2025 04:48:21 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79027E054;
	Tue, 16 Sep 2025 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998100; cv=none; b=GZvwpE302Kcs7sWcRG5yMH6wtKQY0P2dgpO5PAPOORbBb5SQPOJCXh571i6lnGgdhILZAYX727BGZsRaZF+WvhFXeLhLVJm+xmz72HkvK5PrvukXM1dHdl7/cCMuTwdd+EQy73v/c+s8y++Fus/cSyr5yY2+LGhXEAANm0E9DwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998100; c=relaxed/simple;
	bh=AR6U9NTv5fBPqm2mceO3JzfYwF71DRRrN65zglH87xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSLBJzfpKBku93e7f8jMmH19MN0SwhU9VsmK3Kddyn/AEO5ECr3B0MRkBZQ/UI0P1GzwHdpUm31y/0LLsiegnWpZ64i8FarTfryssFKEZzIDMOHlwmNxx+/wGeXUD7Dd/lP8KsRNA990CTNLj4pmrmuAUwEBjAb8nZBWhKqQ/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=linux.spacemit.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
X-QQ-mid: zesmtpgz6t1757998024t25be8ec8
X-QQ-Originating-IP: CRbU/BqZ3ifO5Zk5VW7xeMK7ItiPBn/+hHjhYzxfN2A=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 12:47:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13986833674161826152
X-QQ-CSender: troy.mitchell@linux.spacemit.com
Sender: troy.mitchell@linux.spacemit.com
From: Troy Mitchell <troy.mitchell@linux.dev>
Date: Tue, 16 Sep 2025 12:46:44 +0800
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Sensylink
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ctl2301-v1-1-97e7c84f2c47@linux.dev>
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
In-Reply-To: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Troy Mitchell <troy.mitchell@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757998019; l=876;
 i=troy.mitchell@linux.dev; s=20250710; h=from:subject:message-id;
 bh=AR6U9NTv5fBPqm2mceO3JzfYwF71DRRrN65zglH87xI=;
 b=Jim1MZ+S+B9l0ZyWqB1r9SK3Vo+WowQzuqHMzsJxsr/gL4p7keQet/x7XN57H/nKexSTdfZ5c
 nfX7frsj2/cCqJ38mpOJfmja8yfkQD7pYTwL8gGNzU6iM1bSZoiji+c
X-Developer-Key: i=troy.mitchell@linux.dev; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Mtga1ChWHZ+UWVwNG+XqePWTpiT4hdjWWUKbGBy4vUhyA9yl07+mLds8
	+lJHggJFosKGvPuCk2q/UpnJWc6osjWu6C8kTAWAMuvk/WQAYhCQglLjZPHcwUOrebgbd+I
	Mci2C67QTwhEyYfEGlpv8qENUTHD4bI9/QCpqcmbverQG+cpACRAFC3Em6N87e/uz8CHpFC
	JHJPG4e0Fdv67d2t1FEmKBSzMIA5IcUm4219SUcsuEj8AtjvqsHEpc1zLjCnKQ+hMxb1bk1
	i+kqMFRPzxtYVbWjOYGTm/pTUbzydBvXvtru7+1WbbLWpoRIzl8w1U4L8/CesAeOBvLJex1
	hmcx2WAOpa8ZzAslujt2+x1jFwcDHSTtxYq3TMVuSLGbnfI2oHv6b8vtu6eHchCuy3xYvxp
	WtlK6faTZ/it+pLOFk53UT8a2MXediNY9T6povmh3lWRjrUGAFX5x3l8ss+srrSRm5QK8s9
	/wEQW/4ivpHZaFRIhUb//PivM6qdpimR1mtXXLJaY3AxkmfBldsBecGGA4kCf+c7arNazjk
	xBd9eHueALxaussLJsJtLwKVRYICDAraG2bIXv7QI++dv8y2bpZS3Qvr8Oznat0bAsr0O4q
	A6TZNe9dfwFLB6B4xKcnFGpxoGWnJabt8PNORr72Vi/EYsznJxOFsXjL3VMFL83d22eXgcy
	x03ecRj+xIILGLKUmAGUxRNjKFxmMYPxTGvjoY29EglqeXsSGHGpEc7RPaed0TdNa8iZgGS
	9hvAXgTJyE0HEp/GrCLwj0kEC/e0ZHaMUIaOezVaAIIRRgaHGIr+hImgu1cU2VVtSYD1xI+
	WtBdJTG0T4FKX1BC9XC9Vsh5+Pfl3jeY5ZVeqY5BtGwOcbyEwYUSdpluTXuUpP6Z+J3XJRF
	FPyjML3AIaVs4QvT2uAuvHAagAbhILys8o8Et+yl5wFC7tDSwqPipVXYm9nUav4pyoK17uf
	MLQbOfvqYSGaHPS1jyhnQZqHVJyeOlqzBQoKmXWZTBqqw8aNUcBIk/xdV9+cQ824XCDhhXn
	p49C/85bewr92N8jnxoScxmzU5brTaQWECMn53vn9UpbaxubNM3IiDYF93yrg77In8nDikC
	ul4Lw5kA1EbENq7F+I+AhA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Link: https://www.sensylink.com/

Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 77160cd47f54079a39f35b570d69f7c4c2274724..ea4011d64ab9081d212a738839849d5814cf6c98 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1353,6 +1353,8 @@ patternProperties:
     description: Sensirion AG
   "^sensortek,.*":
     description: Sensortek Technology Corporation
+  "^sensylink,.*":
+    description: Sensylink Microelectronics Technology Co., Ltd.
   "^sercomm,.*":
     description: Sercomm (Suzhou) Corporation
   "^sff,.*":

-- 
2.51.0


