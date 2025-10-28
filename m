Return-Path: <linux-kernel+bounces-873112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA2C13234
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AFB1A68043
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0662B2BDC33;
	Tue, 28 Oct 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8XoV0Ng"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057C285CBC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632822; cv=none; b=YiJYtxNsxw16moOH0fcj0MEVt/0sfh/jmKc0Jy3JfaxIvevG4/4QjJujv1HJ8gTy7MiAMV8N8Z33Hii+9xVrvHYnTKpQWup7VzZcPICsfQTuGHhCdpOZ/GxNr8br04V3bxCYOWM5IC0YqULOH6sla7owWRtdhmTiRc02pbCuUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632822; c=relaxed/simple;
	bh=4ypjvRC0xHu19Jpd1GKnjwPsnkIyQXnxSORET/7XTqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqtSebYGvxNofP0K/rQniznU6FLDj8SWJYc9d9MGIxwJEBS0D45Pl/83PKlJ9O2kbPYICi0cvcnopHk9i4iacVJPZCRSxZmxS/2IzBZsu+USYlfnIE7LltVlZqQaEPGLrVNIM+TBpNGhydggQG/jQxZ/oGdCDC7kRywdvRrA9vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8XoV0Ng; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so5384095b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761632819; x=1762237619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gIFG7SISg1BvV10VAwPSSQgpAOVoBb9U2Xlupg6IcxY=;
        b=m8XoV0NgKa800qfd3y/+HWcUix3wM7Erx8wSYBUXBnWvKOsnf5hFsB7W8UqDOhR6W5
         8p4xEVE2TAeah+xd9jNJHpCdheGLW7EXdE1XiDS72CS9RgrO68rWAFvcKTZ4Bd/a/ks7
         TOpZ7736ZqqoSdIBPNipnBSr7YGhLVeWrU2iug+iv09FO3aXVSeCSfBEArMGGPDJz1K9
         XI5d+3v24mZnVM+GQQ1Bqg6jp98AVpF1HQ7HdogSgXM4SEHrr1ZLlq5Ug8TIxAA0/+8s
         E46e5WCNd+3BGS+E0EpPu8qFuI+ZDhfE2yYaBnmKnYbBljS2DCRWIzlW6JFgS+PL+Lh6
         QBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632819; x=1762237619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIFG7SISg1BvV10VAwPSSQgpAOVoBb9U2Xlupg6IcxY=;
        b=cjhlInyxhL69N/t7NQy7KXtrPjGkwKKU99LfhqCP3B1oYhbTsY7GEv+sZfbM72FaFK
         jHFzLazTmgppLiz0/8myiurmgQE2xH+Fso1vQrUEp8N20wdPkZAqviD3mjvHD6hfwMsO
         LA+Kl/gFIdFJoXZ4w8x4mhywHm/lAqsiG7kEKcVngMGO6JMR47tBNI0HpI7kqWBif2Q9
         hU0eKZqMErHnUY41/OQOJM+vlCia9Ud0nL20sPIYEGWbyeiKoCJ7NrvwRRCmBQrgufj5
         +gazUooWMLLh7IWep0Q2kz7zGLY/KcaKFn8cyzpzypbMQ33EOwuG3ptJPjxtEP/wCw24
         YQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrwgakWXfEOQPSvVSefWKUPCF7KcXXD/qGvccSRGYyu5XlSaRO/4VQXLaktv2fps/r4tfjR+NIwn2nRZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBv0aB3SSz1ksHCpAlYPBc6Al/zPfaFsCj5f89H+elSRjfnVmd
	6dp/w6KfJtCzGYWYkuI1N/WSJRepRpdKmobqUJwa1Ej3ajQ12XCNbPu3
X-Gm-Gg: ASbGncswlh0/+1qoupjijU972LuWtFO3ECKAxbjuIV94QdMq3bkfde4KYtC9CV/mFMH
	fHH18yE+RM3xEOh4oHbefHGDLI1HtJHD25dyMfPtGoc0+yEnCNYGzdQTKOkpsPimv9cMHO/BGOd
	TVeVy4nYX5i4Qx8KCKM5tM5+GRXwcRnQobZrSISEM5DpWYlQ04guHF77q54oa+0soOx60oPXcqn
	nhwwAidBIBElMuvnYjm1Yp6WQpG6Agp6bKbA8gZoCtV4NgyGMOsgf4hGSWjrV4TVkvu7SmSpQmk
	FmFVIxYxYvXJ000SDFO6ecAjdHx6t2DMg7OAad1vRmaFnnHw32keAQewQdn8pILmNgv5V1bWqkW
	NW9VstmaLJEgG6MInFwmHKr3BrbFAm0uiGxd+22q+7qVaOkt9lPycLXTdleSDgmk4Z2Ijgtjexg
	sApQqNhaLxMsJazvmqclnx1gIl9ZDm5vG2Fe4PGNnpjjcC5/s/Kx+pJlB3frSgOJpqnYyD2TY5E
	E6pixjc4AXmQ7Q=
X-Google-Smtp-Source: AGHT+IG/a6FlMLcmPODeVXqDq8p6icNpYlyWYcTFguHnLLVnGyybZ55aGvHzqPtQk3RDx0yn6bP7aA==
X-Received: by 2002:a05:6a00:6fd9:b0:7a1:6124:c470 with SMTP id d2e1a72fcca58-7a442e40712mr1809915b3a.8.1761632819336;
        Mon, 27 Oct 2025 23:26:59 -0700 (PDT)
Received: from opensource206.. ([106.222.235.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087587sm10293217b3a.58.2025.10.27.23.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:26:59 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: mchehab@kernel.org,
	hverkuil@kernel.org,
	ribalda@chromium.org,
	laurent.pinchart@ideasonboard.com,
	hansg@kernel.org,
	yunkec@google.com,
	sakari.ailus@linux.intel.com,
	james.cowgill@blaize.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] media: v4l2-ctrls: set AV1 sequence flags for testing
Date: Tue, 28 Oct 2025 11:56:23 +0530
Message-ID: <20251028062623.12700-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize additional AV1 sequence parameters in std_init_compound()
to make the default AV1 sequence control compatible with compliance
and userspace testing tools.

Specifically, set:
 - enable both SUBSAMPLING_X and SUBSAMPLING_Y flags

These defaults help ensure that V4L2_CID_AV1_SEQUENCE behaves
consistently during validation and v4l2-compliance tests.

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index fa03341588e4..8809912797d2 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -160,7 +160,13 @@ static void std_init_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 		break;
 	case V4L2_CTRL_TYPE_AV1_SEQUENCE:
 		p_av1_sequence = p;
+		/*
+		 *setting below parameters to make AV1 sequence compatible
+		 *for the testing
+		 */
 		p_av1_sequence->bit_depth = 8;
+		p_av1_sequence->flags |= V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X |
+			V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y;
 		break;
 	case V4L2_CTRL_TYPE_FWHT_PARAMS:
 		p_fwht_params = p;
-- 
2.43.0


