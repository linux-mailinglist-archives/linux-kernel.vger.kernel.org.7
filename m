Return-Path: <linux-kernel+bounces-856574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF51BE4817
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7498454262C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62F23EAB9;
	Thu, 16 Oct 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrsshslT"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B532D0F3
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631407; cv=none; b=FuCyBA1hnd2AA8Cr0ZaGFLX9HEx5+o49sRuArHSGqdy5LR3VHzYxVwZRPzUDN/pZinsiR6TpoTh1JN65CJDu1fen2NutMLCI0hW0zxhpSOOGNEP21s/9PyWRew87tR4hBlXXU4ZjrwuBXVbYDWTTzaFL+s4ch4DdUqGMozG5m+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631407; c=relaxed/simple;
	bh=dDzcE9GIhuMD03hwQWEzPv1MMHllwhlQEEVcA4HO9eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMMV5r9IXxQ822lvRWCEsBGF8zvGXVM7L6w69WXIv1GxcrO/My/lp3buAnXtTCuY4QQFfPvDDotGkZw+okMDRYkZm+tmkBDlOLwjpLkqRGAiwsfulR8VeoB9Wvk4s1hrd9iS8y+eokEcHjtYuIyufRTf8KvEAaEn6l93Eypl6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrsshslT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b463f986f80so188951566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760631403; x=1761236203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU4H/m2arF+mqUMYVRlHKE47q1ucl7Pu6ll61/fszag=;
        b=ZrsshslTt7yXtTkAJTj0Vj/o2o6Slh/tJh7wwncDNsY+Q8IDDYV5Vu2w/ICZFBSIph
         Dgl3WH4zf+2VAI4Pl3XqxQBmzTwa+p2fbcvpH9V4m0QDNU+fRkNUh/ig7Et+0+A9hQMZ
         gzmMrnPAMI165Lz+ZEVRKzxxzNDneUKkRcr1fCjQGESQcyl9pGi8ZpB+Tca2KNTxKF1B
         ZTRRRqEZVC28fF3/6m0DY06hnJyQSBrY+zrJ14UoImwcrdnMyx0//77u4VP2bpB0VHDh
         3DM8Wsi+w2ThoIS+MF785GUoQRADWxvpSCMH0arYgwHNYJodiLuXS24gS8fhTCKzxiTA
         WjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631403; x=1761236203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU4H/m2arF+mqUMYVRlHKE47q1ucl7Pu6ll61/fszag=;
        b=lGODjvfVfwN9Nlnp73QGVoSZKt2d9+gz2Fln6M3SR9+4bObvnWSgWudFqQuxebJxSU
         ooqsQRPHiTtU/4e8xy/IdyvONij2YFiYNP/5h0BFX0vHI2+YSyq5CPWdA7QAgDz/jrLb
         SqV1BlC+z3U0Fh7GaRqbKjP0RQb/GQ4TO2QkoCgW/p5T6iZRL8poBxp5rbM/GJvnOs/Y
         +fqwP4+/FUtHgr8rVpUnL/ILThqwWWuBINqtH0tLgquu+IPwFj9OWMRUnONL0oOzRZcy
         nzoIn9RojhFYjQytkpEdw4lr3Hd4e0h9SGtiSkWw+/r3EF6eUCKPfDH+SG24x5QUU0zx
         GU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTSbDDhzeRCYJaZNXBvYk8VOk7iaYtiIChwOg0nKXdvRuZae2AJqjoDJ17eYKIetScPE/mIiWCgeXvrlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9Ngj5GNfXVYPCI61qxD26I1btY+NamPsIFmrzs6+TbjVxhdd
	aVTTTJqIdOFNlrzqOsgfEjPt5r/siMkf6JBPWVjcCRJnoGqrWjycGUOU6kOGrHRIAJ2BdWCxhv+
	Sepq2KemtdY4s3mm/mN1wVxVbMdQuxG0=
X-Gm-Gg: ASbGncvqGPOQR7w/8YBvJd3IRW/NvZM3kjMoQ8f3TTZNsuNlcI5iw6KnmZSCgX8gaOv
	xTheVvxZTLjzTnyMk1D6cprWso/qYehTyo5ilprGEC9v+Mvk4fMyf57IqPXspPm6oAFnOzjs8JK
	NevXQUz+cVXiINA6E1Gj4V8IjVsEI0MZK1nwP9zWjiPbh/YytqyicPH7dCIE75G6PLxByrHswgb
	/C1xyCQxcYUvX5uAyq9KcZMqrZiaJec2KqEACN4grYOrDMW+iNlP7xPZhitpVrnZSpsipYwtA==
