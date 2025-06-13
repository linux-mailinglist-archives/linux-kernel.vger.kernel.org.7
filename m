Return-Path: <linux-kernel+bounces-686093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D9AD92F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 18:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6704F7A6123
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D2214811;
	Fri, 13 Jun 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6fNnxut"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9645212D9D;
	Fri, 13 Jun 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832901; cv=none; b=gVqM2VLWIjSDEKeQtm7CSi7LtU1foFsSuUU9EWKGCRadUgSZablGKYxonjsNmbs0tsujveadQ6JwKeu64wAS9iFu4TWsGYJtkK6+/pOhW/mFV1k2XT3DQHGyFe6Xat2Bht9T7alJm1FFQfGrLiRaFpUsn4mtfDpxTYi+t8znL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832901; c=relaxed/simple;
	bh=j+85Z9iN6id/AZxF/3c6k5SRIkQ38TfU+QOw2QPbJ8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WlFlc8nRpdTxaoj6xZnV/lTB/53cYI+YfVuIe2hmMOPOt3P76p0ehri6RsFYUeG2GUFrdgdry7Wx3axiqP77gPg/gbW2hlqZpwk14+BWPN613gI3pExSD+jQBesLbQ8JTKs7yv/N25OJbky8j8QFxInnpFIsZjqzNX2/Y+Bu6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6fNnxut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635D3C4CEF0;
	Fri, 13 Jun 2025 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749832900;
	bh=j+85Z9iN6id/AZxF/3c6k5SRIkQ38TfU+QOw2QPbJ8w=;
	h=From:Date:Subject:To:Cc:From;
	b=N6fNnxut65qhEuKg9enKMwgzKL7Wacb/3e7B6NfRkjdGw9xIu3r5NQsiMd+64f5/Y
	 MCEAN4Qes1iuM5Nczrl6SNV9VFMnNyA7t4sk3ElkUxZABBJOiQJIqT65VBrIREL2l+
	 bT1/f4ZaflvPej5n9VhZZt8qtiN/yZLqIV646exvAs2exq/dP9yXH45h85TVAc5IId
	 6jMl5hUg7ZkG4kSjcNiw22gZ6V27x69OITk+VB+xr+RfMYeUxttmS4vk/jbY/D7hLT
	 xsQpx1CxZSGOnfScn6bU/XLGC2Orb3m4Zm6KTbekETkHvSMW8nTRaDuGLw8TTyp6IP
	 apLZAV0WmNTHw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 13 Jun 2025 17:41:04 +0100
Subject: [PATCH] ASoC: hdac_hdmi: Rate limit logging on connection and
 disconnection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-asoc-hdmi-eld-logging-v1-1-76d64154d969@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ9UTGgC/x3MQQqAIBBA0avIrBvIIoOuEi1MRxsoDYUIxLsnL
 d/i/wKZElOGRRRI9HDmGBpkJ8AcOnhCts0w9MPUKzmiztHgYS9GOi2e0XsOHqXc3Twp45yy0No
 7keP3/65brR8jrGH0ZwAAAA==
X-Change-ID: 20250613-asoc-hdmi-eld-logging-11bf756cff6d
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2292; i=broonie@kernel.org;
 h=from:subject:message-id; bh=j+85Z9iN6id/AZxF/3c6k5SRIkQ38TfU+QOw2QPbJ8w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoTFTCLQoZVWZGDdV4XfO/HfdlIqg/6O2BeqOGV08y
 vAWrtPqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaExUwgAKCRAk1otyXVSH0HSaB/
 wP8CA12qJpoQG9DN3qyrYnlFc4egfdjAOYzx05tIe61x1ZloJ33iPLMbhuCYoQ89hqJqrDWbXHUrL0
 Sauo495wQpM6MHW1LGrFOkdaUUypqVBMs032pGGYj26eUdgXU2qvJZYbsbYn7L/4i8j492040AyhaP
 0bWSxmBeYRC/Lf+zTKzux8QuLX1GUuhBmRjKq4sUnPP3021pk5UVl+IsBWhsBIvBnmRyhuNtuUPvic
 YI0RkriHy2A9pEmJqkH/sXDrCxWbL5OcCcDeAjMMmUcjIoOtmfizqvqc1mYn84OyyngMU2f4RUUIPp
 pexxpqF60PZxXLuW0cK6nnxW6ubn2g
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We currently log parse failures for ELD data and some disconnection events
as errors without rate limiting. These log messages can be triggered very
frequently in some situations, especially ELD parsing when there is nothing
connected to a HDMI port which will generate:

hdmi-audio-codec hdmi-audio-codec.1.auto: HDMI: Unknown ELD version 0

While there's doubtless work that could be done on reducing the number of
connection notification callbacks it's possible these may be legitimately
generated by poor quality physical connections so let's use rate limiting
to mitigate the log spam for the parse errors and lower the severity for
disconnect logging to debug level.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 1139a2754ca3..056d98154682 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1232,7 +1232,8 @@ static int hdac_hdmi_parse_eld(struct hdac_device *hdev,
 						>> DRM_ELD_VER_SHIFT;
 
 	if (ver != ELD_VER_CEA_861D && ver != ELD_VER_PARTIAL) {
-		dev_err(&hdev->dev, "HDMI: Unknown ELD version %d\n", ver);
+		dev_err_ratelimited(&hdev->dev,
+				    "HDMI: Unknown ELD version %d\n", ver);
 		return -EINVAL;
 	}
 
@@ -1240,7 +1241,8 @@ static int hdac_hdmi_parse_eld(struct hdac_device *hdev,
 		DRM_ELD_MNL_MASK) >> DRM_ELD_MNL_SHIFT;
 
 	if (mnl > ELD_MAX_MNL) {
-		dev_err(&hdev->dev, "HDMI: MNL Invalid %d\n", mnl);
+		dev_err_ratelimited(&hdev->dev,
+				    "HDMI: MNL Invalid %d\n", mnl);
 		return -EINVAL;
 	}
 
@@ -1299,8 +1301,8 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 
 	if (!port->eld.monitor_present || !port->eld.eld_valid) {
 
-		dev_err(&hdev->dev, "%s: disconnect for pin:port %d:%d\n",
-						__func__, pin->nid, port->id);
+		dev_dbg(&hdev->dev, "%s: disconnect for pin:port %d:%d\n",
+			__func__, pin->nid, port->id);
 
 		/*
 		 * PCMs are not registered during device probe, so don't

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250613-asoc-hdmi-eld-logging-11bf756cff6d

Best regards,
-- 
Mark Brown <broonie@kernel.org>


