Return-Path: <linux-kernel+bounces-789695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74364B39944
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B19A17B78B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD7F3081DA;
	Thu, 28 Aug 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6y4PIMq"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEDF3081C5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375986; cv=none; b=XZ7Jy8ktXcnWJF0+xUJxUvvE5C3B9FoEbISIcaBb15G0VNOPF6Im7TWind3M2ScyAAihs7CQQRJ9pH97cfGXHFPOtdWp4qoE7e7xwdPGv5CME9mwl1UyrM+lSZjmbyEqaEzVdmy1QV+6qfjcxPSSx67ecm35QQplYaWZKxsgegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375986; c=relaxed/simple;
	bh=lZ/IsY6gJYHS7za/fVENGpZ2fJIkgAYtEhtCPQncjiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTRm5FVsSkPrnOhy3gF9quxETCB9Nl+dKSe3Yj6U1k+DlRTSbi+8uv2KdNXrJiD735ZOC8q4yl7pBoX5H81mP85XOYaUeikORh9WrCCmYMc5Fy30lWrvdoZXKsLzGiq7jm/zwQfitJToppup0pbJV4TKB4volkdtORqIXONYzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6y4PIMq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f54c9a123so167720e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756375982; x=1756980782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdX/N4KLUhkdInwTJSVw73qwe9sck2J+BFjqIgZituU=;
        b=p6y4PIMqSxdR8OmE6XGpL0FPgt+pvxXit3YKVrpwgvFV/Ep+AdMdtJFyvDTYA/+Ee2
         wjZM+hQtqmvk9WUQnh3jvFpJMMLRxvbqvefNwyHVs53LOBfTKaWjzD7yt9J5BO9wqgMH
         EMCe81sHbrdUnFBV7OrYPsSNCBZT6JfZWZj5i0aNF2fsSdNhWH3C1zugpSH4XRsRyL7e
         VbgXqTivD07YISEBLxTG0dFbSjKb0wFsR3E2PUAfuWYBY3uGK1w8YXlfX0BJnbmg/Mr7
         dbE6Mo/3HncZxb5PlRIP6u/fT96EcjYdqfpb6fjFiCTGTKZ0QV0g+tAQfX0+Ncz1H9Gs
         Fwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756375982; x=1756980782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdX/N4KLUhkdInwTJSVw73qwe9sck2J+BFjqIgZituU=;
        b=FwBfmB/pJ7RWHct2GIxiQDNKoa2vdTnJiUZY2IgJR986ntFf1cavmlqpCqUUFeVIZh
         UlZV1wX8Yhdm/zfUCuK+oZPVUNUsPFD72avbdPIcIAlwlCalrv3BdK3WM346ndGixEwB
         KzmdZpPHC++cWrmzfxRr0iWxwx3rw7ccnCc2kshAJKnG3TcSEtxleuaDlnm1v8D6Ew7s
         gM69nWcsXXGsUUGAl0L8JC1ZNSdhYHJpereL8Ua2QLfiErZNZANjviW2/Asg4JUrsJaV
         LHVYfoeEx3PzMjpfBDrifzx4fcfgebCLo2GNbaz7aR/yp/AwAFIZlrVhzQ5MRQt5H8Cx
         XnJw==
X-Forwarded-Encrypted: i=1; AJvYcCXBGk0j+VGG90G8fADmE25MNzv4Gc8iLYR4PoHqARsy4kj9+T6GDcdRAIibPcD9O8LisxN8Tm7msbCQg9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hBO3QNONhm0OMcCGusvSKRtjBgdVvTr2KpxTZ4NkAPSt/Z58
	lixoztFo5Xek3g/yx2QvGKEnFVn0a+RgS6xjhlGjBcl0dwMa3gmgZJ0wjAQ4o1eb6PQ=
X-Gm-Gg: ASbGncs6oTi1PLVlvZSebVN27KxjEzYUsJsdR8mysl6gfhZALiWq7Qx9pj51eau+pTv
	CxtdnRxm2NFHGRPMHC6i/Jyqv+oPLYOD6y86YacNuCgd5KNBz1TaqMyQUZmk2IKTuIKPih7ingC
	nx3+ougPcFXB5EEooPK+A3DK9utikgWL/CNhXqKbdNo9BV1/BbzjEs7zUtLsRa7lnm8IKA8rwW3
	a0dQkqwSXhvCsDh+dP12lz8VOSvrMFusnNyiBTKbtMc/G1OwTcawPd3mPx25/xfS3kDaYFPuHFn
	ywKzh6hLje9tRNdkt+Te2kATLgt0B3pKs250eS1k7Lv6YZxQ6QSKP1lwhVezU+D4LLG0retmMpX
	zzTloOwTP3gntzBrOLX/miHUj1keDz/IavNPwzjLGR0N0N0kNUhnbrxoBwrhP1L6W6kkc
X-Google-Smtp-Source: AGHT+IGl6v236hNxm+75u9MOYwiKwehhXE74Vrhd0hXoFMFVftfHWVJ+Asu5Xu7WnVHT3u/LWnOAPQ==
X-Received: by 2002:a05:6512:3c8f:b0:55f:4953:ae8b with SMTP id 2adb3069b0e04-55f4953b1d7mr2005264e87.6.1756375982348;
        Thu, 28 Aug 2025 03:13:02 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55f35bffac0sm3211494e87.11.2025.08.28.03.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:13:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: bhelgaas@google.com
Cc: kees@kernel.org,
	ojeda@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	benjamin.copeland@linaro.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] drivers/pci: Fix FIELD_PREP compilation error with gcc-8
Date: Thu, 28 Aug 2025 12:12:37 +0200
Message-ID: <20250828101237.1359212-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
ffs()-family implementations") causes a compilation failure on ARM
footbridge_defconfig with gcc-8:

  FIELD_PREP: value too large for the field

The error occurs in pcie_set_readrq() at:
  v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);

With __attribute_const__, gcc-8 now performs wrong compile-time
validation in FIELD_PREP and cannot guarantee that ffs(rq) - 8 will
always produce values that fit in the 3-bit PCI_EXP_DEVCTL_READRQ field.

Avoid FIELD_PREP entirely by using direct bit manipulation. Replace
FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8) with the equivalent
manual bit operations: ((ffs(rq) - 8) << 12) & PCI_EXP_DEVCTL_READRQ.

This bypasses the compile-time validation while maintaining identical
runtime behavior and functionality.

Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/T/#u
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e698278229f2..9f9607bd9f51 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5893,7 +5893,8 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 			rq = mps;
 	}
 
-	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
+	/* Ideally we would used FIELD_PREP() but this is a work around for gcc-8 */
+	v = ((ffs(rq) - 8) << 12) & PCI_EXP_DEVCTL_READRQ;
 
 	if (bridge->no_inc_mrrs) {
 		int max_mrrs = pcie_get_readrq(dev);
-- 
2.50.1


