Return-Path: <linux-kernel+bounces-874436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E986AC16572
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95F205048E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457034DB4F;
	Tue, 28 Oct 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ks/uO4jD"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7934D93B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674116; cv=none; b=AR26qh2xCctWICuDlK7SJMW7E+r6k0NkSPoYYMAKTz658L+UdhiT+jhLrv7dbB+D4vwxex43e4KDcOI+BvF+aqCGyfv+pRS/ZSL2DnIZ4hXjVjQCFCqVkMaBXdim7x7GzlHRQIjRkVNfpVeykc6YmwkdopZNGhBTGA77+hdxN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674116; c=relaxed/simple;
	bh=iStP52tSTRqDHZ2s/0JKhVbhHFkl0Dz3qnu03/driQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rzDQ3QEQ15mWNibz5gG9ZD6XOsQGqiAa3vcycO4XpCj0nAjpunKaClxIKIjFSBywPpw/49KlHZMucsWYNRmcIUc9woypC7XMSnv7S+7gesS8YP+0NcLPM9UWPOR2OydSpevf4kVX6f58zj2kCN5/V3U8OzC3lRBEZnjtgVwv9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ks/uO4jD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-592f5736693so6618644e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761674111; x=1762278911; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrs+/SZt/Dp84KkQFuAowfk7ciIjCYoKYgFhbI0eCxo=;
        b=Ks/uO4jDUE+R5flB+IeJSU1S2jahqmB7+vQGIFTMq/ZBTqJBFbINUBFWt+xFamwVsg
         +j00QQ/pF+/U5hbHEhk4Cie1KiAsNRv5c8s1V0Gdwms2cx1bE7+IPCwZEZwOw34I8KA8
         NNl7gosuHl/m1nQNkY8ddo3QjrPUJ92iavcRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674111; x=1762278911;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrs+/SZt/Dp84KkQFuAowfk7ciIjCYoKYgFhbI0eCxo=;
        b=Z/iAUqO2eNFiiuL5OVtFW50eUUuozHaFUmpN5MKr9u8J29p1t5xDco7ab9BE+Eqsed
         D9Evb0ek6XSyUWNL9K9Uo45Ly6nfaUI+2y0gUi5/pHXc6x5izH3HfRQfwSDzNyGusHNu
         Mh4fI6fXFaDAmtg5QFmDVF9cvZlFX5VC3t9BHG0dbWFh0M9/5GMKsmGNuGFDeZYZ02E+
         2swcGDBRHUKvvfAWNp2eSvXM/SK7nTEioRrumWHHfNE0BBfzDmVK4edz2mnGhCwzylqD
         NkIj6cYHb9omso3Mxf0rK8BYyboUTjkkM3iNM/y39haM/ZSjeV/J56dcxS/ZyKicAg+/
         ztfg==
X-Forwarded-Encrypted: i=1; AJvYcCUGhaPNF3haS/ZpNDkJ1DETuzgTBChuU2SqnoMIC++sx9/FAI2wA0aOts2JpXyAt8wsHgow8cHcQaTBWbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqA7OSzrJG1ukf+GBizq84N/abTUMme04MA5vk/5cCcoYXvIP
	bZpM5RFIk7eLmGzHvV7rb220cdu34+rQ87QtrDgIiA+OOhpweaBomFKOp6plnIH6Vg==
X-Gm-Gg: ASbGnctuXAwByuzp6qZAzkkQ8MCK1/Vyq+P7ISdPkjjrMHgeQYCEjA8LSC8W0+eDF6X
	8SM2MuG+PbZNPsg+0BXuNWcS+jv26sHBCh/LX5IcbMoFUwGzcVh2jKlCFeu6a7PSpEuf6R7KI4F
	/tBvzUiBmZOc1vl16uI4bjUaJoqvaw1DF1OXhq/38jIHMwWywp66RrLq62jufCViesfKxIS4hEz
	L8VCNpgR+reMXwmEKC9/PNrJbCww0mBEEI478Hq3/x1PpewyjDt8Rj/ZS5Nz8uPhDxnRNVCRZkM
	Kcj047PcpnUJdN8frFMc5x7XT1RcUhA7IVP6ix/bBtoDxWD0AYKPIX5taSg3Qo5qNTn4LZJ1nIS
	HLyOSJjXPjTg3JawiH2HHZt1TOwJn2AFRwPHcjT+H82Nzch2GG1D628Bi/GbqTEMqdRqH2Pr5vD
	MS+Z4raJIlihrsblJb0Vz5TgTd7WXBqVPGY4VydEoVaHwIOcp0YfHM31Ol3vSKbpCzIw==
X-Google-Smtp-Source: AGHT+IFqGiYrkyFkibQDWmSYZpAF6eBWO6jYvlesQVDAePpNLhM3UWiTVV5GZ9/v+cj6r6VcAsgK+w==
X-Received: by 2002:a05:6512:4012:b0:592:f935:cd8d with SMTP id 2adb3069b0e04-59412868c4bmr83783e87.15.1761674111422;
        Tue, 28 Oct 2025 10:55:11 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f7444bsm3239773e87.85.2025.10.28.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:55:11 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 28 Oct 2025 17:55:10 +0000
