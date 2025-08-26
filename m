Return-Path: <linux-kernel+bounces-786058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE08B35477
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F77686EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB82E1EE6;
	Tue, 26 Aug 2025 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITlJ8waC"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286B2EF64A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189409; cv=none; b=N5D3zSeCeJNhdCTR9lcZEpBl2gx+uLDTWoxwizmsTtZrZYEVh3DYUvJ2t5K+sJlWmf3i7kp4o/2MFloZlGrGxBuk3QsYc+gUU4g54uj9SvZUn4t3bv39SCnIhsOjFDK9GxKhYxXAnRRwAI5gixD1ICvLHQgYSw+NFioQ/zCmLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189409; c=relaxed/simple;
	bh=C7cPZLFMyiIe+4CzQuLyUuTVf46p2GXozQVEnHowXMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/qdO/tj9EP1DKLC9LUlvBSEo0nuGcTl3HZUvVkPxIwTm3KZDBtlGhUvHR2ASq8l+lSi+MYGi3LrvHVArnEXOyXtvXfydTitmLZg4wyWMsUB2A8TBGZdnx2Oo23G5+V/RcznNJQLGC4qB/lbeEP13vPZcQ6Qsl/fRN8AtE+Bvtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITlJ8waC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-771facea122so124820b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756189407; x=1756794207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZyZNf4Dr55KEIlR75zNWS/ByBEDgqsfEHPE537c8XU=;
        b=ITlJ8waC2AVlZaKox4NdQ8bYgpvPIaC9vm/vrcwcflA2PG6W8xl/ktX8YrqxkKU4zY
         Vivdui0Q5z2N8u2j8HMwK6FvQct913ocHQuOVzb+jk7Qtjxc4oQ30PoGyXzGRt+Dr9Rp
         WiUI0Ot6WGFBUWkGmfaK/ezGpmJYlkSAJnaKE3AGQYefeDQlOEksSEvHDQAfrtOWNEjQ
         Z+VfxUflegPcBCYDbgjxFC7THy+TpYT4LgIA9ZTCLfqfAo9u4DxBV+GY7G4dRkuxdFFN
         rLWnszOBbFjk59fX1tQtCwjKeN/G2jCjqgYVTdW+dJjzh8rOAgPxC9EcHDcK9yw/pQGP
         Y6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189407; x=1756794207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZyZNf4Dr55KEIlR75zNWS/ByBEDgqsfEHPE537c8XU=;
        b=mby7S2DaO2C7b98jjLUjqP6iVnWyhiG4UYoX/lCBFqWa8GGFxA9GiRzoma2i5Nca5p
         oRPv+JvdBiTzymvz29tlrB2J4bcvfVTCbSVVyOslIZPmXS3He13ztMQGWvRxeoNJkujK
         9r1vDOc33opUcc4dlgCThKwmRKnkb6+Kd71sf3S9vki06FOLXHSYv18H+5d8vlEqxgW1
         tgDJkhqFGFemv+91FlNiK6R1n0ZLndagYsEOsgOp25us1MrBgeqe5G7jwDiFS/feuy9V
         58yMe1SnWc6x4an6dMWyUe0DCkke6cj9qxVQG/pl32n4VifOCRXpnkkOlGJk43ER8uc1
         SqAw==
X-Forwarded-Encrypted: i=1; AJvYcCVHz4HsroWknCR6QmIW+1iBy+EtYTJENH51AJgqaaOK6yxnKO4RNgiqioiOQeWYdQN599linBNnHn5jVqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHm8vSYE2+Coc+R519WSVXq3xtu2LcCaXm0IhcjHWsyw0/r58
	Z7GE45vfMmLrndn/zJEJmRziuY1CJRJ3wLlPW18I3wn9e9NnxfdwCnWB
X-Gm-Gg: ASbGncteXbX61y7PHD5SYi/VZgB3ihmMTGThCaZy3hNXwDMX/eaFrrFIGI0ZNNkassB
	w7nPSyX1ISDqA7EMIK+jYBfEOaubJnXCRo//qvR06i0NRkBvCbo+0PJ60AmVZK06szlgHIZBxhn
	xspC++dlTp9AoGjINQ+yMIl5VKJYHtTe0P/ZrtblWFi0BdHe0nIMFbPL2wzY/5XBBEqkJwArj0r
	zD+mp4+vLdsa58DnOmLujGxRRjqtC61VcXP2lqmquu0uEr66U6xXBrBdh46HFQCHOQq387LNkIN
	TQhM9aZS2ovyjqfOacJ3laXy938rWCUqXHzF1nn5kSwOiy4eFH+UffhFfZkoxZbkqISFDW/Icz8
	SRRrSIFCrC2PKB6twZP9YWRLgHA5THIuf8UQZMUj5Cp8Ixrx8UhIcL8Q2cd92ZiATb71iLGQz4Q
	==
X-Google-Smtp-Source: AGHT+IGoeyYkfTdO7uF1s8t48caGzsyOPfqYIDXRxUuDxsAVNHKoMtxa7xfOKLylp93hCfDdks4Gqg==
X-Received: by 2002:a05:6a20:1586:b0:243:253a:fb7d with SMTP id adf61e73a8af0-24340d2c163mr19908117637.34.1756189407377;
        Mon, 25 Aug 2025 23:23:27 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fbbc3bb0sm492535b3a.66.2025.08.25.23.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:23:27 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: vbabka@suse.cz,
	akpm@linux-foundation.org
Cc: cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	glittao@gmail.com,
	jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw,
	cfmc.cs13@nycu.edu.tw,
	jhcheng.cs13@nycu.edu.tw,
	c.yuanhaur@wustl.edu,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: [PATCH v2 1/2] mm/slub: Fix cmp_loc_by_count() to return 0 when counts are equal
Date: Tue, 26 Aug 2025 14:23:14 +0800
Message-Id: <20250826062315.644520-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826062315.644520-1-visitorckw@gmail.com>
References: <20250826062315.644520-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparison function cmp_loc_by_count() used for sorting stack trace
locations in debugfs currently returns -1 if a->count > b->count and 1
otherwise. This breaks the antisymmetry property required by sort(),
because when two counts are equal, both cmp(a, b) and cmp(b, a) return
1.

This can lead to undefined or incorrect ordering results. Fix it by
updating the comparison logic to explicitly handle the case when counts
are equal, and use cmp_int() to ensure the comparison function adheres
to the required mathematical properties of antisymmetry.

Fixes: 553c0369b3e1 ("mm/slub: sort debugfs output by frequency of stack traces")
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 mm/slub.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 30003763d224..081816ff89ab 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7716,10 +7716,7 @@ static int cmp_loc_by_count(const void *a, const void *b, const void *data)
 	struct location *loc1 = (struct location *)a;
 	struct location *loc2 = (struct location *)b;
 
-	if (loc1->count > loc2->count)
-		return -1;
-	else
-		return 1;
+	return cmp_int(loc2->count, loc1->count);
 }
 
 static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
-- 
2.34.1


