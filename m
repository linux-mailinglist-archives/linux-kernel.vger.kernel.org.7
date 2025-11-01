Return-Path: <linux-kernel+bounces-881378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA8C281A3
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775211A21B9B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595392F2915;
	Sat,  1 Nov 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MO+QIsd8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E562FB601
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011850; cv=none; b=kqR4CPpiBKC7NbQOgilYnCREQemQCiOvBbNdltDJ1JdDIOzl5f5I9s1SQP1JstYBOhnAatqjZfKSAxcbEVmnFWG7YsIhWtO42A9XA/kJOhZJy7Dl5oP/VDW6XJvr9/8R9U+Ag4+zmKUVwE/xJM1nN1f2r3pWz4++5n1eMKucjLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011850; c=relaxed/simple;
	bh=25h2zSA984OKtQmRh9EqfuGp/YR9+0RmE5X6wuvM7LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu1RyjKANq15CPAviUP4ZmuE6KOiLHVqlzKZkG51cyJLnESMxZmKon4fIlHHAY/j3FCl3THbtOS5y6NsQ0Ogn/ld3+ayaDBj18PI8M4CV+oXFEhFRPWYr1rhi6gdxqscybCKsFL0z7WYWQ5QFGrOE1QOmqhvXZslGtZrIYMA4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MO+QIsd8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2957850c63bso1466865ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1762011849; x=1762616649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2XwcEWhGPqe4YWn8OiU0EgUYXN4uylgwxXcr7hecLU=;
        b=MO+QIsd8rzwC+6fGbbHdHtttAcm/z4thyOIljW0sP8tnYxLqk+JehlOZUrJGMhnHvd
         NYQ1yggIB+3gPNH0EtsfQ9f0mbUMGWZmHkmib0YMipc4TUJJGMdU2yJTX2zXCan46sci
         DyA6Kks1qZ27SUOCUGWkZBIM2emfnATdBkMnZl6JRI+NjQsxssUUe/F7CBNJcUb8uwvU
         yLRNIzbb5vBaUEJAf7fdxZU0WATnw/vckiPN3urFBewXkxgGe/OC4WXGDdzMcZmg3M7Z
         fpNO3xxOPXdlJpopwWrvlnzxIeNQmGF8wSEdql5k3+79t84y9PNS2wKkk8FBrwMrGaFf
         MAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011849; x=1762616649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2XwcEWhGPqe4YWn8OiU0EgUYXN4uylgwxXcr7hecLU=;
        b=vbdbWR1GYqsymZKEje5nmZ+W4zYIQlUJsD7Zqx9nnczIj9XSVGXc2yqcsLnyRXzexE
         8Ep+aZzgJXk2pV5Dnaf6ZRnGGSxAwaSFD5+dR+SO9jVd6GN9lKAKywPcJGSJcq0hX3dO
         W9LRBKLprqAsClc133jD2d0H3yJwlqF0yWYmpH31sZAHTQx12lG+sIbGtW7Zr5VLZdb0
         fS4Mx4MWmnHlGLqC4SYs+sLgsTEr6zx0/6bHDB2JvNpB+hEp9O7ph50zwCvQ/2AE+h5q
         NB+A8CNvM4dydwO3vF3n9TcGWja5ZMnS4NZxdaOrDUjDoOd1a7bSdzpd/HK6ouRMiJdb
         otSA==
X-Forwarded-Encrypted: i=1; AJvYcCXT5XVZc340yjxuzh0ggFqC+XjjxT4lutNg7T0s+ivVr1klY3XsWuIsWRyuiDxLqqu46vwuNZC+Cx4LOng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyjeecHaRGHP/R2ZGpkcvhmmOg77ed4HN6RO7zHysM3z6vxFr
	oNe5aWf/pgWzY3vkICQ2+REP4tKB++fe0PXki0loZpYcYw4ULy6P/GHK2GtL4RcR00U=
X-Gm-Gg: ASbGncur3VJ/SmY8LmCQxfom+H1NdFutJPMFhC26KZW33A5VY3/URMbJwcjYvMHRw+S
	VSgcx1u6Ae8V4Io9EcK9HzEtfL1Qwirwa+rmsgWw9oyL23pnopIfjiuDYCUGGXVUN+6ZOOhk/x9
	cHn3Ni9lICpiqIv9uyxlhrwgGjqvyVOYZ3ThPgGjtwlVbC/Soo4r3tDVOZPTKpikAUTJBn6rsQa
	VYNizkW0Ep1yvbdLO1Ad9Wi0sR4ENuZqQQq4ClQzoYeJ6VLUJHYIyCnNCwp9GomHCTQlk8K8jjp
	+aIZEB1TKiSTc5ukinbb1PUyowvwFx6HMIYvHacI1v6e7SqvUTEE6p8kGyGQms9B9VE8g574yfb
	1MXRhEFvT4GjBiqxyeQU/afDx0S3igImjcL0yxt9gwz8RJX6bbbaCKPtIyniuhcXGpH94+PjddW
	1PtjLIkTZprziri4kSA7sUTcu3zV9ZPi8=
X-Google-Smtp-Source: AGHT+IFLXAEw3tjU/Pr/6wioFbhUuNkqtSYjBkNNCIo72pud4xy2at7NIHMIFUUJC02TK+9WqwH1GA==
X-Received: by 2002:a17:902:cece:b0:295:5898:ff5c with SMTP id d9443c01a7336-295589900b9mr26809925ad.16.1762011848203;
        Sat, 01 Nov 2025 08:44:08 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm59990105ad.105.2025.11.01.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:44:07 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 08/12] riscv: Enable DMA_RESTRICTED_POOL in defconfig
Date: Sat,  1 Nov 2025 21:12:41 +0530
Message-ID: <20251101154245.162492-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101154245.162492-1-apatel@ventanamicro.com>
References: <20251101154245.162492-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V ramsink trace component may have implementation specific
restrictions such that the component can only write trace data in
particular parts of DRAM.

Enable DMA_RESTRICTED_POOL in the defconfig so that dma_alloc_*()
and dma_free_*() APIs work for devices with DMA address restrictions.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index d2c1ea2a866c..4e870b8f2220 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -305,6 +305,7 @@ CONFIG_SECURITY_APPARMOR=y
 CONFIG_DEFAULT_SECURITY_DAC=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
+CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_FS=y
-- 
2.43.0


