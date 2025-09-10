Return-Path: <linux-kernel+bounces-810690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE90B51E04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF7B1888FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8212749C8;
	Wed, 10 Sep 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="KVg4UAqh";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="ASTI7upd"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78184262FD4;
	Wed, 10 Sep 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522459; cv=none; b=U91tZhXPrYwNEzs6aHrg2GtMt62EI/pyS1rJLaPetIQlevt3ggW7PqfYGBYIhYYF6C8fGJR0ALEZmNDICu/bkUV5uOu81PcDkakhjPCI0QhOkBFhYCrpdv8iyQaxGoXD1oowXW2Se7XXCcXBtsSrHYDI8BM/0Ib2rMaCeXgVw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522459; c=relaxed/simple;
	bh=gGA8cxzPPsutuIQEV9d2uVQQve6kWVH4sV8F3OXwkNw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=icg9SnUCjuko7qfRLMlHJdxVimpylwmkHsR3d+1PleYizwcrGB3JgG5I+PqNtuRhI/+H87azeBmVFwJNwtk/yjN69V/LRwrz2+ZhlCdecDBbA9P67uDM+386VH1b56UhG5GzwMEhC3VKME/5WUXs3z1cSQI9yaMunHoAjqPj0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=KVg4UAqh; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=ASTI7upd; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757522445; bh=gGA8cxzPPsutuIQEV9d2uVQQve6kWVH4sV8F3OXwkNw=;
	h=From:Subject:Date:To:Cc:From;
	b=KVg4UAqhExq5W4BPJ0AUN6X9ac+QyfeuqfcqPeEvbpOCTDV/f1H16raNanB2zNg5d
	 oBSLw+IOuHRRxvJRBwzfKoHPaPEkccmPDyQH7ohamoLcmjKWPSVbqHuwTGvEIhtJ2E
	 Pb1NJcpw4Qx0lH+j9cDiquvlVpj8DkIV9ezoZmqOacvoIEECRWZbZMAG6dyL7IRAm8
	 eAC2mNl7zqeY/yevbW3wHQRBMPGmPLG5V1H2yQ9h+wS1caCw/PyRn2TQhHkV7Mu53M
	 scz7Xp3wjOYs22nTBMo6ewVntSKKXZZDewgQSbn6ujdojRShh/5kwrnGCCXlUBBGtr
	 pzUGnHw6QjlAQ==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id C7C77FB08;
	Wed, 10 Sep 2025 18:40:45 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jZ6L5AInDSPs; Wed, 10 Sep 2025 18:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757522442; bh=gGA8cxzPPsutuIQEV9d2uVQQve6kWVH4sV8F3OXwkNw=;
	h=From:Subject:Date:To:Cc:From;
	b=ASTI7updRCjTGFaeNzPiRlJfEeiO76QbNEdX5hJmAQ70gkshVAG3HHrJc6yvopGC/
	 9h2jNEnAUay1NilDt3rBCDB/kKOmQyvmx3a/Sky7QcvGSqw9QfRK8ObCXn4SKX4gvI
	 welO+SWrl+11RioqOgC66OZr/hVebasnDRWN4C+TAhOFwR5pXHksyQYB0/PEZ+LG12
	 M4EDVr61o14M+FcJO32BttYVbgR0FbwWqr318YQ9UhNJYuJdg+RR9QPbUOqt5UwAUD
	 2Now39vf+vibjTE2nSZTRj3X/4rcs2mVuqpOlGEyB2jQxbSjwGGdxj4tDKhMn+eUlE
	 wD7USndeOFcTA==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v3 0/3] drm/panel: visionox-rm69299: Add backlight support
 and small fixes
Date: Wed, 10 Sep 2025 18:39:55 +0200
Message-Id: <20250910-shift6mq-panel-v3-0-a7729911afb9@sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANupwWgC/3XMSw6CMBSF4a2QO7amLS0PR+7DOGjhAjdRwBYbD
 GHvFkYa4/A/yfkW8OgIPZySBRwG8jT0MdJDAlVn+hYZ1bFBcql5yQXzHTVTdn+w0fR4Y6Uubcq
 LHKtaQjyNDhuad/Byjd2Rnwb32v0gtvUvFQTjTClllbG2MWjOntq5Gp/HwbWwYUF+AtkPICNgj
 EZd6LrIRf4NrOv6BncWShDvAAAA
