Return-Path: <linux-kernel+bounces-851870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D096FBD77E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C320F4F58AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917F296BBC;
	Tue, 14 Oct 2025 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ1+ybYH"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DD28D8DB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421164; cv=none; b=mTGDTaQGpMjDwwfj59gJ223B1lD3O0H2LggmFDfIZO1Ty3lExXpmU1GafC+XBnuDHUVpeoh0CZCtoGsJmx0Fdfn5U1Ea5RQlWMfn5yeQuHjvl0y9Ce0mT2KddAHJ/LfjjhZYZu0GnJi4KW61ZHEDrRCdhUDjqvJsvxzClBlN55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421164; c=relaxed/simple;
	bh=xiqFJOykby4cQK17gVtELNe3dahFjsM+TAM/4GuYD9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdd7dziSlgbIrTU6dVA5FFUiDUhaC2d4wFC2ZlTQKG9+RBnW9tBe6X25Im96mabvulE26L9VUp4o4z9tpz9F4VZKCKaSyIahHmt4rgHW19cWxTuw5iPiZ9LpgXzluz9pV5P+xxuMztlosX9bcWH57dvjtqFDluPN9z8WotGQ4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ1+ybYH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so4908934a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760421161; x=1761025961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWlNVmLtjnf8rAcNm545u/wbHRU51ZDEKLc4vvLow4M=;
        b=DJ1+ybYHL4cjKKbSwkXU6gG1UUY9+h5g+o1p/XIGZoO7DSK4y/CnqS5A0e+NYJe7fP
         09KHxRjHC4ZvC7WGZP3c3yZxE4qNP4pH1mdTIi8GbuAVtQKELP2d9r39iSBLUIq1Qf/r
         c4UDvNA2xUsSQGhcPrxQ85ELUVg3HwxMPDwRAzm748x9/YtMvF6vhP7v2RgjlvxhcvI6
         OONC3FagZW5enMG0bpmzBxV+JKy6mxneZF0Yb6Sy1bpjQ2ukXUiJJHawKG/XCyUNQwin
         0wEeM6So8r42Wo4X2VfkxllL7k4zH+w1byiU4bvSI0qU6gWP2UL2Tx8VymUZqjAPYkBu
         bXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760421161; x=1761025961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWlNVmLtjnf8rAcNm545u/wbHRU51ZDEKLc4vvLow4M=;
        b=WwaqVPelmXNHDMgJx3ivkjSMGQM5ywMYJNqF93+HmV2k0Ga7qxgDPq86densVsyDm4
         9AE0wnrjmoHEZODzPHNV11ObHwimQ9OFFSrmB/R7Wr6XqW8omQdimE2prA18vG3QR9st
         7XkMI40fYlDMkH51jnYRX2/uYQS9o4i2DbOmHHVpinzViYAWKtwEPztJbZJeqBy1Ezkh
         H3Su7G9sYHG1PbrowmpGwoudrVmSltKhq1UmrR0Wp2rWXFvvU6bC2lxzxafE4uKz4Kz6
         aGTs2cBwNXzx+7A4eIDpdyDkiUsAvC8bRRxxKzWGDgng9YZUU4YR0zwtYl7/Q6Nu55oZ
         RbbA==
X-Forwarded-Encrypted: i=1; AJvYcCVeKmho/InFZn8W9OQNzVIAWelA26ohDdw9uoIPbZd0O6ugFXXo5m4koF8dIcYkKhKrsQUXdHPthHnDIwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYU7n03wdC+dMLJ7LfpQeGj7KqeWa6THThs6Ec1zMxQgMHWd2
	BZQ6gLFhYHWbp5Jsb7RFS7GWnFlHM9puRszoYy8AObvjDFWoPD0lPvEH
X-Gm-Gg: ASbGncvc1YL/Decszf+9NUu1l3+cC4FuERvsbllKShkowAAHBTk59zU6v3dS+HwcHj2
	qaUFDNVqRrzCZdKfzBi/YeM3D7ZNGvnysmTp/OiolesMzBEB+WhQadq0DPLQwM8E0g6JfVxwFxb
	ObSlYVc1zZ6UP+9D9/1mVMM4qoGq8djeu1j53M04CRexKjPZrIYnBUp6Lj5sgub8WBhONgjPqmr
	MVo9/91AFRBvwzpdMh4NanX9qBbY+u4KFfoV1ZwHFjEuivQhO3FAKFTlQj2PVmWshciYPajf1gv
	2fA5FaHNbQIk1UvNYR8XhRWQeg/ehVWythKcqFSx2Hrp2P+JYrsd3buNttwAmXdmxTAE9pTWu1X
	35U1itMSzMO3wiq77tzg0oy5zxXeiBfGOoG+gR2RcDXI0d0UpkTCsWA6DrVxCQiPFyxefWbrjiY
	k4oqY=
X-Google-Smtp-Source: AGHT+IGZ4VytOKfxuKimiMVWhQiKhxNFaYk8/G36/eeE0Sx6uLTpUHGY3Bg+9lWRu14oZFzlLrNxWg==
X-Received: by 2002:a17:90b:224a:b0:332:3515:3049 with SMTP id 98e67ed59e1d1-33b5112504amr30797652a91.4.1760421161516;
        Mon, 13 Oct 2025 22:52:41 -0700 (PDT)
Received: from arawal-thinkpadp1gen4i.rmtin.csb ([2402:a00:401:b8b3:f979:38a1:d361:cdf4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62657166sm14391472a91.11.2025.10.13.22.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:52:41 -0700 (PDT)
From: rawal.abhishek92@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: arawal@redhat.com,
	jamie.bainbridge@gmail.com,
	Abhishek Rawal <rawal.abhishek92@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] r8152: Advertise software timestamp information.
Date: Tue, 14 Oct 2025 11:22:33 +0530
Message-ID: <20251014055234.46527-1-rawal.abhishek92@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhishek Rawal <rawal.abhishek92@gmail.com>

Driver calls skb_tx_timestamp(skb) in rtl8152_start_xmit(), but does not advertise the capability in ethtool.
Advertise software timestamp capabilities on struct ethtool_ops.

Signed-off-by: Abhishek Rawal <rawal.abhishek92@gmail.com>
Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 44cba7acfe7d9bfbcc96a1e974762657bd1c3c33..f896e9f28c3b0ce2282912c9ea37820160df3a45 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9311,6 +9311,7 @@ static const struct ethtool_ops ops = {
 	.set_ringparam = rtl8152_set_ringparam,
 	.get_pauseparam = rtl8152_get_pauseparam,
 	.set_pauseparam = rtl8152_set_pauseparam,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
-- 
2.51.0


