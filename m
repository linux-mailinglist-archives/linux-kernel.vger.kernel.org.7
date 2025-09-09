Return-Path: <linux-kernel+bounces-808263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A95B4FD44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810DD4E07F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854D5340DA1;
	Tue,  9 Sep 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dycQUxrK"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803AA21B196;
	Tue,  9 Sep 2025 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424663; cv=none; b=Aim0BPK1YlP9MLbXEMBwFbWgHx+WAQZf3ywAdG2/8yU1iBKoUWrUhrtp0CxUXKrZ9NY1kwIFM9SbjLq7v5m61poER+YGXhotMjOqLbdPiozvAuysdmPgwK60cKaFgBkBMCTEmKqJBoP0TkhRfQh7/uK3JzSQb7wRVnu3PFW4h9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424663; c=relaxed/simple;
	bh=j4yCC6gNIuYGKygrC0j+ROF1XiTBwIfsY3yiaplkHjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFOgkJO6TNWpSwPW2UOn4KoRENoIUo3YdZYsuwrOEVoR24cw7retR/XxsBdWLXDQeialgxRExiEqWricCcecUPXGo9x96BrtK+9GBf2TIRsFT/u2Ow3NlAmAVnswmlHLNzSBzqJD8xOifZ9PkFPUU1aEJCTQHlaOegYxfOahJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dycQUxrK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-329e47dfa3eso4906315a91.1;
        Tue, 09 Sep 2025 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757424662; x=1758029462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dG6XF2PIOMDeR4MOZBWi65Kf7chBzQecby0CPXw5mi8=;
        b=dycQUxrKJMMjcAG6Pve5sZAE/lG2SqaFus3xnsHNAJjQdi2qeQRngVR4rjEb9fpq+U
         /KupFc2JZb9znzOTDKKiQaZd1aPLUOEYoOA3zy1vzWn36hQsymUH19prqC/J6FfD2wzD
         rdAfS2XR7CwIDIVnVXA9HgIUvmpLWojG+V3U88lLYt3gCRU96WesMj3VTfFuJJNLiC8v
         MgVupoTvcYZ+MHmqBneXVX8o4MOZ2dgxCJMW73uPqOYfZ6D2NoNviWlkScQz2PxN/6Py
         QyxzF9yU41RBQwwqI21Iuw+8mUj4s8W7HAroJtJqh3AoIW6d1Oq0HC7n2QW/yk9KKig1
         NvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424662; x=1758029462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dG6XF2PIOMDeR4MOZBWi65Kf7chBzQecby0CPXw5mi8=;
        b=MZ/lQ5V99mdSN3JPPLVkA4cElGj9fEPVXrxC/xCJbtpCvwTLewtTb7KcJ5Q64SUatD
         InTjodDzSbPs7f8567DqDUocw2wdkfolNI1GcQv2b7WYi9DRfS3oQjHvrr4jQgUtnjP/
         7UeFLk3VZK42AB20zed3fkr5PjokOMSs18aBWsljpUsSgIZn4nXh1olgPSTaiOe64Uex
         lCBHhOZDzFn4ipkKMXRthJ4oWcFuPfwZZP9SDqeErm8UJcIACVhW1bztuu2an9qLH++o
         zTrNJr1DCD1cgAy3+ev7TRtWmPZS6C7uNMRTnFiGZghK/ZJaWJj+7woFHSPvJ+lfeP5f
         eW/w==
X-Forwarded-Encrypted: i=1; AJvYcCX2+JQ2Z1OQOaIGPWE8oryiPTAtSpAJ0+GyPIiwz7qMtrUCEXkIK26zFNMC7i1yTZnfSDyEdshOXMjY@vger.kernel.org, AJvYcCX6X36sweroOAi6GztUvoR3yzpESKa/CWxoEwq7QeTsejyytkhhSM4VaJwlNCe09Yg2sNVXBth2WTo4CFG3@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPP6DPeZvdvQg7lLbD1YhxKtpeIY/GMopEGEbJLOepkKUilwt
	c2Z8igg1q7Mv5sUu8UCqrvA3PQL2v1fJMcwfZsJ/eMp8oVv4e0ljb7fx
X-Gm-Gg: ASbGnctbmz8aLRmVCb6D3N/4r12wH1DASkTCVJ41kwe8meYkJw+XJwhO3vydd/cfYEz
	fR5hwgataUSJ0im/tUAz21/jYA07Yq8ni9sSKNdr4/tG0r7Czke7B81huaGRsI2E7X2Gj+M4cO/
	hJkdPx6VLfsaer0nOx81vWc6PQygy5Vw5yxJOw5lFcR6OpzJteckfzeHx3R3TFeyzp5J3x+CVos
	HaxSJ+vjpUCNyc0Jik9YY838YreeVxCbjn2Ihn3BfVFFH/jXHOVrr3ManKBFWXaf3fo36nBUjot
	NVYRdDCu0GEeROJfG2/2z3m+1377zQ4YDB0BjSkyUj0psUi5LqFg78CjsNKZhWl/RZ2dM0varzh
	ChIequRr7SPQQa6OaEFYAs4lsJiSqU/bkJ7/X954L
X-Google-Smtp-Source: AGHT+IFvzCSi3Jx1813Qml8IRiQpzQZCTcshHHIDJ588+57HfZOE6WtTLDZVN3MrY4AiWuNHBrHx4Q==
X-Received: by 2002:a17:90b:5584:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-32d43f936fbmr14109516a91.29.1757424661526;
        Tue, 09 Sep 2025 06:31:01 -0700 (PDT)
Received: from localhost.localdomain ([240e:3a6:1c4b:13c0:db95:4539:1490:64d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab173060sm810778a91.5.2025.09.09.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:31:00 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v2 0/4] Fix USB controller support for RK3368
Date: Tue,  9 Sep 2025 21:29:54 +0800
Message-ID: <20250909132958.26423-1-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixs USB controller support for the Rockchip RK3368 SoC.

Key changes:
 - Update phy-rockchip-inno-usb2 driver to preperly handle RK3368 usb
   phy initialization and configuration.
 - Add usb PHY node to rk3368.dtsi with correct clocks and register
   mapping.
 - Add missing OHCI node, add missing attribute for usb host node.
 - Add dt-bindings document.

The following changes since v1:
 - Remove the duplicate structure member I accidentally added.

These changes were tested on a RK3368-based board [1]. Both of USB ports
can emumerate device (HID and mass storage).

Main code changes come from the rockchip downstream source [2].

[1] https://ieiao.github.io/wiki/embedded-dev/rockchip/rk3368
[2] https://github.com/rockchip-linux/kernel

Tested-by: WeiHao Li <cn.liweihao@gmail.com>
Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>

WeiHao Li (4):
  phy: rockchip: inno-usb2: Add usb2 phy support for RK3368
  arm64: dts: rockchip: Add USB2.0 PHY for RK3368
  dt-bindings: phy: rockchip,inno-usb2phy: Document rk3368 usb phy
  arm64: dts: rockchip: Add phys attribute of USB host node for RK3368

 .../bindings/phy/rockchip,inno-usb2phy.yaml   |  2 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      | 47 +++++++++++++++++-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 48 +++++++++++++++++++
 3 files changed, 95 insertions(+), 2 deletions(-)

-- 
2.47.2


