Return-Path: <linux-kernel+bounces-813771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA4AB54A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF8B3A2C88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6152FDC5C;
	Fri, 12 Sep 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdqyXZ0T"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5C1EA7DD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674801; cv=none; b=CcZeHVkCc7Pc1eIwzCm9XR9EZcbwsfFdXoia38uNyXt3VumSdPu946/hrzU/caLOifrjgso8FyGtggZk1dTRs/w+Bto4rM2RQjQTpyoaLl45vOqyJTM71U88atwy8D9ndJ/eCEOcLrhPwSQZNSF6ZCQ8kQh4N+NCVpCImcy1/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674801; c=relaxed/simple;
	bh=Lv8Z/EsvKyPQrhIBJmijlUy1AOOhVUCeuR7SE/Sj8/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYY7OY3VlcUUZz3de4qwD1uC73xtoxvhiRmpkWXBEeSMqdgarEOknR/8IE11C+CC1QO40NiG7BO8+uODEkyPn8MzQwTJHFT1EQ3XHZRVdLgWYOf1OCg0pWpaRQcsXnOz+ZcHx1dAbyGeQdLgEthW2YIBaScm2lD2ntf9/Fwj1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdqyXZ0T; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b54b0434101so333648a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674800; x=1758279600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGlezImdoAxOnbpnC+LXTdX0GBXGa9EFQIhsjjJX3xE=;
        b=NdqyXZ0TN6lnejXk0nQ/hpmspsG/TVaRWW2p+pLsp8gnE+1Nddy9isZ+dfEVOUM4Og
         5s1NbIxUwLc7tiBCC753QcJqzlzZPXx+zY26r+RjUZuFc0PZF+17iwnprLsbq0xB17BW
         05tucUtGqVQu0xdB+nCbtTgsyPgjePmLJiPDy2aE/9/hDjPBczHcoEs1dXniY6YJarif
         sJKOyZeuEPGWWVms3MDkBnNCrgmSY+p4KIzze1qBvTfAFSEZvk5ipywbDpHxQ3BLm5R8
         JcdhZW4oU7Jh/VRXHcu8WwtwSfGIVm/cbD9/86KEcfXBPINBXuEiTqlyCgjYP8LaoHZJ
         AHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674800; x=1758279600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGlezImdoAxOnbpnC+LXTdX0GBXGa9EFQIhsjjJX3xE=;
        b=vuyGr/TkwDsCm5dbiSXpz5DQdzHu0I2iBwsyiFSche+9VaqeSFZsdq83RZ+ypB8JMN
         szVUeukm7nwryvCiwmCMzyv9/l3qQLUC5JjeIJLDhUxhFddM/kKfaHQBqIl3wSZoGGCl
         flrz3mWCrnWJTUD2wJv1IkAN88v4cje64tR2xMEx8QwEuEj98BHBeo+Vs9ctTH03rikZ
         1lC0Pk81kwECJarYAmkSkC6mPMqcAMSmf7Kvc+woQCF/n664EAiDEfaKJ9SelBeaWtL2
         bv+yHaDy3Aotg97j266kNgDsAYH5KM20fSyZcGP7hP6ghZrf2Zu/xuLGv8CQF93LXg/A
         Sj9w==
X-Gm-Message-State: AOJu0YzO6fPoLfeouc6CX7HtFTYrDervqrnYmPPEMh2+vRsWgYyWxHlU
	uaMLjgNQkPe+8gqTyK84xwWRXmIMb2w5SCZ+j0IHQuWihMwyktwtVSnJ
X-Gm-Gg: ASbGnctf+cREKkaQ+DgnhVsZ9awqRmw3ncrQjR9V+eLppvn3VLNyIAT4QXndI5v2aUp
	llJKb6hEOSZ9pDMgqTKNHPh4WXgGouTAzvjTqvcIJD8Z4l+5nd/UaEr0GSu/+uajy5LFubyHJ3G
	6igt+/4qKCzdYWiEQ1f3vRI+wFUupdOy0roJkMgzFIHb8Elgv1o1NlVYTdqVPb5xOpUPVCElYhG
	sDwLRNTsaIsRvVw5rI5lPxiXH8PII4Ypo//I66exK32fw6iZUV8TNy+OH9w6fbi3bREZdszya4k
	UR4KBEFnAFtxdm2iVEnI+5NwQWqxymrr1y9QdHnOMjn351DZryXBApvRJ1cLBC/uQvbvxUL/ksK
	QdU2S6n8/DqnY4JWLDTn/HsKzn++e/pFWHPaU+6XMOKdVS2tU2hA=
