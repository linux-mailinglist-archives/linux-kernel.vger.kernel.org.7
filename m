Return-Path: <linux-kernel+bounces-801947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE209B44BF5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF299A0278A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021EF233D85;
	Fri,  5 Sep 2025 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFMJyRyq"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00842628D;
	Fri,  5 Sep 2025 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041016; cv=none; b=YUHyAyjWZxM2ez7f7N0SWu1eVuKe5mrSgR/7pYO+13ssQ7SEL/WyT/TCl+b39ZrWgpBdQgdM5kfbL6LeqhnJxSeE+i4TKNtzkWhp2wEe/6Cz0N3Tb9wdCzTjHhmpEUhyR/gEdeAk7wDGEuI+l/HLokzX55l7RaIsqBVWwZZ35js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041016; c=relaxed/simple;
	bh=EYfhSGJ37m1ml/TvjhxEKUogzE2u4LvTGdkDe+MT0JU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ecJhoVmTicv/MQRCdOI6pB7sOKrZjxdBLyVFVrJpfruuFOssODCRbHsiHJIuJjRZwg72zix8oL7bmv/8eid812foweRSGZ1eAWwqJdWFisd3znVz3Frsn85irUhDlCE0X8mwfaZu1Q0K8LVEKeRSTeO2WfHxfn1Vb+ag/XkREHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFMJyRyq; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so1062108a12.2;
        Thu, 04 Sep 2025 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041014; x=1757645814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kN8Wi7k18fgZIy+pyFPVgHWFBPonBi4FEMxlg9xCuYs=;
        b=EFMJyRyqMyLZmzu1TxPRg/6jROaNplZX5J+m9AliRlzCFbaSA2IMHqzOIRMw9E6bKZ
         IKGAW9znW7CeaVpUCNsAafDhZtP4sqxwOyGdhOwlMOPvlyn2KCZrwNo8YcxTSxRJiRWN
         ZGEr0N1gBPxZjmjTGGfTtK3EEJ2a7ZfJU88B1tpMy5GvEmIL4Ri4etSHj6YsGscbsW3Q
         jNWEvw6ur/9rT9PqE21bOr7jQzZSsO+PXoE3mTBSEE/TyA1b9iucTjV1f7REHwiPQQEA
         knZREiPU/uaVnXrIVpf750hAWePVoli4I5Xhnazg/1C3wyV2HBQdXwYU8WsxTaiwnJNq
         lDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041014; x=1757645814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kN8Wi7k18fgZIy+pyFPVgHWFBPonBi4FEMxlg9xCuYs=;
        b=VtzqLWZdREJSxk6zMLabcdyjAVjZAIddEz6H2gpat1nxVtanBVWdczJ9dAM8ESu13O
         NLymhrBNwlVzwEIxpJYxYYmHemw16uIgE91gYo6E/d1vHqyqZyQr0mcDnLuTw94NPtYB
         c9RiROb/AebSmScEZSEQ0EBAcExv5n11N1ZtlImXRE2gw6QGQ8dNqReUX6eaQ9Zq4EfL
         J2LOmxWiL+WjfOliA34sXCEjBnwPhHv3/eM1JfY2UlwaOt+V+cnOkWcDEqJY1LYYq6tr
         h4lA0vc6OxVS3Cx35xTaazaWAGohXxmdIpayiwKCgppR+6PTeyK/NuZ/Wy2D6n5jGfbg
         VXEA==
X-Forwarded-Encrypted: i=1; AJvYcCV41xhpgX8muPiUvTIT4ZTz4skUK+CoFNQfLyiHWBcgwP9rBc60I1IoJuk1JVNW41HE181ZCEz+/J2IoUag@vger.kernel.org, AJvYcCX7WHEtfhx1/KtHcxp29OmLqsqSJXy2yYJ/X3cBnL2JnrTs74WQ88v93plqX2vI/n2Zzekr2Z6xLk9W@vger.kernel.org, AJvYcCXZQnX+imcnrYqajPoRUr9WFa1uiXnTLEsXwOFGe4ORVQqz+5RGgMe2Wpx2d3hm9D0BP1VKDemqx+jv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkj8+lBVknokyhR0A9dzqioAbapJOZTQv8LWh956fOidWgq3aG
	Zl+t2rDTChRJ94VZ6ziRaa7A/1LN7m7kz1vhQugig7ALBlwr6GemATBn
