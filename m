Return-Path: <linux-kernel+bounces-730664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415D2B047D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6044E3BA739
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A36E27933E;
	Mon, 14 Jul 2025 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b="JaUT1bB2"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FAE2797A3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520662; cv=none; b=iloZmjKlZ6aN1Td1EioX4foHL/6S6kyLRQ26tG2DimIFg0VsmQtsqryAR5fS2Z04ZR4b5T+Mg36gLBlR8R5KOPz5sRJExlELQcbO7EzlbRRpYx28kioYO5q8UnEx7irjspsS5tCRVXfcyPSakg0AsoYKlgiPCukxxKfqfZKXyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520662; c=relaxed/simple;
	bh=hoRIS4xztsEZTVodkSIk19iypGdwTDkduJUZuq63xV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR93Z0Od5p0b/GTAKhfDQBCbF8AljiOEP3NUGWqeoyVeKP0HNHqwa4pSKZs7BmaVEvM8YIwTMTD2YBzDMM64QVIaOchF6V7kEZz5PbVkrlfo0fImKhfW6kvmq++JGhF8LTKdtSvXBMZoQO6RT7tw6sKX3d3tz04br8VPUoTq6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com; spf=pass smtp.mailfrom=scandent.com; dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b=JaUT1bB2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scandent.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a589b7dd5fso63717261cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scandent.com; s=google; t=1752520659; x=1753125459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpGQ9FLDAr43bgdxabo4tUh7EGNcN/YMu4ikygM2H3E=;
        b=JaUT1bB235zXybmeD3LXmwMQdy/pPshMyKa6JNDTXDr+UnseWdTxonJGfYzajHLI0p
         ODescWDTnEjziCsJML51xlG396QfgKMuuQsNE+1kkh/vQZZKuNwXdAc1gWkfyNEsTgAN
         CjhPGRC+5yqYpH1673gqRy6g4iTeT3VzoAYrtH1NLj/Ut8RvEDDFq2RRj7SQW7n8soG6
         xWr/pYbhfPCBrhZHi/xw08kVgn8Oukn5Q1JJRBwv7JqQZSuD4RuZkbPINJTfMScJPQWY
         1Fy+Jyk6kp9MdTQlequvKClPVUKr4/3r7EebMrhoaa5qgMivyyQQc2fV4kv/owTEXLOd
         XsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752520659; x=1753125459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpGQ9FLDAr43bgdxabo4tUh7EGNcN/YMu4ikygM2H3E=;
        b=AbUjW9uF+d1snKS0w/w7eZd1rZr1rOKGATm3x3ed2t9jynXyN/nvXoaz6F7agztBs/
         YcQ1fnWCp5N7dGT3vbn8aTID1WEw9vsT9teVtAhxMxSL/I3AAm6JAAp0cA82tkPzi9sC
         /DdbKQ4Tej9o/j/4mPih3QyGpBDDwYvPGGLi85VNbRpsO4emB14bxYQKPkvBpUtkE9+O
         YjSVErZPPKE/ZvF3msYmVa4KUh1yLO2hF49CYxdZAIOOXcGRNYRy88FwIJSQeXWbmpLv
         gI4yAGW+ovfetsD6dbx06FomFoRqhWeQG6vKe1xVgAvhm4T63dljancTnfuq6nNxP4cH
         pU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTAjy8usC+CbGfwf/Y9NnWxVe1QGl+jQzWKo/laOYKGa1M7zZfkp4l5pWYy454BnOU12XvYqlUMDkiqsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1xfHlBFNn8RZoNx4rG1XZjmaS5OKMu/BeBo3vEUsIf3cOkTK
	JTdkijwFRAozqwkJpZQlcw0QomjY4o0rE6d4BYJgzEFiK3SxhMM8jm4+x+AW6aaUq/E=