X-Google-Smtp-Source: AGHT+IFW0sVkWLfTATGOs+e3L06riQgTnCt13Di8cg085uzPoGjrDKDDcAkFb4jmVbnJLc9ZMCGtNA==
X-Received: by 2002:a17:903:2f4f:b0:24c:99bd:52bb with SMTP id d9443c01a7336-25d267641camr32497785ad.30.1757674799671;
        Fri, 12 Sep 2025 03:59:59 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a789sm46074395ad.88.2025.09.12.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:59:59 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
Date: Fri, 12 Sep 2025 18:59:39 +0800
Message-ID: <20250912105939.1079014-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEjxPJ4naa66Aum5YO0jntY5-reXxF5Z-=JYTcmb7WFCBODAHg@mail.gmail.com>
References: <CAEjxPJ4naa66Aum5YO0jntY5-reXxF5Z-=JYTcmb7WFCBODAHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > > Baseline: 512 nodes, 512 buckets
> > > Comparison: 8192 nodes, 8192 buckets
> > >
> > > Metrics (Average value over 1800 samples):
> > > * Bucket utilization rate (higher -> better, same chain length assumed)
> > >         * Baseline: 52.5%
> > >         * Comparison: 49.5%
> > > * Max chain length (lower -> better, positive correlation with worst-case latency)
> > >         * Baseline: 7.5
> > >         * Comparison: 11.4
> > >
> > > Experimental results show that scaling buckets and nodes from 512 to 8192:
> > > 1. The distribution uniformity under the current hash algorithm does not
> > > degrade significantly;
> > > 2. The maximum chain length rise significantly, potentially degrading
> > > worst-case performance (ignoring other code in avc_search_node function).
> > >
> > > Details:
> > > url: https://gist.github.com/zhr250/cb7ebca61ff5455098082677d75b1795
> > >
> > > I will modify the hash algorithm in the avc_hash function and collect data
> > > again to see if we can achieve performance improvements.
> >
> > If you look elsewhere in the SELinux code, you'll see that others have
> > been converting other hash tables to using the jhash functions, so may
> > want to try those here too.
> 
> Or you could follow the example of ss/avtab.c which was converted to
> MurmurHash3.

I read the code of jhash and avtab_hash, it seems these algorithms are
more complex, with higher overhead compared to avc_hash. For cases with
a large number of nodes and limited number of buckets, the benefits can
be significant. However, for scenarios with a small number of nodes, the
overhead may already outweigh the gains. In my case, 8192 nodes are
sufficient, and I'm not sure if there are other cases with higher
requirements.

Based on the 'Max chain length' data I presented earlier, if we want the
hash operation and table lookup to yield an overall performance gain, the
overhead of the hash operation should not exceed the cost of traversing
4 additional nodes (11.4 - 7.5 ~= 4). If measured by 
'Bucket utilization rate' (~50%, means average 2 nodes per chain), this
overhead should not exceed the cost of traversing 1 extra node. Otherwise,
even if uniform distribution improves lookup performance, the hash
computation overhead could still degrade overall performance.

In scenarios requiring a large number of nodes, it seems necessary to
optimize the hash algorithm to avoid excessive bucket allocation for
maintaining performance, which would otherwise increase memory overhead.

I will first refer to the avtab_hash code to improve the avc_hash
function, and then show you the data. I will collect the following
information based on several different configuration using the same test
model:

Baseline: 512 nodes, 512 buckets, original avc_hash
A: 512 nodes, 512 buckets
B: 8192 nodes, 8192 buckets
C: 8192 nodes, 8192 buckets, original avc_hash
D: 8192 nodes, 4096 buckets ("large number" of nodes in limited buckets)

1. /sys/fs/selinux/avc/hash_stats
	a. assess the effectiveness of the optimized algorithm based on A, B
		and Baseline. Expect bucket utilization rate: A ~= B > Baseline.
2. total latency of hash operation and table lookup
	a. A vs Baseline: expect A is no obvious latency increasing
	b. B vs A: expect B is close to A
	c. C vs B: expect B is no worse than C
	c. D vs C: see if we can save some memory with no obvious latency increasing

