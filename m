Return-Path: <linux-kernel+bounces-746617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDCAB128F9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D9E7A8595
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C3218E99;
	Sat, 26 Jul 2025 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXYNI/3c"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A352185AC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504433; cv=none; b=F9PaiMmpu6xEkztJj8SBKAFf5Juo2Gu9NzTc38Rrt1sVkQlAacSKdS1Kf7WB3OyMOtBuabDmnknVtUa/UepI7B+VCRnYMfKAktKYNOYktIaPGHqXCwHf7uPsldTsf8+WH7b8iWreHiWF6J2Fq6E8YrG/0ojDoCx6tQ6QU4GjefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504433; c=relaxed/simple;
	bh=spShQhbzwsDpuuBCF0J00kLiKd8sC/VG38gYV30hMzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=humAcnfdmJ6YL3OW0ISVD4juFv02heZcjfUvaCNbmxDVrCu485bnzxTgZb89ceAHQaFrRpKbhrnxvEyQoJ6E9xUY4IUxe7dgywrq5z0CgLnIxKFxsV0ZqKCt7W+mNPH6qcIugxxcS7c/9HGVl99iRkqKGKzmAAePOtEEcrKcIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXYNI/3c; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e32c95775aso306167385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504431; x=1754109231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EZ13gOR4MCpjhKGk8VIh6hqTqWWLNSk/iwMXtaMPUY=;
        b=YXYNI/3c1hSq1z/0QrQe+/MVvm291qDdXSLW2Zb7RoUusLGFsPd8qv8NjQ/NMCshTO
         IjAER7j+wtSdsnnBY0DgtWSvnVnBX7g7g41wTY7M4r6EkMIw/8P9wR2W/ivVXRhaEdI/
         O2liNoP9W/txXN9BZDCkT9uloe7QVNBKWu0p1dkHKj7IuBbVpZGaTEVybg7l3u9YJyfK
         JJpWXF4N10Y5Y1iyxsn7qVpCZhPPftJIIahgdQybrHDk/Lf/Ul5MWU+URL0tfe1xphwL
         U27m0KSfupogDklr75ySn4PNC9OhmB3b5P1WaRBtDo+F+5tC15CopqIXsAeT8H3Myd1f
         YNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504431; x=1754109231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EZ13gOR4MCpjhKGk8VIh6hqTqWWLNSk/iwMXtaMPUY=;
        b=BEemzgW+5RFckUJYtu4wZdNExGe/KfqnoNFcsEGf395jzTdO3z0eIGLYYyQDq2+I0p
         gD5zTBIrVIjMXuhcR/q+341v1l0WdcQJrkMMzTpvc5YcbG8DIRSzj0+okugfIaTERA1t
         sZv5QwuBcV5q4hUqekZp9G8xNZzCtlpJjBGdW2vKM0tyqmMPFPpSKAhDlI9RWPpPVRjw
         rFcR/8TXfTlV/PuqTuoLxTdFOXblM79NXcsQBwAN7W/rIEYroyHFSyEO/p0Xw6aNaZx0
         6PAbc/FeVMAGi/PCQWOcAnnwcHyVy57ahi3u0IB1wlkcRBkfGgRlu9ijHBvJhlsYSU8t
         yAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVngSdtRLSSGwdIMc1ezXqWF9Af3EqciJQxegPv98jKOkDk0qTudHetiryAzlZB+++aoENfQmGSd8HKKss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+GB/z11EQhF+16i7UTFle9u4UphFx5hk71tLlwIZmo6LNluzb
	vda4tEIwBjdSjBHDloJoHdbssZ1bj8u8U+FwYtLiCg4FLvraVDg8PbIn
X-Gm-Gg: ASbGncvqde1yxgKK/MzNIm20KHsD76bkB2jpVrmlq9a7jwqMEU2KFMlbiuEMbiLkGBH
	yHHEKr6R7N8qVIwQ8SZ1p3SYW6G6N4e6Lv++K469NDPVYVMJbjvKIKDid3FKCO8s9u6UBecxX1w
	e+jSa19q+EuPyx8ZQ5i/wgBHyu9zLz+d6GX4gulzpSHg6BVNsMZ515qDlkYRy5uCCG6dIB65111
	ptPbzEghsobj4WYV7JdtyVXzEu72n8RoxC3pA9oefo2WMCgXd1P95r5gV1bY8oawhBv5n5uSkZa
	0ZgUwcukv9zbuho3VTagMDHY88RC+SJCjzsBKCx4AnhH26CcQDKVaj7h1qwI/vMzzjggg6mpHoU
	Da42p4L4hU6uwbMHV72MILzGY7WElOiShbkDNzhGL4iEXC4JQz9k=
X-Google-Smtp-Source: AGHT+IHSWMa30iDJm+pBR8Q765qRcpjOUuLJpjvifMALXHOQqjnCpC7lXlrGDs+Vnb96ZoSfDY4SPg==
X-Received: by 2002:a05:620a:2193:b0:7e3:4417:2b14 with SMTP id af79cd13be357-7e63bfad12dmr592154585a.61.1753504431314;
        Fri, 25 Jul 2025 21:33:51 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:51 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 11/20] staging: rtl8723bs: remove space before semicolon
Date: Sat, 26 Jul 2025 04:32:09 +0000
Message-Id: <20250726043218.386738-12-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed an unnecessary space before a semicolon to comply with kernel
coding style. This change affects a single line.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 161f149bf244..547734f5492e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2105,7 +2105,7 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 
 	/*  adhoc no 802.1x */
-	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ;
+	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0);
 
 	pdev_network->rssi = 0;
 
-- 
2.39.5


