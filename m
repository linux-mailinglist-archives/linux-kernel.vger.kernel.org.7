Return-Path: <linux-kernel+bounces-894162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5185C4963D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730803A5E46
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B8302142;
	Mon, 10 Nov 2025 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO64wu1w"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F380328622
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809679; cv=none; b=kofn5WRWXFbb2J+Jdrfvue6rNJ3vxdAhJC/Zw2c3NOO3VxYc/doo9XEAdRYhjTQhrOO2dTAD1WtG2q2iTOBn/FdUKSLq2JLUK5bok/xHHGYH/D8jZqLTv2pDsEsLNlYpZFhbaq1y5U71QLppEH4u9cDADRy4WGk+n2W8mFwYsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809679; c=relaxed/simple;
	bh=qBrq+iwChJzT/MhlLixa2l6p7csrPqfs2BxOGHJ9chM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRnMMPrEDKlU66XmAM50WNEstECWc8a1Me8uleIsdAZ8IebT2ZePSkT3+RDlN81/c2xjKVI02ysFPrDw7Jd9V248pnRFuqyaIvA8+kM7zbuICgzSVL4iKo505ypYcLYIXw9Bh55eMTIsbjPCjA1/P9G7q3L64nQRJitwDygXP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JO64wu1w; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b32900c8bso1066091f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762809669; x=1763414469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QptTM5Ixuo5m5wnXL/4qGQKCVgxSmjKUYr1TvFp0E1o=;
        b=JO64wu1wonsRpyeNXFwroNXFlFQ++O+08sB2IXVMicOfBuni8ck1C1ytOFircm4eZm
         Rr97IySPWnsKcwmOs8feh4O4XZUEn8jC5N9HNDlR+fj8RGWS3rjdeFeBIBPv2hUCp74P
         pcc2hNLwnT0qOIq/c+PTp6uJGCusBFiA/EtlM/NNdRlXpeqblJsmWro0R4qpL4lMc8yc
         A+XTq4oD8GkLaaSjBwr9ineB9+nNwCQawYSbvLLszbJgJ0ZMGgSlOSsjQatmn+mwlLcX
         Q9tARiSjKFaNAvB/K0fjDzulNweeIleuadJKNbc2ly3rgGDrSV8VIX5kbRd8BTt4asXT
         6c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762809669; x=1763414469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QptTM5Ixuo5m5wnXL/4qGQKCVgxSmjKUYr1TvFp0E1o=;
        b=baBE+PYlZlm6vZm3OmdttdeZuuGNhNke3HvhZh9gyGw+Nrh+ErxucI1LVuenlLkqvP
         N5WRiR6IzUd21WACdePD2Evn+hT5wBtNDfzod+uK/uADVoHGkjJ68hUgtLDxdxT3Bgsm
         qp76lK0LJdU9x9IEQkzWUuIDhxM0t0j1sB2YMtld+vWp9dHFhJ7vDAvvV+iFZtfq27Wx
         gr7G3THcmJM2KLgLIC9CBHWasVc+2pApZ1La2VVFwhUnyHVC6sdQAu3Rz09+idX5Sls+
         bIm8HxSaujYbmF4an+GQhI+Y7T5il7Uk6dlgP1YRq8nNLPZ0T/RKYTqAPUTE6rRIE9wF
         C3Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXCqOJsJqnWHGTbm5uIBTbGDL3MGPF43S78a3qotJh9WVj16dv5ZZbfPWH2UKGg+h3+CgcDySqg3HWxmCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Yx7uouuZJ3zJ0PqikT5xT8dYMK646/kmqFNtiUyElL9QkOgy
	INs6UWQgMK9gLEYKorFeeQCjmXkzcBwsl4u6Oe7GlMGp9Zu7LOhMRt7J
X-Gm-Gg: ASbGncsU1q+MpEsFnr/wLjfXujTvOwHKZB93E0DxekSCGW5FdgJROnfgUKpfshARJQ1
	T9YwLElMj3332pgvsUz504Kyexje/ikLTm35Rou6o5tx5OkfJZoAn4bb7fWt7d1hDBu22oid6kK
	6mhw7XsZgsGQ+gshsvP3TfxtlF9Vm9JyXAsfLEzkg3BLQC/cbU0cjOpRCsRTpMp1cRs9Syoi1fA
	NXskld8g9ZY44gMZh4YIq8uI3+yRw3F2fVKT4XibnsmA/0awXcU7lte+g6bsr56LEuC8GCh/fxV
	SX5tfni2g22+x8+C0Cf56LRIlk7o25RyGU5dLlW4WdfxcrhlCQthd+Z2aW+D/p0XZAjB9nb/2S9
	MTm1d3cs+sGAtzogOZXH8tsRwAyRKRXYDSCDnbop549mItS6NCv05aUoOzDbUKwds8Z0mNX47fA
	YjwcazfuB/ohRaPUQ=
X-Google-Smtp-Source: AGHT+IGyWFKuRgH1C0L9Vdpx7fIlC3uIo42IVd5RZdnUG4U++HXEcz6WAKkrk1gx23ETrpUiaFhneQ==
X-Received: by 2002:a5d:5f85:0:b0:42b:3aca:5a85 with SMTP id ffacd0b85a97d-42b3aca6f93mr4447781f8f.63.1762809668525;
        Mon, 10 Nov 2025 13:21:08 -0800 (PST)
Received: from osama.. ([156.223.120.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63ba87sm25073483f8f.14.2025.11.10.13.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:21:08 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	ruanjinjie@huawei.com,
	suzuki.poulose@arm.com,
	ryan.roberts@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] arm64: acpi: add newline to deferred APEI warning
Date: Mon, 10 Nov 2025 23:21:01 +0200
Message-ID: <20251110212102.816724-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

missing newline in pr_warn_ratelimited in apei_claim_sea

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/arm64/kernel/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7aca29e1d30b..aab07d179787 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -439,7 +439,7 @@ int apei_claim_sea(struct pt_regs *regs)
 			irq_work_run();
 			__irq_exit();
 		} else {
-			pr_warn_ratelimited("APEI work queued but not completed");
+			pr_warn_ratelimited("APEI work queued but not completed\n");
 			err = -EINPROGRESS;
 		}
 	}
-- 
2.43.0


