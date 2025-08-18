Return-Path: <linux-kernel+bounces-772885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C841B298E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302B24E6E68
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288F26E6FA;
	Mon, 18 Aug 2025 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXVe0y66"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994726C393
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755494738; cv=none; b=JKMwKAJ263ibT99XeBmSgdgLw1mG9sr1n7yriA5MqSx0JJIQgLD9+hkSS65oWyPgXAV4V0nV/KU9cGuc1mEUtBFoA3z4mAQcrdSpHz9cSiSD/AoIfBFNuRuqx2lIK2FhxqpFPX9NPDQfSuGEGwV9akSS50d/MWy0PW1aA0yzvco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755494738; c=relaxed/simple;
	bh=dqxFEX/VL/2RWIvaGy2jWQ4m5TBIX+EXT4oXhAPS5rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZzWXa4uqM2Rrrp+iJo/p+cS2276R+Kx5zXNICT/T0mEUehz5OeH5nmYSceT05KRa6EBkKWGOCrq2AEck+clSkhfHNh46353F4onw2v7mmt11TdaR91Hdmy3PrS4rjHzuRPeNbKJylyZFF0eu+YAvwMlT2jVaPucaTpiOkrq1nBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXVe0y66; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so3903150b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 22:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755494735; x=1756099535; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWawdILeIQYq+c7F7VMxTWAdEGo7NrIDJCoccdr/4pg=;
        b=fXVe0y667EJ+yHGmn8n+PS7ixPxAT6MQvq2QFXUS7EHJmMFoAMYWUspoRW7Jsz2JWD
         XHOM8p2uOycaVi1UMmSPydUR4XzCFNguBgqjSHbMRVlzGViIN4p8eMy2efN4ZLk4shnD
         8XkWazC7NzEodMBpghALIe55XLO1L39MZEG8ISMT5HjNMN/2eBWQ90QRrbcckCl0Y11c
         EmfW9LsWFc1lOi81rsN6xNKEnn3uYh0/N5LN2iPOtKuv/97Pts+EO3hf+wMSFgIDrcqy
         B0zCGrdkA4KYCgSDhXsE7/myDIQPB2M+cPvdyZshkGm4R9DpF8SXyQ7IMIgPGnJ19ebt
         mdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755494735; x=1756099535;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWawdILeIQYq+c7F7VMxTWAdEGo7NrIDJCoccdr/4pg=;
        b=ZhcDhoYpenSDygchquLS5rYwjdL+3ZP9+L4jk+MQJSMLYYN0hf8dIRAVfHy1+E6fnx
         bRgYF6rW8fZSK4rEPje+FxP2zafUTn9fW1Xgq0skxRRT1FgezH2blclFGd/tpf2fGnJw
         2N9+Guz26uHi47JysrTIddsS+iq2e/Q7C1DiIZyHYvkzeBnFao1JpNyfeM2a0dvQ763J
         7G7nguEdw8ZdmnwEJYGRUonXhalrXfCoXF9NXSzxpgageqHAfEOc2o0lXYsRymbEcVdm
         A6mcG0nQ6QiYfSlW9CuZkTpQogz71cuPL/zlieWGpX3H4mFA3ygQ33+TrIRvXZMY21Ov
         5bBA==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZYwdUHx8x+x+iK/vFwGk282x2808L6I1ikgGswnjUddU/xbQ+b0Fk3ZUvvsaLDfbA1BgG2RlkuIX+xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMw3s3kSHlHf1YHRP1OHYL9NL1cOfgUbCBYY9yApAjeq8oaEZ7
	XxF1PA/dR4PJ10Su+pgUpLdJU6GByy0GIxbss+lf3OPOS7/9ddDoFEDc
