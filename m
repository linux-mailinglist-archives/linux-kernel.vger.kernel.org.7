Return-Path: <linux-kernel+bounces-860020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C97BEF251
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0D524EB1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649B029ACD8;
	Mon, 20 Oct 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSt4y6gb"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A21F63CD
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929630; cv=none; b=J19uSnHhpIe10PPgCMwA4OssYttTuon4RdvAbhWsA3RCTYVz21+1rwGcliwCK1Y2oEFqrLhugLguotUK2/mJ9RLUYVErgL1K+lyCFYvsPMjB410cmpYKTII3dSVA/fVxht2drXKrHFqMEWUyb9NGo753X/s1jMbmP+VzddbKMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929630; c=relaxed/simple;
	bh=62CZS3Mnhs6KiGn+uc9ThB3o4cJtU1xkwvV9CLAmJ/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El3DBqqqeq5jbnujGa64uIFRIvJwJ6+aS+UuuNcV+iJA+lVfsEafVBfH0/aYtRttaFgv3jjDqHiNTKc8WWyuzx+NU72dssP6ZJ//73ymzpemyJaBqesEuTLXbv6Tb5rN+AbWC7BurCGzZ54MUOIvYYJnw1vyNhAOV2G35PR7Ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSt4y6gb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b50206773adso878748466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760929627; x=1761534427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdEInNnnI8mUaV9oHcjuBVGjC97eLQH2pPXt+cVP+WI=;
        b=RSt4y6gbzTDAV5+so7O77AM/cqfXn/ffJfxrJl4UTHtV4EIpHVEeMj4hWIo54g8nb7
         7cu15SpTE6EqqJ8Zo3qemoP0RT76Ly+zE5xCPkYtvu+GBpABlEmQuRIyI2MeJhn8NnDx
         zFxeHbPMx7+XuK/jHoz+nDvGSPMsTJScdNMUJz2dYL2Bi1PZvljZhATCvzIh8N7QF2RT
         DWZ0K6FY2wDORlhUIu2rIewi+8rYaVRAhuSCYWBo4u9jXsfn2UUqeumyL0OzKg7H7DD2
         0BEKsDwJUsT4j/+bpmL6Xf4T3aJk5ug5dyHkMcGc8LhDOscmHG/WFuhqov3PQnHL7Dtp
         xeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760929627; x=1761534427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdEInNnnI8mUaV9oHcjuBVGjC97eLQH2pPXt+cVP+WI=;
        b=Gzv8TNpHVss5OtZLyKMOPGd0n5tzcvtr6t6laa8J/B5DG7hu2UIMrmJui1DRA6fMDK
         RXvZpgCVGLUmioUFy4j4kwacvW+wfbgTvn6Heb85IDe/+HuZhxKOhgPqxF8IcoTuB6qA
         RxQT8ep7cKSZaucZ4IaMvqFEGPsYvylBeUdex3tzCqZiKK0K0upPH2QaMuQMlcUxu1cq
         yD3Ycx9yfj1UZRsMkUd1XgB4X/7+pg8Bz4uYz7F+XQHqmo7sFRjjhDmNyQoitpf60xDF
         qH9e68l+CrjIzf1mhTSPp7snhGB4Vk7LAaRbS28ztqekVAlXtM6nzZREmzlgVO2mbAH/
         e5NA==
X-Forwarded-Encrypted: i=1; AJvYcCX5PA9LAWpZbbFt3qSxrGiAB5RL+3qHe7+1L1inD2WoWoANXj2rEerJbJcZkh+A3pR2/BXuPV9sY2k9EdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/U0VGB71bhmRDFiEP7TMEZJgAIjhuBpBDF39kU+fz5cOaH70r
	vxh+9mwp3kzWi3z0qCp7l6CDwmehcwhjoagnz0Zcm/d0HUDva8uEfkPb
X-Gm-Gg: ASbGncu3lEDa9PKfs3SoLH2UxmiSFnAzft0NLsjjg/bdWB2WY1fheifNQl0dfrg9F4H
	YgvdsvYaDNOl5W93JnuBivO1tZItH8Z+zxnRbxaT9TAKzmL1fUcBX7qzGHQSObLwCUWV6IXDwUK
	TdGX/sGCawHduPOa6rw6XmZU62EUvsW1MvS9ZO9Ex9SEm9/XWPRyXOgdxoRDJrY7Fz4D738afIo
	7Vx1m/oXPxR6G8Qly9iJMzE8BD4iZu1sM9ODkT1RkCsuwaWljdise5pHqjv2pyxMfRBzmqEkB/G
	11mF/TN7eFUDKdEd6zxaiRZervUMen6/D2NNviGtcJomNJLLCMUj7ngKgaReMTdFdaIPuY+x2nt
	ZhRtEldmFzUWbVdkWCBqhBFRQScMaiK4nzHKGtVL8UrRM8FDJGqhuwk43Q6EiZ4ltIFvD02E+O/
	P2
X-Google-Smtp-Source: AGHT+IHzTVc3sIuoUUpDNIz4MDhtAuQXWOAHI2hiEQDwV1qeN2gWXxdUl9PvarxzCGNo6SLdmYdZOw==
X-Received: by 2002:a17:907:c786:b0:b4f:6d1c:6f4d with SMTP id a640c23a62f3a-b6051dc37f8mr1718239766b.5.1760929627290;
        Sun, 19 Oct 2025 20:07:07 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da25c9sm668375866b.11.2025.10.19.20.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 20:07:06 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v8 2/2] i2c: pcf8584: Make pcf_doAddress() function void
Date: Mon, 20 Oct 2025 06:06:07 +0300
Message-ID: <20251020030607.10219-3-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020030607.10219-1-chiru.cezar.89@gmail.com>
References: <20251020030607.10219-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change pcf_doAddress() function's type from int to void as it is always
returns 0. This way there is no need for extra assignment and extra checks
when the function is called.
Remove assignment of pcf_doAddress() and replace it with a simple function
call.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index d1b0e55fd871..7e4a6d19494b 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -253,7 +253,7 @@ static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
 }


-static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
+static void pcf_doAddress(struct i2c_algo_pcf_data *adap,
 			 struct i2c_msg *msg)
 {
 	unsigned char addr = i2c_8bit_addr_from_msg(msg);
@@ -261,8 +261,6 @@ static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
 	if (msg->flags & I2C_M_REV_DIR_ADDR)
 		addr ^= 1;
 	i2c_outb(adap, addr);
-
-	return 0;
 }

 static int pcf_xfer(struct i2c_adapter *i2c_adap,
@@ -288,7 +286,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		int ret;

 		pmsg = &msgs[i];
-		ret = pcf_doAddress(adap, pmsg);
+		pcf_doAddress(adap, pmsg);

 		/* Send START */
 		if (i == 0)
--
2.43.0


