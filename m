Return-Path: <linux-kernel+bounces-819009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C329B599FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6261C054E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A328258ED4;
	Tue, 16 Sep 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSuZ369x"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E049221DA5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032388; cv=none; b=lS887ZhPz8eFS9Eg2k2nSdZfeLdUfr5bOloF/bIQmWDk7jCRYZKeJhjaxtlWJS8LYhRQ2ydJr/oT9kpOesBwgnKSrnTMhYruo3P/eed8vlrXGl+ofpccgvtcZLvpUd/+hdpPJcDlUZkj0yPc0OkcoZ5oZssDX92yF0cESzScsdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032388; c=relaxed/simple;
	bh=IkW4nK/vinXYi2bfrKKAAwnIOc30dbD41Dd6dOR/Ldo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMMbwNehl8JhhrP6nUcHbeY7CZjYi7DGMBpdGPPPl/r/LxeNq/G5DmCa9gmwQOfnLsSMKC0KDEcB2I04cpInZDiVT8/XHD/79GSRKdHyZ1/uz4bpeb1cQ9W/Aouo6G1CCYjPbE1dRzhWpmPp3KsEG8681Hv5RpKzXQD4Zw4KCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSuZ369x; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so2298181f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758032386; x=1758637186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtjNvPki9FX33kkHGpqKgjuJyKPvLiypLHYyt3prAwM=;
        b=dSuZ369x3at3HvOo1zi/P7neUerMH16IN8qEEjX/PgKSQp6+YOLK16HhHDMsCuCwvA
         vdT32WSgailg55IEn4kbgpql03gu2tJ+bGlDZ6iBECv2RGbTYBnKio4s+lusm93A0mrf
         dxnS9OCGdk1u6+H9a3bFve10aKB7Vf3U/YEjlyH26gfYQCsfoV3hXVCBB0eOr7P9TpbH
         9+vDRmi9PoQHSY7IUGgA9rPsJoOPjTmiBsv+7hlO9AZWC8MUuX9PegxB0phvkcoOPawu
         yokVmsQvr42UZCdMAwj9yulPaxWHaC93PHenkaF4RPYQ6rm63Rmqt9b4lz72bD4KhDgL
         fG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032386; x=1758637186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtjNvPki9FX33kkHGpqKgjuJyKPvLiypLHYyt3prAwM=;
        b=ok2aHYbhlEM1jD2un7DVFWDC3DKAHAMPjh3SLAxKDT2PHBMqavbP2k7JuvSVefqaBv
         dPCwusVF7s33p4V/91F64stqxXiirw8ojRo7jOcxGY5O4B3MOTJRP5VphoX5kldkYIbK
         GoyrK9GftGewFCm6IrcS2Y+mb4nWMYkMPoe3ZHpGMrDPEA4PD0cJoxBy1QC5CURg41kM
         lgbWMIkPqXiFGB2mLbLNmbakdjwEuJ489twjjeXLsAulNYTgyvPk8lIE8mdqeMyA4tdK
         Pwqc0MdaiGLfZcA6wcUQ8V2wAOL2ikL085h/iAxSSdUnOk/dNKXMPZSorWaqpJwU4zSO
         Ro5g==
X-Forwarded-Encrypted: i=1; AJvYcCUjCpFJ9shsTqlgNbQNY4aHiJmoCRpHk79LOjDloyqUxTNYsC6x/4aLq4/WgbPhjFNhZoU0HeSXtrstiLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlrfM9dHV1FrCJFVu52E8dinp0iriBThRuXIoKbNPu6jtLa46
	iSlf+aykVpN3lVOQVRWuCl9zrF0SGGTNmB8xY6F2CqVOFLxpii3qbmQYGRMM+ezZ6jk=
X-Gm-Gg: ASbGncvVtsdDQm/aX9gYF3IFOmYnXfA4HAyOZb/rqzjpGgESHCPTsd5btxlTggB4JrH
	SbIMEBF1CxVRpgeDaNB0LDXjq43DkohtGkgGdjqiyhHrbt/K9COjul5/qBfJ912+w1uUuolXvCZ
	G2usFhYs8izsLNjrBAvnv+syNl1fNWhVaTzeZk+DcQN6YoOG/LdnaqxHkxpRzbj4GXRo5g5XdVX
	e9KTnty68yjKoxbD9wf4mk40Y66Dzyn9N/uAbIpoGf8/G2dcZihCZB0GpzeCH+2By0qFxEZcFTV
	2g3JMiIAzI7eg3J13p9skzhdvNjAxkk+npbSmXWFKgwU/7TaQOAwObFXBANJSAOjN4NfZKzg0MY
	WdAAGff7I0bdJhe5MqC/gkktRvMZ2Owk=
X-Google-Smtp-Source: AGHT+IFdcw9hqpwZPogQtp5veCDSAw8ABo2+U1X+L5NI/DxNsiFcjHEYgUJ3E2vGvtEZVPnSECGu8w==
X-Received: by 2002:a05:6000:18a7:b0:3d4:eac4:9db2 with SMTP id ffacd0b85a97d-3e765782b5fmr18609594f8f.5.1758032385579;
        Tue, 16 Sep 2025 07:19:45 -0700 (PDT)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d7595sm220245015e9.24.2025.09.16.07.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:19:45 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH] arm64: dts: qcom: lemans: Remove unnecessary cells from DSI nodes
Date: Tue, 16 Sep 2025 17:19:31 +0300
Message-ID: <20250916141931.601957-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warnings
Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae94000:
unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property

Fixes: 73db32b01c9f ("arm64: dts: qcom: sa8775p: add Display Serial Interface device nodes")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
I haven't found a pending patch for this, so here it goes, sorry if someone
already sent.

 arch/arm64/boot/dts/qcom/lemans.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index fd6eb6fbe29a..a551f2a274a2 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -4524,9 +4524,6 @@ mdss0_dsi0: dsi@ae94000 {
 				operating-points-v2 = <&mdss_dsi_opp_table>;
 				power-domains = <&rpmhpd SA8775P_MMCX>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				status = "disabled";
 
 				ports {
@@ -4606,9 +4603,6 @@ mdss0_dsi1: dsi@ae96000 {
 				operating-points-v2 = <&mdss_dsi_opp_table>;
 				power-domains = <&rpmhpd SA8775P_MMCX>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				status = "disabled";
 
 				ports {
-- 
2.43.0