X-Gm-Gg: ASbGncsUnbj8wiwSa1chcMkVWtp3dH3/K/3IHpLrIiusWK6ENli7QkyKvxQpDG2GO9Z
	DtCZN6GDldSVzxRLMfePL6JAkofeka1wlqjI8s2tzlkvBt8TLvRA+CIngSHjuv2zIUDFoYxbsec
	7wOitma4oiT4C1pnfPo/eIBd3a5z99khbVibxcEHbif829J+0QS2wT3m3bZACjoKht5cdRvQqbx
	4jjLYH9ga5P2ZAT//w3620TcbndD3mu8uKrvZEooXXw0kW9XXNJrJO23LlCmRPbzOTRnfQPTGwo
	W7uDlRnUMmuK4SWiPX1laR5d5tMFdcfqOhiLx6kxRs4p9nnrzCtOx7L3pNU/mkKteRNNbydN30y
	AlHC4XxL3UfeULB2+9SK7X36tCfvfbApT3IlzaBgYu2HbrA5K
X-Google-Smtp-Source: AGHT+IEU5noXyWPh4x33ngWAJKOBd6ljiPAtleeBfBcNMPyZjaKaCTbDXwMpZfNYEqmpn/ooTm4Fng==
X-Received: by 2002:a05:622a:1e94:b0:4ab:80df:24eb with SMTP id d75a77b69052e-4ab80df29d2mr5189881cf.6.1752520659214;
        Mon, 14 Jul 2025 12:17:39 -0700 (PDT)
