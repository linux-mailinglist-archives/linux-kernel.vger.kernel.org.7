Return-Path: <linux-kernel+bounces-854403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B064BDE495
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B029D502299
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E3D3218A2;
	Wed, 15 Oct 2025 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2kd3iyc"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541731E0F9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528209; cv=none; b=CuDWhBDb+932kNkHELZ5s97UN4IdNad431+I7WsbV7sv+X6KGknUMgHlWoze6rR0ETet5cwgtIaYTmhZJtxlkOg8tH0p14fqElzyZCzHTRtRA6x/T6gyNBlsJC27QU2ByWs+WHBN7DwMiz7bWOGoErcverLZj+ItJRm4ufKu8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528209; c=relaxed/simple;
	bh=7PJk3qgEheGDAcZBLr842eZ4flaL7Aa2z8+o+HCwQvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=j2dqJ/KeWKmy1x4LEKwlLIb/V3r3RjYmtLs7qcEasAX6MsKYQOEIsgVzxMeR/PbSDnc5nSei+KRYNpflBzze0prIIsgN6zxYQTm/nVuc0wlwB7PNdo98qCnFg1I6bt4PlHqQDs1xBrU9mEMKciKkeCd/3s5qHaNd9TZNFnRSYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2kd3iyc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b40f11a1027so1161713866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760528206; x=1761133006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh700VwdwPN4K+gi98dGBUeQEE6YuZ3VBhMh8LN0aQ0=;
        b=U2kd3iyc2eDwKvlR+FaLOZZ3ZMyQW2qDa4fNK+wayC4mhSA8H4WBTIDGyO/lyjdNCO
         8XlMYtKXaA5VtDN+AI47RtP+bdveRTXRDsXqw2VP+nrl/0NqntXg4892CJYmjEdjI+u3
         NbNUNvjL/cVHjJEo2/Gz/PkS606+XKCu7fTfU3ViLVguWAYDl9kUQdlGdKZYS9LehAde
         XIlNFMcMz4V9iG7Zf7QtmMd3lMsgkOYZncSBZJBw7vwTHCjO+TnEbb2efQnTior9+JT9
         jxH79iS+OHCouSW4/m3S1suQ1chXGcNeIfHSw4MNfWS5LVGZor2ANzJ0LOE3I6Zgsxs4
         mpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760528206; x=1761133006;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh700VwdwPN4K+gi98dGBUeQEE6YuZ3VBhMh8LN0aQ0=;
        b=mieSJlRah4g7OB3YCAdFoWTy5iTL/f6eY8/C/WDF8Bde5U1zyt8RjULfrVR4EO36Fk
         0sPwwbhu+ZFyafRynBodfC09QqJv1XUPrtd1urCzP1oahftuqVBydKiMQJGg2eEoO3Uw
         3wP6DG8f4Ccc1MtrK9F6xqJX942GVtTvrPB4MZ09SzurLWMsOPc33IC1rOA0lVanv9cv
         izQOzd7TDZJ6lOrX4gum81bbz0/4+nSMVKB20LhdWp5esg0lFJwR3XiOFaCWVMSBgOS0
         JXMHVARNlyRrwoN97G5G1tZ3dHHmSnqjB+LuhCpL+ODL9XwV5XsrpFeD7fdfvc70VDRl
         ldoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgVUruThS/kTN6xgrXTKMXzMyVJK0JU/dS4/58CaQfcOoD1rTRO5gwyOXsV7oE/bvQcHbjUrz7fnC8rsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcEF8V0CChxUb9300VOzwoSkCAA1WgW8W6DhIoDck78qd9tZp
	M/V0dEUUPWnVfye1rVDm6NCVgUifIYhwRW1z3kh/edoCi7DpURMpyOg/
X-Gm-Gg: ASbGncuFLMdQBCqjsBGjNMQAPnhWS3VmtGfHCbdZPkuq89ffWNoRKi3thvTKT6Eddjt
	3AI0jmI8gkDsnoKj5hH5ctcLQ5UncRNFMIskQG8sQb9RE/D1Ll69B8fP2VCGIU7ew2UHcA2THal
	vb5n4EkxvgoF/b3JQY3MCwJiJXMeM8OwoW8AnCqLem7sgjvXSjkbEHBHC2vtMQwQl9hXQqJX5vS
	cdaSIGkpe02waidop03n+EcUa4PnEmuf6AQRnWoCjS41yAHA9gHC4QARg5dMCGlxUWmEP4gfPre
	qVpby01MAsHAXG68LCHT1CX5dcIvreYaYDZPfKRQcdhkAyDye0ZkJn+B3XYygiQ0fcJf4Pu/Fhq
	e5YgfOg2t33szGUqbFLkhHslYyt9HUj+cwnBTkqU6Dq2ZiBYQp+obzct1acnLHt95gfeI
X-Google-Smtp-Source: AGHT+IFHt8uRAhWI+Au2Y460jm83uLYaE/5mx0j78JmcnSSI8oN8k2YJhrw+OlLiYTtYhg8/Z8Y8SQ==
X-Received: by 2002:a17:907:1c97:b0:b3d:9c3c:9ab6 with SMTP id a640c23a62f3a-b50aae92af7mr3341572766b.29.1760528205738;
        Wed, 15 Oct 2025 04:36:45 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba171929sm205081766b.33.2025.10.15.04.36.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Oct 2025 04:36:45 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:36:42 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede
 <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>, Ricardo Ribalda
 <ribalda@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] media: uvcvideo: Return queued buffers on start_streaming()
 failure
Message-ID: <20251015133642.3dede646.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Return buffers if streaming fails to start due to uvc_pm_get() error.

This bug may be responsible for a warning I got running

    while :; do yavta -c3 /dev/video0; done

on an xHCI controller which failed under this workload.
I had no luck reproducing this warning again to confirm.

xhci_hcd 0000:09:00.0: HC died; cleaning up
usb 13-2: USB disconnect, device number 2
WARNING: CPU: 2 PID: 29386 at drivers/media/common/videobuf2/videobuf2-core.c:1803 vb2_start_streaming+0xac/0x120

Fixes: 7dd56c47784a ("media: uvcvideo: Remove stream->is_streaming field")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/media/usb/uvc/uvc_queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 790184c9843d..f49c538618bc 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -177,7 +177,7 @@ static int uvc_start_streaming_video(struct vb2_queue *vq, unsigned int count)
 
 	ret = uvc_pm_get(stream->dev);
 	if (ret)
-		return ret;
+		goto return_buffers;
 
 	queue->buf_used = 0;
 
@@ -187,6 +187,7 @@ static int uvc_start_streaming_video(struct vb2_queue *vq, unsigned int count)
 
 	uvc_pm_put(stream->dev);
 
+return_buffers:
 	uvc_queue_return_buffers(queue, UVC_BUF_STATE_QUEUED);
 
 	return ret;
-- 
2.48.1

