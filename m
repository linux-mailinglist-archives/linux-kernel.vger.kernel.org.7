Return-Path: <linux-kernel+bounces-894413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E01C4A451
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBDA3B0B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D1305044;
	Tue, 11 Nov 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pkmi93pI"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4DD2FB973
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823149; cv=none; b=SEZjOVcltZkz0wMVbrGo/oUKbKSdshYhuSdqiiTlld5wrlC4c3HFRH6EnpFWJ/WWKpFuBJ4GW9y4kTolL0xSkW6zDsbZIk5oFnFpEw814y0iiLeHpJPei9qO8hoJ0nClgLYgT3OPiyUBpKeB+52kf3gH0tEoM5NkRWNPxyOyWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823149; c=relaxed/simple;
	bh=32FzMDU9FuSXH89N9W6BQDxaQIuvFnXEJ7ejrXc17Oo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NneKJZz+ZWiXaDBPbR5zskx0dd7N1BgnoyUtfd36UdIpldkrxZEc9udXqnsDfAhtwoDKzixmJ1tOhojCqvqyz2tRi6qrAmMfeANU0RXeNm28uI0PL5TMi3X6SknhKeSbIdzCDH+dDTwjmnFrt3Cqk7IPrpQaaKE2UvTsBaA2mkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pkmi93pI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso2945963b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762823147; x=1763427947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AU1cvyK/RZiYSXnkWHxOQByTi0bqhv5ilLpZYMg7YE=;
        b=Pkmi93pIOU01fZ2npdBEgjfvWfRmIgGbNiAcjNd2rjzvU47HHOiK48ZQjVreA25+Tu
         Tpqp3dP9SUetxKFKqEQDPIdrxehgfg+BmDWAideQZf6sMShwTscIlQnICd+2f5koacfa
         ra+zE5AQn3I6puu9hS7wu33IudacS+NICaK7FBzyJ3aaW7esWOnjAXm8+W9xMcDyjqkl
         XyJg8n5XaA5QOAQ0RFJKDX/aPsjZphdnp40g+V1dO5EbKH/COFSo4h2mq2r7ISMMlM6n
         pHapKcGQ5FMaikHPSwrplDYn5sWjfunb7hccMdGMDXcbs8xPh6zD8h6lJi3U2Ubc7GPO
         l0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762823147; x=1763427947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AU1cvyK/RZiYSXnkWHxOQByTi0bqhv5ilLpZYMg7YE=;
        b=j6Czf//kp+xK4/OyBSlDClCH1T1SeqnqAoYJOux1Odojzw8qBFK+Whh+JlE/kaJgbq
         Ga+JbjiDamlsHOTdnx3RGal5oLXlZfGBn5h9cYF927CT+3d8xUxdZ7AiJYKuDmQFKZZ2
         0SL9ZRIEC6WDm9kCG5muEK4Wy7eJNCTefbQWfrT2Y/TX/XBCGmVeMpvuoICs+BXS3wz1
         EaOJNFIS9g+HzdLEUJK09MrCv22zb8c8FxhuOQQefet0fzhRW4d8yzY2W9WbRND+Bta9
         uYKwjQTlIzR8GvIx6/kvppyNhU0xkTRKz2Q2nLRdI8XLb4WbjMrD0dEE0jbhA6s2di8N
         7Y+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXujwRt33+vBOCB41HXr9gs3XO92Hf6MOuPvMvpvU0dPFAXyJaEdOVlYjLn8ZIIgjVYkp2nlaCrszXJDzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmc4XRDUmkdnFS3RBhfidDqtuUyJmBf8pThfOJwtEhF6WHAUQG
	NYjb0WCMV8UHFPG2YpXWSiB3KjjM/v0R+MSnJWrFh/tMvRQwKa3xMgTo
