Return-Path: <linux-kernel+bounces-783845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231DBB3336F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF21D7A7710
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272851E9B12;
	Mon, 25 Aug 2025 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OBXle2YV"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2A8393DD1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756083959; cv=none; b=Q2xKtr72PyWUf57P21DNvNNZ13Dx2srlxH1gXfOFxEN7OoKc+CgviZD6MZN9+5kJst0dOEC4vgWw2lewV17d8v/Z4pVW+FlK6vwqPqiXxkJmDzipOa2vWx15uUvKDxKd6rJIRdgdNwExemcne+xshhS8wjaQNo5q4YbOGlSmllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756083959; c=relaxed/simple;
	bh=6KfKqjUxTG5oWU+gUg21b0Q4lE4lYdO3w8ypQkCvifA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/FvdeNeM7g+HGPB9TpZwz1A/BWfUS7ACmE4fttPZlhoHtTNbPvSIrOj0dH+N9NCGCa92YUfWWqFUZdN5+JXUGC5aaMyTX6MADBq6eVb1zZPB6rxySUmnKpdMaJ8SELlQyt8IhcAPy6bUybQ8qcTNdqgRM9NOOngWn5kQpTtZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OBXle2YV; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756083947; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=0/N19tc0HjmCStaiIEgtkwvVpFTgO94a0ndEh8/RBIU=;
	b=OBXle2YV1T6KSpIukL4hn9qCmiMP8pkZlOlIGNGFMvjzALk504HodJJ3JypuSEGamVzseFWLH8Ge0qWaZUtf1Pn6+xwwcxXNbpgY3nqgVQH1tbLQjQcGqzN0rKNOk3ew1TiIKhmOHt+1CV3Ev0E9sl4yjObzTz8zfwv18A/OdY4=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WmPhh-o_1756083946 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 09:05:47 +0800
Date: Mon, 25 Aug 2025 09:05:46 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH 1/3] lib/sys_info: handle sys_info_mask==0 case
Message-ID: <aKu26tqEeirFRDa9@U-2FWC9VHC-2323.local>
References: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
 <20250815071428.98041-2-feng.tang@linux.alibaba.com>
 <aKQ3Bi5q7-in9MgC@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKQ3Bi5q7-in9MgC@pathway.suse.cz>

On Tue, Aug 19, 2025 at 10:34:14AM +0200, Petr Mladek wrote:
> On Fri 2025-08-15 15:14:26, Feng Tang wrote:
> > It is a normal case that bitmask parameter is 0, so pre-initialize the
> > names[] to null string to cover this case.
> > 
> > Also remove the superfluous "+1" in names[sizeof(sys_info_avail) + 1],
> > which is needed for 'strlen()', but not for 'sizeof()'.
> > 
> > --- a/lib/sys_info.c
> > +++ b/lib/sys_info.c
> > @@ -55,7 +55,7 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> >  					  void *buffer, size_t *lenp,
> >  					  loff_t *ppos)
> >  {
> > -	char names[sizeof(sys_info_avail) + 1];
> > +	char names[sizeof(sys_info_avail)];
> >  	struct ctl_table table;
> >  	unsigned long *si_bits_global;
> >  
> > @@ -81,6 +81,9 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> >  		char *delim = "";
> >  		int i, len = 0;
> >  
> > +		/* *si_bits_glabl could be 0 */
> 
> s/si_bits_glabl/si_bits_global/
> 
> But I would personally remove the comment completely. IMHO, the
> purpose is quite obvious. But I do not resist on it.

Will remove.

> 
> > +		names[0] = '\0';
> > +
> >  		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> >  			if (*si_bits_global & si_names[i].bit) {
> >  				len += scnprintf(names + len, sizeof(names) - len,
> 
> Otherwise, it looks good to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thank you! will resend a v2 patchset. 

- Feng

> 
> Best Regards,
> Petr

