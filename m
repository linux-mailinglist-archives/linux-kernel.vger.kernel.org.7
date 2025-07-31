Return-Path: <linux-kernel+bounces-751996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC31B17020
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344E41697FA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB682BE657;
	Thu, 31 Jul 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mmfn/D91"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6432BE636;
	Thu, 31 Jul 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959985; cv=none; b=OI6Ri3onxf0X5wC5UxuGhxMdzlgi9ocgo7How1E6p46psX/PFy69bw99PZYHM+OKdLHqxx50eQbxRZzX8qBI0boQjQzDeFAQ7lNsOh6+rOMP3HI5tMDtTf+TPLQ0G9atvJ2ZIE/GpPWPNTH3QzhuTnwhmW/Ppjog1I1pTdi+bBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959985; c=relaxed/simple;
	bh=fqZO1JNYBXlDxIlfB5OZUFz0ouoQTRtapMQE2pFFdVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alVJ1yGk0MJr5CSyVzxyqwwZa6bFRU+0yimF5IfRxAiJPoUS9n9zOKa6AZWTbPqIMOFoST1OCky6UkSSEUbwnoAeZHWYp6moYXNbWO4J6BbKNnuwheE8ZDZibsaZXtZXXe90pczYCIZ9Bi0Zrrfc8RrpuuyACpQdGvljei8IIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mmfn/D91; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bd7676e60so45894b3a.0;
        Thu, 31 Jul 2025 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959983; x=1754564783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFhfvC5VEfE8AKIEeum3f69cJVMRVPgE7qZ5KXrKlXU=;
        b=Mmfn/D91JvUfO0ZgYm3UcZxNVi/QQa55Tz7ZUplOq0pk42iAkCIP5LW3Pi9JmuWV6c
         aIef85XT06GzfN6pK2AkCigZa00IClwkAB4RFMmztXupuw4Eyee9dt6JhULuM4V8XunY
         LAWmtZ52iQ6qEd+sDiiIWUl9rnY2hrETKW8x9bdgI47hw3+e7hLorebjDf4Wjaui1E67
         ulTG3l0YyfKLN/fNZaOYGq25giOtQ9yb9rJxWrr25jqELWoCk745WyRKVkwDU68vgffw
         Nl1PPsjpIFOK8O0WbQ+5YCwfPhweFT4Z+x+RwdAhDIcHkhU6Vuvuh/sOzeQzPzSY08KY
         Tvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959983; x=1754564783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFhfvC5VEfE8AKIEeum3f69cJVMRVPgE7qZ5KXrKlXU=;
        b=Z8Yv6lgKCbb3kW/vLqC060o+iuCmFK1eWLDk/FTOTjbpBMknFjHJIsGG+6d+vd162/
         a3K3LzeIhC0D6G7bNo/qVom6Oadpi9xqWWEpF4oO55QAHiFJUM1H+q3aeJKUOdLnP7+N
         6Lnf7ew0elCk4jh5+eG3SBROm8SP2nu8RxVH82m+e+p7M+rf+ijNZ53Aa1De8h+j2EXY
         E2RMC+Xiy7LNYgnIeHELyhLD27te/d0c+h4xRip4DQiU4NY2RcZ/07JYGLhWi8XQDh8k
         vZe0bqFW/7xTucblZ31ixLK9yP2tRIWbjN0kj4vFB2N5IaGL+Sg5bj05dF9EjnznYFLy
         wDRw==
X-Forwarded-Encrypted: i=1; AJvYcCUZYrGewjQa7b0IORj41bdUUrgRtzPvD6DmvC46dsF2K8DW7VpHocJp2kHzffroV9UlM/vz2Xd+6nRCCU8=@vger.kernel.org, AJvYcCXoUlF6Kyb3bT1eiqVSNfbzfd+Iu8iI6eLgInTz+gUTLHxPGznD/hJHDvN3Db5JcGLCSv68POvWZQumeX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFwWcIIIblTbenFCgBCEWHQKv8ECkOIZX30UWqEiHsXRxMIVD
	RAU/kJwxf7+O++OAcNvJYOPj9DExv0b9ivARbBo3FkEmbdbc3fSaMga4
X-Gm-Gg: ASbGncuR6+xxQNOhS89eZm5vVFEpW7fAyo0jo7ko1wBdMESZetiB8T7PzG6idiG85em
	aeInASmiwAVhgLz3C8rlzd1NO+RiGKpzTB3B3jEXPL9Psgtd7xg12LeG4nFStrKDm8K80m+k2VU
	3IUt5nH1VwwiqvscCbDJvO6sT/OgZMu3C0Z+24M/lma1JUtH0NboO4LGYKYUHNLTWxrk+uSM3cH
	Ja7JWwRJ4IzEZc4aho8HnWx42tOZJBcFqNSnWY7TBOVQA+jTn7hSrK4dCFHsZjUIMSPbBd1o5c6
	dGa59rWlaLhpVtIGyBoausrvvEA3etSrZOA3OXpjWVMoD977tRqWSn5bf/7uWuJhcudeFEUY3+b
	RWhgP0TVob22/8cXe60JohBzrBbRdT1jLKZZrNQ==
X-Google-Smtp-Source: AGHT+IEIMZOrahipWmGwDgqKoQgiQCaY1fhIOBZ8C/XEanpUSyQbjFeefUNr6KabzotB/ub5wu7vWA==
X-Received: by 2002:a05:6a21:33a7:b0:220:ace9:193c with SMTP id adf61e73a8af0-23dc0eb9e63mr11290547637.38.1753959982904;
        Thu, 31 Jul 2025 04:06:22 -0700 (PDT)
Received: from 25.04 (1-34-7-240.hinet-ip.hinet.net. [1.34.7.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb0db0fsm1250492a12.61.2025.07.31.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:06:22 -0700 (PDT)
From: noble228@gmail.com
To: tiwai@suse.com
Cc: perex@perex.cz,
	hulianqin@vivo.com,
	lina+kernel@asahilina.net,
	cyan.vtb@gmail.com,
	dan.carpenter@linaro.org,
	bsevens@google.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"noble.yang" <noble.yang@comtrue-inc.com>
Subject: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB Audio device
Date: Thu, 31 Jul 2025 19:06:14 +0800
Message-ID: <20250731110614.4070-1-noble228@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "noble.yang" <noble.yang@comtrue-inc.com>

The vendor Comtrue Inc. (0x2fc6) produces USB audio chipsets like
the CT7601 which are capable of Native DSD playback.

This patch adds QUIRK_FLAG_DSD_RAW for Comtrue (VID 0x2fc6), which enables
native DSD playback (DSD_U32_LE) on their USB Audio device. This has been
verified under Ubuntu 25.04 with JRiver.


Signed-off-by: noble.yang <noble.yang@comtrue-inc.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index bd24f3a78ea9..cbb66125f839 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2408,6 +2408,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2d87, /* Cayin device */
 		   QUIRK_FLAG_DSD_RAW),
+ 	VENDOR_FLG(0x2fc6, /* Comture-inc devices */
+		   QUIRK_FLAG_DSD_RAW),	   
 	VENDOR_FLG(0x3336, /* HEM devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3353, /* Khadas devices */
-- 
2.48.1


