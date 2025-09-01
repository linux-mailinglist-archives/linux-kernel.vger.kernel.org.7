Return-Path: <linux-kernel+bounces-794762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB16B3E6EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E71A83FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49393376AD;
	Mon,  1 Sep 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="nBlzbBqW";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="pV/zSamT"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3F3322DDE;
	Mon,  1 Sep 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736576; cv=none; b=sG2WSrY/eC4LMVZqp0Wn1CaWbt2Zrpb/r8AUZDHFTihVc+PbmAY9610V+lVp77L4KcWNliud1Cek29nlVLnUxUKbDNk4RoAwpHh8cVvh8QprAumDd9A5kSP7jto0uGbjIIR/no7DwhFPqTiqAWGmnqj9uYCnY9l3hAUTg1IYdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736576; c=relaxed/simple;
	bh=SmdNN49hUuOKQIeXXh0pzQHpcSXzkQPO0HJLe/izY4k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KupQdYCYnf4/anpo8DGdY+mS4ojM0b/d5Z99uyyfy/kSe4uJ+kSYuFdkoLvwxv9eWxSJiUeXyq3uvzYfVtYnKEk7xtyajmtX192q3gykTmkG/A+Ij2+mFchUJvK3mnN9iXSeM2StZgSABzfnRGeDEmbTp03Yb+7qkJ2R9JmVYJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=nBlzbBqW; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=pV/zSamT; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1756736563; bh=SmdNN49hUuOKQIeXXh0pzQHpcSXzkQPO0HJLe/izY4k=;
	h=From:Subject:Date:To:Cc:From;
	b=nBlzbBqWP3doxiXUEnFgCAWYxcFL7cVlkWosYYBFHRT+7ti178TxkjKhOZzH/3wXN
	 vaSXtZU9blp7xKCLVpK9RHoywOj1RPKkL2x4nD0wuuGuP+DjgjSw9NZ0UwGbuj7+Bb
	 z5weTua4MEKCoQdGkbzcQJ95sNpgMwM6SKQmH/ic9+8ws+mZyWVRRbcHMgRGKZCKkr
	 T5UGoIYHqvaPXrgOdA+b32CYgqNtxF1NLp5VWvBcLmf7J2gm4L/W3MO3pnbcywqSE3
	 rlyHntmT9B+KhHUFFFtBrkHtGR0G9pp6opec9YfAbYupRlOU2ZOlmIO9Ngwy+jsMjG
	 bWRs7lJmM8F+A==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id B855BFB07;
	Mon,  1 Sep 2025 16:22:43 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4KFeGVDPrzFf; Mon,  1 Sep 2025 16:22:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1756736561; bh=SmdNN49hUuOKQIeXXh0pzQHpcSXzkQPO0HJLe/izY4k=;
	h=From:Subject:Date:To:Cc:From;
	b=pV/zSamTHYq2xmrr5oJda8UXobzIVYADMVba2igmHayfeF+gC7/pO2VECS6I35pbD
	 DW0HsbVXn0WwqWtOzv0+mgIKvtyulgUzbR20HNMve8zsuV/TR55jOULnDaZ7RcER9g
	 itk45Jg3v2O02XOqxJIey6t6aAtAuILhLIprdq/rQDKAWNoCF6yF+9TJI+jEbn6LDY
	 1tcMoghfxMDLw+Fvc67YwDZla/4NtUyGwWVTL+R65wqQ5oYTgA1EDpibPJRxeVS2bJ
	 /TqzdlLBXY0wa2y9H+LiDtgJoGFykIiQkjaZT2povE+WemAwUrADPkqayuz50sbBAI
	 d6kKCGzM51J0g==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH 0/3] drm/panel: visionox-rm69299: Add backlight support and
 small fixes
Date: Mon, 01 Sep 2025 16:22:05 +0200
Message-Id: <20250901-shift6mq-panel-v1-0-444b4abbfaea@sigxcpu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA2stWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwND3eKMzLQSs9xC3YLEvNQcXUtTyyRjAwvz1OQUIyWgpoKi1LTMCrC
 B0bG1tQD6N9VRYAAAAA==
X-Change-ID: 20250901-shift6mq-panel-959b3087ecd2
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=SmdNN49hUuOKQIeXXh0pzQHpcSXzkQPO0HJLe/izY4k=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm90YXdaT1B5Vmc4L0lWVDM0c0s4b1FyN3pEdjYvCjNCcDVVcUd0N0NRbWZRTXh2
 bVdKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYUxXc0dRQUt
 DUkFsdjRaU1N2ekI0OExGRC85R1dkbWNOQkJRL201RjZac1kzcWRmZEFlVkpXYVdCRmc4cTB5QQ
 pmS093ZFFReDJmOVBGT1c5N1d1T0REV3o3SGdmOWszTzZUU1lwS0p4ck42ZWZXdEl0b1ZBWGs4b
 040M1B5QzROCjM1UlBVV0ZMZ1RRWk9uT0gxT2FpWEd3SjFhRWEranpNbzhwSWRwMkpoM1U5OVc2
 K0tOZlBtQVdIYXVFY0kwSkkKcXVYb1Q2VVMrbllXRElkOHdtNXg3QUJBbHpaRldCdTZNZm9iV3h
 jdnN2Yi9LcFcvTkRSaE5xQUpLcHp5OGVIdQpta2U5ckpXWW1QVnVLWVhVN0FCSlNNMXlHcVpNTn
 FHcEtqK3JORERRRlIyazk1dDEvbzM1bFlDSitRbU1MdVZVCkZFbzYrZ3lTbWVtanBlR2MwTUtkZ
 WFxWVdNRURrdW9rNDNlUGwrOUFrSEw0Mmk0dXM1ci9wZFBISTNOSUZvN2QKMXdXYlV6ZkVnOURa
 cG1YRFdTOG5SSDR2ZGxEZGdaYlFUSktpV2dHMThQVXd3ejBNSitZNDFrSTM2cDJYRDFaMwpoVTQ
 0cGV3djNhOVU2MVhnd1NYZG5sa25CaVRTOVZyVytPdTJlSmlUMEJsbGJoTW5IVU9QMmpuaXJtL0
 RMVkZ4CjlrOFhnSnc3R0NJUDlNalp2dlN4Sjh5MERhd1dlU0VVeUprVWF1RFN3VVU0ai83NFdyS
 0FXNDdGNWgyWmppNzYKVnlGTzU2MTlWem0ybVBLdVl1bnBwdStFTXg2VmxINVB6RlcybDhCc3Bk
 QnRsMEJNbGM5UXlXVEM2MkFDZmVQVwpnSm5TNVp3VGM3ZG5HbWwwS0t1elY5MDgvUlNBNS93TTN
 OSWJhZHlIU0NHTXkvQ3F0Yi9nM1JRalJETjZhT0tUClE5NnNiUT09Cj0xaHJyCi0tLS0tRU5EIF
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


