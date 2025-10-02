Return-Path: <linux-kernel+bounces-840559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4657FBB4AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CB57B1CCE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1238283CAA;
	Thu,  2 Oct 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQxiuyM/"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8EE280332
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425855; cv=none; b=Vjf5OReF61LqPalwgMmRN5YlE8SlzmXA/XT1XY3Aaw7a18KGCoomUy0dOcL2nV4eMXB9g1+HIbYWtQmlAeDe19QXy26AX9tvIKs4HxI8c+VUzjhk/5I+e1RQJyLkwseGdXOFUHtBaVgSjzBh1YNqeoFZINCsZ9erfJ3jSThgnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425855; c=relaxed/simple;
	bh=dwZfLXH8d37v/B3FJKGsonwulSm1Vgyq6CvOcjfbAQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOVlgFe4WMlyLQgFOZpn1dbT+6+ucOqvKsL5afMBBs6Sl3EYSt362mtYvA8n5npNdy7+QAWD6Dacb5hGHrit7k8QAFpjo9dSu3ldD0aweGGcffPbi6CTSPVplHtgjs56brYNhnTbUeyygJnKROiaCbtDf8Oeb9a1cRXoMaPRf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQxiuyM/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4de659d5a06so7564281cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425852; x=1760030652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=313mVP8VdjBWl1khwEYBeX0tVgZSweYr09fkKuFWGbY=;
        b=UQxiuyM/Vr/Bu8blLc4W6ZsPjTo7quLMV4gw/BYJLgjPMKveD/olP4F2DeFESU1E3j
         nvNXTsKnwZ8rKSNtHg+30TM3VMvn6TeDJz4dzR8Oyaig7aeECqKx7wPSy48/hpTQqo1G
         h4IS+alkje4tEKeL8sk4VtH4rKkBLuUhKj3C9Cp+k7lDkYP0D7G9xG7Do+UMMoEnKSMg
         Ys3ICJxJp5O7mHTneyGB6YDL9dfqR3gb0GM3PKGHXvF+lSowyk0/5OV7g/GT9xVWrTmJ
         +y5CukfeT8fRR91v8H0imLau8GnrPyR4Q26NSQ+5+MSsvTT1Y3gwolp1N/8Fb9HSaDr/
         vfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425852; x=1760030652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=313mVP8VdjBWl1khwEYBeX0tVgZSweYr09fkKuFWGbY=;
        b=Sw8HCYq3QbL7RBJE5ZJpoJwO9jPVwfOX/toPHsyYyDNgeo3iMrd8JZSkpxCumYrQXy
         oO2pt4ikBr2DRnCChV52DaMV9Qsplky8eL3EDU6IX7oMOW9PqGObB5FNGozghAkbaTTv
         aKp0kab9wER1Lb0FT7RnBjDO8E69jkeNnM/PROjBviQofFOXG++sWfjPtGj36FdD67U9
         gMYMZLi94YzAyne/Hl6FOr3qJlrlyHWTTkK2kb8mwPS8si4qLIxXbdQoITejQrspQdKj
         96ZrxOs4ysDyC8efTuGXIIZOc1nma20R+0p4pXF6NjCK4Vl2MXMS2tNquKLVxerltUsm
         m/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWf6Q7iRaHsuqRExTsyq6D6qVp6W7A8fqsAb/DujO3gu6XzlzCjPCqocjwzfOiE/PNAog5QO9bZ1y0/Zts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2nwJnaLyftQZyJTvRDz3zjvZI+QZtO3S+l6lEm67iT4OPwUFL
	FZPHmLaKc4i+ylWrgTfaS0UHygMq1E+mGm+41uY0Z9G9dUEuh3sdqRy8
X-Gm-Gg: ASbGncu52Hp2B+Bup6meJ0ctZydnR/4HsHj3zai8MNzUi90XCCYaiMM8hh/F7xX2Pvr
	YxA32XJy+pcdieF0+vdZxCt7Pao3dWSmHGwHZ3DVaoca7Iy5BlbsvPBBeACfYxZlvzRpSaMEwFL
	rwk7A6ZpO3fzzmQCJY8g6tMxWtpuAjfCZECqy7o/O6mkBAbjThVH4nOB74eMmZrfbmlca1Hv4ON
	0mExIE61NRdxd0dLpztv0UlB/I8j+KGd9CtVQpWIBvcQxnOCen28FBfhHkXSoHkif5rZdrzgoo1
	69yFARFr17rwetbcFtfd6nDoz6+Gru1FKfT5heeyXt0431n/Fml+rv8HZJLTQnQ7OmOySg1xAx5
	zOOksP9u2cmtC+4y7joEb4/vgKGfjKPR3J9x0ntlCDH7G5jBL3dQlvoX+38QVNTTS/rPBpDz2Ou
	wcz8XNkdGFMGwVTUuXZEK/
X-Google-Smtp-Source: AGHT+IGPfzE0xKnoRrTLWYWeXzJuK1HWfT56pdpm1DttOO+jl3oRV5rhmilRrGeiE9NZtGpToaDZ9Q==
X-Received: by 2002:a05:622a:4017:b0:4cc:1ef6:9c07 with SMTP id d75a77b69052e-4e576b12bacmr1052321cf.60.1759425852312;
        Thu, 02 Oct 2025 10:24:12 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:24:11 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 13/16] staging: rtl8723bs: fix line ending with '('
Date: Thu,  2 Oct 2025 17:23:01 +0000
Message-Id: <20251002172304.1083601-14-vivek.balachandhar@gmail.com>
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

Adjust formatting to avoid a line ending with an opening parenthesis,
in compliance with kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ac225bb9dc80..c4d203c824f0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1113,8 +1113,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter,
 	 * ptarget_wlan->network.phy_info.signal_strength instead (has scaled)
 	 */
 	padapter->recvpriv.rssi =
-	translate_percentage_to_dbm(
-		ptarget_wlan->network.phy_info.signal_strength);
+	translate_percentage_to_dbm(ptarget_wlan->network.phy_info.signal_strength);
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-- 
2.39.5


