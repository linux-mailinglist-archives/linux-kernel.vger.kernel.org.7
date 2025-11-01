Return-Path: <linux-kernel+bounces-881150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 859DEC27912
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7B364E2FAD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E3299943;
	Sat,  1 Nov 2025 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMKSY5ug"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CB635
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761982804; cv=none; b=UOxcFuiwFSvsdMTpYhhxrbzqyr6V3W/78c9rKhvPok2fZg2dvNE2bfozZNvRSid+7MgWn6aq8oTei6ClG5Yyqf5ckSM0Z3LOcvz6NhIjCu8LRp3KP4w4y1ezLdCtuZiRUdSAx7HAaR9Ekr1G+xcMwsMUN7DZjJssQZz0+xZ4ma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761982804; c=relaxed/simple;
	bh=tbIlqcUdt4K/0Wbd5er6IiYuRxDgb3ky4LwFPVHhFaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEjqpMNfwkVGqMdJEUd5caLdrpFdVodCRYMfdudbvmUpD7KZaRJ5WusfhOyEHPiB3YZ7WQH/MnwzUsinvbgqDsKSqbHZusSEhsZryYizoOOvkyNbjpA+Hxb5GFQo1P81RIz7InpnkMoeJQAn9obPGHcghrcrQymiYeRGc7QDB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMKSY5ug; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-594259bc5f1so83811e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761982800; x=1762587600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ikyUkEuAIUj+HxEe8beF0cjcpPgN6wIzeDAnASkpDU=;
        b=IMKSY5ugnmrD73LSV64gY27jlbjvzWEA291ZKelmvzgJx3O1slkueqnjZ3IXE1KIRl
         ugGoSNZPpSfMQW/Fhq/9amLbc8mdMMJe54pLdmxVU1kpvfCkWS6jZBRZGl3Tcl0U5jc6
         qLmEU+H2EeAFeWtfYqTwju0nfwEfRWAj5MDHVV5aKBz0/9sL7ecRZO95muiGwAbFWG+d
         sP3rz4fuVm/NqIyHevN41PC25O2SSDTgwL6qdEqJdIxBCuaPxjIV0Y1p4kICtLX3UUWM
         a3CJrAhTVZa0BhscmRejEp9CT/mYFX/Y9JSlcLQP5xK8n3zGesp7dQTRND8OycZM/7HF
         OMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761982800; x=1762587600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ikyUkEuAIUj+HxEe8beF0cjcpPgN6wIzeDAnASkpDU=;
        b=Go5IqSYDOxpoS9UjD0SvkCB03KPoftNoisBGPQbuVqqO7BdCRa+33ooMkAq178/V5N
         CUS2cWejJ3qxMY1nZQsHF/fvvcIs4m+S3DdBVgb06Jm+sJ4/oeMtEvydIMLrg6UXsFEn
         oucs3B7vaqbuSa4nQVC632zKd3/HUrqXoyV0TFIJuqrHZ67iMvz+i2m4TTT7ZQmiocwr
         H5mVNzEFG4teQl2YLhBRH93YuMFOS8TNsh+KcvOXbcpFu1/UKuS3wvLVzGmewnTjAwAS
         TAibOkoEFBFFaDl57HR5ZzQ+Vl0xGQpdLPn949tQDdSS4DGbqI4430yAvO0pvTmI51XF
         meGw==
X-Gm-Message-State: AOJu0Yztqd/7n1nq/kWk4v7AfdgQrPwo3TChhjyV5fTVg/a5RkMPpykf
	ci4LhRBA9sCvtSLcr6IZHZjhoh+YvURNmlPKcvVnmrQHmPXuJsgqHD0sVv5pNMJu
X-Gm-Gg: ASbGncuq3Pxapq5fN8eezWU3NghW3HeZmw2fUIubSZO1yIGzoNGkrrUHpgI15pKut6Q
	MV6D80fT9nQlPibDAdtGurv392EO1Ip37fMPVYtJR/POxdLu+N76Lq9DAq9CzIk0JoBKFQoiC+J
	8NNx4wbUvDf37OyrDjNM45oBVEKW+FLDnXtHQ2df3jrelmHTjfasdHjc9cvJLFmxE+f76k9azNV
	A3D9avTmHSq3nE6tDYUjuKeDXrV1nOWv+0o1x8vXNVsSKH5z0RG/nRl/VUnvrsJje1dHdz6ARCn
	+vO7XK2nKjcosOhr4RV306Cu+hpb5JsBGdOcZ+HFAciRHcnGk8XH4WF8opmzCq/e1F2goim4I2e
	1bwjRno6nvNjDM3Y0E13qXgVXy0nFLJgCvttDmuS5BGx1uEjLx7Kn2w3ab4IRfzHmB0mWZEGzpn
	ZuUs5fS2T0GYAP+Q==
X-Google-Smtp-Source: AGHT+IHN/5VDAdZXqmFc5ov7KuGopsx6LXHRlLfyCwafkNk7BiC7MNslpi5Fa8UA5JAzhq9ExUaIkQ==
X-Received: by 2002:ac2:4e12:0:b0:592:f4e8:71fe with SMTP id 2adb3069b0e04-5941d50cd51mr2386650e87.9.1761982799435;
        Sat, 01 Nov 2025 00:39:59 -0700 (PDT)
Received: from archlinux ([109.234.28.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc07fsm1063222e87.89.2025.11.01.00.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 00:39:58 -0700 (PDT)
From: zntsproj <vacacax16@gmail.com>
X-Google-Original-From: zntsproj <vseokaktusah7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: greybus-dev@lists.linaro.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH v2] Fix tiny typo in firmware-management docs
Date: Sat,  1 Nov 2025 10:39:40 +0300
Message-ID: <20251101073940.10740-1-vseokaktusah7@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 .../staging/greybus/Documentation/firmware/firmware-management  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/Documentation/firmware/firmware-management b/drivers/staging/greybus/Documentation/firmware/firmware-management
index 7918257e5..393455557 100644
--- a/drivers/staging/greybus/Documentation/firmware/firmware-management
+++ b/drivers/staging/greybus/Documentation/firmware/firmware-management
@@ -193,7 +193,7 @@ Identifying the Character Device
 
 There can be multiple devices present in /dev/ directory with name
 gb-authenticate-N and user first needs to identify the character device used for
-authentication a of particular interface.
+authentication of a particular interface.
 
 The Authentication core creates a device of class 'gb_authenticate', which shall
 be used by the user to identify the right character device for it. The class
-- 
2.51.2


