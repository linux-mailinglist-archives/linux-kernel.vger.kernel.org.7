Return-Path: <linux-kernel+bounces-870060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201CC09CC2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A1BE548868
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3AA3168E0;
	Sat, 25 Oct 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsqXuqo/"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D653161AD
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410474; cv=none; b=UGTFKERguwcvK7ugM3/rCApSt82dPwZspt/k7yDswyvPv09G16sxeocmojXpToEDEOZNiPytCUTrhFc/oRpk60KNK/njYnqn9+qy+lps4yFvYQoUU2LtKQNgMWmvMmaCrMRz8WdmUble2AWXkDFBrKTtGjSODFGFZqbDM474CnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410474; c=relaxed/simple;
	bh=BQ3V3TJBGcgRl9M8TTeR9VPGV9MIeZxMNrPM3NKIWvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCE+qRDrphCfe3LTweGZAZYEL3ddBeWWz5e+it36LimsL93so/7m3fZxAsJJiOVWvGvGFWBPDjvyyhBQYAr44NxFfDyd6+xPRS7hd7LRCAHo6UwhHZkh9zgbVLmb7FZHyRw2rV+a8J2ZwbezPQ7u+lL4kTQBp/SedFz4rv5k9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsqXuqo/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87c148fb575so33744696d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410471; x=1762015271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsJVQgpn61zq+Ge6F8BtEeBoOu3oJNRDvnauUG9sJYA=;
        b=WsqXuqo/Tuhsx8Pu0PZaNI1ZZo6qxE87GS5+EtiO+N9LGzOtQ0k5M+00e2KHd+385p
         j5yXdY/w0jMFqwq/onjBqTNQ8Y0u8pEGljdMCSje/jq0JsBcwi3VB79cWCQtzOFmOdye
         4cL9exeCbeQ+uBHJ1vG8Y7quQKeLMwHy7229GKW6zW7+9d1noMeGoI7TnN9bQ3vI4qRl
         +detcSFdjJZH66iobjs66pNk3Dcju2KrfPnoE9CHyqKlSagJT5Exukig/i6+uSC6uMIw
         QCWGGGkyk1Yj3bVgea9m7NlkeEmjUvjQZZWemkavL35xK3kxORktOPwPcI38y2fD8TJh
         1RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410471; x=1762015271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsJVQgpn61zq+Ge6F8BtEeBoOu3oJNRDvnauUG9sJYA=;
        b=K0+GiSKZyHr93RBZ+g7My8PlEgZJ7EaS6vZ91SzKkul6BcQPo9hGIl1K2R1TP5kIZV
         y6Hb2GNAzYXZUwz+SBa/5alw6euJbNdctDDVCwqU39HjRy4PqK+VsVLF4CfeQOAWUgR8
         Vo3qgj5TGb1bo/8X+ZxxX8GeZbIntkdSnxPIxw7LXUuoUcTryb1f3QuduuE/2dnPJeDO
         kwPcR7uJw1RpMp6jzcwzMKjvmmn9EgXFY8MvktSThTBIDbVAn3e8eDzdFjNmjD0tWKay
         oYEs103y0cBFte7bxMhmTteJQMtnPKwKYU1bV8P88AacLGm4fSxX4KH7o388Kv8VLaNb
         jvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB1PmlJJs3LV4B4z6dgIoYXtCXo7bUxJmim6apDeVI8zbl2/M4ugq6O9XsiaOR39KngL8ljdAwbLWEqhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GvMNaXOHwa43QojUkbSPSieLd6oFBNvNcvgPZS5n5oolSXN5
	4ysVyxbyKeBI8LdWJJeTVP/NdxeXZllwqpBvSyNC7oT54leZBXIv/cSZ
X-Gm-Gg: ASbGnctJ2j1GMxINuymTQHvYBBcqSMV3pW1QZzxLxmkGm1bP1snnar7pQfayGW6l7bM
	UiePD69s6aCqsxtiL57eUa9ZnQjc/sma+5YeiAFncfPbEEIhk1Bvr4bZjJcaIMrnrJC3s5MXDhq
	cnw0E/7be35AaC2kFNZMHg8kVHOfR06t/HBl6tvibMRasmO3+YgGYHdrS++36kcjvm9rbzQ90Ix
	YY8mcf6TAKen8T8KqQrU1d1nAIAPdK+Il3CmyuPZVIjcZ/7aj7bqu+NFBPok6XN+j+Tz9JiPKt3
	X4yyH/pfqB0H0bbz+MhZH5MyNPcmEKF+etlnD2yewjayu/lUBWsZ8wfLCD2XuhU+RB7xtzjovCI
	9hne3DFA8/mjRdkQdt3gx/WeeWcPR8CYlcaczhy/9nrMkyPiGjiwyGG/7fJ1hC0rjcWCmLWHA
X-Google-Smtp-Source: AGHT+IEL1Dx+4HYqw+4sQyuOiRieC9Old4SO4wr/AN35TA8qAjfv9mLDb5RqV2L9cyVVu7WfD8Eouw==
X-Received: by 2002:a05:6214:2aa2:b0:87f:bb8e:410f with SMTP id 6a1803df08f44-87fbb8e4dfamr72431596d6.50.1761410471178;
        Sat, 25 Oct 2025 09:41:11 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49783eesm16403476d6.44.2025.10.25.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:10 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 15/21] bpf: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:14 -0400
Message-ID: <20251025164023.308884-16-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. BITS(low, high) is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff40e5e65c43..a9d690d3a507 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17676,7 +17676,7 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 	 * - includes R1-R5 if corresponding parameter has is described
 	 *   in the function prototype.
 	 */
-	clobbered_regs_mask = GENMASK(cs.num_params, cs.is_void ? 1 : 0);
+	clobbered_regs_mask = BITS(cs.is_void ? 1 : 0, cs.num_params);
 	/* e.g. if helper call clobbers r{0,1}, expect r{2,3,4,5} in the pattern */
 	expected_regs_mask = ~clobbered_regs_mask & ALL_CALLER_SAVED_REGS;
 
@@ -24210,7 +24210,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			def = ALL_CALLER_SAVED_REGS;
 			use = def & ~BIT(BPF_REG_0);
 			if (get_call_summary(env, insn, &cs))
-				use = GENMASK(cs.num_params, 1);
+				use = BITS(1, cs.num_params);
 			break;
 		default:
 			def = 0;
-- 
2.43.0


