Return-Path: <linux-kernel+bounces-829056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E32B962D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E8E1899A70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33D221F32;
	Tue, 23 Sep 2025 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="m61MBV/s"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7018E20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637118; cv=none; b=RtSDcSlj+79wyE+idlmDc/ap8lS1dCIspfhiqpKLCq+khQ7oXa6Bj0/5q8NvWLEbvpzbUb20DdWOWvVEcOO9lPbQeizdlK3SGUrfmEggkoX50nL1CZGdVBsWph9I/v6VlD8c8JbOEJvKfPe/uYWcM9mxivUVuAcXLJ1rsswQzlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637118; c=relaxed/simple;
	bh=dGetF1qRy9QXK0P3a8VW8pHQYytO1lsKqc29yOoYSyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ly/yH+lFhfWFr5xxkmdm5tsGfo36Flzb3J78Q1i050uk8LnJgQdK/3gLf7XSoyAn+Bs21gtK1wpO2Tk53ygtVQWB7oNZfL7Km/lDHNDeBXKwCD5Xlqj7xL7D9GzM4twJEOkYvnjvE4GoprRgWxNRLHHdZHTmrv6FdKo2Jp+jdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=m61MBV/s; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so3708961f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758637114; x=1759241914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFG4tL8lqUh/sVKHN37qHfPMPVZ9QDTBTj4893Vci9I=;
        b=m61MBV/sTq4KrEQzQepc+JQRslZuNMRlDMsyd+DpfKD+ctGsIKwf67kMXHF6AcuHIx
         BS20phdd5i5QJtk8933lRym78Gho+0qBAc1dPIa5C7swHwGbsqgxdf/G1yd6azoLo2IC
         0gSK8fHPPYO/ath+2+tCnL5e1DiPtOJ7p3s8sqBcoF4O2S+DcXNT+YRnF1gEucCsQ0lk
         PGPFjVWwB1LPkRRiVrptyzwDliYVcDl3/4l7ResTdcXdDC32YI8kqKoa3zFOoqwW7BFK
         dvzwyF8Igf6H4rmaygLN4+sNvg4LovAcAeQM2YnrmN5lpwywpKE0xfARbD1iufLwW8eJ
         5AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637114; x=1759241914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFG4tL8lqUh/sVKHN37qHfPMPVZ9QDTBTj4893Vci9I=;
        b=tQXgl1K0hwQg9K2GdgotC8tMhsO93kiUa98qKTfg6Cjn3Y8u1yjjrImqtXMePXVoNF
         MakJfgdqPInVQog0z2ZPjqC+RRy8Rv0ooZae3VEq9B4TD5W9xchAdvzyWdgZVY3jfzVe
         GlDnlPVUTt8cFE2AaA4MVzapw9pZNGzPXNCrWAjo8vTZlmhU9jFNGf/SaFz/mgNHZUPC
         Z3qrgAsUSwPgMKgHg9ip/hrlb8GN5iZtUONTjIV1GUgk5Vcp3kM1I4VNER1KR8SGH/sm
         03eqyT65S8Wu+FxDE5Yb2TnOnJ3o1fhn6ivMfNWbC+bI7Vr7Q/CO8kf+h2UDlPNmffel
         baVw==
X-Forwarded-Encrypted: i=1; AJvYcCW12zJxL7euOTLhh6anB5+wldUEgUbQJao+Zu8tflX0NjQzmGbWLmRSjNcheuSaJt5Ophh1eoNqzL+R+aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFTYGDGyhIBxjClTTws2ld+6SfDS99zDqUM54KIgRrhFp5+ep
	pHm/NSWPQh+TNFyFn7FUdfuqbLj+3P0Lyge3CHkB9jVG/iBiZgjqX5SM5SA8YIXe3ro=
X-Gm-Gg: ASbGncsyBD71D5BwOiAStWCCz9eQdJOO92gs8OG0mHHFKiGXnVWn8o6JERjMq3Ph9xs
	dAqc13yX7OuVg+vTe5SFgfLX9hkGwY5+GssyDIkUqcRGd/ITIDbcCj5/6o2UvwEUewGb64y+TeU
	J81XMFfnXZaTiy494TTs6JiaI7wy1naM83jPJJ06Q733ZkCTrmur/xLbrM1NBYmyeLnINCHatM7
	8eS485ClnS9AT5snYmE3TB03BEqIQCjmNg3oNmN/9wyByY/W7N6ApIVQhEwW2Q6zOrfv8xj93ie
	vvm6Grrpnqif1eV30PhGZymIycV3el5gz9VKNA+rGuOlWt/cgGSt2sOynAyoJiVaDoiG12CN+k6
	HyAZaYgXhpXsJe0EP0TXpiH6TuGGXhSWo5Xkh8XNl9fUR6pbivbaJ
X-Google-Smtp-Source: AGHT+IF4vqcfWEYZtZ/S8nA08HR0jyyV0IaZblTvH4YW512bTSjwjlBru1lEZAr3DAhQSemddQNZLw==
X-Received: by 2002:a05:6000:1866:b0:3ee:b126:6b6 with SMTP id ffacd0b85a97d-405ca76faa0mr2014826f8f.34.1758637114129;
        Tue, 23 Sep 2025 07:18:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee141e9cf7sm23617713f8f.12.2025.09.23.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:18:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	wsa@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] i2c: riic: Allow setting frequencies lower than 50KHz
Date: Tue, 23 Sep 2025 17:18:26 +0300
Message-ID: <20250923141826.3765925-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The MR1.CKS field is 3 bits wide and all the possible values (from 0 to
7) are valid. This is true for all the SoCs currently integrated in
upstream Linux. Take into account CKS=7 which allows setting bus
frequencies lower than 50KHz. This may be useful at least for debugging.

Fixes: d982d6651419 ("i2c: riic: remove clock and frequency restrictions")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 9c164a4b9bb9..b0ee9ac45a97 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -386,7 +386,7 @@ static int riic_init_hw(struct riic_dev *riic)
 	 */
 	total_ticks = DIV_ROUND_UP(rate, t->bus_freq_hz ?: 1);
 
-	for (cks = 0; cks < 7; cks++) {
+	for (cks = 0; cks <= 7; cks++) {
 		/*
 		 * 60% low time must be less than BRL + 2 + 1
 		 * BRL max register value is 0x1F.
-- 
2.43.0


