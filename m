Return-Path: <linux-kernel+bounces-781283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D49B3107C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087C468165E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F29D2E6138;
	Fri, 22 Aug 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgNxZqk4"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0D26F285
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847821; cv=none; b=cIfW2BIzyciwl9jzXsU5LhsrugF/cZ6aES08m6cpZFLOyKisD6kxA8dk8ylsVJcmhSXqDYmADUwHb9eB3zkQKHo+1BDdGY4QGV8JUt7QueUl0WvC3YdL6fbMnQsw2FftY/v9LigeD4cwJlAe3575QWqGxymudCpMT9AToi+6f2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847821; c=relaxed/simple;
	bh=mVxXa8eikz4A20j82PinKi46l2EtvkiPxG6qpqxsSfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMdrRlOtusUsbHv3rxNt4JqFC3DAg9CWHVw7k2ioaEQM4nNtLepVMjFkFCBBi47g6tptRY17bmNsE9vhXbMokAZINAVTVwh0nCO3lOXsfO9uZNMQfb8a3kaXGRP1dNDIoeV3/LUhhBna8TbXOsHK8oa00ZGIpaHzjXIma2OvFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgNxZqk4; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-519d3c38bc9so527598137.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755847819; x=1756452619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+LKVPc9kKW7P+wvIba70K2T/PYJXPwn/uceRk+y08s=;
        b=hgNxZqk4F7tdNNcHzVDrk1zlI8THhoraRjNiPHSuV0H2TQ8y6vYy5wDNBdXEwWm49x
         i/j5WwVepeWzwfYf1N1pSLqnMTxkVK+TqYn5q4qJz29ncB9YlyhHPNLlRbv5MvHuVq8F
         BikDVEJ0dTt0z9ndqjUG9Vth2A2OBQ5U4PYAmCkUg0GohZAoesJHXYOP63zWhaTs2aw+
         p0YdxB8gTPu0mkI8+sMWuN4wVl0jDFvTkmZ+gn3yuLyV69AzAdqsXD37stlLHQfdgjbG
         UXtifOx/9Nsehcyabqeg1XiI0c6EtKi7br77PG+DCDa3QnkHjj3HQtoAuj8VdQysFpKC
         MxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847819; x=1756452619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+LKVPc9kKW7P+wvIba70K2T/PYJXPwn/uceRk+y08s=;
        b=j72VN3TAVAqDCQfVXd3bZjbeWQHw4a4oaeeiFnyONkGa0TQLVP4HPcLlPIj5cdSXFZ
         u8Kgb3Dh+7+hpUoC04/djlVnJ4WBeJmrdZxbf+1may0DaMpyRiU6K9ISLoXt1FmhhJK8
         SYzxbQ8G6oaPgq7gxGDE0yIU1ofC4OlQea851MGvEoJgTlxk99BNoyJ1ni/mQ2kxj1Z+
         +lTEGrfAMKlaLo5Dj9uPZls+Kll36jZIxiqCFKY4awNtIqzvu7hwcx3IvhgjziPH7WnC
         bcqUceI+Q1Z92z91q3umbWMY7JaCGsYG9N912BVICIyZC7Smf5tMY9rJBH2++xcXMgrQ
         PMlA==
X-Forwarded-Encrypted: i=1; AJvYcCVAi33ZKfy0BVlr35aN3w8/l4tz3fVarsrzcd4aBhPjaP7mLkChXxTQKsQe6SB0e3WpThBSWZbFu4GNR4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHCmtAuXmImniH80C3kddUL/h0yjFry1sn8Ox8bn/L2qiaV7+
	HGpokfK2nDP5lXlOI7Q0wLaLrP925QvC+Dl/iAYuYsmZlplHAYo08P0/+O/ZPGb71KwesUGNPDx
	L5ZMOk8iACtQ/onexjVDsB87OtR44w+Q=
X-Gm-Gg: ASbGncu0MrFBPaWzaGX+Hr56/XQ1gaTO55P0AsQF+Me+hTCME60Mv3NP9EJr6G9yZDc
	N75ah/OB4Q8Tdrx9nMOLrsbFJfdPsJMTKqXem8YUb9rMKabRpOmDKN3+wnw150ssu/YeBfWRgjF
	opfTcdNNzqMZDL6YxijysXBIvnBCkGG5ZPodlsexcoMyUxJoNW+5FJNJVpae1bFFOtSrNdiWnp7
	iJAdek=
X-Google-Smtp-Source: AGHT+IEtNwyUDOVJSiLdLX6NwOJBzlsyvEjMMa4jsxgGzjp5jPh2OUBTcyj8Lz5j55noj3cQHm2jQALdssibJnWImjI=
X-Received: by 2002:a05:6102:3e88:b0:4e7:db51:ea5d with SMTP id
 ada2fe7eead31-51d0cde2937mr458403137.6.1755847819116; Fri, 22 Aug 2025
 00:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF8kJuM++mc5PjcN_bxjZjbByT7QpVdOqRQte=vGJnuQxSTVfw@mail.gmail.com>
 <20250821213630.1771-1-sj@kernel.org> <CAGsJ_4xLKVM+1LqKzbwjd0vB_OYnb2E-h-Wb_C2bBxiSdU=3WA@mail.gmail.com>
 <aKgF_uJT99rBiyDd@gondor.apana.org.au>
In-Reply-To: <aKgF_uJT99rBiyDd@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 22 Aug 2025 15:30:07 +0800
X-Gm-Features: Ac12FXyv6CwezG7VPt_wlv2AiL1S_xRAYOxgC4WUz0F7iC1cnJ5iDPsKPK7KeYw
Message-ID: <CAGsJ_4xR3bvWTEfbu_navPHGiVacAJTY-87BvOH2QQd4xAM4VA@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: SeongJae Park <sj@kernel.org>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:54=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Fri, Aug 22, 2025 at 12:48:27PM +1200, Barry Song wrote:
> >
> > Is it even possible for crypto_wait_req() to return -EINPROGRESS, since
> > crypto_req_done() will not call complete(&wait->completion) in that cas=
e at
> > all?
>
> Of course crypto_wait_req cannot return -EINPROGRESS.  However,
> I was responding to a request to make the crypto_acomp_compress
> call return a boolean instead of an error code.  That is not
> possible because it has to be able to return -EINPROGRESS.
>
> Nor is it possible to change crypto_wait_req to be boolean since
> other Crypto API operations (including decompression) can indeed
> fail.
>

Ok. zswap only cares about the return value of crypto_wait_req(),
not crypto_acomp_compress(). So it=E2=80=99s clear now=E2=80=94any error re=
turn
means the page is incompressible.

Thanks
Barry

