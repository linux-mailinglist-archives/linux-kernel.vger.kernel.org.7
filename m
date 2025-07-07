Return-Path: <linux-kernel+bounces-720379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCDAAFBAD1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D23C16C05B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CCF274B23;
	Mon,  7 Jul 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UOAvDuOH"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68627270ED9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913248; cv=none; b=kOeo+zQHE9h53xhj5h7Z3o+VsbESWGd276B9S8E6jy070TPwkl6gCJNmqyxQ4Xb8Wr+4Qr+Yqwzl3oEERpCqkE0ugOhQ5bOn19GQnighV/o3Ay6eTvV29+kNsR8KUoos2Q0LaiGi0rkQVtzDTyktcbZEMRr5NlauBbj4R3P69qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913248; c=relaxed/simple;
	bh=YNGFFPC9zzW74qiewwqmxjg3sbDXhOxc1nuxGLMg4Jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLzD/hLN84NaYe8QrOyQYlCv+KnvF+sJzHvoERcE40cdI0/R/HEPNeg90iNRWXYuYFExCpQSIavQD92SYM3BUpU7GHuTC1ZnNaNUhUWpGUI/F+KcPrVIpTS3D0l9C3ne4t/Nt1jrCKMHYxSMF+FVW1rPrwK2qggVPqEs1+yAlD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UOAvDuOH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55516abe02cso3551903e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751913243; x=1752518043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9os3lS8fH6kHGyK9R2m8uRATRzh2C1OPAQHL6vUS+6g=;
        b=UOAvDuOHTlTW3SP79K6ikfG58LdJjxXuhl/24IwvFx2i2XnQfL+7UU+PGEkw2T/bQ/
         uG9FWQswii2lSS3EiFXHzwzQRQkMKCiSSqhne63L5FbRxfyAkKyMoxBXjo8fvx9i7Ws0
         +ecvur4HaQGhoyfe2lNgGzozpZ2C5DkrY7ko4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913243; x=1752518043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9os3lS8fH6kHGyK9R2m8uRATRzh2C1OPAQHL6vUS+6g=;
        b=FNthPbT/VGrQdWsPBEhRP+SLhIYEldMXrpezX00Rf/prhWz+7pW4v3tsFtJ5uYWw/p
         asYtAWauMdjqMQjdWWnKd87ly4GTv4m3MgvvdN89vDHlCTRvQbXdAPmdvOvmMhvq7S7r
         lZ16x8/mQnL4o6+ISsxttSsXoNraoaO7GZdu2bbmF5PGCG09EHpqtqZFpUK7t35+yay0
         7sm08CGAlt9QAjn5sDvh5/5psQkdMDTQ2JTQHSEm5Ol1dFp+rY4hO3TrmobxAJ7EwWEE
         qjMABbKfwcqLBYzDN0dy0aaSEd40IGUAc0PQCpvDWavElmjTNWYKG9VkicxaDrL0k1fY
         d5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbuicW9+OkQFDGI7rz6LhlO71I7gsF1ToqnJAxgbxSyXA/9fy01FWJpKsetQDgRynzzS9SRgNbStGDvPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YF1RlqUU0Z+6Neq4dNqKx/pkwB4fEtd37pnsn/V6DNRtrdec
	Rb/aoXvBlMpHaNM4CHWav/CcAC95PsGrhgCbnuf10PdGALeNT/XqfZRGl8ScG4Ud0xYi/d3PICk
	SC20=
X-Gm-Gg: ASbGncs/heIqmdWMGzqeMeErsEf3MMXA68ufIilf8SZfYjr+l1YU8/qcvE8NpWgFje0
	sNwNIODzn3gdMDAQqn/Efel0ilNPQpu8bnczba0PQsfqqB+narOeoyRx7yqCrPIeiuqyRVC9NxZ
	YY8rPrM2N8ZrJh3HwA9qOv+4OugEtvG7rQzVRxqmmyuzOC4vTIPPcNxe1DPCtgfPPPFtkCCZBiy
	YxayHSPW1dRCrE9OhKMq5+R3IKbjquMrbPHCUHmSwiALA1SNHp1jQOXbJ5gXHGzIHEddZHv8SsS
	xTH0BwoWZM15joWYgVDSDedS0D/AlwKaUIdAKcKyCHzmzEla14bBCjhJeHWtQHdYsOceVHInf2i
	61pRyuy/hCnFJX0NcAftYW6f6AdGontCa5BfETkxA4A==
X-Google-Smtp-Source: AGHT+IEo+zOt/AEi0FnK1sr6WXC8fbhAVvwDgLrxJE5f71HHIze0CaiIMj7O14ZqNlyCSg74rdmpIg==
X-Received: by 2002:a05:6512:3d06:b0:553:2884:5fb3 with SMTP id 2adb3069b0e04-557f75de7f0mr181222e87.12.1751913243387;
        Mon, 07 Jul 2025 11:34:03 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d31a6sm1417630e87.61.2025.07.07.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:34:03 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 07 Jul 2025 18:34:02 +0000
Subject: [PATCH v8 2/5] media: Documentation: Add note about UVCH length
 field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-uvc-meta-v8-2-ed17f8b1218b@chromium.org>
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

The documentation currently describes the UVC length field as the "length
of the rest of the block", which can be misleading. The driver limits the
data copied to a maximum of 12 bytes.

This change adds a clarifying sentence to the documentation to make this
restriction explicit.

Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/userspace-api/media/v4l/metafmt-uvc.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
index 784346d14bbdbf28348262084d5b0646d30bd1da..4c05e9e54683a2bf844ddf26f99d0d9713ef05de 100644
--- a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
+++ b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
@@ -44,7 +44,9 @@ Each individual block contains the following fields:
         them
     * - :cspan:`1` *The rest is an exact copy of the UVC payload header:*
     * - __u8 length;
-      - length of the rest of the block, including this field
+      - length of the rest of the block, including this field. Please note that
+        regardless of this value, for V4L2_META_FMT_UVC the kernel will never
+        copy more than 2-12 bytes.
     * - __u8 flags;
       - Flags, indicating presence of other standard UVC fields
     * - __u8 buf[];

-- 
2.50.0.727.gbf7dc18ff4-goog