X-Gm-Gg: ASbGncuEqd6XfipJqbVls7ZBaqZXkdGkv2zOkGS2uELDEIY7qQbe7KYz3YL7Mp9rIMN
	RHAu3XSJRtA4W3U8Nn+G0iuzk7YPuSFxDs3CB1yew81FUrwPmJw3mWC115T6Qvp1gfmgZr/epfb
	Qtpm9NGjFblrF1ZbZyY7AY9NrZaa5ek8ZUTtPmQKRYvFSGoc9DAan4MrCoCqm2iNr7nue2g23dN
	SuuItNxBxA2c69E0p1lU1ljzjO74M+O1YFTVsP5YpmQrET3mtBx4LLujJmHsN7me8Rptzw4NC0U
	ohlUGFiwhagyIvUNOANTXSAcUv4rxc9AileqMj5X3raNKXwyYnmejDl3sSvPdWgmoouEdoWW543
	iXwuZH2rF7l79YrDRRWkxy6gUlVhraOYVZIri5j79UG8O/oEy6wySezkl76NA6DjgFNHQvemA8T
	Hx2i7C0jAUZ/foYubV5hhi5cZo9H8oJOHodQ8U6D9qCq5L3HpsrKE=
X-Google-Smtp-Source: AGHT+IEx5azjX+o3hqS8V17+4/MrJOMVmOKv87GOYuNRk4AU89k6A3F+8tvCJUT2IefZkkfOXSjRHw==
X-Received: by 2002:a05:6300:8095:b0:355:1add:c28a with SMTP id adf61e73a8af0-3551addcbd1mr7931367637.2.1762823147197;
        Mon, 10 Nov 2025 17:05:47 -0800 (PST)
Received: from localhost (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b214155c8esm9744314b3a.38.2025.11.10.17.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:05:46 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: typec: ucsi: Add duplicate detection to nvidia registration path
Date: Tue, 11 Nov 2025 09:05:40 +0800
Message-ID: <20251111010541.145421-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111010541.145421-1-acelan.kao@canonical.com>
References: <20251111010541.145421-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the duplicate altmode detection to ucsi_register_altmodes_nvidia()
which is used when a driver provides the update_altmodes() callback.

This ensures all drivers benefit from duplicate detection, whether they
use the standard registration path or the nvidia path with update_altmodes
callback.

Without this fix, drivers using the nvidia path (like yoga_c630) would
still encounter duplicate altmode registration errors from buggy firmware.

Fixes: a79f16efcd00 ("usb: typec: ucsi: Add support for the partner USB Modes")
Cc: stable@vger.kernel.org
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7b79e7491094..923a7bd30936 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -535,19 +535,25 @@ ucsi_register_altmodes_nvidia(struct ucsi_connector *con, u8 recipient)
 
 	/* now register altmodes */
 	for (i = 0; i < max_altmodes; i++) {
-		memset(&desc, 0, sizeof(desc));
-		if (multi_dp) {
-			desc.svid = updated[i].svid;
-			desc.vdo = updated[i].mid;
-		} else {
-			desc.svid = orig[i].svid;
-			desc.vdo = orig[i].mid;
-		}
-		desc.roles = TYPEC_PORT_DRD;
+		struct ucsi_altmode *altmode_array = multi_dp ? updated : orig;
 
-		if (!desc.svid)
+		if (!altmode_array[i].svid)
 			return 0;
 
+		/*
+		 * Check for duplicates in current array and already
+		 * registered altmodes. Skip if duplicate found.
+		 */
+		if (ucsi_altmode_is_duplicate(con, recipient, altmode_array, i,
+					      altmode_array[i].svid,
+					      altmode_array[i].mid, i))
+			continue;
+
+		memset(&desc, 0, sizeof(desc));
+		desc.svid = altmode_array[i].svid;
+		desc.vdo = altmode_array[i].mid;
+		desc.roles = TYPEC_PORT_DRD;
+
 		ret = ucsi_register_altmode(con, &desc, recipient);
 		if (ret)
 			return ret;
-- 
2.43.0


