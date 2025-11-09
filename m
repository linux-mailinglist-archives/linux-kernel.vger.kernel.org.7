Return-Path: <linux-kernel+bounces-892019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1533C441A1
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 16:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6043D3B1E55
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58832FF672;
	Sun,  9 Nov 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEkRfktT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DBA20013A;
	Sun,  9 Nov 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762703677; cv=none; b=bNHkMhH/6XiMe6Vh6PaB/s/T+njZQ2HKP9C7Y61dBFfaZjofCC8H6eeltyyo378/77z2XC+ug7YMzDj6OcJuFRsuB9F0484ZGqXraUTeiUMhnpXNxhxXAHk2yCjB0MmvEqIUvMuPPh8j63yQ4Ek/8J/yXpf6YtD4wnvNExaS8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762703677; c=relaxed/simple;
	bh=0kQKKadoXIQakRrU82+4pVBIswZA9kLK7Pa9hlHe0B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sanoPXHDNkDn7L8Q2iKH28hbElSnHoJ7Su2Hv/QiXcPWgsd63DgFCe1NKE0cVttj2dsVR9W7ectFIcLvVCh3CKh8te0hIg0Zg/XHagYNpmTW4pvh+2WA/CCVRDZ0TCZExtrzbsclACXNPu4kHoa+bUcc4O5BWUOdNuXr0PtsFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEkRfktT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762703675; x=1794239675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0kQKKadoXIQakRrU82+4pVBIswZA9kLK7Pa9hlHe0B4=;
  b=GEkRfktTqVy7Rg+kLM20gxXqlGrYlWFJu6eqPseowsRGpDuPxPhEAwVh
   EKDnCSFI4LX8YGnyDLxN5JP0QPOqM9tC8cBhhPKbTj3uOgdWsokIeVyFy
   8W+DA+qQyRC4pKfveJttR09+QrmyDs1tO1soKFuqWni1OA5y7uG7ZaQfB
   i4WM6Cu7bBoRYzl+IWylT/go8x0ofI1e+2PQrHWs7Nb5fIINQhARKxdLu
   2BEdB1NJMrRs/SbkN3oUl6DRfL2fgu3m+V7PsigSQF+bU8ABx7ivwXB8h
   oDnNot+xsuQJPGxt8XREmVq8ClqE4NaE8DHRuaJqa3Q+AL8v52j1/piU1
   A==;
X-CSE-ConnectionGUID: 1iPVTC7EQFy6n705VhDtyw==
X-CSE-MsgGUID: XYuQoc+8QwOx0YeW+1XfFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="82399461"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="82399461"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 07:54:34 -0800
X-CSE-ConnectionGUID: Thd2zKyxQRSgSE6N5LgMbw==
X-CSE-MsgGUID: fDahApYoQLC9vIPs5oZ9zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="219209198"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 07:54:33 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vI7kM-000000073eg-1BEZ;
	Sun, 09 Nov 2025 17:54:30 +0200
Date: Sun, 9 Nov 2025 17:54:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aRC5NjhOmuGIpdPA@smile.fi.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <87sees73i5.fsf@trenco.lwn.net>
 <90db7fc0-5ce5-4ed4-ac33-18910c37d3d7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90db7fc0-5ce5-4ed4-ac33-18910c37d3d7@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 08, 2025 at 04:03:15PM -0800, Randy Dunlap wrote:
> On 11/5/25 10:12 AM, Jonathan Corbet wrote:
> > [Heads up to Stephen: this change will add a bunch of warnings that had
> > been dropped before.]
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > 
> >> When kernel-doc parses the sections for the documentation some errors
> >> may occur. In many cases the warning is simply stored to the current
> >> "entry" object. However, in the most of such cases this object gets
> >> discarded and there is no way for the output engine to even know about
> >> that. To avoid that, check if the "entry" is going to be discarded and
> >> if there warnings have been collected, issue them to the current logger
> >> as is and then flush the "entry". This fixes the problem that original
> >> Perl implementation doesn't have.
> > 
> > I would really like to redo how some of that logging is done, but that
> > is an exercise for another day.  For now, I have applied this one,
> > thanks.
> 
> I think that this patch is causing a (large) problem.
> 
> With this patch:
> $ make mandocs &>mandocs.out
> 
> Without this patch:
> $ make mandocs &>mandocsnoas.out
> 
> $ wc mandocs.out mandocsnoas.out
>   29544  267393 3229456 mandocs.out
>   10052   95948 1208101 mandocsnoas.out
> 
> so it appears that this patch causes lots of extra output.
> Some of that may be what the patch was trying to do, but
> with this patch, "mandocs.out" above has lots of duplicated
> Warning: lines.
> 
> $ sort mandocs.out | uniq > mandocsuq.out
> $ wc mandocsuq.out
>   18012  167689 1994145 mandocsuq.out
> 
> $ grep -c "^Warning:"  mandocs.out mandocsnoas.out  mandocsuq.out 
> mandocs.out:25273
> mandocsnoas.out:10022
> mandocsuq.out:15252

Yes, that's what Mauro explained, that we may have the dups.

> In mandocs.out above (29544 lines), this line:
> Warning: ../sound/soc/sprd/sprd-mcdt.h:48 struct member 'dma_chan' not described in 'sprd_mcdt_chan'
> 
> is found at lines 7 and 29122.
> 
> So maybe the logging output needs to be repaired sooner
> than later.

Right! But I'm not familiar with this, so I can help only with testing,
and not with real fix development.

-- 
With Best Regards,
Andy Shevchenko



