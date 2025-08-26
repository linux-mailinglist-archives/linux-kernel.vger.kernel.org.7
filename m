Return-Path: <linux-kernel+bounces-786581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B651B35E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4935189BFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60B2BE653;
	Tue, 26 Aug 2025 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGb3eJS5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B254200112
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209178; cv=none; b=jqMPCatUAxIJmk7SV+xtSijp0528KxyyUdObzPFXPruQNN2UMP7mz++v9RtHRKJp8l2xw4N5EfbkFbGHdEqDW+mZOIjipBQTHpP+f8OosyDArb7Z+WAYOyv1GmSAInLmuaV/+/+DxSOLP4JRDbJ0H+k8E+qnvaW7azfmOhDsDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209178; c=relaxed/simple;
	bh=GR8wOyKl4HbIY5koqYX6Qcxm/LL8C7IpL8DFj8Soc1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmi9WkRT7hLaRQvtv5JP/OwZVAwpiI6Ys8n5L34XrDSZYs3JgfdPfLOUDbVrH45luk1S0uUCHG9aA86WBOxHYIs8L6ZP3L9NNzhJENxn0JxTVVsRot8f/WdCwmH4GE47KkcnGOtc9+CKk9Py/2B+FBcZ/HkaB5DzN4J0PsNMNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGb3eJS5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756209176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e53lcb42G3RVNhjNWPFwju1PJTH1cjj9lH1MqnWkPUw=;
	b=OGb3eJS5HaMnsnwILZORtvCVe11rE6PZnS8H9bto0aciOkEcLf1CBZycrRC9k3d6DClH6P
	EReDPPMTehSvJ8906fnKTmBswQALdSmVr9Mg7s2GgePM/KPR4jZ6eyg3HI6uzvm3FuSrnx
	1kp2Ij7LNxjyrO+IxWMfXdwblBncZ6A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-sSY56QaZNSWgMyauv2LRnA-1; Tue, 26 Aug 2025 07:52:55 -0400
X-MC-Unique: sSY56QaZNSWgMyauv2LRnA-1
X-Mimecast-MFC-AGG-ID: sSY56QaZNSWgMyauv2LRnA_1756209174
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870614b86so1878516185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756209174; x=1756813974;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e53lcb42G3RVNhjNWPFwju1PJTH1cjj9lH1MqnWkPUw=;
        b=SOmDLDLP7z/UBb2Qu7RV68rfQfJLtqZCONqR4TYwcie14c3xlCI/LlqALQ5gfM0KNU
         SzhYcfMgQlCB04UvtMpsZoCozBH2OpeE6/XnnehEpYqQPUJkyA9Jd6beCf6WsUAXrRDI
         UgfsIuR9sLRwB1rCdd7/gYIkM6kk0g9o21GUZ3XtA1dZXzSyJdkNPfrENJDFv80gg2ko
         WfxALMSuTXohB5SIFMeLq5EHbGvNSIVgKMHi47QpxgO4kP1OZ3B/HizgkggbmHIiX2KV
         JszBsvtP4bvDBuOB8pKdXsyzCYnE1L7fc1/REfmHYZ6RrQjLiOJbe3i7YHHfBM+Ue2as
         3nsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcBPo95B8uel/ucqxZNjFhkkQxiVSpVGAG7C8AK/9nzADzR6Dg5/XaWrRcVTOyaORtAYvk2Lwmk7virzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNvlMW3nEfg20bSt98XkP/FNvJfd4ZJYeQO11LV6UWVDO7UnO
	D49F1vHhdlJNFw3J2nBizpEQ/csYtNOKhe0hpaMR+mAKpcMRPKs8d2InXdu2v6uRJ2JhtX7HqD+
	ZvkehAk0kbGXC1Lc3shmUur7Dc9WLGjCN3BcMnNPxNTE/8q0k6KCNkxMakDnkxYe0LQ==
