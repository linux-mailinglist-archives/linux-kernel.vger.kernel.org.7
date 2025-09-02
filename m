Return-Path: <linux-kernel+bounces-795989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1350BB3FA5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BCA2C15D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513FF2EA175;
	Tue,  2 Sep 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4KpuJRj"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CD2EA72B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805366; cv=none; b=HdX+fYc6Z2iIg43snaX+BLHWEubjZU+vFUbBd3r+eLNBg6tuzNULYSRodMUaYp0eT0ndlMkEQergC4X50LybWWbrnOmo9Ak2AErb6mLcJ0oKKR+iGZEN4mE0fVBVXc8VTMcuLh3NKpEgNjAx9kuRC0kQkWyliWbrh/ddp8hvPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805366; c=relaxed/simple;
	bh=3UJWS1FLF+q1oCYy6aZANoKsmaqSziLBRSNXraSp9cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShCfCFqlwX29kiPW8t5gGPGt1ZswMl1gQr3oOUYuSoBshR5l+ObDERg9kgOzPAfy5UBaqIZdUj1qpWVGYbJESrQ9Jt9qm+jzOFvmSlkcTcgnAUWrDp2IISZiDNLWDGR7ENdJKyL4JfpXpT3nrdgf/nfLSPn2ppMcLCr+xJIGn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4KpuJRj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3da4c14a5f9so271785f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756805363; x=1757410163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4myXczSicKq6B3fSQvBxEXTuo9K7Q/Ustidy6FFEJ4=;
        b=k4KpuJRj5kk8lANj59TuTF+gInjApn1Sgedb2il/HTjlKKDqcsCMoF/jrDok1dg0Pu
         Yp3Of865VSsOWnQw74i4Tzn7ibBvnwS35yBSwjFFKYI+TyvU4S2rDZVROegAejPzIf+n
         OE10zPz5hm/MbDyReWEPA/CNtB/AvgucKYUwWuKUO4thK2K3HDRUZtXMLfHdimO52/J2
         vP/HBm5GxMkavO9KfAH3NoY4qdhFti6uCTwkBer11y+EgulEuOjBHTtJX8yJwLUSTgM9
         NhIIhz2qvNbOJ2q8QlJ3noYwLz22dPTAaP2VqdUUCd9BHQkfSJ256kCZJHOhWDmo4aje
         CJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805363; x=1757410163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4myXczSicKq6B3fSQvBxEXTuo9K7Q/Ustidy6FFEJ4=;
        b=cxFYiI8qjYfJVyZTSXjCXTXbYkYZ793K4AZmmrPqsx+7ZdskAhcjfm3FnSZOuWVt03
         jOY3jGA13qARk+EPAI9Cx4FhVm2NqvUg2049kZuXo3oDyvwKDL3Av/sletAjs4xFTB2N
         //RAXKIkWen0rtOhMl5Ri53Ri44jjTXrHD80bpJy8zRTY+rLGUkwFlf+rw3heZ3fjaf+
         Rxlm3EJw5wfrVQjHxenJLDCbe5MVPGlE3hKD6GUHaKG33g55bLEpimVIrOoVQyU3zJpS
         ZOGN6//j5dhdXsIq3S9oL0auspA053KB01odie+mcv2eUKyzFEmJUypwJIpl45m2uXe+
         7viA==
X-Forwarded-Encrypted: i=1; AJvYcCVqNS6rAVufySq7gkvVecFf1IJnGsiQXYPqJUVahtWLhrCxZulGxVqqutYXpFaamuP3CibQuVqP0LxUojA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5WGl9B05QxvVazmH0V/ve1b1LazmTZWHCK3x/LjmHMuC2GuuX
	Cj8c/d4mMMYnLLdPdfiFo02GtjyUwc8X1M4C4hrLvWLIGhlWU2bv86o/ieO5VgXrsOc=
