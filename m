Return-Path: <linux-kernel+bounces-819831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA5B7F7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306A73B1434
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9AA226D04;
	Wed, 17 Sep 2025 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="GGcc15pV"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F0225A3D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071471; cv=none; b=VumjE3AginMdl2WKpe/sGlmV5fqLMOpLAYgRzVi3FdWZrILkIhj9/stpTioxaarwuQhz1wtU11n1evdI85gmR7E0Pf413qgTGIMT0hf9RlRE5jyJx7jRVF05OfCwvu5Ow9HMWEzaw53HCaDZ1rk+fHpv7L9XQivFcDDtu58kYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071471; c=relaxed/simple;
	bh=xNr/QPqZJjmdX3agp0UpK/7utCbc9K/M2hrqsI80QDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPSZaLTVbugcl3NpU+c/wGcSLs2hyHGqAABTmhrB9Jt2s3Vd+XqMYOkIZx1YjiVXYKW4ctAjtEEZzulCUvOFjdEFbmnk49Olu0DZwaxMADlF5mUvf84isgxfE4swFkHNIvSeLW/D57XtolCBRcfHJl5+SJWunUMa9ez5l4PVk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=GGcc15pV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1758071467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNAqiDtwCJqZdJcO28gUidP3IvDIiO4XMyc6Vtbn8eo=;
	b=GGcc15pVJcCVmGefEgI4tyRvllos+PE5EaXaWpIPrOPkxGo2fN5XDzuyLHXvMt0vOlyozb
	UrA++5kMoVVVhO28nM4+W2QFw2+leBuhN02ZYyz4cBHKO4gYruP6enRfsO3ipB4UPwfGvG
	gMq0cciUMX2zhstAX5KOlZTg2HHzIOe8RrjdxB4+4fy36bbc+Q104SlZIKTO/Wy8KGNtuN
	c2u6epPwdA7YFOKp2acw6ir1qCVunlN50Ln9tduyn3SaffphvlPEeTNlYLbbDCzlN1h6aO
	bligwsW8ME8rjzND1qfgrVjhqWv8EaW7ewCNQFIx/GWkiRAq2KP8nWSRJtgFtg==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Tue, 16 Sep 2025 18:09:55 -0700
Subject: [PATCH v2 09/13] arm64: dts: qcom: sdm845-lg-judyln: Add fb_panel
 dimensions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-judyln-dts-v2-9-5e16e60263af@postmarketos.org>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
In-Reply-To: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Amir Dahan <system64fumo@protonmail.com>, 
 Christopher Brown <crispybrown@gmail.com>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758071415; l=779;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=xNr/QPqZJjmdX3agp0UpK/7utCbc9K/M2hrqsI80QDE=;
 b=5kNRWjlJUYC4rNLH+lINJyEU1x1GUzbXkVxunKwtRkkVwJhBVn+jBYfbMdiRUKwwFaab4jeCM
 7e6zviFO8z/CYarG5oFttrteXeE5nzILijnEdD4sTrdc58XH5IiguWJ
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT

Add display dimensions for proper scaling

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
index e84b45ed82fd13850ea7ec1f34ddac5b59fc1434..8c1692f86e6ceea7b718361965e78f95d39373bb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
@@ -23,6 +23,13 @@ framebuffer@9d400000 {
 			format = "a8r8g8b8";
 			lab-supply = <&lab>;
 			ibb-supply = <&ibb>;
+
+			panel = <&fb_panel>;
+
+			fb_panel: fb-panel {
+				width-mm = <65>;
+				height-mm = <140>;
+			};
 		};
 	};
 

-- 
2.51.0


