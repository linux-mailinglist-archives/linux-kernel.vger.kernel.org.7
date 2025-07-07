Return-Path: <linux-kernel+bounces-720380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FCAFBAD3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4211174F4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B18274B25;
	Mon,  7 Jul 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jj5yW9X2"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC55271446
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913249; cv=none; b=RwLLXxrViNG7G8n+/O7cqQ07yK/PuCGDM4EzJgCcsg8VFwgYEtysN8UmA8y63RwC7m6BeW9cBLX5jG1YjdS1M6zUcm4mdx53n4Cny17YMtOK/nKsbCcP31GY6mHbt4RVZckPo+/W67O87lydSQsrxcO247GOQawxtcnZk3TLn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913249; c=relaxed/simple;
	bh=cMCc/YVoj/o1iMMtqAwdWEEQxRV6brtdDuFTq1NJi20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6ZdcFhSzV7/UuoMeYAvrbp6m2F75ek5DIPNW3woFmg/rMqqYxdjeZK0n/hQ51ztFj2UZo8IHyJdVMg1wcaGsprNbmWfcXkmoE9+34dxpeGuGid3k89zeznYqabih07MXonlbTr1lEQBtFWMKERXU7eDWV8dd7M8AqucY/NIgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jj5yW9X2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55622414cf4so3345872e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751913244; x=1752518044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6hGfoFapvas+Hz1L3ZuhmMpf2VFQ5l8hbCjstkgFL4=;
        b=jj5yW9X2Xmo4AKbKKzyfApVQngaZ2Q5Ksq2EA1HeYP2pXagqk2VPu52IRuiZWkis9E
         WNf5oTuWUh7sFjgK5egtd8RaF+kcDlGOiRH0yMv8ogHsGqahZz2yOeAcWoXKCnImPsDx
         pMmupqtdmQADK+dcfSDBTrnrS9j8WPCX5mHCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913244; x=1752518044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6hGfoFapvas+Hz1L3ZuhmMpf2VFQ5l8hbCjstkgFL4=;
        b=pZ4rdw1YO3CuDoxLnUdmWxOIVoKpsPOtL025PjtMwBgmxWR7mrfQTdnIFvdoHrXUlF
         +Rhp3bzJJRLLYpUz9FYQfNBYXBJuBCsl5bPE9JvGx7vyhOTFgvJev/ux+rIZMgBc5Axh
         Ahe0/NGGvSENk7FSbTsl4fZzx5/MoVbedObll6BsNE5ZLUXkcpisS3JMsY9R1XYX8xpI
         DNN36EoJMV20XAJhDL3DDTrUY3bL7bSQPH4qURRIHSt7I2nN1gTtx/NTEvIpukSZBeJ4
         aDa6mMDGWS2ORU+8EuAK4Gv4ar2ZXIISY6BKsIHVybCJ3B36HL4lGChQ9fStGz4EM0WB
         cdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKn7iszWioJMfoEH5lbCKOC4yhjN93pi96qgWXkxfLlF3bDq8WnWzUv0XkcRFayrr7+fJZeKWsd7hiT8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbAtxhzMD/KLbPQvPBlQT8ptoodkX32LhHZCnZpgEfLeEfA3S
	gjMpNwtViPbUrddiJN/lhm4+64ht7EvI/VOs8jsKJnsNg2QyjQkY8y/wVD0hKwadig==
X-Gm-Gg: ASbGncunWO2y7oecUaReGicCzjbK9eQxEDBoHSh6vym5oPshWCOjDGWYW5XjKqQ6zRC
	rp9xSkvHDp+ab/pn/Ranr6dtJQCunMWE+scbRr7AJhhcQf0A5PDU+aoRsSh2eXA0RN3smOKI0oQ
	88nKZy0EoE5SgVW8Ud6GYPDrqgZF0vF+byRK67DbC+FGqegRXUQewuR6ADkShU4S54xjiY3xoKD
	mw10XTfUu7vK5e39OPULLD27X4Xww5CDWqF/vCjPn6oYLny8XjmaZCyRshafCC6QCi2aJRGLq0L
	oqQ5qIuekxcN5icszOFxxnC88i87yExi6pgne+g8nAuAPHYeeBwAFXxs8TwI+zsRVOtaD692S0i
	17a7xIKXq5lPL2jA5Id45Z1CaOaVOnaRJBmOYFY8aQpzk/AdjxrQt
