Return-Path: <linux-kernel+bounces-871078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12D9C0C6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F7A18A31AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342642FABE5;
	Mon, 27 Oct 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jf3C5XbZ"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1172F8BD1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554636; cv=none; b=MhVcGmrPEBtsKwNvcuqMzcNeDV3YcJgvE9Qud5fHKJTobVAAmvj3HJGMpDKePFa4RDdGL5AGD7kkze+dRWP8eH1B+HsAJ0uWNcQvgZ0Z5oA1cuuHUhWT4uXcLnEu3BGzTB9yynO+6PUQd43NenxkPQRJ9EMSpyxTE2xRJG05QeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554636; c=relaxed/simple;
	bh=tqv9oNTMFeWo+CDUalWwdjt7MmuAOQ3CpjGUhS8s1+k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PU5hAJPDmP5g24a0tNcZQs4s911ndxq9BLmkmziQKa5snnH0iVwsCXZfChLEhFYSpxsrE4u8nAtNhomz9poq+e8+tEWJTOGx/UxuF2O69XPI3TATaUlN+bb/Tx3h7CFfFyKaMOJC/aBQ35BwWNEjciWxZgtZmID0Mhx0vYoHX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jf3C5XbZ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761554622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqv9oNTMFeWo+CDUalWwdjt7MmuAOQ3CpjGUhS8s1+k=;
	b=Jf3C5XbZQtat3jQ0BW7uYQK0E3POXTU4b/IXxb/60LgzcXIx31edAm+lq9U0g478lPOVCI
	kEzpLd6gI9fXWNYRrpZr9BxSgvSJ9IKfsNqeY99L07HbJ9Nj8qwC07TRJz28rA9hFHjVAE
	oZTNfpUDhEDUTNUNc7ifPX2vIa4zOaI=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] crypto: qat - use strscpy_pad to simplify buffer
 initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aP8rHYq4I09pvhFa@smile.fi.intel.com>
Date: Mon, 27 Oct 2025 09:43:02 +0100
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Jack Xu <jack.xu@intel.com>,
 Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
 Qianfeng Rong <rongqianfeng@vivo.com>,
 qat-linux@intel.com,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4A83F19-05EC-42AD-AD6B-B096E0303C2E@linux.dev>
References: <20251022123622.349544-1-thorsten.blum@linux.dev>
 <aPkfsuliKYy5UAbB@smile.fi.intel.com>
 <6DB96B06-108C-465B-9A54-88B8008DDD60@linux.dev>
 <aPp3cXRxvdJzBkw9@smile.fi.intel.com>
 <B981F95A-287C-44CF-8852-B4642E728975@linux.dev>
 <aP8rHYq4I09pvhFa@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On 27. Oct 2025, at 09:19, Andy Shevchenko wrote:
> On Fri, Oct 24, 2025 at 08:47:02PM +0200, Thorsten Blum wrote:
>> [...]
>> Any recommendations?
>=20
> Yes, fix checkpatch as per commit 885e68e8b7b1 ("kernel.h: update =
comment about
> simple_strto<foo>() functions") or ignore this false positive.

Thanks for the commit hash. I ignored it and submitted v2:

=
https://lore.kernel.org/lkml/20251026015710.1368-1-thorsten.blum@linux.dev=
/


