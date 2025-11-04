Return-Path: <linux-kernel+bounces-885300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08086C328E9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C3E4617C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906333EAFD;
	Tue,  4 Nov 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpZjNS4B"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AC33DEFE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279808; cv=none; b=QiGSVIVS6IbpsryzIElhhzcHhPBenWGs13OvF/RL8kr06GD/JccRhIZJzWwy+emkNFcVATqOAVogo+onAQaX5MNlPV4CIL4X722Yc+SOzbZ04OJL4Oftp2WOffTUjzdjvePJMijAo13AK8S/n3U8JR9ST4PqOQzUr3chDekV97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279808; c=relaxed/simple;
	bh=AVpGhbTlWMYcUtDZO75Du13zXCCyhna1uvtNgig20wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh5o8jNrn47TZ2QiQBPydePda9+t10UOdbYl6TquXbvCt2Gf6/UIbwz4OOAAdP7oVb2hY1DuD1wBFdcJ9kVdz0sAKX4VUa4faDT/W2gPRfRfGCC6IMDp39XTqjMISIORwAyCJ95LaHv1ND9EmHCTEAZVwjjppRJ7GCwRY6FgA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpZjNS4B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477442b1de0so20304205e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279804; x=1762884604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBzuHGqFjGOh4IAWV5vCG99JkAgbQed0TO0fNPxfrBM=;
        b=lpZjNS4BM7T9ubzWi+7PYlDoVORI17XV297RvIUvk8SKZJPQx9vPMx2YTBnBbd2Obb
         1A2cW2iXhC4012vRbnHxfPwj7A38Pe1Z/7tavHAObVR4tXtW+TFNo96i4XIuelHD9zQw
         ShT4LUOVKLyGU8N8v6bKvCIpcHK6UnAfWYf0kaK6qhFsQuHxUb9ekB6TzG0O0Sno0kZM
         b1zqihSUFwv1Q5VzcFlUdWEhwMxjSa41c8mVO2oMuWI5njkxK+sUeKKkmarylcDcFMYE
         RKjGvJwPPFwsCxRSLhogHvIwjZaIkHhTIYW3qQm976FN8gHNJVMF0X/7dMkA9oi1bEj7
         wnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279804; x=1762884604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBzuHGqFjGOh4IAWV5vCG99JkAgbQed0TO0fNPxfrBM=;
        b=wnc9f9VCONRw6HaQkjl5CXtTemrnn4xgPkv4vaa2vOT+/P99ORURc8KeMiqSy5SIiX
         BZHZrEtmaIRhqDRerTRPszfgOcuG5Mk+BtA6bMrY5pLpcMW8lqMgwdVWoX0Y9EpDnTai
         Zw65luQU1kigJbwqNs9iOpjGC7kRw5uRjA9P56OLQAYrqkNwW8KnyX9cDeGRAn/XSUmD
         gqNboqiHSEEt3Hh+fkQI6dnj7KaTqAe1t33MTVnPLsU5sjzCqRRsXrtbGN4dmc1vBIYK
         /SU1gXsWZkr2oDbWqjEWR+SXZ5V5tAISK95Tk/wl4rvbhR4oO1RqCaB0oZe4u7J0awzA
         UyQA==
X-Forwarded-Encrypted: i=1; AJvYcCVitZ3UoK+OP55AXlKXmBIjpOr05Vvp6cAq57QR39SWH+vKpiU3jDn2+n8h/F/21pDoWYTOlepKLwaDhm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7AJUGduUU19cqeUyfxvHwkutwCSDzREsrXXh00E2zl3BedjG
	jd2mpzgvfcdbdT0NRvuliSvqOMtfL/PNvPO+O4FKqCao9MpcSX1Y0ehC
X-Gm-Gg: ASbGncvhqUDVLA7ME9v8G3Mb4yUc3VpbLMHOzbV4W8xF1cVJbt+vrXFtWne2h5fQxxl
	fCFUTrw1TXPtpT1CXaZvYyCckd9DavbU3OhJN7TRpIKHXfX+Yuk0O0gcbpqzxx4yRWCDUJgvdLl
	W0JhIEmA8p39LcY7cOqPqR5VHL3khKiIFII8HCevYDFdnIvcL8Fa2bQpKTWxqy+KQh9Gyo+sVRv
	IrValLw4acCfia+I5956j8pPCoFFyTXsSVwrCSjUuZYWU+o8OHzcAirgILyICbb8LUmCQ3pF2lA
	aywllB4TIsD+X1L+NfwdmcZ6s8SFe9EqZtiv248t60GuHX99O2iHqyrBGY1HuLXOMwIX0Obs8UH
	tEETV1TYq4QeTeYC9OAQFcOKfmTLsGo+7UGsYRTJT6XL905z7KHj63UJTfXb1+rn2BOXt+iQ9YQ
	kc8TXT81D/xuFjKcDK8Q==
X-Google-Smtp-Source: AGHT+IE+aXaz85+OcD9Vk61BR2+xCkKdEVOqbAdpjmknpg/EVMyrQo0hoti++4WquFHkKitI5cwjxQ==
X-Received: by 2002:a05:600c:4e48:b0:477:54c0:6c3b with SMTP id 5b1f17b1804b1-4775cdad2admr2728525e9.2.1762279804193;
        Tue, 04 Nov 2025 10:10:04 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:03 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v2 02/30] drm/sun4i: mixer: Remove ccsc cfg for >= DE3
Date: Tue,  4 Nov 2025 19:09:14 +0100
Message-ID: <20251104180942.61538-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104180942.61538-1-jernej.skrabec@gmail.com>
References: <20251104180942.61538-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those engine versions don't need ccsc argument, since CSC units are
located on different position and for each layer.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 31a8409b98f4..f7f210a925f8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -790,7 +790,6 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE3,
 	.mod_rate	= 600000000,
 	.scaler_mask	= 0xf,
@@ -800,7 +799,6 @@ static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun50i_h616_mixer0_cfg = {
-	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE33,
 	.mod_rate	= 600000000,
 	.scaler_mask	= 0xf,
-- 
2.51.2


