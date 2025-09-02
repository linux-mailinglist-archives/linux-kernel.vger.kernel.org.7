Return-Path: <linux-kernel+bounces-795709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B5EB3F6CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E0E1A841B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF42E7166;
	Tue,  2 Sep 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXmtI/tR"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8032E2DDD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798742; cv=none; b=Jo5X7O5bxCpApLtEFzS/fbPbo9K2M9xn42gQAKT8GIpmtvpmgc5JnNzg4g5j21i7jdukLpCN1mpscGZOQ6VDB/Mb3QRuI30TQo3EQfMcdIFBezc+BTdsvyHcBtOJRBi7qc3uXB/au8kaFqVuN5uKiSCJ94EwErXdFVCZEEcbClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798742; c=relaxed/simple;
	bh=qxr+CREui4pE7rWTCWj6E45p0I+6Etq/aCUmmlsx7ok=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e1NOcAqhJaafHkPgOc8p12JC6obo67pf0pT/ySspRbRuW5EDeAm+9rXiKkOA1lGRHqRZnTA9Vau4TUYSap5+LQf2tn6wDn6CWBTHg9VyUI22yjSDdYZ0K3eTNFx42Xf7dw4+farmHCPQ7u5pzjtb3Nvq0TJCrOr06h7TEY+OnUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RXmtI/tR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3cef6debe96so2628478f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756798739; x=1757403539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WE7v0z7TzjZvPVfK4+4Sp1UwAsOZUOttl1hBOuNjNnw=;
        b=RXmtI/tREvYorkHCf4d6iMF84kM8El9u92b3F9C3SL6kXV02xf81nAlAxqSSILTeSx
         MdGdC90i8eMYOs5s3/37tY7kEvGPzycBFPVHLTY8yrhXdjq4NIDZ6bOddHofdqC7WYq8
         Y1jq6/MFRQ9Byja3MEK3G24cSuPERpq4Qhrvqd9liz0HXcg6pSmgNLIoBotmELb5lgxB
         aAsEkSScEiynhEpm1J3EII6hYzLNBYaPv2bKMwhi1fgopcUYQUqHHn+3IoIshcS1w/N8
         tn1jxyOOkcCyW2dcKCXEPtgXkiXsATHgi2J4xcmNRiVLg+WvnZkGl5/vvWqZzb5lODwA
         RfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798739; x=1757403539;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WE7v0z7TzjZvPVfK4+4Sp1UwAsOZUOttl1hBOuNjNnw=;
        b=g9rL0MfZqBA8c6UvroGYjYAIF14KnVut1sM8SD05bjk7RNBPCjdVm9A7LzfAxgLZ8v
         OW2dtpz4cchdqxCuchHr375cgSebJO9Fj2HgyRfyaJa5pD88LgmDk+eCUWBHk0YCCtQJ
         xSN7faFkbaGQfeZYQhtOu9mcpZ14ngmyOiL/Nxjhxx7eEFO4TvDEItfH5uagNWq1ZBIj
         CTg+9z8eVxmXYx9zja2ScFhcgpHDemwMswWOO6AfVK/9toSHk2e6AMeQqKH8HUBGD1HA
         ZNF7nqzRFAFQ5tGlVPMouT4/srpiWr3pm+vBq2zoPDo2eqNWjpIpduZZAuOMHkCEaNYU
         E43A==
X-Forwarded-Encrypted: i=1; AJvYcCWGH195NKOoyk/0Q0/D+OZX2P5JIjkwMJ9To/v56ZyYSIVjANA+ubEw8k2HRXQ2cbFt6lw7wOhOEfuVDGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGmhRpzZEhwsBquFq6gOaZwGF2Y5hDAQ3/c/cSkpcdH0v63ebg
	9y2Gqf7BUSzUFiFECpy3jABjEywwdXlL+a8fPAJlqkt6BL+dGejiaKOXFTPC2fhRm65K/UqJU7N
	4u9iSuOrW4g==
X-Google-Smtp-Source: AGHT+IGtOLqgwO0BX/6Sg5J5mhZ2KciPQ7kiO1dkbcPPy47bP+WENUmn6cded6JsjNVS6Jfarr14pjp35Rl5
X-Received: from wmsd13.prod.google.com ([2002:a05:600c:3acd:b0:459:dcf5:1b54])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2d82:b0:3d7:38a7:35dc
 with SMTP id ffacd0b85a97d-3d738a739a7mr3158803f8f.12.1756798739364; Tue, 02
 Sep 2025 00:38:59 -0700 (PDT)
Date: Tue,  2 Sep 2025 07:38:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250902073841.2338568-1-abarnas@google.com>
Subject: [RFC] staging: media: atomisp: Simplyfy masking bit logic
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"

Simplified masking logic in pci/hive_isp_css_common/host/vmem.c.

---

I have tested this change on whole range of *valid* inputs, and it gives
the same results as before, but this function seems to be little
counter-intuitive as far as start is a (bit index) but end is
(bit index + 1).

It is follow up to: https://lore.kernel.org/linux-staging/20250901091050.1935505-1-abarnas@google.com/
---
 .../staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
index 722b684fbc37..9703e39b7497 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
@@ -22,14 +22,14 @@ typedef hive_uedge *hive_wide;
 static inline hive_uedge
 subword(hive_uedge w, unsigned int start, unsigned int end)
 {
-	return (w & (((1ULL << (end - 1)) - 1) << 1 | 1)) >> start;
+	return (w & __GENMASK_ULL(end-1, 0)) >> start;
 }
 
 /* inverse subword bits move like this: MSB[xxxx____xxxx]LSB -> MSB[xxxx0000xxxx]LSB */
 static inline hive_uedge
 inv_subword(hive_uedge w, unsigned int start, unsigned int end)
 {
-	return w & (~(((1ULL << (end - 1)) - 1) << 1 | 1) | ((1ULL << start) - 1));
+	return w & (~__GENMASK_ULL(end-1, start));
 }
 
 #define uedge_bits (8 * sizeof(hive_uedge))
-- 
2.51.0.318.gd7df087d1a-goog


