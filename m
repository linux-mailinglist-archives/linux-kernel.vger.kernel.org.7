Return-Path: <linux-kernel+bounces-732378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7CBB065F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BAC566ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FEC2BE64E;
	Tue, 15 Jul 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcEpsZ4G"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB72BE620
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604114; cv=none; b=HtGF1JiqHG/2606nTQxXBnBIJT5wliDNNeWL6Zb0rJ+LmMCuWghs60rbwW+guxP+g/EQEZNUxAgk5/ygEU3sT407aeD0C+tTjclLN+al4UF/1YwOjxAl26raY36yx+KPjrlV1HhfMzn2MCLMitZZ0h2p+abrijQ+yA3GHa0x7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604114; c=relaxed/simple;
	bh=fzOSRSQCoHNu0dLeNFk9R+TyySgHxZ9QTmLjc6x/0b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spTa2rn/AxkIsCUzWuHd2etHA/YCE0UnsToUK+BdgGrjOVSnId1SgEdQI49q3h1V9Fj77XpHZ0SSVFwfW/8i9TGgQ8i5euifhrqKfakq1ksMGY2h4NcXVvDIr4pOwb0rInoUM7oNJ6emkRE+sWp3IQzmZ6weYO9kWuqdb8Whj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcEpsZ4G; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0c4945c76so930216066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604110; x=1753208910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNAKp9Jrrt/krq6KY8ZZhtTOTeAjVwlU8hOn6TWbOn4=;
        b=bcEpsZ4GlOrkt03atrSK/zAarK02OYAz/j9BcPmKuH8e88vyXsTa5RZFb35kgOIkf8
         749pv2s2MgFYy2m839+Ni3dik6G9/1zvIPrrL1GnYGbfMC2L4N1cw3Miy/nW2ZlKuBtw
         0Afyo9pjipRMhifNheAkiRIAmcce0Jz12jU79SsD7cPBgfWh/jVnaDK6wXLM93LEkeJn
         ssv9zb/ty46DiEUAJN1ANwrRxqAMwZx3gAWsTOMbGsgFOJywmF7a/Ndp/iufyYXu4p7y
         ptG2YCfS7WrE1KZnA6FSdQgh2Jbv0Rqfi1TSWyaibCxRGLworHZI7+uS5Ko2RQnI2W/2
         nVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604110; x=1753208910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNAKp9Jrrt/krq6KY8ZZhtTOTeAjVwlU8hOn6TWbOn4=;
        b=JT8FMe0d7KG84JHV84K0NMUBMFrjiQZVswxYNA7n/AwgkWPG0utdMsMl4FscbdmZWr
         95IkOxN+coW9MFFPT7INOrEFoEdjI4dq/fTsF/iBHaoRarZnJeHIzgkJ7tL1aDSzSrvw
         SDFjdbw2O9xERMhfXik0W8QYaDwVy/B6xpoLFkZzoZ5ozXMTzMNqAdD3fxaX5OTUu5ZY
         3xy7z2X/PKh/xhMOqHHtEe1YGEAoe18Ei2LDVGmOLB8Lrji/d8Hhi9tYnIAdTN7C0Y/c
         aCXfUNIvQuw4OymT6bP6Y9u51ls4O5zQivvUujwOPTtwHiKNJKp9udYESq/wrGkU3fey
         RqLA==
X-Forwarded-Encrypted: i=1; AJvYcCWBUPgJ8KeBaR5/2Fr60clcAtnGbaN0G6rSk3XUVWA1cS9/3Z2tLnhIPyXP3Y2DqlMPC41/QL2Phkqtyuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvnZyarT3Ln9Ydn+1DaGlClwgG6gs9xj72NS87bV/W4rrzjbt
	mmEI612bBVblfpI7Ota35NX7iroFUVv7EX8zag04WLKb8+NtnHUc8RtQ
X-Gm-Gg: ASbGncurvXgdZw8nhtLsxH5GMB9y8dE3OyI4Z0Bm5Gw0OCxBQXWjaLYA2n1hreGGCYC
	YpIRtAo86croREs9JLkSssADRE97839OEHhBJBYtugVkgalEGP0JYGW1PtXoQHQnGhV4/knZtmm
	2ujx6BZhkFA2R2koRlCPFRNfhP0/r17JSeftxQGpKOMpXjWNK0kubAA+n4N58k2F3+wdOUfpSbu
	FQFfObptYvt2eFgv4Y7LUzI3krJyLy+OXP0hYhEFdWBSOREzYstyYzNNkiMWUpKVtMOAa4lhOvq
	eTzCDR8xi+CNNkaGAPLhDem3jzQGi3uKvx4nK1fLQk0AEsCn7AIi6Jroi/OOqeUhHCWS555kBkd
	yo/O0NoFt8kb9o8/5ebIl91U=
X-Google-Smtp-Source: AGHT+IH//uRs0DZirwZlWD3pjj8AlbNnhVRn/1OY+8pccSolDMIpgSzcJHR+8gQWtBuy82tFc80XGg==
X-Received: by 2002:a17:907:868e:b0:ae3:ed38:8f63 with SMTP id a640c23a62f3a-ae9c999736fmr48181366b.14.1752604109818;
        Tue, 15 Jul 2025 11:28:29 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:29 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/11] staging: rtl8723bs: get rid of struct hal_ops
Date: Tue, 15 Jul 2025 20:28:03 +0200
Message-ID: <20250715182814.212708-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes the remaining function pointers from the hal_ops
structure, and finally removes the structure itself. This reduces code
complexity and thereby improves readability, as the hal_ops structure
is just an unnecessary layer of abstraction.

The patches have been compile-tested only, due to lack of hardware.

Michael Straube (11):
  staging: rtl8723bs: remove function pointer SetHalODMVarHandler
  staging: rtl8723bs: remove wrapper rtl8723b_SetHalODMVar
  staging: rtl8723bs: remove function pointer hal_notch_filter
  staging: rtl8723bs: remove function pointer c2h_handler
  staging: rtl8723bs: remove macro FillH2CCmd
  staging: rtl8723bs: remove function pointer fill_h2c_cmd
  staging: rtl8723bs: remove macro hal_xmit_handler
  staging: rtl8723bs: remove function pointer xmit_thread_handler
  staging: rtl8723bs: remove function pointer hal_reset_security_engine
  staging: rtl8723bs: remove function pointer c2h_id_filter
  staging: rtl8723bs: remove struct hal_ops

 drivers/staging/rtl8723bs/hal/hal_intf.c      | 33 ++++---------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 26 +--------------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  8 -----
 drivers/staging/rtl8723bs/include/drv_types.h |  1 -
 drivers/staging/rtl8723bs/include/hal_intf.h  | 13 +-------
 .../staging/rtl8723bs/include/rtl8723b_cmd.h  |  1 -
 .../staging/rtl8723bs/include/rtl8723b_hal.h  |  1 -
 .../staging/rtl8723bs/include/rtl8723b_xmit.h |  1 -
 drivers/staging/rtl8723bs/include/sdio_hal.h  |  2 --
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  2 --
 10 files changed, 8 insertions(+), 80 deletions(-)

-- 
2.50.1


