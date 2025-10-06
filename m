Return-Path: <linux-kernel+bounces-843213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6620BBBEA49
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264E33AA089
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF542DCBEB;
	Mon,  6 Oct 2025 16:25:59 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED72DC77A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767958; cv=none; b=N2DFnFYB+KzIuXd5HHB7pCWIPBxnf72xSyLLYAlPUc73fZKM75zC5OgWdjFCioToaYPw8QSfFUfkdJ/1mkv9z28duGfD20kZY8IptL492LqVIZ+mm9+iVQ8ILa7XWc08v+Acu121oO7/IvZCEZQtTc8Ml98xfUFccEwrdadMokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767958; c=relaxed/simple;
	bh=UDHIA+rT96JxJeS7VpDVWDL7ReWUFI0T4W/uwCwrUhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfoEuA9dnsPQT/aQVdAUKa1dr1QJHO2+Oeq4wIUa1dNzTc+n1FyvT1WWPUphc5eEvj6sDddCr5R/3tPeSvQ3+0RzwQUw+0LjEBsIRyGTcZrOPLy2PZl0Yis1yQjeSEBJe4iRZdxGPcAVDHh9WmrCIGGae+KanKhY0S8LJSTWKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso12409640a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767955; x=1760372755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3ezdJfUGEJ5h+e5P4gXyUh1Kf24KIpHMutjKUxVLWU=;
        b=rIKRHyET3MRZO2y8vpWY2IZKHTswC/Pr/Z/ZxeskZLOOJlQ2BntOMcigDLwZJrUnc7
         1zOgyQcPpf16V13lQuSPPxwQMKtvGfA2MHuQqL5A3L0jCd8loZ9/b2cV95OW9ZCIsf7W
         IOi7VLB0AGksr3t/qQr7BeaLxGZjCwrZWi88WBrIMPa03v8yAmXAl2y4oE6j2tAUohdO
         zuPWlXIIhRGt+gJkPua14XF3wizCJcniBBL/csDml6uyvbydfVDxOpeFOgp6cK22Izbm
         ZWyb/YhwEX4B3CbfyRZsIuev6AA87GuDcwLKeljF4Y9XeLPzI29FX+D8Cy1EAA6/Pnyr
         xtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUazkqRSz/YFCfsK5QIcJIvFOlNfdhB01PwgG9qF4dsNJaVnf25bJEuQ5anHXF5aNifzHV+5OC97dKoIVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYKoMrTDKtdOBoJ0MKez5be56vQpsqENxEMOhrOJ/FwKA3ugT
	AR7iYiLhaw13VSKJqfC5wGt0Qz9TEnhwRwZnsDc0AId2dlmUSXvAAwYz
X-Gm-Gg: ASbGncuUmWHM1AFfdA0rZU1VjCV1FaE77mkK5IvtT/dA8eF87MoqULALc0b8roP2c5d
	UHjdhhz8AJIQz5OKRMe1TiWKIMkuaiYnpqFnNRqITTgg4xxjqekHtlD8YgkSo8hNuLOQZC5orLg
	dEcsb5vfxogk7Vfm70VrBnf4NXjw22yQl0eVkfU/p5OPAj8CHlalWdkUYAxMlYM14G1U2IA1tGE
	mNEDkza0wymn1l6hbT1bQU6wfOgeb3rZYVxoTKugVkoZVGfH8CSk1WASaWGqw+eh2FS4tRU+LzP
	O+Lr/RUVBKsNQGRhve1O01VaaOMCxzK5aRrNui09eS2mAkXqeF29XMBSAMBGk1ro/01zQQvPNed
	hER0kSCmAPcUIF6SR89nBg75VpGVYQwVgD+Ca5v1U
X-Google-Smtp-Source: AGHT+IHTdpA0zEqEOLtB+HjVImjUU0ECe1QSWxgIxQTb/UwEPQR5ZGbAA+8IxrYbKsRHP5GMNZS5RQ==
X-Received: by 2002:a05:6402:1ecc:b0:61c:db49:aec0 with SMTP id 4fb4d7f45d1cf-639baf1bbc5mr216512a12.5.1759767954748;
        Mon, 06 Oct 2025 09:25:54 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788111f1fsm10608112a12.36.2025.10.06.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:25:54 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:25:51 -0700
From: Breno Leitao <leitao@debian.org>
To: David Hildenbrand <dhildenb@redhat.com>, kas@kernel.org
Cc: Jiri Bohac <jbohac@suse.cz>, riel@surriel.com, vbabka@suse.cz, 
	nphamcs@gmail.com, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, 
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>

On Mon, Oct 06, 2025 at 10:16:26AM +0200, David Hildenbrand wrote:
> On 03.10.25 17:51, Breno Leitao wrote:
> > Hello Jiri,
> > 
> > On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
> > 
> > > Currently this is only the case for memory ballooning and zswap. Such movable
> > > memory will be missing from the vmcore. User data is typically not dumped by
> > > makedumpfile.
> > 
> > For zswap and zsmalloc pages, I'm wondering whether these pages will be missing
> > from the vmcore, or if there's a possibility they might be present but
> > corrupted—especially since they could reside in the CMA region, which may be
> > overwritten by the kdump environment.
> 
> That's not different to ordinary user pages residing on these areas, right?

Will zsmalloc on CMA pages be marked as "userpages"?

makedump file iterates over the pfns and check for a few flags before
"copying" them to disk.

In makedumpfile, userpages are basically discarded if they are anonymous
pages:
	#define isAnon(mapping, flags, _mapcount) \
		(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags,
		_mapcount))

	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.h#L164

	called from:
	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.c#L6671

For zsmalloc pages in the CMA, The page struct (pfn)) is marked with old
page struct (from the first kernel), but, the content has changed
(replaced by kdump environment - 2nd kernel).

So, whatever decision makedumpfile does based on the PFN, it will dump
incorrect data, given that the page content does not match the data
anymore.

If my understanding is valid, we don't want to dump any page that points
to the PFN, because they will probably have garbage.

That said, I see two options:

 1) Ignore the CMA area completely in makedump.
    - I don't think there is any way to find that area today. The kernel
      might need to print the CMA region somewhere (/proc/iomem?)

 2) Given that most of the memory in CMA will be anonymous memory, and
    already discard by other rules, just add an additional entry for
    zsmalloc pages.

    Talking to Kirill offline, it seems we can piggy back on MovableOps
    page flag.

