Return-Path: <linux-kernel+bounces-790973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AF0B3B088
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B563568416E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369D20D51C;
	Fri, 29 Aug 2025 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5MOuRSx"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB081FBE80
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756431066; cv=none; b=rjCNu+Io8UzPAaMU2E/gFWdcz1EbaebSng29/S+Oce7CAJZf9eC4HnzZiEzCHPQNspTkhPNxzovQmOzc13+d2ygOPvj0JdmeXSU9IKKwKmGgG7AGeVuyAzqVsuGmK2BSM6H5cE/zOPD4ig1pTPLfnDfXbJc9unSg4mN8YYVekzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756431066; c=relaxed/simple;
	bh=pKt+r5DpAI7p4BPFjwN9v/Y+1a84jf9NTgvzR3HT8YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfRg3s2uQ3ioA9ZYjXqUo94zUkBEyDmp5uGWUaoQ8JCe4NAn6BARDJcR+NzaxI9nL+mSw9wkFcdeezo3dENJ9IluADcDSoM6ieSKAqyNfIGxHTrIAPLzOMKF/bm78n74AHmR+/qTfArn0oVZRuZp2P6kNPe6aUu1ZRt6iBdz1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5MOuRSx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-327aa47c928so1241178a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756431064; x=1757035864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/9pMLAzp+OJLv9QfGuHa4wnCkokVIs0cn0/wGFQPEU=;
        b=m5MOuRSxM0h7p2QEQamgwRq+Gfc8WHk6jtliXaKoE+76/hKtTms/dLbs+Y2JniAA/C
         xXncz98ekD/nlRmhwXrSflwGehsP+TQGRNC2ANK22ON7jms0dlfmk0p+wdFDbVRYMN21
         3u3uogvAzTkSfveh8Foj0Jwbo+rWnR4pFt7UMfN03Gb/dSXw5+2zGz21kmORPJgK7sKh
         EGZ0lZHkcMFbm7e2qMmfw1Mv5IO4XuR2colFkQSIQI9EqUyk4rFNUenh09ugYEhRnqu5
         hlTo0cyiPC/jN3zTWC/wQPaBlIssODjQPx87TI0DTps9P0biQgfl+7oYXvnJLDhiuU5F
         dzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756431064; x=1757035864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/9pMLAzp+OJLv9QfGuHa4wnCkokVIs0cn0/wGFQPEU=;
        b=JT5BAhLARgDLtsh2Q7K4ONuvqGwo0QVgM3P2TXu6XdUlWwOWseo93aDwdDqxDf76X3
         h9Una2VcKK9Wjh2sVBcdfKM5M5/7y8PJyNMzHHkg2/y5768nUjlWiS6DgAhzcO2tRaof
         XBHY3K54U9ZvvOJdpMbrXzzeur1X220geBy3/Trwskdeheub4QGAYHqfbdMWzE6HaAQC
         xNmpdV0hIoxjlRKI2dQsU0CqhSM2wIsex7BTqe8+H21iFJLkCrEmbia3xBgpv+iORvAu
         6lUk6YT/yrchZ4UV+QLbpmaauLkwoTrl551P1tKQezT6t8jIE61gufUy5UTtWSItNiJs
         MsnQ==
X-Gm-Message-State: AOJu0Yz3SZ6cqghcmYABUSlvlCS7VPpuEmqJVwZQtLyyEzMfJRpMl0Tw
	6laSvErY2EvBoHviexOeX5Yh0DFwTKIR1+ybL/FIEpiGdQI+/J+IY+DiLfvHuw==
X-Gm-Gg: ASbGncsAW/lprphcOLeBkC9lHb6Jw/e3su4R2Z0lTmUkDXen9C3HAj9J0Ry7gmIrW8A
	5QY5r1ljDYeWtjQp1i1Vfl+wVfOz5cut/JOelKYJmu9SRjug/STotDuZN7GGyeXSo9Yr4VTfTp7
	viVtIhrOIzbMwaXIPaPxlCAOsd3vPlPRdn/vGx3zyT6IP3VAvahUfVaop7h3anDlIo/8WgxpTyr
	kdSgaP38kK2C+bFCZ3vmDMqxC9Ueuj2dYPYlf66MRw7ygjyhpWwimExes/Jccj4/9NMvYaMTvWq
	l27RjQ0dyq/U+U6kalm20JYJDxxQzVm5XH6oWtt3GrnYQcS1kJ0YACmP+mmG8jRM+Lz2MLkcG2Y
	WtHf2YJrcO4GOnYQH9ShhvfUZ3OwSIB5X
X-Google-Smtp-Source: AGHT+IFjrfeM+QC3JsYvq0XJQwzI7oSGwDWr+9yk1UjNgku6/8Ns5b588Q9STD2zyT0UUigxpZD7TQ==
X-Received: by 2002:a17:90b:3f87:b0:327:e781:3d2e with SMTP id 98e67ed59e1d1-327e7813ef0mr507446a91.33.1756431063645;
        Thu, 28 Aug 2025 18:31:03 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327daeec552sm959977a91.27.2025.08.28.18.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:31:03 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [RESEND PATCH v2 2/2] i3c: master: svc: Recycle unused IBI slot
Date: Fri, 29 Aug 2025 09:30:53 +0800
Message-Id: <20250829013053.3562853-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829013053.3562853-1-yschu@nuvoton.com>
References: <20250829013053.3562853-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

In svc_i3c_master_handle_ibi(), an IBI slot is fetched from the pool
to store the IBI payload. However, when an error condition is encountered,
the function returns without recycling the IBI slot, resulting in an IBI
slot leak.

Fixes: c85e209b799f ("i3c: master: svc: fix ibi may not return mandatory data byte")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
Changes since v1:
 * Add Fixes tag
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 8e7b4ab919e3..9641e66a4e5f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -417,6 +417,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
+		i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
 		return ret;
 	}
 
-- 
2.34.1


