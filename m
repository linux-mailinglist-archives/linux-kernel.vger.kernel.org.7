Return-Path: <linux-kernel+bounces-870035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BFC09D97
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7F50582751
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D2A30EF77;
	Sat, 25 Oct 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgGPhXIg"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189B30E0F9
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410009; cv=none; b=WGS7y71j2r4RAn/CG4oUmgR3wyDkRrD6grGP9x3og+/g3KdRYZVtEK88mWzJngEYUF930Zs0Z3hsICI4VzMBmGZyNPGh8lngqi+4dAU3DPFWDq6EdjrLfi69XzrGHazewj5MaKSQ/7GvbJirkqs1OahfHydxfXZRjqttmedkYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410009; c=relaxed/simple;
	bh=BQ3V3TJBGcgRl9M8TTeR9VPGV9MIeZxMNrPM3NKIWvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siyvk4zqE/rTd7DTbzpf0Ok/td85HxrjfnvhNAjy/NxGfmA4/0ztm0pdteruFn8KnWOrS1lPsV3zf+e8vxsu/GGRwU3SfaNiw5Ofzm5GwUkG4sNOIHqr5qa0/0Qfs/0/zqaVtPAbhGyLf+B/7w0REdFMOy/oy2wbnY3rMTUf9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgGPhXIg; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e8b6144288so26294461cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410007; x=1762014807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsJVQgpn61zq+Ge6F8BtEeBoOu3oJNRDvnauUG9sJYA=;
        b=MgGPhXIg0rTs9nmYtvb/bgsKyqiLVN7NdRQ4G2mUrJJ24tquypioARmvbsG+6FkCBB
         szepg08P5WF4NdGZqI0Xo7O8CDdNIiHW0NIeL37ESqFd7lRzgRTmFLOWrq11fPdVjDtl
         K7J0NuKz2cxxrT07ZUXP3dIQAOWjQ8FtWkS2DLI0YqbFSP5QAYiwuPndTkvuwkz+sRTD
         0KRkl62eFG8JDwll390+qZ3Aq1c4aUpQ15vVVOL5GCsMn2xAK8lN+x2f5eJDprckfdOM
         +ol53XJfFVdmcHYbhxZ0ZRWz1nysaDRKGRXj1MDAkbIA9VSsDeADodehyZQYIjpVLeYr
         N1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410007; x=1762014807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsJVQgpn61zq+Ge6F8BtEeBoOu3oJNRDvnauUG9sJYA=;
        b=OuV8kNB/wlm2aElU+3x117eJUh3RGsFr/hmbvrWORa0eucRt2hTZAp6oRcMBvinqgf
         y76YHA7VPpjqVPzNwlfyn65W6Efc4yq/qHBLodepTssgQ8S+YjyhGgwGYe5C2erp+pWg
         quCx+/KT2FaD03q8Fauy8svOLC9hTayH7ulsKuYqEYplqPuD3/xvTDMumdegMVN1S28m
         YsCsCqHEOoJz0Ob3eLetI3EhwPYwfTjhhS28l+UawXmlu1di12DKwRzRDcAjawIjWYQA
         ZkLiunpwni6yEhQe87MMV+EqeU4kMMpYEOmHQxd7YrmdT+1NTxxr1Qf4oDlsnFc8TICx
         7otg==
X-Forwarded-Encrypted: i=1; AJvYcCXHGfJGp0ejMFw+zYCF4uiCVM6f+sNjlGEuBjA05Q+3F2kzjTNNUlyyMyOYZ+peVpXP0DNT83rm8FPm95I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Ab/77B40xcU2HYu/AchFIH+OOPBOU+V2bizmluDH29cWSyxF
	m2rnAszdg+gMKiJmDNzA/QvHIQ7+ovNQgfSbTZX46Gy3q+Z8vZy3y3bY
X-Gm-Gg: ASbGncuX4O3VbhGMeFpFxac6zxKgqf9Bae9XUqLkMgPT5fdOhWb0u2XwY9cHaQwmRk1
	tPymd4z8x/YAGrk9MvNQTUk9UhIJ0NQSPvn/9tlOqujVMRdQDOVcaITaI8QwQakXVmXklQtheIt
	qlt7fotg+qodFIib8OxwyOS11G7NkgIgR9VwkIHacOOsPtimjMDQtaUqpU+HfVuV/7N2EBSeQ97
	urNVYhdTC9h3bN8Nf5uV7ZmRquYzocIlxptY4eADKdlnjDGZoUTSynbD7/8DIi6kBPntd+4aSSo
	4uNtuMTTrnqoL9idvWSXp7LoWRe27lA9jBMIATJKfJTk6MsIpzOloy/Nlze0f46sLVeg4WodFWb
	rNGmcEC1juW46BALX7VeqRJwc2TOJpCSITrPFLrPyRqXJSrQg5ahhqeN4XEUkK9HCbxvda7z1VU
	2QzoqMscE=
X-Google-Smtp-Source: AGHT+IEi0gU3nsclmOfIhkatsK1ylhMxi3V/RcKHP2qNLsK4jpBPuV25o1zZOF+JE24zBQDJY9wwQA==
X-Received: by 2002:ac8:5d13:0:b0:4e8:a2dd:34a8 with SMTP id d75a77b69052e-4eb94912a08mr76566831cf.64.1761410007043;
        Sat, 25 Oct 2025 09:33:27 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25896d52sm172754385a.38.2025.10.25.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:25 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
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
	bpf@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 15/21] bpf: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:32:57 -0400
Message-ID: <20251025163305.306787-8-yury.norov@gmail.com>
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


