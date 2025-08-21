Return-Path: <linux-kernel+bounces-780470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE9DB30249
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2CC57A4603
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA0D30E830;
	Thu, 21 Aug 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PbLQdufb"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1361EB5C2;
	Thu, 21 Aug 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802234; cv=none; b=ixeEBppHjKy0Ji+4CCg0rCoPgDAVt9eZiwpKNLSpUbqiYt4s6wrgjOKOPEHs6nHNcX0OPIkSmrl0sccqYE4gB1NYvz3CT6Ol3mkRkaJzDgAbJWwio8ycrLmA3hRKipuu/MBnuNYf7ADqDmUQ470m3KzGqUqOUBkTrvHqRV13wqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802234; c=relaxed/simple;
	bh=MCotrZmNT7RLq9JXnxjTqoY/y3Qcia8Pef8k45/qlxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lf50fX3oCEvLd3e72Ij1q1P7ynkXq+FduP9Sqj+SBLKev89QarG2QVvH6lbfnGdhKTFLPiyJQfB0u2oJlEBglZQZlyKC0w9RAaRXPcsf105Wz1LKkzQHaOdOLWgyZYUCdP+nTEs7ufEic4XoKZhM2CqwcPzWtSg6MSZkNy2o7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PbLQdufb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 71C5240AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755802230; bh=wR+ymNRSdxLoxdfwbiG8L4tIz2EGNW+ebvxDR/PAd7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PbLQdufb4JYWtd0/ScdfGma9Fmb+G9nq8KE7Wq1vmRHzdTiOayaCe/HK1Alr8qj5Y
	 TO+ms1z4PkD82hzBtTxml6n08S8CzgI4wz61JPr/MhTe2QYE6Gm7K0a5HokUaoKC/t
	 s936+FSWZHwv0JALXRixKcyixHilakGJg3FVtXfsjUhwmhawOlYmWduM92ym8c4H1J
	 94ab/BHHRC8jX0Pb1C9dCgemYYwvzgZRONu/vQsfJnJaaqzMfV761kXQHZXjjN6NnC
	 lG/+8VS3UikPGSRdnqGmpBHtQtE+ZpsAi4MfsEjU4GNZGABA0LQrbsxCwhQq1/IkDZ
	 1XKV2rnFeuF7w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 71C5240AD5;
	Thu, 21 Aug 2025 18:50:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
 viro@zeniv.linux.org.uk, brauner@kernel.org, skhan@linuxfoundation.org
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] docs: fix trailing whitespace error and remove repeated
 words in propagate_umount.txt
In-Reply-To: <20250818181934.55491-2-rpthibeault@gmail.com>
References: <20250818181934.55491-2-rpthibeault@gmail.com>
Date: Thu, 21 Aug 2025 12:50:29 -0600
Message-ID: <875xeg7bm2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com> writes:

> in Documentation/filesystems/propagate_umount.txt:
> line 289: remove whitespace on blank line
> line 315: remove duplicate "that"
> line 364: remove duplicate "in"
>
> Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
> ---
>  Documentation/filesystems/propagate_umount.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

