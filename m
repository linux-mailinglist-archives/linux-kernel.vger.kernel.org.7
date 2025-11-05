Return-Path: <linux-kernel+bounces-886361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A2CC35569
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1404D4F6C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76B30FC22;
	Wed,  5 Nov 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k278Zokh"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF730E0D2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341715; cv=none; b=MYyxFthgJyKPkPIYi0W1uCbw3hG80pM309yOOj7thrfNvTpSocKQ8qenVtmak7Sv845jtnbkWjP1SxahMKeLaIrjvcludCt96qC5padATmCdS6P/6DrleePCpNj90YnIz1R3DeXOpTZamaUw7xa4ExHB1V9CBJHsqZfC4EDCja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341715; c=relaxed/simple;
	bh=BFh9UCgyUwVsBujdH7J4wHkf6lQu8PKTJJsPUVxGQHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGSrPKXgAXe05iTxuZ7l14LTOdcQ2/t+daY1TRtEl7dq26qDywK68OOM000XPoVQL/QrTELCtIo6blwQWxt+SHt7UgU7WWlLX5PqKWzu3mZj+WDl/igrVrlRsMgCef1pdciQlr4PsxXqLWMzNnaRt87I4lPLcY8YCA1kvdNXl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k278Zokh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c7e438a8so1422325f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762341712; x=1762946512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1euWTEJaHKdLb/LdGqQPWx0LpFCSrEIebRupku/uzo=;
        b=k278ZokhFRG8x2Yfc9a+f3qRXKSxKe2N2vCj3XDtw+piX/ykpK/BP+DGni/rX1/3Oq
         3Nz2F733yooupiRFKjbE7DIlk27TccKLImgYqXTFNvrioNEw4KQvTYY6WeBT5OEPuFRN
         XszjZMljn2L8LB1Oc4rdPX/SxnKRpppk1YmFwIEiLRPkvQis6xbGFbTB3yh3FGnavA/+
         fz6FFRX4/Js7Wz/tGk+TjZr3WQh0ppTKlcI/FmHJkVMzK+v6Wk6o3tjDGx0vLO+akzmy
         k30dZrTBdbD7Oo8oFfwtmeJIPQznqw+HVu1Lm9qojYwO1c8fWdI3kN+//adGTjNCAVMq
         tpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341712; x=1762946512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1euWTEJaHKdLb/LdGqQPWx0LpFCSrEIebRupku/uzo=;
        b=FOvQbmyDkWl47nn0zpAxq0prFdslXZQbUaldLsFYpNst/5n1b/VOD8mAWp1dgqA8ca
         b1U+/FCKhO5QvudVfbcC1YMrGDqrNBcNcArYT07TBM50muWG2WRhCA2vDqiJ8VSUaWex
         yKFeN+eFPpSD4s2GOrT4re7D8Lb5e/dtLkU56IvMhVCWfui0tnX24es+5CNM+tY85Ubz
         3GM+M/kxZtLSv01xbKpI3WHBDJyijyn9FBZCSrB22fJHBLSKAIIj0IAB9tUqSL1uG+hj
         DSk0ch50/g61Ko91fNDidZBXB8RODuF7WwNA/L5kKRxK/mxwGLGAHXFKTOMmTJsGbnQ8
         kf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVwY1co9aX7wffbuacV+deJDbvgT2PLWxGoZWO8bCsDb465DeGAd/mv0Thn+yf9U9v0e526GpzHlYim7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LjAg81G4yiCoFQO3BqSpRfthaDk5R/dt7SiFWSc2Y6FQtQNH
	6GHeuuu9M9AJA/rM0YgLsQvIwM7Bvukh2krWwZBo9x6r9CyOBiTlbHOq
X-Gm-Gg: ASbGncunAuYXxONb+MEu3H04iQfKW0JqeVMpVQz6zsA9zYdg0mHktQN809LsYS5Mpz7
	dEH2iDgYSpvPw6A3/poLpZQ5klKynoLq61zSdMMdJVk77fiCuSBlYFWmAB1bs3KHN3Oixpa3xe4
	xrOeZe8P+vendPmnOEHr7GXyjjViMRxQeN7fT6gP5NpAQL/yh4oqEHqIixnqdtsZvJSApns7Ert
	XFRU2gSjki1yR1nHfk3sN3XQ5aCaHwiKm23qZqopJclU3fHcP9jz3bZLDqxF50R9dO0uTM09SZr
	oLYsP5WoeTSsZW85UKghKQdopFP+glXwXfxf9ftEPLbdxOYuCAsZk0e93X9bJty5DJ8krw+IMeF
	JJQVOpMRQ9Rh9dLygpnc6mQNX6gSmoMmPVQD0tqPqcsTkuob5Gah2+WY2KryEft/WOY06psz6Z2
	zNYIEXPiIQkNW9cbBYpfDbEd6KSz+ONw==
X-Google-Smtp-Source: AGHT+IFaBERjDOWilhiZ8nC8UXn/SnYdgLV2o1hiIVjnv+aP0HIBPMqxjWbtS5BYh1ZNdfc2gkZbxA==
X-Received: by 2002:a05:6000:1845:b0:429:ba95:3a89 with SMTP id ffacd0b85a97d-429e33078c3mr2614657f8f.36.1762341711769;
        Wed, 05 Nov 2025 03:21:51 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm9829851f8f.45.2025.11.05.03.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:21:51 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 0/1] cpufreq: qcom: handle ipq806x with no SMEM
Date: Wed,  5 Nov 2025 12:21:33 +0100
Message-ID: <20251105112136.371376-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series handle a small device family of ipq806x
devices (Google OnHub) that doesn't have SMEM init.

We improve the SMEM driver and apply a workaround in
the cpufreq driver.

(I didn't add the review tag as the patch changed
 with the new implementation)

Changes v4:
- Add extra info of socinfo not usable
- Add Review tag
- Fix compilation warning for -Wpointer-to-int-cast
Changes v3:
- Drop first 2 patch as they got merged
- Use of_match_node
Changes v2:
- Rename error macro to INIT_ERR_PTR
- Return -ENODEV from smem probe
- Restructure if condition in cpufreq driver

Christian Marangi (1):
  cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

-- 
2.51.0


