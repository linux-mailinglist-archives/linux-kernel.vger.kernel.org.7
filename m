Return-Path: <linux-kernel+bounces-880232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D43C252FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B67004F5C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E634AAF4;
	Fri, 31 Oct 2025 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMjBar2s"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD035950
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915753; cv=none; b=IkyYbzswAZNFOqVItwUu89m3F4wkezH2mGnigW6eXLYRmjPv42qxOQ1IoQXuUPmKPJlAvym8E1Jqw2nFdGg0NVFBndeuY7HMg6+IdWGNkNA+UfUKSZO9YC0LeWgt28eXfgPuGb0hVMnhFPlIn8vnM7pGAGcDKgZIsSROf4SpPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915753; c=relaxed/simple;
	bh=mC8PFQiBgB01djBFj2JpH1pU7vb907f/6mCcztjN0VA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HnIlBcKFL+JCoKT99QBN1Xs1hsUalDLcd5ND+HunMviY8NmIh+Ct9RuCF4zbJDFDyyQgoPRC206549hmHujKpPDyathn2uce6YREjtWV0llSWNow69rrGl3sCVtX/YkumZwB93181rZGnzRawynhmyDYjMrk0FxcWyd7LFwrYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bMjBar2s; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47114a40161so25270945e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915750; x=1762520550; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FQGZCGnHsgyhdfpYgLWb8UhWYQWnOT5iNG04Z0iL94=;
        b=bMjBar2sjGpZ67mDCSasIkdcDoUpsLtDzCSsCBvnJh+/5pkoMeagd6uyFi/kTM6j8M
         ipju7lFDW9uLrE9b5yTj5LM/h4rf8Cn4vRmlnvJTGr6QRMPiHiUtjAx9J6v+UqohgrpJ
         ixD0CADgBIz8bQyS6uaWuPFyZhwlkmLW91ujD4Vpr6xQTI4+r3x1hwQ8wtBkja/32vdI
         c8KX6rs26sZa1Zec0QlzHfdi0Y6Mfmvyz6arq2m1B8Ikfm8mRM+/BisAivEDxoocR+ad
         6AFcClOZjl8hh7y471xtCQ1rfwF1aJRpRyO/00CjOtk4BSy6Iolwfc/MYkGSFd0U01PT
         DPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915750; x=1762520550;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FQGZCGnHsgyhdfpYgLWb8UhWYQWnOT5iNG04Z0iL94=;
        b=lhMp6jwU/CTxkIJV3yAxHeWPVebxnCWYEkI5LWaOjjBU9mnabN/RH1v2QlZ03l9sxd
         z2osh4S1WrfM1E5AMxE++5VWA52GAwRvfsQjTlvBkReBm5w5AuvtMtKkLvHgOaTi3EDt
         C7iE30T+fsALy5ZbXrHcQAdN7NqNdvILucUuGcMJF20QPTU4dog5bSyvy+9cUJ2qRA6z
         Qy2RGWKVgltG9WGzVuELYsiT4WlnCAnuzr6jEdk1YX0GSt2tt1CCrveo9zkkrjOrE5mT
         JCtMJV3R7BLwPmcFfcV4uJrMptJ7n3NJa3+CyG3pmDiG1E2lwpj6TaXzqDdocwdzLTYA
         tmEg==
X-Forwarded-Encrypted: i=1; AJvYcCWTSnOU2d+AaJlUQXS/CA2nvBJqTLaVAPZdMavoBLTFsrvV2Fwfah916ssYCA2/6d2jBF2u4qj2Mj95Px0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+xldsBgb71FSOKwv0FcymWlkw5LKoJoRdO7jghQdpDLrC8Sc
	E107wwslR2H9W2oKXofflr98e+PhGitG0SCP6LAFEyzCIA7iF9eD6sxBZxiWSTZ93XQ=
