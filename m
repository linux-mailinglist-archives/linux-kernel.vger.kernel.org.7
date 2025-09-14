Return-Path: <linux-kernel+bounces-815832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85322B56B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B29B189BFE4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF22DF139;
	Sun, 14 Sep 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b="KYz3YJNC"
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8602798FA;
	Sun, 14 Sep 2025 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757878333; cv=none; b=Zp7zW8GHo6pTdi7CVzN3qSBCqWXubLnZrbvhWIYyDXzydJNQKUsJ/FgtK/5fE/a0Aa9TYhDhg7uAIrb9Tq6wBo6xhhQZEBC8Lk2/Tx4hviVAgtEa6aqocROxk9f1Kxa36vdC6aUedRvxZAI3NyBSSy9gpL08Dd1KWzNWTzuwwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757878333; c=relaxed/simple;
	bh=XyJr1Et83VSZI4TiOdi7NfvvgURQCYI5SyEeqwKJn9c=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT1tJMh/hh5dIX18LnbKpmtW0sr9H5DkZGZDFFEbd3bRWsJjj3yAUGADRueUV2TeDopf79GGFpK9HhqKv6WkI/V8yfIyEfKdkr4KAquSLKPS/uwEL4P7XM22RKOBg4UGSGpxffmatw7ilQLIZ1Nh3Lnz2/2R3uiJnzNwcXgrljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro; spf=pass smtp.mailfrom=chimac.ro; dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b=KYz3YJNC; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chimac.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chimac.ro;
	s=protonmail; t=1757878328; x=1758137528;
	bh=7lpOnihuzgN8aXgYGmo1vFZZPGJlskHF0+CRgoIdYsg=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KYz3YJNCQf7EePMd5eoDtgjn1HULYv4MJteOCyQneSINTVQNMtPI7EMTOBafoovi/
	 IZkvH3E1Xpc9mMNeMBO5Nzh156176PIChR5B/ibkRfHSksXfb8fyZ7jRH9GQydgoLJ
	 j/2gse+ef29E5TqlKkzclMAwiRQCAX+xxpy9YSD2di6KZE/NgUXjzPW7ggwt+lnGQM
	 IehuKetoA9MxXK9LqxYsqt00fjkdTOBcMV1kR1pWqwM+f0x4xO424XEr8nd03QkNU5
	 1TBlUZ6bBctn1APx+XgJq3DSGhckYoyYHbSztLywsiRmz30oiS94k0TFYZSpyn+feU
	 tinHhojYE34BA==
Date: Sun, 14 Sep 2025 19:32:04 +0000
From: Alexandru Chimac <alex@chimac.ro>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Chimac <alex@chimac.ro>
Subject: [PATCH 1/3] dt-bindings: pinctrl: samsung: Add exynos9610-pinctrl compatible
Message-ID: <20250914-exynos9610-pinctrl-v1-1-5b877e9bc982@chimac.ro>
In-Reply-To: <20250914-exynos9610-pinctrl-v1-0-5b877e9bc982@chimac.ro>
References: <20250914-exynos9610-pinctrl-v1-0-5b877e9bc982@chimac.ro>
Feedback-ID: 139133584:user:proton
X-Pm-Message-ID: c2dd42e13741ea2a0c5e007de82694ad671e68a0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Document pin controller support on Exynos9610-series SoCs.

Signed-off-by: Alexandru Chimac <alex@chimac.ro>
---
 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml=
 b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index de846085614166087ef9046cf5d154fb9dad8309..2ebe9353d3bff9f708118a249b5=
e969aa5fc393f 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -56,6 +56,7 @@ properties:
       - samsung,exynos7885-pinctrl
       - samsung,exynos850-pinctrl
       - samsung,exynos8895-pinctrl
+      - samsung,exynos9610-pinctrl
       - samsung,exynos9810-pinctrl
       - samsung,exynos990-pinctrl
       - samsung,exynosautov9-pinctrl

--=20
2.47.3



