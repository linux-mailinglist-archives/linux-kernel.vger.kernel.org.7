Return-Path: <linux-kernel+bounces-822217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81164B8350C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EEC11C2460C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405702EA154;
	Thu, 18 Sep 2025 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A7ZeV5br"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB51F1921
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180573; cv=none; b=KUA2uKNTlBvtg46YaUTUhbfOE+ayCDwzHJ9TWCha1GE+av7SrQvaqixNuvT8TIADzasv+B6u+PuHplKjOVZ0uWbO6m8SR9obHol+/6e18I1spD+nPxMW/E1U3ZbeDBKS+1qmH+yxn631rUIJfm6gPA8z8S0N5lrYsuIR9qwNebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180573; c=relaxed/simple;
	bh=2pW0yDiHX7ou3AyxWw9aSJCvyruA4rRZ4+1BSHBN45A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXUnq2Qh+RgIwbnaXwYiDCpG3df43IabDMWDvT2kEmU0atDvD+iKJQS+NsZ3O/h2Rg+Dn3DMhigctJItKtkeK8IA98QmzEYhweKhFdDoDgy0yR1bsYBjtok+qlVdFg1e/KxAAdc0R+HqYF1zq3Q5/CNYumxoA+zUNd8fEnREb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A7ZeV5br; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07c28f390eso107495366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758180569; x=1758785369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TeUhfPwflpH8IcvEZqVCAI1Ffw6zpYGf0YbylPJd+s=;
        b=A7ZeV5br1IUFTMVLfY2ofKJNYCw9/Svo8qSGBySsoWGEQz+IOoNOWZYw13ER/emxAh
         ym2nABZWXHVXiPDiBgBzXdqUJRS+KQG2FwdCu2BSr5X6hmSRuq9OlmnrH6lqLCW+h6s9
         yKdKdvnl5ERK2j6S12fxVFl61KBp5tptF/MCXYeRW+Mmv0IZrGYy/tOsNze+GBFElnYK
         +jYHGK7ckjUVz0D2MKyUzjRjx5zFrRf4koeODIGO8rvr6ppSFF6EHEZlbvgR2ApM1l8E
         lbZU0uC6r8TuKuI94Bok1M2Dg2JKD2y6EFqaHYlajhq42IFBTlShty5bwUqQsEjf12VP
         O/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758180569; x=1758785369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TeUhfPwflpH8IcvEZqVCAI1Ffw6zpYGf0YbylPJd+s=;
        b=HEb8QuOMouUir2c6pytQpsM1cahYSfa+UDRoRod5mwWhpGovLzGn4/qQAuqtptj1/7
         z6uG5ZUufqtf9Ms5GODtfeM+E9nSyGjTed7A3W/OBtUSJgq9T7eHkKtG7TPdR/mJF6ZU
         njInB2kOuCLX/c/8LmA2wTLrZ1SNidnTEdxqprW8qJYxspgqKbNDUzcotMBpKBVqzYpV
         VcGgSdN9ZngUWqQpmFaeSAvfrbexKkpOpG830ub2Z+6wV3X6jZTGb8+xMkDWV46+EZOS
         dyiRv4mc5PCUtr7PevFl32GanQBkP5VaJTMnCo9EyfuDFSneZ6qv9JT+Asm7asIkSf57
         xlzw==
X-Forwarded-Encrypted: i=1; AJvYcCX5HyAbbgCTubZjN+SMZb/l9+VCjowANW5qMfWJ9VMhxNpXpe/h1CCUbnyyS656l5vXh9Oa6pVJfAaJCQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXkSk3+xaMf8Z/s/BdgQd9K7vn+pSKKHBt4FhjdDmBNXkN1d3
	FEsLQBUigdCLtQnNCwEmfr/OIQEYBuGwS3hYp06ya6t2Igho3SJ7xgMZF+3TekwFoPXuy7qCCDu
	+8/QkUF4=
X-Gm-Gg: ASbGnctmBQcktLvbxVx5+GcwTc4RqyiOyWw9RoauLWZQ2WcMV9DEltu+GfpzpDSPfIs
	xO3hvuvtE0p/bj8Ikoo+Z4iLKMu4GZ3C/iy8YH9WYJ7Z9F+CDNbil4X077ghCefggSlJs/Z+jY5
	FNzZoArjqHMHOkKGgWjEE/jE7pVgDUT7PPRzD34mBmotIe/T3ko7SmVIMvBkZvvRrq/uXhSEoTc
	JudC8tG2fqoTZwYXKcTmx9zNfLKMMHX4NAWHzo0EWRSgjOFwRY7D1btE1vSBHqwHeUgDJqwpi2m
	M4mxu7pwEvopUnaH/w4fMhfSbQLXEBL5+DWSfKfA0PeYxelmB8yQRpsTzBUp9GZgQ+0yZJ0jjId
	LXIfkNViFTSP6x0i93xd+eNjWYfyF732/PnzSKH9bOteIy5PBtD2q
X-Google-Smtp-Source: AGHT+IFBM4C92jB9g5WYIgyFSfK4VqX6ptPMI+JV4FUWTBO8gbXhFHISPMW3943ATw/hCv+jIjxXgA==
X-Received: by 2002:a17:907:7e93:b0:b04:392e:7168 with SMTP id a640c23a62f3a-b1bbd3a6724mr532626766b.42.1758180569540;
        Thu, 18 Sep 2025 00:29:29 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fc74af9d6sm135689666b.33.2025.09.18.00.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:29:28 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:29:27 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, Ye Liu <liuye@kylinos.cn>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: add header line to /proc/buddyinfo output
Message-ID: <aMu01xIkj-3hgW88@tiehlicka>
References: <20250918071741.526280-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918071741.526280-1-ye.liu@linux.dev>

On Thu 18-09-25 15:17:40, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Add a header line to /proc/buddyinfo that shows the order numbers
> for better readability and clarity.
> 
> Before:
> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...
> 
> After:
> Free pages per order       0      1      2      3      4      5      6 ...
> Node 0, zone      DMA      0      0      0      0      0      0      0 ...
> Node 0, zone    DMA32      5      8      6      6      7      5      8 ...
> Node 0, zone   Normal   1113    351    138     65     38     31     25 ...

Why is this needed? And have you considered tha this might break
existing parsers of the file?

> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  mm/vmstat.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index bb09c032eecf..e9606457ab91 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1574,7 +1574,14 @@ static void frag_show_print(struct seq_file *m, pg_data_t *pgdat,
>   */
>  static int frag_show(struct seq_file *m, void *arg)
>  {
> +	int order;
>  	pg_data_t *pgdat = (pg_data_t *)arg;
> +	/* Print header */
> +	seq_printf(m, "%-21s ", "Free pages per order");
> +	for (order = 0; order < NR_PAGE_ORDERS; ++order)
> +		seq_printf(m, "%6d ", order);
> +	seq_putc(m, '\n');
> +
>  	walk_zones_in_node(m, pgdat, true, false, frag_show_print);
>  	return 0;
>  }
> -- 
> 2.43.0
> 

-- 
Michal Hocko
SUSE Labs

