Return-Path: <linux-kernel+bounces-893807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3416C48698
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F951890211
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198E2E5407;
	Mon, 10 Nov 2025 17:46:22 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044D2E3AF2;
	Mon, 10 Nov 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796782; cv=none; b=leN4e/PWjVMuSUj0gyaEAdytgk6hhSGjpuKCykiJcH6GZgicn/eZXJLH6e66/Ju8o8PGsgS/sd/UTPBc8S0afD2srzMLHe3Tt+y4xOdKUPF/6meI6lb9UhFpjQgrtHRcRydrTWyojpPRLN5aIIYntHkfore2V2HQ0/GEmbsAd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796782; c=relaxed/simple;
	bh=Jbi5RMwGRs086xz9D5Qz27q/1MNFZKpeCIgXY2/x+/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFN/AvuHht/8hbwebICylgQwhSoSeXR/9Y3My2ar5iau5QrNLLgmGegoIY5c7cj9v/kyh6RBLMBbSqf7nYLVBjzAz6fKqJ6QCiP61gwHTq0esxEAyEkuDncVuHckAd4OnMsaqqxLX//iW3ii+Y385wWvO3rRzqWu+tHY+sk0xJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id BDCE7139D23;
	Mon, 10 Nov 2025 17:46:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 9601C20028;
	Mon, 10 Nov 2025 17:46:08 +0000 (UTC)
Date: Mon, 10 Nov 2025 12:46:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Christian Brauner <brauner@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, "workflows@vger.kernel.org"
 <workflows@vger.kernel.org>, "ksummit@lists.linux.dev"
 <ksummit@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
 Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251110124615.4c8203fd@gandalf.local.home>
In-Reply-To: <20251110172507.GA21641@pendragon.ideasonboard.com>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
	<653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
	<20251110-weiht-etablieren-39e7b63ef76d@brauner>
	<20251110172507.GA21641@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mssetsafi7xn69xkio4ibd1o6p5ofwk4
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 9601C20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/StFnPhWxwXbXgclZLA5CF+NltNO4Sn8A=
X-HE-Tag: 1762796768-843566
X-HE-Meta: U2FsdGVkX19QJcYoOXL0nYw0ecym/L6D6Rlj+IHuCZEqSoWXXa75v7GcVJI5eTBE4nIx0QssuTGx7j5Vn4Tsp6EYT2MP08D4LmUe959fnX93vcoA8EqV9+K7hR4tK1DhRpoDv6TxLqfIfvGiN9K0XwI3VxqtDOkQzT17pXgOtXqOTgxFWzdckGvV2cwtPZ2vqXnBPjkHPVhNmMeRv6z2CYwo2CsnP4eQ9v94mhPxInhUqaB0QZKSsbxov//E5Yfq0w6Uc4B2LkYfW3vAroxMweVTCvBdDAu1WvFAlATPixb7tO0aCfNIxpMLjO05Pjf/SXyefP4rQM9itXDfKI7uo5X4f1sdWEwcfxZc6nVK2LN5BLwXc1lr1i6LUyLqQitD9TIzMNkU5EY5jZyG951ydDZX7uLi1Ote+v6UbERGnvjv4mMOQqEofViCdWWuEO9R

On Mon, 10 Nov 2025 19:25:07 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> > > > + - Purely mechanical transformations like variable renaming  
> 
> Mechanical transformations are often performed with Coccinelle. Given
> how you mention that tool below, I wouldn't frame it as out of scope
> here.

Agreed. Tooling that performs "mechanical transformations like variable
renaming" is definitely in scope of this document. The number of times I've
seen this "simple" activity make mistakes. It most definitely should be
disclosed if a tool helped in this regard.

Anyway,

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

