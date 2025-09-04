Return-Path: <linux-kernel+bounces-799722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFFCB42F89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16E83BFEF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A51F0E50;
	Thu,  4 Sep 2025 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHZP7c30"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AAF1F131A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952109; cv=none; b=rPRLaULp4VcjvI4s4HbnYWTuhFoKfowKLJGSQ3FXwXHqFy0aoueuJ4NsLWnrWVHA8OowhvGU/5R3zW2O6D7wsRQ+xZzrAxWjr74hGL4T4ZcOZ3xOAu/8A2JwMGoqlPrMCZPRhWM3kXV+bhco3JnCkFjIGZLsfRzWyKCAm5/N9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952109; c=relaxed/simple;
	bh=JmI3rvfGEf1Z1riF8sZuENvE+ZlBl4htm6xrdJ3xaEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTbsyPuI9t0BSDT0h6kTs8lk3J7li1ViPv9Btl8tRlqHqa7UgShEVMehBUz07kHFtKCvilCwLGaFqcXRsy0CwnAFNoTIgZl73IKXXgAJleR/+0zWninG2bgQs5s6oyA4NVaaUQJMITOuwArzAGkdrAYRR53pGFPu7Lmo5yL0ux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHZP7c30; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-80a6937c8c6so71384085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952107; x=1757556907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=420xhJpXeiS8O0VHfKZK4Z2TaOUNPYgxom/AXLmk2uA=;
        b=KHZP7c30RHWWU8Htqa135F5LE1KIWzcUe5CQTn2eEIFUJWrkqo5L6dkExzBuaZvqJR
         GPgOp4OGT5rYXf0DLVClkKjD86wX1Yw98oJuFE36U3ylPZtfep4lfIz6byyFM9T7hyLa
         /e0wOIAA6bloI8ROvTdJAeCHpt8rpxO9CZLmItKd2h0rs8Ml7pBNxg1TKjs8i9Bq8NZv
         QoLqBSrG7v69sUWLMITe2XHNws8nB0lqB0Zp55FeWtxMd42sX9O91C5XxGlRzBy8Yf+P
         DRa6J9lIyP0F/ohKc5zklgMHhchtfl6OpbseeEXogzijjLLYdt+Rg6xjEc0JZAw1J3/0
         P/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952107; x=1757556907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=420xhJpXeiS8O0VHfKZK4Z2TaOUNPYgxom/AXLmk2uA=;
        b=OMWMSGD3iH7wv7sVyBEt0jamRHZl17aI5f9pl3q0uTLtAoRTAuT5B7DnqJPfYx9o4u
         8r3p52/VVs9cGkbThCRQToKb4CLLMtcLiBTtNhCF0luMuuHPXX7eu6tQL5g5zneOuJhJ
         6X2k+IL366IMJp/EyqjUnUV4ZPv4Rjxqr2CzHkjSM0agAITChuLq/9THgDGfdwQNv0P5
         rKHhjR1IBpqgCMQ/t++KXPJPhd8Cq90UV+dpjVLi8y7E5OUIUMt35T/RcEpqgofnYl5S
         8l9bTpRpMnASXWAENwtph8ob+N2XjYkbPy78STpwEMuf17P3g04D22zwhKbJYRNstd29
         8zKg==
X-Forwarded-Encrypted: i=1; AJvYcCWN44LXr2UL1hLwtwj5jIaiUYRRUSw8+hUDyxwRGwFD+r0hklDDRdDoSrcqeBVR6/VI5Mx9cpjdx3Unn5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvP6FBI5QbNVI+pJYUCsy3hhJljaon2bMy/s+TEsMLLPqw8s0h
	2M6deaWlPg0tOjouMOmc5bQdZBOfVX50BWBy2/Qr0wZ7CqXq7koAOsvO
X-Gm-Gg: ASbGnct7A229ctfDMcus52eHeE4xC4zQ6tN8rIU6SuT+DvoT+pifrCnNjkEhZSgiCQj
	2KQCOlNLJW8oXbMOL6w/0b5olbSkA7mk/OyXFJg2jFUuiWsI5v+ECPWK6Crb6tnkaPB5+SkOUKR
	h3QGdPQpqDTNxAfnxOEVZiaDWw/DAPauQfHmHH6TCdFftTlXG6/8g9sE5G1bEz7cJIVNBpteXTS
	kaF7UUgwOYimaufcKYsKsp53W7uxT+qzdLaUX5/lLy0eb2ChFz3TeU5REyRhONZmi1SvUwDd/yV
	8f4toOTUi5zUdzwaQ7GPRiTHeFnyG/ph5jHgh90ju9zbDdCfipbrtcOzZ5RJdYDa+ugikvzldON
	jyHAuUQFBotU7Fy7FnbL+ikzCU6ps33zhlBgJn8gXQP2MmmGAeEuo3jfntsfpqA==
X-Google-Smtp-Source: AGHT+IG5kLD8eWxZPLfL+wNBvxFGXbMhdVZiaoqWw8aRLtKUk8BnB3R9Wm0KBkGDhvNrtgPFa70+1Q==
X-Received: by 2002:a05:620a:40d5:b0:803:d9eb:5663 with SMTP id af79cd13be357-803d9eb5741mr1386993585a.34.1756952106984;
        Wed, 03 Sep 2025 19:15:06 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:06 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 02/16] staging: rtl8723bs: remove unnecessary space after type cast
Date: Thu,  4 Sep 2025 02:14:34 +0000
Message-Id: <20250904021448.216461-3-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
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