Received: from vserver (ool-44c5118c.dyn.optonline.net. [68.197.17.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab801e542bsm1482521cf.3.2025.07.14.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:17:38 -0700 (PDT)
From: Richard Yao <richard@scandent.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshay Athalye <akshay@scandent.com>,
	Richard Yao <richard@scandent.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 3/3] drm/panel: ilitek-ili9881c: Add Tianxinwei TWX700100S0 support
Date: Mon, 14 Jul 2025 15:17:23 -0400
Message-ID: <20250714191729.2416-4-richard@scandent.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714191729.2416-1-richard@scandent.com>
References: <20250714191729.2416-1-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the Tianxinwei TWX700100S0 panel.

The init table was provided by Tianxinwei. Their comments have been
preserved.

Signed-off-by: Richard Yao <richard@scandent.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 28cd7560e5db..54198bb7280c 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -1223,6 +1223,223 @@ static const struct ili9881c_instr am8001280g_init[] = {
 	ILI9881C_COMMAND_INSTR(MIPI_DCS_WRITE_POWER_SAVE, 0x00),
 };
 
+static const struct ili9881c_instr txw700100s0_init[] = {
+	ILI9881C_SWITCH_PAGE_INSTR(3),
+	/* GIP_1 */
+	ILI9881C_COMMAND_INSTR(0x01, 0x00),
+	ILI9881C_COMMAND_INSTR(0x02, 0x00),
+	ILI9881C_COMMAND_INSTR(0x03, 0x72), /* STVA 3H */
+	ILI9881C_COMMAND_INSTR(0x04, 0x00), /* STVB */
+	ILI9881C_COMMAND_INSTR(0x05, 0x00), /* STVC */
+	ILI9881C_COMMAND_INSTR(0x06, 0x09), /* STVA_Rise */
+	ILI9881C_COMMAND_INSTR(0x07, 0x00), /* STVB_Rise */
+	ILI9881C_COMMAND_INSTR(0x08, 0x00), /* STVC_Rise */
+	ILI9881C_COMMAND_INSTR(0x09, 0x00), /* STVA_non overlap 2.5us=14 */
+	ILI9881C_COMMAND_INSTR(0x0a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0f, 0x00), /* CLKA_non overlap 2.5us=14 */
+	ILI9881C_COMMAND_INSTR(0x10, 0x00),
+	ILI9881C_COMMAND_INSTR(0x11, 0x00),
+	ILI9881C_COMMAND_INSTR(0x12, 0x00),
+	ILI9881C_COMMAND_INSTR(0x13, 0x00),
+	ILI9881C_COMMAND_INSTR(0x14, 0x00),
+	ILI9881C_COMMAND_INSTR(0x15, 0x00),
+	ILI9881C_COMMAND_INSTR(0x16, 0x00),
+	ILI9881C_COMMAND_INSTR(0x17, 0x00),
+	ILI9881C_COMMAND_INSTR(0x18, 0x00),
+	ILI9881C_COMMAND_INSTR(0x19, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1e, 0x40), /* CLKA 40自動反 C0手動反(X8參考CLKB) */
+	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
+	ILI9881C_COMMAND_INSTR(0x20, 0x05), /* CLKA_Rise */
+	ILI9881C_COMMAND_INSTR(0x21, 0x02), /* CLKA_Fall */
+	ILI9881C_COMMAND_INSTR(0x22, 0x00),
+	ILI9881C_COMMAND_INSTR(0x23, 0x00),
+	ILI9881C_COMMAND_INSTR(0x24, 0x00),
+	ILI9881C_COMMAND_INSTR(0x25, 0x00),
+	ILI9881C_COMMAND_INSTR(0x26, 0x00),
+	ILI9881C_COMMAND_INSTR(0x27, 0x00),
+	ILI9881C_COMMAND_INSTR(0x28, 0x33), /* CLK Phase_NUM=8 */
+	ILI9881C_COMMAND_INSTR(0x29, 0x22), /* CLK overlap 3H */
+	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x30, 0x00),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x32, 0x00),
+	ILI9881C_COMMAND_INSTR(0x33, 0x00),
+	ILI9881C_COMMAND_INSTR(0x34, 0x04), /* VDD1&2 non-overlap 04:2.62us */
+	ILI9881C_COMMAND_INSTR(0x35, 0x00),
+	ILI9881C_COMMAND_INSTR(0x36, 0x00),
+	ILI9881C_COMMAND_INSTR(0x37, 0x00),
+	ILI9881C_COMMAND_INSTR(0x38, 0x3C), /* VDD1&2 toggle 1sec */
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x40, 0x00),
+	ILI9881C_COMMAND_INSTR(0x41, 0x00),
+	ILI9881C_COMMAND_INSTR(0x42, 0x00),
+	ILI9881C_COMMAND_INSTR(0x43, 0x00),
+	ILI9881C_COMMAND_INSTR(0x44, 0x00),
+
+	/* GIP_2 */
+	ILI9881C_COMMAND_INSTR(0x50, 0x10), /* STV_1, 0x2 */
+	ILI9881C_COMMAND_INSTR(0x51, 0x32), /* STV_3, 0x4 */
+	ILI9881C_COMMAND_INSTR(0x52, 0x54), /* STV_5, 0x6 */
+	ILI9881C_COMMAND_INSTR(0x53, 0x76), /* STV_7, 0x8 */
+	ILI9881C_COMMAND_INSTR(0x54, 0x98), /* STV_9, 0x10 */
+	ILI9881C_COMMAND_INSTR(0x55, 0xba), /* STV_11, 0x12 */
+	ILI9881C_COMMAND_INSTR(0x56, 0x10), /* CLK_1.2 */
+	ILI9881C_COMMAND_INSTR(0x57, 0x32), /* CLK_3, 0x4 */
+	ILI9881C_COMMAND_INSTR(0x58, 0x54), /* CLK_5, 0x6 */
+	ILI9881C_COMMAND_INSTR(0x59, 0x76), /* CLK_7, 0x8 */
+	ILI9881C_COMMAND_INSTR(0x5a, 0x98), /* CLK_9, 0x10 */
+	ILI9881C_COMMAND_INSTR(0x5b, 0xba), /* CLK_11, 0x12 */
+	ILI9881C_COMMAND_INSTR(0x5c, 0xdc), /* CLK_13, 0x14 */
+	ILI9881C_COMMAND_INSTR(0x5d, 0xfe), /* CLK_15, 0x16 */
+
+	/* GIP_3 */
+	ILI9881C_COMMAND_INSTR(0x5e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x5f, 0x01), /* FW_CGOUT_L[1]    FW */
+	ILI9881C_COMMAND_INSTR(0x60, 0x00), /* FW_CGOUT_L[2]    BW */
+	ILI9881C_COMMAND_INSTR(0x61, 0x15), /* FW_CGOUT_L[3]    GPWR1 */
+	ILI9881C_COMMAND_INSTR(0x62, 0x14), /* FW_CGOUT_L[4]    GPWR2 */
+	ILI9881C_COMMAND_INSTR(0x63, 0x0E), /* FW_CGOUT_L[5]    CLK1_R */
+	ILI9881C_COMMAND_INSTR(0x64, 0x0F), /* FW_CGOUT_L[6]    CLK2_R */
+	ILI9881C_COMMAND_INSTR(0x65, 0x0C), /* FW_CGOUT_L[7]    CLK3_R */
+	ILI9881C_COMMAND_INSTR(0x66, 0x0D), /* FW_CGOUT_L[8]    CLK4_R */
+	ILI9881C_COMMAND_INSTR(0x67, 0x06), /* FW_CGOUT_L[9]    iSTV1_R (STVA_1) */
+	ILI9881C_COMMAND_INSTR(0x68, 0x02), /* FW_CGOUT_L[10] */
+	ILI9881C_COMMAND_INSTR(0x69, 0x02), /* FW_CGOUT_L[11] */
+	ILI9881C_COMMAND_INSTR(0x6a, 0x02), /* FW_CGOUT_L[12] */
+	ILI9881C_COMMAND_INSTR(0x6b, 0x02), /* FW_CGOUT_L[13] */
+	ILI9881C_COMMAND_INSTR(0x6c, 0x02), /* FW_CGOUT_L[14] */
+	ILI9881C_COMMAND_INSTR(0x6d, 0x02), /* FW_CGOUT_L[15] */
+	ILI9881C_COMMAND_INSTR(0x6e, 0x07), /* FW_CGOUT_L[16]  STV2_R (STVA_3) */
+	ILI9881C_COMMAND_INSTR(0x6f, 0x02), /* FW_CGOUT_L[17]   VGL */
+	ILI9881C_COMMAND_INSTR(0x70, 0x02), /* FW_CGOUT_L[18]   VGL */
+	ILI9881C_COMMAND_INSTR(0x71, 0x02), /* FW_CGOUT_L[19]   VGL */
+	ILI9881C_COMMAND_INSTR(0x72, 0x02), /* FW_CGOUT_L[20] */
+	ILI9881C_COMMAND_INSTR(0x73, 0x02), /* FW_CGOUT_L[21] */
+	ILI9881C_COMMAND_INSTR(0x74, 0x02), /* FW_CGOUT_L[22] */
+
+	ILI9881C_COMMAND_INSTR(0x75, 0x01), /* BW_CGOUT_L[1]    FW */
+	ILI9881C_COMMAND_INSTR(0x76, 0x00), /* BW_CGOUT_L[2]    BW */
+	ILI9881C_COMMAND_INSTR(0x77, 0x14), /* BW_CGOUT_L[3]    GPWR1 */
+	ILI9881C_COMMAND_INSTR(0x78, 0x15), /* BW_CGOUT_L[4]    GPWR2 */
+	ILI9881C_COMMAND_INSTR(0x79, 0x0E), /* BW_CGOUT_L[5]    CLK1_R */
+	ILI9881C_COMMAND_INSTR(0x7a, 0x0F), /* BW_CGOUT_L[6]    CLK2_R */
+	ILI9881C_COMMAND_INSTR(0x7b, 0x0C), /* BW_CGOUT_L[7]    CLK3_R */
+	ILI9881C_COMMAND_INSTR(0x7c, 0x0D), /* BW_CGOUT_L[8]    CLK4_R */
+	ILI9881C_COMMAND_INSTR(0x7d, 0x06), /* BW_CGOUT_L[9]    STV1_R */
+	ILI9881C_COMMAND_INSTR(0x7e, 0x02), /* BW_CGOUT_L[10] */
+	ILI9881C_COMMAND_INSTR(0x7f, 0x02), /* BW_CGOUT_L[11] */
+	ILI9881C_COMMAND_INSTR(0x80, 0x02), /* BW_CGOUT_L[12] */
+	ILI9881C_COMMAND_INSTR(0x81, 0x02), /* BW_CGOUT_L[13] */
+	ILI9881C_COMMAND_INSTR(0x82, 0x02), /* BW_CGOUT_L[14] */
+	ILI9881C_COMMAND_INSTR(0x83, 0x02), /* BW_CGOUT_L[15] */
+	ILI9881C_COMMAND_INSTR(0x84, 0x07), /* BW_CGOUT_L[16]   STV2_R */
+	ILI9881C_COMMAND_INSTR(0x85, 0x02), /* BW_CGOUT_L[17]   VGL */
+	ILI9881C_COMMAND_INSTR(0x86, 0x02), /* BW_CGOUT_L[18]   VGL */
+	ILI9881C_COMMAND_INSTR(0x87, 0x02), /* BW_CGOUT_L[19]   VGL */
+	ILI9881C_COMMAND_INSTR(0x88, 0x02), /* BW_CGOUT_L[20] */
+	ILI9881C_COMMAND_INSTR(0x89, 0x02), /* BW_CGOUT_L[21] */
+	ILI9881C_COMMAND_INSTR(0x8A, 0x02), /* BW_CGOUT_L[22] */
+
+	ILI9881C_SWITCH_PAGE_INSTR(4),
+	ILI9881C_COMMAND_INSTR(0x6E, 0x2A), /* di_pwr_reg=0 for power mode 2A //VGH clamp 15V */
+	ILI9881C_COMMAND_INSTR(0x6F, 0x35), /* reg vcl + pumping ratio VGH=3x VGL=-3x */
+	ILI9881C_COMMAND_INSTR(0x3A, 0x24), /* POWER SAVING */
+	ILI9881C_COMMAND_INSTR(0x8D, 0x14), /* VGL clamp -10V */
+	ILI9881C_COMMAND_INSTR(0x87, 0xBA), /* ESD */
+	ILI9881C_COMMAND_INSTR(0x26, 0x76),
+	ILI9881C_COMMAND_INSTR(0xB2, 0xD1),
+	ILI9881C_COMMAND_INSTR(0xB5, 0x27), /* GMA BIAS */
+	ILI9881C_COMMAND_INSTR(0x31, 0x75), /* SRC BIAS */
+	ILI9881C_COMMAND_INSTR(0x30, 0x03), /* SRC OUTPUT BIAS */
+	ILI9881C_COMMAND_INSTR(0x3B, 0x98), /* PUMP SHIFT CLK */
+	ILI9881C_COMMAND_INSTR(0x35, 0x1F), /* HZ_opt */
+	ILI9881C_COMMAND_INSTR(0x33, 0x14), /* Blanking frame 設定為GND */
+	ILI9881C_COMMAND_INSTR(0x7A, 0x0F),
+	ILI9881C_COMMAND_INSTR(0x38, 0x01),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+
+	ILI9881C_SWITCH_PAGE_INSTR(1),
+	ILI9881C_COMMAND_INSTR(0x22, 0x0A), /* BGR, 0x SS */
+	ILI9881C_COMMAND_INSTR(0x31, 0x00), /* Column inversion */
+	ILI9881C_COMMAND_INSTR(0x53, 0x45), /* VCOM1 41  44  45  4A */
+	ILI9881C_COMMAND_INSTR(0x55, 0x4E), /* VCOM2 4E */
+	ILI9881C_COMMAND_INSTR(0x50, 0xC7), /* VREG1OUT=5.1V */
+	ILI9881C_COMMAND_INSTR(0x51, 0xC2), /* VREG2OUT=-5.1V */
+	ILI9881C_COMMAND_INSTR(0x60, 0x25), /* SDT=2.5us 蚕22蜊傖25 */
+	ILI9881C_COMMAND_INSTR(0x63, 0x00),
+
+	/* ============Gamma START============= */
+	/* Pos Register */
+	ILI9881C_COMMAND_INSTR(0xA0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xA1, 0x16),
+	ILI9881C_COMMAND_INSTR(0xA2, 0x26),
+	ILI9881C_COMMAND_INSTR(0xA3, 0x16),
+	ILI9881C_COMMAND_INSTR(0xA4, 0x19),
+	ILI9881C_COMMAND_INSTR(0xA5, 0x2B),
+	ILI9881C_COMMAND_INSTR(0xA6, 0x1E),
+	ILI9881C_COMMAND_INSTR(0xA7, 0x20),
+	ILI9881C_COMMAND_INSTR(0xA8, 0x93),
+	ILI9881C_COMMAND_INSTR(0xA9, 0x20),
+	ILI9881C_COMMAND_INSTR(0xAA, 0x2C),
+	ILI9881C_COMMAND_INSTR(0xAB, 0x87),
+	ILI9881C_COMMAND_INSTR(0xAC, 0x1F),
+	ILI9881C_COMMAND_INSTR(0xAD, 0x1F),
+	ILI9881C_COMMAND_INSTR(0xAE, 0x53),
+	ILI9881C_COMMAND_INSTR(0xAF, 0x27),
+	ILI9881C_COMMAND_INSTR(0xB0, 0x2A),
+	ILI9881C_COMMAND_INSTR(0xB1, 0x52),
+	ILI9881C_COMMAND_INSTR(0xB2, 0x5B),
+	ILI9881C_COMMAND_INSTR(0xB3, 0x23),
+
+	/* Neg Register */
+	ILI9881C_COMMAND_INSTR(0xC0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xC1, 0x11),
+	ILI9881C_COMMAND_INSTR(0xC2, 0x1E),
+	ILI9881C_COMMAND_INSTR(0xC3, 0x0F),
+	ILI9881C_COMMAND_INSTR(0xC4, 0x12),
+	ILI9881C_COMMAND_INSTR(0xC5, 0x26),
+	ILI9881C_COMMAND_INSTR(0xC6, 0x1C),
+	ILI9881C_COMMAND_INSTR(0xC7, 0x1E),
+	ILI9881C_COMMAND_INSTR(0xC8, 0x87),
+	ILI9881C_COMMAND_INSTR(0xC9, 0x19),
+	ILI9881C_COMMAND_INSTR(0xCA, 0x26),
+	ILI9881C_COMMAND_INSTR(0xCB, 0x7F),
+	ILI9881C_COMMAND_INSTR(0xCC, 0x20),
+	ILI9881C_COMMAND_INSTR(0xCD, 0x22),
+	ILI9881C_COMMAND_INSTR(0xCE, 0x58),
+	ILI9881C_COMMAND_INSTR(0xCF, 0x2A),
+	ILI9881C_COMMAND_INSTR(0xD0, 0x2E),
+	ILI9881C_COMMAND_INSTR(0xD1, 0x50),
+	ILI9881C_COMMAND_INSTR(0xD2, 0x5D),
+	ILI9881C_COMMAND_INSTR(0xD3, 0x23),
+
+	/* ============ Gamma END=========== */
+
+	ILI9881C_SWITCH_PAGE_INSTR(0),
+	ILI9881C_COMMAND_INSTR(0x35, 0x00),
+	ILI9881C_COMMAND_INSTR(0x11, 0x00),
+	ILI9881C_COMMAND_INSTR(0x29, 0x00),
+};
+
 static inline struct ili9881c *panel_to_ili9881c(struct drm_panel *panel)
 {
 	return container_of(panel, struct ili9881c, panel);
@@ -1449,6 +1666,22 @@ static const struct drm_display_mode am8001280g_default_mode = {
 	.height_mm	= 151,
 };
 
+static const struct drm_display_mode txw700100s0_default_mode = {
+	.clock          = 78086,
+
+	.hdisplay	= 800,
+	.hsync_start	= 800 + 80,
+	.hsync_end	= 800 + 80 + 80,
+	.htotal		= 800 + 80 + 80 + 20,
+
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 16,
+	.vsync_end	= 1280 + 16 + 24,
+	.vtotal		= 1280 + 16 + 24 + 8,
+
+	.width_mm	= 90,
+	.height_mm	= 151,
+};
 static int ili9881c_get_modes(struct drm_panel *panel,
 			      struct drm_connector *connector)
 {
@@ -1609,6 +1842,14 @@ static const struct ili9881c_desc am8001280g_desc = {
 		      MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
 };
 
+static const struct ili9881c_desc txw700100s0_desc = {
+	.init = txw700100s0_init,
+	.init_length = ARRAY_SIZE(txw700100s0_init),
+	.mode = &txw700100s0_default_mode,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_VIDEO,
+	.lanes = 4,
+};
+
 static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "bananapi,lhr050h41", .data = &lhr050h41_desc },
 	{ .compatible = "feixin,k101-im2byl02", .data = &k101_im2byl02_desc },
@@ -1616,6 +1857,7 @@ static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "tdo,tl050hdv35", .data = &tl050hdv35_desc },
 	{ .compatible = "wanchanglong,w552946aba", .data = &w552946aba_desc },
 	{ .compatible = "ampire,am8001280g", .data = &am8001280g_desc },
+	{ .compatible = "tianxinwei,txw700100s0", &txw700100s0_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ili9881c_of_match);
-- 
2.50.0


