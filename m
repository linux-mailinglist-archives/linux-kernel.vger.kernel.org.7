Return-Path: <linux-kernel+bounces-872716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 910BFC11DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA7504FD3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E532ED2B;
	Mon, 27 Oct 2025 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9frTLYR"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339632E120
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604553; cv=none; b=RUrEg49gORkUsAq6x28uImlLEUTA4ZFMBToSsH5BZb/v65yfQaMbOqhy7ZV3LuM/mifCouHHozi7yKjz7dm/FgsTeT/72BqTyzjExOfI971ydp9oc5qULwP7Tscdte+724HHIxUyqgvzZNfnd4C0IYdeBTww8BE5oNCJeqYIeO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604553; c=relaxed/simple;
	bh=SKtvE2cUsj0TClOJo7lTtn7TGqhHQ7WvgKoBUrEBgbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=onRVp3J08xJv59QhNUNHMlCfEJn9sPJwXKapqhDm8Ui4/11lP1aRKoiDANqUz0VHwNBk68wEjkp0TIFu1fB8ntjDXmcHbrVOYvmPFINQ/GnPRdn+re/ZdPvW7KayT1QKMs2Mzew3D2HtyBYgPW3bgfMIQ7Y55I0hpCZwMMO2Cck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9frTLYR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso19939675e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761604550; x=1762209350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1A/LVcxwDpEvr0Gd6ktMDjyv/wP+ObMnSP73Nfx0djA=;
        b=S9frTLYRqGBy1Mi7u1t40O8hpwFG0kc1UqWup25TwNpcTEdbiIIcfqka4KU4MkEPDf
         bGseeHhpYy4v1plwmjc5Qc/ZFrcuG1od+EWpb0BK+rzCICRA3TNmKKcw5o7toWUpoiHZ
         x0XmIFnNps4xBKDwWSq6jTz00HK6HvS2i51G14FbKT9lJJemKbU9/oCFkdqBPtOZH86o
         uNNTPrwPCUZJbKNx8j0FcE6bF6GD9nvJ/ZxAgTKXwhcSskMiJJ4nv4ivRY6NotcnwhUB
         phrj7Dk/pTixSFKvtB2/GRXxJsb2Dmb1a2A94Ymy74OUeB7CfBJ+ebTETcwVgVi/ff7o
         Fxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604550; x=1762209350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1A/LVcxwDpEvr0Gd6ktMDjyv/wP+ObMnSP73Nfx0djA=;
        b=TQIXD2TbVqwqoyFEOtVCt0Dua0VU8sVG93/OZrkymipkAXI5NOMhvvKZCWvpoXklyQ
         1ZN7pmD48YYccC4Vnk6fxHa5Sqc8otDJgz1k+7P1NM7iH0qxndccKqB4rZVNFlTh33fO
         QgGe+U3V2bdUmt+SfZAD4Corf07T98RDwlSsKmtIAKV71IIuSLCO5qHdbHhzg3e6gqHH
         UUuFysb6DdV3eap43gy/z+7K4Sx+eoKKXp661t/w57aQiMRgte5AmlS4C9pyj09al9Iw
         zSdckI5fKvGwvjpAeftYaCjIs1104toLVhnXkv0MP8oujFX3ro2IBCRIZzJCdbgnzb01
         FIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCrH/aXlmm7d9SWW4xh5Dq4bXYSUMW7q1gjR135dGYyvem12cTxPUB73g51zkxJhukPGyNgoFDH+3BJRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmkddwAKss4MmwPP6A8rx2N+MHS1DfFwQGzK8POQDLFOmaAgg
	qJ3etj3g+rc0t4ywZIsNMUvAs6JkhuWyA/H1+WYOQpNZtwS/HUoVYi4xBNVNYS8I/4o=
X-Gm-Gg: ASbGnctd6CG6KAg3bhsifsGI77/OD8sguumETpcJHnA/6HvkXsG+qAZ3XlJ/XVYpdfj
	Gh7qS8LxRv8LVhW2Gj1b/B4L9tQpBA833eDZELiFcra9p+Pd17li6LPLA7AB9VgUt0/s5U9oAkH
	RBbGuK6+RweE6SDHbjfWLua6AXPO8uT2/eKbcY/MnVtTrhRC7Opd1WvkVlMPe4ymrEs8MMD42tL
	NdWEgb28c9TxAl4eghpdff95N0aZq0CST02CHVs7L9AK2Zp8/WdGWkGnW5IDZrIo5uANQYgDxnI
	MbLFOAapbxv6vSydJKRtfipdfePn+S/ijQZcUQvy3o4nTI3pVFL3H2v9fA5/wWE5GnxyHBEnv43
	+o+hd7LTTQt1DxnDHDfv5YBGm0C6DPzkItbhKaR5277JCpQSHO10qd1KIoahL+9nuidZggq1zAP
	BUxc1akRrAUocdIOhfZ5za/PglNdYLoF2mkPsCIk569XslwG/C3uUhnKcfzkgorry9+/0KdL4uA
	QnhLwpGuEhdhwVLIdpUJ8GIey3PCvlemIt9QfE=
X-Google-Smtp-Source: AGHT+IHNgeLqcQIQBIBat/dcUh1iIM3JbO5kFkHctU5a6hvBLpM7+lnvBMICPcm0MwMUNylncZpsPw==
X-Received: by 2002:a05:600c:4446:b0:477:bb0:5e0e with SMTP id 5b1f17b1804b1-47717e3036fmr8362885e9.20.1761604550213;
        Mon, 27 Oct 2025 15:35:50 -0700 (PDT)
Received: from linaro.org (host86-130-206-17.range86-130.btcentralplus.com. [86.130.206.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddad455fsm79826845e9.2.2025.10.27.15.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:35:49 -0700 (PDT)
From: Mike Leach <mike.leach@linaro.org>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	james.clark@linaro.org,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 0/1] coresight: fix issue with insufficient claim tags
Date: Mon, 27 Oct 2025 22:35:44 +0000
Message-Id: <20251027223545.2801-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All CoreSight compliant components have an implementation defined number
of 0 to 8 claim tag bits in the claim tag registers.

These are used to claim the CoreSight resources by system agents.

ARM recommends implementions have 4 claim tag registers.

The CoreSight drivers implement a 2 claim tag bit protocol to allow
self hosted and external debug agents to manage access to the hardware.

However, if there are less than 2 claim tags available the protocol
incorrectly returns an error on device claim, as no checks are made.

If insufficient claim tags are present in a component then the protocol
must return success on claim / disclaim to allow components to be used
normally.

Changes read the CLAIMSET bits to establish the number of available tags,
and adjust the claim returns accordingly.

Cache the claimtag protocol availablity in the coresight_device to reduce
reads for the main claim/disclaim api.

changes since v1:
1) Added claim tag availability cache into coresight_device when using the
main coresight_claim_device() / coresight_disclaim_device() API.

Applies to coresight/next

Mike Leach (1):
  coresight: fix issue where coresight component has no claimtags

 drivers/hwtracing/coresight/coresight-core.c | 46 ++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-priv.h | 10 +++++
 include/linux/coresight.h                    | 15 +++++++
 3 files changed, 68 insertions(+), 3 deletions(-)

-- 
2.32.0