X-Gm-Gg: ASbGncu2ILbzWzqgOKhthHsAq5MlBbGl8HHDI3Mmcn/9a7jqFDyX8J3RAE0vEA4OWV1
	GkzMhVAAj4hjjl023YFyWZ3K4FLqW4b0uh8S+u9hPEKTuvGzc5izEHCmfsDihGAUxipXFthheec
	bGYb8iNdgYR8ClJZGc6LFECJOQDFYPH5Jw6yv4EJBnd9pi+zKM69oe6a3NOFlQT6wMy6668JePK
	G5a+ofT/JeCzQe20zeW7aplT6rhNhjTSPN3OaFp1Qw1dqp9+n0J1q24f+5z1waagwYq07H4cOL7
	/6Hfy1MXiVSOw8K+LlAtrBsM6gbE2vJXz5UcF2Qzdpw82Dqk9Ykg6Td7gQDxJoQevVbHMUO9GLe
	4iJZW3NM2zvY=
X-Google-Smtp-Source: AGHT+IFoXLBpoEZj+Kqca1ZBVX7hB+nXvEhxskTZBynAZLugXVjdrP0Ko36czmoGorKpcjWCnETh4g==
X-Received: by 2002:a17:903:3884:b0:249:407f:9638 with SMTP id d9443c01a7336-24944b79032mr267675025ad.61.1757041014118;
        Thu, 04 Sep 2025 19:56:54 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm9428588a91.4.2025.09.04.19.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:56:53 -0700 (PDT)
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
Subject: [PATCH v2 0/8] drm/rockchip: Add MIPI DSI support for RK3368
Date: Fri,  5 Sep 2025 10:56:24 +0800
Message-Id: <20250905025632.222422-1-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds MIPI DSI support for the Rockchip RK3368 SoC, enabling
native display connectivity through the MIPI DSI host controller and
PHY. The changes span multiple subsystems, including clock control,
DRM/VOP integration, DSI controller binding.

Key changes:
 - Update dw-mipi-dsi-rockchip driver to preperly handle RK3368 dsi
   initialization.
 - Add missing lut_size of vop_data for RK3368.
 - Add missing clock ID SCLK_MIPIDSI_24M to the RK3368 CRU driver,
   which is required for enabling the 24MHz reference clock.
 - Add MIPI DSI node to rk3368.dtsi with correct clocks, resets,
   and register mappings.
 - Add dt-bindings document.

The following changes since v1:
 - Rebased on linux-next tree 20250903.
 - Adjust the dts node order according to the document requirements.
 - Patch 3, ("dt-bindings: clock: rk3368: Add SCLK_MIPIDSI_24M") has
   been applied.
 - Patch 4, ("clk: rockchip: use clock ids for SCLK_MIPIDSI_24M on rk3368")
   has been applied.
 - New patch 8, ("dt-bindings: display: rockchip,dw-mipi-dsi: Document
   RK3368 DSI").

These changes were tested on a RK3368-based board with a MIPI DSI
panel [1]. The display boots successfully with console output.

Thanks to reviewers for feedback:
 - Heiko Stuebner
 - Rob Herring

[1] https://ieiao.github.io/wiki/embedded-dev/rockchip/rk3368

Tested-by: WeiHao Li <cn.liweihao@gmail.com>
Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>

WeiHao Li (8):
  drm/rockchip: dsi: Add support for RK3368
  drm/rockchip: vop: add lut_size for RK3368 vop_data
  dt-bindings: clock: rk3368: Add SCLK_MIPIDSI_24M
  clk: rockchip: use clock ids for SCLK_MIPIDSI_24M on rk3368
  arm64: dts: rockchip: Add display subsystem for RK3368
  arm64: dts: rockchip: Add D-PHY for RK3368
  arm64: dts: rockchip: Add DSI for RK3368
  dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3368 DSI

 .../rockchip/rockchip,dw-mipi-dsi.yaml        |  2 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      | 76 +++++++++++++++++++
 drivers/clk/rockchip/clk-rk3368.c             |  2 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 20 +++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |  1 +
 include/dt-bindings/clock/rk3368-cru.h        |  1 +
 6 files changed, 101 insertions(+), 1 deletion(-)

-- 
2.39.5


