Return-Path: <linux-kernel+bounces-848609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 855B5BCE2A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 758934F4924
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC5223702;
	Fri, 10 Oct 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSfuofaR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BCA222580
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118748; cv=none; b=Ob0evdCqt7BYeA4x42JvfS0UuhDB+RXDAWIlqUJyAJqEDHrRExj95BVzNfNf7KI4RI71Z4JkbGOmegOR4/+y6BAsagICUpyJlerPY/AEdVpGq+aQLC/NcqYIALuiH6gc7zQyiMiveNFcNjXvTL0HTzoLSsbltjGniDy3hEJIr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118748; c=relaxed/simple;
	bh=26wS2UwwrJX369/cOLS63wjrCQ8Ov4xWQodKO7NyVSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSi0tdrokR5RtSIUTpO3aBCsU3MJyX+RGMRB1/yjFyy/l5oA0xGPw2oPYJdK+5IR6gInKup+yxdg+j/A/3ZmjSn2o3Altvq/grm74w4JbwFvk9P79xDQxkGqjzikliQ5xeKnXrB6zibPTI2ymsyN8bFyemIGF9fjVSYH3O5l+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSfuofaR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760118747; x=1791654747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=26wS2UwwrJX369/cOLS63wjrCQ8Ov4xWQodKO7NyVSs=;
  b=PSfuofaRyx8SRx7XkGvKpfSvZWloT8ARPYBS9GZm5JwVB0R5hFiW0acu
   wYVFCF/pLwB4My6M7S+03zr27FNryvg3rXESOrZjt4lrbfwLsJUWuLDHD
   S6onO9GoX9cGHKv2W1tMJZsXpo9EdtDmoT+ic1CBeUFXLew+CrX5ZfrGR
   YWY6782FxbC4OkewS9UdgNQ5rVEiP1kYNrHa7qALJRj01CIET0eROxm9e
   6m4DAe++ai1b5WKWuQs4kBdDpW14yNTr2z7lsc4706hKMsfD+1LoDvdUW
   L9JmgPxyP1i9a30D8oXbMI7vYVypSv+XSk3CbI0korMKGZ31BAHNYMtU3
   g==;
X-CSE-ConnectionGUID: 5a9LmbsyRNCtfAXVNxhfxw==
X-CSE-MsgGUID: CzX6XPt8Rfa4xVU2Jtdvfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62261798"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62261798"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 10:52:26 -0700
X-CSE-ConnectionGUID: 8ow4oYWAQ2i26YbBisFeXg==
X-CSE-MsgGUID: PNtez41uQyWskJw4E4xRmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="181453935"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 10:52:25 -0700
Date: Fri, 10 Oct 2025 10:52:19 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/tsx: Get the tsx= command line parameter with
 early_param()
Message-ID: <ghbb5hxgodvkuupqcdqlt5t2cum5tidoqgimtkixfqg7ymsxxy@gubq5y6eflqd>
References: <cover.1758906115.git.ptesarik@suse.com>
 <63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
 <20251009185134.fb4evjrk76rwxv37@desk>
 <20251010003345.dc6ybdhwoslyse5m@desk>
 <20251010094519.3d845993@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010094519.3d845993@mordecai.tesarici.cz>

On Fri, Oct 10, 2025 at 09:45:19AM +0200, Petr Tesarik wrote:
> On Thu, 9 Oct 2025 17:33:45 -0700
> Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> 
> > On Thu, Oct 09, 2025 at 11:51:40AM -0700, Pawan Gupta wrote:
> > > On Fri, Sep 26, 2025 at 08:01:02PM +0200, Petr Tesarik wrote:  
> > > > Use early_param() to get the value of the tsx= command line parameter.
> > > > Although cmdline_find_option() works fine, the option is later reported
> > > > as unknown and passed to user space. The latter is not a real issue, but
> > > > the former is confusing and makes people wonder if the tsx= parameter had
> > > > any effect and double-check for typos unnecessarily.  
> > 
> > If this is too much of an annoyance, I would suggest to move
> > x86_get_tsx_auto_mode() from tsx_parse_cmdline() to tsx_init().
> > 
> > ---
> > diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> > index 167dfd38b87a..805be8beb37a 100644
> > --- a/arch/x86/kernel/cpu/tsx.c
> > +++ b/arch/x86/kernel/cpu/tsx.c
> > @@ -20,6 +20,7 @@
> >  #define pr_fmt(fmt) "tsx: " fmt
> >  
> >  enum tsx_ctrl_states {
> > +	TSX_CTRL_AUTO,
> >  	TSX_CTRL_ENABLE,
> >  	TSX_CTRL_DISABLE,
> >  	TSX_CTRL_RTM_ALWAYS_ABORT,
> > @@ -27,7 +28,8 @@ enum tsx_ctrl_states {
> >  };
> >  
> >  static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
> > -	TSX_CTRL_NOT_SUPPORTED;
> > +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO :
> > +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF)  ? TSX_CTRL_DISABLE : TSX_CTRL_ENABLE;
> 
> I like this approach, because it converts runtime initialization code
> to a build-time initializer, based on build-time config options.
> 
> Can I add your Signed-off-by: for a v3?

You may keep the authorship and add my Suggested-by:

