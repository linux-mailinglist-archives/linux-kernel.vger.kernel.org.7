Return-Path: <linux-kernel+bounces-887307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE4C37D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DE418C7F81
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E6634887C;
	Wed,  5 Nov 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NycLZwM5"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07982BD5A7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376617; cv=none; b=ISxgFdLKKuVAqZTeH6GTSxp5l0DUIgnQvxQ4rXboORQF/sp/GYyhd5+5+yIqEIuDrEYigwHgLHF38hTYGj3jonkAj1c176phuoDb6smDl/G8Z97QcCWQ3R+cGwk4zxtlin6yg1VQ3HwfTtyEUre+j1iBDbErWegFHVJQ4SgTeHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376617; c=relaxed/simple;
	bh=tQi93lzM5aeu3ogJvKrADSMGFMS5RnUQoFSMx1fNffQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XH3OgisnfjET6hWqsmNEGjigg+gr3OX+rSEKjzQJBEwBo3S3GuQDpm9MyXm5stweMcUHTwjZdCLq7zRmo5SmhNIeHD/AZG37JxgsSZd/hSaYENhSF7d5XLsjBCfgLwOmWjrrO49NuqgeckQ6EbUSdtsQBYLYEvf8rw2kA/f2uvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NycLZwM5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-794e300e20dso1035339b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762376615; x=1762981415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=343sy24w6YTxt7tYy8ayiZuHRTB8gorNxc1SSzGdAHE=;
        b=NycLZwM5DYBbAPkdkP/u7/TGcz82iExx4YXTXPP3mb+msqZg5ZeF+nqM2EBSTMK/Ke
         1TZSyU87a3isBguN1BqhDa/1TysAfHqifjJQ5IWwnzRDomGsat1bvmhubSHJHKbH0LtE
         xLXMAS51VCo5dlIHVzZpPlLTRNd8u/cctmahzSl22iyQ3rTXiEOASRrLCj2Bxx8F14RW
         k7+28sh2eeYmDbxEha1O99tqCKWiHEHwvLEus1SiKDlVPWcD3hYuYdvALWywp9oKObqo
         hnWpoSGuH81feVmV6fqCE7CDb95PU1fHuvZDWhok0C7s15hcCBP9q1mmQASVIQ0IPULU
         bx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762376615; x=1762981415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=343sy24w6YTxt7tYy8ayiZuHRTB8gorNxc1SSzGdAHE=;
        b=J+FWLdAgJq89FGEVoLmxUouayVZDvJs5EWEfBqS2JMrl6lySyKE5HRUXP2j0IAM5Vk
         9DJGrKzcE6ZEAYs4QqYmY3xzd86+ri/2vvnauem/jjWdGnqlEFKGOy2IBH50UspnDTjO
         RNmGpvxsJNwYU5qsECP+tqZD9rcUeJT+yQCpwG1yHS6dqyd2AKCWOoYjp4LkigK2LJqJ
         +dYWe8B1sx4ZXtdQ8/0Q4e1AxHKQZAmGZ23iyMfGqV2uIjb1JaZtRsqbZzuBAYG749J3
         K1uXFlhQZOoxdwrSIbgip3a8Ts5215GKsjFXyvTn0aLu1Cfe6Q48uuW+eFgKlpnTAy9U
         W/zA==
X-Forwarded-Encrypted: i=1; AJvYcCVbibsXvfbEQrTAiszPwgxu1EZSJUC34c/UHFRz/mW9AyLAhLdKqWscwKFur0JqeIPi1TqR9QAKTuikAf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHy0Cws/Zct4zPhOPpOfvJ9xw+iC9G4TlIGOwl/5uOqcmSRLZE
	4gkR2BHklgYyhGKhh1CXY6/ShETnaw3Ws2GgiMgtVZISUNPav798IGYD
X-Gm-Gg: ASbGncuDtqkx4fwB6PP6zuIq+44GqH1Apfy5zfiBNuM5NKncXIyc3yQHUs0aPZndc94
	Ko3gD9ni4UVoOA/fVEpc2Yt7ZwZrTmw7NS1iOaHQNXhtUMqq2E5zE9afgSFegp65JV6OQCRk+DY
	+vpecmc2aFJF2UFgAH6lPuWmd/qv9CCu/wYFCfYlrT6rj1180NV8lu9xJLPRoJD+3xKDnN0ToCM
	IAXvURzWrg3yzY0fFTU+2yn0LwQw42dhBwQT5s1tmyRIaC+RQL5LRyPJwt+ozD88ZWYoKdAoQTQ
	wQOTajwLzuQ7l+8/6C07RVVYvi0dPI/bvAjorjihsRcbQOfq6TXy474PXsHMkScDaMvvPzuamMd
	Hx83BILDh5cprrQUC9OxmzwxeQHebytDD0v9I1/hHQY2pLuQ=
X-Google-Smtp-Source: AGHT+IH9KVolxbFQMAWQh/itfTmucWy+EosW0ssU2GKl97kxaV+n0qi7R7CaKpI9HbFQndlA/lF+wg==
X-Received: by 2002:a05:6a20:6a1b:b0:342:c634:e272 with SMTP id adf61e73a8af0-350df200d41mr1036693637.28.1762376614938;
        Wed, 05 Nov 2025 13:03:34 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d125c93fsm13626a91.14.2025.11.05.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:03:34 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 dmaengine 0/2] mv_xor: some devm cleanups
Date: Wed,  5 Nov 2025 13:03:15 -0800
Message-ID: <20251105210317.18215-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devm cleanups that are now possible.

It's interesting that this driver lacks a _remove function to free its
resources...

v2: resent with dmaengine prefix
v3: add error handling for devm_clk_get_optional_enabled to potentially
handle EPROBE_DEFER.
v4: remove request_irq based on feedback.

Rosen Penev (2):
  dmaengine: mv_xor: use devm_platform_ioremap_resource
  dmaengine: mv_xor: use devm_clk_get_optional_enabled

 drivers/dma/mv_xor.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

--
2.51.2


