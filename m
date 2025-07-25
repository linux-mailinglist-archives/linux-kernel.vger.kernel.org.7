Return-Path: <linux-kernel+bounces-746100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD7B12321
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24FA1C831F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615472EFDA0;
	Fri, 25 Jul 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z8Dmf4cu"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89621DE3AC;
	Fri, 25 Jul 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465543; cv=none; b=rBVHLkmomI1upgnyV5rTwFqDb2+GLohYzmMOoyiHy1i8YbQqV0JP6NRwb1W/gxTdXK0W5LMh59lEiBnC13UX2prJw97M06Vz6KuWuRsMFjrKHsMrzCXj8Ck36vTst1Bu+kz2V6EW3CmcYWBBWmo66MP/wkxl0kQGOqhPlDGxp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465543; c=relaxed/simple;
	bh=RsPRgmZCOqun/rYWmkkcvg3T55MIka5uyEZQyaWsRkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJL0yWbraX+wJO96sYDIIzsIipY6xzcILBzrwQ+DFqPKx7F9ZZtyAiSVidm3Z8+XBoTAEzGAPGfBCWWPA/2YPDodVD4QxIjRpJGtlosyEKTt9p5GLKi2RfasncxOhRqZrRDiNSP5Ai3O5Z8i7UnWdk+k6JA/c/Slxc+MlgWkWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z8Dmf4cu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aFcxMrKl/6T2lCcVEBxTm5V2wzGAihXJCOqriV8fm94=; b=Z8Dmf4cumnntEeo5nL2SBVupqO
	uuRfw4qxLnTOyYnHa1kYFr2LA36AL0Fz4+xjJHgISL3o1xGfykd3Thk+bADxSaQ4A0Lm9W16rmzjY
	11klNXhNQAu1s5Ir/3RXTclatNHM2HBO7nSoc09m3AebUtoY3MWIBuuCBgXWyy4xrCoEFV0SIodCi
	lwMghsM9ry8itRwqKg8xQUUGMCbiwr2N+/KBuJBvacGzjNHwLZjlhkDT3pgt8N+sEPwqpKn2+04ke
	+I+ThogCsyXD5jyvX2wnWqc0/JvSr9pAJ8RrI3Orb2KGFqj/lvxcHgxnfRn9V5BkKbmeku0MlqB4S
	xUrLwYJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufMUA-00000000Ebq-0OON;
	Fri, 25 Jul 2025 17:45:34 +0000
Date: Fri, 25 Jul 2025 18:45:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <20250725174534.GY2580412@ZenIV>
References: <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
 <202507241651.5E9C803C70@keescook>
 <aILYj62tF_1mDjDO@lappy>
 <aILb-zDiDr4b9u9S@gallifrey>
 <aILjTKk_v8NPxlVJ@lappy>
 <aINqjTAwbQ_xnAw6@gallifrey>
 <20250725113702.GD11202@pendragon.ideasonboard.com>
 <aINvLgwaKZsKOibE@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aINvLgwaKZsKOibE@gallifrey>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 25, 2025 at 11:49:02AM +0000, Dr. David Alan Gilbert wrote:

> > Except from a copyright point of view. The situation is quite clear for
> > deterministic code generation, it's less so for LLMs.
> 
> As long as you'd acknowledged the use of the LLM in all cases, it seems to
> me right to say to what degree you use it (i.e. the 1..3) above.
> I think even most people worried about copright issues would worry
> less if an LLM had just told you about a problem (1) and you fixed it.
> (Although obviously IANAL)

s/told you about a problem/told you that <location> has triggered some
heuristics and might or might not be worth looking into/, really...