X-Google-Smtp-Source: AGHT+IGeI0c+J/vFikvKLQh7Q/TygfPMPFT9ewUwuJMXMjAiOuEpM5YJkGnX697MAOyb7hi1nyrkuoDilCUc0wP6mZA=
X-Received: by 2002:a17:907:2d93:b0:b40:e7ee:b5ec with SMTP id
 a640c23a62f3a-b6475510488mr53395866b.59.1760631403045; Thu, 16 Oct 2025
 09:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910144653.212066-1-bharata@amd.com> <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F> <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com> <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <20250925160058.00002645@huawei.com>
In-Reply-To: <20250925160058.00002645@huawei.com>
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Thu, 16 Oct 2025 18:16:31 +0200
X-Gm-Features: AS18NWCi3W8UGN6S3h7IBg2byjYK79TJWWE4zkCP9FRr4Mz_MHN_5h5HNXTlxEo
Message-ID: <CAOi6=wS6s2FAAbMbxX5zCZzPQE7Mm73pbhxpiM_5e44o6yyPMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion infrastructure
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, 
	Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>, Bharata B Rao <bharata@amd.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dave.hansen@intel.com, 
	hannes@cmpxchg.org, mgorman@techsingularity.net, mingo@redhat.com, 
	peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net, 
	nifan.cxl@gmail.com, xuezhengchu@huawei.com, akpm@linux-foundation.org, 
	david@redhat.com, byungchul@sk.com, kinseyho@google.com, 
	joshua.hahnjy@gmail.com, yuanchu@google.com, balbirs@nvidia.com, 
	alok.rathore@samsung.com, yiannis@zptcorp.com, 
	Adam Manzanares <a.manzanares@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 5:01=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Thu, 25 Sep 2025 16:03:46 +0200
> Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com> wrote:
>
> Hi Yiannis,
Hi Jonathan! Thanks for your response!

[snip]
> > There are several things that may be done on the device side. For now, =
I
> > think the kernel should be unaware of these. But with what I described
> > above, the goal is to have the capacity thresholds configured in a way
> > that we can absorb the occasional dirty cache lines that are written ba=
ck.
>
> In worst case they are far from occasional. It's not hard to imagine a ma=
licious
This is correct. Any simplification on my end is mainly based on the
empirical evidence of the use cases we are testing for (tiering). But
I fully respect that we need to be proactive and assume the worst case
scenario.
> program that ensures that all L3 in a system (say 256MiB+) is full of cac=
he lines
> from the far compressed memory all of which are changed in a fashion that=
 makes
> the allocation much less compressible.  If you are doing compression at c=
ache line
> granularity that's not so bad because it would only be 256MiB margin need=
ed.
> If the system in question is doing large block side compression, say 4KiB=
.
> Then we have a 64x write amplification multiplier. If the virus is stream=
ing over
This is insightful indeed :). However, even in the case of the 64x
amplification, you implicitly assume that each of the cachelines in
the L3 belongs to a different page. But then one cache-line would not
deteriorate the compressed size of the entire page that much (the
bandwidth amplification on the device is a different -performance-
story). So even in the 4K case the two ends of the spectrum are to
either have big amplification with low compression ratio impact, or
small amplification with higher compression ratio impact.
Another practical assumption here, is that the different HMU
mechanisms would help promote the contended pages before this becomes
a big issue. Which of course might still not be enough on the
malicious streaming writes workload.
Overall, I understand these are heuristics and I do see your point
that this needs to be robust even for the maliciously behaving
programs.
> memory the evictions we are seeing at the result of new lines being fetch=
ed
> to be made much less compressible.
>
> Add a accelerator (say DPDK or other zero copy into userspace buffers) in=
to the
> mix and you have a mess. You'll need to be extremely careful with what go=
es
Good point about the zero copy stuff.
> in this compressed memory or hold enormous buffer capacity against fast
> changes in compressability.
To my experience the factor of buffer capacity would be closer to the
benefit that you get from the compression (e.g. 2x the cache size in
your example).
But I understand the burden of proof is on our end. As we move further
with this I will try to provide data as well.
>
> Key is that all software is potentially malicious (sometimes accidentally=
 so ;)
>
> Now, if we can put this into a special pool where it is acceptable to dro=
p the writes
> and return poison (so the application crashes) then that may be fine.
>
> Or block writes.   Running compressed memory as read only CoW is one way =
to
> avoid this problem.
These could be good starting points, as I see in the rest of the thread.

Thanks,
Yiannis