X-Gm-Gg: ASbGncu/uImM1RA3hPdLu+sJfwW1dHyAMZbsTm43AaaeeewUrFYrdWQt3Bvbo+DaU4e
	rfIQ5GmjhVRzc6Qoeh7bSJ5lqvKVPePWZ4jPMuXhUSI0u6FbW+M1OIgf3HHog1TN1y4ZrPCwGfq
	eL36/uGK225iS1n4tm9kmkuh3XY07iZRE3hfWa+A6eqboEQFAljpfsfDBOTmi8cHmP2zt1C0njE
	rNSJNXg4MJ2zU0THacy+l6Dat/k+exzJLeWbKKe1kdoy61JzuMcr908uowwA7kkUCOn77kCT8Et
	Hy9TzQsARlbmxyikK2MLEYiU2CYMQdPMWeLT489L4c1/+tnBj2A6wozW0QktVdnuANUMVHx74z+
	Fvtum/BNK+45h4uihn7qo
X-Google-Smtp-Source: AGHT+IFEyHVBPpUQu87+9vuJC5WFe8phvlVaAzvfFzSLbyBXhy6X9hQUYMGsk0Qw1l0OKlI2IokWqQ==
X-Received: by 2002:a05:6a00:1398:b0:76b:2c12:334c with SMTP id d2e1a72fcca58-76e4484fb5emr14190101b3a.23.1755494735185;
        Sun, 17 Aug 2025 22:25:35 -0700 (PDT)
Received: from localhost ([159.117.70.219])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e45289544sm6359629b3a.27.2025.08.17.22.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 22:25:34 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
Date: Mon, 18 Aug 2025 13:25:18 +0800
Subject: [PATCH] drm/dp: Simplify return statement in
 drm_edp_backlight_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-drm-dp-helper-logically-dead-code-v1-1-080f76699c0f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD25omgC/x3NQQqDMBBG4avIrDugAUG9SukiZv7oQGrCBEqLe
 PcGl9/mvZMqTFFp6U4yfLRqPhqGR0dh98cGVmkm17uxn4aJxd4shXekAuOUNw0+pR8LvHDIAl7
 n2Y0urjEgUOsUQ9Tv/Xi+rusP0Ma9M3MAAAA=
X-Change-ID: 20250818-drm-dp-helper-logically-dead-code-b99252fbfcec
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, Nai-Chen Cheng <bleach1827@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755494731; l=1333;
 i=bleach1827@gmail.com; s=20250730; h=from:subject:message-id;
 bh=dqxFEX/VL/2RWIvaGy2jWQ4m5TBIX+EXT4oXhAPS5rY=;
 b=2+mNW0078zBqQmEoPaN8PDrxmYaGLav/YPr7/2cybsMI82J15uA68Dbru45EQvNMjKdVnRWfm
 jq0pIurPudUCQ/8nWE39IT9aa1GCSUeber/mw5Eaz6aV2M6zoYOno4G
X-Developer-Key: i=bleach1827@gmail.com; a=ed25519;
 pk=jahFPRplw20Aaim8fIt8SxlFMqkHbJ+s8zYBGbtHH5g=

Remove dead code in error handling path. When drm_dp_dpcd_write_byte()
fails and ret < 0, the condition in "ret < 0 ? ret : -EIO" will always
be true, making -EIO unreachable.

Simplify by directly returning the error code from
drm_dp_dpcd_write_byte(), which provides more specific error information
for debugging.

Found by Coverity(CID 1649043).

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 1ecc3df7e3167d13636e194c4aab44ee8979aa11..b022ee136db2eb3b721ef918650525202dd22035 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4079,7 +4079,7 @@ int drm_edp_backlight_enable(struct drm_dp_aux *aux, const struct drm_edp_backli
 	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "%s: Failed to write aux backlight mode: %d\n",
 			    aux->name, ret);
-		return ret < 0 ? ret : -EIO;
+		return ret;
 	}
 
 	ret = drm_edp_backlight_set_level(aux, bl, level);

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250818-drm-dp-helper-logically-dead-code-b99252fbfcec

Best regards,
-- 
Nai-Chen Cheng <bleach1827@gmail.com>


