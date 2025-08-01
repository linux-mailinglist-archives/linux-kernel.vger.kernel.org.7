Return-Path: <linux-kernel+bounces-752949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0788CB17CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5EE1C258B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7B1F4C8C;
	Fri,  1 Aug 2025 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR25YRrs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BAF1F03F3;
	Fri,  1 Aug 2025 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754029436; cv=none; b=RKgnkQw9MH69gVNU+ghl6CMWapO302LudnRQs8PYXi1n+g7gpBMgV2OT92/J1Z28vM+xZQB0SKTwZ0uKLkzugionDR7bRCNjAAIXTT7sNDmIw6o505d4S6n5E0DmVfMU2jGbjZMAEYes47Zg3qtpINllb5AVp0VtgfaHieACGIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754029436; c=relaxed/simple;
	bh=3wxPWqrrqcVDibSqQSNPtF2uJL4oSonN9fZvqC9K1WU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LG+yQQU1XWzvdbT2Y3j0DdvsUtngL0p/zIrn97volwJk9ktMptPLG3nXKXeTkOcs0mLOWQUjIiWQVmYSJKeNSnXuebXAWBqsFi0lzQWVGSPTPfZD7avygXCBoLoalA7QaeYyZf8Idu0jVeZ2ScKsXrMO/cpY0G2qpTtfkS6Ls+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR25YRrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38434C4CEEB;
	Fri,  1 Aug 2025 06:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754029436;
	bh=3wxPWqrrqcVDibSqQSNPtF2uJL4oSonN9fZvqC9K1WU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tR25YRrsPiWQy39F9FL8x09pwT1K40Wd6d6SUNk+hfTGHDhglNs6MfgTemJAmdGtr
	 xKWJW8DZ94gMBI0ex5w3h1v3UTg8qD6v6HcQh7gvxALUT0zFKM5+oRUKIr6fV5Mc0r
	 lZ0rcjVvZ+2HSZruhTuFgHlVKqas7gFYss+6qf/pZGOZpCKxFfxUDFgB5Gxe9fFcxO
	 CmOGY+K3fTXL7sVewtSIo3FAUCkpRfkkQ/vM6EVMUV8slYGLSLO5CPdY/WF6GFHddm
	 rqrRXlJsK37Rt3P2UaHMUmd2NDRScNi+7OJQd+BewjFC4YM8pyfNzM9c26s1xzmREn
	 9ElUTtoKUNYGw==
Date: Fri, 1 Aug 2025 08:23:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 00/12] docs: kdoc: thrash up dump_struct()
Message-ID: <20250801082352.4ef1fb12@foz.lan>
In-Reply-To: <20250801001326.924276-1-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:14 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> In my ongoing effort to truly understand our new kernel-doc, I continue to
> make changes to improve the code, and to try to make the understanding task
> easier for the next person.  These patches focus on dump_struct() in
> particular, which starts out at nearly 300 lines long - to much to fit into
> my little brain anyway.  Hopefully the result is easier to manage.
> 
> There are no changes in the rendered docs.
> 
> (At some point I think this code could benefit from a deeper rework.  We
> are essentially making three parsing passes over these declarations -
> dump_struct(), create_parameter_list(), and push_parameter() for structs -
> and it seems like we ought to be able to do better.  But that's for another
> day.)

True. I tried not to do too much optimizations during conversion, as it
would make harder to compare with kernel_doc.pl, but yeah, the entire
logic around parsing structs and functions has always been a nightmare.

My understanding is that the original Perl code was written this way to
make easier to handle typedefs and structs the same way. So, common
code was placed at create_parameter_list(). The push_parameter() is
there to have some common code used on several parts of
create_parameter_list() on a single place.

If I were designing it from scratch with no strings attached to Perl, 
I would probably create a separate class just to manage struct
parameters - or alternatively, to deal with structs as a hole.

Thanks,
Mauro

