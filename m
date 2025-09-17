Return-Path: <linux-kernel+bounces-820515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FBDB7CDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C8F462FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36472C3257;
	Wed, 17 Sep 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="nCZgoMyy"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966D285073
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106555; cv=none; b=MNIFiV0kwbv4l2mVSihEFpg0ho9XSBqmra8e1vJ/MHsSMj9ICFuPBkKq8HExoXe4/LpC+ehpFIyTmsZJYYSbUOldCKKB48jNEEU/3LG5ulLirLEVqNzPRmYMutVakeeNUuSE0eb1PuVTzxDIsoA+aIRR/wZTSYgvEBW76Erz94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106555; c=relaxed/simple;
	bh=ufhyWHlpTzLjNTSW36vWnM7LAPZfQZI07G9bZ0M2gIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UKiOsHA0Uv80xdfQ7bE00yV19J4bJYmsW9+5MoYlXvb+lCQA0lhOluDi5mXi0RVwL9Xz/Eo0MWbjwI+BwjBUaKbu0zb5Ke3ft84WccTxV8IHlVf4PhVHrR3ftELehLf15VJWyPPhTjC3T8iOKkiVduO9gXBpPvjgkRf2gR8FQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=nCZgoMyy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7742adc1f25so4505408b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758106553; x=1758711353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=adTihmHwzJbf+9dxqIDSLfiv88TU7A8gsjhgenPMslQ=;
        b=nCZgoMyykb0AEQKBXPm+6rCbfglmbJpbS5qPcg7pb3bCDgeiIXaIIEy4O+bqr7CxsG
         ickSIH/LzriKggevPD3arvVLxHN7f9lPPs3ZW+2kK0rZeqm73qyO5/nLvqlQZCBjsg9G
         VwvPpbvq/svgdU/dq21eUtiI6757qECUS2rR8fdf+l8VBCEJIMZQafTpBdnouZoFVVOp
         n+++c1d1VvnHq3ktWEbuLyvDs7gIVYYEmdUVfkXVV2iq0EusZHhmT/kpZTD3Egc7JCFr
         CtvD/o7B/bnu8d6UH6rc2ff/sK+wuGMDhvaNVO3c5JFtyGVb0SkAKtstpDtokJPbmuh6
         K21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106553; x=1758711353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adTihmHwzJbf+9dxqIDSLfiv88TU7A8gsjhgenPMslQ=;
        b=u68TzklYxwMLPwIzCgKyWhqacYEUluZim5SV4DtJsaqZjzJpvFStBqPGmF+5Pg926z
         e0r1zOGBJP92Q5f84CJKpuz7ZAbACYoeHB+DLZzBXVosb4AOEkMrrAYTyYloqX36IOCv
         EJwMcI2OJbaS34JxLxc4tzK/BCqtrhBLnAiE1q7K3iBSvPK70TsyNe8pfyRxYLi7cEKb
         7Md3ZGvy942O25yEo/KIc/Y4LYnTFZKL41Rqhcv1jVZvtrbsoKp/XOzQCExxXzT0YQoQ
         bjDRZ6vfu2PDcdnwl3nGMu4w9CGIsnGx982ynZH+IBZLkxq2aouiUXK1TxLx65QIbJpZ
         N3OA==
X-Forwarded-Encrypted: i=1; AJvYcCWnY7O8OMOEvfT9WDmPXzoaM/fzk+PyzPbvTgDGc+dmY3uJKN5Gw3BRVEfdbPxG4bwa79RhmzUoQybiszY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8h1J7RQe0wIt5x0OIG1a/uZZmSeGN5IE6vlBAOcdbhUOffGT
	7bp7z/xvMcXthU4oFwy90ya6D5uf07pYZGWf5c06X5uqEFUZ3tWYzZmUpLYX926TzlI=
X-Gm-Gg: ASbGncvwQloNlPhGqPOR3Oh7piDlqtRIFbrFha+NmGfcJMNo7jvwK03P5PD5koYFhZb
	cdMt8wuJAW2o+bt/jMRimjv8CqQNtZTM23DI3+Ykakd69JtsyglrrpDg47eIpze7YiEp9HOVFbX
	kcdbmX2wZw0AbzcHRf9830S0rCzmlRW4O7W9d1ur9JkuG7O+PvLTCM9byk22z9beYpb/0WRNLwU
	nPYD/EH5PiS4NRUYY2rv01ysiv4t38CX4Wkhg1oaJ3jQw2YIXA8UhfyDkP5Oytcog5zlsC4Mkiy
	XrRonXn8oKRA+zAW28P8Sq3kFaPy440Ish8KQQzMd4ExYI5RJLtiOs0YhdIQKN7PGiH54xrJgHx
	sjL256W5DG3oOR/vNg7klpv/pYEXANsyhGFUh2iyX4OVBw4n7QUr6e9Ko
X-Google-Smtp-Source: AGHT+IHu7B8nUjAHLAKGXC+EcCyBnCKDdaHlbT5cM0DjbI9g+YR/BAYDE26XBq1QLYfijEOd/iwymg==
X-Received: by 2002:a05:6a00:1994:b0:772:282d:5a68 with SMTP id d2e1a72fcca58-77bf9b5427bmr2020650b3a.29.1758106553021;
        Wed, 17 Sep 2025 03:55:53 -0700 (PDT)
Received: from fedora (cpezg-94-253-146-122-cbl.xnet.hr. [94.253.146.122])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-77618a7feefsm15249228b3a.58.2025.09.17.03.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:55:52 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: daniel.machon@microchip.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	herve.codina@bootlin.com
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] phy: sparx5-serdes: make it selectable for ARCH_LAN969X
Date: Wed, 17 Sep 2025 12:55:14 +0200
Message-ID: <20250917105541.54033-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the SparX-5 SERDES driver, so make it selectable for
ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/phy/microchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/microchip/Kconfig b/drivers/phy/microchip/Kconfig
index 2f0045e874ac..2e6d1224711e 100644
--- a/drivers/phy/microchip/Kconfig
+++ b/drivers/phy/microchip/Kconfig
@@ -6,7 +6,7 @@
 config PHY_SPARX5_SERDES
 	tristate "Microchip Sparx5 SerDes PHY driver"
 	select GENERIC_PHY
-	depends on ARCH_SPARX5 || COMPILE_TEST
+	depends on ARCH_SPARX5 || ARCH_LAN969X || COMPILE_TEST
 	depends on OF
 	depends on HAS_IOMEM
 	help
-- 
2.51.0


