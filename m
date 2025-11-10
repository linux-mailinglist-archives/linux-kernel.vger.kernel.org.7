Return-Path: <linux-kernel+bounces-893551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A1AC47A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50F85349E32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776D274B4A;
	Mon, 10 Nov 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="D1Goflo9"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8069153BD9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789714; cv=none; b=ZMTkpJIhhH5Lz79I4WW3VQtEyNUoS2/M9fdU8DAdaR5ENhtN5SGYRut65V+uEd0yIBKTPZAmeGx9ACyqFXU+Hh9hA0/SsFQgK2vgoN97YvrapwDz13RSSHnRZ4KPLyjFDLwT7q+JXa6aZQ04j6h+BQOblHYwNivqwPdu2cpBw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789714; c=relaxed/simple;
	bh=oclVIPwu+uT0JYbrNNdVGXO/Snxkslu/wcLttJWhJXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzik52Q5fG2sbkBj/LGb8NICJ1I5tEoAM6onYzn/wTR4RIwQM8UEY40zpLGXVs7foIafWDlE+NvQEXSiXGESICmkx7HnIM/AsG17QxNAV3PGyLQnCqEQfh0m6ysDJoDVspvPUKCmLO56XH2O5n4OqNSKohSeFPF/0Hq0aMUtx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=D1Goflo9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1316844b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1762789711; x=1763394511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxG8U113OCt23H5vQ5qb7boZb0Fnj6MtbM9jk8M6/fE=;
        b=D1Goflo9tHH2Z83nxCRDoenDV7ekPDm+AGdob2FDG0pmjobLSooY2XTNvL5UUnOph/
         VapQ3mKn4MT+DAVSnjTn5p9Ou4p8XJjD1U0RFjvoBZIPQuLKL8Di4BAShGwA5uIJ6UnW
         rb1pgEhChLqlOvajltF+cZESUBvjLNOsf6UMkE0qVtRLeT/2fvUP1qjcUtGLmAPetox6
         5Ppo5bOHG/enIfKB+jo4Q/ZhXzgG7LcnrIE6wtS35BgMabQ95Hq3fz+3X8CywQvl/iWR
         T5xLuH+gcYb3F/Vuhj1g9pi2OV8UZdu/NUJ6XWedFLIuMuZJPhe58+oknxKgdLjFfEsS
         BF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789711; x=1763394511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxG8U113OCt23H5vQ5qb7boZb0Fnj6MtbM9jk8M6/fE=;
        b=bIlLIVWoj5NNjKYR9Fp0bRR8ZGGETkwFuLO0ECh0oBFji4C2GNifh+t9CWUPh2XSyE
         TrEwszsbcm9RXoDVPGw1upHXwiSFx5n03STNxiYQ/kzaOmCJGdLqdy6ZHh3VuZHouQKI
         0HV5c1Gn4XKJMmJYA+c5UVnkIM0JGJvsQS/gn6CLVxk/ddD8O40f6EhfHjkcn5MhyPs5
         psElJSIOeTQxu1vZ/40JV4tvkx9WF70e0rW9riNV4Vkjb7DYMfxHYZhTcx7eCLnmBBg1
         vYHyZMgxGgfNkkPA3+bpPlwEBHI9f/8OXsRlmVKGR86rcpz0BLNmJfQM7924yGmLLdQu
         /tGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVExFNrpmDm+1QI+KLngkehiwPA/+6isa2xP/K+GEpEhYIjLtrMbhsH4tKLH4Scb5T853DZ8ggT7aBKORQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5W730CqSF9ZRS+5AcgBfr+i9yZV2E3NYfotTNEyFDYkfWhcn0
	QRG43O3d7ze4ExV29BHl+4sH1E8VBGYV79r3IfCIj/GrfsJEajmgp4yVMmwiOU7pU7A=
X-Gm-Gg: ASbGncsF0YxbnZ/bOxj5FnmtfAh9m62PKkjQDvSYam4aFVeC7FVfR86ATWDPS0QNetU
	N+6JGYACHVgWMKAvBXIh6QyKkAPgmsKvQU627QjZvbW964hWeNHcMetX2sd9krRpP5avxfRsgHB
	ELU3QIFHf6vP78k2a4V1sEdfWxK2Cy/m92kYZq/gy1cBzDnKkkXzdIu1bIA6C6ze68ZryaaJCyx
	vneVxeVMds8RnjDUXibguATwdUAmPAp3ZShrX6FrMjlXo9AIvWhxid8YHN2E9fn+ZT/Ey3dFWuQ
	VBLoegXfvamxnKgEo1UnBaUYbLVPTGIcCpxU/fK7ku2C2oIlhXBqTaVF0DiQT7cfYCjkRHZMp3m
	JZEifgt1ZrLF0skrYjVpFmr5wuTfKRx70PrOlcpTNrrDPeAl49MwNphYG2Y9c9oRe6p51JVHgl5
	0aavsKDspq/BEFeQ==
X-Google-Smtp-Source: AGHT+IGX0/sQPJZ9IFWURUjUR6+qkfpN6BmZpg4nLetcbOD7FksfDUtQyFd6hLj0vw2F7Br4vT6eeg==
X-Received: by 2002:a05:6a00:2e25:b0:7ab:78be:3212 with SMTP id d2e1a72fcca58-7b2266a90abmr10078556b3a.19.1762789710801;
        Mon, 10 Nov 2025 07:48:30 -0800 (PST)
Received: from localhost.localdomain ([49.37.219.248])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7b0ccc59de7sm12151593b3a.65.2025.11.10.07.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:48:30 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: zack.rusin@broadcom.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	bcm-kernel-feedback-list@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix potential memory leak in vmw_fifo_create()
Date: Mon, 10 Nov 2025 21:18:09 +0530
Message-ID: <20251110154812.85766-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for fifo and fifo->static_buffer is not freed on
one of the error paths. Fix that by freeing them.

Fixes: c451af78f301 ("drm/vmwgfx: Fail to initialize on broken configs")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Found using static analysis.

 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
index 8fe02131a6c4..a9fbdfd3a718 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
@@ -150,6 +150,8 @@ struct vmw_fifo_state *vmw_fifo_create(struct vmw_private *dev_priv)
 	if (unlikely(min >= max)) {
 		drm_warn(&dev_priv->drm,
 			 "FIFO memory is not usable. Driver failed to initialize.");
+		vfree(fifo->static_buffer);
+		kfree(fifo);
 		return ERR_PTR(-ENXIO);
 	}
 
-- 
2.43.0


