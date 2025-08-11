Return-Path: <linux-kernel+bounces-762419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F6B2064F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E0018A2451
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E91275846;
	Mon, 11 Aug 2025 10:47:29 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02EF28469B;
	Mon, 11 Aug 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909249; cv=none; b=gym/230QkiYYmD6W7i2v5wY0eSg0mg2XIYo7JgbwyreK6oDZTTrWj33nmyATuJMXREgZv02TM5XxKmuqnFTrzQCIcI0GSjPZAsgGg7iUiiSM9yN56DosYHr9HoTkUm+J/kRTt/GBToIb7XFHwKhYJINiQeBl1BfL5Ui9qoitkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909249; c=relaxed/simple;
	bh=bC/aBLp9v8VH3ZgOnnxRfjjLifBJw3enHrNi4K90M9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/uCmz/InoBhNRoYGYYqJnW+b+acKRpeXjGLiFlr9PMFyA/ln1RFp4UvYrFLphIX0pPI0IGPk9QfhcZmkBWFXRDImX1q6PA/lMcLOCDyUyGSrH//agM53xjwoHDLbAyATNfrHuZr6DTmAvAwsUUnXFIcL1hC6GHEEO7jnzbIWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz6t1754909176t641e0f49
X-QQ-Originating-IP: BXnYFSWbq5XIKjPfePvkrFtvlAywx0UdrWpiOze9Rt0=
Received: from buildhost ( [183.17.229.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 18:46:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13167854891472909437
EX-QQ-RecipientCnt: 15
From: Nick Li <nick.li@foursemi.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nick.li@foursemi.com
Cc: xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com,
	like.xy@foxmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/5] dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor Co.,Ltd
Date: Mon, 11 Aug 2025 18:46:06 +0800
Message-ID: <EA25BCF08F8BA128+20250811104610.8993-2-nick.li@foursemi.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811104610.8993-1-nick.li@foursemi.com>
References: <20250811104610.8993-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NPoj0uw5Jpnx0Z2iSvNV1rxYGWS3tg39YjbBeezsMI4vNhn7e/jVtQOx
	7slMZBsz9QYk+r54tOACUhHtRG0EdaLdlVPLdsOleDJ4a0ucVm1n3fLtOIpAuEp4Auct7U1
	gjCY6y+wG21T+xknFV/CysHozQG6MxghF+HVC0nscX2xIBzEeZ6ychdfmlstvXKhEKF9m2y
	+VqhsvOeOvdq4ZhRYm+xWUgTVDUrqeyylb9jPzdguWbDaf5c1OrMhUfPMsiZAhwBZvaYiA9
	APpChPwTd005VIV6obfMxV89Ony6PHqdKvqPfIUS2KAPiNNeJeSZAsC6UMfrAZwOIiR0iqa
	mkMdflT7FFX4ajuMU/ejhQm4KbvOeXibrrGQfhKqOKuHJJB89nncPHfysqrcPEJtr0wcGFy
	NR2qoUWSdVuV3sFJ8NeONILD+/JDccw34/LXNOmnwX0nQCM0X6ngTC4AHc28aVphreElQs+
	oG2VdktZpCsGzlcwdJt1S+jzK2FEdoVlSQahsyPtBwzmZa+3VWGbxg3PY+mvNctxB1FcYks
	47sClNC/l0di8E2a7XthFwaGGSLtTAGXhRD8e9XBEgesexTctGecO95YHrOq3x/5cphqz6T
	3utAlOjxYnPX5FVY1JrU5dwNmojLqHmlRRMINg0stLDzkhUyFWoIqMJwwILTYJWGp0yQdnK
	uBq3Ho9ZVXLKaMqKRKm5rWtyYD6O1wOBdkwBOivt6UFSjdpjnpxe52/HS1PCh21ELS8wDjV
	XekSFH2yo7YL9OwBQoTZ2hA+S1JIRhri5OslRCCijdrt+ton9jjU5KHZaX3zq3VzDxcEcGi
	CiunCdLKGGPg5ZdWyHN5MrjHqCuLaezt2dfRoNRf+ZQU2+iZlIoTg/HgXDho5ihLbgiCCE8
	5Wn93D2sGqSQC3g5N3k0AxksZg9FcOXhJB5oAFSHw/vnv2HXBfGanrn+CHF3vsPJVlNTo5G
	N5PLoO8o/1JpNYWNY/TDagKpE06iLL1JR0Y6s1lAfh1WK8kbwuCtaisWbzbLDRVjxTo/vUZ
	FT06Y2Ke8ZnMYHlsE6u5cbzBQ7tivL2JTe4q84MtR8FYOzgP6jASeJUakiBSw645RcTZ81E
	OShTYYaD+9hlv4Kk2WYWG+lRiXuXTBKJ5gAdIYZ7YDAweiQ5tmlfqiGQYH8K1CqxYaLV4eW
	AoYI
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Add vendor prefix for Shanghai FourSemi Semiconductor Co.,Ltd
Link: https://en.foursemi.com/

Signed-off-by: Nick Li <nick.li@foursemi.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 77160cd47..a92261b10 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -552,6 +552,8 @@ patternProperties:
     description: FocalTech Systems Co.,Ltd
   "^forlinx,.*":
     description: Baoding Forlinx Embedded Technology Co., Ltd.
+  "^foursemi,.*":
+    description: Shanghai FourSemi Semiconductor Co.,Ltd.
   "^freebox,.*":
     description: Freebox SAS
   "^freecom,.*":
-- 
2.50.1