X-Google-Smtp-Source: AGHT+IGXpDV/f3jM6ZfbvudPD8pxigPxC7oBSeMClnkzX//m6nh6RDqJosKm/5PF2RkWF3O2NZiKmw==
X-Received: by 2002:a05:6512:10cb:b0:553:35ca:592a with SMTP id 2adb3069b0e04-557e55ce64cmr2739571e87.52.1751913244440;
        Mon, 07 Jul 2025 11:34:04 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d31a6sm1417630e87.61.2025.07.07.11.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:34:04 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 07 Jul 2025 18:34:04 +0000
Subject: [PATCH v8 4/5] media: uvcvideo: Introduce
 V4L2_META_FMT_UVC_MSXU_1_5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-uvc-meta-v8-4-ed17f8b1218b@chromium.org>
References: <20250707-uvc-meta-v8-0-ed17f8b1218b@chromium.org>
In-Reply-To: <20250707-uvc-meta-v8-0-ed17f8b1218b@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hansg@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The UVC driver provides two metadata types V4L2_META_FMT_UVC, and
V4L2_META_FMT_D4XX. The only difference between the two of them is that
V4L2_META_FMT_UVC only copies PTS, SCR, size and flags, and
V4L2_META_FMT_D4XX copies the whole metadata section.

Now we only enable V4L2_META_FMT_D4XX for the Intel D4xx family of
devices, but it is useful to have the whole metadata payload for any
device where vendors include other metadata, such as the one described by
Microsoft:
https://learn.microsoft.com/en-us/windows-hardware/drivers/stream/mf-capture-metadata

This patch introduces a new format V4L2_META_FMT_UVC_MSXU_1_5, that is
identical to V4L2_META_FMT_D4XX.

Let the user enable this format with a quirk for now. This way they can
test if their devices provide useful metadata without rebuilding the
kernel. They can later contribute patches to auto-quirk their devices.
We will also work in methods to auto-detect devices compatible with this
new metadata format.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 .../userspace-api/media/v4l/meta-formats.rst       |  1 +
 .../media/v4l/metafmt-uvc-msxu-1-5.rst             | 23 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 drivers/media/usb/uvc/uvc_metadata.c               |  4 ++++
 drivers/media/usb/uvc/uvcvideo.h                   |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
 include/uapi/linux/videodev2.h                     |  1 +
 7 files changed, 32 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index bb6876cfc271e1a0543eee4209d6251e1a6a73cc..0de80328c36bf148051a19abe9e5241234ddfe5c 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -20,6 +20,7 @@ These formats are used for the :ref:`metadata` interface only.
     metafmt-pisp-fe
     metafmt-rkisp1
     metafmt-uvc
+    metafmt-uvc-msxu-1-5
     metafmt-vivid
     metafmt-vsp1-hgo
     metafmt-vsp1-hgt
