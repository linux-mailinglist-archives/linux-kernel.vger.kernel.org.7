Return-Path: <linux-kernel+bounces-840548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6986DBB4AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E24167FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A21A271449;
	Thu,  2 Oct 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQENFczi"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98927055D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425833; cv=none; b=mhWBn7CZAqiMKfOYf154pbPNWKCQr4LKV5QCZodtt3qjl0oBRjOFSx5bOxpDKM88CasQ5m+PGV1+fr14rsuCacsC7zIppONiWG3UDdhTn1Xs7Lxs3Iid+6Xa5/6GhWgaYMjPCkYyLy0Nv+hakqFmK7HnX2zOJwbTLnFVhMqesew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425833; c=relaxed/simple;
	bh=JmI3rvfGEf1Z1riF8sZuENvE+ZlBl4htm6xrdJ3xaEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8s1FSlIOKyaeFGxdN0hD8youTP/6EB9EnoIy9j0qEZjbTKY2J0sMI6uzlo1v7qzbvOurfJ29/GFJ8CEpnEJEDjbMpVvSOZCrtZBodqmwfSUgHkY+QXxqUhb+npG0/r3BUiBAkNpIUch57DSM3AjTn9LQ4GcgQFc4Re3RAK4DPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQENFczi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4da72b541f8so14887001cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425831; x=1760030631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=420xhJpXeiS8O0VHfKZK4Z2TaOUNPYgxom/AXLmk2uA=;
        b=jQENFczitbDr9lkodh0jUJYoFuEIFh0ZMm3waqpZHYZkbVzNOrzFNoGewmmWtCItdJ
         R56gAIdH/Hh9Bf28CWXHRXfhC1Rumq9XGOOlRUGfcNDox1RaDYkO+RI7Z4ruVyPENcvS
         bc+hcvt7GVBscmL43oNdulGD0tYSPpufVFiKeBGa05ConjqOM7Iks6agX/Exch7xvvdy
         W+Md/yddV9EYf/6pj02iXDE14oKYMHNTxJTObQFjTztCJ0mESd3Sg8QWRA7ziUnTVfap
         0ESsXPVJL35c78GdgaFjq5wcML27cr+IKBDu8FNwzWd/86QZFoftAEDQWPAiTg6/ITsa
         GUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425831; x=1760030631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=420xhJpXeiS8O0VHfKZK4Z2TaOUNPYgxom/AXLmk2uA=;
        b=TQDd2sZNiyYuU0uXWTZH5G1x+K+7t+lwA7t8SFDdcYw5uQPgVQv/NNZYiJ3rZODJ4i
         8QhIOxoAYYXEpJdqxD2fPOfj56u77sCufO1oxAXTPFJhSsWRdWC23NgEKl/j5WwyMccC
         eOVVcpKxuK84YtXaA2vVwRseOllVihijnuE9LvAi9Wff/6GxvUvw0LP4M3OFpEq+Uqa4
         sUJgS0Ky2+kmCHYRTP9YwsvgGtjJYSzVWlsrQ4dJ/+jdVYo1yDKPteKag+HtbMwz2WKx
         kDa4ETgBB67QxU5ciVjaF9CsdFlCicwYbn4C5tS88omNQzD99EymP3KZ9zeRJL509N4M
         Z3RA==
X-Forwarded-Encrypted: i=1; AJvYcCWhjXs1GiBQSjlQJc3WQHMa07RDc+GJpoYhOV3x7bsIhVfIdSjz8Tu2RIKQ4WuFmjG1/NFUQu1MpAgIFHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWdsD4pBr4VsX6xIo19sGFKmV41+PcG6lz8uuhd+6kYfnIXCF
	+0h83RrTQKNd44mFPFydjKGEMgnbR6y7VohHgu5lqkykdeExLqvYZIDarjtCLA==
X-Gm-Gg: ASbGncuvycWwgFxVa1waEVqa70tLsqU5tWBf7dUVkO6y6/lMqgCXZLwoxjFU+S6wGlC
	QgFr2DkHDfN5d9KTZygtbdYebu9LJxetoA03+NUdfQCvsQ9y0zyjfevlQEOy6GtQhFkwDJlM/ZB
	YO25gvT8thTX71Rx+p2QDHwKDyaqsp84ef4sJb7NomV9Evi2G5NCCd3VY3P00OypLM+qwznksj2
	tJn5+ZLaui03k12xSYGexk95QAiWjeMdxPNAQ7MGQBTHGj3ThAkrByvpLztTG3DhZEQCrYY2p3i
	cZI3jExNGyl/OSXqEfcyAkWXPN4edXcOgszBceyrLGZU1mezQw/+iJBvKo/f1lgQO/L4TQdFvCp
	Ww6BQw0Mqb4vASVlQE0juWwzNtNQ9o6AcmqmpPZzbzXoWgMXUr8KDtrgqA2H7d2mVWfUlKul6E9
	Q=
X-Google-Smtp-Source: AGHT+IGfItm29WSvAQomqrxHJt7hMmXfIayQsgFHSLYDyuV5Lb7XaNWV6JC3vLeWw7ZLk3ala1Fd4g==
X-Received: by 2002:a05:622a:14c7:b0:4b5:ee26:5366 with SMTP id d75a77b69052e-4e576a7bae4mr1456461cf.26.1759425830892;
        Thu, 02 Oct 2025 10:23:50 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:23:50 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 02/16] staging: rtl8723bs: remove unnecessary space after type cast
Date: Thu,  2 Oct 2025 17:22:50 +0000
Message-Id: <20251002172304.1083601-3-vivek.balachandhar@gmail.com>
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

Remove unnecessary space between the cast and the variable
in two instances of type casting. Improve code consistency
and align with the Linux kernel coding style guidelines.

No functional changes made.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 516e736d03f1..43244e950faa 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1101,7 +1101,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
 									(cur_network->network.ie_length));
 
-	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.ds_config);
+	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8)cur_network->network.configuration.ds_config);
 }
 
 static struct rt_pmkid_list   backupPMKIDList[NUM_PMKID_CACHE];
@@ -2547,7 +2547,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 		if (issued == 0) {
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
-			rtw_addbareq_cmd(padapter, (u8) priority, pattrib->ra);
+			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
 	}
 }
-- 
2.39.5


