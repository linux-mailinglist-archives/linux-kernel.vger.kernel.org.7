Return-Path: <linux-kernel+bounces-843622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA1BBFDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C201899D76
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAF1AF0BB;
	Tue,  7 Oct 2025 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMQVedbM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3268249EB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797343; cv=none; b=f6rQVDySMA72fUfSnjX9IEu4pHpK9u3XL9WLNR6QOeg3Qx4t5+am2a2Z5iuCZgG/g7ppvaFrtJHNGjwLVUhgulM2lig5reJsVV9D5Q/uQsLyDGgZYeK4pFKuSuyhx0/fX8hFN/QODAvMOkjSXJMmNLoBh0udKZx+73pSm4axd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797343; c=relaxed/simple;
	bh=NJ02XtCBVUZhZ6rCf7V6WivB1JLbqCaihCOuQZnHr80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0KYQvWEaOL3x1BH5tFDy7Eu9+P4TLHataDbwpfoQKrZpSdFxoNv+j29MwwNpfIary27HKhwHmVWba1/P4t1Nig8srnkANPvzZljgqxmwWSCJUaKf3sptxEPWK8De7aakbx3+7b29gUHDueXxsggefxZUjotFhnVfcD5e4pAdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMQVedbM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-637ef0137f7so9197525a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759797340; x=1760402140; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmTEafLLz555+9PYYyX6aK2mRmjoUTzEwUNlTBIE748=;
        b=AMQVedbM3zGDf2KZRmYuTTE7/pNjz6JvRlLU8aMmlDVDHeBKobtyr3FcDA9L8ECBgT
         ZKdmGdaHLXmXbO7Rk3+h0ZuKZ3pnsk3LeWDmu2vpv+C3zAH4qq/9API5nkQV1VETOFkN
         HfdlHnUFMle2xupLWJprS4UA2j/jTfFZHxEnysu79Fizl8avtZUJXtIVFemYPoEjh0s5
         tT/VqT0WRo41HmxH3czlWhdXRMko24to1V4jS6rsBvgvy2MN92ppC7fHPRhxGDS7YdyO
         0sJe/izDC6q5Q+2MSW0k/7OimyFG9jnoh5JIlQ7JuLzQ452i8FuyecQS4uk+L880C954
         2uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759797340; x=1760402140;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RmTEafLLz555+9PYYyX6aK2mRmjoUTzEwUNlTBIE748=;
        b=Eec20kiFPwj3mctYYs0v0dXvIAaPuA3BoGfABYz/lCgvcdbH6J2YsHfZ6a1SuQJZBa
         RsZ3sxXjcU0SOd3N1BvrLRBoVo87QXU8DQwTZlWyamVQG7svt0v+0SVA55oJl0qc9f91
         OHy181FgyrsqWl+Kc0MaiC6W5sH+YeD4WpM3AaVFspwMSY7h2IeHHmAWxrjhFpsGD55E
         +qvxWmAaKhzijU4fzAcwN3xrhCawOosJhLtUzqilHRkAEexGegEOUno6dKsGoxmX2RKx
         ST8wN3dMx6OSliKGMgpr16y+Bz6Ju/YiZBZ5DL7FMmEH9l/FwMd6B1gylBa71CxvF7Ph
         HR3A==
X-Forwarded-Encrypted: i=1; AJvYcCXlM1bqX6AKda7LdvTW+WMLFb1iHIFHzEgQLhlk0+oJKJMu0oBp8xgbUhn6Gj8Bicsv4bmcDoyLawYP2mA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhy8otn621bx7qcXyC6bN6lIu5ZY1OmVDj/BjkksRHsE2hOy3h
	EV4Mvfdwsv0FleusXYZhNkdJz8Cdl5aTT59O1XImBaEXUzZ1gglX2v4O
X-Gm-Gg: ASbGncta/HVfgQgmwDcyRVRjPrEOQlYAuPrEW7fUTYpsgCuOHbWh8ciZzbteV28aeZQ
	XlLHMu8+0kmVUoi1gJEzcAtt5P2POZ/VtO63lASo+IKk0LFBpEg05sdw+v3YhE+8BE30ygAAUXH
	RSDdb5m0qjSEJh3Gkyt6SeIO3OSsCU+ZTeUcWLtjj4Oa3uBXmuE8/sVEF5kVtHGSx/N3PCrDFG6
	tc2LbsIIotxtSspq2BBN4EQ+mXUIyoHUuW1GPaCp+D1lsUKcpzPcphtpQAc7wQnOgHCBwJ8u0h1
	XCMSnPbdZp8z04UXGE4migC4TqaUD1lyQx4Xqy45uHpJtcosL9RkLKqttSxzIfWtgIXRpd29luv
	r5RzIxyp3nSlalJOj6zHZwb69b/c85BqoVtu8YEMWsuIhmrgJuQ==
X-Google-Smtp-Source: AGHT+IGTr+zz0fZdhcPlWyAVEVhw1eLda7v8W50j43hQzJxysrhCRGQQh3TjjtHlO7I8gMpDi0dgVQ==
X-Received: by 2002:a17:907:9707:b0:b09:2331:f14d with SMTP id a640c23a62f3a-b49c429cf0dmr1613887466b.64.1759797339928;
        Mon, 06 Oct 2025 17:35:39 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9f11sm1254464566b.4.2025.10.06.17.35.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Oct 2025 17:35:39 -0700 (PDT)
Date: Tue, 7 Oct 2025 00:35:39 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
	richard.weiyang@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH mm-new v2 2/3] mm/khugepaged: use VM_WARN_ON_FOLIO
 instead of VM_BUG_ON_FOLIO for non-anon folios
Message-ID: <20251007003539.evunghgqxysojtr2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251006144338.96519-1-lance.yang@linux.dev>
 <20251006144338.96519-3-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006144338.96519-3-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Oct 06, 2025 at 10:43:37PM +0800, Lance Yang wrote:
>From: Lance Yang <lance.yang@linux.dev>
>
>As Zi pointed out, we should avoid crashing the kernel for conditions
>that can be handled gracefully. Encountering a non-anonymous folio in an
>anonymous VMA is a bug, but a warning is sufficient.
>
>This patch changes the VM_BUG_ON_FOLIO(!folio_test_anon(folio)) to a
>VM_WARN_ON_FOLIO() in both __collapse_huge_page_isolate() and
>hpage_collapse_scan_pmd(), and then aborts the scan with SCAN_PAGE_ANON.
>
>Making more of the scanning logic common between hpage_collapse_scan_pmd()
>and __collapse_huge_page_isolate(), as suggested by Dev.
>
>Suggested-by: Dev Jain <dev.jain@arm.com>
>Suggested-by: Zi Yan <ziy@nvidia.com>
>Signed-off-by: Lance Yang <lance.yang@linux.dev>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

