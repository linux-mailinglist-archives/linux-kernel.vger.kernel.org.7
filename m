Return-Path: <linux-kernel+bounces-869842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DDC08D7E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAEA1C87525
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F62D592C;
	Sat, 25 Oct 2025 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAxk4c3I"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51C2E54A8
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761378226; cv=none; b=r2dwwGQhAjLKrZ24fv9uuoK3hfMjdj57rCl5+F+ecokOt6037LuNCSZsj2AyxzWVr+cD3kV11vhKf/NFCw8OuzEltlRzq55JmBH/lfhCD7HHNXub7Y6oSKvnQnaj37WQ3XSVh+A7cc+rPqjDvhiQjgxlWE6EAwUZMZFs6kyxM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761378226; c=relaxed/simple;
	bh=xGV1glgkny9Ydr3KIsuzkIRCaEadYHkVr8U90FGPB0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsNOdEzx02uUaHIRx9PMHdNS1x+HpKaFM/k5hCBLblFoB78zS8MXWnFN2ebnWqdwm2w8RuaySd2OO8ocDNwHVflK2+wcFk0N6UKHIl4ViEao/FINOcOFAF28yzOjPi8IQW5hEorrZuRiF+VNLYxsR/t3rrPcEjPt6Q8f0jpCUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAxk4c3I; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2864561b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761378224; x=1761983024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UoVebdxoYndvuY8RSJNbECBWK/xtYB+Fdm+CYMdRAlY=;
        b=kAxk4c3IJ5pt4rvCb68PUT6PF5AkwMLrNi5deE8ouUWucNgRZ9kIe6Q5D8vwpbs7x8
         9F493BqWqoBRACt7s0WDoML8L47FNOE3Pr84I4hx0c7bXJTihMOSIgW08Yt+HsxFGiyU
         oxL5hy72fYpqmAQdw64U1Sg1cm66jz9lvwP7dgetnHnytdrXIgEZ8DlFlXQmyCZOWmp7
         ddhRoQAhTJOwFDvFt1rQtAAalKWGuxG2sc3Qbz4hkPf2IjeRptXdqCQTse6lTMzGzLqf
         pG8BKjaYoR8y03hwo8IwY9eb2ygAHN0I30HYvav4IKimNnxE2fbGkMCYTjIKJONU7aUZ
         tbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761378224; x=1761983024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoVebdxoYndvuY8RSJNbECBWK/xtYB+Fdm+CYMdRAlY=;
        b=ts/aJRvbxmSVt1Iz0WjNvXHPUj8MizG9Sq9M6Zl0f/DCZWhWks3EL+kndgjm/iGpn0
         8NtM47oKUim4JVHZdTtU6QzvVthmXOdr+TA5E1tdKWRSmW/tX09ay1bbm1jzOXdhd6MC
         x3s6CPT914Ze2ii+qWyM9Y2OkV7NXpJa2zoAekfEijFkc24sGrnaOdiMcegQVkwR1TDA
         /UKtJJvXI2/he1ITvZB0VPPW2A4m/bN77o0PzjJlnHVUFY8/cVmbfs7aka6tq10Ns5ZM
         kAJ5BqrfTWgD9Uri+uQ/Dx9zq1DcauTD0d0qV1fOZao+BErQ8aZM6rOnuXZf6w056Zql
         2rzA==
X-Forwarded-Encrypted: i=1; AJvYcCWLYOSXW28O8pfDcqIZ/c5TIuz/C4BC2bQIGtHjV95diuEo+CvgmHXtI3KhlOXj1VpSyCLxBaCxjKO32cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIPOX19CFTSNfgfmDK7NTKAZQsZ8qQkITZGaV47a4QCy8RtRB8
	qPHwBEbfgwcFqNqiYA1yrqa4dPdnSxU5y16fsWYz9BcmBDcgnicx3TGG
X-Gm-Gg: ASbGncvsTGVppN9X6zIq/BTnRyxpdnyaHd7V5U9pm1XW5S9rZwOf4jB7hGG2HXvSttP
	SmnuVMP4S88ZG1hPNrYT4csGHXAiDui5c4SgaQRucJK+fMK6BX1AStSCX/8ALs1Vd79JWVfBAzG
	rBberCcCq3Md9qMcbHOnTXu8ofS8q04xQc3fnhnRLYJNxvH0MAzfQGXLq+TuaFV52m1iKhzQxRx
	SaaGnkPaYaI+Lv/gSH3Jv2wco+tXmeTnHhsnZv5q/jfEapBJbAeBaatktk4OGAl9aGgQuZWuIm3
	QtDhcVxmF9my7oKag3Pkcn4/sTKf1VPDoDqEJkc7kmr8xV1JB/iCh6gdFsR4uOEcg225Tuq7hDP
	DZGudTYuXfMADFa/jLSF8tDSTMK0T9JLy6UIw/izSoz3MPBA3A3TBwtynfIduWWQWctnPHFszLA
	==
X-Google-Smtp-Source: AGHT+IHbg6uahjG69hu0gzcYoFdfbPQ0bsi43jxp57hXpiuURUZytGc4IEe9Wj+GeDsVaOYDgbBBYw==
X-Received: by 2002:a05:6a00:2b94:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-7a284dcfee5mr5115661b3a.10.1761378224061;
        Sat, 25 Oct 2025 00:43:44 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404d760sm1395083b3a.39.2025.10.25.00.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 00:43:43 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 0/2] PCI: j721e: A couple of cleanups
Date: Sat, 25 Oct 2025 13:13:30 +0530
Message-ID: <20251025074336.26743-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the J721e probe function to use devres helpers for resource
management. This replaces manual clock handling with
devm_clk_get_optional_enabled() and assigns the reset GPIO directly
to the struct members, eliminating unnecessary local variables.

These patches have been compile-tested only, as I do not have access
to the hardware for runtime verification.

v1  : https://lore.kernel.org/all/20251014113234.44418-1-linux.amoon@gmail.com/
RFC : https://lore.kernel.org/all/20251013101727.129260-1-linux.amoon@gmail.com/

Changes
v2  Drop the dev_err_probe return patch.
    Fix small issue address issue by Dan and Markus.
v1:
   Add new patch for dev_err_probe return.
   dropped unsesary clk_disable_unprepare as its handle by
   devm_clk_get_optional_enabled.

Thanks
-Anand

Anand Moon (2):
  PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
  PCI: j721e: Use inline reset GPIO assignment and drop local variable

 drivers/pci/controller/cadence/pci-j721e.c | 34 +++++++---------------
 1 file changed, 11 insertions(+), 23 deletions(-)


base-commit: 566771afc7a81e343da9939f0bd848d3622e2501
-- 
2.50.1


