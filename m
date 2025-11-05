Return-Path: <linux-kernel+bounces-887253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93509C37AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 059ED4F7571
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B32FB0AB;
	Wed,  5 Nov 2025 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gDUuJ/02"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C54311C17
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373676; cv=none; b=sty5WEHXKrRxEHNjW5ZuglAQOPf1JswDSu+4V9WJn/edL34UUO4CLayQzoPvXnLtme1raVY8qQro/Bu7+8UMsNRh5GleVage3YAN0etHhUiDdmKGrbg09CsFS97e7BsOzcJPunms42YTHVpjbDz7uirqPP5REXFRPUYc/ca99Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373676; c=relaxed/simple;
	bh=FQzNj/iI21StuEtNBXSJB93avwyumsTpx259DhyFqdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzK23EsaYgfHCE5JZNHqTuIAW+ubZhbpsxKgHH6yKMthd+i7G67la9baEKnRrJTDTvcB+wmlM8IhslDweVkMwfQe+e9+q92vVP1mWzG3rCWURMDhYOgzne4mTn66cqxPX+V2ONzNuCr19g4dU+TSGLwRBYeCWH1uHfAUmeYXnAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gDUuJ/02; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b728a43e410so26035866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762373672; x=1762978472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6YOD+qBBkgg+BsuL1SBWq+3Z34YLCPMyV0Nnl+sTk3w=;
        b=gDUuJ/02vYyIgH7+jip+SvAFgZlGAZhJAvoSC6XhRPgbvjLFMk4otFzmw7laZ5gzmc
         icMR/h6bQUqZucrXoqSou/cptL7ThV6lcO5Tfio6cUmp7RnPoKUz70whgjdx1JAdiwNj
         aNuqfHkxG6dVhf5msmPfD99s5YUhip+HNIs9d2+nk41F3YiV918UvYhdpa19kePTiiDf
         SgwUM52q/7SBI+DllLta5VWv2C166YCEJifho6MyeqBt7YTONgj8Jae4YVrngWYqt8F4
         dYxyFQ6nZlqShgQqnbzMXdPu4RoiqMIJT33SkVfPXBO3SXV7LfbPK7lTKbFbITB3S+3m
         FO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373672; x=1762978472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YOD+qBBkgg+BsuL1SBWq+3Z34YLCPMyV0Nnl+sTk3w=;
        b=fhT/Gt6QOcvTIgHFUB2q1vcT9zBrKG9GZUURBJgBJPr3ST36YKofcscl4QaZ7nZ5qm
         t4D8YqpSPSnI+kwnv9tBwT9kcSTFnM0vYrTUvpPBaPrnJtoUkg4E2/I6e1wx/9i6OJgp
         JVUUkHVCgniD+ZZcYNXsuarwV8rrVt3Z6gujxiEAPkMlJ2bBjghGgv4V+tDNCqQIlE+6
         /hZ7kuuGH1dg+eAff1NnkLvRIFO3+GVnsvLHZawZjN0CZ/Z0BDH1k7Ugx8oxDahW/Nki
         9UA9LSgVtCw4i2myE+vS0CL5RnJnGsTuAopDD8ckMhzIAyeeeKfKWp2isfbIHqcVUd+B
         4eWg==
X-Forwarded-Encrypted: i=1; AJvYcCVeDjF4ADMJsIgOcGgvlZjnL0guQLt4tAD/O6DbTt60wIShp3W8zvMLlyHmgFAuE/Xibo5ahnETVVUHPK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FW7icPrL5YS3vsPGwDyz74hbttMZEaLUiqrferXqzRsEZaFK
	loAuGzjLWYUcE1LEvau/mxBIQ2ciMta+fiYMsKCMbfXvF3/NHyN9lQF3YaiRYXh8phM=
X-Gm-Gg: ASbGncs7SuLJtu3uhKSb6cGNh6B2vy7T98b/dStn9YmMd8Uj4IQzKL5N1fN12tfUThI
	+oNulrFBBPjl1hcCdMozg7pCKVmq5xZa3HepAipuyH+ZMzHc96be/bJCgN2GCYXeOwCo1aXPgQw
	CUuUNBWs2+LN/0/wCyfsecoiM6mzgl2m6wXqbmXa9zKMSWGSWHTYDp4XPXUPLP8CU4zrxxXrnUJ
	ItatW6oOa0wSbjuK/HezHxyj9Hmll1Hydzt3+Y0WRFKiempiKmSmLLUi522nItNCRntbWl2L6S8
	sbgcv67dHywINNUCsAVg+kwZdjvVn5H2YwN0cEy4Dmc3guyZMeRwItg4M1ulTiv4uTzl8t7TQ7k
	bDfWlzS1D/ggUkcpTrsLSI6K1lg2bSjKnO2Jtb+t5k8P+7pBZMIWpA/ghDp1sOFq9Ckuq21tXC2
	rV69DuKyf7l7mHZAZZK4Q5/GDRmAI1uVTDP1Oqonw=
X-Google-Smtp-Source: AGHT+IHz4N+UDv5hA7YHGT9ZSBnETebYj3ZBuTUrybneyCPcbhb+U0L/RcjMsnvhLc9I+xf3WZ6OKw==
X-Received: by 2002:a17:907:9815:b0:b71:854:4e49 with SMTP id a640c23a62f3a-b72655edfabmr463264966b.56.1762373672395;
        Wed, 05 Nov 2025 12:14:32 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650967e11sm4101625ad.8.2025.11.05.12.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:14:31 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
Date: Thu,  6 Nov 2025 05:14:13 +0900
Message-ID: <20251105201415.227144-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netif_receive_skb BPF program used in snprintf_btf test still uses
a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
available and provides the same functionality.

This commit refactors the test to use the bpf_strncmp helper, removing
the redundant custom implementation.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 .../selftests/bpf/progs/netif_receive_skb.c       | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 9e067dcbf607..186b8c82b9e6 100644
--- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -31,19 +31,6 @@ struct {
 	__type(value, char[STRSIZE]);
 } strdata SEC(".maps");
 
-static int __strncmp(const void *m1, const void *m2, size_t len)
-{
-	const unsigned char *s1 = m1;
-	const unsigned char *s2 = m2;
-	int i, delta = 0;
-
-	for (i = 0; i < len; i++) {
-		delta = s1[i] - s2[i];
-		if (delta || s1[i] == 0 || s2[i] == 0)
-			break;
-	}
-	return delta;
-}
 
 #if __has_builtin(__builtin_btf_type_id)
 #define	TEST_BTF(_str, _type, _flags, _expected, ...)			\
@@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
 				       &_ptr, sizeof(_ptr), _hflags);	\
 		if (ret)						\
 			break;						\
-		_cmp = __strncmp(_str, _expectedval, EXPECTED_STRSIZE);	\
+		_cmp = bpf_strncmp(_str, EXPECTED_STRSIZE, _expectedval); \
 		if (_cmp != 0) {					\
 			bpf_printk("(%d) got %s", _cmp, _str);		\
 			bpf_printk("(%d) expected %s", _cmp,		\
-- 
2.51.1


