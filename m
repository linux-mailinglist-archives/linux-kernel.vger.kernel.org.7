Return-Path: <linux-kernel+bounces-826850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57144B8F7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CFC2A014E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC572FF643;
	Mon, 22 Sep 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkDtHcUZ"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC12FE049
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529524; cv=none; b=AJ00PvJi4NbpeH/jwx8MHOTWAO2ReSthi5AeYbZP5zA+X2IFQNoykUBo3AygTj7M6ihWkWvUTbsHHyg/R02A7ks4loNlTcgXp9zc6uLnoE2wViUnWh7E24h2XnWC5Ay9qmx3g/Bwgr+Y4WfNpZlloW6LEPXiCKcSBc+3xCY6K4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529524; c=relaxed/simple;
	bh=oLrFhF92HdArUx15fueLaKz7PNKuzX+jtAfAeTiwpXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CxA0J92+gKD1o50IabQLaZua2YL0y4CGwz1rzOV5v216QEyJFePDGSWfoXUtZjP9mTGT8xd3SL8dfzoChClX9bOIl5UH4+8EVMTUYMmbp9HVYmR3SoIZHNUoUucb1uIXk9mHqKAmXeuV9eh/bcsr0TIRta7I5l3hBmBKGY8gBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkDtHcUZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso2697680a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758529522; x=1759134322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ggi5B9vLvJ8tH3G1KF/mQ7XMoVTE3nlPVTBcBye3zVQ=;
        b=NkDtHcUZOILSbaBzJ9mUuDk10oCNm2DmbhvbTUHSwGwGJ4T5N+E+YIwuIYocj5Woxj
         n/wCLiZ20zaj07fxBePozicvqjuGPTCrQ0CJOzeWQ7wNH0SEAe2dNfR4i5U5WIjjPavX
         tMETlfIrdmV3fr1dj1B/hdBNlS7b32W+IIvFDy6E6Wmv+E7+R2wVyMi49oq0qpQOzyKN
         b583XsTEWBxBcjtmFD2qkUqN6nli8ZYzY6fFlXPgNLH+KkfwlDGw2y/CliOvHOiJ0jdS
         +aa9FF5n4us54umHCGdlb+pmlBx0eqMSSMHsOo36NNfhGSlgBQ8VcjndiarJoa763Ya+
         8cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529522; x=1759134322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggi5B9vLvJ8tH3G1KF/mQ7XMoVTE3nlPVTBcBye3zVQ=;
        b=K87DB5FDu/aSTcF3tCVJvIm4Q+F9ie8W52/M/o4Acrj27H2UoQjbsPrnE00PlJ73Z1
         UoHvgK0t44orC0DILLB4N4U6qaREiaKUbR0zJgpRPxsA2LUDUaxBsMAEK/6DgdzmWOX/
         mrHTrdRutQqbDn4UMg3xVM36NvuyLRPQQEIfB+NrA6HrNNubqzGp6+XhTt3bjc4NeRyy
         sHHMr6Uz6zJQCK8srMu3UD13paGe+S3x1BWZDTRPTD8wR7jAM5VSdQ9pNjuBTyyMlRul
         Y+5baI7t82FEnKcve/6V4Cvp2wbAG+ZPG+tzdbibCqLq2rMedehwIOPFrNiGKwFFPSh7
         qssw==
X-Forwarded-Encrypted: i=1; AJvYcCX6MeY9glxpKC4BU+cwRwntqibTeQEpxiP4fRCrA16Qx/5V+CxD7yoacRnIAaYdo4s0F2ArJL8JD4cyW8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3Z3uIqUD8DNyzPXJaWGGDtzFNERvkWkiHuUaFYkuBrJe0tw4
	u27SbhjlzaVJ2HPGIuaLQzezCPEyelQ3jom7t1IT0VZ4ApZ43c2ztPje
X-Gm-Gg: ASbGncs7U1PwWRZG2flumig0uf88oNu30PMwb6Mg/7Wug2aYVWHeOQfkaK3SNs3Ab1d
	Sd74TwE8d2aP5/QZHlDsS5d1iQTDBCyB4nWE9kSYOI0IJJ4S6X4j99Lxu+aQ4X/k0OhhMXzQWlz
	3XOKGFkvG8Zw6cHpCjVQLaqk+3pcBl9CDCgqUA2tyQKEqdNIB/DOZmDx6Iv0qDOod6Gd5ZH7th0
	2DUzvniOjmJJj+cRxZsajwoi6gkE/lmTlEzwnDLoH7+45j0INqebvPnGcAEfHvXj22KWcmdYhzY
	bpTRFamoiBYsfcMip3lRoEcgK/zd1c/XJH2MP6cY1VtCCt3D97hHRYdnPotbiKjPuaA2N+dm3lZ
	GMwDVt6eiEhjyQRYpqNKV78IftFGew0I90XuevZlO5dsQXz/vB9jiM0KIX4GJRjRhvObnFiurEO
	BTG4Vs8r5XrxotC4hWqxMKX2OV1b4=
X-Google-Smtp-Source: AGHT+IHESfgiWX1583jgQOasqZLBM8Q7dyrYwWIi+YyG7D00B4yjVWdeH/3CCyl3mLO2dR0NwhJ+5g==
X-Received: by 2002:a17:902:cf03:b0:276:842a:f9a7 with SMTP id d9443c01a7336-276842afc51mr57163045ad.57.1758529521976;
        Mon, 22 Sep 2025 01:25:21 -0700 (PDT)
Received: from rajasilinuxtest.zztcpmrl4zvulnxionwmgqorff.rx.internal.cloudapp.net ([40.81.226.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980318743sm122818375ad.118.2025.09.22.01.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:25:21 -0700 (PDT)
From: rajasimandalos@gmail.com
To: linux-cifs@vger.kernel.org
Cc: sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	linux-kernel@vger.kernel.org,
	Rajasi Mandal <rajasimandal@microsoft.com>
Subject: [PATCH 1/2] cifs: client: force multichannel=off when max_channels=1
Date: Mon, 22 Sep 2025 08:24:16 +0000
Message-ID: <20250922082417.816331-1-rajasimandalos@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajasi Mandal <rajasimandal@microsoft.com>

Previously, specifying both multichannel and max_channels=1 as mount
options would leave multichannel enabled, even though it is not
meaningful when only one channel is allowed. This led to confusion and
inconsistent behavior, as the client would advertise multichannel
capability but never establish secondary channels.

Fix this by forcing multichannel to false whenever max_channels=1,
ensuring the mount configuration is consistent and matches user intent.
This prevents the client from advertising or attempting multichannel
support when it is not possible.

Signed-off-by: Rajasi Mandal <rajasimandal@microsoft.com>
---
 fs/smb/client/fs_context.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 072383899e81..43552b44f613 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1820,6 +1820,13 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		goto cifs_parse_mount_err;
 	}
 
+	/*
+	 * Multichannel is not meaningful if max_channels is 1.
+	 * Force multichannel to false to ensure consistent configuration.
+	 */
+	if (ctx->multichannel && ctx->max_channels == 1)
+		ctx->multichannel = false;
+
 	return 0;
 
  cifs_parse_mount_err:
-- 
2.43.0