Subject: [PATCH] media: uvcvideo: Fix support for
 V4L2_CTRL_FLAG_HAS_WHICH_MIN_MAX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-uvc-fix-which-v1-1-a7e6b82672a3@chromium.org>
X-B4-Tracking: v=1; b=H4sIAH0DAWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3dKyZN20zArd8ozM5AzdZOOkRMO0JDOL1BRTJaCegqJUoCTYvOj
 Y2loAMUR4ul8AAAA=
X-Change-ID: 20251028-uvc-fix-which-c3ba1fb68ed5
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Yunke Cao <yunkec@google.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The VIDIOC_G_EXT_CTRLS with which V4L2_CTRL_WHICH_(MIN|MAX)_VAL can only
work for controls that have previously announced support for it.

This patch fixes the following v4l2-compliance error:

  info: checking extended control 'User Controls' (0x00980001)
  fail: v4l2-test-controls.cpp(980): ret != EINVAL (got 13)
        test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL

Fixes: 39d2c891c96e ("media: uvcvideo: support V4L2_CTRL_WHICH_MIN/MAX_VAL")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 11 +++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  9 ++++++---
 drivers/media/usb/uvc/uvcvideo.h |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 2905505c240c060e5034ea12d33b59d5702f2e1f..2f7d5cdd18e072a47fb5906da0f847dd449911b4 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1432,7 +1432,7 @@ static bool uvc_ctrl_is_readable(u32 which, struct uvc_control *ctrl,
  * auto_exposure=1, exposure_time_absolute=251.
  */
 int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
-			   const struct v4l2_ext_controls *ctrls,
+			   const struct v4l2_ext_controls *ctrls, u32 which,
 			   unsigned long ioctl)
 {
 	struct uvc_control_mapping *master_map = NULL;
@@ -1442,14 +1442,21 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 	s32 val;
 	int ret;
 	int i;
+	bool is_which_min_max = (ioctl == VIDIOC_G_EXT_CTRLS &&
+				 (which == V4L2_CTRL_WHICH_MIN_VAL ||
+				  which == V4L2_CTRL_WHICH_MAX_VAL));
 
 	if (__uvc_query_v4l2_class(chain, v4l2_id, 0) >= 0)
-		return -EACCES;
+		return is_which_min_max ? -EINVAL : -EACCES;
 
 	ctrl = uvc_find_control(chain, v4l2_id, &mapping);
 	if (!ctrl)
 		return -EINVAL;
 
+	if ((!(ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) ||
+	     !(ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)) && is_which_min_max)
+		return -EINVAL;
+
 	if (ioctl == VIDIOC_G_EXT_CTRLS)
 		return uvc_ctrl_is_readable(ctrls->which, ctrl, mapping);
 
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 9e4a251eca88085a1b4e0e854370015855be92ee..d5274dc94da3c60f1f4566b307dd445f30c4f45f 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -765,6 +765,7 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *priv,
 
 static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
 				 struct v4l2_ext_controls *ctrls,
+				 u32 which,
 				 unsigned long ioctl)
 {
 	struct v4l2_ext_control *ctrl = ctrls->controls;
@@ -772,7 +773,8 @@ static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
 	int ret = 0;
 
 	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
-		ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls, ioctl);
+		ret = uvc_ctrl_is_accessible(chain, ctrl->id, ctrls, which,
+					     ioctl);
 		if (ret)
 			break;
 	}
@@ -806,7 +808,7 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *priv,
 		which = V4L2_CTRL_WHICH_CUR_VAL;
 	}
 
-	ret = uvc_ctrl_check_access(chain, ctrls, VIDIOC_G_EXT_CTRLS);
+	ret = uvc_ctrl_check_access(chain, ctrls, which, VIDIOC_G_EXT_CTRLS);
 	if (ret < 0)
 		return ret;
 
@@ -840,7 +842,8 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 	if (!ctrls->count)
 		return 0;
 
-	ret = uvc_ctrl_check_access(chain, ctrls, ioctl);
+	ret = uvc_ctrl_check_access(chain, ctrls, V4L2_CTRL_WHICH_CUR_VAL,
+				    ioctl);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index ed7bad31f75ca474c1037d666d5310c78dd764df..d583425893a5f716185153a07aae9bfe20182964 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -786,7 +786,7 @@ int uvc_ctrl_get(struct uvc_video_chain *chain, u32 which,
 		 struct v4l2_ext_control *xctrl);
 int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
 int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
-			   const struct v4l2_ext_controls *ctrls,
+			   const struct v4l2_ext_controls *ctrls, u32 which,
 			   unsigned long ioctl);
 
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,

---
base-commit: c218ce4f98eccf5a40de64c559c52d61e9cc78ee
change-id: 20251028-uvc-fix-which-c3ba1fb68ed5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


