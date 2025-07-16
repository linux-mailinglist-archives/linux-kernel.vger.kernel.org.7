Return-Path: <linux-kernel+bounces-732814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF9B06C59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E091AA7B02
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A927511F;
	Wed, 16 Jul 2025 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBHF9sb/"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A751F2BAD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637091; cv=none; b=rPYt79cYzHqjjeeimpQ85hF8eCIQdhUP/abQ4GI7/59qsOnHj56wbqBlar7SpeQyDf11Q8FNv59uBkwS6JLDM6uK6I1m5dvgPwafNZIsc0MR2Rumj36+bIcwqNcF0TlDRRDyoASVxNUMmzbwZCnhde6Lcc2QejuJlbuNnFpN10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637091; c=relaxed/simple;
	bh=9fmm5M55Ppy7CKgsyBOqgK6g0dO78d7D3fbfugO4hzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDumd83ZyZNGySIsU8hzJhFA5D3rnqizvj6wwgKkaqcaNk6ZzOlOd17OcwGrzZPAC+mSSzMCwBwCu1WYxCZs2zieBjCu6nOuj0sNfpoWUd55OvSXAwmuZDqh9eNS98s1avzgfTWHyefnysdywlGNr4tnIi32RJRW2CpmHeqQtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBHF9sb/; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2ea08399ec8so3859148fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752637089; x=1753241889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyAgi04IKnPOMF045RBHfSOBtdrD6l8/VwYx4LR0WfY=;
        b=ZBHF9sb/XC5xBMcUfEMjTMUoZkU3C8kMtxwC0FKJ2nuTB++4guthewsIAwcGH2sIU/
         8g8oIKDgRgAU57XALLc0dBsLwUaVyLtJ822ZzeaUAQvrbwslrqPwY5Ed+ldpU8qoHyOx
         ZMyMelR3QdsPceT2ngt9rLOap3Naun8UIEgKGDPe8zPimbo6/VwTMzLhyj/vhTIsxeem
         mSiIcNOw/bFN1K+DuyPwvNLfk1eoNSd/RD71mms2WgEPGt/IpBsjaw8rWjutcvmdnW7g
         +htscYF1zI1yegriK1DmhmuiipSmvPez8REfJ6rkxYPVmImdhQLhfW1KMc6qSPwivtNV
         lV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752637089; x=1753241889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyAgi04IKnPOMF045RBHfSOBtdrD6l8/VwYx4LR0WfY=;
        b=DH07syTw95tCUi9hV8k+s7visUYslTBVpd0WdMUnv0d0ltqOBIpTLACkUPMM23Vr9Q
         TjgkIQ8xfFWZSoSsqJ0o7s4+6ihtl1H2/M7Mt2oJXqkxvn7sNh5ZY97JMvJt/jIKa4tp
         e4HCINzi38ET5RjnB4sEbG/W8dE0E4Pi8dkegbkyRa6HDZBgZJbX1gQn4fSh0K2Ysu1q
         tvcK31dofZNU2xI+q8TMmOYgf78oW1jtwBRojMJVSvQUzT+xUHE+d+MjRk/4Fl8OCO6H
         5ooZJYBr8LTVJWio0p6ddHNjKcFSxL0Rt580DhKmsNrcngyCCmD6sqrK5cGxANqU+5VU
         ptcw==
X-Forwarded-Encrypted: i=1; AJvYcCWdjevA7ui6JLlRuOyT3HHJLaXr4yVT9ingVgHRVfEXTj1ICR5JvQDa+FyMQo7fprkVT+i0lPAdsjm8DYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkV9pdXroBwpOuon2KQQ84HBsvPOaA4cwUPSPjAAiMTZOJ+3C
	vyHbSMujNMQX5YjXm+txzzDVd+/M2pLTE7D8p6v56mvz4lYKMSdzNScE
X-Gm-Gg: ASbGncvUiuJLy1oyVPtBTvCv+0V2punBJFvFJTges1o4oJVH4IfiC8N7az1mQHFROjT
	WA8V/ksFaW+mjj5Inaruf5IWpwLZG6Kh33+z61iLtE7X8SfwZQeiflh0Iirx0NH8jluGtge16OT
	S892BcET6GVvjmUhP1+27iz5i3vV681eACFaYW3AVkrjl6S9S8zPvPp63IVe7unCZAoYndQ9cvP
	unpO0D/X5Hlrkk8UV7XhNey7OAvaxhoC1VZvqS23mYjXY0r7dry/uQWl2vDtKV/09Ha+WeAR56n
	OkWHDEL3uGizgGIpFogdXA+t5JCDpcV/w4ox0ln/aSC+CNuHN7LBEJTRssQvojKZRKs6Wec6Hpb
	Y+ki/HVb+t95WEB9y1S5v6qj43oD4W8v8zQyCYFiqXKtunoTVbhURPV1hyhXje5U=
X-Google-Smtp-Source: AGHT+IGQO3BKn2UcWw7Ik8pzXHP0U4Uv/SaDrxeJaOX3rFQLbMUuLy0SunGeQW2s8mb8i4Oejit9nQ==
X-Received: by 2002:a05:6870:5494:b0:2d5:25b6:ec14 with SMTP id 586e51a60fabf-2ffaf32804bmr1505309fac.15.1752637089255;
        Tue, 15 Jul 2025 20:38:09 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116d22easm3140980fac.33.2025.07.15.20.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 20:38:08 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH v2 1/3] staging: sm750fb: Fix const declaration for g_fbmode array
Date: Tue, 15 Jul 2025 23:38:02 -0400
Message-Id: <20250716033804.59650-2-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716033804.59650-1-ignacio.pena87@gmail.com>
References: <20250716033804.59650-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The g_fbmode array should be declared as const pointer to const
string as its contents never change.

Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca3..d3bce107f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char *const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.39.5 (Apple Git-154)


