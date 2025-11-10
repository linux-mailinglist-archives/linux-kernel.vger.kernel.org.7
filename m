Return-Path: <linux-kernel+bounces-893342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93ADC471E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE203BAFD0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4393128BA;
	Mon, 10 Nov 2025 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QshNdn8y"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72103126C7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784042; cv=none; b=Ol+E45a24fjn6dls7Mnmyj1uWlHWzGtSXNxBcQlgV5hHx3PzISfDVWKm0puc84f8ytW5UvHc2pSLpIU/uQi2CRswc3Y1KzX53VbUmVL4v36PIkzNatS7HR0uD4PXPbMjN81RiQUNJZS/cSZmzlyNVhAt1sa+eSh/HtFTmfJ9bh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784042; c=relaxed/simple;
	bh=nhj3Igbx12WySTAs3L6CZE8fbVP3gkRxrlKpU0V1S2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVSQK9owGhDX42PpMr9b54qFYH6fUliH/0VQB9LWUpdSGB2togbabMyQvtz9j7/1geqVQpUzzghoxurhO4eui2Qx4dyCQYohejQkjbPBZMz3FK1D2aNiMwDVtwTWL4sCOiilzcJyfrajHUaUKTthRW2LqPMtvfg0/c8x3isbGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QshNdn8y; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324204so530139966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762784039; x=1763388839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYf9FpLZWUf42lAhUlxsk+V48xYQlFSQ2G8JV6jPPvE=;
        b=QshNdn8yQ7FchSFTx7qcHFGVopt7Fd31yJBamIE8scdUsKrK/Dl1wesxzuiw1aqwxw
         fA/KZZckMgyCowdFY8JB/HTMTraHBXYKDxp3G0h4p8MwKLJKR5gD8iuVHN0pF642sdZe
         35kwMDAl2kDoP9y0NDtIAln4A7XoOOIzGpAGgABYPj58EL6qhnVIyeyRjKWvq3jb/i/0
         v1SPcux9ZbAl7ofXlfFewNgib5lDR7/+CHOxRVJMToN5jiokP/6QbncOOyYPgBILY3s7
         8yMZZnIFGt0Fyiz4VYERDzIaYTR6O1a0NTGIn7nus2e95TP3UtcrIGYg0nAjFpqxtAxQ
         eBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784039; x=1763388839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYf9FpLZWUf42lAhUlxsk+V48xYQlFSQ2G8JV6jPPvE=;
        b=ngLAsGvNPMVQ1lkKkVDfu1rblDT3Qa8yCe8sGgP3DPUVDDhQOTlIS6tUm35ZVrcW11
         7zfO2O1qCjLJuL3RkxZVkPr0SdeB3eTOepHhc2wXRGhJaj+4S1U+Z1Pv/GCOYdsJFhr1
         AEnCJIsPmUbPOszHp8cYqmim0LXaQVi6g7jZv03w+dWd57CZ2hD0mGXSMDBok/Vx0Vw/
         UsYrm1AWFM6XyM95fOp8SzVzVa/2rwWr6Y//nLx9EvoEX5QwIWDLa65tCdaWwUSGiI5n
         zmrObmoCprXplUArbN6EkYDZ82WB70OmfcPq6nfwEb4CsNH7P4jUfEKbdDDErpHQaL/o
         OmdA==
X-Forwarded-Encrypted: i=1; AJvYcCVIxYXoZtwsjTUIZxel354T7Fx68yVyRJtcxdwyQBigBecGVk3ZTqncwAftkxsMzqb2BB1nmKaZUiv6xnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Ui4Fn3LkW6K5nfHXIclwKkePH0h8mLOT+1amzkLsbAmSRsVC
	ob8rLTqhBOdlNr31wlTbFidSPTSjgztzvjbUnCcWuzxQku7k01gE+PdCFi45ZKxaqeKI6rRXxQo
	GCKfH