diff --git a/Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst b/Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
new file mode 100644
index 0000000000000000000000000000000000000000..dd1c3076df243d770a13e7f6d07c3296a269e16a
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+
+.. _v4l2-meta-fmt-uvc-msxu-1-5:
+
+***********************************
+V4L2_META_FMT_UVC_MSXU_1_5 ('UVCM')
+***********************************
+
+Microsoft(R)'s UVC Payload Metadata.
+
+
+Description
+===========
+
+V4L2_META_FMT_UVC_MSXU_1_5 buffers follow the metadata buffer layout of
+V4L2_META_FMT_UVC with the only difference that it includes all the UVC
+metadata in the `buffer[]` field, not just the first 2-12 bytes.
+
+The metadata format follows the specification from Microsoft(R) [1].
+
+.. _1:
+
+[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/stream/uvc-extensions-1-5
diff --git a/MAINTAINERS b/MAINTAINERS
index 658543062bba3b7e600699d7271ffc89250ba7e5..fdde1d37ed2ef9058e3ea3417bec25afe454dfc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25827,6 +25827,7 @@ S:	Maintained
 W:	http://www.ideasonboard.org/uvc/
 T:	git git://linuxtv.org/media.git
 F:	Documentation/userspace-api/media/drivers/uvcvideo.rst
+F:	Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
 F:	Documentation/userspace-api/media/v4l/metafmt-uvc.rst
 F:	drivers/media/common/uvc.c
 F:	drivers/media/usb/uvc/
diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
index 4bcbc22f47e67c52baf6e133f240131ff3d32a03..77e03273d3cf6b00cac6ebb9b29b941f1cbfd9f7 100644
--- a/drivers/media/usb/uvc/uvc_metadata.c
+++ b/drivers/media/usb/uvc/uvc_metadata.c
@@ -195,6 +195,10 @@ void uvc_meta_init(struct uvc_device *dev)
 	    !WARN_ON(dev->info->meta_format == V4L2_META_FMT_UVC))
 		dev->meta_formats[i++] = dev->info->meta_format;
 
+	if (dev->quirks & UVC_QUIRK_MSXU_META &&
+	    !WARN_ON(dev->info->meta_format == V4L2_META_FMT_UVC_MSXU_1_5))
+		dev->meta_formats[i++] = V4L2_META_FMT_UVC_MSXU_1_5;
+
 	 /* IMPORTANT: for new meta-formats update UVC_MAX_META_DATA_FORMATS. */
 	dev->meta_formats[i++] = 0;
 }
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index b3c094c6591e7a71fc00e1096bcf493a83f330ad..616adc417c62a58686beccbc440a5dfac0a2d588 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -77,6 +77,7 @@
 #define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
 #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
 #define UVC_QUIRK_MJPEG_NO_EOF		0x00020000
+#define UVC_QUIRK_MSXU_META		0x00040000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index be94a79b976e3de4eb957f5d2584ec6d4230469e..993b36417b4655456ce545cb42a41b55b98e4d6c 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1463,6 +1463,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_VSP1_HGO:	descr = "R-Car VSP1 1-D Histogram"; break;
 	case V4L2_META_FMT_VSP1_HGT:	descr = "R-Car VSP1 2-D Histogram"; break;
 	case V4L2_META_FMT_UVC:		descr = "UVC Payload Header Metadata"; break;
+	case V4L2_META_FMT_UVC_MSXU_1_5:	descr = "UVC MSXU Metadata"; break;
 	case V4L2_META_FMT_D4XX:	descr = "Intel D4xx UVC Metadata"; break;
 	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
 	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 6f7bd38dd5aa4b1b2084685512512a380d76a5e4..863bc5b7dec32303e852d7e9c3891011ce5a3d71 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -867,6 +867,7 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_VSP1_HGT    v4l2_fourcc('V', 'S', 'P', 'T') /* R-Car VSP1 2-D Histogram */
 #define V4L2_META_FMT_UVC         v4l2_fourcc('U', 'V', 'C', 'H') /* UVC Payload Header metadata */
 #define V4L2_META_FMT_D4XX        v4l2_fourcc('D', '4', 'X', 'X') /* D4XX Payload Header metadata */
+#define V4L2_META_FMT_UVC_MSXU_1_5  v4l2_fourcc('U', 'V', 'C', 'M') /* UVC MSXU metadata */
 #define V4L2_META_FMT_VIVID	  v4l2_fourcc('V', 'I', 'V', 'D') /* Vivid Metadata */
 
 /* Vendor specific - used for RK_ISP1 camera sub-system */

-- 
2.50.0.727.gbf7dc18ff4-goog


