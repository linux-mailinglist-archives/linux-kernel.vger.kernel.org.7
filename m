Return-Path: <linux-kernel+bounces-646740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981E8AB5FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 01:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2020D4A409B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80B01FF1D5;
	Tue, 13 May 2025 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZKrNvc82"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298073FBA7
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747179320; cv=none; b=bkS6rQzyFruGXYDYo1n2f6NHDFoMBR81ePhREgSRwVUmaHpQeIBloI5ZUZJbn+yIt2qUscepur2Bseof8q+NhM5nDMvXtkxbg4HEkpmAuEpjZt01lQ5FV/NeTIi8lLIez5kRli/k+VWqdQx1EpSo18Y+b0ZQAWS03Ieub2u5658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747179320; c=relaxed/simple;
	bh=+4vW6CNsHxe61iwdan0mTr6dPCihj4VpRe5EH1LXf1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HanxmWNClMGEfGWSsDmlePU4Ps+wTyXCFZByN0FqKeXM29Z/Fd8Hm6kWbW2O7DgAPN1490ZBIQf46qSHKeB2Jk0msmFqo2yAE4ALT/4kLmofMgF80995WINifHZhMfZ5J/3YEdkIcaQhgX3Jbkv7lM9VD7BpokRYB45rff9WSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZKrNvc82; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 May 2025 19:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747179303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BP5364cOafYuTahp1Ohm9NsSXHYREJKJOMbyAPXgGBs=;
	b=ZKrNvc82pIE6EsJUoM2rpmUVMOmrWGEfrw+CjXcnlTGWoeTBi5Rv5TTN3jrqSyGvZLg2tT
	GuLjRCMhyngW2hYKGO4K6Dl6VQC3xCsnqI9ZyJPHt9UWiHG+hPZ82qn5R9Jcf22lBVBY6Q
	6AxGMaVMk/q5bqcKoVfnh3ZXB/XjcO8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] params: Add support for static keys
Message-ID: <tjqz5spozvd35egxtfn2n3csvqu2qsaobbkfzf52ovhsokq47y@eq5xl2ugyydq>
References: <20250513130734.370280-1-kent.overstreet@linux.dev>
 <zgifi763q2zdj2xn2535daboorumz4g64ospsukp4e6btmosir@xrbhtw777ytw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zgifi763q2zdj2xn2535daboorumz4g64ospsukp4e6btmosir@xrbhtw777ytw>
X-Migadu-Flow: FLOW_OUT

On Tue, May 13, 2025 at 02:24:46PM -0700, Josh Poimboeuf wrote:
> On Tue, May 13, 2025 at 09:07:32AM -0400, Kent Overstreet wrote:
> > Static keys can now be a module parameter, e.g.
> > 
> > module_param_named(foo, foo.key, static_key_t, 0644)
> > 
> > bcachefs is now using this.
> > 
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Petr Pavlu <petr.pavlu@suse.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Daniel Gomez <da.gomez@samsung.com>
> > Cc: linux-modules@vger.kernel.org
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > Cc: Jason Baron <jbaron@akamai.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > ---
> >  include/linux/jump_label.h  |  2 ++
> >  include/linux/moduleparam.h |  7 +++++++
> >  kernel/params.c             | 35 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 44 insertions(+)
> > 
> > diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> > index fdb79dd1ebd8..0fc9b71db56f 100644
> > --- a/include/linux/jump_label.h
> > +++ b/include/linux/jump_label.h
> > @@ -107,6 +107,8 @@ struct static_key {
> >  #endif	/* CONFIG_JUMP_LABEL */
> >  };
> >  
> > +typedef struct static_key static_key_t;
> > +
> >  #endif /* __ASSEMBLY__ */
> >  
> >  #ifdef CONFIG_JUMP_LABEL
> > diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> > index bfb85fd13e1f..11e8d5c57435 100644
> > --- a/include/linux/moduleparam.h
> > +++ b/include/linux/moduleparam.h
> > @@ -122,6 +122,7 @@ struct kparam_array
> >   *	charp: a character pointer
> >   *	bool: a bool, values 0/1, y/n, Y/N.
> >   *	invbool: the above, only sense-reversed (N = true).
> > + *	static_key_t: same as bool, but updates a 'struct static_key'
> 
> The static_key_*() interfaces are deprecated because they're really easy
> to use incorrectly.  I don't think we want to propagate that misuse to
> modules.
> 
> It would be better to have type(s) based on static_key_false and/or
> static_key_true, depending on whatever the default is.

Except those are just wrappers around struct static_key, so why does
that matter here?

