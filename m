Return-Path: <linux-kernel+bounces-844341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A274EBC1A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9367A19A0C20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C02E11A6;
	Tue,  7 Oct 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SZybQh6I"
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706D225785
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845888; cv=none; b=FUbDGTDn3Nim97f4m2BH/iiPmZArnoki//A0WzuW5AHFX92B1cSTKcnpZtjaUn58Esnp68r0lQsk2fkIqkUgVjpn0F26oEf9tDKJPzNCPPeOBeMbyjGkpvynriidA1R+n010a6MA/uTkeg5VBgv4zpYKNo+t33n9f9A6njH7abg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845888; c=relaxed/simple;
	bh=T7xKd6x9LCmTlXtrpXw7Dd+dCv2klQxxhbQjd7jUIls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UJLovSzNUDla87fSjfPzrHl3QkKZl2zFVoggJpqrEVFEt/IFrLWDKprpqwgz26iAbVYOQE5yXHIeee3oV26AYDB9L70he1fOLYjCZcSr0OCNmZxXRBiG/opCDNdjNNpzC8v8KQj/LmP0EsJo2u6ec7FiF0Bgh/7BhxE7UhmGfYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SZybQh6I; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so4212225a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845886; x=1760450686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+9d1ZWb5LY8JAy2gqqVDPFgFUs9C7bdvcAG7+1eQP4=;
        b=Lgz2DMLddJ/Rmg3sW5KCWkZ7GGLsYp3YAIt1IzOaKWgILL4bLx7hWv5T+GG4zvEuZk
         2jHHS2JqIzhQhBinYPWvyqPxvI3Rf68l55UG3rE1Iey0YQCecBaL9NWyiHAGiDvka8PJ
         Nlr57LrLdC1AMQFeqP+KOSjCyBbxafKt58AwhMqPhjE7eudCWovpsEhkQzQ7rESAYS/M
         x+IMzYt97ubWfuIX6jrNbWf4hl9Y2IWD4Vada/GI+eixwF/R9tDlpHGHwHxljqghl6Xy
         6CQNLgb9JTbkkDA5o53Qir7H59znXpXk5ANztSX6dQIbmVNXf5RXk7hpEgDeEMdBL71k
         R33w==
X-Forwarded-Encrypted: i=1; AJvYcCU92Zy92vn+qi7p6SmJm8fclLsj8D4p+qj5jy+iBTvJChBOZ/kjFbjHCVNCEQUPvoD3bvs2X7K/W/Cncs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzekox+SbaHqjmOdbEVAUyorAIdZIzZHEdRI7tTiRthkLDwBbya
	eYQ+OuL+oaOCjQdd2fO8liUF9tsxuykCAW12rbdVC65GsgEfZ02zEFF1c5fHbT2OHCmC47mtZpc
	RRfTNhXWvzYEtgtNtV05G8LsMURXWTAhtEjWwnga6jbUqIfTlTmIQ1zmZoKrfwjIIEjj1XD/FaN
	2xEtJDZhE8NNs4PyLx2KOWQBusBdylD5DFVV+qsDi+uZFStgu5AW+RfVceOoekhY9/w0/ucCM5y
	gan3U38aPLBqo6o
X-Gm-Gg: ASbGnct4WIDeTwLjOVWRKD+PZ908c5K0MV221S2dlrxKtVGH3dMkHnMyCV5Tyx5C/cT
	JEIU4Sa6TxkvVUST6mB6UvFuBoOME7/aGZgQ25Gb7FE4Qaf5802J6jxJzlIvY1UvxJWQ7lrG6xT
	mOLqFBWqHGS1+U1khBtZwG4fcqwjWXJGxkioQquNlvc/JUVaK00Lwc7D30VZzmVyUYqw6uxN2hx
	2A8g86IwoMhysHvk8aGRhFL/ArVAso3e/HPclCliibLgoNiNHiHGZm/PtBOB27FO3g/Ib+gTK7p
	kcznPv7NeD+PBnDVW7Nadovf/vIMKjhbE0Y0hj2lzoatKsr6rI/HbCO3TNrFG5hzxWn9d7PXClA
	h7YCWcsw2E6pKeX1xoAkSL43vVq4FmZt5XljlWBiyi93GlReFThBfIF8UZPHt8xI9FMVV16AiZ2
	4oNjW3
X-Google-Smtp-Source: AGHT+IGESdQEGRlIZPy4YJZSYM/V9C9r/Zyfi5fnngVUrJF9Av4bSGAEK0EpHbIi6xBjDHUtyYpx/G+9twg1
X-Received: by 2002:a17:902:d4c6:b0:24c:d6c6:c656 with SMTP id d9443c01a7336-28e9a51326cmr192157975ad.4.1759845886099;
        Tue, 07 Oct 2025 07:04:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-126.dlp.protect.broadcom.com. [144.49.247.126])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-28e8d10841dsm10886075ad.11.2025.10.07.07.04.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:04:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-43f642bb178so6381084b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845883; x=1760450683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+9d1ZWb5LY8JAy2gqqVDPFgFUs9C7bdvcAG7+1eQP4=;
        b=SZybQh6IVkzJikDKv1q8U4HJSjI5CVCeDbdZwpRwNIdfpSLDZBqyJN/7BUT5VK1Pj5
         zYgPvc2a7iFSQN5jQ38NUVu1VtjKQtuB13XmEC+ei54nHa53W2mQFFtzwj5YaMBai6Dm
         6ewpaldwTNicfMtfr0EbKJv/C+8EGiDdbMYqg=
X-Forwarded-Encrypted: i=1; AJvYcCUYH9sO1455Uoc2guFYGaYbYG3VwaQCMSIZuQnQysKHaqi4qfYUdb167ME9i7Zz/PhRkLjG2GylKiM/m1k=@vger.kernel.org
X-Received: by 2002:a05:6808:150f:b0:43d:365f:be86 with SMTP id 5614622812f47-43fc1848847mr8223459b6e.33.1759845883197;
        Tue, 07 Oct 2025 07:04:43 -0700 (PDT)
X-Received: by 2002:a05:6808:150f:b0:43d:365f:be86 with SMTP id 5614622812f47-43fc1848847mr8223351b6e.33.1759845882241;
        Tue, 07 Oct 2025 07:04:42 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:04:41 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 0/5] sdhci-brcmstb SD host controller SoC specific enhancements 
Date: Tue,  7 Oct 2025 10:04:28 -0400
Message-Id: <20251007140434.606051-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

sdhci-brcmstb HS200 configuration for BCM72116 and PM register save restore
changes applicable to various SoCs. 

v2 changes:
 - Separate commit for SDIO_CFG register defines that moved
 - Implemented cosmetic changes proposed for initial change for :
     "mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200"
 - Moved BCM74371 support in a separate commit    
 - Implemented review comments and reorganized code for :
     "mmc: sdhci-brcmstb: save and restore registers during PM"
 - Added Reviewed-by and Acked-by tags wherever applicable 

Kamal Dasu (5):
  dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host
    controller
  mmc: sdhci-brcmstb: move SDIO_CFG_CQ_CAPABILITY define
  mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
  mmc: sdhci-brcmstb: Add BCM74371 support
  mmc: sdhci-brcmstb: save and restore registers during PM

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +
 drivers/mmc/host/sdhci-brcmstb.c              | 154 +++++++++++++++++-
 2 files changed, 147 insertions(+), 9 deletions(-)

-- 
2.34.1


