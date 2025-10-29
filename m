Return-Path: <linux-kernel+bounces-876580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38DC1C0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 716E75E1AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6437B347FF5;
	Wed, 29 Oct 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShHmGmuZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311D345736
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752806; cv=none; b=MeIq0WsFvrMBd8jkllaO7+1ql8fkQM/UnEnaIR6xWGLTnDZGbOniPu9PEFNWyNhyPOzjxJKcE2jy184mQdL8gKDZfKRslhJeCmJFUmNWIahfEFVC/k0K+x5M8RyAM7XuSNI33cjqOpYZUzQ0M+BDe+qreG4mz+DLAm2L0zTjHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752806; c=relaxed/simple;
	bh=b/ttJae4xiEHONrSB61gWYPCVcnCnqIpQyNKL5V/Pqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5McCdiq4N58bZ2Mgyalew9N96MKzdjGAoYhY+uJP7MnUBdua4EPdi5cyvOT52hhREO88Q2/Y8kqfnAQH9zPnh/oBHTg83iXCoSalqu2zB0kiW8ZQAjAvgR5sUDkAOfy68USMmB5/u8ALVKIFcBlr0VR+9AL7QWZcQ8FG9hA+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ShHmGmuZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475db4ad7e4so21817505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752803; x=1762357603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=ShHmGmuZPoA1hsZMLL+v2PKUW+6LomOA6CM5WM7kgYjUwXD4eYlgD0U2wtJexjZjjR
         afeKDzSGq692VY5s3ykIh7OLAHx5uLGfy1n3f6oI61BhkVKy9/38UsUprsxQXzQpScwD
         SFOwqjj1aj5QnkzClwBp0Jl8v+huqoCxUlPHp6KaQRJLt/kzny7X10LtWT242SyFGQHp
         fWDuUGbkiEFNktK2iVRRLkTTsJa8++dW+t5WimpXSOhD9olEIMw2hlxGkXfNXaDPeaza
         scKD3gIxK/aGS9bROQ/hwSE8I+T7q84rulxrU0nEbkX8+esoUTuEMTFv/PkzG2zww5K3
         zyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752803; x=1762357603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=bJIAOKL23SEDGX2NBsg+pxJRwjdd3G5vr+x7gL5hFuyaguLNfWi8VVCRh2Xsm3+LYl
         Sq6wAZ3z8+htri+Rlln6SxOIx4UxwA03ynbzIwIZybdW2iYsEXnyVRGmhMGOj3bDsKtw
         PkFLQSbZRYGX5m0K9NHq2aVCTQ9h1VY5CK5JukGiHublbTAxbFLS3qrBeqOzoPF8tBGq
         5WLUPHXuHNlgUfhpLfOmSCqu5YOoSMuudR8ndK/MXzNnDNiTv5FFKPZJ1Ce43MZ+vr5t
         tWYJuptEzd0xh2K2A/kRnp3w8xUNiQGOyDpKZwzhpbZv0tjgwRVSjq2P7cieiBMmREdc
         47Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVKRdJ2kR8aHpKLWR654srvmdADuw2qfCj3zutAjoNPW2x+pF+jURdw0hInA7r9+cN4H4+xBtbd6RPyFQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP222jvJl1ajrk6M8XKdkBKlCayJqamSrJ6uZaC6BP15awwoyZ
	7fkToJrF9MlKCk0ulXTKKVXCzLFX41hY8oGun2FCknVqwD3eirUGs1X9FNpe6KocIjB5gSdF1G3
	dBRdjrVQ=
X-Gm-Gg: ASbGnctMof0OIiTNhZjJIKk+pGAJRD0YbcY9dLvlqQGezZkHQsIPYxyYEWRD36fOxgL
	YrGNI2B8+tEtA4BNcn+TZvUV9ZGX68acfxXpnJTmW5TfKFf8bZUU8UAMfjJUchSzpokddpgwv6F
	2IEkGgdXD7J5FYve89+Rwrq69rkq8p8aMiyUvqdB9vh6ja5pzh+Kx797Do3ToKJ8UDTCg1uRwlT
	9LPS/IG8Mn7/H1/TN84l+2ZWAnAG9e6+koTyBIN3W1kn+/wft0a8yrzD7NsDAdvzEatLURJOIj2
	gAxVPDQGpGEcGCqf1fYWsUV30yxw6FJmcwROgtKl/EzIY4/GKg26HNlHz37GQ8ajh9X56CxIMX6
	dOwQOeDGae9xIsuJMJt1R1J1Pof8Zalv8NSUKDJHet/1n8v8iY842rxqnlkhmXIh9TgDIfsrOl7
	nGCt/GOpLPX1I0cyt+ahju
X-Google-Smtp-Source: AGHT+IGgMpgZEFzxgXHO7KovTsc5aHb3zJSnvVbjxNijmQFt3YOgqBA/a+6DV3XDRna+PgQBEaHpRg==
X-Received: by 2002:a05:600c:3b29:b0:477:e09:f0f with SMTP id 5b1f17b1804b1-4771e165a0cmr33584695e9.8.1761752802900;
        Wed, 29 Oct 2025 08:46:42 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b9994sm53745535e9.16.2025.10.29.08.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:46:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 29 Oct 2025 15:46:03 +0000
Subject: [PATCH v9 3/5] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-james-perf-feat_spe_eft-v9-3-d22536b9cf94@linaro.org>
References: <20251029-james-perf-feat_spe_eft-v9-0-d22536b9cf94@linaro.org>
In-Reply-To: <20251029-james-perf-feat_spe_eft-v9-0-d22536b9cf94@linaro.org>
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


