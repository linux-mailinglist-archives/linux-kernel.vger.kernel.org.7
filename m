Return-Path: <linux-kernel+bounces-808521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D30EB500D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DFC7AC7E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829234DCFF;
	Tue,  9 Sep 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MHOANEV1"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976B31CA4B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431006; cv=none; b=aHQ/xoAODEoRPTpOg3DieOqaPXO5oEhspyJIqbhYuSaByIqDqE5dt41uJx/IyoVvwtvGD4vmKrXTw/qE+/IaCABX3DlJV0jBYOfJzJZIv2c1BpcarP9t28YH42Jd4NDTkV2hahT1CggE6AAGtK8cc1r+3qBWtCOn/jZ9q6SvWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431006; c=relaxed/simple;
	bh=f+UaUmU6udEpPBMLjtY423HAghvQxJiSusaBrGUJpCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmOTlI9ef9cZs8y32sjeAIqE+9U8DwevaVNv5EXgIbfWGhTKgM64I9boILYOdIESzxPUtCKU1xeTqrG+YFTmShmS63OgTTzyPw3hTxi0vJhTvmkx7FuZM5256KTckH2tlwqM0iGCQojjeTyppCR82AETyA9ZVDe6k9TtNbWEB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MHOANEV1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b490287648so93649391cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757431002; x=1758035802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMVyNEMIYzhPHpvXp6Ti45drIfjgHT9dEeCQ/o4OoQk=;
        b=MHOANEV1sCMhW9Hw9Etex9BvGxTKKE31zrNgo7JwYAgf7O+wCHWfAeLxgIRgMXkuJ9
         CcxCNqPhaLrykCFaIdJCkppnbQT32SVI/2rT4b1bEsUaCOiPZynhsvQmuV3w3tbQcDUL
         DC4hfBu0EeoER0jABQ1e2kQhpRJPOWVPhSMev9qcmJuJ6fwX0yu0rmeF7Qc75kR6QJ10
         ewRvrgoWF/dmxKS4Vyr9VNoiQIeJVY0/u2W8N9+xbdWfxU34uQU13ksLgnxMI6w1XJtg
         xso0nU19GdT86bPx+HVhzEsvYDB/I0vLun/1A8Uf1ex3KD72P1VothaAt65mobF//TfP
         aQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431002; x=1758035802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMVyNEMIYzhPHpvXp6Ti45drIfjgHT9dEeCQ/o4OoQk=;
        b=ohIPT4y/SiUflHNjvGQVfowNqR/mK+a2y8JEOTXDzqUk7uniW8PMbxo18Z/IaxmWOY
         UnUdX2kATajOPwdqTD6kMGT+eiS1xssDlsiksyR3xN0u9aB/ReDvmQNnYEHJh/3Tg1jt
         VGAxUh1+FEeL/MggSX5bn9g2jpekLiCv361V3pdbv863Qnb7IFaGrrLAhQNSuZ9+sXeG
         r0IFjjfTlpBSYJ5MM9keOvqU38kx7Gpv42jwpiDe97ueK3sXKFJj/rHkpSNkjOrEcZdi
         rB9vkx1wUy+0t/hMcwT6FHuJcbfgiS6b9cwM0oWCgUKW7pvhU/aID41orCPbYLbw1kQu
         MGKA==
X-Forwarded-Encrypted: i=1; AJvYcCXFJ9unJNohGFqcFAMY5Aiq5eOJXBO4bVZ4bV1ClP3yrlys+VfaS6IgA5ncnUQ6bCwAZUq5pYmOEhVIGUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd8Q2soAlc15NdkFOxW5LuE8Pkwtms+K3sXAQEnyroSKVHa/k/
	8UP6ioVNjtPpm47EPLkW2AJITm5FFp8hOvPBvi+PvJccUGKAl0yZbc7FUQacUvY/fcdrK7/qZ+/
	CQKJF
