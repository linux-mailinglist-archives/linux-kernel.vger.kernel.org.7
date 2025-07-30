Return-Path: <linux-kernel+bounces-750169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E96B15815
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402E318A293B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9351D7E54;
	Wed, 30 Jul 2025 04:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkWlfhNn"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF618B0F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753849253; cv=none; b=j+js4h1dMAx8bNdgqCtrc7h+x0j9I7XSc0BXEZuInyIiIWtdws0t/oJ8ZLgbA8QXnJwYq/EFPJgWJ+xyZYkA3Dr7BAxkZS2I+V05lxVG1r1wmPxLOMrcEngjQkuc6Y5cML/L/AK3/ZH/et5dqlYGj688gzNVCmCDKHSOm7QPadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753849253; c=relaxed/simple;
	bh=VtlbEUvC+1Ke27heP7oXzNDycF7JeErvTwnIj32oDFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBz3Sr1kWrj0LtllhzYXQoAZmGQ7GwXAcrFXCXyJDDBqkiryIXmHsL5QwaoeXBJFcHm+3v2ZILermc185HRa0VzoSSDU0e19Zozh2j0TQkfSpDEnJDDxQFguwxPtlNVGC1vIDqVebK+bgKuywWdqjVRGgE8IbyhGU1wlSj264v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkWlfhNn; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4aedd1b006bso5204811cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753849251; x=1754454051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBDrP8+XAiCQt11h5ERJV6IvzsZGdQ/fB3B4Nudc+Fg=;
        b=QkWlfhNnZfRipIPksf5BoGk4IQvpkx+JOuWPmNezlF/ae0RE/6ahnh9FeACM5eJ8N0
         fTIjETyOwNpVCBVhSHI9YaE7vhn89+j1KEVlPdORjhO6fZ/OnggYxRY1Vicm9kycyEnY
         49qKvc89YH9D55TpyAVE6k7Nn4VAXfEkmGq3G5MTvkpeRVRarinuR+OK1Y1kpPDql4Kg
         Qz2Fur03wcY8jZTGQ8KlXwHUcmoB195WPeEsQCo1ZnMS2+thIXs5uvzP4YTaPS0VD83+
         9E8wEC1mCBnyHopPGtEoSl1TrCERjXjLUyAMENnpso7dmWlM8LvbM5FJmMyE5Q+8fy17
         aZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753849251; x=1754454051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBDrP8+XAiCQt11h5ERJV6IvzsZGdQ/fB3B4Nudc+Fg=;
        b=YNHWsYUeUx5p2lVT2PXTUmXib02SrV0vk2vDmk7lrTCAps6RM5GJComYwT71s8cz91
         Qt7xHAg0yI7kq4Hh1aNUo3oG/G0RLfyvs5QMRLnPebvlVJp1ut4p4YhaGwylUMBKrZws
         Jixh7QXsHhZS4jLCSg9Kvs3jYlYnUL6wyTZsTLmbQezLgIvZ75Cz01M72yP4iRF2GFmu
         fgO241hp4AErhlvZ+mNOzu8IBw6/IrsTYfSiOHoUD2/0qxPMKKnaepriDSfPGU2oEdj6
         7kAgAlE497vmLBEEGOZSboK/d7/XUtRbn7tLAREWKyl8Ri8XX6N9z3wZCEHO0CKC/rKd
         oZVw==
X-Forwarded-Encrypted: i=1; AJvYcCX9YLMWmmhVm/lhaNgIoz/cXIWv4iOSHJ/L3E5c4D9iR3LkpLFW7LJ4n6w2X+2qJSAmZR0t6Pty621L4U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vPt7ZuQVotR8uOooUzbosPaDzMjv+lcGotdMLLcHy91AQowQ
	g7qauTOLtqX9LxxrsYJwqdpcIi9oejmh/CA/DBPp3GVDVws+SE4CTeQMiMEeDDvy
X-Gm-Gg: ASbGnctxJIj95gsRscORhfafr0/9Rt9ZP/bxpzd+SlrC+DDUjbO8dXqviBNCDrJBtXW
	99WT/NCcuda2pI8jpvZXwM1Vz5V8AQ0YEQF/cL5JEpHIbW0edd+lMi5BtG1JYbVfgCa+51J2Zqh
	lx3SzFSM7qywIXChsRFqCxez/fu8XgykNP+BfEun4BFUwHgOVJ/g+HddMxB1i4yqqTI9Cw5usn3
	rh3t9gEv883YNu1FuQ7S2xN6Yak/Pw/xKX+xOXarVIY2X/dxXF0sdr1XVGdd+jO0fd3xwwOfgWG
	30KLqAc6pMmDbl+M7tSbsdOrb8439j5/s84R01iKwnwDcnOvUC8wNF9RHoS1ACZ4XGjxJidAwVj
	MdnDrCKGMlVDy2cVu6Y2jvluSdY26Nl1tdZPQTRXNY2Qo/KmkJG0LykFA7eCCBw==
X-Google-Smtp-Source: AGHT+IHz+lZhDxmH6jA3pyAfmQkH6IxnMd6r6bPodgf2EeznfTLaqQFGNquzoDmjbIcO0X4/Bu60tA==
X-Received: by 2002:ac8:7f8d:0:b0:4ab:667e:2db5 with SMTP id d75a77b69052e-4aedb9e2501mr28267311cf.20.1753849251261;
        Tue, 29 Jul 2025 21:20:51 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeadea8b61sm46472761cf.24.2025.07.29.21.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 21:20:50 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
Date: Wed, 30 Jul 2025 04:20:32 +0000
Message-Id: <20250730042032.488456-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730040402.488284-1-vivek.balachandhar@gmail.com>
References: <20250730040402.488284-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line after the definition of rtw_roaming() to separate it from
the following function (_rtw_roaming()), improving readability and matching
kernel coding style guidelines.

No functional changes.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
Changes since v2:
- Moved version change notes below the '---' line

v2:
- Moved the '---' marker line below the Signed-off-by tag as per kernel
  patch formatting rules

v1:
- Addressed review comments from Markus Elfring on changing the description
  of the patch regarding readability and separation between function definitions
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 24e505111f1f..b1a427a655ef 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2449,6 +2449,7 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	_rtw_roaming(padapter, tgt_network);
 	spin_unlock_bh(&pmlmepriv->lock);
 }
+
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.39.5


