Return-Path: <linux-kernel+bounces-840560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B490BBB4AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77749421E18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB78285CAB;
	Thu,  2 Oct 2025 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzXnblgI"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2FA26A0C6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425857; cv=none; b=EcRgRqjekge+RT7nLgEz83WygK1QFQGnPJeFBIX2eqQFgPJYnJl0hN/PRy2TvHyjc9aIhHBcEFS7oj4vNP4BOKQPfiFQZdiyD4cYb6/5kFlQq9244dMHALjaF3FKiO0Yj3HirFk/irhW2sS5bZSh07trKtRGSpaZ3p7dpxUM/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425857; c=relaxed/simple;
	bh=PDtDyr8IIupAynE7vIrcqsK9hHfnFyukjPp37oDvOyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qU4OVPF/ptcFWZK3TCtpOImknaxsGT6/LHy9PXBsUY5gTUI8PTmC8hwipIvU83Yc2vu+0w7BVk5muppSNUv8IQdRHmTTOqZCjSqckVG/M4tPe0FKt1gaB4pF9twFvCtxydvCzeLRyxnURyX+WQzfJUyiuR0Gxot8bY7wTUMHOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzXnblgI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109c6b9fcso13922591cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425854; x=1760030654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUKn8LT5S2wIt+aKDb8/VF+5KlByoVIfcbDQAP2FidY=;
        b=gzXnblgIqpqb+JJFc4gxFGW3IwwtALanE5ng6nqokgf3NYD6FwyhH8lm01PL9cNYR9
         fizqzRctDB1jBzmHcUClZPYSoqAVBc1bxu1O6riN4aPFx4cgcSdYJkB7LBQyoQsyXLD+
         9UrU8VkJs4vUtURjh7MgyUAKuUAh7nU2dle4xPV4aXGNcJ94BLQ3S7F2T/zvDLy5Sd/W
         Ai3UajNWwRpsI34N4pgV9sl0iIscCmwu15Fd8T0X7MWfr5QYfiXxhkIUSYXdXbcL7tg0
         ghJNxzuXbWpOv5LJA8ehRmBt8C4YEs8tOdG5oFVY9Y+85L9Nx7ieKiBpqCVt/5nAPI4I
         64AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425854; x=1760030654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUKn8LT5S2wIt+aKDb8/VF+5KlByoVIfcbDQAP2FidY=;
        b=QpEIYVror1+F8lqhrBQ3bQU+qN4dvDvgeNATuBBqxBK+GT7ANEjrTTv46ZWks2vdG6
         Xb4yxOAIFx0coKrz1K8+ryvoItpSo/lonLJNaE3B/Us1AoOuZT4vW1JNmRBr/bgZNXAs
         jAaDg5XRm3zpPv8pRHLjK19TUP2jEQgRdYubGImO8lWBpOYdXatCTcSLe1nOiHH0r50J
         yu6I3Hzl5muVw1gr7Eg4geWLu+jyjXwoimFJp72h3NVM2hrSXCNwyhZJdWhCh6HeTzjL
         zS9WpaW9O/Yg5+8SLfKeCNc+UrOk8Lhub2MuqDIVQcZtxGGP/iH0qnbmRMDqbwmKg6YX
         NTNw==
X-Forwarded-Encrypted: i=1; AJvYcCVgtkcE7Pz+j4qd5CaM8o5x+EpacPRSeKQ88DqDCYZgxS83acUutm32P+CQcpoHVpU7nq2FljDNwAsZzDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQO0VqWNzZ6Wg0P9UPCgU6iyMaThGdMQbC5jramO17uruOW9T
	aN3X5Z65+EmWYHYuHSLvZUaNmz+8SbT/EpAAD4GkKmE6+JjRd64OX9p/0oj3Sg==
X-Gm-Gg: ASbGncsqmn1u8hVA+iEZuyd4tIao7XxqKLvmZfswxDzC30emRsbUeYmly3DOdBfG8YS
	F73LCUTWjsxuLMl+Y8fuALyGtof4ewvSQWcaZwqL8wqqGFOf+1alSIWMG3/iw+GCzPvLtvCMTUz
	4i3S/KGdB8tp0+VPnYzYD9nXJJTn7/2pV11hAU17YnKyYsOm5VpS3ZCoNKMTgsfv5kGl6u6cK6j
	9cwdIrRfxzqtY5YKyTDHOXWAXHXkKv9r2XmKyvXyyzVTdhWNyCxThoR7uK7OV6itoDen5Tm36kH
	WPVoCpoGEPbhOKrZuop0zithwwLlMRDORFWj0cRbXEJN/fnef7FVCyFongrI+GkSQuS0EAR7c1M
	NVskG8IjoyL34jdqIy1IdamivQ9A0Z98rptmSkFHV8BTuRK1uhxjwJOiBmBVtlmkY25qrqnLWtq
	MDze0zaDTllA==
X-Google-Smtp-Source: AGHT+IFIFp08Ap7tHWi5VknBquq7SaJcKzDh2TQQuSw9g0VbvyUapfVdPhU48hZZRJTrV1nOQUyyNA==
X-Received: by 2002:ac8:5fce:0:b0:4d8:afdb:1264 with SMTP id d75a77b69052e-4e576ae6edbmr1225611cf.51.1759425854266;
        Thu, 02 Oct 2025 10:24:14 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:24:13 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 14/16] staging: rtl8723bs: place constant on right side of comparison
Date: Thu,  2 Oct 2025 17:23:02 +0000
Message-Id: <20251002172304.1083601-15-vivek.balachandhar@gmail.com>
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

Reorder comparison to place the constant on the right side, in
conformance with kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index c4d203c824f0..aa842905a467 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -776,9 +776,10 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roam(adapter) != 0) {
 					if (rtw_dec_to_roam(adapter) == 0 ||
-					    _SUCCESS != rtw_sitesurvey_cmd(adapter,
-								&pmlmepriv->assoc_ssid, 1, NULL, 0)
-					) {
+					    rtw_sitesurvey_cmd(adapter,
+							       &pmlmepriv->assoc_ssid,
+							       1,
+							       NULL, 0) != _SUCCESS) {
 						rtw_set_to_roam(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
-- 
2.39.5


