Return-Path: <linux-kernel+bounces-795510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A2CB3F3A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4440B7A6BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDFE21C17D;
	Tue,  2 Sep 2025 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HYCfyFCM"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124232F761
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787084; cv=none; b=Z1GfCO35Uth88kqkB58HsB96G7rZoWGs9Ijm9PJcr20HIBPxcIkMnXZpkuYuuLoQb72py17Al/HDNji1QeHR1R+myBIfS6tsjOesBNgbDp285rO0y1kbzQdmNxectO/mK7oGT/QR1bVhFdx4onaO6nSsONOQxM4HUm1Ojwv/PtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787084; c=relaxed/simple;
	bh=M+Q9v9flGjdDETMSwkt4HMUVbn6KWMaG+8KVF9eW0eU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Go3nZKHwJWKQqJafzEDFiNLJteudsZiK5K23sz78uH6Ry+ekLKCDtVWGVG4LhHn+aMSE5J70mp6Cbk4ounHqtQvOTvVmaFnxPbEKygSH0iPQW8r2Ys8KiSJeN7xAJ/X3dk/qESWO2nX9ijv4L4xe+I1CXs/v8F/aHh6lEQVGvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HYCfyFCM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77246079bc9so2348267b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756787082; x=1757391882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELXyWcssNZnLWjFVF7tpe1q7V/V3XE3CzBOArXpJV3A=;
        b=HYCfyFCMvxB8HA64jgV9xk4YN1QUoZ+XYyurJSa9MXiIgRUTuGEnzHuqTvz+gI0/tk
         DvtkH6Pi4bvEQXU8T7z3ZHxncB16flF+VpTOzSAa/9Ela4TXe/Zf9xJiEo5HbQt0sjoe
         gAkN3VnizwrlUi4Z2Bo6cnkPbu3LK8o9sh27eZxHmWXi61g+bJFfokiRumWRyd7KTzag
         ooTH25JE69L11dl4kLwUIv55SmYZdSX7ZNEpB1/GwkU8KSQAE8H3OhP5/TxrFsjZc51w
         oI/9E7DTgXYSmbRt1p7zgOsqmk8amFothKDGA1uOnIdN29dEKMvO71Ub2DylI3ZlBkoC
         fXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756787082; x=1757391882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELXyWcssNZnLWjFVF7tpe1q7V/V3XE3CzBOArXpJV3A=;
        b=dbPRW5PVupyhjyBc17abLQ7rTrZvdbSjq8Luu8oGXc/HvUdFWeUOKW2uHcYYtRrSxk
         q+Syz+qpO4x4xB/nZXx+seoXRSMeTFhO1CQCLSkUS3IXSc1cI5xcaT8rzgKwy00EFy7f
         zjZJF+a6WaMFsBRZ7S9uAV8qac5YIOnbaIKbmKXU1IhQM71xZp1eNM+QviTe80TMzgl2
         1C3zUOF8RT3HL51nOuzgpE+m1sWQeXy903orPfzGrUMbgOcjLJe4ojFYg7aHnX9fSkVS
         VANFkMz72J1bYRHUoIhK2JFESbs1mybrx3Jq5qLUe8Cg5V8nkofvBFr2pT/hGbUclOn6
         ZMtw==
X-Forwarded-Encrypted: i=1; AJvYcCXdE1cpRsFSLyC+O+kroimMbSx0yoXOaMLvXEQ1LCifYOp4yb9INT558eTdEM/vk7eh424xFXoAWqhV3K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/n5B3iP6Ol2nXwGwu85FJou4is0qeVleLWhXJ4jFkeOzlARxT
	T53hFAP42DtmxlZXvX+li9gZQC0GvB9uBz92Vc/5yK+/Hbf+BWLj9KDcIWdeNvBt8ig=
X-Gm-Gg: ASbGncvgymKW+BEbTiCNfBLhcf1a4NkElIPCn01EJSu/zACQcmR+rbbVLKArsWll+rG
	bx5Fhr1mu5JdfqcyuxzYxKNiFd5HI0MtVjPHSgANZgBoezWOVyM4RxtbMbhLD8WN/Rj+0ujrSBF
	6rfc/Yr0B9wSnbntgsbJIG/QLypKVaGtu5fkNZtRhxAsFys9PRWBkrziL2a7fMntp9R02mBeDgl
	NZsmNjHUW7CyF6k+0UQBlfs8uoTE2YxeMglc91cHOcZmttDjYlHrP1fV7MCsRBgUp6hloJYOKiM
	s3nKaQzNHKfopSHIHGP8/yjArUfcm2dZvmxaLlqkThQVsfZphLGcyH4SKVgm1PFWfurQCvYCbDU
	jBv2HUBnDlfx69FhR4FKMCEYFNQpWcJFohfQAxrZ9fzhwuz5qs/nhaTaI7jU6dUZw6/ilx88uUH
	K7stQ9N6Tp9ZtYVMr578RrSeLirxKrAT6fMfmmh5UtsXsO6rqIeja/yw==
X-Google-Smtp-Source: AGHT+IGgZRRv1+lJvcGUzyqHqMqDpjPoMrsqY0dxwET91a5H7O0B+l/j1QflRtVZPNoA7S61H349iA==
X-Received: by 2002:a05:6a20:2589:b0:243:a91c:6561 with SMTP id adf61e73a8af0-243d6f04d71mr13318621637.30.1756787082321;
        Mon, 01 Sep 2025 21:24:42 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327e21d14a8sm12216706a91.2.2025.09.01.21.24.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 21:24:42 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v2 0/4] riscv: Add Zalasr ISA extension support
Date: Tue,  2 Sep 2025 12:24:28 +0800
Message-Id: <20250902042432.78960-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the Zalasr ISA extension, which supplies the
real load acquire/store release instructions.

The specification can be found here:
https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc

This patch seires has been tested with ltp on Qemu with Brensan's zalasr
support patch[1].

Some false positive spacing error happens during patch checking. Thus I
CCed maintainers of checkpatch.pl as well.

[1] https://lore.kernel.org/all/CAGPSXwJEdtqW=nx71oufZp64nK6tK=0rytVEcz4F-gfvCOXk2w@mail.gmail.com/

v2:
 - Adjust the order of Zalasr and Zalrsc in dt-bindings. Thanks to 
Conor.

Xu Lu (4):
  riscv: add ISA extension parsing for Zalasr
  dt-bindings: riscv: Add Zalasr ISA extension description
  riscv: Instroduce Zalasr instructions
  riscv: Use Zalasr for smp_load_acquire/smp_store_release

 .../devicetree/bindings/riscv/extensions.yaml |  5 ++
 arch/riscv/include/asm/barrier.h              | 79 ++++++++++++++++---
 arch/riscv/include/asm/hwcap.h                |  1 +
 arch/riscv/include/asm/insn-def.h             | 79 +++++++++++++++++++
 arch/riscv/kernel/cpufeature.c                |  1 +
 5 files changed, 154 insertions(+), 11 deletions(-)

-- 
2.20.1


