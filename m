Return-Path: <linux-kernel+bounces-827229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF47FB9135A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546D14217DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105A309EF2;
	Mon, 22 Sep 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii/sfJTM"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF73090CB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545383; cv=none; b=rII7wrURLDL2asKJWWOx4zhL3/b4mYWZuxX3W4TS6r8fkKLTH7q7tCFL/L+3tJdUxbyAbM+sP5I40soZUFrTx+T/GOIoYOlFZIkej7/gsg36jCFXev1xq9P0kWiDjObs9Kzx0/zOi8V9bxV6iEKlKiUYsTxUxZ4t94Vvh4rPkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545383; c=relaxed/simple;
	bh=72xINJxwfWCjPzDYknkvknCftfqpRGYVTgoJ7cd1Fis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8YtfsIQfbcZXxgqsuVZ2Tsk1DWfoQMfl2fNshkgSpqMQLMciS7fGpQLJ3+66CdVtP9OducyEL8SMY+k9K5K7YOGFnrDbfpun6E45ENSyaVqL5VqrIxkiJV0TGIF96sLLEkx9dzFASTutJj4OUTbuTE76TO5ggIvx+6pnZ5IzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii/sfJTM; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-25669596955so39138135ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758545381; x=1759150181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72xINJxwfWCjPzDYknkvknCftfqpRGYVTgoJ7cd1Fis=;
        b=ii/sfJTMMsLJrDJaSVZ6QD1jZ8bw80lisBBdAKUvU3SzLqx5Jq3/GAi4lWWZfiocN3
         uHz1xdz9bj4BO55Hyvw6VrIPtSfH/kQkcQHhl3akriqeo6Zoj2gdeO/tPft/3k2MI1WU
         gvGZKaIXr4XJVBOwZRWnEsArxsdP7d46M7MrPfCKaXH2jy61V9dJRrY2XimNZISIilFi
         IJlqTz0sywvpM+7ABe0+jfCkAxEOf32hQ89o6GzRPuhQM/hxltmY3AVGK8+LjeA69znG
         gO6t6rYiuz0/wYQnTicvrx1tZxXPjHlIuG3kEmPiKfVRyai4bnvB+PXdD3zCaxASqgXN
         iDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758545381; x=1759150181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72xINJxwfWCjPzDYknkvknCftfqpRGYVTgoJ7cd1Fis=;
        b=rPAc6wyOzIxrdnR4R4dYh+bix7SZJxZKm/hFgNpRDgpoQT/ewMUZmdOkhaJv1/a9lT
         Aig7L1MCCGuNjbxIpZi0QjCYIWxAnb03yW/9a9zEBaUKSPTV+h800WrIpC3298FNMi+A
         b05rh5GsQ7K8M8RT8UxAG59moQYDgqtG3w2rc7WhyNSZoSMHIFex+c7Nr0wLI2nZuP4o
         5tmWY+LKRYv8h2nEIRWGQYF6yg2xM1FEytBGOWhpEXdBdkMLWSiccYm0QnJxgxeCL+Yx
         BxutSoyAu8+qKShL9nszQoIMLTAJgOAeFPPDDlOlpZQag/gkrb2qapQ5viXnvfM5ftBg
         mr8A==
X-Gm-Message-State: AOJu0YwUbO/JY6gyJPjlCxJP0TNf1cPsbIpVdP48hjRBV+9qotlBhmfn
	0PdpLPt60HBiXoDFZnBSDGeNpy0aO6Uf2Hfb+Yiib1XXC8Ql+OzTzxnF
X-Gm-Gg: ASbGncu/gld//2huClbabEenMu2lrQchtZ/9823LyOsTB7epWbL+TG9KcyckT2XggQi
	20To7TlvcAGgUSG/JUdaiTWuEi5cKUbcktN8SFh1ho89w5RGb4r5UkEyEjv46SveNAE9gYsQNPT
	YA6Sn899kjAdRgb0PJ/EHH/hs5pS/VwR1QqE6+T/PTCskd2dfTvEsT236ZkBlgUjGf06IxGNT1w
	K2SbiwSm5EggkKZz26o2YqcDk6sLYsyoZOXPCCvWrwmf27zqs47cC6igEsWYarz44xCm0OKWgBT
	5LUEMKUwygKzo20dvLMxXFpd8ZToSplNbvnFeCcjA96YdqqvmuAK4cDDywNZ1FdmcoXV8xQPPUA
	aHJK69Jvm4iHJLQ1AEwzZhslLXcQWTZrV+uHE4m9toPZwnSylJI8=
X-Google-Smtp-Source: AGHT+IHLkdd31s0BBY9824+rv3LblWPuwQwTjzF2olLliAheKwRkIaLxNxoDa9KmpbrowO9UkMVCsA==
X-Received: by 2002:a17:903:3b83:b0:25f:45d9:6592 with SMTP id d9443c01a7336-269ba558c7amr145199075ad.48.1758545381429;
        Mon, 22 Sep 2025 05:49:41 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053da4sm132593165ad.20.2025.09.22.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:49:41 -0700 (PDT)
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
Date: Mon, 22 Sep 2025 20:49:20 +0800
Message-ID: <20250922124920.262151-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEjxPJ41d8WcEh8QYp9E63+tCO2ukE5UWvCJ-hoXgN_Sx=P_-Q@mail.gmail.com>
References: <CAEjxPJ41d8WcEh8QYp9E63+tCO2ukE5UWvCJ-hoXgN_Sx=P_-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Given that the constants are from well known, public sources (which
> you should document in the patch description and possibly as comments
> in the code) and the combining function is trivial, I assume this is
> fine to use, but at the end of the day, it is Paul's call. I would
> recommend #define's for each constant with its source noted as a
> comment.

Thanks for your suggestions. I'll update the patch accordingly and submit
a new version.

