Return-Path: <linux-kernel+bounces-828284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C109B94500
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB02D3A81B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0330E0FB;
	Tue, 23 Sep 2025 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCPjujp1"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69230EF68
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604314; cv=none; b=i/IC/R+eJmPTNiimGG2HDD1/GxWctKN3IcHV5Xl5oUpZ81Z1i0gUiTFBbiAG4DbyXMtaDPFARvdJYXb8KCl6L1Q442CLgPTYoW+ENcSdyVxH9GDEN6b+dntbRBfJ9I7YMinz4veMwcxMhoV+1Fe7cS7V80ABrlYQ/9J6fsjPfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604314; c=relaxed/simple;
	bh=H8oZjwkzLuzCrJu5AgJD/IpchDJW9dBa+Wc3mxEgcyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTMYS/XncCVzfDpB9n0H+kdTIPvaM0wGfsURNmTuDOEmwAhS+zyyuABPirV2Mz73R4Pnt+kef59i1mF7+CMbHIwtC4yoNtc6XhTRzRAibWTOQmyseruN7EMPz6r/AdD6IQtmT8C/OyKivokPNXs4UtpXuCow7E0sSe+AR5ptBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCPjujp1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso8176697a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758604311; x=1759209111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H8oZjwkzLuzCrJu5AgJD/IpchDJW9dBa+Wc3mxEgcyE=;
        b=gCPjujp1JdouS76OkasmokxcZW0aR8SLwkhq/9w56Fz6gS8XbFgisW43dEb45B5WA2
         8+iLNyuY//582GuqovKknJabYEtLa6Xm3zcPZlms/KSs0MZ9cpNbZv5ucvMuz2L5o27g
         GYFgH8bb1K+WP/TsBOxJbvKpO55oB8OYgd2hvkCuOwpwzIfZEVrRAH5TYE7bYXrcE/PM
         0i3ag04s5PdcxYboNCWjuLMhGEXZPq7fpTvfqud+GphJL53fB43YLb8DPFmsHMX9v/UN
         u+QaFzPmPLujxnpxNKMOAlRkReo/KOcolOLv0Rs4H16bkLSfLQzigNhVFbei10rm2l6Q
         hvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758604311; x=1759209111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8oZjwkzLuzCrJu5AgJD/IpchDJW9dBa+Wc3mxEgcyE=;
        b=wmvCzYriKoJ1Chv+UrS/ROh9owm5U3iTd5KtmmK2hMNGsVBXLL8kg0ErgnhvmhNvHc
         kUFSV9NFggqxIWEonJ+8UOuT+fWObOr65grBOmQIoyTE/Nxg8ziD7lQqTG/XuE9r4FQ2
         Ww8HXiafk/O/E44b9e/vLwyDAf0LaDKg5T3ilewUdMGv2osJsSVWe5jiwWOnhhTSv9vJ
         Z6zqhYBfMwG24fBQLvYYaH2SHbBUBjCC/z4CAWDubrad1xpm0yIgOIReE0HNTGqYBYgy
         5MMQ9KGNazszF5F4UMSjuvJNQaUrZqBE+t0Fn1NribRSGJVT4XxlkiUX97CIsa7PjFFv
         Vdyw==
X-Forwarded-Encrypted: i=1; AJvYcCV2b02Uh4TEH5y6qHTfrZGiPCbtL63/hK2BARMmYQrXOB34aa1SC8G2o2rZ2Q32P+/Fr3ihwgFIoSMJWbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoI/FN3gpDG0Micyl6bR8XJK98lxR3BxQB/NBVVI3OBSLb1zok
	+mIdoPj9DBNuRwYne0KETkQvoQJI32zMgZPKAoLUMhAsidK1MqVx3OMIGOoswSyfoJAn+ZMIGRC
	DEgkG13AtdEOkcYE7oBAJm/dPUMOnojE=
X-Gm-Gg: ASbGncu31qOXKL1y02QSFFOOLDMNFPJILeIw5nvwIro1jtWwc1y55Nt9prioWWCEmuT
	7EU155HDGvjXdyk8N0pmjp/irKlvbf0vDwy9X9HwRnu4Rsq6vl3HEyFGa34tWZhPydtgTfj+23a
	DqpswzSbo9YMMj5rn9Le9ldmIdtbrNN//UttXgMu2TP/LrcjVwbREhXPTrO8asvqKt1IiHE0dbu
	7totCf+IU2kmckBDKxgMB7FZB3EHU99ESVtZvrD2F8B86K7U5Z5xw==
X-Google-Smtp-Source: AGHT+IEPRdvpieHJw8RRRxoSE2PSWeDmEsF3LD8Vt0hJlWeSXhWvyc1YF2YZ1JHwU/y/0MfHKNaPmCTEz9q/HlDi2A8=
X-Received: by 2002:a05:6402:4311:b0:631:b058:bf04 with SMTP id
 4fb4d7f45d1cf-63467812253mr1028138a12.19.1758604310599; Mon, 22 Sep 2025
 22:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922170357.148588-1-viswanathiyyappan@gmail.com> <aNGOnDb0WsIbk2zx@hyeyoo>
In-Reply-To: <aNGOnDb0WsIbk2zx@hyeyoo>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Tue, 23 Sep 2025 10:41:39 +0530
X-Gm-Features: AS18NWAz93VsrUOfHCTB4kaK6hHURodNuYHUG5D8F71sybC2WG0KWMO2FAQjnLQ
Message-ID: <CAPrAcgM=-2dvHg5yvsqtT_YfjH-gThc+iGZGJpc8gpKbg-OdrA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/slab: Add size validation in kmalloc_array_* functions
To: Harry Yoo <harry.yoo@oracle.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org, 
	rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev, 
	syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 23:30, Harry Yoo <harry.yoo@oracle.com> wrote:

> When bytes > KKMALLOC_MAX_SIZE (8K on my system), kmalloc redirects allocation
> to the buddy allocator, which can allocate up to (PAGE_SIZE << MAX_PAGE_ORDER)
> bytes (4M on my system).

In include/linux/slab.h,
KMALLOC_MAX_SIZE is ultimately defined as PAGE_SIZE << MAX_PAGE_ORDER and
KMALLOC_MAX_CACHE_SIZE as PAGE_SIZE << 1

I was using those definitions

> Because allocating a page with order > MAX_PAGE_ORDER page is never
> supposed to succeed, the caller of kmalloc should be fixed rather than
> kmalloc itself.

So, Is it almost never a good idea to add new validation in the allocator code?

> I think the right fix should be to return -EINVAL in max_vclocks_store()
> if max * sizeof(int) exceeds PAGE_SIZE << MAX_PAGE_ORDER?

Thanks, I will go ahead with this approach

Thanks,
Viswanath

