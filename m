Return-Path: <linux-kernel+bounces-823820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E76B8781B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F8317EA2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994F149C41;
	Fri, 19 Sep 2025 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1yBAU0F"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872341E5B63
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242226; cv=none; b=HkCkWifVpjy6T4MnXZLBv6abxGZHWdIm9AIT0sMVEUFPULlw5i1VnxKGc/IGJpnIivQJ/nChXdr1KfA4im7r4bEGyOzqJZKBLk3XyEJDaWPRQSO96qbz4dZZsZwjrrx1NQYTRXkdu8JjaBFs1yxfY47lJpra06lPh5dhQwURck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242226; c=relaxed/simple;
	bh=k2dBfrdNtLGAZ64PrS3NFKJy0ruuW50Pp0bwQuFiRAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT2mwzgx9A8vN4jUUMwD8/53RQloJFULqAfIqToyoi8p4bBL3qp54KhUgxwGFrwRoLSBdPhIK85+1hY6UnLSe3UaIlAEAUSSw64RFSW3WUuEp84FyIaQ/011uRD3r5kPUbuWyffNVTT//Lv99ALifdKa+f84ixDPfkNqpQ4poeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1yBAU0F; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54abd46747so1600038a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758242224; x=1758847024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWbzRPCjSF9zkkrc1WhzONXArq9qHtgULo12Vo1t/Ms=;
        b=l1yBAU0F9OyIDzCYGvQ1xfpg8acZEoqH10xMtJaObl2+EZbCf4fXuWB2TZV5h10V1P
         Du7h8bmQyBrAWGs9mXNN5av5Pm7dVG2NfbsIPyC4AbSSpvvM8oZCFucIdSMpYXJ/6pO7
         H+Hu8kfOcyDoIO/CHJ+pRiyCLm6GFGgILkphr19ZIqbxkT44aaqXcJIqrFfs7iiP3Mm2
         BQILtMgRbZPh728zLo5SQz1MVLdlFRM7crf5XAm1UxIydmEV39NQjMv/qB8MPxC20Vh2
         bASArHIOvxiIq2yxbvkl0Y1hkPM4q8+1SmUzRA+/37aYPiTMvuhKfsRB2UL/zAHUukG2
         NmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242224; x=1758847024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWbzRPCjSF9zkkrc1WhzONXArq9qHtgULo12Vo1t/Ms=;
        b=l9gY8ky7nrjV7mWfWUqAmfpPgdMWqKcnGp4rU+kkUMqBRao7gtf6DbOklD6yh3vv1v
         lykyzqQ5lqbSvW8+7b/vNKvVIU6TGpdFUZGoS7OHzUs4tqCwID5djEj6Fj+bCgtD4jfQ
         klx6IKjIqk7mrl9XhpdYLmEZBvjCNHrUNXxrbE21YGK3Z4QYKnIEf46uZxxSbdWBYDoR
         in1WG1sB4HkjS80a26/b6xXTZ4aZNKMYZlIXBmBKBMSxVrqQkAI/OJd33IjWED77IPE0
         UmhgnbtDBXlrjz10RM4HyvmgBix2iTcCG4p+YbKpRCSNxVxzD6msU0eBY66eHUjizZyF
         hslg==
X-Gm-Message-State: AOJu0Yzqu9z650jWVAxNhU/cMLXKIN9em9vTPF3b8PGUtcLNcSyyZbdO
	K8VEQ3pgOV1JaRBgxxgsIuPywIzFV563JCfnYYwTN6pSNr3vBhbtSJcczVdpGaJI
X-Gm-Gg: ASbGncsnNWdg/m+5puzLZPh/behFrtuzNUsdVd1WWh/Sb53z/dXPUcFq39j1KCqjZgB
	o6oGmW996b9mVmUKemGzdVhFNyqSRYBz+gpsTctf6aJDXDDDoZLNIdOlAiInbuk3QBkJqMYfaJr
	sk22li5IPkBD9Y0pcJLZ+dMLW9MfLTQjcpt6n10o0XdmzWJyzqr7j3FRPfaS/2drZW5vzQxaNBF
	bOdhERHiaQidAEXCfXqwSQwDyow0cZ9KLjnL1J0ZdTZz1gkoELqmhpJG6Mwl7PWuVirdBQc9s0Z
	ozpdxhCoctfvyKfSQqGsew4hfC7Tu5NRhpE4c3IAz4gP1b7B4tOLEbcMeA7Pvr3ETWhYHQJWKX7
	Q+qdunCm/B7YvcRQqO/G/ZxwPub7xbsbxQ3lPmN3B
X-Google-Smtp-Source: AGHT+IF04noo2z6nfhj/WjW4j01+xVKhsQR6t2wKDzK6qpg/OEXcEUFT4SqFii2oCqgKJ7SG0yCTqw==
X-Received: by 2002:a05:6a20:7348:b0:243:d1bd:fbbb with SMTP id adf61e73a8af0-29274fb7736mr2077670637.59.1758242223625;
        Thu, 18 Sep 2025 17:37:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff445dd7sm3349864a12.51.2025.09.18.17.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 17:37:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3E9BB4227234; Fri, 19 Sep 2025 07:36:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Bernie Thompson <bernie@plugable.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 1/3] Documentation: fb: ep93xx: Demote section headings
Date: Fri, 19 Sep 2025 07:36:38 +0700
Message-ID: <20250919003640.14867-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919003640.14867-1-bagasdotme@gmail.com>
References: <20250919003640.14867-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=bagasdotme@gmail.com; h=from:subject; bh=k2dBfrdNtLGAZ64PrS3NFKJy0ruuW50Pp0bwQuFiRAw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlnlrS7CYsEXRY8VzLlwce97sGs77MD52g9PZglITvF2 tHuyhHhjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExE4R0jw7Fzb+umPpMMTd19 ISEk4PLmfTIrrl+Uj/V6U3ad46ODfhsjw4eweXXK7uvdzLu5XZkaBaaXbdrsO/exk8VUf/bH/u0 yjAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Section headings are formatted the same as title heading, thus
increasing number of entries in framebuffer toctree. Demote them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/fb/ep93xx-fb.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/fb/ep93xx-fb.rst b/Documentation/fb/ep93xx-fb.rst
index 1dd67f4688c751..93b3494f530979 100644
--- a/Documentation/fb/ep93xx-fb.rst
+++ b/Documentation/fb/ep93xx-fb.rst
@@ -41,7 +41,6 @@ your board initialisation function::
 
 	ep93xx_register_fb(&some_board_fb_info);
 
-=====================
 Video Attribute Flags
 =====================
 
@@ -79,7 +78,6 @@ EP93XXFB_USE_SDCSN2		Use SDCSn[2] for the framebuffer.
 EP93XXFB_USE_SDCSN3		Use SDCSn[3] for the framebuffer.
 =============================== ======================================
 
-==================
 Platform callbacks
 ==================
 
@@ -101,7 +99,6 @@ obtained as follows::
 		/* Board specific framebuffer setup */
 	}
 
-======================
 Setting the video mode
 ======================
 
@@ -119,7 +116,6 @@ set when the module is installed::
 
 	modprobe ep93xx-fb video=320x240
 
-==============
 Screenpage bug
 ==============
 
-- 
An old man doll... just what I always wanted! - Clara


