Return-Path: <linux-kernel+bounces-895351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0EC4D8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FF9B34FA1A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98223587CB;
	Tue, 11 Nov 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2e8JYC7"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F717357A5C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862467; cv=none; b=D47vNiKYuj3Zu7Z+rdmBmyglqilBTOquGJxUi3Zq3TctkfVKR0nfbi96eLJzwl+TfP83/1lcFvgc3MtEHSEUwUyGn2bhhJ92pGTjZ42m4Avkh+iStwTzNmIeIrv5AfM3g3cgshhHU2UxmxD9shN87vEQRlwvNsu5g72EIfN9nbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862467; c=relaxed/simple;
	bh=d9dI3YFU+1DVibPHbzDPHydAzSLcAbh0IUfpmeR/ngA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXi5iDQPra57mfRzrrKsaukln+vL9HhnLIktHZv1EAtspLSZ3XDYJc4xOwwNXbJ19MuRiZpkwr5yP3Vljz93Iyh6IhqKpyN3RpELtrRppjigc0jwjRd04lsZnKofbsa7btCvXePEHjeXhk05ME5lSi6M79IIwk01NrvvtoxtznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2e8JYC7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b713c7096f9so596322866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862464; x=1763467264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2nMRTEYBnX0JEevXqRH9dgEagWBl68PRNtodA0SJ4g=;
        b=T2e8JYC7Ol9RB0R3S4cbyJhUCzjetRN/lohLYW3C01kWPVrLw236q4B2hk0iJHgTZT
         FDlHCJfknj3z/S/pS8gGQmNcUzEtsKb4/kZJktw0tYB+cK+pob8uvW7ApwqCPdn9rxgE
         4fRKacojOoaLbpqx4oGH/vOO7oqemL7S/L81uPDmrQF32EVCHjnam/0N4qP8Z0AzdrlL
         PXRtcwLKRUmU09or1bzwQUZXx6/mr7ELMAxNBcWsZ9k37B3/YxsJH63TK9ECJTNM1wWd
         S2y3MhIErzSMrKFg84Cu5H7flgHEjWd4D4k0Hjxb4kFdUCAXEMOJCiZL+oYFC5WRKbDZ
         JWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862464; x=1763467264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2nMRTEYBnX0JEevXqRH9dgEagWBl68PRNtodA0SJ4g=;
        b=NlWP0K82xow6SHWL4F3ID/B2RtQpXMp1Y4fY5XTVHZBv2PzMYDvmsDYFUcLze9CcMt
         mrvS6miG3GzOS9OeQUPL+z3qYwrCGFPPu8+9ct4YLCSQwKOvTcPqtpoW7kkU+LRS/AUK
         XFAJU2lma5Go4ldfuC213uFFx9+Nyq8w9b50eHxKav39JcQYDE8vrFB0O+RgieezCuJd
         Phj2zOCgeM/gTu1B2Uk8IhtIyRSJBDVcQZe4fL0qvcYXSAAUAA2OZ9moYgk+Ya8nJ959
         meA2ylJ5s9QN5DO1UQDQ/6bhfM30ZJYPhwcOFeG84NJTa2UqRL5TLfOTK38udkVDnWa0
         DGXg==
X-Forwarded-Encrypted: i=1; AJvYcCWYRGRhgqQebtwy9Jt6H7hru2VfcbgRfyUq6bE6XqSGnlnGmz9zBneIGe2SaIsbcQdmBf9sTrtVyJGvu1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZA7aVf3ccZbHqUMeERBTluVycWgOUaiCR1qZ8ogkQviWr5JFt
	dKp0o8LRUp+GYH7xNH3hN9EWEC5OyK5+dSwtaWxEapfoePvX2EL22+bw
X-Gm-Gg: ASbGncuyZvUVWbUm1QAgfWUrk8C/oBcgxdvK+B5C8Kc/rqKL3CRsGudzV4QJLN64tsZ
	+2GDWnoein8VZHZESbZqR2fhGEQxpm7tNqJ3omTx6NWY3F9U76Tik4SlyFQAaPkKzCKfSXHoq76
	ri5yURMG+PCokR0M4SbJkxewwjGV/ux7kP43jflQCoC0hCHdE8bqT6cKjAbkk76+EaV/mMJ8i4n
	E2Gkc8OtpFVSYDGkh+V0zS2ONU2GKTG/c4EcaPRAF8YCfMv3h/c2JW4rwFByUfuKstEI7cZ14nL
	4xsU7MJo9l+D8B3SmeklWXMe96IF8ekMpyX6izugwHiaU5YAiR4n/40Cl/PZsxGHF/9j+gYQ8Gl
	HolLg8IrNOCge5PtZgjGddEHmOGJn/YFYHUUTwLZ8vf29NLMwpHCO6puEv6SPdh7MAardd6lvuP
	tStpTTQNqvbb3/9Tpd0m+W5CrnRA==
X-Google-Smtp-Source: AGHT+IEMFjppQxmpKPUPuwI5Eh8CB/xzwrQb4iSasl8juRp6TAOQ7ALPukt/vhacoC4tWko/18/7Eg==
X-Received: by 2002:a17:906:ee8e:b0:b71:1164:6a7e with SMTP id a640c23a62f3a-b72e003924bmr1291166766b.0.1762862463417;
        Tue, 11 Nov 2025 04:01:03 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm1340707466b.22.2025.11.11.04.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:01:03 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] arm64: defconfig: enable i.MX AIPSTZ driver
Date: Tue, 11 Nov 2025 04:00:20 -0800
Message-ID: <20251111120022.696-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111120022.696-1-laurentiumihalcea111@gmail.com>
References: <20251111120022.696-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Enable the i.MX AIPSTZ driver, which is used for i.MX8MP-based boards such
as NXP's IMX8MP-EVK.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8d6a1bb1e03e..2db7d000aca7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -271,6 +271,7 @@ CONFIG_GOOGLE_FIRMWARE=y
 CONFIG_GOOGLE_CBMEM=m
 CONFIG_GOOGLE_COREBOOT_TABLE=m
 CONFIG_EFI_CAPSULE_LOADER=y
+CONFIG_IMX_AIPSTZ=m
 CONFIG_IMX_SCU=y
 CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_QCOM_QSEECOM=y
-- 
2.43.0


