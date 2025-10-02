Return-Path: <linux-kernel+bounces-840562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC8BB4AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A487B2391
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1428A1E6;
	Thu,  2 Oct 2025 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpBjYcRl"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3128312D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425861; cv=none; b=WZ9hoIE3PBdjNTOCByWqz1eKzCeYyPnlf9UGUlVe/X1DuKfiB+FcT1Vcr/CaUPAm0d6FzJhn2T/nt6RbCySV//sD7zpby3IHSqD7vo7NjHJWec1TorMEEsG77wPbXlsbXEWhMyyXIEyN6XKhPfWAWsg0ZXSWegKKEBIepWeMUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425861; c=relaxed/simple;
	bh=bNEWBZRyBHfKqr01S8/SKbTmlXSajYDu9W7EMIMQC6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gVnCymEmO+LzZyV1S8R+6s0MPs0fnbinKlXkIMPJgqdSB91PyQz+bSOo9wVhKKdUd68cjhlTt6LhiQeLCM7tq1omkoLdiy/gNFjjYomD2y+vWpuPKDbW3+YT21tkyDyz2/PXhUIJ+SNOS2IcvzyWl/k2KrUr86M+cWZSikQLL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpBjYcRl; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4da72b541f8so14893901cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425858; x=1760030658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMViGqdfcDRKE+thTCkDFhQYc4S31LExZ+nrwKtGa20=;
        b=SpBjYcRlOQ+0OeqBUTSaTWqj6STLep5hbio0F0+gU8dzsJ4IVU2iKA7OAhWAHdRB99
         k0ImO5m7gQ0nW4u1H7iDBL2YhSykJKtmG61YQPfKsvMZxY0jkvtMyCFDUnzEcHfqXLME
         seeCvovxT1837r9NIDl+jumTJuSnqywoqhOM1IVyuMhRq4vbjb78G8hvwEUJkTpeL+ux
         yNHA8EVEoR/6fXRq7JBWqYOlaT1TQJaDqqxypz00bhWZKOoiYIeMxAXkjduSQ46Mkxh3
         Fry0k0UHibFCqXfYAr0JfXu4dXf91rta0pw+dnQ8rJMWqVzB1ln1ex75eVsOjPOtTkof
         J46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425858; x=1760030658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMViGqdfcDRKE+thTCkDFhQYc4S31LExZ+nrwKtGa20=;
        b=It7KKnGa0bNoD4cDwjfb570SnFcS8tZLPJ/oI/RR5ATWaf08dGN6uAy5WZpXbMpKje
         mq4oaoMPbQfqs1x+Jx3ECN1xHPOHUL1+CJOqLrBf9ZIcT1YqLO0TmjEeRLx0/UynV6yS
         3C/PDooUAysRnzwsT12D8GN29x1z16Zzo45+M+sAc+B5yayTELXLHI61InNTJqrPXrYU
         aSQN6oh7aoy0ZfSgAFNbhppGyEx+HIeQ8BheN6N0Hqufe1deemslPo1wHHEiClfci1mz
         a2WxzcE7Ukvh5VHXKBdxx4EZSnxH5mWNt7106YjwE0OHMhZkRV4aqnmqTAP4fYp4rBzu
         zWnw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0g+KD7n9+cWRcKbT27qD2YYkuLbPFSXRNy4+LR882a4jWWQ+RiKtZMZZqa4BCB2i4O62yn5/Z+xuxa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCg1lRiFLecEewQTiBPVCjQMRepxcJ98Dy9HSC8FXxP/gp5/c
	kR3Jq6YNoDppwi+pIZB8SAd1hcfUGHuRZp5KfjipueIzUYhn6DYKu2+m
X-Gm-Gg: ASbGncuXyAIKgQCV3eijseEZyY/T0EkShQL6k3fas1sF7i2IySKUGlHyh1Lz2p3oQj0
	nhjEEZOPyCDeWGlOwgA+P5YIU/Ntr+V9gd3SBcv8gzxi1NoILzDQzzTaOsc0/UJ+ItLvOrzCioZ
	K13FOegMwXqGAfeH70UeSRbznDfO6Azp3VrTixIwA0fs6dzZIW18lQc0gcL9zLcS+o/PjcW8Tre
	Klrt96F4kyPdY0plpDTzvLjfNu+8V7cr7IdrEm3G1HNmLn99/eIA21wWfXvLDZgOMib+bQMbNzs
	nAKy2pZUg2FcGtI+W1mkNH+A26tGMBMksXzLnSPhUfXi1mlE1MgBx7ikp0UpLCqvidIhOto9pDI
	1OFbbLm7dJzLkLRH4iDKMsV2PNzYNmYC3a7uWo/X06o6NP2Z44UDVdgU6z42CBLUCa9dHck0f5F
	8kd2Fl+lP5LRz5Ck9lJo4x
X-Google-Smtp-Source: AGHT+IFBR/DbvZ6VQiaghYjkQSXWBduaHlJ0TVnRxV/BRzfotDhZefmEwz9LpFxscxCFJZEtu8XB3Q==
X-Received: by 2002:a05:622a:4d95:b0:4cf:8fa2:ccd2 with SMTP id d75a77b69052e-4e576a453d8mr1892611cf.13.1759425857952;
        Thu, 02 Oct 2025 10:24:17 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:24:17 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 16/16] staging: rtl8723bs: remove trailing whitespace in rtw_mlme.c comments
Date: Thu,  2 Oct 2025 17:23:04 +0000
Message-Id: <20251002172304.1083601-17-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
References: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing spaces shown as error in checkpatch run in comment lines
around the IsInPreAuthKeyList() comments section.

These were pre-existing in origin/staging-testing; git blame points to:
08a2e17462dc3 ("staging: rtl8723bs: fix space-before-tab warnings")
(2025-08-05, Zhuoheng Li)

No functional change.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index f17b16fe8819..6f147a6f2345 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2093,7 +2093,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	return ielength;
 }
 
-/* Ported from 8185: IsInPreAuthKeyList(). 
+/* Ported from 8185: IsInPreAuthKeyList().
  * (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.)
  * Added by Annie, 2006-05-07.
  *
-- 
2.39.5