X-Gm-Gg: ASbGncsD3ZIpdidnZlAenZya7oh525rxkq/rdE9uECov89tlGoiTvAHlDELX62kEYIB
	EllIejMRPqzNCyZX2UA2paP6llg1NwoC9xGo2O3Ni2SABbJSAhSzAej2pewcvOp82ctxA+GmXgt
	NVGpomW+gRmDF7p2Wl++5WSBImGmKQmhYtiJVeE8garvdrU3Lg0ksDCucpbxIvRfpNfUFsR/Qyr
	zqPjQRHb/LemnrY570YirQVVU7pdVJ7uhi5ybUijiD0TcMfkZJ6n8KZStZaHjuoTP/EOKoEY+kf
	9aeddzBYW9yxe2o8E+EKdYXZ7YDUm6E0uDwL4UwryA9zgEwtEWD/cIdPEV17NNs+tpu35I0c8Kt
	xC8i2/5x3oUo/VA2Tc6M4fiSL7HDTby+joTDikuuXMXkZqu6AZzFkkQ8t0JGVmL9Wdga4sxEUAc
	vxsLs=
X-Google-Smtp-Source: AGHT+IFWGbbWVSdwsSwRLLUACXXxYZpMnpmrI0HtAU0yQT12wD1kfbTgpMWg/xPH1FaG58xVuN8lew==
X-Received: by 2002:a17:907:a0c8:b0:b3f:9b9c:d49e with SMTP id a640c23a62f3a-b72e053f2b5mr824285466b.57.1762784039128;
        Mon, 10 Nov 2025 06:13:59 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm1105466366b.22.2025.11.10.06.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:13:58 -0800 (PST)
Date: Mon, 10 Nov 2025 15:13:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Junrui Luo <moonafterrain@outlook.com>,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, tiwai@suse.com,
	perex@perex.cz, linux-sound@vger.kernel.org, mchehab@kernel.org,
	awalls@md.metrocast.net, linux-media@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <aRHzJIFkgfHIilTl@pathway.suse.cz>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
 <20251107091246.4e5900f4@pumpkin>
 <aQ29Zzajef81E2DZ@smile.fi.intel.com>
 <aQ3riwUO_3v3UOvj@pathway.suse.cz>
 <20251107175123.70ded89e@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107175123.70ded89e@pumpkin>

On Fri 2025-11-07 17:51:23, David Laight wrote:
> On Fri, 7 Nov 2025 13:52:27 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Fri 2025-11-07 11:35:35, Andy Shevchenko wrote:
> > > On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:  
> > > > On Thu, 6 Nov 2025 21:38:33 -0800
> > > > Andrew Morton <akpm@linux-foundation.org> wrote:  
> > > > > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:  
> > > 
> > > ...
> > >   
> > > > That is true for all the snprintf() functions.
> > > >   
> > > > > I wonder if we should instead implement a kasprintf() version of this
> > > > > which reallocs each time and then switch all the callers over to that.  
> > > > 
> > > > That adds the cost of a malloc, and I, like kasprintf() probably ends up
> > > > doing all the work of snprintf twice.
> > > > 
> > > > I'd be tempted to avoid the strlen() by passing in the offset.
> > > > So (say):
> > > > #define scnprintf_at(buf, len, off, ...) \
> > > > 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)  
> > 
> > It does not handle correctly the situation when len < off.
> > Othersise, it looks good.
> 
> That shouldn't happen unless the calling code is really buggy.
> There is also a WARN_ON_ONCE() at the top of snprintf().

Fair enough.

BTW: I have found there exists a userspace library which implements
this idea, the funtion is called vsnoprintf(), see
https://arpa2.gitlab.io/arpa2common/group__snoprintf.html

I know that it is cryptic. But I like the name. The letters "no"
match the ordering of the parameters "size, offset".

In our case, it would be scnoprintf() ...

Best Regards,
Petr

