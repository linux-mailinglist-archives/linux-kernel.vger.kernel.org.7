Return-Path: <linux-kernel+bounces-813457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F8B545B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF164AA2D93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999718A6AD;
	Fri, 12 Sep 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocFZuqaV"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA6F2D6E43
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666502; cv=none; b=M7tHySnum4fFrvBITd6k4h28UCbyzuAsbeBnmlLRJUhH0UrytQNHDfuWlV8ulS6JCYe4OQveBCeCbEqUITL2S4AXbesDJCI1ZJ2wbHGTw48nUsuYjMX0facMaAUveIFicDwBxMTGZAGTDWef95ypfxxDmoDKGxS2XLpQdKBnlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666502; c=relaxed/simple;
	bh=j8WiM1AwcmR4UKZ24HXYJnllvBCh9jUhE7SQfdx0nG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTMNIuIypA96ZJJAgrjjnF3gFCU1jD2s5QEdIEoiHWcyoXkcoQ1uFbbOviOgp6UezzTbe1kPNRO79HkmlIforvvBPipsicrtOWubSdqyhfOerpE2ps6v1mBu03YWRs0gtRSvBurW0wBENRPi4T1nZdNdJW3hL0TePEs0jTn4y9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ocFZuqaV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5679dbcf9d8so1412122e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757666499; x=1758271299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi9mhYSrg+uoSn4FWmIZqdjd0t9zWFL1Q75akd3T2yM=;
        b=ocFZuqaVuwx3CVQKWQlJc8PMRi6+FZtfuDsu+irA033g+kqDpI1bFxPi8Rp7QQKnRe
         9fsYpedxzehIyuLl+Cv1hTDLQq9+fZAAxXEloJrp3Ms0gMIKrpiQlRUmkiL9t2j8uc4o
         epE57ExvvH33JU3XAkyjEfcbU8iFOVml8ClCKlHU1jEkL1iNiG3pYq8uXOLSNVdcZ8J/
         x2z/Nuclrznfo93BSd1Am3Uhqq2RwZRvfRGY2oO54lNkQbzQpEtoNoAsAttFE0GGbahA
         AIgl1tdCIg/SYd8u0xCIUSFTFBdiaaxmVKCidLfEQvhW/fiAiAiFVYr35RMNuXTgFmqd
         vKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666499; x=1758271299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zi9mhYSrg+uoSn4FWmIZqdjd0t9zWFL1Q75akd3T2yM=;
        b=RC+5Cky54OylwTTR0C63dqm/P3KXXuDnrV9Lmgkc6k4lSQXZt/BhqIENTAuAwVwknT
         2WpPTJsjgNpEvtDuIPHEkXmoJy/EU9RnO46Hq+cMy5KKYIB30Eguq6FStXjJ3lSqsVY1
         +Bj7qyMF6/10L0rHoeaP0ImVOQ4u6mlV/Gzo5HfpgZezpaaf69nyBNCijmleQ9fzYFak
         VxIdJ8caf9U9ttww3s5aOAkuN3+ncgnfDCb3xFHobPT0Jw16VsoypnYeXOTXJ+DHbJVU
         TTO+NAyvSTSTHOej6flbN75VVoVLXDCg/v3yRQr3XtDllDRFUGbKUW3mThn6dPkUwxlm
         Ym+w==
X-Forwarded-Encrypted: i=1; AJvYcCVh5+W3Y/ddip071w0Bcqp5q3jv+3NzLpAEzDwT5pcyE3szNGxSpKTP4vsqz+/YkbcuRjQdTL3l6QH9FJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbh1hXMaa0UTncOZr3E/Y+Fp7BLC2mlyL5lc/BN9rGdq7E+2b
	q4JWwbw/hWbxBMuvT5RCW3Aw4n6r6NCcvEX5laSEZ94gR0qUX/s4UZvZZuEiKi7S8M8=
X-Gm-Gg: ASbGncs8Lj4fPL0By9h/IeEJdYshGZnyM9JdNDTdgqmmQU27rGg/9nTAEe9h4X9gNAs
	vMsfkxLtxJPfWmSp78JzaEcAs4q85q1f0XH+vjcW/N715pW9RwRV99CDAgEFSUf/rIRCHzM3HTz
	WAcy4AZ+Wxo9M3etFITFdkJk+XBvel6rNJXl7GL/apt9nnktpSPcJTHfinYjPsusWlg8mjPO0Wo
	4rmtEPDpwHTOc4O22Gj8X8xw0PIhpHR1JISLJ6I+HVKh6lV61UxXeynTYz+CpbAyu63Ts6NHLZi
	oqLQZoH5DfBFiJ0KSGZDu1alVaazvWPawxLkma4lEqZSpy+C1SF2ImBMuKvDwMOVS8DiVpppq2o
	un8MgJSsJlcJmU2rYu3YyK31DVXXniMtOu7mYP2IGCPTEm5Nlor+l9T0N5z87oZmlbw==
X-Google-Smtp-Source: AGHT+IFx7Iz5XF+xrNLJkCkiosSOnrJ09CXvrdjTO4FZGsUjEDPPR94YYqvJ/Qo7O7hEYIQNGxSzOA==
X-Received: by 2002:a05:6512:3599:b0:569:a257:acca with SMTP id 2adb3069b0e04-5704f1ce7f2mr581298e87.32.1757666498725;
        Fri, 12 Sep 2025 01:41:38 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63f6csm989050e87.86.2025.09.12.01.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:41:38 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com,
	victor.shih@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	geert+renesas@glider.be,
	angelogioacchino.delregno@collabora.com,
	dlan@gentoo.org,
	arnd@arndb.de,
	zhoubinbin@loongson.cn,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v2 2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
Date: Fri, 12 Sep 2025 11:41:12 +0300
Message-ID: <20250912084112.2795848-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912084112.2795848-1-mikko.rapeli@linaro.org>
References: <20250912084112.2795848-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Heiko Stuebner <heiko@sntech.de> all SoCs
since 2012 have power domain support in HW and
ROCKCHIP_PM_DOMAINS should always be enabled.

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

v2: added "select" for ROCKCHIP_PM_DOMAINS also on arm
    mach-rockchip as suggested by Heiko

v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b7855cc665e94..37f1cf38a010b 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -14,6 +14,7 @@ config ARCH_ROCKCHIP
 	select HAVE_ARM_TWD if SMP
 	select DW_APB_TIMER_OF
 	select REGULATOR if PM
+	select ROCKCHIP_PM_DOMAINS
 	select ROCKCHIP_TIMER
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-- 
2.34.1


