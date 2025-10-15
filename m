Return-Path: <linux-kernel+bounces-854239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68FBDDE34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC7319A6417
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5DB31B812;
	Wed, 15 Oct 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DRXnmBu7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA531B809
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522191; cv=none; b=thKRmc16OsPqFMyn2jrNpWXRfvVQL1eDAXez2Jm8RQrYashO3WCtrlmeCJqshE7MfTixQnpnq4r4uXOyFrb1f/YZstQsRhNe4sfBommAWqKYGfjT+ZJ5tQgNpyTVPHzXKQaue6Cj00G9WMuFQSEcNVwv+iVKV1rdjrorAp5BAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522191; c=relaxed/simple;
	bh=aRrdpsObtX1p2rAWgFuGAL9X7vaHFsWvKJIFWRPKpRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmniyuKyhmLuzsBHRI9fQavbI1ymnn02KZ3w6b6NS8m63Aod9DFkjL3NNnFqPxM7XHgWwRZh1tdxdAidpBuoax/6rm9V7L6nYFjmzfnx8oBV9Fp4TPyyRyJ5K+W07ORPPVK53b6s9YsmxUbYXClBqT4BSumQHaqJsZLwPqmebLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DRXnmBu7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ICGb7T24T6wc2bu3o+jjHhuAUA8selaEgQ3iff6bI9I=; b=DRXnmBu7iBcYa5g+IEgpFk+egu
	FCrDrq/C9Cp5XchFYHRrF5tOZjrBGaZdmFYiMGbGAB065kD4/Uc1TDH/GvF1BhnJOuJ/Vy2a91qmt
	BbW3YbUKRX8YU5EHrZCsL5JGyv4Rv8vPyqoa8c+uiRtEUkypFJrRIYAtEizafxTlVFILGOrbAgoX5
	UR5p/9ArKcwowLWk66Bj5jOXM//O/bm4ACX5/KTsSKaSNkm4skqlDAzUWjHy2uZrz8rLEGmn340t1
	xtb0DavSqRuT1Va1aIWztpCseVZiK0KeLK7jMJUt1lIYDQqubaD+PxTou/tRPOvGKlFH/LOqAFz13
	t7uZuwvg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8yF9-00000005qvP-1ZHh;
	Wed, 15 Oct 2025 09:56:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3CC7330023C; Wed, 15 Oct 2025 11:56:26 +0200 (CEST)
Date: Wed, 15 Oct 2025 11:56:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] objtool: Fix typo "teh" to "the"
Message-ID: <20251015095626.GM3289052@noisy.programming.kicks-ass.net>
References: <20251015090106.4037-1-yangtiezhu@loongson.cn>
 <20251015091758.GA3419281@noisy.programming.kicks-ass.net>
 <d489fffe-d201-6213-a59f-2e217c5ab880@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d489fffe-d201-6213-a59f-2e217c5ab880@loongson.cn>

On Wed, Oct 15, 2025 at 05:47:38PM +0800, Tiezhu Yang wrote:
> On 2025/10/15 下午5:17, Peter Zijlstra wrote:
> > On Wed, Oct 15, 2025 at 05:01:06PM +0800, Tiezhu Yang wrote:
> > > Obviously, it should be "the end" rather than "teh end".
> > 
> > Was not in fact type but interweb slang:
> > 
> >    https://www.urbandictionary.com/define.php?term=teh
> 
> I can not open the above link, I read the info from
> https://www.definitions.net/definition/TEH
> 
> What should to do in the next step?
> 
> (1) Do nothing, just keep it as is.

This :-) Consider it your new word of the day.

