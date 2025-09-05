Return-Path: <linux-kernel+bounces-803632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A04B46331
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB095E1A21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C85E277C81;
	Fri,  5 Sep 2025 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNvr9aZX"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BE2777F9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099247; cv=none; b=RWhG7nE6VhvERmmPJ5q4/HyfknhJ04HRuEkqNc3QCd6P7evlZgc5WkYTliJUx1jaJ2I7zU83gzdtHlhhSFyRcESm9XYYMWFTrLL5F0CWnF3Z+CX5YZa8dZ2NHyw1/l3tqpC7oxT7XEx0t5xijtbBt5klCkZo+ykRjDfOooN5wHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099247; c=relaxed/simple;
	bh=3zJGg+Pfojhq73u20GWnxU7zmpGtJSjGO3URi5ORRVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vF15gOv1K2wccpRRXtvITFX4qnQ2fpTVk9m3JNjNU6qfs5cClGaCEjSpeCJ3l365mpkKVQRpZdsy1lQH/+MhVV4Ot071QYl7HzhkLPOToB4ZzrPbjdujTx8InYI4f8sXKO3ic0BQ65pxtHme1uooGaraR30TcYHanQr4EY8Hm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNvr9aZX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-807e414be94so245692585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099244; x=1757704044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ/oIN58CQG5eRvJBAHGWAbcCzoZ6DmYMUn+vT6yYSQ=;
        b=YNvr9aZXnlccniEi3tnAOwiLz6W//EaEBEh0e0UCRXVPNYoMJzlGQm3eatY+Pazjqq
         k1Z0VD5+6OD6eCk7RhVCMYBEn/c1wIzOeRZkqye7TvP/D+fZ+bcRvHEJZ92zPYTMTa6t
         xVxz7kAJRk0NF0dyeOoYyaFjQcxXS3kc/1catqWVyaAMLugbzzA45WyOFaeST8M8Qa8a
         WYOgWUMWf41xRFVdCYGILb4FDm8AMlt84nxNyFpNRPHUSliF2nz1QbrrA5jTu0jmF5SP
         LPg8dS84/LFT/BBMK9otjj6eyUb0FVUja2exuW4TQr7lrX2c8c/P30VhNzoh26I+50Vy
         9ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099244; x=1757704044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ/oIN58CQG5eRvJBAHGWAbcCzoZ6DmYMUn+vT6yYSQ=;
        b=h3LYk6vc6U5yio9XYlQY1ORVMkjgyxVwSxiGkPBaQD2UV9QfNEfs4/zZlfvjXP+xTT
         HgLX8NkDKR01BmVcDsZ+s7Svq2HgQdaKJc7wo8sFYrgbXJ9ui+tcMEvNCFBc6nV3ZhjR
         1fwrxECjIV1EfKjfDDEyAxsZaCoJOdvJF5TqKaK31ZFSy84z7zkHFKtRSbl8mTVR2ugj
         m55mHhQz2n1CEQxSeZj8qIP6FpotdwgGarALlgKTXwbNZ6S9O3+moYCSVjJfr2fMSngM
         XU4tGCyLfAvE+ib6R6kAbusgc5mlgmT9KpcJsdPWk0doWXVnmd2nTyo42RFnZXrZnHo1
         jV9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKRGbC/AFtGr7iF12F3ji7KRUTYitHuFHZTjDPObcOIzTjJ0/mNeuVFc63tFXR+65CjTTtoDkYOujXI8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyofvt4QmceJO35HD9kh8J9vDgVFwqDMU+u2+chMRz4SkDgesnV
	v1aDuOevDFtLSjOBQTfv4y3CsVcS4KHlwVkNCI4bl1DffSrZYHfw+13b9GwJVSrGmn01K9gyX66
	sNo6/JUYQ5pHXxsRrkDDOySDG8Ys78RU=
X-Gm-Gg: ASbGnctUs2pEYDG/Iz1r7mUtV+VZbWAjIM48eM8zp1jtmZxduXp7tNVUjukFdjw3B/i
	+7qUkNX4NXpQ6UQxGh9W7vCgRWO8fYpsMfOrstpSL0lO+AljWNWTqUKhyQCJshvgOCWSRwNP3sA
	17OeKeuXJpbUO+9fwPo2ZFw05tUYK+T1D9S8dt+dlCzhlSdYRqWrwkqv+yap6d96kfjGS1X2w1C
	3a0pNT9UJ2lbaG23g==
X-Google-Smtp-Source: AGHT+IEFCcAvTRiAP+ne7o+on4Q3WXOguRxEwPVt18f+lK351eBuSwYXNaETh1rSpbCvL59gTg4Up9CrdMez1u3469A=
X-Received: by 2002:a05:620a:29cc:b0:806:9c53:d6b6 with SMTP id
 af79cd13be357-8069c53d711mr2035482085a.73.1757099243957; Fri, 05 Sep 2025
 12:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905131352.88069-1-kernel@pankajraghav.com>
 <aLrrQDCBzaMwwmA-@casper.infradead.org> <hfljftvow5dzmkfgh3cjuqmngnmg65o4r4mpp5u34zoixwmdl5@ohnv6bbqavyu>
In-Reply-To: <hfljftvow5dzmkfgh3cjuqmngnmg65o4r4mpp5u34zoixwmdl5@ohnv6bbqavyu>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 6 Sep 2025 03:07:12 +0800
X-Gm-Features: Ac12FXzjLPwbFvmdOPGnbIFkCRXITbBdCuuS4xtejDrZ8WskOLbWE1_9u1pa88k
Message-ID: <CAGsJ_4y_=m9hNBjsT9WEn4UDJtOsjiRworATAxes+MGcjQ21zg@mail.gmail.com>
Subject: Re: [PATCH v3] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>, 
	Kiryl Shutsemau <kas@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:57=E2=80=AFPM Pankaj Raghav (Samsung)
<kernel@pankajraghav.com> wrote:
>
> On Fri, Sep 05, 2025 at 02:53:04PM +0100, Matthew Wilcox wrote:
> > On Fri, Sep 05, 2025 at 03:13:52PM +0200, Pankaj Raghav (Samsung) wrote=
:
> > > Changes since v2:
> > >   - use page_folio(page) directly in VM_WARN_ON_ONCE_FOLIO
> >
> > ... why not use VM_WARN_ON_ONCE_PAGE?
> No idea how I missed that!

With this,

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

