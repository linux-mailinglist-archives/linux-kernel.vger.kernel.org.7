Return-Path: <linux-kernel+bounces-843795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ACFBC0492
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F41D44F39F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9956523C4F4;
	Tue,  7 Oct 2025 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NymTIX3z"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CE23312D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816552; cv=none; b=jtsXLntvDR1zsbJh+amppKsxWZq6ypGEjeTPi/cDQy74kGaGlIWcWCLZm7J2UzXzwlaNFz1UvkC6UC1l//SITrYKmA11sm5AkyIc2w/BV0FGZui6O3gV4tScFZCL9WH6DclpF0Q6dR2Ghe/k8OSajVnPAa6uWdn2U+JJQx6TN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816552; c=relaxed/simple;
	bh=Coxv9LkBZ+56ZqgTTagylAjun+Rfk90LFEZcv328N2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0ixwBOZR+rlkA9hD/9zEBOGL2JHLNDN0oMMxfA5zRYi/1nTMtY8tMXcysRiMfphA5lJ3JdGGPGkQ5PQL7MmV89XblfpP4OYWHogJE2qNhpPbIFH9EGN6QCNI68Fkano+QfVo+9NzrMHWi2SaupyPVraEbjGFQyXLkM0ev5C0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NymTIX3z; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339d53f4960so2901379a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816550; x=1760421350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQsI6ooSHKXCcKpweqSzinWozKmIkvvbAPQL3qXw8Wo=;
        b=NymTIX3zD0fNRDQHo6ItemKgH+0Y0tYA4jAC4jCYJcWUWKbfTlfm1yo9OkDtEWFBjx
         XJCCbcd58iwKAtFzcH8lJO1+rWNGZmaXjOScSxkzdZr/I8nluXvTKIS5ABSQ173q6ul9
         2nM7EcJzuWZfgugkOeBSVO/AzP8zLAlTKwOw7DrmIz1L6706vJtC3rj35jCc6G87y/e5
         3d8YYbpE1jCxSLmrDOZuwZv01WObPJCyThGVOqqOiirGA4RlAM4x/Z4O9SXRxrR2WZDT
         IavmOnA8HjGG90LvXHmng2EPnWHOzZxeRLSRBWLsSzz3i7y5K7euXnVrl0nWr3uj6EPG
         PArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816550; x=1760421350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQsI6ooSHKXCcKpweqSzinWozKmIkvvbAPQL3qXw8Wo=;
        b=SBvcfMG2Hdeq9INa6JaLvxfC2Kokx6gIJ9R3hln3nMX+YA7ctwTrqvU1XFQZAptGxF
         dDA75jNQ1Q9xmvLCh4ognwFaCSLI5Q7qYQi64lgknXR5wCtLhIELBVx+hUBqLI0E17AY
         /aVTLk3uqwUny2mltP1KAAxz5SC2LpkNaGUL/DWOkWs1RqfprFKziLerwjewHtupz/yO
         GqARJ17s2Ru41QBRdX4AuOk+vCwJzCkejGFGWk1ORa1d4YM7Ke7/UlMOLw40qWTGO4if
         dPZFccggFgpmRZhx46aoG2aj9b30ohbmEsQD8P8PmIfrRx04R6fsNXi1nS4ygGUEF8eW
         CnQA==
X-Forwarded-Encrypted: i=1; AJvYcCX7GQYH1iy564bTUXd5lt3R89u4+5+73+VTvGYsOK+EYQ5cGSyIe/vIvNCVWE72Ot6tFJksA87x8YIlwDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxreDdLeJpgugtAwYA/byIIKlNExQSkarcITcOlOkIQEcgOljXB
	0jfQoTuZaXriwe0dTDF5AIYj0hgl/RHIPAuaQwffvGzh0hnTvM/jh/yK
X-Gm-Gg: ASbGncv0VGwZWXasSON3+isLDwItvub1ou4faLwCRqD9S+3LYcG27EItGl9tDwstMdw
	sBKlS9i311aJjzZ80DNRJc/e6MVPSi2oaTRT3kKTUlSEfJ1nZZYv/T7QtjNyQYl6erWsf4azeNh
	A3xf0sl3mG584oaK83SNb6DCEGh6qiuTxkQfx/XW22zrcy5EQCztmhEESk+hI34wJWFNOziEiQg
	pAJX0X6RmD1N+DKHuOanH2bwISGzkPYAorqu/+HHgHRsYs7RO11y2J6t4f5bFFcummcAAAukiSv
	4rrx5Gzxfzox46qo8OQFRNv9ur0vW8IVFwynoNu7CkVyaLZ8G+KNAPBqZuAMUuVw1CQWLqSDRLv
	HGOpeWTw+1aUhOsXMX7J0HED8vkMPpshTf/pEE8M/tpG3D87I+u/G1E/I
X-Google-Smtp-Source: AGHT+IHsJvBTZEKlMhO1eJwhW9FQ6KIKqanMRbgrxxnbVroNK28u90EbOtkZsfIwow+uPANEcbt0jg==
X-Received: by 2002:a17:90b:4f48:b0:330:4604:3ae8 with SMTP id 98e67ed59e1d1-339c2786737mr16896516a91.21.1759816549427;
        Mon, 06 Oct 2025 22:55:49 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm12983829a91.11.2025.10.06.22.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:55:48 -0700 (PDT)
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
Subject: [PATCH v4 5/6] iio: accel: bma400: Rename activity_event_en() to generic_event_en()
Date: Tue,  7 Oct 2025 11:25:05 +0530
Message-ID: <20251007055511.108984-6-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
References: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
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
index 665c8df93008..1900965a1048 100644
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


