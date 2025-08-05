Return-Path: <linux-kernel+bounces-756412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD34B1B3AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710703ADCD2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD812737F0;
	Tue,  5 Aug 2025 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im0fW9FI"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6B26B74F;
	Tue,  5 Aug 2025 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397910; cv=none; b=O2+fJzJ8d2E3AXBPUezGUq+6X6Wch8bkty908HxYyNSzMwiV2mIu6DfNCPlqySNov7TITLt+dDP9TQEvkllE+VMx4A4AHl3L7Vc1rxKBF8LhdaHx9DfL7+J3EYcv9Q8jeZ4TyssgOfsbw3czMullAgS8Xyx9LC63fO2LF1b3pzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397910; c=relaxed/simple;
	bh=QFgU0/CEXFYbjzfNHUQQpLRcHVD1gPo38FsS7g+TlD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pq4pYivPYyh/1OadTFLgbzWuZ+W6Ut1sD98RZz20Yz5H15NADbKa7XdT3ITaZXP4cNDVahk2Cq6J0uHTTR5r61wqpLZtvv+ohOtWcRwrR3LMWV/VyVZ06etQ3OpPL/I5DLdcfrt3KWwHjAbuQLciam5byHKxekybLj6uAwihoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im0fW9FI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7682560a2f2so5471730b3a.1;
        Tue, 05 Aug 2025 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754397908; x=1755002708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHU/sFwd+Rac9PdQf2L/PVDjEFciLqd4WbjhsM3H5TI=;
        b=Im0fW9FIs+IyYkyhdNgR4WYtmrRmYaHanbpro1R01Nf2cpY1KxlHD2ZeY+LZUSAA1/
         dTNNlhq1oV1f84ZsDNcbLH/6hOcVyuBbd4uH+ANNsxHqDKWU6XeVErgmDjxvS59Cx2eT
         SLhTtz3LNVe9dHiGWCXOMlaMs0nfNbkQvYyrfJkWvd8040IjYY0t39g7mQ41JKjCC2nM
         RdelDb+eQ9tsvYqE9KqN1KihqnPt6papXOTK8dz7qWp/AkSlE0m5kCPtUc9UgBmanBU8
         sw7+dTxLoZvu7t0KIisbePqgfLk+/KwbmJ3XIVzJ1UWTvBlaCxy+Tk4ka2L4Ncnym4rt
         CwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397908; x=1755002708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHU/sFwd+Rac9PdQf2L/PVDjEFciLqd4WbjhsM3H5TI=;
        b=CM7+kSpO2ARrSvOMOzyz6M5VE8IgX0RHj/DH5tDw/4uhppGxsLobIw5pjakqHevIhF
         /VkdfOwI2+TSwAJvNVAwTV0UHViTP4geQopJ9l4SQHos9nJFhkgDY33P1MSEiu4fNvKk
         hg20bLZbFoy1Ggxk7rrcOtsSY0HuuXExli9OKRp/QDulfrGASK2pSBym/F4u3fm41sep
         Dmzjq5uUS49wYXtr2pdmmefMFje8tLZPANZs9XquLKMipMTXDvn888b4kJWopIPFBZNQ
         dCNBlhPad0/THjvmLCKRfVOUeUPIYJHm3V1dA30AcvPXshqimLR1sgq2tFCgHcPCNQ/o
         7ZSA==
X-Forwarded-Encrypted: i=1; AJvYcCV2SYFVPetxNKvIsjk3+duQXb7sou/KpUjhFp7e84sfr9knQvSqUC8MNUlAcZC939/AZLjT4BLUbRGp@vger.kernel.org, AJvYcCV6j/Hcv5BnjsHJ80skLFL9XOx7lu7LIoD2d6xO3qzPJG62/c8ESnvAd4zmnxTsmrXBg7DYTUjLOUyV4/DY@vger.kernel.org, AJvYcCXR6bJrcEQ7JnRQrD4AEC9mAwEnhO2WUDp7MDsoz9WLU/MzFsGfNts1+ob02OrBfrlL9/TOa85LMynm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0i1st99UvofGEi2KJqF/YXmLCYtOzC5OfcQgUQt9G+P6ApWbm
	HFgs00pXxaTfMHFGbbWy6/4PFKJaQNYApHcOosc+6t406t34zMcw7bf987xKUA==
X-Gm-Gg: ASbGncumjQCV1+jaGce5RldB6aE2LT3fE/p1cjKVEmztRVgzRlrLfwcvI2bJS2Wh2V5
	OfVo3PvFA52/vLTkHmv47TI7ksRy+Cesf8YCgpY7wnxD+6DYt43HajnD/z93HnqMKW2Qiam/VJj
	m8O3kPzf6Y8K3e/jYJ8uMbKyDBZNzPNPPXTH3jP8jlE4BxNuFTuWPVvFjh/4f9uA2mM0Ecy0tvI
	QqZmbTT/VCsqnbtCGsIJuV01Gbf6S2vkNICN0D+H9eaAYpa/nu+JY55jisqrgCMaKcbZ4DikAnB
	upPnvlwb2XTGzIohLydFahsAULDKhNNd3AOm3k/sO3CH4wYLgUVmPjXnXXc28i3FyZCRRI5FHHB
	/Sv9e03mefcCJd1zubLZ1c9tcEcgsKO56dejUAdbTtvUo78w0+jNCeFXbS+qgUkL5CyErbqlAAh
	Fc42m4
X-Google-Smtp-Source: AGHT+IFZU6t8yN3IMYotfaHWUa+QR1XpcnQYfSCO3gsmE0HXqDAkGWrCCO0kkeAngrfHaDLMujCHFA==
X-Received: by 2002:a05:6a21:33aa:b0:240:10d2:adf5 with SMTP id adf61e73a8af0-2401e9ffbb7mr5089018637.2.1754397908378;
        Tue, 05 Aug 2025 05:45:08 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-118-39.dynamic-ip.hinet.net. [111.242.118.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf523sm12959863b3a.90.2025.08.05.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:45:08 -0700 (PDT)
From: ChiShih Tsai <tomtsai764@gmail.com>
To: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	t630619@gmail.com,
	ChiShih Tsai <tomtsai764@gmail.com>
Subject: [PATCH v2 0/2] Add sq24905c support
Date: Tue,  5 Aug 2025 20:44:47 +0800
Message-ID: <20250805124449.15187-1-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - Modify devicetree properties ID to silergy,mc09c
 - Combine to a single if statement for MFR_ID.
 - Add description, SQ24905C compatibility to the ADM1278
 - Remove two silergy properties,re-use adi properties
 - Link to v1: https://lore.kernel.org/linux-hwmon/20250804124806.540-1-tomtsai764@gmail.com/

ChiShih Tsai (2):
  dt-bindings: hwmon: adm1275: add sq24905c support
  hwmon: (pmbus/adm1275) add sq24905c support

 .../bindings/hwmon/adi,adm1275.yaml           |  9 +++++++
 Documentation/hwmon/adm1275.rst               | 24 ++++++++++++-------
 drivers/hwmon/pmbus/Kconfig                   |  3 ++-
 drivers/hwmon/pmbus/adm1275.c                 | 11 ++++++---
 4 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.43.0


