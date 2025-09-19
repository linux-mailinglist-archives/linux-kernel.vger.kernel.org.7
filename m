Return-Path: <linux-kernel+bounces-824116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66139B88280
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2178252114E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4812BE7B2;
	Fri, 19 Sep 2025 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qoPTt1AT"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D241139D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267127; cv=none; b=Uy0dJ7WLwfZ3QzFSJLbEwgZSKBX3EiWUoYpiQDFMHOCr+ja46SlKzg62ObNVJENBHPnoPb0cAxfOn8dfqD4Q1n5LEdqxyM3wKaasxLCi4Rt11sEWEIZsLleTxQZaR5Q9CKBCKJYiSL7PRWsGFembdrAkTEm5HdtaUdWLzJ45hOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267127; c=relaxed/simple;
	bh=wt4kTbK1OFFwOwKQjoxNLzwQB22NiKqqduDfS9iQmdA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lLo12stYHhbB0OoL2hEYklDvg7rnw8+7qTapMQa7HUlTke1Y2TJSlkBcmtvmTnG18r/G+O2vAIFj/3Txii4g5MyNtAiFhaD+HU5bDJOrBwVE9cVoLco6xjh7yUskk1+MAC/qbpD6BWfokKrPa/XCHZ1Yd7g/ru7ZJfNxSnQ4X54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qoPTt1AT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45dd9a66c3fso5942185e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758267124; x=1758871924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTPVmES82odJDGA+CLGTeyXy0AuTwdVk1zEwZ9AQgIY=;
        b=qoPTt1ATXn2AR3kv1GrSaIZAnuLLaka88z3F4/QH++kkKe75iqvRiAW/KaxgdkKUBg
         0T66mPSwlaLVqja/Hna+vjgvfnwJ0hvyNosmZFBqrcasttmXGu3FzQcTRugL3baM55I3
         P8uSrs+8b/lu1T1qrJB4McCf+ZGrku6ku15moFA1OCQw6CzTeTkfXXIwCo0o0Ob8qZ+X
         7HDZIgSsQheCPz08D1549sEbS4gxBt2RK9gFU6M8iazRV6Du0Ng+nJbdIItI/FNGWKGZ
         J/nAVyX/QedKOk6M7Ufe/ryoEu6voSWuB4+tlf4tN/4XXgQ/21KdAd/bOhwDiwgdHaTS
         8+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267124; x=1758871924;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTPVmES82odJDGA+CLGTeyXy0AuTwdVk1zEwZ9AQgIY=;
        b=uf5r9ofXv57YmPdPNHwX4sMappIrXX+V3eaJ7/R5m0V/23y2gsuaFpnd69+9ivCIme
         nZH0zoqbhkCUF7pLE+4JcofDcS9Q28d+FSouDhNzbsjR4+pPHa+g+5IFUrA/Hl+yJjlC
         OVODBfbCWnUpoSfkyL9kdhjl7RS0BkejeDS7/uvw3kDJd4qWUVIBTUXWdQIP3fMgej1K
         24mPHqBcwIV/Q/5Wp5DOH1syAhD5tU3NQNvqfPw5SKaY+Rv8GMSZZLR7Tk0qtusCSFXZ
         Rj36FdlSvuCTC+lpaLcX+wjb0L9e/my0eBzAVsYJccQN+hwhsk6ReJGfghH3WDwjnbKA
         L1SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeXadZscm5i9a2iAE3IUdGp8MY7wSc6AyaiMiZSH4YvNn4L+gslc8X58xHvoCpnSIOjmx2+VECd0UtLQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzifk9ucPhOwI5m0vxCHb7bekFu9pLQ7miamBboF4gnW6YJe4oR
	oVead53X6IRYNP1l6M8Pjvxl6mu7bIdM5aEFV2LTVHomKXUWNZD80NpI6Sh3SY4GSnHPV/1Fc3m
	mbNe1ru5IwA==
X-Google-Smtp-Source: AGHT+IESu4JDMN7PgmfEMFn6QSaJImsolN+62PXX7kbWKDbNIcYpMJOrBufzNDmE5qMK7Of1XKMXHqAp3fy5
X-Received: from wmbay39.prod.google.com ([2002:a05:600c:1e27:b0:45b:9c60:76bb])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:314c:b0:45c:b56c:4183
 with SMTP id 5b1f17b1804b1-467ee8c56bcmr15125485e9.18.1758267123982; Fri, 19
 Sep 2025 00:32:03 -0700 (PDT)
Date: Fri, 19 Sep 2025 07:32:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919073201.751348-1-abarnas@google.com>
Subject: [PATCH] drivers: rapidio: make rio_bus_type const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, 
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because driver core can properly handle constant struct bus_type,
move the rio_bus_type to be a constant structure as well, placing it into
read-only memory which can not be modified at runtime.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 drivers/rapidio/rio-driver.c | 2 +-
 include/linux/rio.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio-driver.c b/drivers/rapidio/rio-driver.c
index 238250e69005..bcfe0b45b377 100644
--- a/drivers/rapidio/rio-driver.c
+++ b/drivers/rapidio/rio-driver.c
@@ -227,7 +227,7 @@ struct class rio_mport_class =3D {
 };
 EXPORT_SYMBOL_GPL(rio_mport_class);
=20
-struct bus_type rio_bus_type =3D {
+const struct bus_type rio_bus_type =3D {
 	.name =3D "rapidio",
 	.match =3D rio_match_bus,
 	.dev_groups =3D rio_dev_groups,
diff --git a/include/linux/rio.h b/include/linux/rio.h
index 3c29f40f3c94..2c29f21ba9e5 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -78,7 +78,7 @@
 #define RIO_CTAG_RESRVD	0xfffe0000 /* Reserved */
 #define RIO_CTAG_UDEVID	0x0001ffff /* Unique device identifier */
=20
-extern struct bus_type rio_bus_type;
+extern const struct bus_type rio_bus_type;
 extern struct class rio_mport_class;
=20
 struct rio_mport;
--=20
2.51.0.534.gc79095c0ca-goog


