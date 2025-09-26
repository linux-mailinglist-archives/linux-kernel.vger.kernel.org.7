Return-Path: <linux-kernel+bounces-834078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC9BA3CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954E8622975
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D62FB995;
	Fri, 26 Sep 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W3fnMtY7"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE62F616B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892296; cv=none; b=qqHVVcyyQk8TjpFHzxBG14JLtxhb3L5tXN6EFPDg1q5JPy6+JbwjXbhp2vsMUCcrYrbeqYaI4lLHE3Dge9g7AqOILkcaxdIYO2oy8voMUEBLGd84fhsix/bsBQy9xqkVk276M36hX+Sph1WWxfuKL7sQbJUuqDiOR0nCzSUDGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892296; c=relaxed/simple;
	bh=HOaXKeMMBeof7Hx+tzoNDTO3vGlaHvg7CjV+p573b/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwI3//DT07wTtKTZpf9zi3TdjEh94vbmUX9FlPSEBLmPapttFpjHlgGs4sqHX9TQtljQUgWs+S8OGlPCiriGDRSTSnxyaLPhkRbRGdT1eN1SDuhYbzH1nOjeGbLpslX0t9guk9wO0OjL0dMl02PKLa55nmPd/ZYfuJkQxBwseuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W3fnMtY7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso2744406e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892291; x=1759497091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zavqbvAJpl+vVyZ8ZvtBFYz19hBaBOc/P6wczkVBqDY=;
        b=W3fnMtY7RjqTLLDo7fzH9PJwwFjlLgWOiWVpSz3GM1AcM9VAqRpDxKfOEdmKVo4S2I
         XBdaLHBPk4EAGufl1mBMbGd292pNFTULimhrWJkJMQQgXTCgMozzhgjL+Qz66suCxhmd
         lahvQdfpNYueP2CVJHkP2abV3KmqPkBb2i+VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892291; x=1759497091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zavqbvAJpl+vVyZ8ZvtBFYz19hBaBOc/P6wczkVBqDY=;
        b=X4DEG6Q80XO3Ig+kLPtAYo49KfY1clrpGZBFWppW30udHH5IdOa9zhsoK5am+ZNVTv
         hLzPiLP1IcNzzd2zgX150Hj9wrAluKJ4Arxm0DBkLV1P02ayPNXPYAkjjTOgFp1ODcwf
         BszxhXXYluaX1Ayxuym+wiGUpwVdhztBKb4Qh3/TqAF9jS2eoHZIMUQurPGppoV9W3ZZ
         JcpUUyTmv33Kqu8emU7DjwR1mV0k7yFpUAUOQOhrSIbSHgBAPDpGNLQEDnvGOVtncEY2
         APiQgjuJbHgWZLZjiRut66B0p2KDiUBeXKxRfA+wHd1VY/x9K8LGY2ZKodcW73j1wiCE
         idxg==
X-Forwarded-Encrypted: i=1; AJvYcCUwZraed29tL4MdrXWb/awV09fzysPVSa+v7sYkh7zgC/dJWbabCb5MAlHIi4Fy+m0ZyhUC3+ASiEDIynA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25o+v0nRrYXLtoyi7KFHvDj+55/6Eg6QYDU09awxTA2ycT+jb
	vn/bIDo3nWl2EUjkHMV3RItKkmr+EcATgXTYkdeFuvzLcO3t2fyJGHOfxksIXG3wxg==
X-Gm-Gg: ASbGncszA8ZkJzORVQ6TYKeOhdzEf8XsaZsPGG4DJx1DjVQMFnlTpTDjzZWJzrII7W0
	2/3LuxL9UQVh8gVHsGYMW5r9mmBP1MLVEUQ/glXJY1TWiweOeeNQEhEIGPMXvXFbJqX1umIPzFa
	u2AnqjAANEJHEl8PYn3busZVXpystBPg+4uN/qC3eZZ0QY2Njq/0RPrm9cQHU3NXJmm/aWChWIY
	olNxbjgkVUeOtBxdqvnaTwfkFODwcD+muEdLCQ46u8fWgQO/aq9CnmPIIFv0ojmCseR0oI+TRCu
	j01HxUuBhhd1vv4xwaB63wtbp9iGCfCBvEIJa8EfFlRBXB2rmwq7Ab3ZtVnhH1JpucSzaTcWSLZ
	DkC9tMPfr0i8gXdK+lWamzzRjlFG8qqZxxJ0dlit90gIlrwhiBnGQJt8Gn4A//LWSKCMtqPTUry
	VyraLRlGZyqjHk
X-Google-Smtp-Source: AGHT+IGYNymib7YkYpDINQtE5FTKayVP9W8HaNUBBncx14Dot8LXrbwZoz7D11yG6qpiPKpfo0xmbQ==
X-Received: by 2002:a05:6512:b27:b0:55f:435e:36bd with SMTP id 2adb3069b0e04-582cd97cc3dmr2187251e87.0.1758892290687;
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:26 +0000
Subject: [PATCH v3 02/12] media: uvcvideo: Set a function for
 UVC_EXT_GPIO_UNIT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-2-6dc2fa5b4220@chromium.org>
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
In-Reply-To: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
To: Hans de Goede <hansg@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

All media entities need a proper function. Otherwise a warning is shown
in dmesg:
uvcvideo 1-1:1.0: Entity type for entity GPIO was not initialized!

Please note that changes in virtual entities will not be considered a
uAPI change.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 3823ac9c8045b3ad8530372fd38983aaafbd775d..ee1007add243036f68b7014ca621813e461fa73d 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -85,6 +85,7 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 			break;
 		case UVC_VC_PROCESSING_UNIT:
 		case UVC_VC_EXTENSION_UNIT:
+		case UVC_EXT_GPIO_UNIT:
 			/* For lack of a better option. */
 			function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
 			break;
@@ -105,7 +106,6 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_OTT_DISPLAY:
 		case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
 		case UVC_EXTERNAL_VENDOR_SPECIFIC:
-		case UVC_EXT_GPIO_UNIT:
 		default:
 			function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
 			break;

-- 
2.51.0.536.g15c5d4f767-goog


