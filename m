Return-Path: <linux-kernel+bounces-770809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC3B27F27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AC91C85DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9E3286D42;
	Fri, 15 Aug 2025 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ROnwqb24"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB3225A4F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257310; cv=none; b=uMngTwyFi0R8urSHPtOeH+ej9pidsP9EGU2tGMxwJ9/grY2Fsmfuds2xIPLD8mvD9b84+sFi9ETBihORzPYtfV2hHN3NGvbAAM7LSMoxqZleK1//VzAngVALkv9iumdhPZX+mPTAaqSFAw5Pv5VhJ9VJOyvRT0wnBWYSjczGAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257310; c=relaxed/simple;
	bh=i18PFWJvJyUVxvyf0I1d5XFMqv+8G//fSu9a0eWFQvM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gRmqYcSIEWkdsSXkCyRLWI/Xkc0aglGVr6fxqk4xx3gQt+m4hsKkG0gJ1tWQh/MmlAVjjEmj2+2oaruneXwdbVpRsLwzY+pBGZ9nMfLKFu3diigg52X1BjvBHJs1FMUlxxmQczyyxpkWBuP9+GkSJ9ADJtyxokQtVlEMEcJ2Nno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ROnwqb24; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755257296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i18PFWJvJyUVxvyf0I1d5XFMqv+8G//fSu9a0eWFQvM=;
	b=ROnwqb24+gaJ7csqiETiu1sNod6Py4u4m8Huq9Iis5g8n3RD2XFkpcuhAaApzvbf6p+diA
	bQQlszxVZ3AT7MyJNNTkNg432j2xcY6YGOgookvyNiepzUzrET0xDHRx9k9YzTspzWY+Kl
	f+xOvxfvVz+SMQ0JNX4kQ33QecehFsY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aJ72XZ0VkrCkKFNy@aspen.lan>
Date: Fri, 15 Aug 2025 13:28:01 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Nir Lichtman <nir@lichtman.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 linux-hardening@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <710CDE93-89CC-4B60-A582-5F9B2916ED72@linux.dev>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <aJ72XZ0VkrCkKFNy@aspen.lan>
To: Daniel Thompson <daniel@riscstar.com>
X-Migadu-Flow: FLOW_OUT

Hi Daniel,

> On 15. Aug 2025, at 10:57, Daniel Thompson wrote:
> Sorry but a strscpy() where the length of the destination buffer has
> been calculated from the source string is way too much of a red flag
> for me.
>=20
> Put another way if there are "no functional changes intended" then =
there
> cannot possibly be any security benefit from replacing the "unsafe"
> strcpy() with the "safe" strscpy(). Likewise abusing the destination
> length argument to truncate a string makes the code shorter but *not*
> clearer because it's too easy to misread.

Deliberately truncating the source using strscpy() is a valid use case.
strscpy() allows the size argument to be smaller than the destination
buffer, so this is an intended use of the size argument, not an abuse.

=46rom the strscpy() function comment in linux/string.h:

* The size argument @... is only required when @dst is not an array, or
* when the copy needs to be smaller than sizeof(@dst).

Thanks,
Thorsten


