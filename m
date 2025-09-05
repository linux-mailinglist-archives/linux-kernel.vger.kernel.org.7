Return-Path: <linux-kernel+bounces-802550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DABB453A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06263BD3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7C2820CB;
	Fri,  5 Sep 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fE3LFOOF"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92D43147;
	Fri,  5 Sep 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065408; cv=none; b=rZOlJkZku9wdLWwBs2ksTFcijV+zdZ+ocCLa+FT/Xka7jAT8HSHlQ4ShYFu22W0nz1qFECUDYjTxtF7JXiKpRwHRKCZ23jZ610ymvZEefCvBnBixKUXF0ERtAa09hwNQvuH8ycly4gal9qOGlpUYtu9T4BPcpYo4mR+ebNHikEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065408; c=relaxed/simple;
	bh=EgNRae1Oxp08ek00sKNY6V7atdD+jKhycTMmppxqU0M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SKAMMF9RucrGQ+rkVmh/HLMNG0U4pWJ3X1Tct3sx+XP95ZAzCMgnK7mWQeiPwuZT3QpcQnPnwTEa2GEbZBtLiHdJSU/Zh00G6EXj3zWC2ngmwPTRocFQf2Tu9s/DG9JEfVmDeBexL427BLFqT1Fhkj9E0WTFRXcSTpoWhZUkzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fE3LFOOF; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qjDMlR820tFBEhIlW52LN6YMtOAXMSSbrvE9DaKH11M=;
  b=fE3LFOOFjvW8jmXGhS6mOvTib2UKaUl7Xyj09cauR0IuiRoa8xHgcFUX
   ZhsIRQSj/n/QGtFK83NTa5UvCMvuBlZPD4QRegTaoN2+FcBOFGKYsgkNE
   EOPAmxaQ7+UtYpTnpmrN9RjuA0nG8dhTlPHOo4zUK/ycTOssRB9Rkn5PU
   A=;
X-CSE-ConnectionGUID: /WQY4bALRvepvsRnZZROKQ==
X-CSE-MsgGUID: hkoij3PeRQGduZquHfoiIw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,240,1751234400"; 
   d="scan'208";a="237673286"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 11:42:15 +0200
Date: Fri, 5 Sep 2025 11:42:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [cocci] [RFC] Sharing data processing resources for selected
 SmPL scripts?
In-Reply-To: <ba6b7f45-6c59-4ad1-9b4b-a02f34036d7e@web.de>
Message-ID: <a00a59b-3079-d55c-eaf6-2db4c14f92a3@inria.fr>
References: <ba6b7f45-6c59-4ad1-9b4b-a02f34036d7e@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 5 Sep 2025, Markus Elfring wrote:

> Hello,
>
> I became curious if further developers would like to try the following script out
> for the semantic patch language.
>
>
> @display@
> identifier action;
> type t;
> @@
> *t * action(...)
>  {
>  ... when any

when any is not useful here.

>  }
>
>
> I interpret such a search approach in the way that it should extract some data
> from a lot of source code places.
> Thus I imagine that it results also in special software run time characteristics
> which matter especially for big codebases like Linux.

I guess it would be quite fast, because it will just find the deader of
each function.

julia

> How do you think about to clarify corresponding data collections
> and computation resources?
>
> Related source code analysis concerns can eventually be also clarified.
>
> * Handling of function declarations in header files
>
> * Relevance of some preprocessor directives
>
>
> Regards,
> Markus
>

