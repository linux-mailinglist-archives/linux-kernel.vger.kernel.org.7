Return-Path: <linux-kernel+bounces-835837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2669ABA82F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761473B07FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B92BFC8F;
	Mon, 29 Sep 2025 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhORny8U"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC302BF3DB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128635; cv=none; b=Sf9+WDCObwzV4LrHy9Du7TnDCqdtn/An/Nv0NiJwTro5v+2Ard4hECeDNnmr9R2iyxC1WydaFtSRUAQdTyrOcrCwoqWClSzaW7Yh5ffof7nKc+syyXabkDOJf2zQXnb5CQEbqnFN2HpaCKX8V4/5TgRBfn2nEfwvO0jfn/yc+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128635; c=relaxed/simple;
	bh=JmI3rvfGEf1Z1riF8sZuENvE+ZlBl4htm6xrdJ3xaEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApG8toE21zb010gDPcvuUR+O3hY3f1rj1wT+OmfbDubca7pOC6erelCXK8XpX4QIz9ysR16+GOZqjQ5QNsnPmst9WCqjqzXg7RBMH4ocoOWXn9x6V37qFfvHwvi9AASjmdO5TPiPu5F+7wbGDwu5YWy8zlws4ZoJxJPSSwxJbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhORny8U; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-85780d76b48so455780885a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128633; x=1759733433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=420xhJpXeiS8O0VHfKZK4Z2TaOUNPYgxom/AXLmk2uA=;
        b=GhORny8U2ECO5U+JOAKW35yd5atXuHqkJmXTXI/MaHzKaOqclaasruul4xFA7aKWuY
         oLER+SHnbu2b6U3InrgyrkMMXFlMQwajrlEze7usWCnTL9R+Nm/NM8UUzXN+w0WAmi//
         jxCJSVNNY5hKvmn7VH9ebXOnn/aSPYaEv6cMVipQHndm4Pg8aZ2QUmZWl6Zj/DIrX9Pm
         8sFRpNO7xKcJiUqSOhn4TSbYiUvETGkf0nJHOkdKHvL881uPQhOcXCaJHiCq0ss175Bi
         HyfEJngC8aveRlUmngoRb1aZ8q5dNZGI/07EXJ4VAsfKOPJUGoJzq/vRVt/nzgx6Uk2L
         uv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128633; x=1759733433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=420xhJpXeiS8O0VHfKZK4Z2TaOUNPYgxom/AXLmk2uA=;
        b=FaXoxQrhOYuxg8GRKzMgQLib1vBrQ9UMFtTEaHblY4FheCHt3/NEH1ESHY8CM+7ObD
         xIHJndJ+2XS5j5FVNPTpCGa+w0efpkAAcdJhPVa3KoEIIjOLeaJX31E9lF2s5sTTtyYM
         xnd04Djwe5Wuc7OrpCu9qEKwlcZzUdTPJzaNeA0HDzlUnLv5PXtlNlh65cYpRktQhMbk
         Elw3GiRY4XYdB6daVXkg4RhRVDyf2uFTNJlpX7XS/P9noHEXuC+OU4pBkbUF+tEUBO9u
         esia3oVfy7d7NsvYubQALmpmimFUU4wRvQdemzL7RtYY9kxhyTSkl/KozhVszuOcypb0
         Iq8w==
X-Forwarded-Encrypted: i=1; AJvYcCWfeynX9WiWz/6Ka7MN3KmHH46CGnef/1OviztG2TYY3LMG7bFKi+B6hPNeOSAQxqlolQmlIKyfQlOkvaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7ozJDncv6xXL3mJxDn86IZwhu9EB6wx2bd6xXMoKcz3Kasus
	/1pMLQWQde1bW/ovrLRxwIZU46gRKshSRorwRTEBFDSbuMhHCCVsnsmL
X-Gm-Gg: ASbGncsrO0gEFp5+HXGUxUNRQ/dLuc8nMWOMB4MxrdujYwgUaagH8c7zhPMwR6nu/p2
	WWkGEE1QOL1qz3+R6LPXRNAs8Dz9Moxj3r7IvL3Addf4NScVfZPzkEf8+GBB+tzas1IFMsFIMQX
	SqQmpovtUuivAeiZWVDsQXAODnTbmg0J5kd286j0dywqom1Du2kQKPygi5dE3IgZ3i3DYaY9Lcs
	iBp/l/QCGL+hJg4lcZoY2ROjPVJ1+gvuQJUpOpc8hgCXIQZs1MN1ONfERreNKP7tSFKRvOmB2vk
	Br5M+pu0xtNmR0ZrY7eFem9ff0yC3SaIVUW4XtvP39eDwbUSExadsdMKuVqjG3M236DeG/tBix3
	n6HMsYB0g+qk+kcNCFp9vASpMZZpFS+OD6WOOSVH0J4vsJ09nzGg=
X-Google-Smtp-Source: AGHT+IFOQPBsC9e7UI3wqDCezKEuwKs2i0wwj9znekjUcnXwC0zeecRTk/Pm5T+vLslHnAzLialU3A==
X-Received: by 2002:a05:620a:1a04:b0:811:d0a3:4027 with SMTP id af79cd13be357-85ae7156ebfmr1949751285a.40.1759128633014;
        Sun, 28 Sep 2025 23:50:33 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:32 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 02/15] staging: rtl8723bs: remove unnecessary space after type cast
Date: Mon, 29 Sep 2025 06:49:47 +0000
Message-Id: <20250929065000.1010848-3-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
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


