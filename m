Return-Path: <linux-kernel+bounces-840659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14089BB4E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9F19C72F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C9927F00E;
	Thu,  2 Oct 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO62vc4I"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038A27B33E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430537; cv=none; b=Ny3U+DSKjw2/XmJwj3yRl0A5VMLuoGznVp3/HaaOVUwsvEdSlXq536ez8+4gpxNHyC21mBs9Vqa1VK+lJJ4SIFiAhQpE5sqSvYoyM3G43Tyx+1KY41q0B6Y1htdvbbSfUalzTX1HU5YDSFlk9ZPqpqamR8aqc5teZ4zwWwhA2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430537; c=relaxed/simple;
	bh=wujo6oR6KRs+dKd5VCfSi/HrfuVzG23TWqKEr0OV7js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPAMjZ6yQvYgeZ5kPNzLiXjkqRpQu2At42k7Fg2P/FsFvAfuaGS06dNqBwJZGOPyDq82/ahg95REdMuTOhLsoK7cK40udI+fdRaY2XZma9sOTZ1Gg/UhE+FaQ+ewXGqJHOpT1TANRuQ6V25o+ASfTjtAfFNbEYLeWHTojeHFTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO62vc4I; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-78125ed4052so1637385b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430535; x=1760035335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUZYODvSV6S3UG56hxwOik5nzkLbs7prF1klJbRcNxE=;
        b=KO62vc4IrA5cqetuPs23pSSYMP/d6bFJVYX5tuZjUpeyyaYmyxpDm2b/4w0ZnhEBIZ
         kqAkSTpqhU5cWj/MsHd7Wky9RPkPxyiF7IDMQFrMUjXzFlv0PaN2imQqSnXDGgL9acFf
         CwPiignzd+Wx1Eb9UMuOZGfe9eVWcsFnIMKUTKA9J1BEjUCIudaQdIcVGahuO6dOSeD6
         u+Xkr/GHnxJNNTUTWrD7S6lj/5hWCUG2ghwy8EM2UzIUHbJUHjH0IwrfZET4KtRJx7IV
         Si8m8jk7sxt2EQGrYKe8zQ3kxrJvL/yrbxAKVW7q6O5ZW9RkUq478oHkTuy0K610DHQp
         Lsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430535; x=1760035335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUZYODvSV6S3UG56hxwOik5nzkLbs7prF1klJbRcNxE=;
        b=RP0aA+hKQ45/F0uK3gVPDbUIbGzlCpWQDTXyFJ8w0CxW/9T59jKvIhDHDw45q5xG4K
         nI+8QwPdtsvL/SI7HODqYI4FMlyJnY+Ffa+bUaoOTUMDUI9PWE4zie4CxugkhWEAvo4/
         gu6Zb0MsEuGsQlqsDuxjZfnDGd9e2u3HcZoMCBfnnDe9M6ZBr3kdAGbQmlUj/jnWNVVd
         Lbz/gPFm5WhyzQnGTNZbCkebunbF4Jw3eVdIKlb+QNswTookHu66bTm6Wk0M7tR/e8Td
         RThWFguBpiDDSbSVT9V1pMObw0miQm9ax7X2PGE4M/dopvJOAf6yWYcZoeeDWFaGW0DK
         dppA==
X-Forwarded-Encrypted: i=1; AJvYcCWdKHyaYkE+4ArWQMX0Ei3NG/2F7+PhyV3+UY9lKTM8Xfe4Qgn6/e/dsXHh1+r0bi6AD0/Zgdrdo4MOGb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKs+/Msz3OjoJeH5ROVSaUgJtcNx0WGwu7mzdvJ8HLpJLKbDfF
	8Bqf+++57WRcx3DUX9abVrTzbl2SRQ8v6/OiNh1C4HBpeaQSlMXi3k5h
X-Gm-Gg: ASbGnct5qdoBVP9NVyzGCqyNUCMgPPqO3h1D8HF1piUKsVXFTAc3drDEYNOAlsrVC6Q
	oALFsEbsfdVhhEW/sLodDg0TxCkJqFb2dbJ0d0yoofMIqOL7H9QZfFmYfAN8/lb+0aIUwt82SAc
	4PRVcWU0y3+WVovtZvWN6KamOjbWkZXqgO2tN9q3J/GoOp1MiZYH51lmYqLnRYisk3T5+5oBYIG
	+Hz7mfFGljz1BXl0AamIN0zTMdinZOykHFeVLYYsTqahM5H4VauyNSPbC+L8mhIe36IrVYVdE3d
	XQWFeIMU3WX2YWF5DpgTTUEYvC4PoQDrr+wamScv4O4yhY1AZxKKmV9OENrwf+M/h8GZ8Ec6lEw
	phVvlC8jqslZKN4EJQyA+giFTkp5gpvzQl1WdNqwU6OB5rH/rbG66iZCh56S8TESpN60=
X-Google-Smtp-Source: AGHT+IEP2vjy7P17pql5sZfYw/KjKSGAfQViyYu0lFY3uTuOnWp8xnin7dh+GmQxvjNLW8IZDmVSbA==
X-Received: by 2002:a05:6a20:72a3:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-32b61dfb9b6mr569531637.2.1759430535216;
        Thu, 02 Oct 2025 11:42:15 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm162917a12.18.2025.10.02.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:42:14 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] iio: accel: bma400: Rename activity_event_en() to generic_event_en()
Date: Fri,  3 Oct 2025 00:11:05 +0530
Message-ID: <20251002184120.495193-5-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function activity_event_en() configures the generic interrupts
GEN1 and GEN2, which are used for activity and inactivity detection
as per the datasheet. The existing name is misleading, since the
device also provides activity change and activity recognition
interrupts. Activity change interrupt is not supported yet whereas
Activity recognition interrupt is configured in a different function.

Rename activity_event_en() to generic_event_en() to better reflect its
actual purpose.

No functional changes intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index a0e994f9882b..41e95291b36b 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1190,9 +1190,9 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
 	return 0;
 }
 
-static int bma400_activity_event_en(struct bma400_data *data,
-				    enum iio_event_direction dir,
-				    int state)
+static int bma400_generic_event_en(struct bma400_data *data,
+				   enum iio_event_direction dir,
+				   int state)
 {
 	int ret;
 	unsigned int intrmask, regval;
@@ -1337,7 +1337,7 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 		switch (type) {
 		case IIO_EV_TYPE_MAG:
 			mutex_lock(&data->mutex);
-			ret = bma400_activity_event_en(data, dir, state);
+			ret = bma400_generic_event_en(data, dir, state);
 			mutex_unlock(&data->mutex);
 			return ret;
 		case IIO_EV_TYPE_GESTURE:
-- 
2.43.0


