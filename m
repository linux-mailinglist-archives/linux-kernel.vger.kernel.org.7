Return-Path: <linux-kernel+bounces-791215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF0BB3B389
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D17C1C841BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32982255F28;
	Fri, 29 Aug 2025 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzen6oyr"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E2254841
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449374; cv=none; b=Zc1RrCSliqZPIIQbxvqKpDMXPP8D4H2sFFlk2G2BCkHek21cWMY2CrCH6D+Dq/hYHVz0JVekQjSMbYmfp8GXfUWdvRdq+9nx7LHbSuKR9MV/qOzARbjP/kqZ/1feCY7Vrvgyq5sqWs2Y6tPWtHdkVEDzaaeQmQvdMVMG3wBUsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449374; c=relaxed/simple;
	bh=t3dpemVlNNOlBETUXx11eR03CoTBAt3SVlI347Nx03c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6i5LS9liSUHfTocT+SaROPj9hd8RgSyDD7hjkVYyVMGoEDLUIsvDlp5O4dHYensdtq4dNSC0C3NJiPbaoMi5Pq1gz1mBms9v1tsFCVF5Z2Y75t7HBeb+3JuITkMzhSIl1pgQo8hEJfAjbZv1+ddktEfposxe/9C8Sskb2Vjrdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzen6oyr; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e96eb35e36cso281481276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756449372; x=1757054172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIYcdGfd/N0Y7hEFXW14y1n0UaZQpTNZtxJVAnkglXc=;
        b=bzen6oyrySPwef9momz6HmsjLsUph7E0aNeIZ4fDQjrImfWYnu9VbHRV5nLNhgh1fe
         m00mTVd8HIxgq846ifbJw4fgyMdD1XggARXDw/jC7GmG3EmouCwVxO7onMo20aXxQSOW
         hthRNiMGlefplPvaK1XcYssQApYkG+EbHuLw0PpJ8EWI0kRwVqQaVs1MI49V5YIT9RVD
         8mep12XZzjCrQ5YRYJ2fSfgHjTl/5xIU2oMgajk/oe8QqbKhmIpOuTb8ScZrU2J4merY
         gkijxITx2bWku6qi0eAEeRsDNX2rY+azqrzlGVgLWZyN/w41trYDj+S0Yyw+RMowZNrr
         ztjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756449372; x=1757054172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIYcdGfd/N0Y7hEFXW14y1n0UaZQpTNZtxJVAnkglXc=;
        b=vFZINiX/sUMQR48oSLexxjks9Nx+iGExMVnoeRHemO148UQ4tF8SnIye7KXl7yqOr+
         rDGtrxR2rhKW+aMcOa5siUU1nrdnLaCso/BQQxCIrH+UWSaruI2n1LNo2ByN3iD8T2eo
         NFKlz25n8J3H3/sFu1gyYtKRuU3nlnJYvd8a/JpO7zoZpvgRgVuZlaZbmzAzNF4C5QT1
         6rNyPfzLPFDblM5tZJ3GFHazFXXiEqUNmeLifSTN8nTNIQbeu3Rvq0YqsKVJA1HI37Ss
         UTMtsgDUTrjSvKD7txR22U3BbvGC1Ve6dFAx/vrbNrrwIZ4f/PQAlzYSm+EOXj82U9NW
         JW5w==
X-Forwarded-Encrypted: i=1; AJvYcCWbN05dAPQlD277EW40lmX8Fc6C5hLDMzZxDlf2RzmlQt//BoOV8gx76Zsw8ChufUxo8cRXPyOZGssUBUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcEv9iNatU5HFOw2hPkRqSP4MRgYfMcU7csvsYGkPZ/hyE9KD
	dKM//c3B1E3h2rkjqjlcxgYLIG709N7CdkTzU/Lcd3LMp+NipogbSfWs
X-Gm-Gg: ASbGnctXz9ACqhO9Q3nU8o2PULB/JhAHgJqfQ+/nRc2HzV4fThHbiSOgV/pl4Fq46lU
	Dzdq3k8A6NQmHZPbamQteKxiCTbuNqxnsd5+6N47XOvjQA/8LQOkBlXrqpw5ICha4Cx+b2Gx1zS
	pUndMTQUOvWHojFo7TgC9Q0VIkhWYLlbI5CA/xoduLhNM0htR2KiD8w8fupkJt9lPwCDgqq7/1C
	RF1e3Qzx3WOtYLOYKY9ZjhfycQ9aRpoEgbnvgzGxhqWgvzKtUXJNOhDPAAtCZmmuOh/Wh4Ee0ED
	koL3Rg84+nsy9qPeKm9RBbBHWadFO5qLQlTXE+aQEbp6oT7whzwdl2NAWvZF2UHTgspYdSOiUB/
	SL5dQMuYPq/Gj5b8DshoHMV3Oa7iDu2KmGjCLYnlhkc8XmbyjqrhUM3Y+hGusid0XF0K70wIL9H
	uWB122q20fU3ScrFPdjKoo/mGUY+mqzaLVv3o1TugmyAnEaQ==
X-Google-Smtp-Source: AGHT+IH+lR+hABKYAFxx7DdPXWQevTkb0HrCtdsfZ37CvrqzSheWlkul+8CbBDZRN9eqKZ7fKHsSGQ==
X-Received: by 2002:a05:690c:d8d:b0:721:22ca:695d with SMTP id 00721157ae682-7226a181ca2mr1421607b3.0.1756449372100;
        Thu, 28 Aug 2025 23:36:12 -0700 (PDT)
Received: from mamin506-9800x3d.attlocal.net (162-197-212-189.lightspeed.sntcca.sbcglobal.net. [162.197.212.189])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-721c634e68fsm5093557b3.23.2025.08.28.23.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 23:36:11 -0700 (PDT)
From: Min Ma <mamin506@gmail.com>
To: lizhi.hou@amd.com
Cc: dri-devel@lists.freedesktop.org,
	jacek.lawrynowicz@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mamin506@gmail.com,
	ogabbay@kernel.org,
	quic_jhugo@quicinc.com
Subject: [PATCH v2] MAINTAINERS: Update Min Ma's email for AMD XDNA driver
Date: Thu, 28 Aug 2025 23:36:07 -0700
Message-ID: <20250829063607.789-1-mamin506@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <09906ca7-62c7-2ca7-5436-662a6c4b19f5@amd.com>
References: <09906ca7-62c7-2ca7-5436-662a6c4b19f5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I recently left AMD and would like to continue participating in
the review and maintenance of the XDNA driver using my personal email address.
This commit updates my contact information accordingly.

Signed-off-by: Min Ma <mamin506@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..6eefa494000c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,7 +1231,7 @@ F:	drivers/spi/spi-amd.c
 F:	drivers/spi/spi-amd.h
 
 AMD XDNA DRIVER
-M:	Min Ma <min.ma@amd.com>
+M:	Min Ma <mamin506@gmail.com>
 M:	Lizhi Hou <lizhi.hou@amd.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
-- 
2.43.0


