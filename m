Return-Path: <linux-kernel+bounces-823899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825D1B87B01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477C81C24BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E3F246BB6;
	Fri, 19 Sep 2025 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnkUIm6a"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7950239E6F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247896; cv=none; b=LiMZ2kuvPAd0K9DSJDw4nRBsnBADnE4tDWSlDzIgtOc9dsICI/EocAkVjx4uT1eOkXuzOCoMwMV5TiK2cJCGwM6qWRqA8fmTgGR3HsHtLJyo2PG+87UGBFcs0cF2Zh+F2fBgSFBAUZm35xFaHCRLRyBmM8oPOxiN974WH1XT3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247896; c=relaxed/simple;
	bh=ziXcd/mGn2ry+d/Ov28rbQ3Z8WS0immtLzwgvpIlto0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMnCqmck3Nt5+XaAgQOSm+4hmQfFMFi5FbRdWmZHEZ+xav1asTiGf+g5/5Ex3MXD4ItIf1kiTW5Zy+ivaf+JQtSeLc1DegpyzmbLhUkL6+3WQS1cTn6Z8AjtV7O8ns5a0XQf+cqWcytAtYFTvUhECA1/MKsuMUenjyMTYEien+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnkUIm6a; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5516255bedso433081a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758247894; x=1758852694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZzkp8nCuA3tTuaf6Pt6AXsPGQNEt3CNxtrSQfVvzGo=;
        b=RnkUIm6aoS5bTEJdbZVIq91ZN9KEsN1bIt4Bf1Y4+j4OmXDYuEdYfmf5DTXf7sJPT0
         xN3lGH3WXJQ59LC01wsLdM2oIOWMBE5TvPI1CgfPyRRQy1gp+KU+xThDtgQzhbxS6v6x
         Y3MovN39rpu+jcHzw2rXM0yVG2iBSt6LYtaHyhXUKrLKQ1YJK+3VFYNf68HwoIy+G+go
         Cn00Hlc2upxJ8EMHe11nJq2TAYchXqdNLaakBd+IrKj3E8dkR7tuC8jxEH0LFiqj/V7g
         Y75ZbOzl8uZcY/fw4zuNhULI4OiUEZjoioMDu7QEULWXDbcej/VCOEicv4iBa1U18NXS
         Y1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758247894; x=1758852694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZzkp8nCuA3tTuaf6Pt6AXsPGQNEt3CNxtrSQfVvzGo=;
        b=DMHbGD8sMQEMpF+ZMe4TRo9cv0UAaRaZXLIlLqyTM/mGFqx9CiVm4Wvy+LYEHyPDmh
         HxQLoJYsiQSCblHIl0eQ1SJ2cySMb3yMq6P+uM4/DXQPxhPjotRBifLmTRfv6yeyFX4O
         mBxtT7k2NBoXvXHVrXbW0DQLNUlm/NJLk0rpvK6cvExdBVLOealWmvuw+YEK9daqAz6m
         uqjMKokwu+iNT4/tW62kYvGgaDtcD4LtDifNt038vg5eji1Sn0fhXLV+9AIn4K53GJE0
         dk3VlvbMAT5sr+9WTSKWKHWt8jL8VagqAfB3pBlM6YdHaACHPX1BzLjJ5TMLZn1E6jbO
         sIZA==
X-Forwarded-Encrypted: i=1; AJvYcCWzF0nNEkJoS122eM/XZNw1QjYWbGimlqi1JHEHJ/s29SuXv5dFfGXXKRWIHLL7GKcYq/m24ZjG2dP36h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdn0VzOyRV8zPRK1F9Ddrt5Md4hCxmxboZPTp2dwAxxGd+dQI
	fogwJ43I70IIS4JCiLSpWvfqzfaHFS/99lPD2tIDevGgmytKjCnWZU/3
X-Gm-Gg: ASbGnctsTA2QuRCQNVNffItFApqak1tvAfgkQ4NEdMEhwEPyTJt1Tm2N2g+pW2V2Pme
	CeJG0ghdqD1EkG+wbJxIo//zJ+llQNFR5EeCXm4OuOzWYBX/73IifNqt+8YZ1+jcgHUxDrwJ3o3
	stDznCvpFlLHmJeU3XnT6lq/kjIfLghFIMF8BUnHTITZ+Y+AYHOT5Ilu4tJ3al/DmjtArZ9apIq
	lbgG828ydHZtIfFZ2b4v9qJhgyRayUHYTiztOPYMoGatYfou9jnCEHFZ0Nct/4qRPr1gzmCg0Tp
	e9V6yl7M+9gELsR8QZIa2JTLY0u1LhTRxJPdonz7cKJr8oztHUSYdw9HMr9GKg3pvzdgDj/HuSM
	GdrV8rcS0c2yt/OFZcOeAUqAM
X-Google-Smtp-Source: AGHT+IFai2xzlAnilWh4m4u+vIgxxJ3TsFPhkwgF6XAkrIfE2ErA7mqnopPzZJz605+TwLFG1Fausw==
X-Received: by 2002:a17:902:dad1:b0:267:d772:f845 with SMTP id d9443c01a7336-269ba55f8f5mr26364635ad.52.1758247894071;
        Thu, 18 Sep 2025 19:11:34 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:23e9:7ba2:72c2:e926])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802fdfdfsm38785405ad.102.2025.09.18.19.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:11:33 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: HighPoint Linux Team <linux@highpoint-tech.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: hptiop: Add check for device-provided context pointer in ITL callback
Date: Fri, 19 Sep 2025 10:11:04 +0800
Message-ID: <20250919021104.3726271-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An untrusted device may return a NULL context pointer in the request
header. hptiop_iop_request_callback_itl() dereferences that pointer
unconditionally to write result fields and to invoke arg->done(), which
can cause a NULL pointer dereference.

Add a NULL check for the reconstructed context pointer. If it is NULL,
acknowledge the request by writing the tag to the outbound queue and
return early.

Fixes: ede1e6f8b432 ("[SCSI] hptiop: HighPoint RocketRAID 3xxx controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/hptiop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index 21f1d9871a33..2b29cd83ce5e 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -812,6 +812,11 @@ static void hptiop_iop_request_callback_itl(struct hptiop_hba *hba, u32 tag)
 		(readl(&req->context) |
 			((u64)readl(&req->context_hi32)<<32));
 
+	if (!arg) {
+		writel(tag, &hba->u.itl.iop->outbound_queue);
+		return;
+	}
+
 	if (readl(&req->result) == IOP_RESULT_SUCCESS) {
 		arg->result = HPT_IOCTL_RESULT_OK;
 
-- 
2.43.0


