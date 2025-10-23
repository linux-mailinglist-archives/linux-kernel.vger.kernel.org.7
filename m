Return-Path: <linux-kernel+bounces-867038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 730EAC01746
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABB7188F461
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B6A314D11;
	Thu, 23 Oct 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O9105PBM"
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ABC31AF1F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226032; cv=none; b=B3MM/I3KrvVFdQBJLvpuhPWMI+MdK2qK69rxbND4BVHzL9a7RIBDaGWRXiyHbd3vMvtsqarHX/iRhq+MAUlm/jXWRlKhy5YeciM8TDYMYZdSfKgETG4MZ+TgRw3oQCNi8NIg0gvelY5GuxRfXk8GyYd21vpRgIwPc2+dlwpGNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226032; c=relaxed/simple;
	bh=ep8fhLyuGrAcfV5jfSM/Wn0CDxtlRo3rdJq3h65NU4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvL3MpKjOy5C6qApmQo7SOEl7eyK7jLPxT58Eg0XlDxsUFWejJxFmaNxMBRhYmbHaztNA2F4+BR0+78as1juKNdFiQSUqLx5lOyDd4vk7gBNi7hQKuc4qPjL8q8A8ynOepRo4NtoilxP7frxq72wGZlsSYEOsKKuQxiInG+UF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O9105PBM; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-87c11268b97so8601576d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226030; x=1761830830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdEwlf4lZgfKN/2rvuQzkYwSMC8ltz7SUViQK3FN+oQ=;
        b=aGDX4G2gYElxvNp0Xwo+cMcv8rsQOZCGewbc7rfOSUYqGCVVEYkoGgfTPc3K8F4Uia
         gCfQQF2tqQMSCcEf04apkuC9qL0AzRqi4XH7TfYAmYZowZLFWZtITaS5hOL+j3jgeYcM
         ClPTb4ph5tfv+1AXrm93YuPQKZ9E/8Ouoa9/yKS6U3UCDTI5k04T2prC/lzjbTmoHQbs
         1lZx0u/A/tdDbFMkFSIIocAr93aQ7uj4D0ZOeTeTRdaJCcPGGsNvOW6Rt3ZyD1PBZkCY
         DToJYAzzEYxrQUB9hlQIz+HhKxSWSzYbRnTxzph5kBBhDaXzO45xhcIAXoywSF6YtOgR
         3qvA==
X-Forwarded-Encrypted: i=1; AJvYcCX1tRDG8WrYOe0O+qB6IitXtxuFwtLaaCYLhVvzwsn4wY5iTcdroiKNk3cvcrJ5hPzAaY84jesTgHCaJco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+D/XAqxJFUJMRL8AmjsPeYE3925Zn1BLP/XYi9ydo87br8YWa
	6I4Md+lnmZzYLNfyIgtPAt26nRoKZ/XTYBwpXxg+MI1N/KcyJ1oBJVRsVXgAMZTXJiuKdcaOrUB
	3NJDp4p6fOxRz6pD0iMbfG2fR7yog3kcIShtW06cpkc0G8gu69SRmFTyIXcYBL9Khnep5ryOFMd
	s8SPVaExVQ4I1itrP2/W5Nj4/MmHUkXgZRWZiQ94eGdg6mUQd2K0z7+0NQig6EmoAAIaEZYy/sK
	eQ9hInW78DyyVVgMqQ=
X-Gm-Gg: ASbGncvJjg7rbeMoAWqhQTABv9myT2UzRe8gyCLatXKZ04iY9cCa4ijPPv7fSDrlxUp
	weQD0SSEz+/KlzRNj5CsuY4YmnL3Q+bHrE3awXnUn3I0sy93P1B+PagR6QflJuZgva3AgdrUboE
	DSKey8pzshwkmogNqidopnkhPebJbBxDEOQHBbpYLr+DxYzKG/K7bYXe+YcYgMuqR5Xj95J/i9f
	yD0qPs4IcVN/Rchrp2v3D3TvIOWz3rb+f3Tgln5SakEJwQtDW2ezbL1rmNGWWACjnRvgLEsQUhG
	e6M1DzUTy3N1CQQyrUoMgRPxpGPj01XoTPwgXZfDmrMFx34zxS7MJHIU7fYzBTo3ewUvOSGxYMq
	CCULtrlpzP4ySzN4Z7F2/loXsrD/gPpxtf+YAve5GIQBkocOCH81Bv8ZZJ9CKgbk0b/pfbG3UTY
	As8q3VIgveJ86jVwm/NeQK/Drb8d6FZMY=