X-Gm-Gg: ASbGncuEmaRgdAPKMxU9cMuMWDLlbbe15bhkhMNc3usvJhJXm98BWwhllgZirNpP7SW
	FcBPNR6oww1Z9AbFQuX525JQAcePJeHJysilMiHngj7Z5BRuZQyQfvmFjKAJL9NaPDiBTyBPBss
	+oheX+MdgDxuHiZuGaL3Y0QZ2/W40o4LkcVVYLeQRmz0lH7BKR9zwLSXBq0pem96C/3VutVMJdm
	6Z8qaya8IHnMjgeH7rJ0XujWp0Wl32vtpLhj50BzWDAXMW8Dzid+Rsvt2HxNo/CAdq59mAQ4A0P
	Rgo711XjJPcWfuHtPamtxf5tLO4O0aD39lP45VwACpBaFh5Z/JShoSB3laLF38pwzfY9nPFWPKy
	cuqwQCIMkHj12XeGXVnU=
X-Received: by 2002:a05:620a:a903:b0:7e9:f81f:ce91 with SMTP id af79cd13be357-7ea110a5fc6mr1545015585a.83.1756209174589;
        Tue, 26 Aug 2025 04:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEES/HvFR76larcT3Nn6nir0QLpsUJq2+C9kWe3HGsFZh8ETnB9k+QXuGo4sEteZ1xDZAs8Sg==
X-Received: by 2002:a05:620a:a903:b0:7e9:f81f:ce91 with SMTP id af79cd13be357-7ea110a5fc6mr1545012785a.83.1756209174056;
        Tue, 26 Aug 2025 04:52:54 -0700 (PDT)
Received: from x1 (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebecb1825bsm661572385a.10.2025.08.26.04.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:52:53 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:52:51 -0400
From: Brian Masney <bmasney@redhat.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, geert+renesas@glider.be,
	linux@armlinux.org.uk, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 0/2] clk: renesas: rzg2l: Disable unused clocks after
 resume
Message-ID: <aK2gE0CysSWisFwB@x1>
References: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
 <aKyX4YJswZLuqA6Y@x1>
 <0d71269f-1c78-4732-8235-5640bf340d00@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d71269f-1c78-4732-8235-5640bf340d00@tuxon.dev>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Claudiu,

On Tue, Aug 26, 2025 at 02:01:56PM +0300, claudiu beznea wrote:
> On 8/25/25 20:05, Brian Masney wrote:
> > On Thu, Aug 21, 2025 at 11:03:30AM +0300, Claudiu wrote:
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > This series disables clocks that remain unused after resume.
> > > This is necessary when the resume process is done with the help of the
> > > bootloader, as the bootloader enables various clocks when returning from
> > > resume.
> > > 
> > > On the RZ/G3S SoC (where this series was tested), the bootloader enables
> > > the SDHI clocks (for all SDHI modules, of which 2 are used by Linux and
> > > 1 is unused) and the clocks for a serial IP (unused by Linux).
> > > 
> > > Testing was done on the RZ/G3S SMARC Carrier II board.
> > 
> > Do you think that other boards would also benefit from this change? If
> > so, what do you think about putting the call to register_pm_notifier()
> > inside an __init block in clk.c so that this same change doesn't have to
> > be implemented across various clk drivers?
> 
> Yes, that was my other approach I was thinking about. I wanted to see how
> other people consider this version.
> 
> > 
> > Alternatively, if this is board specific, could this be fixed in the
> > boot loader so that the clock that's not used by Linus is properly shut
> > down on resume?
> 
> As a result of your request I did some more investigations on my side, I can
> say that, yes, in theory that could be also handled by bootloader.
> 
> I can drop this and try to do it in bootloader, if any. Please let me know
> if you still consider this (or the variant that implements it in a generic
> way) necessary.

Personally I would go the route of fixing this in the bootloader for
this particular platform.

If this issue affects other platforms, particularly across multiple
SoC vendors, then I think it would be worthwhile to have a discussion
about adding this functionality to the clk core.

Brian


