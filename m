Return-Path: <linux-kernel+bounces-754820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB03B19D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CB43BB9C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E623D2B4;
	Mon,  4 Aug 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ska+oRYq"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919DD2F2D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294398; cv=none; b=YfWHvRHvsBw2hpSRcVpwzFsqy2SU4LPOl26OtmhCnK+KxeoH92wJrIOKEB8O1c/zvr0exY+sLYsbD77zmB4DaI/L6lhlBC9I0GACPG8JCDHnVAs3HV4eUMWPTKL0XqH6Z4EpXcPjkYH6oa046TMZg+8sOb6nmFp00e25nFyyTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294398; c=relaxed/simple;
	bh=PA4Fi04XcbSSqBINhdlmikgc3t57oLyEd+cfx15ng2M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Uq/creQG1RIrcprd+wd+DyY2T5mtR15yZQ8BxGRn9fc583eu+mUDM/NbkaWGl03GEaLZ56a/4E/Jko3LaGilkpUAeasVKS+PefFMOrF5ruZDAelc1UTOsdrk9cdrMvY8cb0oMHPqDdXusN7APNOUmoWYcZ/cTXy4EcRBZB1OTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ska+oRYq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so3184168a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754294396; x=1754899196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2j21EdQ9+BzhX5K3jWbsgABY3uftB7nrDoPZVb6R/s=;
        b=Ska+oRYqkvg6Lxyp2CVBce2ttgdWYAVT4BwJBQBIxr9h3ztmNjhn4G5TjIWR7PKPDb
         ydIFjvpR4IR5lAxV4bQQMPV3bgBg8zR4oOnNTm3e3BD0gMojGGW3EMLRQahrwA6rqLDI
         F+KAuUrnX1lXKl3/T2hhfp2l5K0DpRQYA8Gj0JKDZEWFSVBm583A7xAjMQGTCXKMnn1r
         8Cte5cai7+9NIW6acZb394Q26cLzft2/5Py25kh/A2ZLjMWXm2zxhXRh+92f8JcbFu9v
         TsT7rQ9TJPdrxRSadMjWs0MYP5PrgAuHuxGqs0A6EPvsGBnso6KTYEukaX5gxTzgozhq
         bvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754294396; x=1754899196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2j21EdQ9+BzhX5K3jWbsgABY3uftB7nrDoPZVb6R/s=;
        b=q4bi17+AF2Jh53h9gdkKAKcaVkCF3y/PK1JPTM2DkygsaHiAMTs7/iGTgiGEP923jV
         Sw5vam9YLqZqo2R9ewb+1SX0wD4FLS8OL/1VA9AhaAposCbmUFu42JIxOqRIryhOj/MH
         +IcYbuDEAhCTpbla3dwl9ggCmbM0ImVTyzAyxkNolaW1MXsI8JkdLWr5GKdYyxNFzfKA
         BdqWJRCz7Dif35oK15wGae6XlNhvycVXXrccyNft5IQ4Ej/0u2Rc2zm1Lh0phl9mwwci
         FT8AoQ1TQVo3rSKbV8qG4lPJsgvWjGWA5AQA+cdJXu6S7b1StcCF+HIItHO5/+9ni2WO
         yZrw==
X-Forwarded-Encrypted: i=1; AJvYcCU+9Uch7Ndyn991n2eylL5nv1gxpztR7KdcDYVMHX3VyIao6KAVoSw4HM87feb762+HULY8JNxPQB6ra4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77LhHl3xMfNWRASkz7CHd8XszdnUiPBUFqCurhdV5psujJOHl
	tPG4Q3dVSnN4o8nWmjtHqkCms7IwvOg06eMj0NE4b8QL+ZKaIRIY8odn
X-Gm-Gg: ASbGnctsoN+9FKbBaJSpR907nPEgrUfnJYnymfPtya0TgDEaM7DYnWP7NALeNOOL5L+
	O9srHPsBhwgmnA5S/lK3VXhRm3D9Czfuf4EBbN+dgZR6wx4zGdX/zCd38rLKB7Ym978W7pfu/iz
	JvANuTKB+n+X+SikKVlbYsJSWtAHpvlCRNNXpd/uSyUfJ1eRSMicgCctP/0sbAFdm+kWA+DBVAj
	KXvki847mjNwqjpiHGhzksOHbu6xCXUnl6Bh8yXMYK0ACYI6shb3vOax7oX13ErloHJCKap+8CM
	nnS//VIGPUYD1tSi2AcEbDX5bqPPE2vT5fy5EMGKuYWuAyOK6o7HliOoe5TPrk4GRT+ug/Dh/wK
	DIpSX1l6B2IVAymNdN1PWDc+PT8jOXTAvRRc=
X-Google-Smtp-Source: AGHT+IF7alqB/6wZ98S0FEX+bkqM69+K+32EZW07YuWmetJ1TBK03m4jlJehXUkJP0iXJhxQOzaY0g==
X-Received: by 2002:a17:90b:4c4d:b0:321:43b2:4743 with SMTP id 98e67ed59e1d1-32143b248demr1268396a91.23.1754294395745;
        Mon, 04 Aug 2025 00:59:55 -0700 (PDT)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31f63f0ba97sm13749540a91.29.2025.08.04.00.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 00:59:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: virtio_uml: Fix use-after-free after put_device in probe
Date: Mon,  4 Aug 2025 11:59:42 +0400
Message-Id: <20250804075944.3612712-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When register_virtio_device() fails in virtio_uml_probe(),
the code sets vu_dev->registered = 1 even though
the device was not successfully registered.
This can lead to use-after-free or other issues.

Fixes: 04e5b1fb0183 ("um: virtio: Remove device on disconnect")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/um/drivers/virtio_uml.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ad8d78fb1d9a..c402c4cc908a 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1250,8 +1250,10 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&vu_dev->vdev.dev, true);
 
 	rc = register_virtio_device(&vu_dev->vdev);
-	if (rc)
+	if (rc) {
 		put_device(&vu_dev->vdev.dev);
+		return rc;
+	}
 	vu_dev->registered = 1;
 	return rc;
 
-- 
2.25.1


