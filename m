Return-Path: <linux-kernel+bounces-754902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3978FB19E39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B35188F234
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F92472A4;
	Mon,  4 Aug 2025 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jJyl4LcO"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E723246799
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298270; cv=none; b=mHIvIHJLKz+QcbYzogtdISa30oRxtRaAyvYGOVgZq4w9gkbJgGlZuLv2UG4qWOjM8lSKeJN8aeZjFVGYFZJNZPS8Istd16UUpEbSOtQ1f8N7/nruwa7hqeURseMnIyPiMwZLoYIdDV0eyFdfRrFjqJ6ZpgH5UXKLPxMJVvz/OEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298270; c=relaxed/simple;
	bh=6Bhn8TVLiVPA/DDpJF49VzDOxmDs4HWaQoUsOlq8plg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK3/Efk98yV20vH1S1UoWI2OkflEY6kOvxIL/E//rf4vYTk45tT3Epr40tZu8nG1WjEWt5ztT4QBhdHzB4Oa1Ju/2ZlN0PdC/6vbsQPjj/SCCnM5BaaEgwWdNx5TzRx6fqjrDtTnX40BrjnMD/hGYOH3KkcNgR4iVoa2APsLqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jJyl4LcO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so4565992a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298266; x=1754903066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3zkd9Jg/1IWWLetRvam/cO4b58x4mGvV5kNliFnOgc=;
        b=jJyl4LcOJBO5otJknHkRY/bMMfr5oiaGH7EBn8iOgq2AWsTwlWvVe800vlvTmO2fw0
         cf3+XBkXt3DJNV5KlgJupLvMIn6fQrz8f1VEuVCTtsOfD6HMDv5Z+V9kghIMi6kub8yy
         ozLsiXXSAOB2SDDo/oOs8EZaZQqQ8bSF5bc60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298266; x=1754903066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3zkd9Jg/1IWWLetRvam/cO4b58x4mGvV5kNliFnOgc=;
        b=uMwOtis3iJVF/9IZ9T+bd9yZ+3GzNLp4IcRa/0RSXcA7fHgFQ4vpZSqF01XDIswnRV
         9G4GpCwiLjmP4U196i7pAoppwLorVBiACFj+txAL77ar5ieZJbUFV0ToVQq0Y32hr9g3
         YStUxVeh81ksMzknBSsoS3JJRCPr4cBuvShZZYU6HzrvKemdxdbFsl3M/YjTl7S4yHG9
         LT9Eh5RKiyL9iNHQwkhYBtIZSJSPAHrW6NnBMV2uVp/DLVDVBx9SyznEMp+bkAlasNW3
         COdCRwtD8EVUoRPdDMiK+Xz7auikXBDvYGjeCey8p9l5xTAeV8B0OzrVX/fmG/rNnBEV
         eAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHr6mZKX9lm8SreLd6EIsyiPk5BGvHYet9WccXOww8xe/HEyuuvUVQw8n9tS4I5zDyDTbuGw5Hhwb6i44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvworu2sEwCvqTzGfveTL3BP4MnHTQ4EctFQb1X1DuuOk7fbUc
	Z6Nb7UqnHtTW1J6jyZC1rAuCsxyZTgt132+fOM4ZvS6LUH4F4ecmMaIfZX1GQCkqrw==
X-Gm-Gg: ASbGncsNGDaROMPcVP1zI5z8+gx0cwOfirONkEhht5ihNS/rMRhqmMOlnhlN4ZzX6Xo
	jbAsXEbM2tLeSAIgR+7mSC1IA/0IYPir702RyfxPpMZmw6Omo5NROm45M9KJK23JLWhQTck1COH
	GxkAnH8xsDf4euIBqLwJeuTgWh5MWgTC5FdnrsdjUvrCawmpmXx8sX5SJySeh98Ep+L5ebDgw12
	IdMtgKJOOGxzw+pWpxa/9GI3Ea6AUQ7QLldcDbYrhdL33yg9UtZnPUJ93LwfDaH6B1aYzB/oi9V
	FJxB/FmIKOUhqnFcr39k+1Q/Mq2+F+aR+/eQhZOP9G4eDbRQ+KmUMmRJSTCQuwrWUKpydc2HTSP
	a8r0/C7nYGcZGX8KafDsXzI5K/K7ryg0Crmg85Hzjvh+xwkRYFSz7upLDsRyZDQx9XSB4Ru/18I
	nT4iu6j7b4Glt7+FQ=
X-Google-Smtp-Source: AGHT+IGW/LCLdhCJc2+ufotVYylvigS+HVY0E50Z6NorO+AWbE3p7ae6GP/d5eD1odizSiqENv3SHw==
X-Received: by 2002:a05:6402:40c5:b0:615:a60a:38a7 with SMTP id 4fb4d7f45d1cf-615e6eb549dmr7470597a12.7.1754298265812;
        Mon, 04 Aug 2025 02:04:25 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:04:25 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v3 03/10] usb: typec: ucsi: Set alt_mode_override flag
Date: Mon,  4 Aug 2025 09:03:32 +0000
Message-ID: <20250804090340.3062182-4-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804090340.3062182-1-akuchynski@chromium.org>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag indicates that the PPM allows the OPM to change the currently
negotiated alternate mode using the SET_NEW_CAM command.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 5739ea2abdd1..5ba8b1bc874b 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1616,6 +1616,8 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 
 	cap->driver_data = con;
 	cap->ops = &ucsi_ops;
+	cap->alt_mode_override =
+		!!(con->ucsi->cap.features & UCSI_CAP_ALT_MODE_OVERRIDE);
 
 	if (ucsi->ops->update_connector)
 		ucsi->ops->update_connector(con);
-- 
2.50.1.565.gc32cd1483b-goog


