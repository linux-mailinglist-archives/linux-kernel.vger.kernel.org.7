Return-Path: <linux-kernel+bounces-840558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED182BB4AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C5916BFFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F48281376;
	Thu,  2 Oct 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf+XREt5"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625027CCE7
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425853; cv=none; b=HBY+Te2BLpDdpFVnLfdU1aZ/BMzFGIgy1gR8Iikq+6I07UiVq253Pc0pR8yQx7QpMMY93NolKbAz3gAWlddnquTiaDtlX0inH/IlvivKRnyqGWlrQcFpOAV6ha4xA1XL5exMkhSD7PnPOb6DGa9rJHaCPouUhf5TPtQFNVTdIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425853; c=relaxed/simple;
	bh=y15Rz9Jdn5VuI15nWuQPMNU8ucvaYPNJOXj7ij+eGLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKO9VN3IlL0jEllnMoxeQ1/sy3lcvHq3u47TXsvXMW84Cd19H34e87v7AhJIfnLDdKXs04kuty23wPI+NIt8nlClD8NcKn4gx3dj0gOjzNqjumj9KKVSdLiCjPbNRI4ZLLfwUGNf+kdXWJF7mXwfVXuELQ2qpyQVO7hMmuJ91uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf+XREt5; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4df2911ac5aso8048721cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425851; x=1760030651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrGwyIda8Yaf1BU4JPb6IyVXaieF7GyMf9bdMMzqacU=;
        b=gf+XREt5O+ijqmMtBy3RZoDNfl2yASty74GdDrf8unQLkMIfyFx9Ar92t8VohMjVc9
         +qWESGT7A5toQZ28H+YdvoA6jgr0NCpSRh8G4qD0I1h8cPPLBb2LW/TCrXhLdxXyTzN9
         2PaVS8pCC+r7aMr6/qMS0b1s4M41Z4e0EhGMVvtk6LvUaOV0QdY10/I+m/PIgZ7TDu3t
         Tsyoi2IyOHG6+pki2FJEgbUtxnwdCSLwCAS64B+O9/BJsqYJB784dv1uFOtJxXkdlGV3
         1OfolZLU1KtzC4BniQFe6LgbQXlgeTfQ/AvjNMdtTAjiB5eF5WziAIseJ4HVpP4RYESa
         oQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425851; x=1760030651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrGwyIda8Yaf1BU4JPb6IyVXaieF7GyMf9bdMMzqacU=;
        b=UHoLmJ786BqnXUcpn829YUuK5yYu+AwEZvsJL+YWGIEHnOkS5/P59jRyfMalCCzsFa
         TCOyp5Wxgc6OQD52o/WfuRnm7y7YWw3PJrOcbmNF8XdyGxKVX9QgZ+o8zohLCxH2leNn
         J6481B/01nGvqG7mUyerLbRhk08KstcVWACcjWtRAKhswATRbSk6FjRrReGNigwLnhq/
         WefJ3AIMcbOF4Dib5Umv1MzmK21gGB7yT3hACvsh+qxwOPKC3XdLlw/b7D7SGoz76KTB
         Uxsz6OsrCEm4iKp1P0zQNYKCNSzR0mZLVnPqiIVosBJHIqpOUClPwxru627ynjJml9j5
         XJcg==
X-Forwarded-Encrypted: i=1; AJvYcCVxDm9ZdCGWDw9lnP9PSABIC5VGVNzSBj+rFatwBPs2HhSjLsK5rkW89vlf6m+aEyAdFII0iosWwh+9LKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydgwAyFuowrIfNPCqQWCYkhl9xvIDE5XUyyR0tVqu9SWr2QET5
	Ks/oqjaTnIq/nQb/Nyp8npjTcIEztOZq9nvpNlTmxF/EAnQVZ29p3ycRoAokRA==
X-Gm-Gg: ASbGncufs8esCmp2UYqOV/jerVfAaKDfC8HANNxiYPYm1f/Gpxn+sM5M7Mb8sK/tNAo
	GXd3jEzB2TEwckmbRVjoOyomnjU9PJlr7RbSqwPkODWFKaROXNOBBjVKwwPiW4JKoWmOBZX3Tob
	SONwC2K2uk/7+OhhwnGTbNffInTZpaSJ+r9MezNJtAcrxSgcfGqoHQGp7lcxwcMVoCLsjE+E0rj
	bcjify+5wDPUbwaDm5DXdxCi77biNrb+f+nvfdPyQrdAdTwJlvAVGfLRUPgb5SyMyG+MCt7umdr
	GyeYkjz4GDcFewRLPoLz8DZP8mECVZYAngJ3yMXLUF8xYeGBwhbzapByGz6G8WEKLr1OuuepUfY
	yHBf7w9hHRoOhJygaAxp92r91k3IRDmDoJo0Ldx8CF0vv0gFMUXoJo4GOdsjX9xREfcJDOmS4dN
	k=
X-Google-Smtp-Source: AGHT+IH1aTnmfvsiPbVHrnXi0F1Kl2CkjT6ZVGtsmT9NpSMfEE1Uey6PNJoaYFNjakybQ78Eeln/LQ==
X-Received: by 2002:a05:622a:1249:b0:4da:16c:6ce9 with SMTP id d75a77b69052e-4e576a446bcmr1430651cf.5.1759425850512;
        Thu, 02 Oct 2025 10:24:10 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:24:10 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 12/16] staging: rtl8723bs: add braces to all arms of conditional statement
Date: Thu,  2 Oct 2025 17:23:00 +0000
Message-Id: <20251002172304.1083601-13-vivek.balachandhar@gmail.com>
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

Add braces consistently to all branches of conditional statements to
prevent potential future errors when modifying or extending logic.
This aligns with kernel coding style recommendations for clarity and
maintainability.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 74dfbc7a0c26..ac225bb9dc80 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1668,11 +1668,11 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	if (pmlmeinfo->VHT_enable) /* disable auto scan when connect to 11AC AP */
+	if (pmlmeinfo->VHT_enable) { /* disable auto scan when connect to 11AC AP */
 		mlme->auto_scan_int_ms = 0;
-	else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true)
+	} else if (adapter->registrypriv.wifi_spec && is_client_associated_to_ap(adapter) == true) {
 		mlme->auto_scan_int_ms = 60 * 1000;
-	else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
+	} else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
 		if (check_fwstate(mlme, WIFI_STATION_STATE) && check_fwstate(mlme, _FW_LINKED))
 			mlme->auto_scan_int_ms = mlme->roam_scan_int_ms;
 	} else {
-- 
2.39.5


