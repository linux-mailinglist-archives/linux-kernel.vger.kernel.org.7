Return-Path: <linux-kernel+bounces-841147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1836BB659F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FE794E0F43
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8118F28850E;
	Fri,  3 Oct 2025 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/Py1bxJ"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2B23AE9B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483162; cv=none; b=QeebF68/sRhKMrk3KI5JvR/zishps940HQdXfGo5JMJaXZuI+vaYmO1ALazYtANq3MB7VGMg3xcG4WGPv4mm5WJKWN6XLWk0MpE+E5JuD/ms3wrh6WvVd84gknblDLEQdcvKciSo6KAyokthSwzNTZxp68rv51T99rOfP3lZh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483162; c=relaxed/simple;
	bh=AIBqP6X1xglTFsBX0c4o1XVrrIxw8qDeWC1k8/vRDWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I8wICANuLpQ+gl0n8GoOb787YjoF1o9WXQfQBnE6ykGIrlaodrGHxrZAGRq3HaCX1SM5NvNGL1kkib1pioDNxrTgx6D/e5mf67w7HIrkSAtBEhJd2xSNwnBSFH1U802hW5uD9d1PJnZqpQTZWnAl1MzM/Laj5be+kAdbGAv9pz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/Py1bxJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3304a57d842so1918994a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759483160; x=1760087960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIBqP6X1xglTFsBX0c4o1XVrrIxw8qDeWC1k8/vRDWY=;
        b=g/Py1bxJ6z3rrTkSl0LQeoSD5tNSQltfGYcvZSwuySZfhJ28yJUSREISwqUbg4WbSd
         ZNF8WCe3dtOpxi5pvjDFl2z7oUPZCmAleIxcCo92Odf/s1w6B5utIiEuChEOMOzN4050
         AZKvHBC9d8UiJh27YJ/cLrmlDjR3fmOwtYEWBY6WClhPpvWycJUAv/H7cGOpSKDIBVBS
         zzJxgdg0Gw/wSOQbcnZnSe+pOcg3XgsiC/0b15oFeNcAJf8LtetFj5Qn6c8szVqK9KoW
         VZvbWAsfTYGlE92yMJCBMMzdsa2vobd8QERoRAuZgGF+2EwnpJRkVO1Q0A0MPZMYwP32
         2/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483160; x=1760087960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIBqP6X1xglTFsBX0c4o1XVrrIxw8qDeWC1k8/vRDWY=;
        b=ZbPDsUBleDQvpniEK0on5dPN/oZybSUBmkZy0lZsiCqA3PvE/q6I24RQ5eq/0E+YE2
         km2xDPbkwK9N63qnOmXvj+UQRB2PY4v4OZb7MB9ql2/KMm5Pw0JgNpuxPeNJDitL0+Qz
         AlXESpXrtunEDTb4yqg9q+7QzUC2NcJfw5sI9CO6Me4eI0sIotAWcWnYgguo/gP2C2XD
         pxrJOpnuC5BFXI5UOseSXPBbuytVrkqGwfsPY7up8rRVmees3M5f0rTTVWLbo+KMqq2r
         Vnor57pwAqO+D7SZicZaXDtyuN97uwhCANnNqZl8aB82wqLoIQ4BQqAV6Wi9YFe2EbUY
         hDow==
X-Forwarded-Encrypted: i=1; AJvYcCWjeEjjyM+4QmTeRHFzkhmbVAtf8DmbI2sFlvZhFCG+I5Pefo2BRqk3cbPLgc5tVKuurMxC3a9DKvVgx0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrF4x9loAPcHl45ADXihJMPj3wx9d+zQexSAf/sjV+au0RXQ9r
	Q1gt8EUKwJDtOafASVctUXOxo605zcqvTRsTKnkOZX0AqFw1wH9nTuml
X-Gm-Gg: ASbGnctJQRFP3nF4nEA17m7IadkLdU8DCxLeLGNsrwx5I6x4VU0r+0g/LOsqLHDO3p0
	z5DcF0cZKl5TwIQOTvPNqeGkbNjI20dHhGcbLBaoXCYAdv4XRgCMa7Pl/B2XSIlcTTQ2oCrfu1A
	k9ErZcvMZTzYVCACTUNaarY7Dtcl29ie3a6xMcYBjZHNz8x6fl8CB6Ual+mRWXRqrDG7d6q2x/X
	V5OlfKAj0ywNYXNJ1SJqXFsQ0ooHCzrBMRAbsT9arW9r1eQB+h6vRSZAS0Wcm2NrepBuy8dOA9j
	T5dDdewBuCJc7S/0VGGc7UMhUImexqA7tbWhr3FohK3zC1GXZbVXaJxSe2h4FhBs4r1P6lknl0A
	NFsOyUzExFlAaVTW2A1Z/G5yn74XMvMtZQzzh9c4wRn3/wOfvm2d7vt6jTqEctoG07y0BUV5F8L
	nqmaC3YC4=
X-Google-Smtp-Source: AGHT+IHtCdR9ObWT7xWuCfZv7ZujUkZQPdWsZ04gKurgyaQnPlwUI4E2VfFo3orsXRVGmSM+5twmsg==
X-Received: by 2002:a17:90b:4b49:b0:336:b604:78be with SMTP id 98e67ed59e1d1-339c2784862mr2680566a91.25.1759483159749;
        Fri, 03 Oct 2025 02:19:19 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399bc02e5bsm4164019a91.0.2025.10.03.02.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:19:19 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org
Cc: rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	tessolveupstream@gmail.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: ti-sn65dsi83: Fix LVDS output configuration
Date: Fri,  3 Oct 2025 14:49:10 +0530
Message-Id: <20251003091911.3269073-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series fixes dual-link LVDS support in the SN65DSI83
DSI-to-LVDS bridge driver.

Currently the driver programs the same horizontal timing values for
both single-link and dual-link modes. According to TI, when operating
in dual-link mode the horizontal timing parameters must be divided by
two before being written to the device. Without this adjustment, panels
do not light up or show corrupted output.

TI has provided recommended register settings for dual-link operation.
I have hardcoded those into the driver as I am not driver expert,
With these changes applied, dual-link LVDS panels work reliably
on our hardware.

Summary:
- Adjust horizontal timing parameters by 2 in dual-link mode
- Apply TI dual-link register settings

Thanks,
Sudarshan

