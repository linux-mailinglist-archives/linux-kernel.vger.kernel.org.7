Return-Path: <linux-kernel+bounces-760130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E957B1E6E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051A43BADD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099525B1C7;
	Fri,  8 Aug 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGZ+NVPb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8823535A;
	Fri,  8 Aug 2025 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650713; cv=none; b=YSRFyu8TaDuAY3y4NIPfXLJOlAEUl4BBblHbx48U67SP/wNfRV6J3nPgct55SvN9wvtaC0Zow9OP9ZodPOOBgnjyLr94SxkDznvk6thioorKiAtyKe5nUiwbrcFakVGl8qgEVkizNThHFsAlQmiuwZPg6aNV+Lao8qC/E4Cb96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650713; c=relaxed/simple;
	bh=YopiqIAAA3cabfm3Wt1fjyPny2SukpHchgZ3pD4S/64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eFZr6KNN5UqFexOj10cB5Ds9YKuz023ed+JVet4vf78CMfGq12ecOWkz2d+vXrXfgjP+4jXB58WiEHBuXrUzWyss2s+kkV3jTLyW813kXNPh//+e59E0oAW7dmTUqjjMmH/51pejsEQAdr2O/070KVx78NbKVFFrqc51ji1eqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGZ+NVPb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so17288895e9.0;
        Fri, 08 Aug 2025 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754650709; x=1755255509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+d6t8XzLh8MzpLApjDXA2yMYEP8+HgsLVFO8WJw3LUE=;
        b=kGZ+NVPbNQf2EJVIoDstF9JERKu0GYi2HxB4f6eTtd79Pf5Nz7Rmmd2Ua2FHhKH+nc
         5XLcDcwwA/KWW8kPCOYQe/gNeMkqb19r9dkqzBwTxP6F4Fj0L+kCh75cex0tl4lp2A+1
         /ofBWtT+HZlXAb6mojc4aTrUGmza96S/MLReQ+1EDZ4pXyv0asTVW9uggwUoCIDRcKeq
         wKGqCHKWUAawuh7mg4v3pRDBNzy5JwWek4dN+nvdoX59JsdroG7hOEN+MT0AwCUDVvDt
         l/61bK4yt1z9G94pYemMcWP60nmzFjBpBG/wq6gz20pC/Sf7IYV5bjRtTgD2Z0FRpr9s
         EOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754650709; x=1755255509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+d6t8XzLh8MzpLApjDXA2yMYEP8+HgsLVFO8WJw3LUE=;
        b=nnK5EYnMNq1go20pWQTe2EUvdCgoMe2aew/6RQZHfZCkjdCj3MBvSdR/RXhqtekZHN
         7O7M7O0EnwVzWwu9aw5Tg+0l2ZpQgM2xCJTqIQYLvIb5Tmkx+zLY0ff1vqQFiqtKxEE0
         G/y8kjBYO6Vn258aTt4rdR7uzveD4ePwfbbYNV6SyalF88jaXrhK3ym7BeEj4uSULKyU
         R0UTjNx9cIv1HUozkcsYW95g4WX/yEsFA4yA0+HKIkuaUlRWKpgYihuoQptuv+J0eM66
         V30Jg/uNhOOMo0vtb8K9hktLiK1xjmyUWswsjOWSsxF1xQ+4MqhjKv7xY/Ngz+L8yDLL
         QHMw==
X-Forwarded-Encrypted: i=1; AJvYcCXs3xZFIL2Q3WTgC4O/4uQWshJwrjZAxUQd7u2M7ZDRyJPTfRPQrCWgqYmlMEmcEFgARV793FM9ExqA8Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpkhtsDCC04pvuMSn1zb2KT2lL0o2kjAX9WAj8z9khqXDhlwsU
	vI4cuIrSx6/zq0LjsPBkGr58hAwIEc+rRsxusnG67dNEGkVa9GKLnlPK
X-Gm-Gg: ASbGncvfJefx113qT+Q7mlGrN2J7eAHs2fncDus/a/vR+smXZa0HNps1JGDHWMLs9/e
	eI9GfxPKVYMcog+uSA3vq3YU9g3Gz9jVbQG9v9iXH8vxey5PyZ9pNlJPQ4yAXhQrnLwePAgX8RD
	qyB/MugCPX8B/P4fSItDjQv1uuAcM6KIH/MoT0+uMcjk6eXRc7W4YX8dZnFwzSiggH6/AVWcyDK
	4K2Qc3zKSEqD6F0dHnXyf/2Xysp+P8Bx7wXG/rQ6JzNrtMkWN5lsCw350FNyCE48rzukZ7l0x0r
	f375c2FOCQsSHn7AZxn/Y3odzJoaIx4SrK6KEmsuMlVW1cagQrktLMBLU9QyybRJhEC46+ZBKPs
	cbakzdiMTQfK8t18G9TJR
X-Google-Smtp-Source: AGHT+IEzE4zbs8Y8E+efTkUJpNYIZAwXwchyLjYwCvGqsPN5J20IQiBX+gs9CsAXsQQxjE5abHkVjQ==
X-Received: by 2002:a05:6000:2c01:b0:3b7:6828:5f71 with SMTP id ffacd0b85a97d-3b900b449dfmr2171522f8f.9.1754650709426;
        Fri, 08 Aug 2025 03:58:29 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e5b84674sm141343945e9.30.2025.08.08.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:58:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Huisong Li <lihuisong@huawei.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: hisilicon: kunpeng_hccs: Fix spelling mistake "decrese" -> "decrease"
Date: Fri,  8 Aug 2025 11:57:51 +0100
Message-ID: <20250808105751.830113-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 65ff45fdcac7..006fec47ea10 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1464,7 +1464,7 @@ static ssize_t dec_lane_of_type_store(struct kobject *kobj, struct kobj_attribut
 		goto out;
 	if (!all_in_idle) {
 		ret = -EBUSY;
-		dev_err(hdev->dev, "please don't decrese lanes on high load with %s, ret = %d.\n",
+		dev_err(hdev->dev, "please don't decrease lanes on high load with %s, ret = %d.\n",
 			hccs_port_type_to_name(hdev, port_type), ret);
 		goto out;
 	}
-- 
2.50.1


