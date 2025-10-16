Return-Path: <linux-kernel+bounces-855516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D88BE183C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F2B19C340E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4E22A4CC;
	Thu, 16 Oct 2025 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY5WYcfx"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72677227563
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592586; cv=none; b=i9OGiqShkBnpLjWKGssb0IZD1g3+3HQJkaHbLwmObHt9mwoZ3crZP2q3rERxncwi3qd88zG8PZXXquu762gVvBw/Ip7YpX3gDkuYCDzfqaxq1Fx+vWCFg1bVUzHNtCKYyOTSowTrrMnAdeZaggVQohzH9cvvZRjubKz6s+4eWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592586; c=relaxed/simple;
	bh=kB8OXc/QEa1oiQz8AIhWoJHLEsb+VL67N9rALVEVV1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYlsRqy93wNpr+gSw+tRbwvcPAc93Oudpn4Df84CsDrcDiuRnjqbWo1JNiemzEgF4pFtFnMd2gARz4Ebfhjw1LsCyeZAGM0p1eYCVARKepVzzKLvYgh85wKHjV2s6euJIZ5qt0ut54Z3G6WYUHyeKUU2lzmnO1MjIOMHcrBgRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY5WYcfx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-793021f348fso342815b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760592585; x=1761197385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZU/PvsO/Y2NbI/2LYXn5EnCITnm++nCSaU9RCrcRDk=;
        b=NY5WYcfxVfJ2nMvpqf9XjoiV/glqzl+XlgYruEcuciA82grlntNmm6aZAjrwuZV91J
         n1mUTmRuXzOz2ekEA6xX1w5KDmcemXSBSREBX0WPcZpYSlx3JUUAmHXaME7dwytHML0P
         tqFm0aV1wH4uVGEkQuABnY6rnamXjjDVO2PRlqwioQxC3ZG4Hce6/JQnn2mVlMxDEcMv
         hiOeIzTyuQrunaTFkK/bnlwIMqGNWFGPL+WWZu0x8gsGaAKIxHZ8NLfq11/c6bjnZpSP
         WukweYfUL95h4ujO7JdjZWeYEZOj0vCFjcZ2inCnuIsls1tTFMm0KV0gUecB0ojnd1uH
         Eb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760592585; x=1761197385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZU/PvsO/Y2NbI/2LYXn5EnCITnm++nCSaU9RCrcRDk=;
        b=TKz7azyw6O4FvwyFG09zaQ5PDxqv9YUI3QT/K3ZpKA1rgmemneoxRzrV1m2nHVqdEF
         SztRxXT6CJ54Qq0N6ndDO6he2BvzSbyxXVPRdjdYMG1W7NiAnEcrYH1gRTRaAvYtxGtZ
         k2V3+Wpm3xKCILsIAfcz9BWM5PJie+sCQ1er7t+javuDvWC2/jH4fsjOwvo4UDlCCDct
         lxKQI5Lm24uJokD+sxWkkC3jdDMZih/WgtM0toNN69mMmJF+S1AEfdJIWvfRBPSTIwTk
         lrw/rJycFT27FnZbRmSye7ijaJl8kESd6UEBucUMScn4g94V9WH5+ZM6bfYi83bLbe3q
         w7Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVsSPt9bDNIjV01CKTj+r3Hqxf2+qctaGrlDW6ZgZzKQx1FtVbwJIZH0tIda9EW8yCHtH0vYrsfT45RuJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUoWNuUWC4taSQSAnPR+dtVd2aO3oz3s+h8V+Nh9ZmEFipSGX
	axIA+KfdMqzdV3wf3IpfqxOvipOaFx02jx5MEdvtkzZBdrxfnoMdTNMc
X-Gm-Gg: ASbGncsTVPsb0uthZN/ZYfEJztkITzcsmIAUSN6WWkvcih0EL0h/IxAeTFLGA42riZJ
	atTGtBs7e2tZESoCyEFUx2YCiJcOZ4Fh1zVgyMh8zQwUaZgRe3l/SJIbltMWrewI+J/KgoYAMTR
	I9F/ZTswl0rhdT+UPPAXePnBv0BYGD+5vZPqburO9oMwtTW2OSH4OVvy4QzuSnYPRQxriBPyyr/
	COrI4oR/sSAUKDk3t6Q5tKGZP+mxnYvZcsom+VsePrirsT7BdnMWVmJTZ0jMYptBaGfgd80De4W
	fJvFEb62u7L7+SAUQTyXpT8P6qo4lAbxLTKsruCzXzrEWX18NkukvUN+0BMauepGsLBSel79wPW
	Jymkrz/wP+XidxcRfkyl+3aCz6sHANnWBWKLQGCq2cZnQwhz/n09yYJgxeqOjmh1adILiNC09Pa
	9Sipt0vY83Qhsy+TV7ZLFtZi2N7O7Y87dS6iE4Z7MKfow5tvdjVQdnCSJ6WyHGxoWUOAmZSs83U
	AIJyipGKpn8dNQ=
X-Google-Smtp-Source: AGHT+IG6DkPdWX9xJzohk/tu0oSUnnb6SXO1oOB1ejn2LyoFqbU+fIA4QwSqj9cRtFoRS3F/p7/w/w==
X-Received: by 2002:a17:902:f785:b0:27d:69cc:9a6 with SMTP id d9443c01a7336-290273959b8mr383548325ad.53.1760592584688;
        Wed, 15 Oct 2025 22:29:44 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343093sm15742015ad.28.2025.10.15.22.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:29:44 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: bletchley: remove WDTRST1 assertion from wdt1
Date: Thu, 16 Oct 2025 13:27:27 +0800
Message-ID: <20251016052727.881576-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the external signal configuration from wdt1 to prevent the
WDTRST1 pin from being asserted during watchdog resets.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 24969c82d05e..abdb1562115a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -1080,11 +1080,5 @@ pinctrl_gpiov2_unbiased_default: gpiov2 {
 
 &wdt1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdtrst1_default>;
 	aspeed,reset-type = "soc";
-	aspeed,external-signal;
-	aspeed,ext-push-pull;
-	aspeed,ext-active-high;
-	aspeed,ext-pulse-duration = <256>;
 };
-- 
2.43.0


