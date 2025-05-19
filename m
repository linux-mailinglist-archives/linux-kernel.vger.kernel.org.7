Return-Path: <linux-kernel+bounces-652960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF81ABB2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 03:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5928173467
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 01:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAAA19EEC2;
	Mon, 19 May 2025 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="JzpXc7yi"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269B136672;
	Mon, 19 May 2025 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747618080; cv=none; b=KM7bKkg+iqO3T8/Tpa87lyj5AG+BxPkkeJWWXiED47vHsY4C0ueJAQ5HnxnB1OdBtq44bDK+X/M28WrHiSjUdshrsC2UxWCiNhr/ubTjD3ZjquOJrv9mW9xTrJ4aB9z7ZVhu3MCbA5h6tlmktjtLirVe4b7xX5Y7yZ7X9uAKZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747618080; c=relaxed/simple;
	bh=vqGigXA8EmHjZv5xyB30aWNaNpthSwxwCcCPPSpr5jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GPMhBoGXWrVAiHbeCumCd2m/6xPWgqnRrHtH66upCSYjrmkqK/03sQoSvv1YEMOxiZ9HHRxZfDs2LRY+udpcSPtrR09An2aM8WFiHlByX/w3bMyNCLSf8HEyKCLq+e8/kWSy5i6VJ+CsKgEOBoa5FiFpja/5XMZRgbKwkf4D8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=JzpXc7yi; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1747618028;
	bh=975XiWevg8IyB7+oWu6bLHHS0g5LCqgBcM0TSyV2q3I=;
	h=From:To:Subject:Date:Message-Id;
	b=JzpXc7yi1gszkPORq5gql/79ac1DCzYJwxj725HfKeq7wizljNyPSA9S/MplXGsCK
	 EvIXISMeOjrjWmFA6UEq+A50h99e6DqQeVmKMOoLkxfZ0VEPF14fD03PQB/TNyocsL
	 7DTqskwDJnE8yIPza+lOUx9CH6lq+nYIGqwdXFHY=
X-QQ-mid: zesmtpgz7t1747618026t16ca58f6
X-QQ-Originating-IP: j6BCwtD4SfAxd4NPvSFyjN9YnqkjO+XmSHeW003nfGk=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 09:27:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4218085974804082630
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] arm64: dts: rockchip: Improve coding style for rk3399 cdn_dp
Date: Mon, 19 May 2025 09:26:31 +0800
Message-Id: <20250519012632.94-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519012632.94-1-kernel@airkyi.com>
References: <20250519012632.94-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mm/8i8/T4yneh0XRCTNyUpt6QI5l8JR9+V0Qcc+RB093jkpsdfTfQwhF
	n8/iTVP9Q1rcckBE+guIr3GUIEVuJanMyiBPqQ9eJtvrXTzVr/T3wQFnkLrqCbTap5N/3sa
	xfudTUK0fatPYF030B65UeFapBFJC2ViKu/bKGyZqoQ7AL6rKWkJvvAAik6DHdd5YWePW2F
	/XjBo1/64MsWUL9Pdu7C3f9JROUcpAh0qdNlBIiBSsSLPjK2vlV0h5YA3t8lN1jpLHThKzX
	fOaunTuZAS8n0LKoxxrb1RCSqib3E4iUBzcMLyTa23jiDtvfN4V90kAhha0/hOm31eJwYCx
	/ZuCMIA1brNs9nmIHc7328YupLlD9F3c9pETuu7dJtZGJLfyvYDVbHZKZ3qkL3lleix5pNj
	ThXkhLsgzb8uy4iS/kmkhTLNdOy47Y/jpzobLyH0TB6fHBy1XWSPocNO0uNLKy+WEBdf25s
	iFcuLwKWmoi3a76MH27LkDqvOv67tml9joppKr3QXtYszMapGNk0F40OCB+gCQYDXS/ptmB
	MOdevkVXhfajcsPgetnIKWxluviGOopzMuaMY/fUiTSwKS0nXeNP0tQQzTPqy+W0aG6wKPM
	NMVBL2NYqGE4onZKunkZsgU8WAYEhYwCESgfHHvAZM7XQz98TIcf8ji+qfimsHVyuz4IFpA
	ZQZ+xRHzuVGp+DNwCou0U5TLc1VG/9wF3GB4qShNd6seJcs/6lP/LIQj8GE5pVO55Y2CZPP
	zs7NKBuJyl2eDWss5wijShbGm+tA99dnk3CJVnYR148OJgSaOfrK7Hx1pAXxcgPdWJg6pq6
	42RWhePNvs4bh54ApPXjCN8gOBM4yIByPlBIPSNTQ4mdMIow5CGu4bYh80vmZNaeW6bt5sc
	qiWfsDEzzRTXpF6nqedkYY5lIa3u/zZxtrFgFPvpEaE/3rsfO90YWb1GysHXWYk3yzmpE44
	0U3EJj84QWPKSlDyyiK4pW6cgZF5x6B2YY2O6hbVvS0clo4uN3bE1FBCc
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Let's make the ports nodes of cdn_dp in the same style as the other
display interface, and match the style of ports's yaml.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3399-base.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
index 9d5f5b083e3c..e340b6df7445 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi
@@ -618,7 +618,11 @@ cdn_dp: dp@fec00000 {
 		status = "disabled";

 		ports {
-			dp_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dp_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;

@@ -632,6 +636,10 @@ dp_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_dp>;
 				};
 			};
+
+			dp_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.49.0


