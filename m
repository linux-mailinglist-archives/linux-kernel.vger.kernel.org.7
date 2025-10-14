Return-Path: <linux-kernel+bounces-851800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EF1BD74BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64003E87D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEFA30BBB0;
	Tue, 14 Oct 2025 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZezoxSMQ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8C30DD37
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416969; cv=none; b=SemJRRBhI03Wd8Y9D39lkEVFPTMwLpEm2LxR9Yn0OfluDV42Yxu5P+xkwUHpJVrLVz7ljoUhyPd3Wv2pk6aLif/V9EI4tUjOIfs2SvI8htBGhiH/786xmdqByyfQIdnNejMyfJXrjrWVn6Ohc3LS//d0sOWk8/Oa90n6c9PwASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416969; c=relaxed/simple;
	bh=isCQg2Qmxa9ipukkV50sTI8P8heS155Zat21GVABUs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFXU8BjrDLOBavHch+xj387Fb7zFJa+ZkcparWqgvvC2frfQ9kqZ+bsB8VCJcCmhpFVpDxYHTXoNq2BGRTn5rSn1qMZn+2z+1a1uyvwIffvaVx48kFSkpaQykwgGM3GzSZddlMOdn3D/BD6UnTCwMauHgpVUPkvTZxp8PMUbSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZezoxSMQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7835321bc98so4704531b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760416967; x=1761021767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdehfY3g3zjxWma/hGhUnMxogBhAstUttJRuG22ztsE=;
        b=ZezoxSMQfVQTYisSNqoIJYa7PSe+sePD5iG2SLuEBg6p/jYCNQ6QoxV+KMmB2qsCQ+
         YJ0ABhuB5QvXwvtC1Q6DHmiqmXlKvc3+4EmiP+0FY+xSFlGHgzrddyvpavxo4djpZqbP
         lal8PVygauJtNBJ3PTcQ6e1+6Ly9qLWPrHhKCN13CPPtYW8j+NY6bbJwpn1Y6H8owno4
         k46HPOE0pzNSF4LCgm/3lXN/4s914MK1eecCw+DKBvOf6QBShTHyH9MWOScm+iAHSN0p
         YzlJeLZGbITW1AZ9id83ij6xHsXmvK/6uimXEQbLJ1EHLpBOMQHlSDVfRwgL2EnHgmYV
         8A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760416967; x=1761021767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdehfY3g3zjxWma/hGhUnMxogBhAstUttJRuG22ztsE=;
        b=UsDDLk75ojo8jtYZ3upnrGy9uB/q6sZ74bRTegpdYMxn9lGTU5MYmPME93Qiu0pN5v
         QaYkK7uXSyzcm8/CJGq3fCquqgykJAmVEG2DUXD7RMR43I37uFjHIuqfG1Fw4pXlctem
         sBJ/y0zRTXfzXpckS2RnzM+oQ4pXEW6z3d3rrBdcPoCrtwlcv2EoNddeOuYWkhH2NUIf
         X4C380DgfipIwtCrkybsJ0KWUzQ17DZkWoVMRKYGD5dz28GTOvMclAQrjHjZMtfoorjX
         KgNVDABdRT4/yD758CAOuUmFyaIZ7wDiyRThQJMiQGlh8qw3cyUSJqa07hLvUk02HdiB
         Ikww==
X-Forwarded-Encrypted: i=1; AJvYcCWKVabQvK7Aocz7i95vdm8MQGnnKZEjl0oMsWAu5upciq6FQ5N7afNu0D6bicx1inOiaPOOyaCsU6V3ijw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdz33DCN3Mazlrl41S82qyLYXudP9RDIunYsHAKOv9gFxPbr3I
	UQlx2v2CGDJusufgdyPn58KtpoQuBw9WmI0S76UB1dzZ2AsN4c/ZgLPS
X-Gm-Gg: ASbGnctrLFoPITM9TE2Jfv9Snss/XSUVXmivjlS/WJ+9XuPDQtsGyv/x9BN7zcKrYRf
	+edcWYewwuRj3XgoazjASZgX2kYkfZqX1h0I4gkBJKn4T56w6CKMeaRHcOfmkmAYbw3Rvkswl5N
	LLNBad+u5hx7cXK3rPgvpxrW9s3SL0cuYd/3+8yYz8JSOaW4tar5kZdX5uU+lEV+fDZOgcnMZWt
	CxEIJCUie+I4j4vr9bTWybzpZHroV9baG/wVXnXyJDytWihGRlZmzsXEy/pZTr/ungOrYMHr5cU
	jqwle2b2O4fCGoQc8vt67vCkDGt7uvJKzOSpzXfbGZcwjSs5Hlh+Qug1A1729YI/81vi2fpIcpZ
	mBSCy45azQmdvX5dilsiKZaKAF8rcM74z1RTM
X-Google-Smtp-Source: AGHT+IFVo7nH9HmOWaQJIpTOa8xxtz0naCajk8mBW0l5w2WcBlbPqaeuoOio18OCz3U68lcFPbDpDg==
X-Received: by 2002:a05:6a00:a14:b0:781:171f:df6f with SMTP id d2e1a72fcca58-7938762f586mr31416228b3a.18.1760416967419;
        Mon, 13 Oct 2025 21:42:47 -0700 (PDT)
Received: from archlinux ([177.9.216.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-79b65528a51sm8440684b3a.85.2025.10.13.21.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:42:47 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: qcom: r0q: fix reserved memory regions
Date: Tue, 14 Oct 2025 00:41:35 -0400
Message-ID: <20251014044135.177210-7-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014044135.177210-1-ghatto404@gmail.com>
References: <20251014044135.177210-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ADSP and video memory regions in SoC dtsi is misplaced on this
platform, fix them by deleting those nodes and redefining them.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
index a3b81403d180..8ed8a67aae0d 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -10,6 +10,9 @@
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
 
+/delete-node/ &adsp_mem;
+/delete-node/ &video_mem;
+
 / {
 	model = "Samsung Galaxy S22 5G";
 	compatible = "samsung,r0q", "qcom,sm8450";
@@ -64,6 +67,16 @@ splash-region@b8000000 {
 			reg = <0x0 0xb8000000 0x0 0x2b00000>;
 			no-map;
 		};
+
+		adsp_mem: memory@84500000 {
+			reg = <0x0 0x84500000 0x0 0x3b00000>;
+			no-map;
+		};
+
+		video_mem: memory@83e00000 {
+			reg = <0x0 0x83e00000 0x0 0x700000>;
+			no-map;
+		};
 	};
 
 	/*
-- 
2.51.0


