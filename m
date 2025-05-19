Return-Path: <linux-kernel+bounces-652984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB5ABB31F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 04:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0623B4561
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 02:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703841E8358;
	Mon, 19 May 2025 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2+SPvD5"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014D1E8335
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747620338; cv=none; b=oyaNsUWGz1ov55xJkiGfZ4NQw9pi9FM9j9XskjZdxhhv26fUlh3gdOOWNKyOXeZW6gkRsr/JEFAWQM9quA5ACMycoi9MsKan/9/YKoCmX8sqD6LZLeMr998p6ZqH4wsBdqxHWPxdIVyr029h6UT6BMRDJw3bH2I7YnrcYuGlh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747620338; c=relaxed/simple;
	bh=SlSjPSx3oORnZac0lX3df2Lf1XLvuji2J9tmHdBTFmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N8nmQOriajGHEL+YOqnPsRgGRvVkvIlmb9CdLjyx5lEhZWkxX1sDtcZPgi+RzKgmkv/itavlmZmqkvm/ilOQzBKN09eaWTxJ98Hula0p9vqYQowPN8KtvZH8WLtFLbicsXcLn7MjZqGDs/vBi923sgzjQNuNt6zpnoaLBxssk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2+SPvD5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a29af28d1so3174977a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 19:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747620336; x=1748225136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vRY2y3H2M0g7eU6al4Bqcf8B85yBAZ79K9H+4pojmNI=;
        b=q2+SPvD5N8JnwjKH1FJSTV5zGrKZ5lJudexEB4KiE8ywIw3KV4t2E5PNVr+oBKb6b4
         QVJx7OauCN4YE6NOQfHgoc2at0lLN1RP+o82aOSTKgFigXrS/cYHpyYxhd9K3QNVh5HJ
         yYKxQ0hJzmf/ZMdGbmt6TX5XNWsdH/yXg8TLmUbObdYcAKC1IH2Djh8O70qpM5/Ri/DU
         dRffmvb0Cg97xKa352v7aHs5lGW7cs0U3fL7t3zY4gm+zRYpY7UA+7jMOEEQPbLnD2bA
         iRkO75pJJv58yP3wfZssbAeeMy5Z6rIU6abWHMy7VDXNr8fkDUoFNjuuUUgy/5yUS0dP
         tTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747620336; x=1748225136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRY2y3H2M0g7eU6al4Bqcf8B85yBAZ79K9H+4pojmNI=;
        b=pFMF/gca7H8FVP/rZduVi4wCXz0F7EcWt/gYIYEIlOmqBJOpbx2hdpfMxMTjKa6wnX
         qrjR8QFn84CI9h603nSRE2APh4l9X0xQuMnAgQJ3XAtbTYTl+IEZBj8WrqOzFUeiXQFd
         KNT4xqECiuW7bMcYrToxET+57hkCR5rJ7c+gQW8c+iuqXiey7bqedY4wOw8ufFxJTTg/
         7U9NpR2SNKDVAfJR9pmbkLXZVZpSlFydDo4Q9AKiv73lPMG0dAs/3iQ+eBeJJaDBk26O
         cyBqmVUk41Mv4ydVtfw5D9dQG3ftmbioeqBARSm1FpeDmBnZX9cFmh35jCjfs0/v5KZB
         yU8A==
X-Forwarded-Encrypted: i=1; AJvYcCUKc19XPamX0KXeB801Xg4dxS3rP29z+jOrPDtxJw050I0iISlRFH3554CVw5KO8k2HABwUf2a8qdKy8DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKeVPL3wkiUz3GnfNDswfNHep834Ca1WcYWBjRKpB5akcUUDYP
	20nvrH+gxciNdqtIyjyuPhuXFwB94A+41OgD01Xed2CkcHq8Hpby0mo78vgDzK0kbro+toxljNw
	y40xVpCQ1mPgoiTA/lbpJsQ==
X-Google-Smtp-Source: AGHT+IEgLCPDk0lcsU7PJBMeeeiGHkBU66pxZpAlFPIjVpPOdmqlIvYYUbJ1ldSdTgpALODW0ZliY8tcKqdF9dmG
X-Received: from plxe16.prod.google.com ([2002:a17:902:ef50:b0:220:ea57:34e3])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dacc:b0:231:d0f4:6264 with SMTP id d9443c01a7336-231d43d9bc0mr180230995ad.10.1747620336559;
 Sun, 18 May 2025 19:05:36 -0700 (PDT)
Date: Sun, 18 May 2025 19:04:50 -0700
In-Reply-To: <cover.1747619816.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747619816.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <3d4bb87742eee4a6792bbdae893256f621ffffe6.1747619816.git.ericflorin@google.com>
Subject: [PATCH 7/9] staging: sm750fb: rename `hw_sm750_setColReg`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `hw_sm750_setColReg` to `hw_sm750_set_col_reg` to conform with
kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <hw_sm750_setColReg>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 5f4b0064cf92..935c7b1a0fa4 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -545,7 +545,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
-		ret = hw_sm750_setColReg(crtc, regno, red, green, blue);
+		ret = hw_sm750_set_col_reg(crtc, regno, red, green, blue);
 		goto exit;
 	}
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index db80dd295658..a70f51d08dd2 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -208,8 +208,8 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 			   struct fb_var_screeninfo *var,
 			   struct fb_fix_screeninfo *fix);
 
-int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
-		       ushort red, ushort green, ushort blue);
+int hw_sm750_set_col_reg(struct lynxfb_crtc *crtc, ushort index,
+			 ushort red, ushort green, ushort blue);
 
 int hw_sm750_setBLANK(struct lynxfb_output *output, int blank);
 int hw_sm750le_setBLANK(struct lynxfb_output *output, int blank);
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index d3f218cb20f5..04a0f9218eb8 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -370,8 +370,8 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 	return ret;
 }
 
-int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index, ushort red,
-		       ushort green, ushort blue)
+int hw_sm750_set_col_reg(struct lynxfb_crtc *crtc, ushort index, ushort red,
+			 ushort green, ushort blue)
 {
 	static unsigned int add[] = { PANEL_PALETTE_RAM, CRT_PALETTE_RAM };
 
-- 
2.49.0.1112.g889b7c5bd8-goog