X-Gm-Gg: ASbGnctxnfJMw97mP5fAlnPHygTuLW1RRexDBKtUrV/uu7coHRLtyhIdDzKf+aHKa7F
	LThP+JEyWslZEXLhKJqyzOkigH7QujO8JG5lArE3nsPrKsf7XEDCdmz1CxB+g0a/qAj6+6Lyewp
	kZjVZUHQWszai17arpfliVNeE3i/baVsu7pC2Uqo1bknPHy056XoTEhNKqruv0fpZEYJ/C2ijzz
	KbbgxjCjwG2QOMm+JLBvDSnNUatYmHEM9lsmhvOiWYTZ5rZTN/UjS2vlafooXEGr5ADw9KsB/qK
	iJblw2FZI0MTfvaMt5Amvt/XswM6jLBevY4kVe8CJOS7C4iZHPhb8YVYL18LcMXSr2qBX7YJF4o
	8SNjxg0q04aqting6ZNs7Z67OPm6qpZZ2zl9X3iQfkY+Rp4klCPLOnjx3rfnUPV6IWpk=
X-Google-Smtp-Source: AGHT+IGC4hT9ICf62eu235jqFNFWwvQk+Tf3QplcIoM4NxAqPnOWJP5AeU23BCKw8JNBgkf9eY2HAg==
X-Received: by 2002:a5d:588d:0:b0:3d1:8458:cfcc with SMTP id ffacd0b85a97d-3d1df539e92mr9158217f8f.25.1756805362672;
        Tue, 02 Sep 2025 02:29:22 -0700 (PDT)
Received: from MacBookAir (78-80-81-163.customers.tmcz.cz. [78.80.81.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3da13041bcasm2535693f8f.35.2025.09.02.02.29.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Sep 2025 02:29:22 -0700 (PDT)
From: Aleksandr Shabelnikov <mistermidi@gmail.com>
To: o-takashi@sakamocchi.jp
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Aleksandr Shabelnikov <mistermidi@gmail.com>
Subject: [PATCH v2] firewire: core: bound traversal stack in read_config_rom()
Date: Tue,  2 Sep 2025 11:27:45 +0200
Message-ID: <20250902092745.8326-1-mistermidi@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_config_rom() walks Configuration ROM directories using an explicit
stack but pushes new entries without a bound check:

    stack[sp++] = i + rom[i];

A malicious or malformed Configuration ROM can construct in-range cyclic
directory references so that the traversal keeps enqueueing, growing the
stack past its allocated depth. rom[] and stack[] are allocated adjacent
in a single kmalloc() block, so this leads to a heap out-of-bounds write.

Add a hard bound check before every push. While this does not itself
implement cycle detection, it prevents memory corruption and limits the
impact to a clean failure (-EOVERFLOW).

Signed-off-by: Aleksandr Shabelnikov <mistermidi@gmail.com>
---
v2:
  - Drop Reported-by / Suggested-by trailers (per Greg KH)
---
 drivers/firewire/core-device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index aeacd4cfd694..fdf15df977f0 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -581,6 +581,7 @@ static int read_config_rom(struct fw_device *device, int generation)
 	const u32 *old_rom, *new_rom;
 	u32 *rom, *stack;
 	u32 sp, key;
+	u32 tgt; /* target index for referenced block */
 	int i, end, length, ret;
 
 	rom = kmalloc(sizeof(*rom) * MAX_CONFIG_ROM_SIZE +
@@ -702,7 +703,8 @@ static int read_config_rom(struct fw_device *device, int generation)
 			 * fake immediate entry so that later iterators over
 			 * the ROM don't have to check offsets all the time.
 			 */
-			if (i + (rom[i] & 0xffffff) >= MAX_CONFIG_ROM_SIZE) {
+			tgt = i + (rom[i] & 0xffffff);
+			if (tgt >= MAX_CONFIG_ROM_SIZE) {
 				fw_err(card,
 				       "skipped unsupported ROM entry %x at %llx\n",
 				       rom[i],
@@ -710,7 +712,14 @@ static int read_config_rom(struct fw_device *device, int generation)
 				rom[i] = 0;
 				continue;
 			}
-			stack[sp++] = i + rom[i];
+			/* Bound check to prevent traversal stack overflow
+			 * due to malformed cyclic ROM
+			 */
+			if (sp >= MAX_CONFIG_ROM_SIZE) {
+				ret = -EOVERFLOW;
+				goto out;
+			}
+			stack[sp++] = (rom[i] & 0xc0000000) | tgt;
 		}
 		if (length < i)
 			length = i;
-- 
2.50.1 (Apple Git-155)


