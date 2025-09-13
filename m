Return-Path: <linux-kernel+bounces-814995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2992CB55DC4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624317A84B3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2212B19B5B1;
	Sat, 13 Sep 2025 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kP2tdJyK"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07B1E515
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757728228; cv=none; b=iN50A+wtE7fWpdN7um7+RVJKNA1VvhpNVvJUJg0xGvJYcKaOWtxxovPvFy+f5FCItdKvkk+3tRtrj0R1q0zJ1iZypy2eOXmWFk+WsuGT0yFihQlW95xA0o1bdWLZfvPrDh/N7nDiz2f8KaPZiedpAtQ8LHKMoGTb4nKv5xD7OfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757728228; c=relaxed/simple;
	bh=2pke5B/p5bVW7/W1MvtdA/qNec59UAGg1/Stpd9ULMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+qlsDsFbt2eHlZHnOW+ksZ0MRsziXoavB4I356riA6ufg4/MhpE57O+s9bnr9cr2pY8ySSsNRlFYU1/VsVkR83mfV8Sg72NrI9B0/6Ekcy5TTKGoljO+S4nALkouVTiKeE0iJuH+A8RqdQPG5vxIHGGpSBbsrtgx+MyHVruqqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kP2tdJyK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d71bcab6fso22843517b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757728226; x=1758333026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCdKJTmqPYMwrtPghr4e9bj7Z7fRlbmOYuwXpg8nHMo=;
        b=kP2tdJyKwFDReRzK+uzxGWjQmB2sO+K1zYkbdCTXYjAYgYOcj6rWhahL43Ae++grtv
         2A1h/GxHbrK7TjaMGCVZ9E24JWwWP/uuBQ8orYq5wl05YZahuH7g5YlCu0uFLzjs1c6l
         FTCE5tjbFkZmFdI7hClVhaWGBdvOuHLSHG0t5wMAVRNQmGwHVKx8EPHA9VRBZMf9vxXY
         tST70uNcJkPatfvIAOTaZqylrx1ptMj7rWwh6K/wp2qF0Qkez1K4FcLoZADFtFLi+u+R
         acCDJAfrnJ+nBnyHdxult9JYOfbB70qQGsZNEgCMAWw28FV4ugGo6cqA4aZMERigY4fa
         l5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757728226; x=1758333026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCdKJTmqPYMwrtPghr4e9bj7Z7fRlbmOYuwXpg8nHMo=;
        b=FAaXqoyF9HgvlvwrZbLE7gHamFJ8dOUy5peRRDZGjcpNK6t39riM6rT4AU5hBpB7aI
         ugn4/1Ncaw8/2nphjO7AnYhSDMfAr6jU7bfLlCYP93jOUDb3jcZx2GWgB9Ks0giPPzf0
         NGJo9EvECR0gz7G84/8JaJP9BLgh77MWLKJ4KVl8zQALGZBBuhcZEVRa6PLmmtkVyYmD
         bXK4I4z7vEpGt65W8IQDZAu+ccEgUoOXPBJB0gpIcOWmbwaHgm6vYsskaCD/7UMJV3Tw
         hCrhD4nT7RVowLWZO74nA9lYJ85J6jaUMiZ8XwyfB7j6AMDBQP+ScnAE16k9BIDbEP4O
         GbIg==
X-Forwarded-Encrypted: i=1; AJvYcCXqGhdnuloSpJu6N10uQR6N052m015hphvwud67umbeuzTfLmpmlE97Xz+9lpcF9RGr7LjGC3yEj4RPOKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZpRuEBdV6nwXGx10Zl7N49LHprOSOY6h7pqtgxtYjVcNvuOH
	7IFRVEmCXNjDuMFrt9SQIHgfonQ3GyeMEP9qJKd1PJs/pxxvhuzumqMb
X-Gm-Gg: ASbGncv11RtcOfQMjWUqZn+d7F69wOcq741VgpfKe3KjJtIt43SSVVAalfFayXs6+H2
	YeWx7LdJJ3if70+nWCf3qTSzDckvrcqnz9WKf+mJwGqS6yoDxqF8VWmniBWS795aVhktuR01Lym
	K6Xkx1jj6h63LS243vIyWQeFUn5kWuCUf7FSQGzfJ2MC3J0P8Qy0PVwkJVsIbI2J5Dvv3bkdb0k
	ff1GDsbRWAt/fJVTWL9WUsS+T3zVWWLU/2ryBlWlH65Q9nJifML5YxOpNbzT3Bb0V1Ll7EDc/94
	eI3Dwvcf4DLbj6iU6fCbXuOxrZ4UN1YrQ7fci9JsHUuhUvdq74wEYcPvZdBJNrYSeP69CLrQMK7
	qiPfZhhWP+/TVihV4AL3cc1YvbIt4TNgvox/2Wcvq4Ykbzj/HoFrKgVcAA7AzDuniMVai
X-Google-Smtp-Source: AGHT+IHehtPMabakdBlT4r4MpAz+SoWip48LOcYZTX3KzIq+FCBVwHZSUk7DZZyPa3li/g16NWNY8g==
X-Received: by 2002:a05:690c:630c:b0:730:5445:4b48 with SMTP id 00721157ae682-73063191249mr38954027b3.7.1757728225919;
        Fri, 12 Sep 2025 18:50:25 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73088a76fabsm9987867b3.26.2025.09.12.18.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 18:50:25 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] iommu/vt-d: drop unused cap_super_offset()
Date: Fri, 12 Sep 2025 21:50:23 -0400
Message-ID: <20250913015024.81186-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro is unused. Drop the dead code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/iommu/intel/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d09b92871659..7da1cf88ce80 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -173,8 +173,6 @@
 #define cap_pgsel_inv(c)	(((c) >> 39) & 1)
 
 #define cap_super_page_val(c)	(((c) >> 34) & 0xf)
-#define cap_super_offset(c)	(((find_first_bit(&cap_super_page_val(c), 4)) \
-					* OFFSET_STRIDE) + 21)
 
 #define cap_fault_reg_offset(c)	((((c) >> 24) & 0x3ff) * 16)
 #define cap_max_fault_reg_offset(c) \
-- 
2.43.0