X-Change-ID: 20250901-shift6mq-panel-959b3087ecd2
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=gGA8cxzPPsutuIQEV9d2uVQQve6kWVH4sV8F3OXwkNw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm93YW56NUczUjJTZHRRLzFMbHZUell0UFZPanRWCjd1ellWY0V0ZGdJcjFBd2xZ
 UkdKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYU1HcDh3QUt
 DUkFsdjRaU1N2ekI0eUQyRC80ekV2Q3dKS1lsS0hEcDJGSWVmb3h4bHVkZHl3bDNGdjFOWVd0TA
 pWT3p0QTFHempHSVpGRW1EZlBjSUdJUXdqbnExMkd5UjA4UXJSUDE0VXFEQ2dCT2JreCtVbGpsY
 29KdVhrOHcrClNVM0N5TjFyWFFWdnlQQ2hmWkxiSmFWUUlrL0RRRm1pMVpDUWJ5RHRlc2lnUFlD
 K2NZNkViN0Y1R0p6ZTN4VzEKeHU1RHFyOVVtVWYvaUNzVzZucmN2WngvWUdYcXd5eVdoVm44OUJ
 QRzEvbUJhZjhTRTkvcFJXakYxUHFza2plcwo3dXYvNGFwL3VYcnpHc3lpRVNkZDlOMmcxVjhEZV
 VGdHQwSG8xVk9WeVdWZDZZTW1IK0RzZ25WZmM0Zit1S3drCkxTazc1VjlTZHQwejhWMW5sYjdlK
 zRPaXpUT2IyN0VtMCsrTXkzWkgvcEtOc2REUUwrZndrR3hhN2g1OHdpZFkKaVRjbjA0SXZBbVhC
 NHpkYTJVUklaQjVFQ1hqaUdxd3V5dlR1YVlyYzhERVRkNkp1bktUSUVpRjdaLzRLSGdWZwpBSmZ
 MZnFxcnhFNGhZcUxBM21TanN0eENHVHN5ZTl4WUFjY05YSW1lZmZ2aTBXdFg0cFFXWjAxSzB5SV
 I3a1UwCk1mYlZJMVRWN1gxMlhPZ0llbTFZVjFuOEFQckNUakVFc1grMHNYTnY2dGNvdllVeU5HT
 2g3cEdjS1ViTTF0alcKRFg1ZDZVQ25KTlB1VERHSXltQzhvNWdoQm5TcWluYldaRXptd3gwWDl4
 UnRnZHkyQXN5YUhCRmNseGFGOHdsWAo3Z25CQTJ1WnpmUjdEVVpPdEdVbExtMmdxemhDN0dOcmt
 Fa1BxSld1MTBYaHE2ZlhnaDdoRTZ2ZmJCb1pBZnZiCmJCYzdUdz09Cj1ZK0NlCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3

This adds optional backlight support via DSI commands. If
a max_brightness is set in the panel description the backlight
is created.

While at that we fold in the already sent out clock fix and
a fix that prevents us from clearing all mode flags when we
only want HS mode.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
Changes in v3:
- Use clock formula in `visionox_rm69299_1080x2160_60hz` rather than the
  calculated value, thanks Dmitry Baryshkov
- Link to v2: https://lore.kernel.org/r/20250906-shift6mq-panel-v2-0-aa5e585d8717@sigxcpu.org

Changes in v2:
- Add Fixes: to the first two commits to make backports simpler
- Collect Reviewed-by:, thanks Neil Armstrong
- Link to v1: https://lore.kernel.org/r/20250901-shift6mq-panel-v1-0-444b4abbfaea@sigxcpu.org

---
Guido Günther (3):
      drm/panel: visionox-rm69299: Fix clock frequency for SHIFT6mq
      drm/panel: visionox-rm69299: Don't clear all mode flags
      drm/panel: visionox-rm69299: Add backlight support

 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 71 +++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 2 deletions(-)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250901-shift6mq-panel-959b3087ecd2

Best regards,
-- 
Guido Günther <agx@sigxcpu.org>


