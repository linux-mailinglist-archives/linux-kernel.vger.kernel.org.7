Return-Path: <linux-kernel+bounces-836791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F5BAA91F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861D73AACB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0124E4AF;
	Mon, 29 Sep 2025 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bow644b6"
Received: from mail-pl1-f230.google.com (mail-pl1-f230.google.com [209.85.214.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9C23BF8F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176400; cv=none; b=uj3/AEtOkRW7RLBkXoQOL/J0OBoWew/7fZxPRCvdxMAN109p2wD8ycas6IrPrN+ljyp6WrtuQ8iDb7bmzO3FyP0SHqq5ffOWhxE9iAxqDbczspNz0B50Assq8au+hgZXG8/Tri8ory/PUPy0DCP0IUHkDsNXmvfHs+oM9tzxGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176400; c=relaxed/simple;
	bh=xJ0YjV6u0u1BrqJyi5HsaFx0jR+epqiScXrW80J8Ilo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BrWjeRO7/QzQbScs8FwavQmv7SDg43gj/JvnSayKmmuy+PU9FlJlE73rj2qObIgf/hM9s3YMBPBgU9U/9vFzFLRTtuoYNs/corntlnPjE1gqeuCIyr4ySdSQOMNax1S+dd7wQwLcCqtUvxMz2JzRDQ7Vv37HZrvgnLxOaMsZt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bow644b6; arc=none smtp.client-ip=209.85.214.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f230.google.com with SMTP id d9443c01a7336-2698d47e776so44375345ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759176399; x=1759781199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNXWXlHT5+84YH+qmxDCb+3VQowVLVSncoXOi7xa9mU=;
        b=W5YEaSEr1Sat30MRB+08tE1P7yxmapTF/uaQBY51MPqZZFZbRV0AVfA86voAFDMQmR
         y4oNpdGB4zCjwSac612n0ptHNtkCtfRwHKSXHo82SU6C6cHwgctNfQN9m+tYNBYr7/Ok
         6DFvUjsCBJhW3lzLoFO6BCVoN2EdnJlKI6rljax6Vw8kREeqVEs4QHcHrrwdQfKMS95F
         m67GvmWoveQH7XplBWiXH8f6DoM45vnkCjIQ32h5KhrASQWdmGhKl0pDjISqSCTRCcnY
         zN6l+tNWwS/j0R+PHpVwChQEQfZ1Q+qWeoZTdFEycwQZeRZ0lpuSdui7Jt1CncBDSlgD
         KRyA==
X-Forwarded-Encrypted: i=1; AJvYcCWD+zji7BDBEijCjVIMA4CoaYNoNOEHXjAllzU4CqiFc+/jBt1b2a5cgw4eF10dA1hrhiSwK9TzOrQI+B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Ex9LS3SV/6M6GPQGHTdJzNXj9FH6bfUfGu02gxCneqze5bdN
	60Q3bT3+sbGUZvA8z2UGk0/oNUDvY7ksMD9AeZis6lTLXWMnnD/D+aUZCN86pYgLwHv3DM1v5pe
	BImr5g+ZH5+h82RI87FsdNQ1A4Ahu58DCOWoYvBgKMZPehtyoN0Z5gJjGM9qVuxxQkkJC71OVcT
	M/U15YZq69u37fbApaTVQp44AX/K4xIQ5Xp4g6K+NojcJLMX48yq3sJfRvOW3lcf0nIklqbgqUn
	l3+CS4LpE8s/mJew2I=
X-Gm-Gg: ASbGncuEiqfBP/4cCBqo76pAKcK0a7T4tmPbA9oy2W18E7xFqhTWYNxKeo12eoU6HnV
	zUqEulQ4UeQ16+8t1eRlZoa5OiBAJySkJOP1021dLWkhWvswSjJJyPDgedhuOZzwVPH+3MzA16P
	OcZ+hop9MlHOTidaWKJT5Tgr5mycNJC9iYoa34yjj4MgfiBFHx5ZKeL14V3gUXF1V7L7+tAh24O
	VIzl+xS3lDpPba0Nt4mLMgu7xIrYou2fe089Vv8r7Y5QG9WHGj5iBxy+E6qO72UVm8yT0p7tKEO
	KftUF9A3ZcihHKjKuykuUlmSdKufJJwPIo2XSx6opTmGg1hc2czqMHcX4nBDQC6n8uFbcLwQ9QN
	XpHVFhZNx8w66T/PgeVzr00hgSEfd7IXRXhESHQoby8SF8NLEovYhAylpzC7ovwbXl98aBEX+2F
	0=
X-Google-Smtp-Source: AGHT+IG3HAQkgTY/EDNu4RtjVAJyfUca9hEAtf/19n6rosWyXQ0WFz220quvDYe9z5TA20BA82tGjxSbCuvm
X-Received: by 2002:a17:902:f68d:b0:276:842a:f9a7 with SMTP id d9443c01a7336-27ed4a5aab7mr199919595ad.57.1759176398579;
        Mon, 29 Sep 2025 13:06:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed66bb6efsm10596395ad.15.2025.09.29.13.06.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2025 13:06:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55153c5ef2so3400965a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759176397; x=1759781197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNXWXlHT5+84YH+qmxDCb+3VQowVLVSncoXOi7xa9mU=;
        b=Bow644b6p+csLTa64Wcuf5kVEfAMYp91VRVecGYttqiFI8QLU7Sby4GwzPfA2a33oq
         ksjtHowGcFUNNlE3hBbc/BJZqk5T0faJUSmMv83EsoXZBO0oBEgMArPlJVHBgRFA7LIQ
         GGius/12GADlmXHU8dUEtiY1cKu09tDOMzYIk=
X-Forwarded-Encrypted: i=1; AJvYcCUdEWX3bVomgZpF4pCs84CDFF2YJCd82pjvex1mdU602C5E93i7IR9godbZs2+K8RG9uW/JgMixU1uBL6k=@vger.kernel.org
X-Received: by 2002:a17:90b:4b90:b0:330:a301:35f4 with SMTP id 98e67ed59e1d1-3342a296f22mr20564259a91.20.1759176396981;
        Mon, 29 Sep 2025 13:06:36 -0700 (PDT)
X-Received: by 2002:a17:90b:4b90:b0:330:a301:35f4 with SMTP id 98e67ed59e1d1-3342a296f22mr20564239a91.20.1759176396554;
        Mon, 29 Sep 2025 13:06:36 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33838735194sm2121479a91.22.2025.09.29.13.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 13:06:36 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 0/3] Adding brcmstb-hwspinlock support
Date: Mon, 29 Sep 2025 16:06:23 -0400
Message-Id: <20250929200628.3699525-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is standalone patch for the harware semaphore feature for
brcnstb SoCs. The initial patch was sent as part of different patch
set shown below. That was not accepted, however the hwspinlock feature
is geenric for all brcmstb SoCs.

Intial patch:
url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/dt-bindings-brcmstb-hwspinlock-support-for-hwspinlock/20250712-034624
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250711154221.928164-4-kamal.dasu%40broadcom.com
patch subject: [PATCH 2/4] hwspinlock: brcmstb hardware semaphore support

All the review comments and build warning have been fixed in the current version.

Kamal Dasu (3):
  dt-bindings: hwlock:  Adding brcmstb-hwspinlock support
  hwspinlock: brcmstb hardware semaphore support
  MAINTAINERS: adding entry for BRCMSTB HWSPINLOCK driver

 .../hwlock/brcm,brcmstb-hwspinlock.yaml       | 36 +++++++
 MAINTAINERS                                   |  8 ++
 drivers/hwspinlock/Kconfig                    |  9 ++
 drivers/hwspinlock/Makefile                   |  1 +
 drivers/hwspinlock/brcmstb_hwspinlock.c       | 98 +++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/brcmstb_hwspinlock.c

-- 
2.34.1


