Return-Path: <linux-kernel+bounces-852399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B3EBD8DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 858CB4FF14C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C92EF65C;
	Tue, 14 Oct 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mf9AQlgT"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798A34BA5A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439632; cv=none; b=URC1ZqRMvvlvmmYdncLDLPSoI90dIlQDbQxeaZUp8wFZicNYhRFOAv2X+CLDoG/7zIJn6a2PtOQ8WDfN/W7SIhN/owEZ3XbpXNM58YlgwMVKucjegl3d3C9WGh/pVYnVfxUJm/vXYQpkaSVKf5MEmlLwbPUp0b186ZmCxcKhsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439632; c=relaxed/simple;
	bh=xcEHefptRm3q+B/7MsjmtDUbajTynS8kek98wtLXEzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rbdkYIpJeCe64SH7rd6LXLzzRLY9B5lntmD9XQ0krActx4Tk+sahUhMbQemcAfdQoJgEXRe4N9gBoboouPKIMo1vNRS080mrSsGFADp8DFx+43POz//PoBqmqNaUVL+DEcLvwjxBFaFD5KHo+MGfcrZkZXPDeWLpvHrlP79umA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mf9AQlgT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3737d09d123so39839401fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760439626; x=1761044426; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjAPjhv4d448Try5P0FP2VsI1UmiEtL4eWhCUt/f9q8=;
        b=mf9AQlgTA4U5NsEiNUucZFru0M7YYsnkzqo5Pz3G2gxIpBuWwJ3eWvXNvUYowOQ/P8
         3Oe/CUenCD8YilSHzT1EIaSrJieK4XT9SPWVEdgY1b1+7YAg0KSCu/oTVCuUtQI+215H
         x2AXSG1teaKrW51tZsBbFbNAeyWvDpUPuAjSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439626; x=1761044426;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjAPjhv4d448Try5P0FP2VsI1UmiEtL4eWhCUt/f9q8=;
        b=TLPfx3bbn2rfgw0thjbjXAIWAkMmOKQ6KHrN5usFbPyYKkP5Nb3TDSY83vBSbD+qLO
         +CGHT7AfkCk0+4PQZBcZzIFnfYm6ZSOGh3KMPxS5OyBgNF5dEnkjg0ijtzaua5PqHjC5
         1T0dEGqdf/7PLD3yyIVm7gq9YpK5a7jcjFxvCu1hnWwDdhK5vz7ot74pi2Sy3qzqwa7f
         385w2Ry40wa7XAOO2kh1UEEKCjrYYFjLNoY9ab/MMSJkqiM4RApGVq58MxumJZN7++OD
         qMBJ8BGsJ72Ebn+QhhKrTGEJjNd5fKBxY6iuvKVTg+aeQfXoHHA699nJHOFGtKR8d4oR
         FW7g==
X-Forwarded-Encrypted: i=1; AJvYcCXdWfW7KUGx6Ib0NDZmVeuUuPzjmVg4fsWRyxtYZhodFJBUvykoLESZ66SWJNwvpYfeRD5Jtl/CkEQW7Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8hzDLNE+Rkg18j8LD/kr7UKmbuE4KICdqpbUm0dC3w2zeviO
	y39HygJ3fAJXUgJfWppw99GkY0hJ41/3o+lgtCtlBV4dVcHg+5ZzKB96M3ye4KLzvA==
X-Gm-Gg: ASbGncsjhnJkYztbj8yJ6FGp4ws+KR1dtnbgC1az6zV4kgoBfjj4ye2zF62Iu2geWVi
	tvx1GtYVjpe3GgiOHiQi9WQQKZBRBHnPXGOSvBiIzUVhXzrFE4IyfnJpnfY396FUW24Pilqw+tW
	RotKMMBEQt+Fic5vsfgMgTo2lXuCBpnbgfmWQzv2ldfv8Oz/OhZVA1k8WTy9n59QPBy41Jcsfwo
	C306ieIhmHN6azm11rOD9+fhm2bm7oGGsBUscKTirAjr2QuW/vm0Wu9TYwN6FpOtGWNFjcXaLcH
	Ngp8BWD/iGUuUAsqPSmuMR2xwRt1xMougqE7iDyA9OvyP71AzCnsvr6RiOTSzwZLdvTYYe6ZMZv
	OSVqRnno7sCmzuVlLmU3usOuAh+PbpNdk+06qHUgmCX+8M2SlulSXOoGNo8w2dMBYHzfHmkYmsw
	bDFpolpwwGTflduqSUvCTg
X-Google-Smtp-Source: AGHT+IFGWJThrVzinUTUKLlvxn1wPB2/v9XNcpskq+s3lKiZ/x5AJ/mF4Gm9gftYdVHKyFf+eUCPIw==
X-Received: by 2002:a2e:beab:0:b0:36e:4481:9e89 with SMTP id 38308e7fff4ca-37609cf6b00mr66565701fa.11.1760439625479;
        Tue, 14 Oct 2025 04:00:25 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762e77c9f9sm39153191fa.5.2025.10.14.04.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:00:25 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 14 Oct 2025 11:00:17 +0000
Subject: [PATCH v2] media: i2c: imx214: Exit early on control init errors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx214-smatch-v2-1-04218043086d@chromium.org>
X-B4-Tracking: v=1; b=H4sIAEAt7mgC/3WMwQ7CIBAFf6XZs5iyBUVP/ofpoQIte6A0UElNw
 7+LvZt3mpfM7JBsJJvg3uwQbaZEYa6Apwa0G+bJMjKVAVuUrcIbI78hFyz5YdWOaWHqrgKVkVC
 dJdqRtqP37Cs7SmuInyOf+e/9V8qccTZ2hl9k9xLKiod2MXh6+3OIE/SllC9kAj1orQAAAA==
X-Change-ID: 20250829-imx214-smatch-c4d4d47428d5
To: Ricardo Ribalda <ribalda@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Now we try to initialize all the controls and at the very end check
ctrl_hdlr->error to check if one of them has failed.

This confuses smatch, who do not know how to track the state of
imx214->link_freq.

drivers/media/i2c/imx214.c:1109 imx214_ctrls_init() error: we previously assumed 'imx214->link_freq' could be null (see line 1017)

Fix this by exiting early on control initialization errors.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Right now we are handling this with a quirk in media-ci, if Dan cannot
fix smatch in a kernel cycle we should merge this patch.
---
Changes in v2:
- Fix typo in commit message commit
- Move error tag where it belongs (Thanks Hans!)
- Link to v1: https://lore.kernel.org/r/20250829-imx214-smatch-v1-1-f3d1653b48e4@chromium.org
---
 drivers/media/i2c/imx214.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 94ebe625c9e6ee0fb67fe1d89b48b2f1bf58ffc6..c66f0e18726c3fc15df91c37888a797bcea82134 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -1014,8 +1014,10 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 						   V4L2_CID_LINK_FREQ,
 						   imx214->bus_cfg.nr_of_link_frequencies - 1,
 						   0, imx214->bus_cfg.link_frequencies);
-	if (imx214->link_freq)
-		imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	if (!imx214->link_freq)
+		goto err_init_ctrl;
+
+	imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	/*
 	 * WARNING!
@@ -1099,6 +1101,7 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 
 	v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx214_ctrl_ops, &props);
 
+err_init_ctrl:
 	ret = ctrl_hdlr->error;
 	if (ret) {
 		v4l2_ctrl_handler_free(ctrl_hdlr);

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250829-imx214-smatch-c4d4d47428d5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


