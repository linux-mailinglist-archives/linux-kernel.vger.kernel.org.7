Return-Path: <linux-kernel+bounces-870038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D66C09DA0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A89D582F38
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618630F950;
	Sat, 25 Oct 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J16YheW/"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804330F81A
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410016; cv=none; b=g451W45C2Euueo0vvl0qFitelSvLNOBvgvi+jMgMwTBGkUJ806KNgH1xYvmZePZ1j1ErI2r8l+XGqza4SETgzOgW6YnpN90Z0mz1qU90EMP26nZKNagNjG5bUl8pzhw1p4NaswP95gYVpG8iIpLBu0ZtvPCP6O+gL5qGpzD2jEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410016; c=relaxed/simple;
	bh=/qN13PxTPUF7Pj/bbigcTnyf8UWTFD28fitKT4TB900=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikjSvwthj6UMzoyuhFKOhJNMIlfoyI+6ldJ9bI/oGVPP5UrCrD7o/kWgovOBQXiDzE0Ln2MbImSERO1G5DX8H+7mH1+qjzgZWN+IEvDSF5G3Uy9VCgPIhQFZDxAZVhny2TiRaShu5Cmv2dGb5orocBzdhBqwa5WMKUqw8w9N2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J16YheW/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c167c0389so33792836d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410014; x=1762014814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgpdQly6UAXSTR5MLgLdCsEnF7u6zwKVu6ylG76tjIg=;
        b=J16YheW/d0Kpj6oKToqWNL82YGbzgixD1KVDzgU5DDcnKRodOb4Bx3nf3jFshxOQTU
         vHGup94W8nAwA4vhCQSuIY6dLNKHkmVvj9RNv2d2Xo7cIfI53G8Yb1K8ZQMKrUp4Vot9
         S0S66jF8eCszW2JfnjLsXQsmDQeB+Ih16S65uvhepxLQxz9out54bD1wrNnzc8MaWtRc
         gU7fzQlTagVNGasJQ4D4sYhdw3g+QdQ6jbs2jS231xdD55jCDtn6JZYlD3yid+ziyNXS
         ZY0EHt9/ZWB8QvVWspjpjlHR77eeXO8QCfXdzOpK9j5mPA2kPKabEHgsRf1yr+uxCije
         yP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410014; x=1762014814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgpdQly6UAXSTR5MLgLdCsEnF7u6zwKVu6ylG76tjIg=;
        b=gWHaTDyhSA9PkOJzQ3zruUvK9qfl2MPIiN7ko7fk5e+MYJAJkTklACjLTSV30UfB3w
         kPE+zwqYQ4hT+0ttq7BG4vbB3dtJyWXb4tlIFWoI2e5fc3llR7TKe5/KFTH1UGgKQqB4
         bQF6dTnP/ilVnRq3f9V1dsZn5I820ZWrx/Fzu467FNEXwzBHTFcfwAQLPEBpb8aSQgiP
         XVlBmn3qLPCPFrTbAEemF7apy9atvo012IEaRauS53TfwQ9eA94puwoYtUvvu80i1v+Y
         OsqAflZAbOUnfH+BZ8Y08mEyX0jR3X2J4nnvwTdNj5Nisk9v83Jhaae7pE460pcIJuMA
         0yxA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Zkny1dU8VYQ1Xg1yAMETfZLbzvN3nNWeDdFduLniNvTVFSKIrGHaB8Nb9GBU/5fkWUxM6sr9x0Rau7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eKP6DcgUKqM421CrhPSUQTZeCPA/ECpXT94GZu8Ei+ud41V2
	/ufnSRAbUn3xCI8waMlXcdcrW5BXxFrLrnpW3/4N9aJXhUwvLCtwt+bl
X-Gm-Gg: ASbGncs+2MPZ31CTHlcqMEBbCcbd/sYQtWgWLHT2CZfWQV6bDKzkFoNVmXCgQ2DZi64
	NpjQNh9ymU1ko0gyvzjYJQp0DBqpKmLXKMhtTG8lt1NdFVgqGXgZvcV3BTOpmeBtpv3zDAi2sNw
	rJxtvDbrKBH7SRlNzEFNslXTNu3a0sChiZYfht85KI9rYLGsiXyB3iXk4vIHQuIL2ximws/jY40
	uz92v/RMTUu785g6iH/e+Q9GrFoDzT7ApeA9JfNt7CJ0lk4o/rUU84sGovgTUNaomMTd6RRcHHc
	+I94CqGOBSlkiYpadxl3Q1R93z/ed4Latko1JrHJMj+cduSQmDpOq7A+wg50C7FTV4TbyJJN2py
	ZOadMezo+eyvMjZks8U9VHNsurIqkluSjeOwiDV+oHX0Vu/vXFF27phi0kd2Y/9WoWu6tvCw4
X-Google-Smtp-Source: AGHT+IGaxqILFk1sWEKYs4/aKTapgVfZamjsAKwhDmFO0q/do78fw/vH+Xpzx9XExIL+rzfn38dWcw==
X-Received: by 2002:a05:6214:500a:b0:87c:2797:4942 with SMTP id 6a1803df08f44-87c27974b5dmr317695766d6.15.1761410014091;
        Sat, 25 Oct 2025 09:33:34 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49fde48sm16301696d6.61.2025.10.25.09.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:32 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 18/21] fprobe: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:33:00 -0400
Message-ID: <20251025163305.306787-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. FIRST/LAST_BITS() are
more appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/asm-generic/fprobe.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/fprobe.h b/include/asm-generic/fprobe.h
index 8659a4dc6eb6..bf2523078661 100644
--- a/include/asm-generic/fprobe.h
+++ b/include/asm-generic/fprobe.h
@@ -16,17 +16,14 @@
 #define ARCH_DEFINE_ENCODE_FPROBE_HEADER
 
 #define FPROBE_HEADER_MSB_SIZE_SHIFT (BITS_PER_LONG - FPROBE_DATA_SIZE_BITS)
-#define FPROBE_HEADER_MSB_MASK					\
-	GENMASK(FPROBE_HEADER_MSB_SIZE_SHIFT - 1, 0)
+#define FPROBE_HEADER_MSB_MASK	FIRST_BITS(FPROBE_HEADER_MSB_SIZE_SHIFT)
 
 /*
  * By default, this expects the MSBs in the address of kprobe is 0xf.
  * If any arch needs another fixed pattern (e.g. s390 is zero filled),
  * override this.
  */
-#define FPROBE_HEADER_MSB_PATTERN				\
-	GENMASK(BITS_PER_LONG - 1, FPROBE_HEADER_MSB_SIZE_SHIFT)
-
+#define FPROBE_HEADER_MSB_PATTERN	LAST_BITS(FPROBE_HEADER_MSB_SIZE_SHIFT)
 #define arch_fprobe_header_encodable(fp)			\
 	(((unsigned long)(fp) & ~FPROBE_HEADER_MSB_MASK) ==	\
 	 FPROBE_HEADER_MSB_PATTERN)
-- 
2.43.0


