Return-Path: <linux-kernel+bounces-805468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30670B488E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E623ABA45
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC7D2E371F;
	Mon,  8 Sep 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv+my5rN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F561CDFAC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324725; cv=none; b=ArmFURiHDvrD3uZsvZl3hRdkENt969ulZYRtl7ur9Z35v2d0gtE9JmFaPFhD+hjbn1qkldJ3ako0YV6ggziXalynfhljwLH1gJWdQZy7HL/K3GixV/ylVQZiAprNwV6givLWXbv3yQOlVT3z5ce9z7k5gvvw3Ec6N3y88NkHFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324725; c=relaxed/simple;
	bh=tZvRA267BLCpMRJ19kzBIfSvFP2U7bbBur4KCXWxwe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvowByNIo84B/tpKtiNW7EY82tt2JyBKdZtJ4+QFsAb6kUwmTOprOhVg9NzE8hIxlPAgl51neRL0zTWXxF0qqvG5sMJp+HzSt69JIyermjusSv98jIvF0wQvPxJ6M9YJwrZsc3PBWO740O8tp2H0D/jgZTWpg+vM4DA1lCa7TJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv+my5rN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757324722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TGVC13WThJMLd8fP4vjGxIOW9dEwd9L7U4OPiTcFDVo=;
	b=bv+my5rNJjTHojSJpcu20weHxfS5/EgWSdB3lEfe91o7QLCgiCwzXWf4No/FG0wgfvzleF
	Uouppz6zqc8Ojt/Z7yiZfY0ihX4JDQpChZ7pgBY5Rp88BM0+dcpGpFRalcqUC4h45r1E3l
	5VbNKvA+yAfdAO1580Vz9SRRaaZxHHo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Roh1PISnPTiIGoXDXKO44Q-1; Mon, 08 Sep 2025 05:45:21 -0400
X-MC-Unique: Roh1PISnPTiIGoXDXKO44Q-1
X-Mimecast-MFC-AGG-ID: Roh1PISnPTiIGoXDXKO44Q_1757324720
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e38ae5394aso2317931f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324720; x=1757929520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGVC13WThJMLd8fP4vjGxIOW9dEwd9L7U4OPiTcFDVo=;
        b=pTRnU1wEBQQdUhmLU1bncNnz/oHTx5eprNsx0OPAqGVMVJB75h54E+YBuhqEvrTIl2
         dF3+3hXjDyU5Knc6iQO2QGGBWnsuun2P2dAmK4KGlYmOFL8ppAx9KQO7YWoGffe7w2yE
         iVqC1qyoLK6j4YGfvTu/y7mOCxkbHMCTPbwoK0OUk9vRIperkS3KbNbRimNT5RqpCHsO
         aaJO8r0ph0Zx709L4NXEktFqIpBj0IRtwG6hf5DdgMvkgR5613j9J0WIy2RDlMbLbu+K
         m4XVZb1ehbP8ynz/aWJOoKLox6+Sr5KpnRP25ceL5iPzXG3oDyHHnQjOllknlr0wcut9
         JR7w==
X-Gm-Message-State: AOJu0YybVxdqjFGs5rfvzfOkvyrNVPD8sFb+qKiZ1+R3DKRdAiN0II+C
	rWJQVHtnXbGe3uXXk0JFIdJAZ800SfFYm0aOIg+pC3Qcqdm2P7gqKRV5LxpuPOO9wWtGR9JfK8/
	PnfyHGpH87ho+/dQh8VbHlc31GaxfTz3kRZZalxfQCSz4is7ilnRR9biBIjlUvsH66S/t8LB+tg
	fSwcbBmn6MkwqyZbIqcEx9bl8otKckHkJen17qcgtqsbUVRA==
X-Gm-Gg: ASbGnctdNF9xdUOlUVzCMDCP2aBZ9S8cPUIDtNZ1YydeGAy1mtgPa6l+jbvq1IrSnic
	U+Wa9UInx53LW4pWi4E4IpEH0s+P5oN3klj3RurHLNJtqWI+oFErGGRwtnZkxDh3qrw/yNxKTRW
	l0bt6ysVLw8JvSOz32bRIFHTn/fwGb4YSppnW/ENYtvW22tPTJU+0RfbEaKGAmWensV2aeGjXOV
	75MwVHc/C/QSey+rO08rAYRcOfZvd8xoUjkXB13ULEt6PpAlrhYkrn52aBAodta/x5Ircm4bnno
	pgrSZ6AcLWS34RBSVvlBEUoamPLhkEWvpKPfnS1lAKNYtpxSdvziphioay6Aave9tSgp5ewRDPf
	8qWZX7n95Dcb3K9hl/ecfUaw=
X-Received: by 2002:a05:6000:2302:b0:3e5:5822:ec9e with SMTP id ffacd0b85a97d-3e643a24592mr5191227f8f.41.1757324720151;
        Mon, 08 Sep 2025 02:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBtlUA4CQzXRrmkdIYxDOgy8QrWzJ63klyMxD3fvVe5qGUrWCpW70tUsnwgk7JCg7Jp6MrbQ==
X-Received: by 2002:a05:6000:2302:b0:3e5:5822:ec9e with SMTP id ffacd0b85a97d-3e643a24592mr5191188f8f.41.1757324719563;
        Mon, 08 Sep 2025 02:45:19 -0700 (PDT)
Received: from localhost (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e92a42asm434745685e9.20.2025.09.08.02.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:45:19 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v1] mm/gup: fix handling of errors from arch_make_folio_accessible() in follow_page_pte()
Date: Mon,  8 Sep 2025 11:45:17 +0200
Message-ID: <20250908094517.303409-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case we call arch_make_folio_accessible() and it fails, we would
incorrectly return a value that is "!= 0" to the caller, indicating that
we pinned all requested pages and that the caller can keep going.

follow_page_pte() is not supposed to return error values, but instead
"0" on failure and "1" on success -- we'll clean that up separately.

In case we return "!= 0", the caller will just keep going pinning
more pages. If we happen to pin a page afterwards, we're in trouble,
because we essentially skipped some pages in the requested range.

Staring at the arch_make_folio_accessible() implementation on s390x, I
assume it should actually never really fail unless something unexpected
happens (BUG?). So let's not CC stable and just fix common code to do
the right thing.

Clean up the code a bit now that there is no reason to store the
return value of arch_make_folio_accessible().

Fixes: f28d43636d6f ("mm/gup/writeback: add callbacks for inaccessible pages")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d27b6b9818a18..c969259d095c9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2920,12 +2920,9 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		 * see Documentation/core-api/pin_user_pages.rst for
 		 * details.
 		 */
-		if (flags & FOLL_PIN) {
-			ret = arch_make_folio_accessible(folio);
-			if (ret) {
-				gup_put_folio(folio, 1, flags);
-				goto pte_unmap;
-			}
+		if ((flags & FOLL_PIN) && arch_make_folio_accessible(folio)) {
+			gup_put_folio(folio, 1, flags);
+			goto pte_unmap;
 		}
 		folio_set_referenced(folio);
 		pages[*nr] = page;
-- 
2.50.1


