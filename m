Return-Path: <linux-kernel+bounces-755395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76BB1A5DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CE07AA5D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B02737F8;
	Mon,  4 Aug 2025 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9QD/WTA"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897A26E6E4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321044; cv=none; b=QFW0+OcEz7uMN4ooBVk9aOsHFUUaFNyoDfHZS26cmfKVsmtsNSq2uq7Qz/byceMYSeC9Qdzibgi9EBufAAU/Y5Vy2q26s42cHWuJDcU3ysDjT42mwuie+Z3Rm0vm4x2D0YLUCV5Z18BOjCzNJYJMwpJ8VuMreNqDhZmCYM7HfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321044; c=relaxed/simple;
	bh=Ox0mffAq7VFxjLAQ00uA0Jp408fW3ZGQroAD694ufgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6h1/eKo1jeSu+jz8zZn9BuGx+qY6ePNLDSlSkuxrkXz75D9JDkv1Pgdbio9N3enzIwt8voWZbEBlTRWCef4fez+7iximTsA/GTdWYRLkHHqAoqqvnwxwu7rUQXNMSN/p2ZEjYHbdQVzkZlaWcyjhIbSbOpBnb6xbVVUl3PG0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9QD/WTA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7961cf660so3463249f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321041; x=1754925841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpZCEzRp6axYcNR29ZqHh8YXgG+TKuUWU3bsudMRByw=;
        b=k9QD/WTA2JsYGQxA3GfWm+PvNrU7hSTUkXICAYUjZvTTWzNLDE2kJlWhxBp1MPfU5G
         PgXZ1ChokpZ0HdJFzPHtM7m7xMfsvwaJcDQWMZx9QFOjYiqdXVCdtDRR3NsDRpCUwfe4
         L8LjmnQkdhK2AAnf/TU8JhmOQ5Dv9hAUaZrvYLs8JMZpCaixnYBLqi7pNMYiFesU1Hht
         /g7It/eYDXegrHQQu5YsrZTLjLZU3paLgYH32ZiKO2CVbAaUmJVKo9K2VLutnff32eM0
         5UA452IDRbpEV9fUdlhoqqiixNtqbhuVOqbv82wPZ47290SwmqTVcGkasI9B9JvdHCP+
         gqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321041; x=1754925841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpZCEzRp6axYcNR29ZqHh8YXgG+TKuUWU3bsudMRByw=;
        b=eib2GuGnMWhYYlyC+mU0F2h8cfvAkg+oALPqcCB6mbsdiLsaIPnPoPX3nEtBP3ZLRE
         B7VJGdgoD5+zIoWE8vb6tJPKjc5J+2uki5J1iXKZb2fGMBCLX+2N5KNwbKyIaLtK+CMQ
         Y0NNvSlHp+VCyUQCp1vdPEd11Lnix/fjDjOYNJlfj04YXcRpXlOrsomOoIBKB+JR1Sz7
         uzsimNwFFCcJDaFna0BrbbgZ5lflrliCIHUv9Y9NE7KYoNrNYB9koVEZNw6jngKSTR2C
         v2WJkL2LWiHsHffJjbfpB7kyO42Idk4URkEEnIKb5WZfRBaryHqcbMtglmoXtVB+MxKD
         /7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrGPDwR7Ngcv0TD1xL5VRXd5HY8q3548p+Vf5AZGq0ODwB46kVOLwfESglWA8EC2E6DuZM1xzJ4rnQaQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNd8tcrM+0jTOCi25vjvJgZPSXtOHTl+ZJZJV8zZYlEKMiWLIh
	eCdKRYh+WGCmGzAI4WZE7uHSG77a5W935lxG3MLEwTSYfvrz+yZ0IaQQdkfFJOcBPAQ=
X-Gm-Gg: ASbGncvd9PNrtiq3GJdtg3nafSgMxALCkUta3jAZ2NAVEgCNd2xPFKRXti3+Dv16ZPz
	rjYHElscklpYxkGAGd6TOVXUhSd+PU+K0yMW1jXK1YbSja7yiZ3ZOxirKvVHPlxXqo06HkXlE43
	RjD66zoaOXKYF5n9T+Bk2MpYppcjAqOm0cemTbwfZKuh0gVcZsMwwpINPnLS4x6NKtY+ddA0JG1
	hkZJeFZtjnxsISCVWVZ6d6jyrrYoMMnHDWGnxAKxiM/4Q7M9P3rhcCS3+grwksmI80nr7c5Xfu+
	kyreQZFOzI7chk+bYR1VHqNEfHl3ZM1nVKNJy4rTr25Bdb7OYimYzDI+rituvqr9aI5rn+ATGhT
	Ujnx9uiUmJKTc29eN4M6BKB5toIIG1ZGjDJ1Sl6ZTHHq1VqIp
X-Google-Smtp-Source: AGHT+IFnYxGxMKMSKoEvbWIFxguEfVGN3C98aTj47xZnYXpt7yIbGnnsyHqLFs1fTnM5pyLyixo+bw==
X-Received: by 2002:a05:6000:1a85:b0:3b7:8832:fde5 with SMTP id ffacd0b85a97d-3b8d94707d8mr7367018f8f.13.1754321040746;
        Mon, 04 Aug 2025 08:24:00 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:00 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 08/20] clocksource/drivers/vf-pit: Convert raw values to BIT macros
Date: Mon,  4 Aug 2025 17:23:26 +0200
Message-ID: <20250804152344.1109310-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the BIT macros instead of the shifting syntax.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index d408dcddb4e9..d1aec6aaeb02 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -21,11 +21,11 @@
 #define PITTCTRL	0x08
 #define PITTFLG		0x0c
 
-#define PITMCR_MDIS	(0x1 << 1)
+#define PITMCR_MDIS	BIT(1)
 
-#define PITTCTRL_TEN	(0x1 << 0)
-#define PITTCTRL_TIE	(0x1 << 1)
-#define PITCTRL_CHN	(0x1 << 2)
+#define PITTCTRL_TEN	BIT(0)
+#define PITTCTRL_TIE	BIT(1)
+#define PITCTRL_CHN	BIT(2)
 
 #define PITTFLG_TIF	0x1
 
-- 
2.43.0


