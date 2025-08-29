Return-Path: <linux-kernel+bounces-792554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D1FB3C583
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AF65A44A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9B35AAA7;
	Fri, 29 Aug 2025 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxDyBhFl"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BF22173D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756509023; cv=none; b=QzrbaoAKBRNguSqBJHUcJ6HAPV49+NfHQORSFT2jv9gypwlQSrsAATY/iCFP5dX5RdKSqKsJzKrwV/uZIb54Ld1eQdy9Qz3cY2WY3gU+Ty0DQLPzkc/pc9Rs1WF++2zxJLHG8JFKYFlLwH8ClrT5dVfUrp7YkBmwjG6tgwT3M5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756509023; c=relaxed/simple;
	bh=qb6UxXdmUJOFC/RWOVjIGSSJyLwWLgQwYqFiSXaqDiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws70ad9iLpfMuoQ+FtuQ9AxK+3pe+ApwAaJSYei5xSsP4dCZe3DUtja1kPzFJ0tMnJqbQ8UCcCUJNbE0syeJ+S6hP0zA0ra7jD/mEPa3QuP4Y5AaB0M/72NYQ5vdgkRuH7+6VCiFcvXQOWGHuBaJdJMj9K7V8Pd9oVLsGJapJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxDyBhFl; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4c72e4f1b6so1230144a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756509021; x=1757113821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLGuuVLvC0FYe6vAnZmrTVaRCP6gublbfzak+XpRncI=;
        b=VxDyBhFl1Vr1yktBGxFzSjelab/jrOJfHw97P7g963wsnxogoAnUspyJTOHG1PEkLA
         t9qk4cFFOuMA+nohiPnaByGJvSZ69c+18Zj6WBlYfWuo6IxAo+0gM7UDvozI4Vp5DAmh
         7ONZ4S7BkdWVp/UWoLM0DUmTIWPpIOeVTI/Xov3h0OTodovUQKEqpk5hIPG5Wgef1Y1M
         sxIRWspHmh3GR1/gI3M8mUKqdY0mznQQ/BIQXutT9g+9TDRoHK3ZvSZCS9URWkjnLX8T
         HCNq1rFf1kBtD1HaIGwldK2f0Qnfhf8M5gWWI3ehgsB39qR630eOeMcyTVJnNBmHifVE
         BXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756509021; x=1757113821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLGuuVLvC0FYe6vAnZmrTVaRCP6gublbfzak+XpRncI=;
        b=do9IRxOrR3uS6OsN6vTrHXA1IqCSrSQs59pD+rQfzSr/Agjf3nlcFdc1yoz8v3d9f0
         RrljWquM469xtZ8MGnYUrxv5ZPoruZgCT4DKncwMox6oYEwLy/DksBujts8KA5W0Xa0v
         rO+i/rmmLSWp+zzN4Iyc11AVISrS57uYBWsF0EOAeb4n29Bqtj/mvD4Iv67GpsYsu9ux
         lvh1BDbmqBGMarkoAxE6xvj/sUC04167DgjMOWlPqVDMWEh3XrJtd4lKSLNJmN7x6J37
         Mp1LRB4ObEJ5K0flyDRYLeyf3B27pllUEdodlPtu8pr6ASeO+jnfxUFx6/RNzE+dDuIM
         ueEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOC4nEVlSilKI3y9byv12rTlzumGYBd2ZujKGNe+ZO7C+MlO+0XLeNPzmwfNiPX/70YWx98k93ZZMVb80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW9eeaFa9Msua9Qjlf51Lv8pzPJwH0Kk8HwPXKKT08mBJl8Vyd
	Jzd8ERAkXveO4meIUbKVSpj1x/VlCl5E1DdfD7hK0ZwXl8azN9cVWdyY
X-Gm-Gg: ASbGncsS5/3HjYeTg4OEmICzWB1pnqLAGsFBg5Pdha6rgq3VNM9VwyezTkf/MDBNvdr
	nYva8V0aTr89Pqb41RybEGrklbMCEanrvGl+Xy5jRKKZ02NqiVssmIfxs+EonItCdArPDMgYUyp
	3CoehXK12aGJ7BBJHQPkvZwcw8NkX90GkDgctymVl15W/E00NMGKlsOOYhE035pD43Ih43F9lrQ
	uTCjVGgZIVkgPsxPEY9P96OFXG1z6EInTH7VTwUlaFGY2iKDqKq7Eej9SkdwkEqCbDQqewAWuf+
	P0oJATbfsiwxoniu5dKQP4mBUBFs6MxDeCw4SXt4nySqO7gyOEMESpa/vkdT+j1rczDilbaapOq
	umA0cyM/o53/pDavCNC5TlUhuNfUvg+8t9+SnRRHZ9twkUfRsox5s+w==
X-Google-Smtp-Source: AGHT+IHQ7aGyKXT9USKBNqZpOtpxttgC5amNcPf5s75dLoJAaPCgE8cRDcRM97Ojq2iQCa0/7J2Tlg==
X-Received: by 2002:a17:902:ce89:b0:246:80ef:8808 with SMTP id d9443c01a7336-2493ee07085mr12422855ad.3.1756509021264;
        Fri, 29 Aug 2025 16:10:21 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065b73f1sm34684345ad.133.2025.08.29.16.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:10:20 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:10:17 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 06/12] mm/util: add `const` to several pointer parameters
Message-ID: <aLIzWR5IQr7D3wBa@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-7-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-7-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:53PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -549,7 +549,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
>  #endif
>  }
>  
> -struct address_space *folio_mapping(struct folio *);
> +struct address_space *folio_mapping(const struct folio *);

Can we make this (const struct folio *folio) like below. Its more
readable imo.

With or without that change, feel free to add:
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

> +struct address_space *folio_mapping(const struct folio *folio)
>  {
>  	struct address_space *mapping;
>  

