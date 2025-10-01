Return-Path: <linux-kernel+bounces-839355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC5EBB1777
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719BE3C09C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E952D3EDB;
	Wed,  1 Oct 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V7ztuWXc"
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7C268C42
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342644; cv=none; b=rv4Z0GevF3rF0qJNVE09Ppw7abxkFCQN4J3xf0ATx/0gjZ/OJtTgR6hazc4LKcn8nGk22yonVnYlwE2JE/fHuLZnjSahwDSrY0hes1ZIHYD1iW3O3sQPLT/zqxb9BZGJ18Sz4exdsetTLIi3HHmMGe8sT3gj8kB8hrYG2FSAj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342644; c=relaxed/simple;
	bh=4D2u5+7Q4n316L058k0BKdEZoe/mLPgqNFtIcDxFUac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kekjdb2ma1/Lj7joNeax1ET5J6YukYKjwWDLswdKK/cY9UX0zR0M0yNGO/4CrnUQHPUOiW7uZUHHBQHkgrKgkhTRg8ELRfv3k1HEKGFjLl8ZliFetCdE2f6qzqEGPYC9+XnyNR8Yn8fNLbEIZNM4iUQ+x4T70hklNS5iuhvANLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V7ztuWXc; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7abbdf3c476so124192a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759342642; x=1759947442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecfc2ylaD/7+laCYwVlEzsbxMMAjlj+CWU7OhEl57sc=;
        b=MwRa/0IECND2Yiss+etOJQMY+KkPWxsIueDMDFBsbGJHHv92TYPoo1oGvR9SpUeYO3
         xMtsTESAncCCVwrqLGzpXqgSlLVLFS5b+UTFpxAKCJZUapOi565FXcZJymR56hXqoRBU
         KemFPOgPDRhMyiXrG/4hQfByMiUZwylumXBbqu2en/YAAUdLp6AInkVTwoPwkia0DRgZ
         aP001w89SAMTsTUaYDWMhAnxRdRwhKOSsfjW9QD6H+HZaOvIxRYYnZTwi2zBXtzmAoia
         DLEwk+1Ck5bTvfkdt/opkqBanyXZdS2ExuYXLlaUkBn4bA7FotPNYKaW1Rx/VHKbsBWM
         /VUA==
X-Forwarded-Encrypted: i=1; AJvYcCV2LkQufb6sITL6HNuUkS9srO4NPggpqvpqUlC8qYfyvZH3oLu34kq5iKNBdsyjz6cJFxx3qUy+ZVngTfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JdH7DO2Rt+wPW+gG8qMwBEIDLqfntXav2JjA7Cefe7AhWdv5
	YtyBQlDyWm1E4Ti9l9KpNvxye/YGz5G1DZnj3mTCCW1drrNsPbVXO8dxews4jA3LNBoOfxyjUV2
	S67pI47Z1lX9x9nn7F+TK27m1f6droFKjfNtVGEuIY5Cj8jkjw+VTWSk3UBZaEciie8BbEIyxL0
	fuaJRr0xeueZz8dzT6TjhuLZxb5mbAemMOxXkWGj9xrAjQ8N58Ern/P+d/GXb49iNqYsrhW96Ci
	ULYd6XFFt6yPoOt
X-Gm-Gg: ASbGnctEYPrG7IO6lzjRkHxYtAbrl67SW0UhuMRQtNIqKN417MwiWcfkp5rGQR3mJVc
	Sv1wYtbkzYul1L2qfXsOrP8sgR3n4NtPDBt39VeN34m6ODuqqaX3QnVIb4s/mripsr1dmL0Liyt
	vH7QBrEzEuboN4vFaGe1vMiQReAidSlPn8zwKte46G7ZkChbmOv1wot+DcyUIIPO7UkOqTj1GOO
	bdt+6fXfMtMAQCL501C1/d9d9CeAAMBUcpVL5qV96DJZ3uk3P2/kigyCYr27W1AVPsML/6nDc95
	hBLfPwAzBlyExhCTy5qdbb5l0tMswwjb1j2mNuKfFRPiPWi0CsEnolusrZ3g51o5DP2d6qRUXL5
	iAy4L/Gi+otZ8pFg9vgN3GSXAC4fZYyLCecILmr6ghIDa9dbaN43YHLDO1y3evL+qCW844VEpH4
	s=
