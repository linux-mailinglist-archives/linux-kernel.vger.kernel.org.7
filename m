Return-Path: <linux-kernel+bounces-748793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70C8B1460E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9971AA06A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964201F8725;
	Tue, 29 Jul 2025 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDptUyDB"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A99635;
	Tue, 29 Jul 2025 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753754532; cv=none; b=abeWWd2JmcID/SmUt6DmORvYH/wTja/vcqMrQLrPizXBXWCB4RKtLOoAQp4qqIvciIsIree8XAt4Z1P5kvCrIDqAvn9S4Y1Z6rNKDtYpd+NdpzbD6tNr1QN926+lQeIDYJ5RZlMm/c0iaCgaeEDhdIyvFtG+5LzdekUHl2oXEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753754532; c=relaxed/simple;
	bh=1KslsYIC/pYPSmGPEi+/fwRyoMspqFb8uaNEbRRDJEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKoGBJDxmoy5iUNwp8Grn8uMkzErc7ZpMchhwLzAZBEQj7ogDln5xe6tGcFkvdMAb46S3NWMhCalwfU61wHyNwDFN2dpWZ+3M2szh4ZQzZlWtAHkU+9wLiUICbW6omBzd9EhuRI28D45dFpAjJ4Klaf67D9q3pfeuNTCd8y+BG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDptUyDB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2ffa1b10918so2866729fac.2;
        Mon, 28 Jul 2025 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753754529; x=1754359329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEeZXXxE8pXnqG0YImoNpmvGHhhvN/xzySIEmSbgUno=;
        b=SDptUyDB/ef8jGtWrPKYgKODnNVxDVkhnXBmIZn7vJOpkp7+sKxSxeaTgoWlZgoJ2c
         63lDfwes01Iu/hrH5HmQpqq3m+gNsh0Aw8DuWgSqJMMnaS2bpZtb84UzdugY4iJhb/cU
         stUhvesm0BEKJdFSDsW7oHSuINRtH5MCLBuIcYU6gMEgPn+EnfdSiE73oWLxBHQ+31Y3
         huAWfYRIXOKx7tcODviRzW0DXSRpq+DX07pZUYx92dGngjaSudJnzqNnnEgaDK0Pr37X
         GfapZtFdFu0Bv36cFFsQkTDhY4lqbqh1HNdPMKJ8VxZI8fnhBoigF8z2fWnxjIotTJRl
         P/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753754529; x=1754359329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEeZXXxE8pXnqG0YImoNpmvGHhhvN/xzySIEmSbgUno=;
        b=sjhs7JkOEp3p+Dw+z3RCVLzY2ZmJ2gtcEPsoQVaHKS9kGrqIiXXbMpjx2cLI/fbctl
         mDt+j1HfaGq4Fe/bQ2ydP/RmTlABQ7CCqcernITZ/PX3KLpMtMU9fdAr6vbxFZpInqqN
         oeO29oAnwS/22WInMnmtSQbHRxFtBc0SirEXz6pwPv6PAPRNOejIdhV4Y4T57537YpzG
         cvOfYuiaPl25iYJDhFfKyK59Pq7yT6Dcp4ZITNZG70NE6cyDB8bvvQRGlibARL0WU1mX
         /VUZrpXJMsOxWSYAALbb6ZfnNFJMPq5si/puWm+pE7EICErRIXrFN3utJOsulbH2TeCk
         eiUw==
X-Forwarded-Encrypted: i=1; AJvYcCUCojKyd8lSiYvY3iq32jWn7B6t4xu5hb2pTmJ8yty5q0BJesXSR4B5RLC2/ADoNtKImbgq2ZR1nm10ifU=@vger.kernel.org, AJvYcCUoku8QYjAdbvz53bFHCyeJW+DRv90KiEW6to7myPeWYWqH3EcVhYJzVVD1gnlKmv7jG5TPVincAmcM3Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkEvaxGf5upWxBTZWYRYko4WJb8I3tMG8lbbrcP1qQLqLL8AE
	PoAteY19uH0dnEAPUEEAaY9mWlkBJK/d75ms1zQEpFO/7ty0LhCYAKkgkmt17yN0qmU=
X-Gm-Gg: ASbGncvpgqVer71plruzTuhHGbAr3YTf7pfjIMY2wwQg49XvemsDyYPB8/UaYgHNN2b
	rMI+46bCCI+9VI5caNulgywpkXfDkOgCjf6WV/EsKGTEShglWNLc7QPPNgFIr6LF5LH8khxLJIa
	eqQFk0otS5mQweTeWWaCrPryJjIAaPBoJ1UvqZ+leR81a4jGm6p7c9eyPTGkHQ0oHnZ3mz2t7+G
	2Z+2hEPGV1k0HrsWup4w5MRDCdI/V0ii37tbQYUWCFRB3HKNB/NAMN0jL0TKhY+04LwPdPi/9CT
	jMaCC96gpV1+Fs4ppWf3V56Ux2D7uxJYlbpPpOgJvrLsvk591WXpcXTpFiNN0iAWDWZ4f5dig8D
	yLLnTgNYG4iiVpG/lel5w0HBs
X-Google-Smtp-Source: AGHT+IHOw30O5Z7jeXCpP/Gpsx4e0WuD5rBxHCXsw90edV57RFa6IsOd12KYHPXG7J73ZnyfU7myhA==
X-Received: by 2002:a05:6870:1b83:b0:306:9f8e:6699 with SMTP id 586e51a60fabf-30701faa8b5mr9069467fac.30.1753754529402;
        Mon, 28 Jul 2025 19:02:09 -0700 (PDT)
Received: from s-machine2.. ([2806:2f0:5501:d07c:e094:d952:816c:c6a5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30713663c67sm2001746fac.31.2025.07.28.19.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:02:09 -0700 (PDT)
From: Sergio Perez Gonzalez <sperezglz@gmail.com>
To: olivier.moysan@foss.st.com,
	arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: stm: stm32_i2s: Fix calc_clk_div() error handling in determine_rate()
Date: Mon, 28 Jul 2025 20:00:49 -0600
Message-ID: <20250729020052.404617-1-sperezglz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

calc_clk_div() will only return a non-zero value (-EINVAL)
in case of error. On the other hand, req->rate is an unsigned long.
It seems quite odd that req->rate would be assigned a negative value,
which is clearly not a rate, and success would be returned.

Reinstate previous logic, which would just return error.

Fixes: afd529d74002 ("ASoC: stm: stm32_i2s: convert from round_rate() to determine_rate()")
Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1647702

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
---
 sound/soc/stm/stm32_i2s.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 0e489097d9c1..6ca21780f21d 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -469,11 +469,8 @@ static int stm32_i2smclk_determine_rate(struct clk_hw *hw,
 	int ret;
 
 	ret = stm32_i2s_calc_clk_div(i2s, req->best_parent_rate, req->rate);
-	if (ret) {
-		req->rate = ret;
-
-		return 0;
-	}
+	if (ret)
+		return ret;
 
 	mclk->freq = req->best_parent_rate / i2s->divider;
 
-- 
2.43.0


