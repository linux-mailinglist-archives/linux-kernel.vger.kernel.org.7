Return-Path: <linux-kernel+bounces-757061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19835B1BD20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CE118A8128
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C622BDC29;
	Tue,  5 Aug 2025 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfNveX47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40029CB4D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436399; cv=none; b=fdtSThbQQpm+BSPyxgncRS2NgMfxfhQmDLhyLPiPlsMZo1IgC1VOyApcMFttIBhJEfOZd0mkEmosl6HyGPr/80V9vI43d3g/Uijiwy20Nw4/nL7/elPEvz6+nrHMnBz9B+D+d+Ik8SCKNzwsBJuTCR0NYQgTlaAtkwP1dnawJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436399; c=relaxed/simple;
	bh=uZ9KSLAM22NmuVTPlZSaN9HdVrPy8DkN7MfM40PX2Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IztzPw6j6FmAZA1GZiI7f60NzCcc+92LagaTfjEg4iTMV3fF3YWhvToHTSnyhb2DBYHNJXk1w0Ff1V0FgwV3Cc1H432caBj6uEzogIwjbiT2OdxRFB9MXJIC11cQhXf4YF3VjvA0ykLi24Tv0otiuKuDlQZhYsdw65G+NHDxz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfNveX47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6928C4CEF4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 23:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436398;
	bh=uZ9KSLAM22NmuVTPlZSaN9HdVrPy8DkN7MfM40PX2Co=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XfNveX47yS4bApKYFsHba5caABJUn+KCIrhmze/dW0O6bCckYDvypOKlT4gJfFcoQ
	 l6d1L4pYXO8SxSbUL+/liu1W8YmDFPmXeHsrPYdHj6Em7uKb4RpNqrwlVUgjQBJdL4
	 wnHXl8d/8zC2BVbhVTMdNHPWLS/PctckEP/DFvSpK/y46qOvSw9d2O9EWpw6+nWDJ/
	 MrgpePjM1MRQN1axNfC/6MWj70FvbyS9MnHZFIWVhmLouVdbB8IX2c44IOdpDLxwNJ
	 cr0k7XELqH/LQQl8BFtkidgLvcNCBibo7sGaQ1fS42sT/gC3D9ZFHbKMcYG11XR0e/
	 oP5ubZI+Ax5kA==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459b3904fdeso12875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 16:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHrGntGTViUTmqGtXu3en+aAe9gGiporaRVXjeDx8XXc4aY+Rr17g0vemnR07XUeGw4y+R7XpwZpmq6W8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3gtspU3afQ7OvRqgsbfhYXeF1fbCXC9UolhP9dfLHT1V8Eoyp
	WrmK5f80A7vhpcTYZqJrJ44BptMJWORk5m/Hfmu3BAKTI6PovhK8lUbVmdKX5UuEPGNHFQlqI9R
	cHl1AbL8R5SLEsaEw05iqhd8qhWCWdYmXf6pyXKM+
X-Google-Smtp-Source: AGHT+IHANGKeWbwtq2oqxC2twxXrxdNSmni6nCnon5N+Tvdfg1aAQwnRcUtS338ORFG92LnvvcEk0nkVjtsXc2pfMlk=
X-Received: by 2002:a05:600c:5494:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-459e74ac34amr252325e9.1.1754436381085; Tue, 05 Aug 2025
 16:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804172439.2331-1-ryncsn@gmail.com>
In-Reply-To: <20250804172439.2331-1-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 5 Aug 2025 16:26:09 -0700
X-Gmail-Original-Message-ID: <CAF8kJuO-kVXb39AU-gFVYG8VOjfdVind5J28KUpeXHHPA4UYXg@mail.gmail.com>
X-Gm-Features: Ac12FXznNun7ApAQ49rWYq0WNDNOJnAAwm5wdO8vxNdnPZsqi2jr3nYvcCbtD6o
Message-ID: <CAF8kJuO-kVXb39AU-gFVYG8VOjfdVind5J28KUpeXHHPA4UYXg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm, swap: improve cluster scan strategy
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 10:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> This series improves the large allocation performance and reduces
> the failure rate. Some design of the cluster alloactor was later
> found to be improvable after thorough testing.

Nit: If you have a next version of this series, please include a bit
of detail on how you get the improvement to kick off the discussion.
Right now the cover letter just said I have some cool changes and here
is the number. e.g. limit the fragment list search to the first
cluster.

>
> For example, build kernel test with make -j96 and 10G ZRAM with 64kB
> mTHP enabled shows better performance and a lower failure rate:
>
> Before: sys time: 10230.22s  64kB/swpout: 1793044  64kB/swpout_fallback: =
17653
> After:  sys time: 5538.3s    64kB/swpout: 1813133  64kB/swpout_fallback: =
0
>
> System time is cut in half, and the failure rate drops to zero. Larger
> allocations in a hybrid workload also showed a major improvement:

That is a big improvement. Congrats.

>
> 512kB swap failure rate:
> Before: swpout:11971  swpout_fallback:2218
> After:  swpout:14606  swpout_fallback:4
>
> 2M swap failure rate:
> Before: swpout:12     swpout_fallback:1578
> After:  swpout:1253   swpout_fallback:15

The number looks very good.

Chris



Chris

