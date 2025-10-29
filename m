Return-Path: <linux-kernel+bounces-876223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D024C1B089
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E79E467075
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB8319992C;
	Wed, 29 Oct 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB6FDNwu"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22921DE8AD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744816; cv=none; b=lOnyK29ttt1TZnjsP2jakJ7OXq6XZbfFSB94qDSuE7BOxeHad9kX/5D7Jr+Zs27tRgaQ+SGZD21r/hk5+hMbtoy4Q/d5FkxOn2S2tqxP9V/cfApXA1McBuGVg9hjamlgQohbXenhRqC+OEyq65JWkF81dKT0rDlAaaH8ff90Pfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744816; c=relaxed/simple;
	bh=nsjttZq8PuEoDQMx1bwWfoY1j5ZCVlCBFQu8V8UWH+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NGrmjVVjNBFutCqHkeoxc6p7Be4lCGYp+hZUSNcILyf0Yr/LfZrycIYm+hgWoxXbczLgt8/jPeA5vEkw3Cyb16dEfHWckjcoEccZq/qOHNouJq1X5z6dcVPzc+AihnVIedMPLz8iRLH205v3abRmGQ2KtJetTGPiHrkpgAFWTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB6FDNwu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47114a40161so81861135e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761744813; x=1762349613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WF7nqrj2THb4vlhOESgpe7tcZwa84JrbSuJCtvoqqIc=;
        b=JB6FDNwuXCx0TpgMywH0OPZx9zz5uJmQipNj2JloxT2sHFCDAKvfxQP2fTm8wuk2jt
         0dlkrAHs9wEzYQ8dnjyGRAXigIfF0TBJW93o/tui4CcyouUlAokHH1Xr/1Ogs21cj+in
         QzX+ogujvTF330RfPosjmJ8TuRisFQcTrleBUXH3Zrh/uB4VTacrlHeVT1uX2l/TvSeC
         juuaQiP0z6c9nBFWLU6MrVnhzCY1Gk0K+J5V5Fcb49WZLbVvrSFhlNjuMFIRTpFmtzKx
         VsUEoQPJZTfPQLbWS+AEWT+lfuRVv2SuPti3iizrCvv8yVWNYw749MEFNO1/UBB1h8PX
         F0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744813; x=1762349613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WF7nqrj2THb4vlhOESgpe7tcZwa84JrbSuJCtvoqqIc=;
        b=ldZqnYjqMjr6pdLGMFUML//K4am0k8m/nZ6vPrbsPW1nkyUgN0PNKx+6+3SiDiPAi7
         lNC3n+xJaNQOVCLajWSQjv+u9e+9n01sMgUPJgNvB+qZ91mZLT/0Y3ytSI+f2FG0ZEXX
         Z7m1q/H35Gj+jgDqBjdjG6BYH8wOBjWXbubFGfHIHdb1oXOI7B/cfvZlLLATMfmxR2b4
         6FLTr+BBMWjGsXlC1Mzu6ennD/8fMyl1t36/ZglphgevFlb9W1IIJeHEyoNj5kDMOSGJ
         eiTczx+ZD9kTR4K1RJ7XmpW3HW369nFsMufHete50638iGdJk2WZW4pSp5ANXspeBYWx
         NMVA==
X-Forwarded-Encrypted: i=1; AJvYcCV3bLp+xpANi3nnvm/qZM0Q41IB2WYg/noEy8jaxijru5O3wynByqTgVFJTWktC1dtX9alYzFbKLBWODwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPVK+5PZCnWO7/oQda85YLyWuB4EB20NtAxhTFgo22vNoXXJE
	JD7bOAa0kCeMz36wnYOuxe7JmgB4Q9jyoxUvfyJ5hBIeic2Dw4kgTjK0
X-Gm-Gg: ASbGnctCl3qurJUQkVBtxkWqaMiOPvQ/gvlYR008PXMZKW3MfzCOhz0lOj+0vAxYt9l
	FGSlRNHF9ivulpvpg15m/Otfa0vQ+9w+26GNUnk6MQ8T5OlOLNzyoVcYRpuN+APLdoVqBFPKCFr
	fEybLZKTjq+62WwTYzlbJpb0M/Me0VrbsgQ57Q/+xQX+9MqEw7X8byvbrDlje3tms5jdHud25W2
	ooIPhiI3URgxu3vIDfXeQuOwCNMRAU4CD0ja4mtGWv8AO0AwFHVFsYOKCfKte6BmDY6nNXjDlf8
	YJQz+x03YHKBJbTbulXkW701T4t/ZT3foghshWWwV9T+xjH7Zp2m4MaP7NNosU8w1ljnSNSdxiO
	j+JTt65n9So3Aj1kzf7IHDwOF1kk/9zNNsPDg5ldylrscRECA/ZBnbhA+9MIuOhtKXFxxqRpWqj
	sNDpl5MRqRVpKSXpOz+kaH1PJ3+Sp1dw==
X-Google-Smtp-Source: AGHT+IH1wnB+c+Tv3QvNjludDqom86fj/5j7GLlptXYKIF9eMEqcj/69GJzxgHdIDmKX/xBciiwWGw==
X-Received: by 2002:a05:600c:37cd:b0:46e:1fb9:5497 with SMTP id 5b1f17b1804b1-4771e360859mr25948655e9.18.1761744813034;
        Wed, 29 Oct 2025 06:33:33 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4771e387a14sm47955195e9.3.2025.10.29.06.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:33:32 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] err.h: add ERR_PTR_CONST macro
Date: Wed, 29 Oct 2025 14:33:19 +0100
Message-ID: <20251029133323.24565-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ERR_PTR_CONST macro to initialize global variables with error
pointers. This might be useful for specific case where there is a global
variables initialized to an error condition and then later set to the
real handle once probe finish/completes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/err.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index 1d60aa86db53..a38071881b20 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -41,6 +41,14 @@ static inline void * __must_check ERR_PTR(long error)
 	return (void *) error;
 }
 
+/**
+ * ERR_PTR_CONST - define a const error pointer.
+ * @error: A negative error code.
+ *
+ * Like ERR_PTR(), but usable to initialize global variables.
+ */
+#define ERR_PTR_CONST(error) ((void *)(error))
+
 /* Return the pointer in the percpu address space. */
 #define ERR_PTR_PCPU(error) ((void __percpu *)(unsigned long)ERR_PTR(error))
 
-- 
2.51.0


