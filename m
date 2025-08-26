Return-Path: <linux-kernel+bounces-787379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D625B37564
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BAB77B2D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF903054FB;
	Tue, 26 Aug 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OXyoNDKu"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A92BDC02
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250200; cv=none; b=O6LkvhDTNVc9vIV+txJfj0BB3ENXUxb5Fmz0m1x8aXSMg9fjua7uBFhbCkuCBUEmRs0MZeZrJTdvmNth0JrYhb8Rcdq58408QMHTh4zmoPvl4vi2Eid024OPlXHN+yrBGxn3KohiRd1pnjHDK56sYaZN5Ng38jxLPAclkXmeMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250200; c=relaxed/simple;
	bh=qvi7B5q37ieJSXMATxBD/HvZ0beHaR80oa05ZVPlxCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bi9I3MbiW4//rpDo2OtE8zyUmEfUrmmQxKcxMwu0AKliCxfwnCYhLjprFQPAcpMOWlvzt4Fpa6ijMPnet2b7i4R8Re8gn4n9NORWKadQv2Ub8EDRdrnN6Wj8JhnxEB+DVMi2bczGHjXJRqyvuq42pZyk5ejseCMLaslKtV4NW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OXyoNDKu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afebb6d3f2bso65905866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756250197; x=1756854997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aK14C8WHtwfr9yBqD7cQYdKpQBzE143ZMlJ2OollMC0=;
        b=OXyoNDKuySL+o/GfemkGnHVeKTERDmiI8yqWCgMMXcnbbxibagnvBVUSBSwRNrk5QS
         eVHNDlFMLeIzlRfqEJe51sjDnAIT1VvS4WyndYkYpU73fivglTlORMGzF5CHBMfDtdyt
         QNQsd9CVwwPtlA2zjDMUbhW0hpZBmm7KH4a9r51PfkkoprNKkCAt+zCdZiwT5XBSNVLF
         ONtud4FQuzSIz5n3B4uoxiMCb+KLFABp0s9QBRn3pr2FhI2/Y3ApJziLR2of9/uDHWGf
         7ir3goOoza/PnFS/cWn9pGjvQ7v1soAtMl6ECvyeGem/EL38fi/CSIT6bvTbOqphy7SX
         aAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756250197; x=1756854997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aK14C8WHtwfr9yBqD7cQYdKpQBzE143ZMlJ2OollMC0=;
        b=JwyAWGjj0gT94N3EsSmtcJaIQ8nzaTDkPp/UWJ+rouP/sUeoi7KxurV0CtvLqXKjdo
         ispl9bDs0zBnpGdoTD2Z8tV+cOTaoMDbRZD7QR7C/BQJmW3ZifdFH8WLwSIxyEnHPLi/
         gI0CaomBVgnzyzHuJp2rA03WHqtVyCvjrOLOy7Bj/5y6ThxRyMi0Xtqhc1zwmNhLhDGu
         GT0LhPhXp71yTvpEsWi7hG/8L9x5VXMvFpVlpzkFXhBbkX8wXChkhkrciG6sjNSEGtDB
         aM7ZPT+yCS8L/lRM5WItjEVSfaG+fqTe2/zrTNvfJs8LwgDSRTawTOhs7lHoWXxxUE8H
         0ASA==
X-Forwarded-Encrypted: i=1; AJvYcCUqUp6eD3O1knZtsrrN0waNRZmRHUWTjwOjJy8r5S7Zk4N5w2RMCmodju19UCgDHmxWFkK+aHC4Htv3mYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgkv0C5vYKfzehE8PrgfhoGScWH9QImxwxULq8D0kRJ0KezO5
	1UKvhC2DRlLu+1bbLfEy6T5+31qF55xUXNPRrx8oCQ8/QdkViKehXkD+C4OUJ9nyVbc=
X-Gm-Gg: ASbGncucvbA1cOTCpXbGrDUHjrrbM6DqQ8Lo/ZUwh2JsAcV/exlL5BjId9ZpSoIpBXd
	9vBkQYFCOmVaF2Q4iJzyvaXhtpmhVM9vOKYprr0ih/HhZe9aaIVVmFjXQpinUjFB3pk+uo55fBk
	f77+Y15Xp+hK2mrvqH+3yflAGQXi2U5Jw0RG+PgQAAe025f7JcD7ET5chYdqWoFJPQrcssbWUeL
	DVUXqUcr1spiXQ3ZRlR7Eb3XrQLIl93/hAqYqiVnsaTcxoaH44jTCHVLmHNctJVGAzyLe21Sx1B
	Rc1J8cmCH95U+nHUUiSJTPZ+MgQEZmMZx5jIwyklYtvw1o0vO0K148s2/CRMB3ow/ydDGhv0G/4
	iOyPt8oZMuoT+6ZJOCHH1jaYBtID7r87RK0+K/EZqZrLuvwy189W0coiZD1AchzAK1VKZB8Rh2a
	X+D2YiQYyIOXACX/wEmuKQDQ==
X-Google-Smtp-Source: AGHT+IFiG6h5lI6W9GmtX6eyyZFaeAkkYu/4EvN9xMb66KhJPYTSBOh+0PHK7R6lz+1qTP8H7JPHOA==
X-Received: by 2002:a17:906:d511:b0:afe:8d25:770f with SMTP id a640c23a62f3a-afe8d25818bmr502309566b.3.1756250196702;
        Tue, 26 Aug 2025 16:16:36 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afec3251fdesm23170666b.77.2025.08.26.16.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 16:16:36 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return false
Date: Wed, 27 Aug 2025 01:16:24 +0200
Message-ID: <20250826231626.218675-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling is_huge_zero_folio(NULL) should not be legal - it makes no
sense, and a different (theoretical) implementation may dereference
the pointer.  But currently, lacking any explicit documentation, this
call is legal.

But if somebody really passes NULL, the function should not return
true - this isn't the huge zero folio after all!  However, if the
`huge_zero_folio` hasn't been allocated yet, it's NULL, and
is_huge_zero_folio(NULL) just happens to return true, which is a lie.

I believe this is a negligible corner case and I don't want to add any
overhead for this; but in debugging kernels, it may be helpful to add
this check, therefore I put it inside an `#ifdef CONFIG_DEBUG_VM`.

This weird side effect prevented me from reproducing a kernel crash
that occurred when the elements of a folio_batch were NULL - since
folios_put_refs() skips huge zero folios, this sometimes causes a
crash, but sometimes does not.  For debugging, it is better to reveal
such bugs reliably and not hide them behind random preconditions like
"has the huge zero folio already been created?"

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/huge_mm.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..e4c617c0b445 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -479,7 +479,12 @@ extern unsigned long huge_zero_pfn;
 
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
-	return READ_ONCE(huge_zero_folio) == folio;
+	const struct folio *hzf = READ_ONCE(huge_zero_folio);
+#ifdef CONFIG_DEBUG_VM
+	if (hzf == NULL)
+		return false;
+#endif
+	return hzf == folio;
 }
 
 static inline bool is_huge_zero_pfn(unsigned long pfn)
-- 
2.47.2


