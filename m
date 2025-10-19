Return-Path: <linux-kernel+bounces-859785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 886AFBEE915
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECD7D4E2D2E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59E2EBBA1;
	Sun, 19 Oct 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqiB9if1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883D2EB861
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889577; cv=none; b=UPb5PRSzHRNBeF6hZe5K65g2N3o9QXujyYHDTVIDbk/jPim7TMTTuQttc/xP72uE2uBIAXoyD1uFJET80UtbwDhlT7JfbUr3IObMrhHwPW3AmkfFgy0VrZVHV8tAayyh3gxCXWvve5inr7fmEV9NuB0Eqj0lwtq8cDpLnAhagWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889577; c=relaxed/simple;
	bh=iUiqK81uM8PaPVQxTA7XtGIXzW7e9qwdKERuYe+D6p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WcBFWV6RQSiS7A9c8A9Ahxs5m+LbVgBMmRDFpOMVK1P+F/UKfo/M/g4mlcdE0HVpeu0199WuyiM2JyPCK4hRoQMlPVKgKkG6dK6u20jkUz9u1d+SVBAUyNNaoXdehpz28NQ67yyP4xkQV9Thv9VuA0zgUpI+1S+l1OmFaKqUFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqiB9if1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6a29291cebso6018666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760889574; x=1761494374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTFzpahmqTTHRcTI1T2SzZtl71JkvLUoqnEeOyK8S18=;
        b=JqiB9if1ZGaYuENOBR81msvQE0BQRO9cMhJ3+vGJ1yxN7kzSCEYwssWYlw+QuHVE2+
         YcRctv71CJxh2Gj05eXxsZ9TEEVWdy7JAeSsZ438d3lg/dDdhMtd5rv0I/qHt3z9EiGD
         mnKMp+iqBQaMzl4M5AJUm4ZKoQ1opHa3WhGUKVrECZ3M6nwf57zgVmr7yQhRD6d4YSyW
         tnKvmp5+EyZ+cGm2LNdnACl6on21Qlu5Bvqg3P2SDLU1tHsc4eb82eTkV6KXS7RjgPj7
         c4G42SOyRudkk2jH6V0SPeSZ/Ys/j/1lN13KrvXsJudGDeTPxRWfeVWbIyf4v5i/Ckzd
         tIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760889574; x=1761494374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTFzpahmqTTHRcTI1T2SzZtl71JkvLUoqnEeOyK8S18=;
        b=cwBTTGpdwMKB9WGbxCZuInMuxMgYCUjb70/AyWZUNrHwWS9/B4HdHZtoSsQ9PMBJzB
         ADp/KIsDre3fyh/PzFfwTY6GJqmiIeWC6vL+YX+hd9Nn2rYpnF/MpcyM0TLb5VGJuQYU
         BGI6shCdA2uUms9RcsXfToBoBGhb6KU93vZTt4wEayGdXqdmofXm8fDIDDXFO3J5Bm8r
         JTIDYonYc08elhP1r7hszJFtxO/3JBQHRJknqLcsxycakuwum9Rgtd+orD60SeiIyitA
         flIv03HctvFWkuSEUiUcNynqCfigwtAALgv+kBZRAYcsB50qXA8E13/t/kNisR5nrHIa
         xO0g==
X-Forwarded-Encrypted: i=1; AJvYcCWxpYKrYDtNbvdFkAxTisyjXjInzZlwRZ3GgkJiqSqUwyRs4r+HZ3k0aI0b+6lOtkvWl1JDzCqogMlqQE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg4HsFOsH4b7uqOuE063/m8ntRSZXwX3GBatK4DlyX2MMN/NjG
	ASM1imXXi4HZkNfKLR2sSvwpQr9FPm8YUirhiXWv6Cf9v8bPGtnqovqK
X-Gm-Gg: ASbGnctTEAnOSGp1dQitjqexfdm4ABc8Rorwbq3e0lH0A8dGTO27Cf6Jeaa+CvhXFKD
	P+s1RiEUPc45bvVxGFItW+bPlxpAccq7xUPfIkWt2RTZmuOISfYHqCRD/rn7panZLppiMsQniu/
	o2yUgrVWjFrDD5Ka8NgPugrk5wWcyqnYUI+AIyHNOgBGX9pAukZ8z6JGG4ybFCUoJIcW8W6f21b
	pIddkD6qT3XCFR9KZzVrVNhSdnREdC7szYaCkmZ1bJAU60jmWgAAL98YIzX8uymi4tPN5atDVF1
	Q087+/qFY3B+ztv+QqIX0lO6zouCl+oLnmu8Ly0Z/EvwPKQalPCb3KsBPpvjE3VGnIg3bUZU2IZ
	2PWFLQz1/y9XgL9eSuZYXa53Do9M+xu879W/krt6GOP9G4sHsqGOZ5iE7iRtmBLQQF2TNEIYjML
	iALczGMAQRFUm11Sc=
X-Google-Smtp-Source: AGHT+IEHxFRE2pa0L8rXNH1hFC+5I0ryoeM29tlY7gH4lN9MekBBWKyrE79bZEqtF6jDZEgGQtZo1g==
X-Received: by 2002:a17:907:3da9:b0:b2b:c145:ab8a with SMTP id a640c23a62f3a-b6472352847mr655876866b.3.1760889574232;
        Sun, 19 Oct 2025 08:59:34 -0700 (PDT)
Received: from bhk ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036307sm531554766b.45.2025.10.19.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 08:59:33 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH bpf-next] bpf/cpumap.c: Remove unnecessary TODO comment
Date: Sun, 19 Oct 2025 17:58:55 +0100
Message-ID: <20251019165923.199247-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After discussion with bpf maintainers[1], queue_index could
be propagated to the remote XDP program by the xdp_md struct[2]
which makes this todo a misguide for future effort.

[1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
[2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 kernel/bpf/cpumap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..3c05e96b7d2c 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,6 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
-- 
2.51.1.dirty


