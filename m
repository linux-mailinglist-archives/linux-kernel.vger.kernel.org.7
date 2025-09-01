Return-Path: <linux-kernel+bounces-795043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00FB3EC3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E231207E63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CBA30648E;
	Mon,  1 Sep 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9bkBcQ8"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0B24A04;
	Mon,  1 Sep 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744390; cv=none; b=t2hilMeqTvJAp0f/mxmhDJc9AnXEFFxD32NeFjB5laLTd/a4HCIRNrZ0GMIjNA5KDlJEKnKE3OlKzHjL7gFR+rFBBecgP9oxxG9NZw4mMweq8Sl9TVhmDc1Y3OY8OS1xYqS8lzEx0na00+cE8uv5qrS6dj4opNDtwTVVGOHd8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744390; c=relaxed/simple;
	bh=nQcj10zejJVH/tr1l0+eer09KlIPCTau/PJeVg7QFzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1bsfA7/OZwTQaR8FAobgoYZP/XTKvTBAYYVUodNzgQ2+Pnt/+nxAR9pz2RQb+XATRoxv5gdI3DuxfLq9yyqnj95KUK4G51ym9iBOIzGYfLiLEo3xJH3FW/JuYPvq11k8JvGjBS9HiraplhYEvcxXTmKLa2lvPRLvdWanp0HuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9bkBcQ8; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-336b071e806so28741781fa.1;
        Mon, 01 Sep 2025 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756744387; x=1757349187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XMjqWfHnxx+2cq14q67XEqDooplTsFFIcuwaJm5RkY=;
        b=d9bkBcQ81uMw2Xk4mUOINv+x9gw66aLCjjelsaoJ+P/mNNCZc0uvMTnt1siT2qFsjy
         QVW4kXiaIe1Jluw0hpLTWTeMSbX09AncFlHmPIxo9se1/xZyUkfrvuC6NuSIEI8fk7jE
         8BgDieQKNEyRtm1bf3EPM8kqBpozTOCXJmnI91G3HlT1IbZXatBeTr5zauveMn1Mj7mS
         IWrw+DJFZWjtNgGNF7eU7vwaGjzvefkd69YA1+2LvgY1ZgkxhDrnAJKjZZ07YEx77zYE
         ssyY0JEvi/52xzxt3tPpIImyuca5AFY2BTrXmlkGahHam6YOEpUpqFA0tdx5ofDFQdEt
         szgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756744387; x=1757349187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XMjqWfHnxx+2cq14q67XEqDooplTsFFIcuwaJm5RkY=;
        b=uABdD1v+JC3iHF9/xbgc8JtQs5DO4KwXMSSOouBvjfohfpOV2aD6yRQvz/pwuJ/4aA
         v2a2XJ5yuWd5inSSupOZ4uewzEAxRQnDfb/vqYEU2nbDvERyU/LCbpxvMejnnysQ+qEM
         KYpo900O+C1s6TwEWiT/Ltv3dhkLN2yOLjCNj+Pn81Iqtxt6RDOv27FAXJMkamUr0ZrD
         YOqskoIHDmpU/huHe8H+jJ6HtV4agwWD2bW0y5JIAf0heHCPmxzTrWZJoL3tHVN/J/j/
         0s/wvGiYVYcvdFfSI+nzHgvnrjaQBlYitGDu4L8ymUgKmWjj0XafVT+CgHjsDZzvekAG
         Fppw==
X-Forwarded-Encrypted: i=1; AJvYcCVFyFhu9vcK1oOnPAGt+hSs08CfQkk1WeF3vp36QaShSWAFdsOKMenN+/P7FEYxDzwoh5ahR+h1ew==@vger.kernel.org, AJvYcCXbf02jjF/EeSsuseIThkbLJU+7NroP0vS3JegQcTKdIJyHQ0X+BxRlRxKUl4ZQFcgRfXksSM686S87CO6a@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6FjHgAow4VJ/WJnFm5G4WsCuWDyOdKnKZ9h5t7pcK/NXAgUz
	rV0E9BEYBmRPACAR2KEc6U+Z+Bn2wS0PmyNlepVHwX1K0sXu4c+OX94v
X-Gm-Gg: ASbGncvN1jqDepgNoCn4I1EZzpPGMNJb1j9gLDEkjhLGC+ND2OEZqbDA0WKEDwqq0bJ
	o5ti8PmLLFu2pPrgSxUTsTBRfYr6aS/rOgb4wlx/mD+6psOt7AASX/S2gI4QvpIfd13OIqaJN9a
	xSLnPD67kVhVMcYyCDil8xmx5oFqqzqsx25CORmeX1YhYp2YSEUSM+gBC+LF1XY0dfnUdeK9AwO
	0bqLOx07B5oS75tBZd+DeTsJY1UqlWd55cvkC+V+GdFOmyRdEqTXFF1q2FurWmBNcecq/B+AN4P
	OjV15kd5fs86DQfnHu/JXVnwnXe05JfUB+AiM398NlZvPI5L7/7eNaaRpvRjQEtylXiOE6jDa7w
	BIWc31aRzBtRETEwjpSagwVbYRsqrI2LocdMrEYQHhw==
X-Google-Smtp-Source: AGHT+IEVw8ibn5NsZeWB9fEuXwUWCNSL2Z/Kfo1KnKeiipMhJM1r3ia8OLUYuo+3dtfeyeQofbBxIw==
X-Received: by 2002:a2e:b8ca:0:b0:336:cee0:d477 with SMTP id 38308e7fff4ca-336cee0d925mr23787551fa.27.1756744386636;
        Mon, 01 Sep 2025 09:33:06 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([88.201.206.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336d0e78e82sm15291861fa.53.2025.09.01.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:33:06 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Artem Shimko <artyom.shimko@gmail.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firmware: arm_scmi: fix alignment in protocol_id_show and debugfs calls
Date: Mon,  1 Sep 2025 19:33:00 +0300
Message-ID: <20250901163304.2504493-2-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901163304.2504493-1-artyom.shimko@gmail.com>
References: <y>
 <20250901163304.2504493-1-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes minor alignment/indentation issues in the SCMI driver:
Adjusts indentation in protocol_id_show function to maintain consistency
Fixes alignment in debugfs_create_file_aux_num calls in raw_mode.c

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 drivers/firmware/arm_scmi/bus.c      | 2 +-
 drivers/firmware/arm_scmi/raw_mode.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 24e59ddf85e7..e1e82139997c 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -298,7 +298,7 @@ static ssize_t modalias_show(struct device *dev,
 static DEVICE_ATTR_RO(modalias);
 
 static ssize_t protocol_id_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	struct scmi_device *scmi_dev = to_scmi_dev(dev);
 
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 73db5492ab44..244453d3e7aa 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -1280,12 +1280,12 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			chd = debugfs_create_dir(cdir, top_chans);
 
 			debugfs_create_file_aux_num("message", 0600, chd,
-					    raw, channels[i],
-					    &scmi_dbg_raw_mode_message_fops);
+						    raw, channels[i],
+						    &scmi_dbg_raw_mode_message_fops);
 
 			debugfs_create_file_aux_num("message_async", 0600, chd,
-					    raw, channels[i],
-					    &scmi_dbg_raw_mode_message_async_fops);
+						    raw, channels[i],
+						    &scmi_dbg_raw_mode_message_async_fops);
 
 			debugfs_create_file_aux_num("message_poll", 0600, chd,
 						    raw, channels[i],
-- 
2.43.0


