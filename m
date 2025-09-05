Return-Path: <linux-kernel+bounces-801952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D16EB44C04
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827D3AA14E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C9242D88;
	Fri,  5 Sep 2025 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSDwstmr"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542C242D95;
	Fri,  5 Sep 2025 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041037; cv=none; b=sD/wkM5VhwmibLVyeqFmwBDyc2xJohvo34wJBO+fwdp2jrZei3Z01VBbGTJ6M288NwxU/1tsdOIgwJNmvC7Uf2Q6NknQGSdV+u/A1gb2DSsAPP16KwIO1ide6UFtuePSHAwvzfMRejXODzOIIwn58870bKLo1h4AusAKh2yaK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041037; c=relaxed/simple;
	bh=Y8DOLeJl5z6GDeEk1v6azLVw59OhX20C26+oR/PLWZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tS/SbdOwYK+mgcbKNvgxQnIMdfRY3MXVqpk/XBbRhiQXOSIGgnLMgz0Uo0M71hRcM+LZ2JEBFe49sMDVOEfe0YA7i22AMZsdrWiQt9HhQdsdNJRpiq4OJXrnOjDtby24ivdqxD0r7NinXUi1ZULM2/HDXQL+vtFpzn78+qX8qfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSDwstmr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-329b760080fso1613977a91.1;
        Thu, 04 Sep 2025 19:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041035; x=1757645835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CDKUZ+NfM3JX1RChza494Nr3RLvFGvqX6wYQsX8aNA=;
        b=VSDwstmr9XFFJwVYFdrgf/isbZxjB98zOnCib+PvggUlGCQl/4rthKZiXOPVcOpYTu
         +nV6WaAm/wZSg94WeY/Ov/lBA1SlRUzM2Ys1CKJkeBF0Ei8eGyzSGg45yYTO6dBg3x/8
         D0HZshh3Wal33mtRPY06KhaSnPWA6ObGXgJ5VsZQKOY8AF063BkVq/eWGXp70HmTo9BK
         8M2lwkkSJZMogBgLxOlE2z37+4dDZ6SVgVIuFoGR8CQk2frImeoVDEV4lLvTemLQe+L3
         mHz0M+J7QKI9bCVyUeKj0o9d26EZbVXbtLpJO2KFC5ej3GmSTKPLvfy1BXxBqeoC2zuP
         vNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041035; x=1757645835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CDKUZ+NfM3JX1RChza494Nr3RLvFGvqX6wYQsX8aNA=;
        b=KNtfURR4ZKrjRBMw5XiA21it6tdQM4gkkPyiN4dJP4idQzYm0u5Cq7LaPdud2Njr50
         Eso5j2TEoCnCrLGmlLB6eCRIF3E4WsCAGk9xLC6H7C3gRrcXLibsOBd0dktdGvahMvvF
         0ygDjhMPPUjEpRYPNJJVogyPkoCGxTLczJKUhWLTEbLXcQeNttTMjZkLi0Oqup5ylzta
         rBBuiTPizOUjAPkJwsNXAflzl0xcoGHgxjHsQjyVs5o7lABUOXVNnsceiiUwBhVMf2Sn
         mJHd37z4WJwgK7eWpp5NeFPdI9B+ZChEUBhCe1suSjCuS8LB/D/rHQ0PhVKp6nCp/GVQ
         JYsA==
X-Forwarded-Encrypted: i=1; AJvYcCU4t9fNDiYOY07jC0paPXVC2o7614yfrjJzQsDPkpLs3Jf9A2WcPIT1KsDcoTJdfauRNPSG22DeV4vh@vger.kernel.org, AJvYcCUzcLEpUiK9HE7LEWn0/mhONNhjvfw0vXQRgXx1cgUOHGX3qV04z+kWLroPMP1G6PP8DRtHQ2v7Fkwf@vger.kernel.org, AJvYcCVRE+QDY7NjALyV3S6DtHQUfL8lwJA2IaKmpqvM3PEywmX00tvzfw9SblYghN4CRhACG8CC/Hx+3RgjauR0@vger.kernel.org
X-Gm-Message-State: AOJu0YxUonKmKbLvLnxX5zqzG//x5Eqcqsrx4LROonMQgkdN9XLxKUFe
	cfI+/7qhyqdjrWFtWISdGvrVx+W7FPiEAVezbU9aZXD+NBHZsXuqMEOG
X-Gm-Gg: ASbGncttfWoECVgtBpAn2sS/M+vNbrxbIC+Dfi2CkHMi4Ic2zvheebRe6LMGxLpoXMq
	2IExF9QMx6K7r97Bdv0FXQsrhv7JMdvoLeJrLlpir9F3hZbFXlCC5qivEmxJ9NlzDh1U1JnqXwc
	t7omocJymLZtOLnN7vB95yGeC8tTLcI/qQwbiGTUVEJtldtIiOQrE/O+xyUkdOhCHad9e3kUg6+
	DFPudOxWD10BLJRssoYQynx8XdfURfZDz4x5fsJxfcZiTKNG1MfzmBacVNBGFc8VyQfF4wH+JRh
	VmzQTVZomnc9P2T5tH1Wz8HzGwKzb11H1DcnsS82srAPA+fjm0Oe0vRN4oSjHP8y7Vux4z8qvFU
	sH3oJd++91bw=
X-Google-Smtp-Source: AGHT+IGJPBg0Z3/hlijieYcTeCP5A88enc8PD4RQPi19VQkilqYW0HhiucmQtmvJoPxoGBg88j1vrA==
X-Received: by 2002:a17:90b:3d87:b0:32b:65e6:ec39 with SMTP id 98e67ed59e1d1-32b65e6f260mr8994261a91.21.1757041035560;
        Thu, 04 Sep 2025 19:57:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm9428588a91.4.2025.09.04.19.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:57:15 -0700 (PDT)
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
Subject: [PATCH v2 4/8] clk: rockchip: use clock ids for SCLK_MIPIDSI_24M on rk3368
Date: Fri,  5 Sep 2025 10:56:28 +0800
Message-Id: <20250905025632.222422-5-cn.liweihao@gmail.com>
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

Export the clocks via the newly added clock-ids.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 04391e4e2..95e6996ad 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -526,7 +526,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
 			RK3368_CLKGATE_CON(3), 1, GFLAGS),
 
-	GATE(0, "sclk_mipidsi_24m", "xin24m", 0, RK3368_CLKGATE_CON(4), 14, GFLAGS),
+	GATE(SCLK_MIPIDSI_24M, "sclk_mipidsi_24m", "xin24m", 0, RK3368_CLKGATE_CON(4), 14, GFLAGS),
 
 	/*
 	 * Clock-Architecture Diagram 4
-- 
2.39.5


