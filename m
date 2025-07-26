Return-Path: <linux-kernel+bounces-746610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C4B128F1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E4A1C8138C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AD4202F70;
	Sat, 26 Jul 2025 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8JrFBiX"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FFC1F8755
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504415; cv=none; b=RTYJIBhl/+Nm/NsemcTtYy8Tub/IV37rmJK7BIye+sMILSK8qYgof4voR0gxs7UZbUreUu+JjkE4mRg4EaED6QvM1SYNzIOhihoTVPRfw/fWhREPwOmjhE6MUWO60FXfPcCBESz7C867Uf3iGIms4JSF0axBjvhP5mEjilQ9H6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504415; c=relaxed/simple;
	bh=Hln+RE0XFXcl6Q+ZxGFN8IgMNryMqgMXLI5PboDwAkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7fx3y1572gOLhNqd3OY8KtDCk4bLtmxMOkFruCv2herEtsW9ZOOWZW6pjz8kpqM31x56Ibqd4njFc5dvGZ7iIdTcoUapwqrNx5JqqBc70d1yhBtPxWb/aDQFI7YGnAfAdUXJOkegi1tQyHVMK9vwLDPalcFhNKBWK48ClXDo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8JrFBiX; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e6399d0654so88212085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504413; x=1754109213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjkPbkLKXrC1x69MnZUinhNSbgEsQTgvN0JCPdlTAvQ=;
        b=m8JrFBiXa3604iUUknyGOG1+DpkDV4Bzci4WM+mHaCLXPq5uCPbdyqrytjFbCzKdB0
         HflmkN1Qo8560GeUQRTKdjpRT2VHmJ01BrBVg8MahQDI3tA7dCOio2jtTDBZP+QPg25O
         xC+HV0ws96v6Dk8VW6Y5+LZZYhGH2p+C7V4gNKKP7jA/PtkExR01SoH4bhEu9xWm1ByI
         JsYRhsWJi5Ukv+T70Oy+fuLwglhjBRdcmTIU8msHkcdGTK7SfmfyItDf70br0sijtF/y
         Np/eATaqVDKINcbcH3HjKRCia2oZwdLx0ffT4X/BXomzAveFESz7QpJ+Ftd8jI92om+u
         lG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504413; x=1754109213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjkPbkLKXrC1x69MnZUinhNSbgEsQTgvN0JCPdlTAvQ=;
        b=CNCt8uiUYZ/4VU7oKHBpms5raOaZToxMN6uZCW6FiSQ4pL1VBW4QD5+GbeTr0STeJY
         oCRRQBAqgrRA7WRLT8oA++XalNFZxOwhto3gbnDJ+S7jfOmhMb5j6zXjZfC5oYdZBfBp
         yQovirdYTWyQLagZ/5UKqRqKe+H7mdinSNMxS5pKvXlbGkz4EDnO5JRcgZZe4IclRUmW
         pBx5Eu0K68M6N7vSM6Yhsd9mwu9ZjXRVB/BSVByfvUwC3mNcX1ydhgvcaudnALhHDR2J
         yPAnH7BbTuYQYowJu8mxEO0FLe9Lm2PuYLvtmwEBmqbvkStrLGt11/YaT2fcIMw5XpJh
         kbzw==
X-Forwarded-Encrypted: i=1; AJvYcCWHfPfPhI4d2Y0FBFpxLUFKruOjWY4NmHBcNy1EcBopM+2SjNQiYloQH+o7uZGGKI2b1qBdZuLZDkxdjps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLzNa6e8oEO6SPD39bt8kWQ/3ZrU34+w+RPMvR/9AEgGjSSM2
	4wkYyao8JzM+6B8RVrFQeB6p4sBVUR6d5KBMN5Ji96EdeDh+KSmJWRa4
X-Gm-Gg: ASbGncuh7xU4GnApzkgL2/mEeg9tRIWyKtz5x3rtPJKNNsuIGsD/vK3ZW9zCekiW5zS
	rQI5pp7gRFlDJt1RU2Eieb9VKpyNcsr9mUIBRsPg2vWepPLZvpZjD/426BibNSVWHn/qzpcohcc
	EFW8/x0zxhrwmWBh1b/2Cvhfj+9lg7LN153Ss8srkRbV83/J6F1tpkeEf7NZgKdUc4OA+j8rEQ4
	BLC7tmnF6peCLKVdWM+lKjBBtZrMrFWEYgcsPYCYxexCGa3j5POT0iW9V7kjPa6RnYkslEmFZwq
	jCy3WW97W1vxKRHjfBCTugO87D7Nx/ZSnCrvp9DIJoBbVXHcZw9gA6eV/XiX1cEUK5TON/i1sXz
	XAyrWSJCQa47JPvW8/3pYdlL+azcjuAB7vKu9p4dJ0Tt6m6pdBnU=
X-Google-Smtp-Source: AGHT+IHADvqH6vA5wfk2ynhAPEHhDZbOKKGLISpDsIW3emLm5YPAfEmoxlfJG0uV7s1fKXA03oR/sg==
X-Received: by 2002:a05:620a:4046:b0:7d7:79ff:a1e5 with SMTP id af79cd13be357-7e63bfb09c4mr486653285a.29.1753504413258;
        Fri, 25 Jul 2025 21:33:33 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:32 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 04/20] staging: rtl8723bs: remove unnecessary space after type cast
Date: Sat, 26 Jul 2025 04:32:02 +0000
Message-Id: <20250726043218.386738-5-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed unnecessary space between the cast and the variable
in two instances of type casting. This change improves code
consistency and aligns with Linux kernel coding style
guidelines.

No functional changes made.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b1a427a655ef..536b6d036e88 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1055,7 +1055,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
 									(cur_network->network.ie_length));
 
-	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.ds_config);
+	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8)cur_network->network.configuration.ds_config);
 }
 
 /* Notes: the function could be > passive_level (the same context as Rx tasklet) */
@@ -2406,7 +2406,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 		if (issued == 0) {
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
-			rtw_addbareq_cmd(padapter, (u8) priority, pattrib->ra);
+			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
 	}
 }
-- 
2.39.5


