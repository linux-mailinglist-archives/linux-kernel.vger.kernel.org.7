Return-Path: <linux-kernel+bounces-789999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E92ACB39E05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBBC1899C74
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180C30F950;
	Thu, 28 Aug 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="TeLrEcit"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288613C9C4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386203; cv=none; b=glHn2H5Bt1eMcZ8aLAE0X8+ugBGSbQ2xgWwa/LS8I3hfys3G+mKGhBALxltjcFCVeBvEPuP3SIAOkWVHuo3qXP+hzyJdEcTw1uWGHEzn6f8gBALOET5IrTXWSk970LKbB8tXYT/Mf+H/BoO+VkeY8ZorYspa1QAQ9Jpwh0bMOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386203; c=relaxed/simple;
	bh=MQoD8AFsuEYEefqFoTlWNAnr0bGhPa9ZVidr4UgsXoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4UjQcoSZf8DvJrn+D2AAIYGkGXaHoo/yctoxWvBMrc+RHEEhcNa4jY1BNxIYCZ8YW0+Bf72NirwtUW9zJ409J/wjYiC4qJqryHmb8AgIjmW9Sh0CaJE5LQrBhVlnVdVtz0eAp+0QP4T+RXAmKPCorpzOCqpHJ9hWFBIjn61bIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=TeLrEcit; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso4754715e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756386199; x=1756990999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/MNTLOoQaC9GH63ytxoIqp7bt+zk5wA7d2enl0xewA=;
        b=TeLrEcit1MeWaAdVB9WiOErITgoYNqvDKKGSbb6oAP4UpzsAzAIObrMgaj1UQxLj0l
         qWAR/G68qiNOpxYm/XG2iUuIGZeCPSwpqeWQJNPjkg3V52J0d1HL/3f4hxZ1kCajHQJl
         HVHwerp4JJBoRpOpKqZ1mIumCC5a0F+k+Vd4JyyWJ+WVvx3VfhxcEKdEtKl3tF/wgHrV
         4suhwOjhH556yQ5TE+vnSvCBv1b11TLIFVX7TXhpeQaB0F3JEj7qBuZMOX6hEq4k2Dor
         lK+7WkwabFW8vDUMI3pWo8B/zmmPbGNm5UGzWfcU2hTRfBLO8ca6UwZ6L4PX8kNjaUnb
         9HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386199; x=1756990999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/MNTLOoQaC9GH63ytxoIqp7bt+zk5wA7d2enl0xewA=;
        b=ow5Pi6vsHC7++zH3BMO8Tsil8IbZXId7ypy7vyU/5Nxo5NuhCJLOQS8AfUW3maw0UP
         Mx8qQGPAE4hBjBNJrHFGAmGIPWeb5yN040fdsP1Uo/1uKkeJDz+EYp+CSLS2VtxJ6EKG
         khl+OnNnCA2ft0fC/yW4nKFF1q3aUFVlBNSAqK9fvx1uQd+Ffn/19VsINGNanYsmEA1z
         8zQHj3PUOHu5TfUdoHXJb2XTHQoY6QUCjAabNSIhkaSloKBYIqG0J6In/N0nozSxzUoZ
         Q+fH4AGWA/+ImGr+vXKrlThYt9Yj9FIP9rjUzwVBE/AlX1M+XVFRRlKfg40Vr9o+eSQC
         75Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXyX+Zt3HA8Kodl/2AmQD+jgwl+JZ+tX35mLEUlEfrh+ozIt/M1fcpZUhKYFJjbQfBKysaGZFPHeUKNhHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2DBiIYGUQvgE21x+jpAlaI4M/eTy2cpFuRuqyExTsquipmu3T
	saLYXVr58zrysnJZq3qydXBV6zfskRi/bfzje5syKUd1KPKTHcbjpq+nKg+7E/Buy6mq5CFDuPz
	MAGyU
X-Gm-Gg: ASbGncvkFTBU9DMlmelrmmFkVhhlJK+QI2drKs5ITvfraHFFlYnaRhBe5feRn/4qati
	N1FnxYFXiRs2Wi2V2AEodLcZYfJH1GjaKTTWOL7VfA8AdyDIxXsLCde+idBOvanq+f4gqHwg6XD
	LQ3sjbMb7/0TDTJvJbV6BF1tu4jCByc9IlHZ+pRn4SBQQJg9NbFxqsq4INcbJ1BIXZDDdnXdYGe
	wRQGAtGsi4d8J0H9dNT1Y+yS5qmze7fipWOW/JR/NjGGZmg9pXdLg2tBdBfqr/qS+Em9h+Wb4KL
	R+hLmSY+FFO6qMkN6q9pHAIUQ511g85hW2DNqCFDQ3CuG8/modF46xNl+kxh4FiuOlfzeATXDCS
	bisnW0WTXRuTu2ETYhOyrqDu3DYaUyXWLKGxUtDYNHyxSAiAEc7CnG2jnJ7/GqRf43MnBeg4Ti6
	g9C4zmi2NI8o4SSFoGAVNGpCZK6McqjNBl
X-Google-Smtp-Source: AGHT+IG3aWTBrkvPvuuQElLzB0eddCtWy0l0vdwh09kqUvGD618PEronOpTcNT0G14Vl0737ytOiAQ==
X-Received: by 2002:a05:600c:45cc:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-45b517a067cmr204805445e9.9.1756386198751;
        Thu, 28 Aug 2025 06:03:18 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f31d083sm72983315e9.24.2025.08.28.06.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:03:17 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] pagevec.h: add `const` to pointer parameters of getter functions
Date: Thu, 28 Aug 2025 15:03:11 +0200
Message-ID: <20250828130311.772993-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2: reduced patch to just pagevec.h upon David Hildenbrand's suggestion
---
 include/linux/pagevec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 5d3a0cccc6bf..63be5a451627 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -51,12 +51,12 @@ static inline void folio_batch_reinit(struct folio_batch *fbatch)
 	fbatch->i = 0;
 }
 
-static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
+static inline unsigned int folio_batch_count(const struct folio_batch *fbatch)
 {
 	return fbatch->nr;
 }
 
-static inline unsigned int folio_batch_space(struct folio_batch *fbatch)
+static inline unsigned int folio_batch_space(const struct folio_batch *fbatch)
 {
 	return PAGEVEC_SIZE - fbatch->nr;
 }
-- 
2.47.2