X-Gm-Gg: ASbGnctlaZTHRSTPXyFiEIHsv8KRncpBK4sXXlH9PZ/6XRWRvJQzUA6oazoZ1fmyFBX
	jYry7qJW0uOeoUpSkD3i6Yp0/EpLVZIeyrze6OISL9vnew0AQO0zw86sciGeYwzQ7EBUZGSm6WD
	P822EZEFfmyc1/7lubFFFzbZmlBK9GSj83KSGKIxCSsaMZPOe3GVgMZCfeh/Vuqm4jm5NzuoR29
	h+pYD/TwDndEbrFlQDBQeNiBZ8c2DnA9OHj+dBe5EXnSQaBcv8TtFGjmhLaaWPxGVw/TetQW047
	6T/SQrhvMTRz97mNILff2zLjus8y+pG5I7Tk6Lzm/CptB/PSNPuaRZzJnjdXIuvv0rr1sievH1v
	QK5CCfQUVqMdFsqV1NyHhlSaioFV/9FAU0C1ovOYjPG1G4nv1GMRqVr0eFj0tx/Er+xY5LIDsLb
	kwiltILQ==
X-Google-Smtp-Source: AGHT+IFtOV4W0Y8ZfIuQZW9gadDZKRpyQvtO7XZin6e2iW2zHXOgFcxmDRDXqGF4RU8aG0zT2NZ4TQ==
X-Received: by 2002:a05:600c:3149:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-4773089c4a1mr29545645e9.22.1761915749827;
        Fri, 31 Oct 2025 06:02:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4772fbc32d9sm22667605e9.1.2025.10.31.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:02:29 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:02:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harry Wentland <harry.wentland@amd.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Hamish Claxton <hamishclaxton@gmail.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Michael Strauss <michael.strauss@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix logical vs bitwise bug in
 get_embedded_panel_info_v2_1()
Message-ID: <aQSzYV0ytfQK2kvN@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The .H_SYNC_POLARITY and .V_SYNC_POLARITY variables are 1 bit bitfields
of a u32.  The ATOM_HSYNC_POLARITY define is 0x2 and the
ATOM_VSYNC_POLARITY is 0x4.  When we do a bitwise negate of 0, 2, or 4
then the last bit is always 1 so this code always sets .H_SYNC_POLARITY
and .V_SYNC_POLARITY to true.

This code is instead intended to check if the ATOM_HSYNC_POLARITY or
ATOM_VSYNC_POLARITY flags are set and reverse the result.  In other
words, it's supposed to be a logical negate instead of a bitwise negate.

Fixes: ae79c310b1a6 ("drm/amd/display: Add DCE12 bios parser support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Please note that I have not tested this.  It's straight forward enough to
see that logical negate was intended, but it's always good to test things
as well.

Harshit and I only recently created this static checker warning.

 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 04eb647acc4e..550a9f1d03f8 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1480,10 +1480,10 @@ static enum bp_result get_embedded_panel_info_v2_1(
 	/* not provided by VBIOS */
 	info->lcd_timing.misc_info.HORIZONTAL_CUT_OFF = 0;
 
-	info->lcd_timing.misc_info.H_SYNC_POLARITY = ~(uint32_t) (lvds->lcd_timing.miscinfo
-			& ATOM_HSYNC_POLARITY);
-	info->lcd_timing.misc_info.V_SYNC_POLARITY = ~(uint32_t) (lvds->lcd_timing.miscinfo
-			& ATOM_VSYNC_POLARITY);
+	info->lcd_timing.misc_info.H_SYNC_POLARITY = !(lvds->lcd_timing.miscinfo &
+						       ATOM_HSYNC_POLARITY);
+	info->lcd_timing.misc_info.V_SYNC_POLARITY = !(lvds->lcd_timing.miscinfo &
+						       ATOM_VSYNC_POLARITY);
 
 	/* not provided by VBIOS */
 	info->lcd_timing.misc_info.VERTICAL_CUT_OFF = 0;
-- 
2.51.0


