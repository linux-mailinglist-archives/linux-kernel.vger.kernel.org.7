Return-Path: <linux-kernel+bounces-874124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C0C1593D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9711A63171
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05551340A6D;
	Tue, 28 Oct 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdOMxHPI"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F351333DEFF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666159; cv=none; b=UQkiJtIHzDH6yYr7ukwpBoIDSXj0A3BGa5MhS0FAoj9AtLgurI/UsaY519UwCLwrqkIHyMFwB0OhUu1aD0mrnRZQwJ4PZDosRAl1DDgtzihIMubxoOQsIDsEdI4Ykinwbb7+b/WD3MW2HTh6Tx20UO2RdZXVPLAPi/6MZoDdIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666159; c=relaxed/simple;
	bh=+qmujv1j2dhUiejUJ6vkuBSeYgnuFw12qWJH/G+NXcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvxKmio/k28mxR40Y3BaQECsiXNjGmhXTa6zkTf19ELjxuXRbwALEFF47VSOC1B1a7d9j4OxPydEbxiTTpvio+jyvOFZJg+UjW9S3n4mQ7TIAEXupkugNedttlcL0o0muLAVViwwL8klMjXGXkqoB3/hyHRT730rkVEy+1Z4W1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdOMxHPI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2907948c1d2so64475495ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666157; x=1762270957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4y0EJSogwXb/l2ctLCybder9EWKsVTxzS16PIlLrZdk=;
        b=PdOMxHPIIz/e6kJQiTlpfEr3V5/os9F6YnV7X4b9T6lD/QoPVWEh6Fc8YGVnBK8Vje
         1HIujHTJ74YAZKU/pkVXIMR5CBfxLAyQ9/l19U8Eq8ezH6kWMLO3YNP6ZO+KVEBqUS8N
         ErueFhsGXFk2/B+wUr3KPkVr63iUZH+bKov84O6id7KiJzKyds4cyazK5ugbiN3gQe/f
         pMyr0JaMXO+7gjZKymWxA2eAHspNKc7ZOs2IMSkm78TgH0AKiE6dCEMO3akIQINU4Viy
         vSoZwnWD/PrsIhhjEY7iJgse3cG3hnqqSASG3bEAOnx/ExMS04zIPLQZTtDDnLBaLKCk
         eE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666157; x=1762270957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4y0EJSogwXb/l2ctLCybder9EWKsVTxzS16PIlLrZdk=;
        b=hwrVmUV/zeihnoYwNuvUroO3OehDSBvtfy1eOD9NK0sx0frp73kvNOURZndJt+ZtoZ
         kpWQGlYgneubhBmUivSwbbzM+V2D5FTJvBCXNR7B5/nqERUiUzDuURSsjO+HdeZp3zJA
         C7nTCmqJQCYFWe8/MfzqQGoQaRa7HZCf0M0YaF7MdelHm0UTNeOQ/reDGo5wvr/bigd7
         uwzaGcvplKmv4sUMHgxNo3KPw8wo9Y55aVhxQ+S1PQwTHg4IRCVaWcKwP9HxOXmX3nUP
         5DoEYrMn9vAAGHKX4yxXY14opypPozLc6MUKESaqS42+1kMt4RZPnixazWOc1N+UHF9N
         EUnA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9gDYNvP6iMhM4GMPPbduA0HBZyD1eXf83QnC+/THTvxuwFnZ7eCw/GCFlWiUYkOm4/QRVujaYSEEzuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvyJuHlwe3yP0+XahIUU2TuaRki9y0ceTmz5Gx/rHFPOwsAub
	qaLtUTb3qcv/tlRvPaPj11QSEeHNCtmgBI+s7CeoAeT8NVD4H7N7DyR8
X-Gm-Gg: ASbGnct87X2iivsglvTE9yrghH3ffVqb/0MidYQ4WBNoN+KlnT8mgBOsCiRkRs3DNxW
	Oy6YIrITqaKtV3/JC/Rvd6lFqSztk1xdbN3jynSIC45OZ5F2B9+pm2x4zm/WCle7P7AGpn8ebuO
	qDypR4a6DOm9+ubqOdxxezUWG4i1WyTOpF15jAdwk4IV2nhendr6bVQFNd3L6jiHu6i8jFMlsW9
	xeJAiTci1lo/LNgwdSCew6uj48tBp6Bab1LcMnmWNG/g5HkJjji4g3Q01cfl/UeCAc3eS9flh58
	MuzBR5hD6y7SIwFZKKjZ+INU1y87jOJ7ic56N+xxxKIbqAr7hpm9Ja+9708QdejiojQUWZXIQKa
	xc/fD1siFuhpkXkQlf8KRtipuKa03Rf252HuLaTERXcfvkcGaAnBE2U1xMoyxeYx8fzFYkVAypg
	sTDIwnM93B
X-Google-Smtp-Source: AGHT+IEmbuhAY39zkLzLEiO4/3IEI+wJ/XdixLTlEX12sPPCwzL9L/N235oD3a/xqhHcC17poBLbbQ==
X-Received: by 2002:a17:903:384d:b0:276:76e1:2e87 with SMTP id d9443c01a7336-294cb52558cmr46649865ad.44.1761666157092;
        Tue, 28 Oct 2025 08:42:37 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a4d9sm119815145ad.37.2025.10.28.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:42:36 -0700 (PDT)
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
Subject: [PATCH v3 0/2] PCI: j721e: A couple of cleanups
Date: Tue, 28 Oct 2025 21:12:22 +0530
Message-ID: <20251028154229.6774-1-linux.amoon@gmail.com>
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

v3  : https://lore.kernel.org/all/20251027090310.38999-1-linux.amoon@gmail.com/
v2  : https://lore.kernel.org/all/20251025074336.26743-1-linux.amoon@gmail.com/
v1  : https://lore.kernel.org/all/20251014113234.44418-1-linux.amoon@gmail.com/
RFC : https://lore.kernel.org/all/20251013101727.129260-1-linux.amoon@gmail.com/

Changes
v4  : Improve the commit message.

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

 drivers/pci/controller/cadence/pci-j721e.c | 33 ++++++++--------------
 1 file changed, 11 insertions(+), 22 deletions(-)


base-commit: fd57572253bc356330dbe5b233c2e1d8426c66fd
-- 
2.50.1


