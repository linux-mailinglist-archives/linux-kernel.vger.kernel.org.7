Return-Path: <linux-kernel+bounces-841929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDC4BB88CD
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E704C0F25
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482CA19ABC6;
	Sat,  4 Oct 2025 03:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg9fRLsj"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B962A1AA
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759547669; cv=none; b=pet8MCYRmyP18ut5DuDSYlYqihFd5CjvFwh2I1FQkl2xv5iQifbEjopIDCKIRaTnP5lDwB7vx6FYK3eqUuhVVlaQMjJ/U+ndzaOcys8LL69kDYnjcqFJ+wmw7GBXjoUlo6hoq1eq49jGEIy1K/Ski/fpXjGkRcZ0BE4lAYlsKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759547669; c=relaxed/simple;
	bh=SEs+jxvnoDQ+gggMj/8O8ffrzojjD1lDA2vNrhX7WTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZXmbKOZa0/zLNh8Zou2D45yQxlzGpio2/snm85YH1r5kJnqZIi/qnUPjiK6W7513zqzN7Irt34wmOKxiLXhJODCoTnaIujOZFl7OSVL9E4vwaavIUIYrHOvN8MQ2mDztyvB67RGFGS8CEaLpV9oI0RQ5W7HrwxWGoIydeB/zA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg9fRLsj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso3052283a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 20:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759547668; x=1760152468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CCOemn72vvobbf7j0Qp9leAd109mBGP1uki9wP+tOMI=;
        b=Mg9fRLsjsl9t+qQW+KOMgBXtUndaMa8UNwUy/ZF4AU/EIFIw2Tfwo73PPDijoqv/Ly
         pVqu9T+0yb30MgAKtf+KCA/1Kf+eGwkahVn8WzUeOMHAvKLMlJVnpsFg6rV33ScreVHI
         wydh4xWhVlixOZ0zGxDuXMeWln3tMM9wZhRtmJivr4tSOJkdnfGzrcVhagW4Fa+Jqg8q
         5pMGhdxmgwXJVIRCgX16uB5mOezxmUE725HhSXuWHgqEtTAKmXXX/mq5HVrcGFnSo2xm
         fhwSictpq2bIZl+USULxH+M4zP8EJspNEsz+09kJNlScf1GAWY7YeF2c0G+2ydJMSHjm
         tSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759547668; x=1760152468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCOemn72vvobbf7j0Qp9leAd109mBGP1uki9wP+tOMI=;
        b=Qn0H3Bn8H78A0GWfaQjtn+Wsq8rhO30UVyURnx5gX0XutXBZJMX/JMTW99zRLl8r8j
         Iuuc5seVjhuyuw+lTUQCe01cUKLlbobZ9u5zRZmsXPfA0IVRHg8ySVWY0MJJQHycJYPk
         V5LIjyYUEb/dFCxa/yFxNLMjnkEPbsQPiQwa5FTSidWevlSBuPz/LL6GADSTqlES0fjy
         jKBAX6zwRjdHvIJN3Y7JVyJMIW87oYtBkepwqijaSmV5lFMsd/n1RJGcKnAmjgGxXsJh
         PlBTWXvQ7tY/v3ajyZX7xnmE7xIfus8ha5xG3n3KA+qH71k6t2eoUNHSmoyM1uzzWXQA
         RUIA==
X-Forwarded-Encrypted: i=1; AJvYcCUD76jyJKnaFs4a6tvjGw1x8LfCYAkm3/G7DlTexHW+qVDHTLOr+XpAJJybqLI1Shjf0eIbTd8/s/krMpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkjmH0XOp98NAGS2GUdS5uNs4N3pl4SPWHDNUav+HHql6GiaLT
	Q0DSZQPEmzPt9yE/Kto48v0OYdQN1BEwM2coHYxBkBHw8t3+9xssFtoOeH1PIy5iVVM=
X-Gm-Gg: ASbGncvNbclcuwjDMHcD0v0HkC3iTZsEIWZ9QRirvKoa+g9Luz9gBVMJuExykgNbF25
	3URE0KQlllKdEIK6ThcxBXzYL/er5dSmjz7NdCCztBGRTgg1FvMMUZvirGrsTQfg6qS5KK527Sl
	buv0VcgaJmyy3q7O/vc3R47bNt9TmZmFjFjtQ1YRxgD7f3f+KxUxt1XCY/htDouTWsxNHj+J01Y
	ZRaGCmz1SaBvYW+7K9slK/VhuZmkTHi7zJfGMKbUpydqzW9L7vM03Z8J4LnVUDA5KdGme51eoPA
	Jh+d9U8anqfhX3kf8Mls4zvcHx6UPynFln6ZPt1sqkcJSz7LIEwQTar0vX/BkCsB8JGao5yxR0h
	/n5dl8klTcBXfVpfvpQTPRi/ubbiULPO5s/dsN4EouVEBJvfUWEP/zdJCzxE4PA==
X-Google-Smtp-Source: AGHT+IHFhY7jMV7cBJzt9SHbTOialNjWOSBE1RIX+l1qo+ZwVRnG+J5+DyjyP0hLFNjHqTBLVQ2Isw==
X-Received: by 2002:a17:90b:380d:b0:330:4a1d:223c with SMTP id 98e67ed59e1d1-339c2722811mr7005796a91.15.1759547667654;
        Fri, 03 Oct 2025 20:14:27 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:c5aa:36f3:14cd:8995])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-339a70246c1sm9481967a91.24.2025.10.03.20.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 20:14:27 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] io_uring/zcrx: use folio_nr_pages() instead of shift operation
Date: Sat,  4 Oct 2025 00:07:33 -0300
Message-Id: <20251004030733.49304-1-pedrodemargomes@gmail.com>
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
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index e5ff49f3425e..97fda3d65919 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -172,7 +172,7 @@ static unsigned long io_count_account_pages(struct page **pages, unsigned nr_pag
 		if (folio == last_folio)
 			continue;
 		last_folio = folio;
-		res += 1UL << folio_order(folio);
+		res += folio_nr_pages(folio);
 	}
 	return res;
 }
-- 
2.39.5


