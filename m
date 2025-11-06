Return-Path: <linux-kernel+bounces-888426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F0C3AC8B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4BF434E55D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673693195FC;
	Thu,  6 Nov 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Ocd0jOJ4"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE220320CB3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430864; cv=none; b=ikyPX9uUIPSuIVBaj/HvPM5N4F5KB5GkiqI1Ym392rOuGP/NtRQPOAzIRZKZ/sINqcimK5TEskyopXGDrPvZwbWcVX6cNVTKwuNfMKEZX+4gG1VFX9G9/7Vwo2qEEYeqq9bXb6oNoE1R9zGF4kLu+Qp2MHcFnuMZl61kM4klFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430864; c=relaxed/simple;
	bh=bPZRPN5c/Uj/fmMcOQTTcE8ByXgTM9LYDI1n2OmE/2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpAX6ElJFQer1bz9v7yhM2SQRSaKqhtfMVG1nuoaBJs6J6QFckJo7JZBUJzZeReHTDYY8NX38X+v8FGtVop9e5QPE4Rxx2iTv5ICEKyphBtlnP9NVPwHzy8v45gpM9CZHsk7+44PeTy9VQDGSZRSWQAuw6MfrujPYuWjrAiyzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Ocd0jOJ4; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=UetBbdwHupT5BrAMXNrAwwA6NJt7jvzEKFrFEbUdlxw=; b=Ocd0jOJ4vO+WwI61
	UJ+PA4vA3na5VIBiIckbXEu5p54VWe1UdcvLk1uQbTYWPwL0NmoauEH6xb2R7uxqRSjbsIBlCjwJI
	GlH9N1SkMK/kQPKRvPssAIWi4lTQioRDoY3lPjgljPwjW6e4BUGHJODdZwQzhsjHFvwXiRQHw43np
	hplWbqKIMkYrO0DVIMpNyrgmxc5KcxePUOJeWOZ2gcZbB/7Rkf90s6DXO7ZURdUFlY93Lf30YV56N
	f0QN7+3d7lk2w+acWVphHF7KixqdyQA9e72BwyiY3IHj8VCEICrBSd9aZCYd94ilRm4e2bqyLW65I
	09byKjtuAkOqeBkORQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1vGym3-00000002QZV-0uDZ;
	Thu, 06 Nov 2025 12:07:31 +0000
Date: Thu, 6 Nov 2025 12:07:31 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Stan Johnson <userm57@yahoo.com>, mpe@ellerman.id.au,
	npiggin@gmail.com, sam@ravnborg.org, benh@kernel.crashing.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rdunlap@infradead.org, Cedar Maxwell <cedarmaxwell@mac.com>,
	"maddy@linux.ibm.com" <maddy@linux.ibm.com>
Subject: Re: [PATCH v4] powerpc: Use shared font data
Message-ID: <aQyPg1EfDEYF4wB1@gallifrey>
References: <20230825142754.1487900-1-linux@treblig.org>
 <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com>
 <aQeQYNANzlTqJZdR@gallifrey>
 <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
 <aQgJ95Y3pA-8GdbP@gallifrey>
 <3cc3d311-35b0-42f1-b20f-ed59391bb8e0@csgroup.eu>
 <ead4ef3f-9f8c-a98e-b48d-f052bc9492d0@linux-m68k.org>
 <994bea8c-7b28-4aae-a6b3-e4f33731cb29@csgroup.eu>
 <b4737133-a33c-f4d1-cc4b-0c0b70c45635@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4737133-a33c-f4d1-cc4b-0c0b70c45635@linux-m68k.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 12:07:13 up 10 days, 11:43,  2 users,  load average: 0.09, 0.06,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Finn Thain (fthain@linux-m68k.org) wrote:
> 
> On Thu, 6 Nov 2025, Christophe Leroy wrote:
> 
> > Le 06/11/2025 à 05:11, Finn Thain a écrit :
> > > 
> > > On Wed, 5 Nov 2025, Christophe Leroy wrote:
> > > 
> > >> 1/ Either build font_sun8x16.o with -fPIC
> > >> ...
> > >>
> > >> 2/ Or add a PTRRELOC:
> > >> ...
> > > 
> > > Thanks for your help with this, Christophe.
> > > 
> > > I fixed up the whitespace problems and forwarded those patches to Stan,
> > > along with instructions for applying them. He tells me that patch 2 fixed
> > > the hang. Patch 1 did not.
> > 
> > Fine. Then let's use PTRRELOC.
> > 
> > Will you or David submit the patch ?
> > 
> 
> OK, I'll submit the patch.

Thanks!

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

