Return-Path: <linux-kernel+bounces-772225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD2B29029
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 21:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04A1AA883B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3A1FBE80;
	Sat, 16 Aug 2025 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Owlow8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE9450F2;
	Sat, 16 Aug 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755370902; cv=none; b=RucPElTeHB8g92WM/8DHGVVRwmwStuAEYv9FX6K8mb3Xx2CyEfrIgJ1asAl4RGYri36ZP++TtbWler/Aw2ADQqFKq7XfNZdu4pnfMOOwhOCljwJqeuQivRktJmFa64eExbEPVqusL4EaEW1+Q9qaLNrdYgYyH+b6Y8HxpN7ubOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755370902; c=relaxed/simple;
	bh=NMHQWek6hJCAFu2VRXW9YhQZ3hluLQdp9qccjoE3vCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cslI7ViLNN/ahMKtnXTLEz6z8M7/4s4mTcA7CJPJN+vmgso4v7DZNCoXuQl1U4FvtocPFeUSAIcFH9UubIBtAqw0uGk1PWkJ7MJJa7qq+XMeapLELYcdJH2hrBcTQ49W+36gCsawSr3hEi8s2WvSOGVRQU85OmkNYXJsMGXJvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8Owlow8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so21979785e9.2;
        Sat, 16 Aug 2025 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755370899; x=1755975699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge402z6OscbL8CU2G3ApWQ3/4su8++yMy2rU7voov5g=;
        b=Q8Owlow8C4lhWXtSNKrYaN5z/3XllqAwygvWuBZ96v2vnnYIHKmewF+O/mzZuFVOWr
         SPclIZlLIHr6zWaI5AUAaIQgH7u4gwvRxJo7hcVXjAd/SQK2OWCZQJ9YBEqlzcGJcQN/
         m7j+jvFE/KqjdG199nVGtpP7r6DlVkbv9oTaP0d55B4rTlJCSP3imdN2dpYY/KknQCqJ
         PIOj0ON/hP8nPLVp1etUJQru0OOMkYHTYNqVdNBgs1euqnxxj2AJ6223DjHLNp+b7+wW
         lvJRpdfng8pZmtHqUSZvfXBkCXl1oHLJjh8BNfy0grxtvRHaZG3jFKvP8XMhSyUZ+csE
         2MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755370899; x=1755975699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge402z6OscbL8CU2G3ApWQ3/4su8++yMy2rU7voov5g=;
        b=tA/cPdHdRAtuq0NlrF/QMQY+Y+vdn2zf81eYlIVvpAkhPw1VvLjw8Msx56O/c5xaA8
         4qtdVqxqGMqgQ+iULrtXz7wHrs8xq0Gn1Z9iao4bCb+LAgn889qA3KwXbzd0nVQctzcE
         M0vRgGOc94OjPIrQrjQ6nlodMXJalhaD2kL1OuSFHtvzYUP6/mybLQ1x03R6erY/qeVF
         uuh5OV4LipapPVO2172pGQqT+e4IqyG9lH/MQbTJJZ0ueAAJG8VGlGLyrf1KDhIp6NVB
         FMZkSjQyq2FnB2VK8MsVdtcSM4EkLmWVdr1zYTucPngBbkSkn17oSR0bTroqpRg760vy
         URig==
X-Forwarded-Encrypted: i=1; AJvYcCXvYezhrtj+BniGGVdcF4BZlaZdQcKCNKx2UO6dTyRE2GfGUtODaVdlNJc5GoenKnq4hRxtIkptO1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3b6vi1RPLc2VJ6oB3b5qqCCeZOKqvRCsy+KR2h9MfadSpF3M
	WQuW609QNdenJDSUYzFnk4zRUrraCo8ADyQmRPhIxTKpt+j7+zznX0CI
X-Gm-Gg: ASbGncvBFJifJFVNCwNyzvAUf3lxsfdiKuuDYrJM4n6+CO2SVUX7amXKZ0L0DMdQGe7
	S7c1zzTdMlrHI6nzqB15A3OmxJwh3vzZXWtIVHYOtf43hOcSivUTAvH5e1l+o2xEA15+h5TDN5L
	j9V9JTBMqCQDAOM0yjepSxh1H+i1Uk32x8wmpaNjEggiL7TjBb5NiXsVUxvYtiCwanYOKj698ud
	4Ecn8U1q1h34EwP3ds2OHlQj/l8Oq1Xay9kyDnuW4VgocBOY44YzWmaMPUKBwSClHD0BJhp34qL
	AL5N94VVGp1aaYYMrDM40vPe65oQvTE9/nvkTpwKuFsOvinhSdBj1vaJSt+rju+AdyXxXx9w+j9
	JQICGXlrBPbMvo0FnBFSnhVn4q0AhFGnF
X-Google-Smtp-Source: AGHT+IFtveIIDTcyJAnjHia9tIV1AvmirXxSlVv11WsL6hk8Z34okLiXhF2+XZpD6tAQX8TpSeCydQ==
X-Received: by 2002:a05:600c:154c:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-45a217f1cf7mr59689355e9.4.1755370898887;
        Sat, 16 Aug 2025 12:01:38 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c96dasm6608999f8f.43.2025.08.16.12.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 12:01:38 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: tglx@linutronix.de,
	bp@alien8.de,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH] docs: Replace dead links to spectre side channel white papers
Date: Sat, 16 Aug 2025 22:00:28 +0300
Message-ID: <20250816190028.55573-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The papers are published by Intel, AMD and MIPS.

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
The MIPS blog post is nowhere to be found on mips.com,
instead a link is placed to the last time the web archive
has crawled it.

 Documentation/admin-guide/hw-vuln/spectre.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 132e0bc6007e..991f12adef8d 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -664,7 +664,7 @@ Intel white papers:
 
 .. _spec_ref1:
 
-[1] `Intel analysis of speculative execution side channels <https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/Intel-Analysis-of-Speculative-Execution-Side-Channels.pdf>`_.
+[1] `Intel analysis of speculative execution side channels <https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/analysis-of-speculative-execution-side-channels-white-paper.pdf>`_.
 
 .. _spec_ref2:
 
@@ -682,7 +682,7 @@ AMD white papers:
 
 .. _spec_ref5:
 
-[5] `AMD64 technology indirect branch control extension <https://developer.amd.com/wp-content/resources/Architecture_Guidelines_Update_Indirect_Branch_Control.pdf>`_.
+[5] `AMD64 technology indirect branch control extension <https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/white-papers/111006-architecture-guidelines-update-amd64-technology-indirect-branch-control-extension.pdf>`_.
 
 .. _spec_ref6:
 
@@ -708,7 +708,7 @@ MIPS white paper:
 
 .. _spec_ref10:
 
-[10] `MIPS: response on speculative execution and side channel vulnerabilities <https://www.mips.com/blog/mips-response-on-speculative-execution-and-side-channel-vulnerabilities/>`_.
+[10] `MIPS: response on speculative execution and side channel vulnerabilities <https://web.archive.org/web/20220512003005if_/https://www.mips.com/blog/mips-response-on-speculative-execution-and-side-channel-vulnerabilities/>`_.
 
 Academic papers:
 
-- 
2.49.0


