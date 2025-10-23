Return-Path: <linux-kernel+bounces-866867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ADDC00E31
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7243C3A7B48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753230E0EA;
	Thu, 23 Oct 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pa4OzDTF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07630DEDC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219885; cv=none; b=tLDSQH7HbaH2Z1xRNYEYAUkmEIMqC/8WXaIO4qQY4dYzCSEnh7aqRoGjP412XvGPqXn7ZmDDpSdPEhZIbHSGHTbrweZAWmMB927odOd/5KtVXEqR1/MmMyCOkuLkqBMu2FPeAvcA4qx38HKwbF/AaKM7xzglbZnh6l2WNOnr7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219885; c=relaxed/simple;
	bh=7BTUf4I7UAyyJBU95Aw8mfxBH3NdumaLSw1nC41XKIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCsS8ah3u5FTYJN0VtUE3FvRcBUFcHQr7WLjQndAuG91VphsBK+Hm/t2M19eSRHea36KsDdH1VD7cAn3I7cRzqlOVM5ueQadpTS58qWQp6lqMrWa+uK7w1NzoCZROZMv1BHR1uLqtwJsjvGs/z3AL3r51rFojQ2WCyEg0pJicCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pa4OzDTF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-58d29830058so453923e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761219882; x=1761824682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qszteeIIfZdimRIQpgCn+/pEks4QjoflEtrgND3FgTs=;
        b=pa4OzDTFCNpw/Til+jDpAWaEn9tPBf36NRSP6BWTMFH5JPYVvgdQf8RXuvojdpzKyD
         uaWIBArDA8XITIRbDWlcQoYid9eLrZN+kqEElsO/OlOT+Dw0b189q1H78o04oloDwJmH
         FcG8BaTnv12hRzQJj2CR4wQ6VqhjowhoCMn+kSrNv7WO59er7v97vC1T+g+MerR8eKi0
         bP/ol6mm4YvDd3E40aSwrRczTJMusYAJOFKzfxGFm9p24xnSvFmuy+wfO4NmguD9qFKD
         XeLwyz3TFIkfwc+rmB2fZJRFI6s/vGLzfaNiMlin+ZaqAK6FAi1cPqMBNCh7zDWb6V5a
         KwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219882; x=1761824682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qszteeIIfZdimRIQpgCn+/pEks4QjoflEtrgND3FgTs=;
        b=GoRKUJMDOvO8KEUm4rqnVeByYUT0SgornJ+rTJ1xDa5vpIF8KU7Gp5nEPsknxthaSQ
         H+7yfMEgHAQO7/37Ltr7ofoLRSBTNAg4jvuLfS/06x1VFyXy1AHrqOmLV55keZDlnKfk
         IlalKIPRZJjlHIk8U3oNJUGAryH4lvHXuWy+/au3gWevG07czzQChDkWp39tx4Ss7PmF
         j2GVSdzB87ghLRHzW6/0zxaH1fMvgPLu+coQNzZ3c+ZblyxQvcH+aq61aPCK7orfYmbu
         4oRoSEINczk9tOzhVQi6ygdfw9vEPs7AY7bPCX1Yqoy99a06Jo1+h5oMt83rTh1UNxFW
         lEkg==
X-Forwarded-Encrypted: i=1; AJvYcCUiWP6CBXyYMVAAaojrB6oCsgDCVIft6mpzuAL3Tf4wonMQcAN4VfY1Y1Er82JDNEQtYLI+iqAgbRj5lfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWEI8E91uT+Vq3ws2nsMtDiaYi0QRcnziDVtP3JOI1UGQ+1Rj
	crQRCIC3LgcaCWe2QUo8wYGhwujYKBdvFGYl9MSf3ufGI7oPwdFo2vPJcilHxzxiK9S76wTLLaq
	1HV0h
X-Gm-Gg: ASbGnctc+AqOz9fX2LZvQVRorD0+rMeG6/4rEJkG2sg1htHPCBuJPnGlPYsgJ+wZgD4
	YvAfw97Q3x60lFfeQNU252zv9flBB230naTwWn6RtWqaQxT02V1GlQpMlOrmFo8qjnwXGrnpodz
	r1FjyJHz9ymCBRjuTVyf/9LJ5z7wnCXIsTdx2ZEFLMnvTSSkj5AFZ2RP0AvQz8LMIHThTaWFSr5
	KjUoXi46X8SYwUnVfsE3qzfdx5IFHAoSYPwzDaiSt2iP9S+3pKWnAE00mpomTpQvV7Ax+cSubaf
	Dw8Gl9PDJ+ij8uVBK2NTDqWHj6XKa6ZX+C0u5Lvzi2c/eFEtV7ECFqNImX8H0r/A5eWFfSynW0R
	zAoYAqRNidCOKh7M5rEK6RHaGonxzLUMrLeWECTw9ZxOFQ8sIHRNmuqBunFQaWKJFQeL4TkGUrW
	Pq4sL6rgIqySdqNbCdDfva40vS9yFw/+CHro8G99u/i/HJw2wMTrMDuInMtiXj
X-Google-Smtp-Source: AGHT+IFbZ8ea+fRAWMZHdLU+mWJ2Ags/jNDklnyMrW7cZ1hIy3jawsjZE8i2C+6eDVs0jg2Q6h0Kww==
X-Received: by 2002:a05:6512:3da8:b0:57e:f60:2327 with SMTP id 2adb3069b0e04-591d85665e1mr7456130e87.49.1761219881746;
        Thu, 23 Oct 2025 04:44:41 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d1f26bsm687596e87.77.2025.10.23.04.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:44:40 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pmdomain: mediatek: Fix build-errors
Date: Thu, 23 Oct 2025 13:44:36 +0200
Message-ID: <20251023114436.185320-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's add the missing header to fix the reported build-errors.

Fixes: df4e9ec1ed86 ("pmdomain: mediatek: Add support for secure HWCCF infra power on")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510231317.ZZxNaFG0-lkp@intel.com/
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index ac144ab8fce0..164c6b519af3 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2020 Collabora Ltd.
  */
+#include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
-- 
2.43.0


