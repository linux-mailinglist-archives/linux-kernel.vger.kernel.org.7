Return-Path: <linux-kernel+bounces-735135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E230EB08B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9856F58827A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73633288C12;
	Thu, 17 Jul 2025 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlapYzOI"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C4299955
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749305; cv=none; b=FNF/rG4Vh+n5LFBaFjbhiA8I4uWsKoQmjCe7uB8+KJCh3Gg3LJRZfaODcpMH2DOvCZijthgymAyR3QXbEG/fTkG0uB+FhS0tIxYlVYvMYc4/RbhDd8gUgAzDxa5uUewHLw5RbiKdJXPmZJ4RP2R1g1rNNfRwDuBKoZkWaYtgaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749305; c=relaxed/simple;
	bh=PPPNenxX4zSMrSeaiRSD+nf5weghwUgRDun06mgDAtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEzkphKdDNKfKnNiTztIenvdDy2J2u6EYsKeAfvc7X7MDWyGLoQi2Z/Y/dInGU5/rU/u7zfQOHyLKj1T6WeH7XRYobEafNHeDpheO20qd8EL3oKfLPnrImdspgV0puYLaid+VPmFLx4un38MQryt9yCCv+U9Lgp7CogSNrxqj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlapYzOI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23636167afeso6886315ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752749304; x=1753354104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUE32TVCgc5BYcjuwrG1irrIPdzwr0WmEW1sHJImq9I=;
        b=VlapYzOIBlXPHXPPsjdMG5VuOq6uny5BX0c7BqOKWH8pbJDPp7EAl+QaoCb+ZoOfyz
         IqAPfPVbHYDDYecc+PgUBf85fKpdfguF5aloEDRuER3c0fpHXxQEF1IP7JtrEhqRjfy2
         /X61fXGUVJIo7z0Jq3f1Wb11VRYnmZZN4kSBinCstTGCe8ek6jP41vjMvIkXZLEgFxgA
         liX2u7J3yo0WjiS4KHgrkL/Wl8E4JyEMzIOBQ9Pp4LqU12Ah4BEmegoa/xrsV1pnOpqI
         XMDiCQyl9ceka5CoALUooX8Jrkidag23wia9Apvu3rp/PU2ENASuin3YklxCOSRwaj7U
         LWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752749304; x=1753354104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUE32TVCgc5BYcjuwrG1irrIPdzwr0WmEW1sHJImq9I=;
        b=Zdl3WXS4k60fnNRxqHI4D3VE/+pHqaeEXKOF8PeaHAW8v8TjdxFcHI01rYrOC9ipzW
         OtDaVNy4QVscK2ljxczANzv/nczSldeJCpEDHme9pM7TmDkavu2I2td8JxrbUUbc3ZXW
         fLj5UAEz196+yEnVqeseNQOqrSnt2Js7VbOritv0eq+N9mzTMzYNfVx9e4TPIS5/FMMq
         N43z1k/6KQU7tGJsklVIZ1pvUp0qQKZPQX/R/dwURJgiKtD4uEevbooPfhbQZY5OQatA
         lOLOXKiClZaDBNzKpegBDxxT8JDwr2awnoOmwkL84RAm/CVZv1DKmss5wquYRpYhI6ah
         H61A==
X-Forwarded-Encrypted: i=1; AJvYcCUGwhc0jI2cZdSbC2ioHfe0kg88pFsr8crZRmSu7R9DrmnhoCEURYs0RHtaeABPWJ+JrnXYoQLGOJb6VbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXW8/7kYKuP9w+davN0e6KfohSVJ5jRTfqIeRnZJjg6XxV5PVt
	SElyNrM2Bga2c4X1rk/AkwF/cD4IVZ7xxK4fnxRV8ZwOPaKUAW8RhOtb
X-Gm-Gg: ASbGncuDrJX0DIxTYjSv9VCeWNpy5cBAvCi2J44Eq7Y27c/3E6WaFkNEsU9Wq7ZmrRa
	lmZN0Lqvq9JmSqUKkg5KXcERlzDUMl2geTgQsAvq0S7EXNYMo2weB1OyhIv1XIH81qZ6zdO76/7
	YszQfs33wpUL0QQrtQD+DN6mpYOx//BRKXRTEK07ZkVCKcSFZH+YYiUZdFTw7JMR1sxFrVuT23V
	OUUkxSNeGqXy+kSUOEHFSHOHlT1DiJt+vTRQnvmGnUk4BPDzWr4Dl6s/TBtE+/tCm7aUctaMXJr
	mrsNl/lJuTGOGCrFSycBPU5PhCNC65TysVY8Oj9tXMLa467Ce/+iNLgLSJ0uC3aX3XvlpXbx1CZ
	cty4aDurIcCIeOog78lVWzz3PKw8dbx5P3iNtMpHiPjqALWYkY3quc/o=
X-Google-Smtp-Source: AGHT+IFXkzu6bujwc4QN/UjjPM8p8IRosZxnbRCNkugOMi80VBKl6GeB/WVnNve6YlNR8wyj/rJaYw==
X-Received: by 2002:a17:903:1b66:b0:23d:dcf5:4806 with SMTP id d9443c01a7336-23e257660b1mr94520325ad.39.1752749303384;
        Thu, 17 Jul 2025 03:48:23 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323cd5sm140066605ad.126.2025.07.17.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 03:48:22 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
	brauner@kernel.org,
	broonie@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH] selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"
Date: Thu, 17 Jul 2025 18:48:11 +0800
Message-ID: <20250717104811.3773-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716151543.998b121a58064011e9ce68cb@linux-foundation.org>
References: <20250716151543.998b121a58064011e9ce68cb@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Wed, 16 Jul 2025 20:31:26 +0800 wang lian <lianux.mm@gmail.com> wrote:

> > Several mm selftests use the `asm volatile("" : "+r" (variable));`
> > construct to force a read of a variable, preventing the compiler from
> > optimizing away the memory access. This idiom is cryptic and duplicated
> > across multiple test files.
> >
> > Following a suggestion from David[1], this patch refactors this
> > common pattern into a FORCE_READ() macro
> > 
> >  tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
> >  tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
> >  tools/testing/selftests/mm/migration.c        | 13 ++++----
> >  tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
> >  .../selftests/mm/split_huge_page_test.c       |  4 +--
> >  5 files changed, 24 insertions(+), 32 deletions(-)

> The patch forgot to move the FORCE_READ definition into a header?

Hi Andrew,
You are absolutely right. My apologies for the inconvenience.
This patch was sent standalone based on a suggestion from David during 
the discussion of a previous, larger patch series. In that original series, 
I had already moved the FORCE_READ() macro definition into vm_util.h.

You can find the original patch series and discussion at this link:
https://lore.kernel.org/lkml/20250714130009.14581-1-lianux.mm@gmail.com/
It should also be in your mailing list archive.

To make this easier to review and apply, I can send a new, small patch series 
that first introduces the FORCE_READ() macro in vm_util.h and then applies this refactoring. 
Please let me know if you'd prefer that.
Sorry again for the confusion.


Best regards,
wang lian

