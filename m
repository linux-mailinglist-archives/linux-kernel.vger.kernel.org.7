Return-Path: <linux-kernel+bounces-742643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9727B0F4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A04D580920
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702FD2E7F03;
	Wed, 23 Jul 2025 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDqKPu3N"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C32E36F5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279301; cv=none; b=jWxy1ka3Fp9Dr5tMU8XBorBBqVRGf9nWEmVETIBOedRQmnlWbZb21d/1KPQTIcRFh2DgvfUgjZO90k2pTBwjLyA/a9vOuqIz2jsHk5udQ7Udq9gUqObClAhAjorwzoVJY5KvcdNeevNgaTqFB6X2NI5puHKI5A++06O4lgP8MCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279301; c=relaxed/simple;
	bh=AKjlzh4yKMkZgck5M8PKwPP0MD8D2STeY3vDo2F/4fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgV7y0/OKQNe1aBUvlW3YjHjMQZGVIqbcuN2qdAo/tiYJBe3tVr6+oC7LdUj2TRSCcFKsE4yC2wsBqyzP1QT1vP3pKYsTpvzwufIVoQ+9f1xVqanYyWVfkSEeSiSIlstmhkMyJ12zo4kZTahUy2+VMIBbLFWrNcdAxObP1j4xOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDqKPu3N; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso4552903f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753279295; x=1753884095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlOfdDt6hzRRF/PmIEFPhjM+dqXDMr4TgJW1nEHA74M=;
        b=bDqKPu3NnhJdUBqdy1bVLasDg1WDZ4O3vb/f9NvV8pb+PW6bsWXVzk/4SiV8awMsX7
         aY/gEqFy+jbRwxwWVQNSBtnofvCq29SDNCJmmuZ4goBaRzZT+U+U5l33XoWV3hA1svuD
         QvBqKddCO2lbbHXW//M7PgApYk6DePSsI0Hv2jwDL5pO3bJbG5rNN19qp2bTQMQC/8Dc
         ftd2+MZMgETIdyb+sO2fP1oTac57+diUbhfxqc6nSrMMWR5DU1ipH0JYy2XIuMuQD8Lo
         PCj1LV0jJ0E4qbWk5hieHsaTMiYM/dkjziKBwyJsFCTecJfPcYYhm9T343dMXH46Sspo
         gevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753279295; x=1753884095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlOfdDt6hzRRF/PmIEFPhjM+dqXDMr4TgJW1nEHA74M=;
        b=n4fIs68NXX/fZxWi3w8MDt7pvPZmlb2yYj/Skc0+ATCWiBne4nURbeZ6xB+xtZ+BcD
         29uM77UwY2ytVix/2dwvke+z+iQH30f7K4FtvypR3l2w5aG7/UNdnYgXdx0tK7GqoNSS
         r8X2yp3ieqBgy08fOveJ+qEJ6hE8azZgwseHgysuguLz3dXrEDnDz9YGGACTYQaB0YSa
         KdWamQdoaH2nc+8+m8pZU0M7CJ2rTgXFUhxeEAtyNiFauDCu1ozUIl6SclPmYCEj5EIl
         7D4rjbdAjSA8uBNxgw2k29NDHgQTOXQFLJpyQD+EwWAaVgpDU+YajUp93I7OlSC6y3DV
         9iYw==
X-Gm-Message-State: AOJu0YykXL3/MRSUukpeY8geNVqzVVqTeCNxcc1q1wmDY1wwB5Rp6PqC
	Eksf3FdsdSTraBig0oWjf7bPpFYBOnso0pVpI8RYnUv/Jmnt1+jw3n74ClwxzLvH
X-Gm-Gg: ASbGncvXmYJJ1A1kscV9q8AW6yDbCEgaXAFK7iXHJuaN+gmudJ8Ql6kzRYqWCmoyJst
	pZ8kojZjYuBJKPh0MnkpHvL0ArSp+p6I0LWFA3Nf6SF6PWOcfbIQcXLBX/PBG8kcoAB48DSYacW
	9F/jDyHJ75CqAxcpwNCZK3e6ils9a3P6ZO8kBY8Vub9FbVyAfRp0zW1bt0YF5eS2ujglfI1b/bB
	yZPjof26Zvl3tZtP1OnT8WXNAzNp+jwfZE64IQpeD2lLAnCTWCcjOzv3GiT4c7FZIQ/ELKUxZwx
	iOfKcPiKJtcpXkERM4jD2+M5ebtoEvbvUlrkveLry7W2VsKx32Lt7VUWO9hLp+9G4zkvuF6cSDR
	GrRxnwwERipAVEOpVbtqCKitG8A5JaKZm8bzj7HHXhK6aptq7ixRJidFZwK4a
X-Google-Smtp-Source: AGHT+IHbJM2fgR/TdCmFrK73BmKGCwPSJ7sfkNrZLXKLY3xd1n5i/9cyFl8jd8haoS+QhBJJqIcIYQ==
X-Received: by 2002:a5d:584a:0:b0:3b3:9cc4:21ce with SMTP id ffacd0b85a97d-3b768f07c8amr2427433f8f.50.1753279293218;
        Wed, 23 Jul 2025 07:01:33 -0700 (PDT)
Received: from ABZPC-86BPZX2.aberdeen.dnoheather.co.uk ([4.234.100.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458693cd224sm24461525e9.21.2025.07.23.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:01:32 -0700 (PDT)
From: Raka Gunarto <rakagunarto@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Raka Gunarto <rakagunarto@gmail.com>
Subject: [RFC PATCH 0/1] compiler_types.h: introduce ASSUME_NONNULL macro for static analysis
Date: Wed, 23 Jul 2025 15:01:29 +0100
Message-ID: <20250723140129.276874-1-rakagunarto@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This proposed patch introduces a new macro ASSUME_NONNULL to suppress false
positives of null pointer dereference warnings during static analysis.

The patch only includes the macro definition for Clang so far, as I could
not silence GCC's static analyzer false positives without ensuring that
it wouldn't affect the emitted code.

I tested this patch and use of the macro successfully eliminates false
positives when used properly and does not affect final code generation.

I am new to contributing to the kernel, so I apologise in advance for
any mistakes. I welcome all feedback or suggestions for improvement.

Rationale:
- Use of this optional macro can silence false positives which may reduce
  patches that fix false positives (such as AI generated patches).
- Clear documentation of a non null assumption for other developers
- Signal to reviewers to subject patches that use this macro to
  additional scrutiny, and require justification on why
  there isn't a null check in the code instead.

Motivation:
While running Clang's static analyzer on the Linux kernel, I encountered
hundreds of false positives related to null pointer dereferences.
One such example is in mm/slub.c, where the static analyzer
incorrectly reports a potential null pointer dereference on line 3169.

n is non-null at that point, but it is non obvious to the static analyzer
(and to humans) that get_node() will always return a non-null pointer.
Since it is in a performance crtical context, adding a null check
would be undesirable (I think). A macro like this can be used to
signal the pointer is invariably non-null, without adding a runtime
check.

Raka Gunarto (1):
  compiler_types.h: introduce ASSUME_NONNULL macro for static analysis

 include/linux/compiler-clang.h | 10 ++++++++++
 include/linux/compiler_types.h |  5 +++++
 2 files changed, 15 insertions(+)

--
2.43.0


