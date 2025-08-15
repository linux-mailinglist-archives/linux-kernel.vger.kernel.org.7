Return-Path: <linux-kernel+bounces-770150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22FB277B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83A61CC15F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0A7214236;
	Fri, 15 Aug 2025 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuYJqf6a"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B714A8B;
	Fri, 15 Aug 2025 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231696; cv=none; b=piD4e8CWnqp3mu70B/SH1h+2wuKvblBNqnuQaBsDSZDUEveBltnJYXoL8DolaqnF4f8oQ2QjvsJ2qZYLInRIQJXfDNfgxS16v6gsJkKJ9Q6Q5NGcefz0U1QoC7+t6H45NN94KnbJQwbxVcI99Pgz+xNpAO3xXdZly88HxXdztDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231696; c=relaxed/simple;
	bh=8YF2pBSVJdTYrnz03ExqRUAIoZAWFcg03CaphCB7xy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zk/ljTDo77SqUSROtk36IlJqXeXgKWjfIAmoOMQBPGAgXf4PRa6c2h/EIx1wX2PrseOeoIpbdXv/KiZT+2ZgAraGO5SzZHCCcaBIHrAM3GKp/hGJxg7dRTOgAUkBzkhLRWLrbPkyAzVxZnx3tn46Rim8uA9OvGc0rnHIGqUXDF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuYJqf6a; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e570045f4bso8200455ab.2;
        Thu, 14 Aug 2025 21:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755231694; x=1755836494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mH9Z2Inhe6F3feuLMWx4CuDByALoPXZot7i6CuHr5Ig=;
        b=LuYJqf6aC7z1+hMw1y1KEf7Nak5XlVk7cxexCTm5/gmr3KLe5n8D476avCEliauOpm
         33lMoKn5DRW7JDZQMSqgyKMjwCt7iFJxCF8pkw0J9qH2KofG4gmuPyBsH8i+6lizqWIb
         m8ybqGY0sY+vvoXXtYeWkU4flu9CmXCjDZvd+VcyeGZyWtVOWHg00Us7dUsb6MtwalIN
         jTXvcgJs0eAtN9/paqHuIl9UU5hx5jCJMVEn6hsdZbcCyFtSzWRU7geB0NNyckEtT11X
         hR8EjTKa0kCfUr2sxC873N35oLGw6n5iiOjVkZUi9wPtplnZ+w61/sXdCZAO5FMubqyl
         htLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231694; x=1755836494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH9Z2Inhe6F3feuLMWx4CuDByALoPXZot7i6CuHr5Ig=;
        b=bfm84z1Vw/15w6HNmbi5W/hYdWPWEVG2bdJZ4ewNhc0+UIF2Jz5rvM3a55F+DMXnoY
         R2GHfBd4uV8luA1jMU/CRzSECj83GUD6BP8RwchwD0nNjG0kZUzvhCE4KwhNoC3iu2Zp
         iZtDf2+bYqZDpxv7vDGnOJzwS7Rrvpm22O08HQQ+idc9EI7yoJOAQFEVnfTb/xZpPUUq
         GyHGVOaprMzWJiz5QucqoDrKzkVzUnpQpcT2AHooZ5n+Yxw1OOGq9lOJ1nmwFSPoFfCV
         cnBXPIyzc59IUEbR9xkgLItOi3Ln0Wrj2KvnAIh1Iha3T1B9DO6VE6isGfOPGwQ57JaD
         6mpg==
X-Forwarded-Encrypted: i=1; AJvYcCWyMu6Y4defCUpMTlfi7pqANFXcCmXeUCvMRolqwSql9wtuRaWHWub3pH4EX/LXIrvWqon+9SpENxKfbFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7WsCmtB02Vo8ml4yp/7QtZBIE9jln4siz92JPI0L/CRE/unu
	cLACLFc4B6bb+n7On+rm8V+oOiy3gsRSAo5ChKm4NTyyvN/Img3S6bHm
X-Gm-Gg: ASbGncsdkUBvLjkXOL9ArbNXYtjT5PEUcHYmo2e8OnoW+A3ZQehwWVZIrV5YZoKm6T4
	hrIfhsesmQ4b84/FXdOihtDuCLlSAdX284Z6BSdTXFi9ojUfM+hyjXvr8BmgbS2RU96pFfu8htc
	qAJY3PAumulv6WGYSd8pgGqk8XsTNEMzxBspp4LqKYiHPZVMOPLiGa9ORyugA3qLfWTsFIMrWLq
	adbcvl4DFUazHguXXA4fH5uGQPkouS+dnralBAmVztWhf6utMVCy8hrUlZLr3mHWjNL6IQK9cHD
	uo2e74sgES7YvaUnDxoX93vnpUivBLYJa7dK4sIPuPDw9DrwxZlO4MNY8xFA81mjw0o/Q3fbmI+
	sKHE87eWwqnsHye9c4dyXYkf+/romhRjVRTNpYB5V1ALA1pv653nUuxXzeujGjMZitfo=
X-Google-Smtp-Source: AGHT+IGUnuQr4kTd8Pwi79vrAZvrte0ZA2n9301dvRr3oMR1sAmt1Ja6G7GSU6Ymha8EALPUtkN7mg==
X-Received: by 2002:a05:6e02:1a85:b0:3e5:2646:df03 with SMTP id e9e14a558f8ab-3e57e8a63c7mr12535545ab.12.1755231694279;
        Thu, 14 Aug 2025 21:21:34 -0700 (PDT)
Received: from localhost.localdomain (65-128-248-47.mpls.qwest.net. [65.128.248.47])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e5a585esm1689365ab.16.2025.08.14.21.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 21:21:33 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	shimrrashai@gmail.com
Subject: [PATCH 0/3] ASoC: es8323: power and mixer controls cleanup and revision
Date: Thu, 14 Aug 2025 23:20:20 -0500
Message-ID: <20250815042023.115485-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a revision of a previous patch submission of mine wherein one
part was accepted and one part was not. It was originally phrased for
a particular device using the ES8323 CODEC, and I was advised to make
the mixer controls user-selectable so it was not tied to the needs of
any specific device. This submission brings the DAC and mixer controls
for basic audio playback on this CODEC into line with the DAPM
infrastructure and enables their operation through the standard mixer
interface.

Shimrra Shai (3):
  ASoC: es8323: remove DAC enablement write from es8323_probe
  ASoC: es8323: add proper left/right mixer controls via DAPM
  ASoC: es8323: enable DAPM power widgets for playback DAC

 sound/soc/codecs/es8323.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.48.1


