Return-Path: <linux-kernel+bounces-790964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C1B3B06E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01D97B50EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF3239E91;
	Fri, 29 Aug 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4EZzwWu"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4878B22422D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430601; cv=none; b=MpKOaXzx+cdZu8RaavU933Ngo+9AspdZVHl0DCPqmSjtkt32xRwcjvzxghcJUS52x2A5JVeY7NnNNPnHVFC5b+iU8gaGjEuMO3Bimo6+4epqwF9lBV6GcJD7wNnEZ+iosjQIBnBRQmkTsS5JkXb6rLygbOOYELrj6fNcvaRz19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430601; c=relaxed/simple;
	bh=D2eJe/VSyu1EW5EEtFbS0UmU05W1NDCSCYs1WRNX8Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqAEwwxmqyHDMTmkRWO33I3OZsZOU29gqg4fo0iGW0FpvMWE7b10X8chZinHKaprT7oK5sf8CHC4dDrXQgZP1NrKLfz6YzZVHytyDSkoNGBBtCTrjuW8BzeGJsvFlUj9Q8QtU2QSP5Rmimk65m8A+cCJtHTVU+UQU9wYBVYjx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4EZzwWu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4717543ed9so1094191a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756430599; x=1757035399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oHGtvYtsesmIt3+EM6g35UIqNVWRbi1ozOFONogT1I=;
        b=k4EZzwWuXJBoDrUasGjH+oK0ej1LUUBD0uNsv9hYXujpLkjSY5jqRzH+DNmksZujdJ
         Bw0mmB/LEQ+oSImNXSoQgSSGbSkkCcuANy+NG9ERJSyObgXdGvi28PGyd8K6jL6SjUUr
         tkWwcXcaUHKGnXYeZdynMrUB257MagjSVdBDCSBA4M1MDytmXrz4JDMTKo346r0gfqPG
         jNMbntpbMJQXo0FYr2tSCi7mlqqFhEcjA00q+hcby6K/TIRhi1H1+LZodm3LBaoR12YM
         RcG/foK4eMfzp1oC848ihakQLktIeh1MUaiFqhigs482SdFJecSBPwxbstm1+IEIAs9v
         o/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430599; x=1757035399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oHGtvYtsesmIt3+EM6g35UIqNVWRbi1ozOFONogT1I=;
        b=hgrgl1KqaQA6k5f15YErJeuEtE+8A0yAEIM0B6Hwqxe5v6WtUAzyKO8b9vlarU1wJP
         9cLbYqm1qkHPwQ1OvlsZuoMhFzMp3efwJgOaq0tTF53tRhtuwU7k4fkiJRRZVX1lhUdz
         3mBOzLb1dgG4mbgtKEsQYIqK1KRAo4vrUsxckwdP9tthyGVqNATV1MzMgs4DUBLgUY/Y
         M+B/MpOAPCnObXMQGz9OxUELm6HuTgEeN14v9H+hs4yp4Ad+RSDyVOkPlLTbxtPHTfof
         Ke2Hjap9yKVEOfw1chAozscI6PsScOACvNNoxmKWo+Jk5TaZdVYVewZ+T13m0XuG/dBh
         xtDA==
X-Gm-Message-State: AOJu0YyC68md+mA+fOKf14jwjT8H0FqPFRCGIJ9FAMzAqbcsrft4PT8C
	wRAQnxkKLtEQGIUd/aLDIdTDwEEomyx7Mf1YA1ZPb6YtpAZ4l7o8WdGc
X-Gm-Gg: ASbGncvb8Q5kdZ/aA5vkWw0T7+3RAj6xoUhDnESA7iHhlL9C0lhJpZzry3HkJa1pdi8
	VzObLf7tJDDTylV22NH3YsojBvjEFI614jEHczOuyRiWrMlFGg8q3zJtussLI3ti7Fs9cgnVzfT
	1QC3pqV22wzkROvJBeI7Pu3w3vv6Qnnfy/eXVx0+YJkXRo6lcAdolVB9fYDeu83LDdauZ3UiJBf
	SVeIUPxk70scNMfz7x8bfl1578Ouy8Vd0+0w+e8/cz/G/r+tKDz6LiwixwXGsxN51zzXYcOh4wO
	uUJUfrn2J07chhnOJMvxS/vq/LUl0aHnJg0vz9DZgxld8X+RysoMODr03Xk3e0blnfUjXTIOuL6
	Xj/00I5Wd8UFHaTpRcBTGeWWQRJiwvcc5
X-Google-Smtp-Source: AGHT+IG+t3nrXLoxxR1n0FoxZdNMEKufEOVKLubzBN2CKS3LXLlRkY/AYqSJD7YLsftqx+TsO0/egA==
X-Received: by 2002:a17:903:2406:b0:248:8872:5889 with SMTP id d9443c01a7336-24888725c49mr148909745ad.38.1756430599488;
        Thu, 28 Aug 2025 18:23:19 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da183asm7686885ad.74.2025.08.28.18.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:23:19 -0700 (PDT)
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
Subject: [PATCH v2 2/2] i3c: master: svc: Recycle unused IBI slot
Date: Fri, 29 Aug 2025 09:23:09 +0800
Message-Id: <20250829012309.3562585-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829012309.3562585-1-yschu@nuvoton.com>
References: <20250829012309.3562585-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


