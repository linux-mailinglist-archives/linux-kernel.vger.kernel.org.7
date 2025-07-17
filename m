Return-Path: <linux-kernel+bounces-735866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291DBB094B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E841C4686C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F52FCE00;
	Thu, 17 Jul 2025 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuicDF0b"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31401213E85;
	Thu, 17 Jul 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779805; cv=none; b=KhjzdfSOsnSNHg6cmRso0btBQ3UpGhcIB0+HVevdS6M23QVpdLBe7hIWOaB8oYWWG/ZEvlY3ONL3bpGBnVu+4LG0kzbQXVgTyGxXTbSSyFCCxUkInJD5eaIlNU+El+rx5+MvCNPju0m3y5HVYnhifH21B53tjgyMoMvmQmAknT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779805; c=relaxed/simple;
	bh=PyayYQ0JPKYC1bSL+yF6YQ9AEnmvymFEa0T+fiUNE9w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dtckiInXGkf4GRUrvOplOyd1mJLFy07edSJCGgnG9lXAP5x3/FrBdxe+dLKIJEZPCzcJnzdmwjNtNA3lVbctsLe0A7Ueq5SpYIPki2l73MAEskDgJwDF0unnoG6GDnnOW/PCJHvuZ7NzEDUAB5rBX5XhzYttSrEizYWQFTnM8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuicDF0b; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso846069f8f.2;
        Thu, 17 Jul 2025 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752779802; x=1753384602; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzt9wZOnZ6+CbKPnKZeU8dqGY8Qw3egF+06TS84cda4=;
        b=cuicDF0bXb51Qi9S+KWHZNmXYbpjX39ulCr0v1ToRNefXgqI5SBhJtrRbYnlLrDDQH
         QjhY3KhZnnUPomQC5vya5fjh29vYt6EOUHWCIClBfwDkTDFe2WN99/RSkBgxsv8DnJ9U
         l02+WEhqS9SCvGlcYyNft/mBCfoB/1LfT4rHqqmBBUaNJsE/H6n5Lr7lHJvoWb14Gb86
         mvCgjo8LR4T4eaqXBvY3rT0isOmAGN1Db+pNP33tx6u4NEpmIaVlb2bhwCSwxAV1fQJl
         fJbwWawgezfIJURmbAJuuZnVXgTK1XmIapAg+uxe8lLd1jsy4jy0kKSLy36SYDhp2cS2
         EsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779802; x=1753384602;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mzt9wZOnZ6+CbKPnKZeU8dqGY8Qw3egF+06TS84cda4=;
        b=YsF5owwvjHaL54MFNiGktQemvdlIvnNfyMcXJecE5ZqgihIPSERtai2d9HN33E9HL2
         BV5dHWAArS0GiIU8zcYqDaFaGuY82QBps74Lqn379U7MfPlcyZsWwRBMx8DWkZTF/irB
         fVzlWY4gGubQwJNsy9qY7rZ5ojQ91ZRCHsz0BaEFXZLKmLSBnvPD2voEaojD7gS9oNvl
         WXVW1fG3LFLUjl3L6zZVVvWPcNNk0avjVPLMfWXuIdALwvT6wFsDOTMechLGgl0gl5VM
         x9vxWyThMY9odhnxCiF3e1TWW2LmntiGhOENxw8huWWPbHV8MZB37giO1CpQxo9IicZ8
         3LJw==
X-Forwarded-Encrypted: i=1; AJvYcCVrqkMeApjeOCi8olKV6bWoglmcQn3+smiM0q82zu1BMEgclnph4dowvbJXpdroIq7Fm/UpwvfoD5CG@vger.kernel.org, AJvYcCX/N8pafVZO/mi0zmSGrkY+sSAcZ7umbIjwTXFr5bBsbuejjDvTfGFcj/+r87XsRCWn6N1Y6ngNTh022Idq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6r5J7LCd5GKSuAARcVQyYvhq4bNO8Zl2pcDE7iqHKlfX7M2dn
	S+TTssaep7ZEN0YRIIw6wTFE9jFI33p8cwe0gApmBxBFLkQnMGbF0bRO
X-Gm-Gg: ASbGncu16rC8KJUwgv3S2UU6VhKp0zoJawDYSfoxvcy6+iyPSF/wTNKHs/Ryra3j27v
	PW08LRYmtwl7l+UmBftm8ahcCgkKtz251GWHlikJUMBFAB4312WYTIHpr5+qJUlVtUtK4Tuk5SE
	Lh7THcb8SHaOd670/BHsakLNNRO2ioL7/9fYcSil9pMR/5i+ltQc20RqrgZMdkUa98qj3bC0QV4
	+pyQb+G79e8okVtLSAobky7TEPsyXLOcMqtgwGREmpGtDNrMKo1g1kCY/ebifwU7IJy9QzqBG9t
	lo3afjbR/YvwZj+sBNy4UMwaok4jMKkHSuiBwzdEBA+PNkHDlaVFBUdQEkweY3vPBlRZvwDBD4E
	TyyA7mVMM04PdsmYpjDy3tbNawKe26uc1
