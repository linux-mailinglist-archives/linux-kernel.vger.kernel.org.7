Return-Path: <linux-kernel+bounces-799734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2F2B42F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D3D1C23F01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6FB266568;
	Thu,  4 Sep 2025 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmiEJ1NL"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96B223335
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952123; cv=none; b=UJDZ7Jo2HjY8CTMyCt2H92MvrZsLNQLhqnjK7EqB5WvHvQhFK+QDnU/hfiq66RaEHrppDKpcjdwk8q8C47TC90RvU3anwzk/9idHFPpW4ZRiQ6ckr4A5SBNV50kIl5uL7kR8Vt+7G8sPPmCkavglkMqb6nw/FF+n54gQafelpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952123; c=relaxed/simple;
	bh=d/a/06MRexX8jkafOM3Tb1PqFQuAWBAEPNY/pLIaUXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sV4wKwvGTYlYnNFNTXElmIMVMV/9YBpQCVcpzZd3fqEHFMcQDk0lNnPqviNTeLpNNZvNA5heNeBpppKIrUJbmfjDVyVK3yY+0r0XxBfbghxQG2+/67WpXt7XDPs0wwb2+QdS1kJB7zVcvLc9VWMihOdprH15IIq+76wA31HS7kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmiEJ1NL; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-726dec342bbso5135486d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952120; x=1757556920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVxRP/gHP4MJ/VTDLOIdadmwOEyVTedNOpSakKUHi5Q=;
        b=HmiEJ1NLr5VjFbCoPxofKAQkR8iRCamNLOzNtwE4Tjc/Nf2KnlqAivIvZjzt1LcteW
         pC8ATWila/pjWqZ8Z1i1Na1aJPi6Fkj/M0lTZ/XzA1U/2o9S3vJ/YZ+j4CAQFdxU/V41
         J9//1Vf/gTxLlWhPZ6qtQq+IdcboDIwV3+lI/kRoZX7BTciFjt6jD7xZlfhWV2KdjgNl
         eed9yXWHkoaThZnHdmpCkls8iw0G/Vh+bAQTsXy314tkI/9XwF4r09E1wdwjDZkdRfDr
         zFooLoXe6Oy6ByPQKOc0KED6GBAskaNliiUBqqiDudgc1jyAJ5EOE/cyhxsBJgkk3Ya5
         aKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952120; x=1757556920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVxRP/gHP4MJ/VTDLOIdadmwOEyVTedNOpSakKUHi5Q=;
        b=R5nv7CwKHJI+bGaGSOQde5zv/FAIfqdpwekCxpha8hpOR4EMiRfOi6Jrh5i1FIyWzu
         uwv7K/gO1mlIAd7tcKDSyWuJTXy+zxYB2MpR5Zem22dDW/eW6WnUzQUO+74Nnf1Onqg3
         JeUITQMRNLwBl8ebEtliOa1ogW2haIGoTzuNzsiReq/LNfp7GFmQo/9uo7PK2M49T3bs
         ItB69Y+GMKQboPLfiVP3wHDCYecZ3tgRBHXuNxsBd8Jum9HAd2momUChTkC60Frtomx/
         r6vn2PlbG8VMF6Yhd9tjUhxVaf21cI+PpOOb4kCRFhWi0C4ZRUShubbEVuqrQB7aLGJq
         Td6w==
X-Forwarded-Encrypted: i=1; AJvYcCUqWx7UBfvJozdY3ZyieIYZOxw7VMGOo8DDt9Z33zAsTjubXDaOmavCLtQMjffVXNX4hQyI3/aToXWq+yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9AyIHrEx1UoxqPUyU6haymc7C3r8Bjn+WDxoPKwO504O0orq4
	0/lUaS+cp3T6dpD6WnfTjyVgFs3sNRAZuFQmBcu0uSCqQS4MIr2XFy+D
X-Gm-Gg: ASbGncsURjKHuExlRnb0fXqf0snUwWv8QyARfnPb7TxaVgo2TQElz0Z+nAKPM4Ok1gn
	WbmZhFaYY7+z83qHJDSQSuOQ6j8Q0+oNVOQoDuULKkU5Hx86Lrm9A8tnMsZ1YoOqBz7DjrrbVD7
	wmhRRkZ8ev0upIT/RSABzLnB9nxgiLPy9kpfdoU7PY6eLhAlC/DdAiEtHQy8gQR2OlfuPaXSgWn
	h7iHzTSIe55+wU5pOuWThdiXsUS3w9dki88Ojpof86uZ0NQND83Bg/3ShpFNTOPQ9lILNQHpZ0U
	kUDzFBI2YvAo20sXj8dEuuQ5OlDAFJydgLn81COjRhLHulOzDwyCoN5/8CFCDcURoU8XQo0o/Ga
	+ZzOGWXVRNwK98e5/V3yccLR0h9Nf1F32PD5gc836uLAz9kDnFsQ=
X-Google-Smtp-Source: AGHT+IEVebM5qnAmzI7cnZAlWknRkgW85d9n6X104TWupLULP8QJNQ+sporW6oExm0LIDSZeVRhUyg==
X-Received: by 2002:a05:6214:3007:b0:70f:a347:a9a9 with SMTP id 6a1803df08f44-70fac86f022mr241292036d6.36.1756952120162;
        Wed, 03 Sep 2025 19:15:20 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:19 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 14/16] staging: rtl8723bs: fix line ending with '('
Date: Thu,  4 Sep 2025 02:14:46 +0000
Message-Id: <20250904021448.216461-15-vivek.balachandhar@gmail.com>
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

Adjust formatting to avoid a line ending with an opening parenthesis,
in compliance with kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 25f333bb0816..2c34b68f1d60 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1112,8 +1112,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter,
 	 * ptarget_wlan->network.phy_info.signal_strength instead (has scaled)
 	 */
 	padapter->recvpriv.rssi =
-	translate_percentage_to_dbm(
-		ptarget_wlan->network.phy_info.signal_strength);
+	translate_percentage_to_dbm(ptarget_wlan->network.phy_info.signal_strength);
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-- 
2.39.5


