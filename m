Return-Path: <linux-kernel+bounces-803077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC1B45A42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602F1A484F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F847371E80;
	Fri,  5 Sep 2025 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UC9gy2e6"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA036CE11
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082142; cv=none; b=hKzs0MEAZXs8eQbvkphi/oEuK/IDcJj7RAwbUemiw52BB+kSOmX+YVwch111ikKi893ob5gNMo8VlcErAXRFBA+HCpazIlOrfarv0RiUOGr4hkXCUL1uPB4kFTfQyw32XDdDIEPLSaUXsaSSpS6ZYNlEnYnSk8Me9ssdm7XZphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082142; c=relaxed/simple;
	bh=RwkDpJ4JMiS1lt6rgk/ttWd7Imn2DX4N4/is1V6nzBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHTddo+VST92D/w0Oef8DzdkslfgGKw7WyOOXRBwD61aCVUpr250DzqYuTx49r1gwIHxnWigOnjKpSrqzOcZK3C+4DrhcWMnlC+M23EpyFRJXApWvllfR+pC5nkn0XbCvjikvkXWev/FE2ciGe/YWDCVVZLPvpa+M6kyff7E324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UC9gy2e6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b045d56e181so324102166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757082139; x=1757686939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87ag1FHHaswWtSbB90U8zWSxgzWenXvtVjHwVBb5b6g=;
        b=UC9gy2e68kBOj8z9txY31jbyA1LYZEcwZHPYxy+uuCTVpJlLr/h/xrihaYStH+1/AY
         OIyzvS6xwMwEpupl583SYYyMTDS1shtXE8z+Q26ZCUQ1YM46rRIFOPEFiiEWnNqQKwnF
         LwPtS+fB7oxhJv8PsQfiUySTTK7NkVCO2bbyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082139; x=1757686939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87ag1FHHaswWtSbB90U8zWSxgzWenXvtVjHwVBb5b6g=;
        b=nUi784Kycaw4z42Va8lLEKg89zHlozv4g9H29AmQO4M5JJGGmfuKDotIU8dmipgDZB
         nj/MSvok8icarcmsXph291HDAsSc7xWEq9KtuDd3JCZVtJIhl6+twz8AO59hsA84z8Ff
         6GTF0xz7cHDH7Vt0VJaM3XmaqxhPSBDpedUNA3xJwZsaKinJl9Qaew9CObC13/SBqgGC
         AsXUF0RpyCTd0+6yGHQG5rDiytpMtIlVwc89wp6HfUehmRefB0KEfMM7ai3x2y6Raklt
         WF4/YDHtHQRaJ3BgukYkztgqKDkJrZB8Rp5KvU3LYjpvdEjPBe8GfPnnP4eLs9RTFDCu
         GZfw==
X-Forwarded-Encrypted: i=1; AJvYcCVFV23dRP+8HM2KGAijKNthjat5lvIDeP2B2DUi6m4qw1EXrXJKuhlPPVz5IV46t04GdiRT3bm/WpLWnqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUv8okqDd4dU47QbFOpdtx4+d9f1/DQxNjTcDcz7um6gZnCbm
	KJ3Yig4E+hQvRvoB7CfClekdGjVmct4WfEN7KIx6DtkcSgBWJsoerZhtHRx1giaxsA==
X-Gm-Gg: ASbGnctzi3CJEk6OMt8AMF1MTM58sVse28nccU84nUj2YQt3+cC9cfCCrPY16/JNn6w
	f+N7xigmCuFTIs05wFoqvysjLIBjWXZ7P3nB9v88osuPEpDr6KfKNA9p4F6WUFSOyyU3fvs/3ay
	pHf93AV1CSbuHYy/nJEgxagFXK9YApUCGbe9vvXE/d5kyFMdjj8qu1hp5ZqtoMn+QFIEM6pJtmJ
	zND+2NyjhXwDxxEfIsgwA0ONz1yX6wMZD8LlV185JoCPA+4MP6ZgXoQHrW4WMn18NxmFwIC6bi6
	ZH0ypm9m/Ggnha3GwAUGEVx2eJ0tiwzSqH1GvuAd6S7/StSVM/5lmGYRgp1IpAkmxN++BWS+z66
	YTOlYw7+InyXVeavvr+/0AZYHMHziPihRjuVBquczZFeRoSXF2qo4aqQRmNSmISKOpVXumCGAL2
	9FRV96u6rXZ7+Fhrg=
X-Google-Smtp-Source: AGHT+IEtSMMMoUQkrS0etMzB3nxVu+EiElCLzWoEgWR+jsVPfiruWufQaw8VaX46EwAq7cMBxoT5ww==
X-Received: by 2002:a17:907:3d0b:b0:adb:428f:f748 with SMTP id a640c23a62f3a-b01d8a72fddmr2287245866b.21.1757082139041;
        Fri, 05 Sep 2025 07:22:19 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0476e0d61esm502141066b.53.2025.09.05.07.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:22:18 -0700 (PDT)
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
Subject: [PATCH v3 3/5] usb: typec: ucsi: Set no_mode_control flag
Date: Fri,  5 Sep 2025 14:22:04 +0000
Message-ID: <20250905142206.4105351-4-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
In-Reply-To: <20250905142206.4105351-1-akuchynski@chromium.org>
References: <20250905142206.4105351-1-akuchynski@chromium.org>
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
 drivers/usb/typec/ucsi/ucsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 0d6b0cf5a7cd..9f754344a841 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1632,6 +1632,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 
 	cap->driver_data = con;
 	cap->ops = &ucsi_ops;
+	cap->no_mode_control = !(con->ucsi->cap.features & UCSI_CAP_ALT_MODE_OVERRIDE);
 
 	if (ucsi->ops->update_connector)
 		ucsi->ops->update_connector(con);
-- 
2.51.0.355.g5224444f11-goog