X-Google-Smtp-Source: AGHT+IFF8lsVWJTJwrDMD6i4As+eyuiIbEESQQF0qhNLx6tTwcszxJEOXDFYIrXcHilqwhBPrGxWeg==
X-Received: by 2002:a05:6000:420b:b0:3a8:6260:d321 with SMTP id ffacd0b85a97d-3b613e60143mr3320230f8f.3.1752779802135;
        Thu, 17 Jul 2025 12:16:42 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8dc22a8sm21918017f8f.34.2025.07.17.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 12:16:41 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH 0/4] STi device-tree display subsystem rework
Date: Thu, 17 Jul 2025 21:15:31 +0200
Message-Id: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANNLeWgC/03M0QrCIBTG8VcZ5zrjaNNYV71H7EKd2w61OXRYM
 Xz3bBB0+f/g+20QXSAX4VJtEFyiSH4uwQ8V2FHPg2PUlQaBQmKNnMWVWHBPH+7MIDZScn1SwkI
 5LMH19NqxW1t6pLj68N7tJL7rj1H/TBIMWceN4r3Bc1Or6zBpehytn6DNOX8A7qr4j6QAAAA=
X-Change-ID: 20250401-sti-rework-b009551a362c
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=PyayYQ0JPKYC1bSL+yF6YQ9AEnmvymFEa0T+fiUNE9w=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoeUwQs4pAM5O38T3nlF8WEU7Y1ach2SghQdlSd
 adJbgagmsiJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHlMEAAKCRDnIYpo1BLC
 tUxUEACQ1QihV0/vZF+Z/ZIMLTCNbEanzLlzjAJHu/gACUzwmyqQJhxOU2sI0NlfI4fNnrDXVXX
 3jXo+32bwmKHyRv00ls59P4a2tNtmANDSLl29KDKXRQofRMWv8Z4gadAbZyH9+vV08C5a34d7KP
 HGmgHSzq3EzRHjI3+uLXSSayuLzZlWKc8wF0XPbSLvna47gLHxqjZ9TQg9QOIyswiDsIXchnSKs
 JSJGCTSQQzbU04fuToq8JHXUSoMUHclxDppK0+SfJ/r77L4+0DWUy2bzuyf8G/ixqNragahIjBW
 YvoOvV/xGgXrdKUnt7cfP2CRRCpIcgRUx9KL0hBol/m6Xm5QuSY66guBwaNJkBCBjLnibmw/jab
 uny3szjVv6tviSINjWBqFxxIqV9lPGGjs1krT4VhA8pxmNIDvWhyRw0iz+FbyU/8nhyKkFGKzwM
 egEKm3+tFJSy5/nT/2BiC7P36ip9UyFi1s7+1lhIV3kY5ZCy6j3XDET5JyyC445WceMSPGy9drt
 PdKXf1ILK1uaMaOTREFlH5zQb8pADUj/v3A8n1c7PJPtC479R7Er/hFwGPD8VXo7lU4dALC7IGA
 oW1UaNYAKydYyRTL0a8gHxXM2jeIj12ozjm2xhrJO2uE4jZ+aav5Ou/vGzJn29QZ0zJqBylIydS
 4yPttkUKVVLkHTg==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

This serie aims to rework the display-subsystem node, which was
previously included directly within the SoC node.  This was wrong
because it is an abstraction and describes how IPs behave together, not
what the hardware is.  Instead, extract display-subsystem outside of the
SoC node, and let IPs describe their connections.  Doing so helps the
readability, and eases the understanding of the hardware.

Several nodes have been renamed to stick to the generic names defined in
the device-tree specification.

This series depends on another sent a few days ago.  It is not critical
though, since not having it only triggers warnings when building
deprecated device-trees.  Please see link below.

Link: https://lore.kernel.org/lkml/20250714-sti-rework-v2-0-f4274920858b@gmail.com

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Raphael Gallais-Pou (4):
      drm/sti: check dma_set_coherent_mask return value
      drm/sti: make use of drm_of_component_probe
      ARM: dts: sti: extract display subsystem out of soc
      ARM: dts: sti: remove useless cells fields

 arch/arm/boot/dts/st/stih410.dtsi | 316 ++++++++++++++++++++++----------------
 drivers/gpu/drm/sti/sti_drv.c     |  18 +--
 2 files changed, 192 insertions(+), 142 deletions(-)
---
base-commit: b9a572f471993d3e8bf874fcb57f331d66650440
change-id: 20250401-sti-rework-b009551a362c

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


