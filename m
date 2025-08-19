Return-Path: <linux-kernel+bounces-775361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74045B2BE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697437BC6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ADA321448;
	Tue, 19 Aug 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gDP4IC/0"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8331A060
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597611; cv=none; b=Bpjp5YpL2KP9NVpe8EdkzpFEFxLt8XoucpBrd0Nj5Ajjc8/Y1rmKEbMuBWF6rwVTK1uvs2r5GTu7qAhAnY8SbF79golxDJopRwqHADiIQrbwyDwa5qDGX/MYb+kut9bEP4SrxQHqLin7eQE3/EE3csq8DxRxovxUjXkBXDKdeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597611; c=relaxed/simple;
	bh=v/okojaX1odAcTkpye83LrAb63NZEvMcO+JDGF8HSew=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ah7pqvbNKmQVUAKem5nTdNWpRZshG0ndy3i97ooQFJHLB6voSX+uzMjQUQHtaXocUghr4hpMgtAaYmZ0d/4Jdfe74kmutORtpM6VaIElTFEzi361q3I2Kpe5uxvSJh+DAuSlLXlTIhKWICxdVcLgXzwbdbkaAmf/fv6zY7LqTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gDP4IC/0; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755597608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjgCdFdN/p2XjO4xt3tgWE95EILx00Dh/AKJ/jlTXSQ=;
	b=gDP4IC/0Ko3V3/IF1R8VGT2HoCz6HdkyUbdEPEapgXFqi0NcNmIb1hTH8nQstdbdqFv8ts
	kP8b6/ndatZ9BbA24Vt/ZdThxjrnVqs0QveSS3PjfzlQm+uTye0ZlPcRvJTs59k+pkWWBN
	kT1RsmxEBMXeESZBgNhO500qNpZIqy0=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 5/8] MIPS: arc: Replace deprecated strcpy() with memcpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <yisgcmjp5cj27yozthudyrdpfcovhcrgpqbyip5kcum4aa7qwl@52bccatjuiak>
Date: Tue, 19 Aug 2025 12:00:02 +0200
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-hardening@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <53007EE9-0DF2-4772-8254-0551F4093CE8@linux.dev>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
 <20250817183728.612012-5-thorsten.blum@linux.dev>
 <yisgcmjp5cj27yozthudyrdpfcovhcrgpqbyip5kcum4aa7qwl@52bccatjuiak>
To: Justin Stitt <justinstitt@google.com>
X-Migadu-Flow: FLOW_OUT

Hi Justin,

On 19. Aug 2025, at 01:58, Justin Stitt wrote:
> On Sun, Aug 17, 2025 at 08:37:15PM +0200, Thorsten Blum wrote:
>> strcpy() is deprecated; use memcpy() instead.
>> 
>> Use pr_debug() instead of printk(KERN_DEBUG) to silence a checkpatch
>> warning.
> 
> I'd like to see more reasoning for why you chose memcpy() here. With api
> refactors like this I think most folks want to know if 1) there is any
> functional change and 2) why you chose the api.

1) No functional changes intended.

2) To advance the pointer 'cp', we already determine the string length
'len' using strlen(), which allows us to use memcpy() directly. This is
slightly more efficient than strscpy(), which would recompute the length
before calling memcpy() internally. We could also use strscpy() and its
return value as the length, but that would require checking for string
truncation, which might introduce a functional change.

Thanks,
Thorsten


