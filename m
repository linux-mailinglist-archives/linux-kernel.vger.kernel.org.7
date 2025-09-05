Return-Path: <linux-kernel+bounces-801950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 194E9B44BFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319F9AA052A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4D3259CB3;
	Fri,  5 Sep 2025 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBLgz5M7"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8092417DE;
	Fri,  5 Sep 2025 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041026; cv=none; b=rdIaxfdNMhBB15uumilaGQfaBF7babbJnkMTb02aSpSRB/kDFVgtoeC6XGDSFkYK347uxrnuaUnlvC5chS5zCeIhhjS3iVodp81V5ZH2Aka+6HL7uqph7+8mCblXa1lSGv3D/Qcb7+X0tpTGetExpneUElFa2ze23uwy7XRhdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041026; c=relaxed/simple;
	bh=mo89xRiKCHvpFUmyWkO2HTmXZSy3UxCuEX5I4O5M2JY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2ZMLu+yOY3WSsKmhZLeiYLlaACLHoUVZLvhyLEQ9opLxry/ZD2PBbEsBLqNsLasJt5ah8uITb1gNH5UxmsYCL1UGfLqjXrbG3C4J6fjjvXi4OaBBsBAllTFmoaDWz2/rrXPJvfYGoi42vwyTDEnb7lWNsQm01Qe+LTQ4QfWDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBLgz5M7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772627dd50aso3157300b3a.1;
        Thu, 04 Sep 2025 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041025; x=1757645825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so1w6SARn6qmC4AOrbPwt9pSODl5A4iWHzB1CjddN4s=;
        b=IBLgz5M75Wwt/vPpbOsp1maDWr153bYMS1hOVyKpB0y29AnWqHQ30R7XRJIjk+AIbt
         +HUhYBMphULhC5lrrehGY2fw/Vahd4E3dXUd+ouhIq01oADw9zik9jN2TlK8vGXSHC/0
         sa0L/3CeX3w7OgR+M7VUEUw2mivO7iDb9C+f10a7v3gRx45qGnCtEpelZa4aOyvYKDLo
         jYOXsDiSv32/mZtrVzhK884GgQzDzcL12oY9sXlGbSzw/tUtZRl62+Yd4480QoKFQfHH
         jo3G3GXhhX9vY63O5bXMZqOUtZAaUyCQumtUJgEyDpQvlrqjYN8ClnFFl+Cd0BQhooMX
         xmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041025; x=1757645825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so1w6SARn6qmC4AOrbPwt9pSODl5A4iWHzB1CjddN4s=;
        b=jSVLEu7Caf3ORWsoTzTBjLZAqKzDEuVXSvuj49xLDAYrStGJ66IpKdIP6DHluingmq
         Mp3jaGmRf3MIORdT5M6wFMespH2PjnSJl7r0Yu9VTQkyPtSWiF82FVxUiB8WMOzMnKNj
         Ss6/2y+o6Orpm0HUDLQUILlsX02Zdc58rWyhIBE8acuoqRxBfJnm7x8atT3cATrSkP5x
         1uj1CFQUdQSaqeP88d0TFYzR7zb/oi7nUrxlZLW+KhCkmYCloZmxc+YIOreLCtFr6rn3
         rojfw3MGG98bFuu7Gb+DAFWhAQJkHTR7H6mBzpC95V2jKkwk/WUqX4VQk47Q/CHjUxkN
         Tavw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ve7QEemSot1eeafUpN3/+oJO0YUfVs0lmHFFwIFQMk+H4nvnL0aG5UDuEGZXzPGzC7yPhxtKAUW2@vger.kernel.org, AJvYcCV8PZPvfzykr9h+QDIW5iIqR0hAP6WOGDL/d/Ip0b+at8xJNEv0DELWEs+nrPCLMHTZMQBrYgbx5N3FofDX@vger.kernel.org, AJvYcCX3g29wYXc5QlSMzpIoMVdJJD9PzBJ3YLznGNmENNYWQocLc8WLBRmp5h/TPmnRzrzTfkKIMQa8owod@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWvlwtaFS9HKZ4PcDo2aPJxHcBdhka0KZBKuE7cyJmLznM9i8
	FPVxi7nadgtchr/hKTwbKQxxjYk1C7vX0xdYI72o08BaH6XqnNLPewnL
X-Gm-Gg: ASbGncvr+9//VcSi90jnF95QdSR0LyhYwrsBA7wgYpaVF/rwm/NA6qAAc4BBs2Nq/op
	kryc8HWmIVVN1zJQ1iic0t9NNA83d+wZqZkc3Dzvha7sgOLw9IpER1oQZI8eLI1+FUftMrfINT5
	z6aD4K9ToRpefnkTxcIpnHa2/U3IZOSD94XuTc3a6UDNVUHtA00O9dYzdF6LW4lVGKyiR3SF9J2
	DpB8yh8zkinCQv6mRqcXQnb5yDtWLXbpFpXbOeZJK57L8nfzBmbuqvVowUZaOsViBUrhsAQpkI4
	7k8c5mKtTGImtUYCi+0Chbv1M2cvjDqIUfZDoRJvvF+OjQn30Ni14aumFammqeMlCtEy6XWtA66
	Bc0dSvETz4R10lPIBo2nIVQ==
X-Google-Smtp-Source: AGHT+IGxi0bFyMNWI1ng9Srru4j1XYe6kK8wIV4CSfnpgd1yu92+nFzqOJeoOCTEb7GctJdWYeFvVw==
X-Received: by 2002:a05:6a21:9997:b0:246:1e3:1f7e with SMTP id adf61e73a8af0-24e7d6d01a5mr2400763637.5.1757041024606;
        Thu, 04 Sep 2025 19:57:04 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm9428588a91.4.2025.09.04.19.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:57:04 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v2 2/8] drm/rockchip: vop: add lut_size for RK3368 vop_data
Date: Fri,  5 Sep 2025 10:56:26 +0800
Message-Id: <20250905025632.222422-3-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905025632.222422-1-cn.liweihao@gmail.com>
References: <20250905025632.222422-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VOP driver need a correct lut_size to work normally. According to
rockchip downstream kernel source [1], the lut_size is 0x400.

[1] https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm64/boot/dts/rockchip/rk3368.dtsi#L1497

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index d1f788763..219f8c2fa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -880,6 +880,7 @@ static const struct vop_data rk3368_vop = {
 	.win = rk3368_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3368_vop_win_data),
 	.max_output = { 4096, 2160 },
+	.lut_size = 1024,
 };
 
 static const struct vop_intr rk3366_vop_intr = {
-- 
2.39.5


