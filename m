Return-Path: <linux-kernel+bounces-734053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B36EB07C78
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F2E1C22DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA3A288C1A;
	Wed, 16 Jul 2025 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzITbaEf"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7228853E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688787; cv=none; b=u5VnCZOXWXe8MiOp+GUadJb34Os78FkwxSE3OQFbCRivF9MV3cIYfGlSZYSu82vn1w1zDdIP+Rg1DfLuRapTUEtQdeToGjJRRTpdopRoxGFYKvBPN3M0Ts5ZAnber0KtlWBdpcH7Zwd7+hOwZsd0hC2WPNaUDWa1CW9RJ6VMMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688787; c=relaxed/simple;
	bh=2fijkZ5wPILA0nj78Z7VRFYr7ggYZRLreNow20wmEWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDxqcZPQoERb14IxMrO5jFK6+6PAhEnpQMNH3E0YHrHQrWGo8FQRBbo/YRbK/bv8gg6mfoQ6mRk0xCU7zH1lCG63ankc/4qMLIM+6NC+gRfVe0uzea8oqRItuJQS3GnoPNJyN5B5XyquVIAT+nmJHaEnxiASI/ZrLYM8Ldw264U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UzITbaEf; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-41cfa50c73dso126849b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752688785; x=1753293585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6lV2YN3Gq79CHm5MqhPsaOSM7bdwHuTvuTPXwMWVyk=;
        b=UzITbaEfX1T24/yzxokcoENJ8J+PW2MSk74oJLuX74IjfU+XE6D3QIQJLt8CyaChgG
         AIKQ4vYO3IXhgQx0v3zV+tjQP8KmPyPN10kTEOq3BVNnGl39QpTYGqTBfnW8fFVL8Ysq
         furIi1vHnYGrEt5liM6+NuzCVzb0RLOgsDBCyqN32adsY3XRNC5MMqPE7mki9t0DQbXm
         5pEh01tUQoRFq1Ctvvozky5z0EKCViuMM92M17jpXHcpFoF8MRqQbmOgmG4P+QAsdYBC
         FHwOd3cDbs48u+9Py7DzdY799IO5au9F1pLjqR5JUYCZ5cmvBf+mjpPz1uH8z8Py+Efy
         jveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752688785; x=1753293585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6lV2YN3Gq79CHm5MqhPsaOSM7bdwHuTvuTPXwMWVyk=;
        b=qzKTwo+AI3L67zJVPImPt1oUIUFP8NQvzmE7iZS716bPlbqgDcMiZdrmpgIoyYWRdE
         oddGtdUj8qXM6N9KKTuIHpNqRUmL4pY1hw4iDUZP7AzAhJKBLioNYTpJYuQVLPIx7Brd
         gvS9LEKAjZ8ebvNn45/637U227epkVk65AnUwv+8z4e4V8xkuoh4HhZyMhULMShv4eii
         PWqAiXhOhaPDgKhPdge0BqSZLogFCVtWz2yHk2Yn2YSBKNIC2ggMDiSn25BjxfqX8mXk
         J7ObQqMMqmxbXSFSFX9rwMgt7Yi/GxBJ3RjaG//9Bm26SQMrX1kqy1htMZw15kUzyOVE
         wOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlKgjbnpL29qeSQLgrvcXLNPiCflyAQKWfmXq4pjxFs6qv0k+vtQ2HziNUB3CEne4sveEmQ7i0weGC9+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxB5hl/e2vSgQEXW7tYHno3FIVApUlEYB3h5uk2fynLCqXphxN
	FN3wJljYTyVK0hWCaCTYYY7IpdLoFD4aqg9lPDjzRiA/XUolHG5na45D4YfsCuAv7YQ=
X-Gm-Gg: ASbGncumHJgZIaD8nGB9Yzq8M9AfE6yoy+y/ClbWOmquZXkn7ZmL1WWCBe9iEhnjy21
	qubLfna5lqXZ46d1pCD8oeZfG6VneWUAyTvqwvB2JHRQ6t5xx5zoqrU5ycy3DApEm7Zj/29/wDx
	sIGEIAJ4ljhOgkE2YTVcYUbxiBCwhmYepClG5QxSCXDZgDG9eJLSt0y1RfHZuUZMtNs1c86HrRq
	TRvtcymZoy1vhD07VC5ncU7ZYkDylgC17CRm/qI1O3AI3E+Hm11K+pPsCagmHYc6Lra586a7vvX
	GPeX5RBNGxQcqECD7X8knBkY/X2+GvPdIJ8de5hzo2UEuxM+b91dSlO3mBSKDV/2lE7zgE4/8nB
	ppnM1h3/TuGnHTq3dVC+XwIwj0ArX
X-Google-Smtp-Source: AGHT+IGmh6iFReQ2JrLFACRyfrbA1cB5+j6lpHICf17fBkOa5VtmsK+uaH8d1PXCAX5j8gEdhMJCXA==
X-Received: by 2002:a05:6808:1b21:b0:41c:26dd:363e with SMTP id 5614622812f47-41cefe0bb6emr2903215b6e.31.1752688785021;
        Wed, 16 Jul 2025 10:59:45 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2564:68a3:7d6:cb7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41418c0aeb3sm2868907b6e.7.2025.07.16.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:59:44 -0700 (PDT)
Date: Wed, 16 Jul 2025 20:59:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Antonio Quartulli <antonio@mandelbit.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Kirill Shutemov <k.shutemov@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Message-ID: <38ef66fa-f10d-43ac-a650-233d53cfe65b@suswa.mountain>
References: <20250716171112.3666150-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716171112.3666150-1-ziy@nvidia.com>

On Wed, Jul 16, 2025 at 01:11:12PM -0400, Zi Yan wrote:
> Smatch/coverity checkers report NULL mapping referencing issues[1][2][3]
> every time the code is modified, because they do not understand that
> mapping cannot be NULL when a folio is in page cache in the code.
> Refactor the code to make it explicit.
> 
> No functional change is intended.
> 
> [1]https://lore.kernel.org/linux-mm/2afe3d59-aca5-40f7-82a3-a6d976fb0f4f@stanley.mountain/
> [2]https://lore.kernel.org/oe-kbuild/64b54034-f311-4e7d-b935-c16775dbb642@suswa.mountain/
> [3]https://lore.kernel.org/linux-mm/20250716145804.4836-1-antonio@mandelbit.com/
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

This silences the Smatch warning.  :)

regards,
dan carpenter