X-Google-Smtp-Source: AGHT+IE0MnK7XVEH3VuyGh6xkxS3LM3Fobhdlb0I7IZVJ7LUACvUtIA8R5r1fRUM5jdjBofvH/vbzo99iAgY
X-Received: by 2002:a05:6214:23cb:b0:87c:108f:676c with SMTP id 6a1803df08f44-87c2075c6famr340824306d6.25.1761226029531;
        Thu, 23 Oct 2025 06:27:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87f9e72d5edsm1754606d6.15.2025.10.23.06.27.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:27:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28a5b8b12bbso23156745ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761226028; x=1761830828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DdEwlf4lZgfKN/2rvuQzkYwSMC8ltz7SUViQK3FN+oQ=;
        b=O9105PBMaao7gkWMnFJmCn+6FdDnCerCtBP7/+rSyFiIQhvDuB1dJ+faSZ11serRxH
         8A9W09p2ayJYBfNzqmxQNUSqoLrXh7susxcdSANv1PkRv+f6jpZvlrJw+YmbBGjHLAUi
         EB7iHsoz3ZQfsPVEUgArcxe1vWXbDspe5BJbo=
X-Forwarded-Encrypted: i=1; AJvYcCWPsXdo8lBMFtzyIQpYyNAbBoobUqS1TIhRlFa4dYbm+Hy098fnBlE2wrq/SlRvdgco1dI0h6x88RcK2Gw=@vger.kernel.org
X-Received: by 2002:a17:903:1a0b:b0:290:b14c:4f37 with SMTP id d9443c01a7336-290cb9475cfmr317695695ad.30.1761226028127;
        Thu, 23 Oct 2025 06:27:08 -0700 (PDT)
X-Received: by 2002:a17:903:1a0b:b0:290:b14c:4f37 with SMTP id d9443c01a7336-290cb9475cfmr317695185ad.30.1761226027582;
        Thu, 23 Oct 2025 06:27:07 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc204fsm23739785ad.60.2025.10.23.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:27:07 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	davem@davemloft.net,
	richardcochran@gmail.com,
	nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	jiashengjiangcool@gmail.com,
	andrew@lunn.ch,
	viswanathiyyappan@gmail.com,
	wei.fang@nxp.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	cjubran@nvidia.com,
	dtatulea@nvidia.com,
	tariqt@nvidia.com
Cc: netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	shubham-sg.gupta@broadcom.com,
	karen.wang@broadcom.com,
	hari-krishna.ginka@broadcom.com,
	ajay.kaher@broadcom.com
Subject: [PATCH v3 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
Date: Thu, 23 Oct 2025 13:10:46 +0000
Message-Id: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series provides:

- implementation of PTP clock adjustments ops for ptp_vmw driver to
adjust its time and frequency, allowing time transfer from a virtual
machine to the underlying hypervisor.

- add a module parameter probe_hv_port that allows ptp_vmw driver to
be loaded even when ACPI is disabled, by directly probing for the
device using VMware hypervisor port commands.

v3:
- [PATCH 1/2]: reverting back the changes of ptp_vmw_pclk_read()
- [PATCH 2/2]: calling ptp_vmw_pclk_read() without cmd

v2:
- [PATCH 2/2]: remove blank line in ptp_vmw_init()

v2 link:
https://lore.kernel.org/lkml/20251022105128.3679902-1-ajay.kaher@broadcom.com/

v1 link:
https://lore.kernel.org/lkml/20250821110323.974367-1-ajay.kaher@broadcom.com/

Ajay Kaher (2):
  ptp/ptp_vmw: Implement PTP clock adjustments ops
  ptp/ptp_vmw: load ptp_vmw driver by directly probing the device

 drivers/ptp/ptp_vmw.c | 99 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 17 deletions(-)

-- 
2.40.4


