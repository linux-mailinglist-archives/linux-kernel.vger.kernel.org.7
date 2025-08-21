Return-Path: <linux-kernel+bounces-779907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC3B2FAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC581BA048C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825FE341AA5;
	Thu, 21 Aug 2025 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOHWCwc6"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53534166E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783355; cv=none; b=qIO5XsgwbSftfLRfzluxuYlFCrQ0A/4XnLzkhfAmGGK6jySlwOnaGKjEYmQ9HVDFPEewXQ8a4ABCdoLwWnQ5btMwrrfelGN6AU0ngQHRFCYxqyEV6/mxwfncWpw6FAWQ8NfkTdbZgFuBuca8g4GnJ3zzsaPqBGjQPQx+tnLnf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783355; c=relaxed/simple;
	bh=ciExmzo9EJPLx3gD5Z3HNVmu1olV2ONrRUp+sH5Nk+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pg30LEL9A8rpEqupxMJet3+GR2qYFFb3iOqP6HlRGIkdvdz8t+SC2Up/vzA6ixbepqy8bIymZyXYzlBNT/Xrp2d2RmiLI4GnTVYVSeus5hmU1wVkHXPdUcU60wSa/A3cQEXYDHL7G4j6SCSrVwrDwn4IgMMK0SpeTI7emnsSS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOHWCwc6; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b9edf2d82dso519609f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755783353; x=1756388153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8nelKIncwI/x1u9VaIkU0iKbGn5Mrkkuwzjfbier8s=;
        b=QOHWCwc60G+i1qxKSDJWZ6AtbRoMX0Xl4V98iyiQ4gm3qPk6Fn7I7/CGzPKjWE7bsY
         z+gLrex1PwTlDybhB3MhX30PZKrp7og60ajLi4Kiboyr5ZR3vryBM9c4scB0dXa5NyHy
         X6eslojGc3w8u59aZGMR+0sXB1cAc2tYPM2qYA4RbHEJzi8LnhxqKdqUESJArriLjpu1
         kFMh6t7v2aVJjB6desU1xQY8zxH+DeaRYIL2EYXg6bjKw5JBPjp0sr/MKUzsytGNYYCm
         IWa1XW+HarvJ6TKRAO9+FTCk7D7jHvt4ZZz1AzZN6p6cUeBFQlw9/FrnZppPJPEWali5
         asmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783353; x=1756388153;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q8nelKIncwI/x1u9VaIkU0iKbGn5Mrkkuwzjfbier8s=;
        b=XdIuKUXaok0UECUcoHz2fN1RWR13dwYkPSHmla7CLOH+AbtFrRmwuu1/aSKKPU2vWM
         UMexM43pcuefUDytgVsUpvXyoT1f4krB8U+3wBUsZdwiTGapbmS+V3jFB5LvRFjPylYP
         qsQd+8tSQAVc+YcyUKqItH1P8TOikAEsFRp3ZUuBSy923V26KzxsKW7asFYjMy8bNqlf
         EQtzhCNwntczUXdhthJ/fBweRIlrMcnRjbnrE2HaC/zhzQ1j+uPUqDwy8yy18xRLhK3C
         gtY/T9g12XORFHRfB3PecroJk/B2Tp5zsObXugUovjvWblw7kKGVSf8IHGuJr3cRYnT3
         bNcg==
X-Forwarded-Encrypted: i=1; AJvYcCX1US1/2DITQvaz0d8VPzSuKKAv9oxswXD8WIpm1rFWXQvrCs8jKIAMby122ct+FIl1ehFdcdSJ60TIYzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhQdot2hEDSGhClurE5VCnuMusUpei0xsJ21CDrpfe8wehjlI
	QaHquk+AOKvsNTuh0J46UNOR6DSFlBGMhmZ+1fHK6ROaWbVkQw2eTNi3r1fMuqho2uUjKOD8H+U
	rvQmwdUVYHA==
X-Google-Smtp-Source: AGHT+IGoeb9qMtnY0byB8qbwt2AQUvSpswXowm/lbVJEvWyPvIRthWMZy0Z/kNnivC3EcOI5uD+SgMqANpxc
X-Received: from wmbhc5.prod.google.com ([2002:a05:600c:8705:b0:458:6799:d779])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2387:b0:3b9:16a3:cf9b
 with SMTP id ffacd0b85a97d-3c494fc64a9mr2439269f8f.5.1755783352693; Thu, 21
 Aug 2025 06:35:52 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:35:21 +0000
In-Reply-To: <20250821133521.2665734-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821133521.2665734-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821133521.2665734-3-abarnas@google.com>
Subject: [PATCH v3 3/3] staging: media: atomisp: Remove return from end of
 void function in gdc.c
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fix checkpatch.pl warning on useless return on the end of the void
function.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc=
.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
index bd44410729bb4..0906f1d1051b7 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
@@ -43,7 +43,6 @@ void gdc_lut_store(const gdc_ID_t ID, const int data[4][H=
RT_GDC_N])
 		gdc_reg_store(ID, lut_offset++, word_0);
 		gdc_reg_store(ID, lut_offset++, word_1);
 	}
-	return;
 }
=20
 /*
--=20
2.51.0.rc2.233.g662b1ed5c5-goog


