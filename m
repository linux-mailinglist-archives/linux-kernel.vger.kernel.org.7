Return-Path: <linux-kernel+bounces-841933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA6BB88F0
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC24B3BD1CA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34037288D6;
	Sat,  4 Oct 2025 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiMNbIwc"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7E1C84A6
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759548364; cv=none; b=IC7PZdXgOAQsNaj2sR7J/ceWTeCpIUCi5K/OhnWpD2rXssBAeXz0w+eMas461Pd9U/VQdRBfrHAmbEoqQw4mK1dCyd8fdEfaYeUluuFGPp4oib1ikZv4w3D0e0xgB5z8XiHrLqm1Ykw5Tw/t84nswhSbLIwbad4QkwJZkyvj0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759548364; c=relaxed/simple;
	bh=4fbD+bPbiVKsQ/kInv9VxVrhUJekeoAyMEPUirZ7ec4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GPUxy4MtdqOaZTZC+Dwu1RYlWMHQ2RgDmqeNDTXjAQm10P2FEOSEj1k5d4FPruSJo7FrGcFtb4yy25x0VFvwDrUbUXO+IMBUM7XV2mecQQEvY6Q3rbBQv/HqHzRhm0yaFnePTtLc/9pwI93le+k7C522G85/c+rIJMVauK3PGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiMNbIwc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5565f0488bso1900471a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759548362; x=1760153162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yl0nQE2zdIwp8lpR9k8ql7CeF/Uw7tWHoOrvMUQqVA=;
        b=FiMNbIwcfIIK6aRGXzo5NmRDLi+dLvqo5SseVd945hmUktY4rGfcccZksD1GOjaNA/
         /xFzv7pTK5b9Nr9PYG1MDXqYC/3eWUWqAVl4zuqgmU5dJbWektb3hr/KT5f0h9X8uWlj
         c2Px8svAxq5XOKN4cR11C23P5p8V+GlLylZ/s+3T1xi5jNduSWYMGB+WAz2kszFv61dX
         1Q1A2FUwr5yLmbQkKNc3Q4NwPPa2m6ISVC2mQhVPpCVlMgZAFeiNJy9zr8ClQVPp4qIO
         CQTh0xMNXIPlKyMYqN6YsPS0kweA1arGpxFvuO4E/snRjm2uYn/E7sxy5rqUncYe8CLZ
         dUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759548362; x=1760153162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yl0nQE2zdIwp8lpR9k8ql7CeF/Uw7tWHoOrvMUQqVA=;
        b=JMwoxtatIUJXB5/4mTzfV//8UZ8El+KAmMY2acUSrgbn5v/wb2L+1hh9yDFWoWJuj2
         Y02hpP44bAkshOCiDPEd6KpDEY1e5m+JOtuRRgG0hLoDfuL/TB/4Py7k3fwva0XgVyvM
         m8ptu4aE2woiZqEWVzkzCTYlqxKe7PRkvDQ71i/2uU1Fq/H5gC+vlOtNFb2dWZNf3qjT
         Ajk9FMxrpBMlnVEvEptJ9FChAL+cmmxy89T2U2IwXhelwC/IvpdCYXvWzJ+KLkOWi7GM
         NoxF+D88SMAgz1AOK13Uvb5C1hhRQ5Lzc2GyQcq+LTqlMcIQBwOltF1JAHloSTfscSMi
         EBpA==
X-Forwarded-Encrypted: i=1; AJvYcCVlvt/UBLEQABL+mVVYCS3pcP4W2NX6wP4MIykvhc94qQoJHxBlFYIf3m4orCn/1yIbbHymnuZUmxpnxzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXf8Vi8kduqCTcwAUJiLL6wO7OEZ8xq0A/5HwvY2BcN6IZJsJL
	WOrO0arp/wchw31QBAzyi++X+4rQgsdPMbtRr5JrzF+EFQ7i68qiojdr
X-Gm-Gg: ASbGncufPjCPBZ0js4n/iaAzM6zkN5sOaLq+sGYDZgGGMpI0/yFhv7XHUkVMtLJrPef
	RcPa2FzKGIxRM+dqzT7xwrcFgqMZy7S55q9C2087OasoRHFiiHhesJnlfp3T1DCGq5nUsBsVXE4
	P60AoVzmc05waagwkQfJG6GpZh6nreVFaSp3Lrh2z3jkEl8lc5+c0pOzOamBLMx3hU6atVr2RRl
	qJ6IijneJJZRXHCBLMqNTMTUDWo3KiZo1l2e6//toazzBIZTReXH3QPaReCraxs6JTc7GHB8pFZ
	Ei68TyXjtW5VAaoMFyg3dHizZouH/R/Mkzwc1kCyK8mE7gsSIgI2ZjDbKhfDMPCHPEBOxpBe7gP
	JUeqNoFgHQxP0GpUhx30A5+LguE41eGkFHgdKkGa7VtmCdCLAhZYe+6aVx0j2yQ==
X-Google-Smtp-Source: AGHT+IEkNafZar1ueZEPL9MEDN3ag8gecCLnLQdfj/M3tiCwsSNyQ/VzfvHVVS23dBW1jEO8qtxtig==
X-Received: by 2002:a17:902:d549:b0:251:5900:9803 with SMTP id d9443c01a7336-28e9a5662f6mr71312635ad.21.1759548362576;
        Fri, 03 Oct 2025 20:26:02 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:c5aa:36f3:14cd:8995])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-28e8d1b878bsm64818395ad.81.2025.10.03.20.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 20:26:02 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] dm-crypt: use folio_nr_pages() instead of shift operation
Date: Sat,  4 Oct 2025 00:19:12 -0300
Message-Id: <20251004031912.50662-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_nr_pages() is a faster helper function to get the number of pages when
NR_PAGES_IN_LARGE_FOLIO is enabled.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 drivers/md/dm-crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5ef43231fe77..a1025bb29ebd 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1781,7 +1781,7 @@ static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
 		bio_for_each_folio_all(fi, clone) {
 			if (folio_test_large(fi.folio)) {
 				percpu_counter_sub(&cc->n_allocated_pages,
-						1 << folio_order(fi.folio));
+						folio_nr_pages(fi.folio));
 				folio_put(fi.folio);
 			} else {
 				mempool_free(&fi.folio->page, &cc->page_pool);
-- 
2.39.5


