Return-Path: <linux-kernel+bounces-839358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19FCBB1794
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C711C5511
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB52D595D;
	Wed,  1 Oct 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fhftp/++"
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031232D5928
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342656; cv=none; b=OFLywxNc8/L80AxvH8soD8Ma+FriCqokG6gC5J7xtRp847rRlVmK2SovXIqN4JsQSZAJrwI5SiZb7MY4sHXpkWRInIsUvwyRW5PQO2ENTUjElcT1pALhWtkI+UFhNKFr+pV+qfKtmIa4LJT1YmghtFePLkdYmmJ7PeNKKSASC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342656; c=relaxed/simple;
	bh=pbh0BAzdCZ5GeAnkz26ytoOKgkgpRsRjE/yqGfWQuio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbTZ5AkMCGvpHf61/z7rnr7jvruUrkSbhYXIxiXZNoa2M2qiUxuZnZUjTiUWVaCEPgsgte8R3oi8yFfL74sv7ORdt5ol4zbKEwSjmULl1Iz4TKFNWEMBKVDX8bDDvv1ygwKF1a35E8USOnZ6vxwaxTSRUKp4GcMKQnQX3pX0wTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fhftp/++; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-911afafcc20so5841039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759342654; x=1759947454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKcTz2+WfcXi6NCeJhs4Aeeo3+yILKRVizIKcyvohdY=;
        b=kQHAqd7aR/oCgSfF8ztZBZwVf5NXQqytP748qGflzluEqZ5W4m4gK9gk4Tc3DUbV8l
         YtlsowGBZmyekxJ8uXomDNMHx56bpyf67XqYuedNGmQ3Zrmae6NxzaMsJPUptyxIKiHY
         koCS5NBOr1XbSZUElYR2Z+aXILIYEwLED/wVbGueArpd8k/0jESddP+6+OPbrIhSYtB9
         KJAZjklRrQud/c9rmaFbiQ0fVnEzV06UHUhUxTUX+aP3pB1fRyP7ABrSqMGYWIJ2nqNi
         AELOd+dK4GE3MfHrkfNuOgBtIa2aPRdOPthO4+09N8nKn8dGc49MnKyWO7kY5EZuJLj5
         R2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQMShHXuBw1dFMYi+v3sP6mOiMH2SYelOnL6sZk63eygfuBmjjvfsHhJ/Su5yHjDTeIW0yly8Ym7PZflk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jxzq+YRtxqJ5dpnihnvDwbk/qCUEKlCRSsNGaTWuLYXNNbPZ
	6apJplUFHpX0cn4HeZdsRnP8CCF1uJNJiB8nfuJcKKFJtk245fRaV4l1zjQ9A2nUpESoN1iZtUb
	bYcGM70qGwkgLuh2TxsFcFf0fufIlLtEpRjl+raZetDx5dEJmDIha7EKY429zU3d8jwGzjt7D2l
	uI8LiMF/rs4nT2onjKVsk3njzw5KMxZEM4oJoxHjUqtoeMTMCZjpn24J47E+izOTNHqD2+2Hk7j
	DgmS2cLkjb7rhgZ
X-Gm-Gg: ASbGncvOXb3OPGTOP91jzma4dv44RO4hSol/dH+JaNKxDO7DKodNJAzydD56xq0zImS
	0xpn2JKe2Prx+0P3ZX+1MzjFxs0nN3N+dmb44MoeeLzyH+0rH9NuvRTmo0fcXFU3+kk8Nuv6pnF
	Vshy5tJGVlAfyQmnMVcL49Tem9LWI/+lwdva1DU0n7euGuM2JNX0/KS3IZ3BuH5ZwdWlrHqzIPY
	qMgzvDtcd2lIXneT1G/JcmV7RbzbtpGJ2fQFuRAuWKu/cwaJdgKSC8UyaoGar4F5U1A1mKYtL2X
	aP31Ce5LqB8MgvPaKEhNrpczi1jsLdHgSBssUq9L4RW7DQt8CAU9fFntwzfS8zp7bWg7uMTLpig
	1ptVW0Y3ehj1g8rw3A4n5Vkufbbj1AHO808q40gOejbZ/BZY91SydBw65LGkVObFm7TGO+Z0z9j
	XQgM11
X-Google-Smtp-Source: AGHT+IFRmymRM5YlSqGAJI+ZO57fhOUG1QNQbLEjKydmW8pzAauS0LzVT+qRfoX3rTDs5eBfdcvZugA+Jdl3
X-Received: by 2002:a05:6e02:1546:b0:425:71bf:1148 with SMTP id e9e14a558f8ab-42d81633befmr63031525ab.30.1759342653974;
        Wed, 01 Oct 2025 11:17:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-57b5eb02709sm11190173.18.2025.10.01.11.17.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Oct 2025 11:17:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d905ce4749so3292751cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759342653; x=1759947453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKcTz2+WfcXi6NCeJhs4Aeeo3+yILKRVizIKcyvohdY=;
        b=fhftp/++HXs0gaG3zBNC/4gWi792SCdTqPTika72fyZfqbaCbo/lwrH9emdrcVLjAu
         SZJTwty9pUTFpks4wOPu8dJ7iwfNVJ0MPyP0C9k9eGS53ctWL8Q7P/KJgz9DelYQUwOV
         9eS1/M2due8XeNCvRwzDlBEsIVOFAlDGmqBrM=
X-Forwarded-Encrypted: i=1; AJvYcCVN+8rePmrkTaDBxTcnxvghIuPay35DnsURfMPtv2vR+xNZajOkeNmGHobWszz9/0zmeNRwSDtTUyt1JZQ=@vger.kernel.org
X-Received: by 2002:a05:620a:4507:b0:815:dab2:1ea8 with SMTP id af79cd13be357-8737a8f483cmr563556085a.79.1759342653173;
        Wed, 01 Oct 2025 11:17:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4507:b0:815:dab2:1ea8 with SMTP id af79cd13be357-8737a8f483cmr563551285a.79.1759342652745;
        Wed, 01 Oct 2025 11:17:32 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55c9e78cfsm3847671cf.27.2025.10.01.11.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:17:32 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: peng.fan@oss.nxp.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 3/3] MAINTAINERS: adding entry for BRCMSTB HWSPINLOCK driver
Date: Wed,  1 Oct 2025 14:16:41 -0400
Message-Id: <20251001181641.1561472-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001181641.1561472-1-kamal.dasu@broadcom.com>
References: <20251001181641.1561472-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97d958c945e4..21b78f468169 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4972,6 +4972,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
 F:	drivers/gpio/gpio-brcmstb.c
 
+BROADCOM BRCMSTB HWSPINLOCK DRIVER
+M:	Kamal Dasu <kamal.dasu@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
+L:	linux-remoteproc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
+F:	drivers/hwspinlock/brcmstb_hwspinlock.c
+
 BROADCOM BRCMSTB I2C DRIVER
 M:	Kamal Dasu <kamal.dasu@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
-- 
2.34.1


