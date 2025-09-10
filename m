Return-Path: <linux-kernel+bounces-810691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF780B51E03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDAF17A0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725CE277C9A;
	Wed, 10 Sep 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="Ao6jSOZv";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="eAs3umGN"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBA1E520A;
	Wed, 10 Sep 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522460; cv=none; b=pmPbDtj4OJ6W+HV9YNwBYdEMnOOH8Hkhl4JxZlSSW22fTcwipX/C9q9gBRFATQ8bGqg0SYCHoNg2Tk8hh6/P4np26mrNAoT/YJofe1S91K8/6e50981h29JIH3jXFUXwa/RzRoL3Rx8aYFIcN0SBGIDfp00RKuDWBqh2h8V+nyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522460; c=relaxed/simple;
	bh=uxOG//dCZ2ttzLEjwimxxM920Akc8lBjHA5Df1qVSH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuxCMTDu44b7xZpAiBO5yoim40sifdet9OZ7kqV5cGouP+WA/+FIEut493e2y+UuftWHARlZw6ili9W9CizSMBv7wfqHItK0TN1jIBTDTLCEGonzZgFma90wVo3Huqr/dx6G7/GxpGH1U9x4LknXnNCdJNXOAb05vMoeu4uyUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=Ao6jSOZv; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=eAs3umGN; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757522447; bh=uxOG//dCZ2ttzLEjwimxxM920Akc8lBjHA5Df1qVSH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ao6jSOZvI4eYuQhAOVYudo5ZVZuzLaStBHo2Udj7o7eGNc7PBmg1jKa6kSzCrYqDz
	 42GVDaCDQ9IMJDkBgxiQlHVCor229SJgy2OZHuiKw2fVWqmFifwhCxJ9mmC0VKc+Zv
	 yDXxLAQyQegpQdklwjazj0JTWRwoq4q9Uy6jwURJuIc3470W52DlWZJrmk4Wma0hEB
	 Gpb9pm1I9lElrKc16+DlkeWIJDIuD3jOzYhJW6C2iwCMkOLYjJv8M5aMFBguAz90WY
	 qHDMRNurLtUOL4JiJdChXEfngEHdBE2FLh/P7BjYZWcSO8Wo8LsFUZ/FYM7hhlQfIm
	 cYikzrrzv43Bw==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 31875FB02;
	Wed, 10 Sep 2025 18:40:47 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eYp5uqBiyFwJ; Wed, 10 Sep 2025 18:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757522442; bh=uxOG//dCZ2ttzLEjwimxxM920Akc8lBjHA5Df1qVSH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eAs3umGNOboYL8sw290wkCngWZgmKLIlSikZ7fdjKzeLkcrEZeVyctIx6oEgTj0+Y
	 N/FcnHjrZQX71XWIiVB5NgDtvnNzLVMxklsIDyyZesAG3kjkwCKyyQ+5DfFVed3VzJ
	 qnic2AMNSQkz5crpYNQsVEqhDmF2Sml54fGbwnn+F8ZHLaxj9rCU6WlgxZJM5yCm59
	 iFn6tijMphlqnUHJaSBT839sevKjNCHkotXew7vldCsQs7r7rxKVrGQ3oQbpUC5Unq
	 9seq2jMU2VHFjaSQqFfes9wEWYlL9Ke3lGNYmgUD2M5KIYgNHi7dwaSMVcoCkQC4W3
	 oVnto6lc6sZyw==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Wed, 10 Sep 2025 18:39:56 +0200
Subject: [PATCH v3 1/3] drm/panel: visionox-rm69299: Fix clock frequency
 for SHIFT6mq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-shift6mq-panel-v3-1-a7729911afb9@sigxcpu.org>
References: <20250910-shift6mq-panel-v3-0-a7729911afb9@sigxcpu.org>
In-Reply-To: <20250910-shift6mq-panel-v3-0-a7729911afb9@sigxcpu.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Kaehlcke <mka@chromium.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=uxOG//dCZ2ttzLEjwimxxM920Akc8lBjHA5Df1qVSH8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm93YW41RU5obEFMWEFIbDdHNFVnL3JxbEhFdTNXCnUyaEZFNUkyUlZGUEhqVmJl
 MHlKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYU1HcCtRQUt
 DUkFsdjRaU1N2ekI0K05wRUFDQmh3ZkMzVzdjYm9HeU5zemJUWFlFNUk3Zk5jZHY4cXQwYjJQUQ
 p6eTk0U1JBNFh0OFJiNXE1MlJQVVdZelI0NzVtTnFEYTNJZk5lUGZaaTc5OFJFK2t0Y0lzdVpsV
 UR3TmlaZ0hXCmtaakliRVB6SVR0NEdFMC9ZKzEyeFE1eHV5Y1Z3Y2hCeWtkVDEyc1NKQmxJWXdV
 bndYRDFTODc5cnZRSjFOT28KVW5pVW41dTZ4NjRtRk8wTkpCMEloTXNvVjlIbkVBOUxqeDg2UXl
 sUXJQQ25ZUkhPOW9kYzZhWlYvVlVzRVNDegpvZ2VRaVdhclRnRmh0NVdkYzVXZ0twekNOYTdvN2
 puem9sbzVtc2R0VGNWbmlhb2d4dzNPcVgvUmNJY3RsTjE1ClNLNEM1NElVN0ZFSkdpa3hPN2UrK
 0FuTFRnVnFUZkFCMnp2elhVSlA2Qkx0SkpjcUgwV0pLd2ZJOHE4RW0raFAKVkFiUUk4ak9najJm
 a3dSSjVCZDNkS2ZZWkdRcXMrVjZjd0wySS9mQUF2MS9kOGpEZ1dPVGFQeVFWbGRpckJYdAp1dUU
 yVm9la1k2YlpNV2wxSlhhNnNXR2E3TnNrSmFnNmYxODhnSHRPcnd1Wk9rRmVFSUJKUTBoZ2NkLz
 FRV0JmCnVjQmNhcEdBL29MR084dWI0TytWTGtjVXNlL25aLzVZK2JRcjdoNUFCY2x1N05Sd3ljS
 TZOSnVKcGZlS1M1U00KVDUvL3RyRTI4TisxRTVITTZVVW41ejNNZGllV2E5UXIrbVhlSkE2U3pH
 M1JvQ2tJMlErZTNrNlZPNnlhbmRTRgpLdnlOdFJQU2dabGQ2NmgvcVpvTktQTndwUTBHNXNYQjY
 4QzBVMEIyRDJNUHJrNnNVODBCUUk5bUhGWC9TTDRzClRmb1FIQT09Cj00SEVnCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3

Make the clock frequency match what the sdm845 downstream kernel
uses. Otherwise the panel stays black.

Fixes: 783334f366b18 ("drm/panel: visionox-rm69299: support the variant found in the SHIFT6mq")
Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 909c280eab1fb408a713d84051a1afbb252c45e8..5491d601681cff52eca1d72ad4489731d2276c30 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -247,7 +247,7 @@ static const struct drm_display_mode visionox_rm69299_1080x2248_60hz = {
 };
 
 static const struct drm_display_mode visionox_rm69299_1080x2160_60hz = {
-	.clock = 158695,
+	.clock = (2160 + 8 + 4 + 4) * (1080 + 26 + 2 + 36) * 60 / 1000,
 	.hdisplay = 1080,
 	.hsync_start = 1080 + 26,
 	.hsync_end = 1080 + 26 + 2,

-- 
2.51.0