X-Google-Smtp-Source: AGHT+IFuzXoEfn0Uw+ZoDtsfsjWmmPrcZ0duxNdgKKoQSO5kp6eK0XwT23Qdy34kgA9zw/urybYwM3AqO4jD
X-Received: by 2002:a05:6830:67d6:b0:758:21cc:a45c with SMTP id 46e09a7af769-7bddcf0e095mr3257913a34.22.1759342642334;
        Wed, 01 Oct 2025 11:17:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7bf419f511fsm10180a34.5.2025.10.01.11.17.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Oct 2025 11:17:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-87561645c1cso41019085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759342641; x=1759947441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecfc2ylaD/7+laCYwVlEzsbxMMAjlj+CWU7OhEl57sc=;
        b=V7ztuWXch+CaYdGpnMpGbAJJyYNbibHDHc5DXMdw7UR3EEBERaL8GwDk80pYIXBnK1
         fyxk0e8n0s3Ip8OH11vSRUZTP8LMFUv2aw7qRUZj+FzTWzI4M3tAJiVU7wXSzeKLW4N9
         ia+c2PoFhTrRghPBHBZ8b0ysnnuYft4Y4yxmM=
X-Forwarded-Encrypted: i=1; AJvYcCWLaxMIeZBuZAQUggo1KK0dWDxekJtf9H3tthZXdPJGu+3XmMKL9y7eMhHZ6MwknmhjhshYvd1fH0gSTqU=@vger.kernel.org
X-Received: by 2002:a05:620a:3193:b0:866:73f7:259d with SMTP id af79cd13be357-873796bd7eemr589522185a.61.1759342641387;
        Wed, 01 Oct 2025 11:17:21 -0700 (PDT)
X-Received: by 2002:a05:620a:3193:b0:866:73f7:259d with SMTP id af79cd13be357-873796bd7eemr589514985a.61.1759342640724;
        Wed, 01 Oct 2025 11:17:20 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55c9e78cfsm3847671cf.27.2025.10.01.11.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:17:20 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Adding brcmstb-hwspinlock support
Date: Wed,  1 Oct 2025 14:16:38 -0400
Message-Id: <20251001181641.1561472-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is a standalone patch for the hardware semaphore feature for
all brcmstb SoCs that have the same hardware semaphore registers
hence platform driver compatible uses:
	  '.compatible = "brcm,brcmstb-hwspinlock"'

The patch has been tested to work as builtin as well as a module.

v2 changes:
Adressed following review comments:
 - fixed ordering of obj brcmstb_hwspinlock.o in Makefile 
 - fixed ordering of 'config HWSPINLOCK_BRCMSTB' block in Kconfig
 - Renamed BRCMSTB_MAX_SEMAPHORES to BRCMSTB_NUM_SEMAPHORES
 - Removed unecessary platfrom_set_drvdata(pdev, bank);

Also addressing duplicate PATCH 1/3 sent in error as part of v1 change.

v1 changes:
based on fixes made to Intial patch :
url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/dt-bindings-brcmstb-hwspinlock-support-for-hwspinlock/20250712-034624
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250711154221.928164-4-kamal.dasu%40broadcom.com
patch subject: [PATCH 2/4] hwspinlock: brcmstb hardware semaphore support

All the review comments and build warning have been fixed.

Kamal Dasu (3):
  dt-bindings: hwlock:  Adding brcmstb-hwspinlock support
  hwspinlock: brcmstb hardware semaphore support
  MAINTAINERS: adding entry for BRCMSTB HWSPINLOCK driver

 .../hwlock/brcm,brcmstb-hwspinlock.yaml       | 36 +++++++
 MAINTAINERS                                   |  8 ++
 drivers/hwspinlock/Kconfig                    | 11 ++-
 drivers/hwspinlock/Makefile                   |  1 +
 drivers/hwspinlock/brcmstb_hwspinlock.c       | 96 +++++++++++++++++++
 5 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/brcmstb_hwspinlock.c

-- 
2.34.1


