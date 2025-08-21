Return-Path: <linux-kernel+bounces-778946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D89B2ED03
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED921AA2C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EE52E3366;
	Thu, 21 Aug 2025 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b="Lf/6EaDs"
Received: from rmx-b.mailgw.jp (smx-b.mailgw.jp [210.171.6.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C3241C8C;
	Thu, 21 Aug 2025 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.6.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750615; cv=none; b=cpt9VgYhjP/VQtqUMj1Ux/y7BWUTjmLU17642Fpa2/vXqpdPPcBEJzYCNWDE515pq/+AX891Ffb7JbmcC7Nh028pAiudPfB/ZtVryJH5n4ugVVYzBA/gQJAqf60kLCOGR222jSo9I5aelrLIst+iNkJPBHtvi6r7rAlu37JfKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750615; c=relaxed/simple;
	bh=fvsDE9OhzMp4QliZrWDNKfFRbFD3fhjBN25T9pf6Mz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=folCdCZ3rM+Oh6fwMe8vN718ZzNM7gG0liPXWB5HAwTgYiOkFFE86tu+NkT0t1MYHJOoTc+LpqkQotPP+1BXHPb0nZ9470XqG1iWFx3LXYuu9ou7u7XtGqzRY+mzzUr9XTK6a/2/grbQi/2OfLJThF2O3cS1UpF5RxnlO7KFmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp; spf=pass smtp.mailfrom=bcc.bai.ne.jp; dkim=pass (2048-bit key) header.d=bcc.bai.ne.jp header.i=@bcc.bai.ne.jp header.b=Lf/6EaDs; arc=none smtp.client-ip=210.171.6.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bcc.bai.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bcc.bai.ne.jp
Received: from bccml.bai.ne.jp (bccml-a.bai.ne.jp [210.171.3.161])
	by rmx-b.mailgw.jp  with ESMTP id 57L4JXgl015567-57L4JXgm015567;
	Thu, 21 Aug 2025 13:19:33 +0900
Received: from subuntu-desktop.bai.ne.jp (bai859bcd79.bai.ne.jp [133.155.205.121])
	by bccml.bai.ne.jp (Postfix) with ESMTPA id A30E88054A;
	Thu, 21 Aug 2025 13:19:32 +0900 (JST)
From: Hide Hako <opi5plus@bcc.bai.ne.jp>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Hide Hako <opi5plus@bcc.bai.ne.jp>
Subject: [PATCH] rm64: dts: rockchip: Enables sound output from the audio jack on OrangePI5 Plus
Date: Thu, 21 Aug 2025 13:15:56 +0900
Message-ID: <20250821041555.4781-2-opi5plus@bcc.bai.ne.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FE-Last-Public-Client-IP: 210.171.3.161
X-FE-Envelope-From: opi5plus@bcc.bai.ne.jp
X-FE-Policy-ID: 3:1:23:SYSTEM, 3:1:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=bcc.bai.ne.jp; s=20240516; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=3QZn1YoSh3Q8XHPm793CBLJp8xovUxZX6zix9L2ZwO8=;
 b=Lf/6EaDsG+DNeeEUuOTYCYh93mbMnyyB0JgnHvmdHs6iK5EG7bxI4axBZp2NNPY4p6ZjTA2VxO5V
	KdCBgCSXAYoH1wCwuldMT5q349AuPHkzMNgbMlYSKt0o7M2VX/5JE8Tjfvi6dldZO7BUWZH4dYH9
	5uQu2EOHWL3WXQScftjkwmJIiPueEz5BN6epWMds410OltS0o+zjmFaLcJAzJh2ol4bHzr+NWXRP
	iN94S6DLb1j71EB/+cWl31nDM9hYEXAACoDJtLJEfRWYIy6H2aNopZBocFDQsskaVzN8/LzTe9Xd
	n7ADw1LkGUr5o7OijPL/J6kMkMMiUivDAWt0kg==

Currently, analog sound is not output from the audio jack.
This patch allows you to select analog headphones in alsamixer.
Works with kernel 6.16.1, but not 6.17.

Signed-off-by: Hide Hako <opi5plus@bcc.bai.ne.jp>
---
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
index 91d56c34a..656aac2df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
@@ -113,6 +113,7 @@ analog_sound: sound {
 		simple-audio-card,mclk-fs = <256>;
 		simple-audio-card,bitclock-master = <&daicpu>;
 		simple-audio-card,frame-master = <&daicpu>;
+		simple-audio-card,pin-switches = "Headphones";
 		/*TODO: SARADC_IN3 is used as MIC detection / key input */
 
 		daicpu: simple-audio-card,cpu {
-- 
2.48.1


