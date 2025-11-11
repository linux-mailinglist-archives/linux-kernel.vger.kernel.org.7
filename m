Return-Path: <linux-kernel+bounces-895316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEC8C4D7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D4604FF870
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6993563C1;
	Tue, 11 Nov 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDehWl/b"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9853590A6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861119; cv=none; b=u0l/Nv+ZfjViQxQ6DU/sQ/Q+OABp1AD6NogLDxZnr26L9/n2Ha1E9q2aiqZNUWztRAaAimH7q83HSIp8U1BuygQWdQGogjNqSd9NgSG4MtgUsM/PaB7cte6xmrJ//3n8HgeZRfgtveUSzV8peOX5zAtuGpXdUmqUYiefhRD9z20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861119; c=relaxed/simple;
	bh=b/ttJae4xiEHONrSB61gWYPCVcnCnqIpQyNKL5V/Pqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3QE9m2UQTDFNP0mrncsyxR7+nrZIaFLAFagjynUDtyg+Mxwf2bujpoKZ9snDvtu0xmsqTM/DYX72mclWsrwZgSz/+MmCNvathrf0BNSWUUOD4hsiBApX68iS+KWEessTHnEJNWvSxz7wJPJXH+eFKvgziqXrUw6fW65as+4xCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDehWl/b; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47118259fd8so28970585e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762861113; x=1763465913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=vDehWl/be0EvJq+Cp0eB1lTOJLz767+Fv4g5FD2lEo74N9c+Zs5J9LeU2Tam0+/3t1
         h3pM9bX0q8OffUmbFGVIohlru3qgrN1th+Ph9AezTjXqg1/phZu+2aciX5fYZc1cW700
         FTEGgRttwZc9gSY9lZDuEeR4y15jWQNb7uPT1uMVcCgezJIV6M7KaRBDnUye+xkMDwds
         e5Yco7m2yAPi2Edo4Gm4KRDGJzwk9VVclCPKWnZfSY/66r4fHib3xKcQn11W6Nwr6gqq
         xzD1gT2vszWqzsaAe7f/phJC5P6lr6QZ/0rnxMlbEzEuFnIh8bOZ83v76ZDYMBYnOdmL
         XOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861113; x=1763465913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=KSnsMkBGTp/b4NlyDgI2DN/oEQi+EsE+ZvmyAHDrHWfKF7mCsfiDjevCrrab+yYwvi
         hjLAQLVgYTUdrN38hLg6yrnJWJNgzuWOY4452Y/FWf3rBmS+Hxi1HKoGIa25KEFM/XOa
         OkZKdnIgUefY8X9BYDui85c7QZ7Cj6jxC2Al+bIIMsKPKgkU8+MSXBr0t6Fr4OnJAEnV
         IbWLeWUqhMVEnYM5xpWdVLN9yY3MF8N06ci7kvC1gyqPQH3ROwzf1scvd5duJfVajnEU
         rx4LuZa/9RcvJCdvhFtjcyY1axa8Lr3dklYIPHZAOAN5NZ1ng+R5Zfkj/dACJnIRq9AH
         h4cA==
X-Forwarded-Encrypted: i=1; AJvYcCVdWJQmarrrGNVyoW2nu3gLuXvL/mTE36Re2i/EpGUzLHnyuAutq4p9mvSORySw+42nKXun6cRXuK4srss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+w6xy3xnL+FMydtRNS14b/QM1oVDkgtsfjx7Fbbmpdq3RAwIT
	jrK5mXDF8rbMcM63/HSZwvQUio4uT4b1sChmpTi1Hl9jc0szEgeAckJpEuKJ1rWVeHY=
X-Gm-Gg: ASbGnct4tezGDESvk9cOUUdFh+CITtG20KkN6EubZDSPwQ3CVBCc4BGA286J1tX3uEK
	E6mOLJm4Frxb8jANiN1ZOuG7uI2CrgGRzbTxLW446ghRKnMTeJnHShqlAh8VCLZUln4jD8PPBlk
	PwtFEqX0a0fMC/mLIARIkq2K4QblhVMg1dtMtZZ6yUTJ94giUYw22juiqXETlcB6R0LgP3wGsOR
	Z61/9JQ/jJWgwUqj6Pim4AW7rt+ZaUZcIYa8FAR/sWv6h/af6Jgl0Mh8T/kjQF00cSIgiqPMJI/
	4z/5fGKq9sEKPbL3dOhspqr4mfC41S7NoVtwwhACtpZkefbttrldUcnu2ygfUDHWUL8/9mIUHew
	7zV7WIZFEAcFal/ZVj1Aymbwzh0RyTG/DYj/wgBhPKFMOIKJlX5YpT4uzeTVUcM1nicJX6CoYdJ
	tsVg88vt3y08ZhEo/zbbyX
X-Google-Smtp-Source: AGHT+IHHKYLRfVgN/W/e843ki5ckqj4gtDXuwTA8cbEV+6RFtEvcngH3q04dA3ZvJO4NaiMzNyBD6Q==
X-Received: by 2002:a05:600c:1c14:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-4777323ed28mr117807465e9.11.1762861113334;
        Tue, 11 Nov 2025 03:38:33 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm28133486f8f.22.2025.11.11.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:38:32 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Nov 2025 11:37:57 +0000
Subject: [PATCH v10 3/5] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-james-perf-feat_spe_eft-v10-3-1e1b5bf2cd05@linaro.org>
References: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
In-Reply-To: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

To pickup config4 changes.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 78a362b80027..0d0ed85ad8cb 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -382,6 +382,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -543,6 +544,7 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+	__u64	config4; /* extension of config3 */
 };
 
 /*

-- 
2.34.1