X-Gm-Gg: ASbGncsgAis156stGRYb4viXVYTsKVpwB6dtuxRyuxcHQS7bJAwJZM1S1I42jFScvdD
	H5HuqxG4U/imIik6ziOdqvTUSa8Ozm5K0n+2OTo/cutSzzeBx43f+FemrvYXUB2u8e2X19Sjmml
	6GbJfqKmir0xlRwz3TYLd3ThPMd46lz7X9wz1kub/KR9yIAVd+C1sNiF5CKsFpn038zdQXYB3Fd
	5B188+utH1zjE3wbI3l/SjggMsTLlUxD1l6lhU6sSNuN6RuqhyxMNkaVcL2ITx/FKwFFYMi+Sx3
	7Zz9bVd5abIWr1ODKf8R3AbVKcCPLtLq9jTh0CKnsh2wmL8Y0OtosWIS6Jl4nNZ13dRRcK9QSms
	6hw==
X-Google-Smtp-Source: AGHT+IGY+axgPh1+a9hEq+zwI22+ok64znOXyEBd1T6ryY/GteQhW2JlKsyq2rpVFX4c62eRhoaYbg==
X-Received: by 2002:a05:622a:252:b0:4b3:8d4d:bfc0 with SMTP id d75a77b69052e-4b5f83b0d83mr141400851cf.22.1757431001762;
        Tue, 09 Sep 2025 08:16:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::fa4a])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-81b58d496d6sm134210385a.11.2025.09.09.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:16:40 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:16:39 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: remove unused zpool layer
Message-ID: <20250909151639.GF1474@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-3-hannes@cmpxchg.org>
 <rcxmemdxbxuvtag2qv4sjxoh7ho4z3bz3od6i76rc5yholx2rc@vncn6iuuee7b>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rcxmemdxbxuvtag2qv4sjxoh7ho4z3bz3od6i76rc5yholx2rc@vncn6iuuee7b>

On Fri, Sep 05, 2025 at 06:58:47PM +0000, Yosry Ahmed wrote:
> On Fri, Aug 29, 2025 at 05:15:27PM +0100, Johannes Weiner wrote:
> > With zswap using zsmalloc directly, there are no more in-tree users of
> > this code. Remove it.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> [..]
> > @@ -125,45 +122,18 @@ config ZSWAP_COMPRESSOR_DEFAULT
> >         default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
> >         default ""
> >  
> > -choice
> > -	prompt "Default allocator"
> > -	depends on ZSWAP
> > -	default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if MMU
> > -	help
> > -	  Selects the default allocator for the compressed cache for
> > -	  swap pages.
> > -	  The default is 'zbud' for compatibility, however please do
> > -	  read the description of each of the allocators below before
> > -	  making a right choice.
> > -
> > -	  The selection made here can be overridden by using the kernel
> > -	  command line 'zswap.zpool=' option.
> > +config ZSMALLOC
> > +	tristate
> >  
> > -config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> > -	bool "zsmalloc"
> > -	select ZSMALLOC
> > -	help
> > -	  Use the zsmalloc allocator as the default allocator.
> > -endchoice
> > +if ZSMALLOC
> >  
> > -config ZSWAP_ZPOOL_DEFAULT
> > -       string
> > -       depends on ZSWAP
> > -       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> > -       default ""
> > +menu "Zsmalloc allocator options"
> > +	depends on ZSMALLOC
> >  
> > -config ZSMALLOC
> > -	tristate
> > -	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
> > -	depends on MMU
> > -	help
> > -	  zsmalloc is a slab-based memory allocator designed to store
> > -	  pages of various compression levels efficiently. It achieves
> > -	  the highest storage density with the least amount of fragmentation.
> 
> Why remove the prompt and help text here?

We shouldn't ask users unnecessary questions. Zswap and zram are the
user-visible kernel options; if one of them is selected, they should
just quietly pull in the zsmalloc code.

