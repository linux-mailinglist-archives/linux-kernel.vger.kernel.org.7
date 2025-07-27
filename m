Return-Path: <linux-kernel+bounces-746968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E732B12DA7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9909E3B9CA9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BAF18C011;
	Sun, 27 Jul 2025 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSOMYAZm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A917DFE7
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583578; cv=none; b=AI5yWHZDSEiRo1b/fQBq708w1q9t20Ptrok8A3c6PwSSjWNWaLJagkrkfRLwdiQgBc5j7dOatibDqsmwzJ3dJzqPh+vUGukSQDELNBz6bscXHmB27jKQmSKtu6aq3424Fk/kAEuosl8+tP5QMOF8IRONmVU6Z4Htjxt+cEC+JXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583578; c=relaxed/simple;
	bh=K8FwAuXl2tAaeaXZjzJyZSNvcAqWgNpGAXne/KMns2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJMNDkFfD7LMqp4le8meO9aZ2O+znn+eKzDb5aBQ2dqhQ2kuUOBN4eXCANy/CLoI+W2dE5C+Wn0a7Mi8rx43zM4WhoaeNLJWI9+M22rTHNKsVTfkkrcy9Od/GRi5zJQFIK1ovv+qsWaKiMn+AphRD3hER0leT9udU6vG40hVqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSOMYAZm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234f17910d8so28834965ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583576; x=1754188376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VfUIrVpEQOM0T5tWbNj1GsfFx23vEuxov+ArCEUUrNA=;
        b=dSOMYAZmhs3eoJd/EW3n5pCi5BHYDVxn8cK4Bszr8+JvpgW7sCAZE9czLEIL7BXLAv
         arKE0Hfwf+TopeKrwUcNosF4bjWDjjtOJHqbLgzLRmqNHCPxjYKL6iFn13zGOlk1rDoY
         uiihCdGys41V7Wb6Aeieq1MYickUtFULkRYmz/I+odJQigrQ4Ebpu4tRTSv+gwAeBBCT
         LiyMSa+GuRA7wJdIQo8NVpUfS5gV0oyswI6APj+j7oZ+W9WcAsj+/btAQcLDr13XPWtA
         dfigK/X0ZlHEfA+2vgynz3J1yPT0isoTJOO4sHvzpkOT3yMpuOLcmSFpjVWeFsT0GJFF
         DGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583576; x=1754188376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfUIrVpEQOM0T5tWbNj1GsfFx23vEuxov+ArCEUUrNA=;
        b=WoVaAsyCH3YfXZs67gp/Zv5dIZXCqy69aI4HLEIkLgkMqVof0NwXeR+VmAzcBNGDlq
         Ds/L+/igeNy5+Nz/YQntCR58btapGOVAbSngN5HpQW8jMptNm1aIx9xIp0F/RXDc7UtO
         6M8wLYYojranvtXu8nKwBDQWN9UHP/OW4R6CFmp9ZTNUVZ97RiqOhW3BsXIFtbXOdoGD
         c83ZQbpAZFQKxG3XiMtgNjUfSorWzvfQI0XaskG7d5xoDiZbLPWwJcTb0GWzoN2Ayw5S
         xJrNsCWGfU1GX7i0dRXI7+05BRDT73NH4C8JvSzLxAT231uT+uQFq6/ZT0ELag9xSmOa
         rGyw==
X-Gm-Message-State: AOJu0YzJ4Yg2DolFQc/wNWh045Vcqy7QWDRHQx+AWJbAcIPqj6nI+eJN
	mtAO/ym5L3ig/dE3OwO+ylxS65TXjS7eypiC8s0gOJBhiBLxXaPWDCRsC6pSjGv6
X-Gm-Gg: ASbGncsbrqpr1Ii4ansdxrXmcHF8A4d1VxuF1hmWbvcRGie1XtkClWdfgzedFB0O6xN
	cYhGHFIRqY0iqqf3J9YfAOb+TE8Z37yn+wUpgqzgGRYpwR+N0QvVXsKnYtostsOmJr6629rNmtx
	ndw3+o50eaCOEQeONFUqw/jylOSIAFcKnED8LRCuvkjxKY4SFJkYDGRzTkhI15OKdMdj3/w0l1l
	gnYcEShrMQbsiTsUeZ07B/wFFs3WXC1mfuPX/gE7peA5m4TBudipXP0YJQtSRzoChFONFTqn766
	SQehxvsmTIqU3yt4tme10F+Q3FHaAqhz+eyY3Pt8DqskxIteXC9Irw5wIUrbWznPhaPig6bCRpA
	CON6JSRVEsq12yshNC+7+sJ6Cq6Ti6yrUPfHYr1erfuwdN6ETkjNDSjSq
X-Google-Smtp-Source: AGHT+IEDhzntauaNsMBdnuocNrYwEbJMEzy+B4dX0o4WevzNLBbQBo49LuGoyAjTxnKdAgjwn4Qs/A==
X-Received: by 2002:a17:902:e80b:b0:23d:fa9a:80ac with SMTP id d9443c01a7336-23fb301007emr111890605ad.16.1753583576325;
        Sat, 26 Jul 2025 19:32:56 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24009cb36d5sm2276745ad.203.2025.07.26.19.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:32:55 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] fs/dlm: Fix typo 'definate' -> 'definite'
Date: Sat, 26 Jul 2025 22:33:00 -0400
Message-ID: <20250727023300.82885-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 fs/dlm/lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6dd3a524c..d5fa498c3 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2305,7 +2305,7 @@ static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
 	 * 6-5: But the default algorithm for deciding whether to grant or
 	 * queue conversion requests does not by itself guarantee that such
 	 * requests are serviced on a "first come first serve" basis.  This, in
-	 * turn, can lead to a phenomenon known as "indefinate postponement".
+	 * turn, can lead to a phenomenon known as "indefinite postponement".
 	 *
 	 * 6-7: This issue is dealt with by using the optional QUECVT flag with
 	 * the system service employed to request a lock conversion.  This flag
-- 
2.50.1


