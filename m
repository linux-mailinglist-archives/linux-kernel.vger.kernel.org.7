Return-Path: <linux-kernel+bounces-764270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3AB220BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E35A6850F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC422E2644;
	Tue, 12 Aug 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kbjyk/hV"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669532E11A6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987001; cv=none; b=ex4tblCIurE4KPjLx0BB5h3AbJfvwUcfSjO5lzvPnsHwMpFFfV6YfmN0iFa3MVwoTkXmRoh6k3tqIQCbOR0VzXwUPK3Y5tbq6VyaEVKY5siqAcklknPc3BmyvIelEAOJI17Yg0ZxHzHd8Ogy399CriPpGhtZdJITZhHJ/mS4gZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987001; c=relaxed/simple;
	bh=NhIIzPZuSYyuNXHD3Snw6g87jtEZmMDgQ74IqsTI05I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sN2uO45aYDNAeJRLVuMvFiO/uixQ1YJ9PA7VsPGn90ydtPb5B345Hs2ESgQjbWQmtyYIn1PXB7vA8N3az20io65bfPXD5KomMWzbl83Qh5oIJYFYdYm/im1uhhEuavXMG3NurrpDNh5KBoXXnY6Nx1AIeBMoz/JBb21j0bVOOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kbjyk/hV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76b77a97a04so4677781b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754987000; x=1755591800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3fGk8RPNzlwTE0goRde9z6mNNC5qXPF4Mfc5wZS3Lc=;
        b=Kbjyk/hVA11Hsg2PgkZ1LAp0rRRr+qzwnjHd9InoqQHPO7+LuLTeIZZIER5jSjcAAn
         glNaTX0Hc1/eqK6feyZoGVvPUIcns/X6yakQDtNTw4psb2OD2BDUw+9FM643EzTask/c
         8WoUJW3rQbZtsh8T2RHsUelRvwYJ5WUqT60SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987000; x=1755591800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3fGk8RPNzlwTE0goRde9z6mNNC5qXPF4Mfc5wZS3Lc=;
        b=epAjA4KjlH7ptq7DT+/lhE3mzjj5J5HxtXYxUGgR0PZ31pF06GD97eDwRj5ASjElv/
         mzloyBZIffd+Tdh0sOXIHwXOPTkhNjBvgrLEafTgCqbRTc1HFhIXWpTVn6BOwHPVYszy
         C+Dqkhzyl1Jk3sLg9kt7P6DNZv/XyV4xr5gyD6fCtCZsMiZAONC/zZlyT9hJj9fCGe+y
         372oz1kCvi3wXOcP7fgHOxM9LHWoVnjXUUODiniQBB9mPbZqy+6qNGaw8DdwiCKX2Y0Z
         C/VC2I9QhDWdM7xKjUAQOBWnFWWXI8iewpzPWWE3pFqW2skxTslBZlrxvrQpZJjGBZDJ
         P1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXnbCPb0e1stDFVHHU95zSAUCraYeMp4Uxry7q6vI7afIM70RTOzrwRVEeNtB5ZKxmzafUlwVkBGQ2xdg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGapjXtZI7KPwhPLqXI+vLFm20EsgGWDbMugDaxJCZBYrWpXi
	oj3Uvwfnfhy5DjccdY6Li7IHfp8/kYLvHEfMNdeJjhyhKaCc2GIODj61j2HSzj0oMg==
X-Gm-Gg: ASbGncv99k5N2c6EebDKRohHHH4fPz1qT7AGR2LhkVqJgzIFdLEwspTgjvVuP7y5w8X
	2V/efEMzc86pece42EWLaAXhKrbazZ4QjYJwY2eIghaSXCWOZz60e9u5COcVCCvpASrVtpRjDkX
	7z5MRl8n7Og+1WSEU0Sv5uGpr0zBlaIn8fNYmfximBrRTS8eyUy8JQa4y/jbKjfJkPSNqIxRcFX
	8tIV82vGwCmZq55zzof+0YvnF4QLJRLkL0O7coRu/H93xiLNalOhshhqgHLUiq2km0MeAbPP4u8
	K5bfGUN3g95YJH1OWyHGsw04oB8cAb7Bqxj8b395aV5UuvOsl+4tOTJxVet2Z14TPxUqH3yqG5R
	fhF35jYyfgKsn9owYLHFI5h1Md+ArQ7yAx5go/C1u
X-Google-Smtp-Source: AGHT+IFIaVxtQml0iOhHXxPcsA5eLK+goYa9RCC9q5Wljt2PSVohymFqS5Fc861BFUfuo2dZnQ70DQ==
X-Received: by 2002:a05:6a00:1491:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-76c460d2c66mr20874497b3a.4.1754986999650;
        Tue, 12 Aug 2025 01:23:19 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:8e8:f5ef:865c:a4fa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf77210aesm22722064b3a.113.2025.08.12.01.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:23:19 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Hubert Mazur <hmazur@google.com>,
	Sean Paul <seanpaul@chromium.org>,
	Fei Shao <fshao@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Xin Ji <xji@analogixsemi.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] drm/bridge: anx7625: register content protect property
Date: Tue, 12 Aug 2025 16:17:59 +0800
Message-ID: <20250812082135.3351172-3-fshao@chromium.org>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
In-Reply-To: <20250812082135.3351172-1-fshao@chromium.org>
References: <20250812082135.3351172-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hsin-Yi Wang <hsinyi@chromium.org>

Set the `support_hdcp` bit to enable the connector to register content
protection during initialization.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v8:
- rebase on top of next-20250731

 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index c0ad8f59e483..609cdb9d371e 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2604,6 +2604,7 @@ static int anx7625_link_bridge(struct drm_dp_aux *aux)
 	platform->bridge.type = platform->pdata.panel_bridge ?
 				    DRM_MODE_CONNECTOR_eDP :
 				    DRM_MODE_CONNECTOR_DisplayPort;
+	platform->bridge.support_hdcp = true;
 
 	drm_bridge_add(&platform->bridge);
 
-- 
2.51.0.rc0.205.g4a044479a3-goog


