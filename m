Return-Path: <linux-kernel+bounces-895032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA8C4CBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 236BB34EF28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557DF2DAFBE;
	Tue, 11 Nov 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcnBwEyI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5F23FC54
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854333; cv=none; b=UmPPFYNeYXbode/GdGSC6BrGxffsvNDzAPDNcZMfsYx4lfNS75kYb7Lbo6zKMzu/vpjZeWo42F80M9uwopI9B+h5sAv86frbj2HQq2iuNCCnZqA0YMwMZ1vIvh+v94iOTPKDbltFhWqFfiPzNx4emu7+/32nAkKHJ5QTw1rFIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854333; c=relaxed/simple;
	bh=ckFH07UEJ/6Vn75EeCEfpSFArExjv65uHl/yV6y/LG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/TFFLaRIv0WYAKPbH5zaOGz1adPsxnvWVfvlBy/g7+WjJ/zXraucueXxVAYcu4mvwXqrSqUH+7DroS2jea1m5hxFiapi7E5un9piRLuc/PdEeSPbqlGW+LSb4pkrFYFyBlde5fHIpKu7WOVRUSq76gfWgqB9rzatskY9oS54ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcnBwEyI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4777a9aeedaso20114955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854330; x=1763459130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nmpwq9Y4K1E48WXNTAOK6Thjd08PZ+n1dzKkwN85Vb0=;
        b=dcnBwEyIX499nZtJX+koigf6Qa7Fpe/AEXxORFmFrc8nKDtJU4hZWH2OhK7QR2gBwD
         2y9+hUSl7bIy1JJL6XHIxmdldvNm5BH6ZZCAMQoLN4Qv6SxsP2+avPm6Y6XaH8aqTmUT
         xDMcMt8w/zX1+rZXHLZUxwl9JMb1BCXKve4LbzaXf1pXlFvEOhXd+Fft+nwIfWkiF30V
         sReQ75+BqfeAWfLDZLtLa6QNLIGpGlMujnccOUra5UJgWrtShXEBtszZgnE6Mzsg7TLa
         UAqEgm2zavsoDCksG1BftBptPduxPbxRtSIEo5QU8wcHsQG5PzYvkpxv9kIxMLPPkDJk
         scwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854330; x=1763459130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nmpwq9Y4K1E48WXNTAOK6Thjd08PZ+n1dzKkwN85Vb0=;
        b=iP5GEjCVUKtvlP+87+XW1ezoVlWhlp666eZzYRUSgesHun8s1bKmAcHTlvDrKYYwJl
         NMXGjMcifDEMZL0CYfMWSfxO3Z0Oahsd4FQaqNLWB8fFVzHF1E0somXqRIzHl0eavcxs
         tF3HK/J/kTPPFOPZhmYSsOPFiKYnU4+/2Y0hIUtX+gw+XAfMDS1b0baSyIoxGmeAnHBI
         ID7eVsgovkIMisNI/CC8ihyS3gTv6V/7tncDNQgwa20Muoc+ogs2sIGc51wRDOz31ub3
         HMd8ADCsPFAMQXx84E+bWDljszBqGXs84BbFs2vGJbJlgDwuR5DNcAMVP78MSREvHjdD
         Qoyg==
X-Forwarded-Encrypted: i=1; AJvYcCWwtXR9ssFRjyV1nObOtkZ0alGhLBFxEwMeW0X6S8F6d6gD7fbLfxLh8PgZVOmotytVwBcyKf4mLU2NAiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9mWOILZxvhTAvCnLGIU6vbzdTdvd0Gs2rLb4VQ9yFoqF+28z
	LLRlYvH2yb2fYunp7Yo4ZAlZ7eJbgUN+8IB9LsFsqriLCval+ChVcLGr
X-Gm-Gg: ASbGnctwxjHa/QEoZ/O+dFmiFx9BRdPOXVfIaa3NrGcSxRQ2is/b6NJm9bwSsDs8cZh
	y4y3Y26EhCqFE1gAD7/ikPdoTFpkcxQ2OMiF6zBfm/hJPehks8IpSe7HPriPwFILSoTUQZHA0Zk
	IZnkqk1QqysNDllGKWd+fOfzarE6g37bSzreOPxTpmcJs05gC/W8/Op6QXFAGcTcwX50sor7wTu
	ZonQkZ03uV0ZiBqE6kIS/HvdksOxEncRQGiQLHoKtkJ0r1OTFvOHRgNWsA22P9pGpRxrrh88jPp
	tGz6sHBgD3Rtnnl5zgNZ9Lzu1tbKMvZWfW7G7JZ7fkO3EqkhG/7uVBAlDGe6eIpIl8ReThO4x+N
	Hqrxr/wuhDOj2/plZcjwUwoeQV8uA1kPyDMOdHJXdKHxCKWNuYcT3MTsaWGZ6gnoABbE6F/KH0Q
	zbU3I2UEejXBMcE2sZ
X-Google-Smtp-Source: AGHT+IHWpS+03nTt0hf29otrjCs/XZ96klb6JhMRHtFvfD7GKW/VFisxIx4dRvm/W0bepZiBYm05gg==
X-Received: by 2002:a05:600c:458d:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-4777327cb6bmr86750025e9.20.1762854330400;
        Tue, 11 Nov 2025 01:45:30 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:30 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 01/10] staging: Remove gpib build from staging
Date: Tue, 11 Nov 2025 10:45:03 +0100
Message-ID: <20251111094512.6411-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is no longer needed after the gpib drivers have been destaged.
Remove the gpib Kconfig menu and Makefile build rule.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/Kconfig  | 2 --
 drivers/staging/Makefile | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 075e775d3868..2f92cd698bef 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -48,6 +48,4 @@ source "drivers/staging/axis-fifo/Kconfig"
 
 source "drivers/staging/vme_user/Kconfig"
 
-source "drivers/staging/gpib/Kconfig"
-
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index e681e403509c..f5b8876aa536 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -13,4 +13,3 @@ obj-$(CONFIG_MOST)		+= most/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
-obj-$(CONFIG_GPIB)	 	+= gpib/
-- 
2.51.2


