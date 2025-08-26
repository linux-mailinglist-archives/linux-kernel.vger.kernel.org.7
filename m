Return-Path: <linux-kernel+bounces-786911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1678EB36DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED5617346B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B227815F;
	Tue, 26 Aug 2025 15:26:49 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2211FF1C4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222008; cv=none; b=GYH52EfQ1+Kq5hvuF+sWi3Fjuhony17rqxQYfnFx5zoXQJYV4RftIODOrclE3S3piSIvDOq20HyA4gxtzFDd62KLfeDqsEKHsUMJYvw7Eay88YmiudFtJxmUIGckI4l8HJInaaLXDWB45jh4V02gTnc49wOTOBrkuJ0+Y20Pmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222008; c=relaxed/simple;
	bh=v1N3I/Gie5yChrhLCZX8ASH+n8v+bYZJx56eFAPyMM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWbwpUZGFRH0T/9tdYAVtIZQeWBAWKHka3k4JAqMjF4D6pJBUPoRkQ21JuGgV7mxFT0CihNdb9vgnVQo4R+dqQ/8SMs/L0NHIGj/Y4XTgp//0N01U5KyaVQHNZ+QN6ukwHi8mzwRA0OSDa6hsdDfHshPIbe567H7JdrEDMMtc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb6856dfbso1055767366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222005; x=1756826805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVkVgsShdpWJsHwAY7c/HqdSCWng8HRKeool7od41Zc=;
        b=gjQsnIkNQ/QfdCc9MC7wSry5gEhLkvTUMUGtIuaZSSM3Yahk3My3DZdGn9tqFOck11
         U9ZNbXWbduJWmbZvF7EmkJyuRRTj2yyqbUhB2jaCE8M59Vm9A8xOCjEZnBBunh9VhtCD
         4PBpi99Ou9rvURojLopuSz7KzRlQFmvLzoVe+h8X8+Xuuidg1qhm27OZVkMrb/ti7ef5
         5UrS2TjvfUm2s9ql/qy73DcUoY5FgkhyIIabYjxgEUbSUN1POHXalLthU1ravGbcuWOB
         8IwFbc3joK9LQYVzIWnUp/bDjHL4WTkDH4LF4nWckEug2FDvLNQbCIkEAJFcIUN9G6G8
         tx0A==
X-Forwarded-Encrypted: i=1; AJvYcCWgbSuLmZbegC8ugP3sMp+2DWG1+wmsp1fbeuiiE7ywOSRjh3h9wLRZuVHZ3ypv/sD8W5Zloi4/M9Kk0ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjgLWlrpUZ79Q87ulN72huW1h7rP4soEEFSLefNIsxS7eWxy6
	u8r/A+S5WvWyguYmK7ZwRPEZgyXkOrYeXh/d39mIu5bfPsyvoxrz0jR0
X-Gm-Gg: ASbGncsuioDS3Tb6plgtffXRqmMhLMmKe6N3IaBoCW29yGh+gfGIlV7+gv7Zp9KT9A9
	t71jgyQ0llU1m4jh27NWE77q1nH5j+2xZSRHkzduBOxxNDkS56ioQsYDIw6ONTNxVZFwJZiZ6ZN
	T5rq056oeADnPpOfArdFuHFF0aYTyuknZz3Eo/Lsr9tKtocK4ZhkZKIG+IgIiztKlei3sj+rtUN
	MjiNYYMTj042MWHkUg5qWTdxPUPuUCg0x7eIv/e0RRMpu/8nyfUjnj/DLIliFBWfaxz91mRmi/s
	A4APalUZwApS+9pCttyHXZNU21936FsYdkOQqpm/2lQbnqXfhGivJbFZd8mzs5emmQ6r7HvV+AC
	MUOgt8gSLYf0MKgHyqqktt1rW
X-Google-Smtp-Source: AGHT+IFywaQm/SYAEkgpvTya1QCs8x+TYb8PSoO8CqBuiJc0HWJDKYF8Wnxptjc0r0Kk2hzhDgRRvQ==
X-Received: by 2002:a17:907:7ba7:b0:afe:8ae2:a8fe with SMTP id a640c23a62f3a-afeafeca898mr226076366b.14.1756222004741;
        Tue, 26 Aug 2025 08:26:44 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fae421sm811426966b.26.2025.08.26.08.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:26:44 -0700 (PDT)
Date: Tue, 26 Aug 2025 08:26:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bhe@redhat.com, oxu@redhat.com, berrange@redhat.com, 
	kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arm64: kexec: Initialize kexec_buf struct in image_load()
Message-ID: <2dq3z3vil5vu2m4kbwdps2enozbqrzbp6fd2utdr6dj6kutzxf@f3vububg3s6j>
References: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
 <aK3HVqt6I5KxoHia@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK3HVqt6I5KxoHia@J2N7QTR9R3>

On Tue, Aug 26, 2025 at 03:40:22PM +0100, Mark Rutland wrote:
> On Tue, Aug 26, 2025 at 05:08:51AM -0700, Breno Leitao wrote:
> > The kexec_buf structure was previously declared without initialization
> > in image_load(). This led to a UBSAN warning when the structure was
> > expanded and uninitialized fields were accessed [1].
> 
> Just to check my understanding, is that only a problem for new fields
> (e.g. the 'random' field added in [1]), or do we have UBSAN warnigns for
> any existing fields? I assume there's no problem with existing fields
> today.

UBSAN is only complaning for this new field that was added to the
struct, but only populated in x86, later it is read in in common code,
causing UBSAN to complain (and even wrong code to be executed depending
on the garabe that is in the memory during kbuf instantiation.

> > Zero-initializing kexec_buf at declaration ensures all fields are
> > cleanly set, preventing future instances of uninitialized memory being
> > used.
> > 
> > Andrew Morton suggested that this function is only called 3x a week[2],
> > thus, the memset() cost is inexpressive.
> > 
> > Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
> > Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> This looks fine to me, but I reckon it should be added to the series
> which extends kexec_buf, unless there's some reason to avoid that?
> 
> > ---
> >  arch/arm64/kernel/kexec_image.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> IIUC arch/arm64/kernel/machine_kexec_file.c would need the same
> treatment in load_other_segments().
> 
> If other architectures need this, it'd probably make sense to clean that
> up treewide in one go. It looks like at least riscv and s390 need that
> from a quick grep:

Agree. Let me send a v2 addressing it on all archicterures.

