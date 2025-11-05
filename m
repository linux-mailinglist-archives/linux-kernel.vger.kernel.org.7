Return-Path: <linux-kernel+bounces-887116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A81C3751A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEA23BDBF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1228468D;
	Wed,  5 Nov 2025 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CKnuJKNZ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42257283FC5;
	Wed,  5 Nov 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367354; cv=none; b=R5nFM/IYAJJO7Qur0UeQqRDIOr8BB3gy8JiZtRBcuDyLIO8+04vYAbYNhfqkPfbCX3ziZhOM2nYm0IIVyJV/HXwgtWyVgZsrKrBJB4jN/OLNX4fJQHABEBRB/PT7AshEmhC3VRcRsfgZoDUmIvgP2WtncjlkmGKZ8GWR2/qFlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367354; c=relaxed/simple;
	bh=0wd/ZdUnDBdj1c3SyrWKY1LlYkg9dLXwkl9/NSU3e2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gcrDsbmufCc8Z+AHs5aF85V2vd1tIyiMVzQyRZaFFvvnd+AwWhVMqdcD2kZi+FkymqdTX44iKvQL2l2GctrkvySXtr6uqj8+4oMUbMsR8oxqeHro2OBOl+yyGJDWLTqRfVitFb8PBleYaAJp4hZTfH7PboczsqfO9Ri7MUWn7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CKnuJKNZ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7944040C2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762367352; bh=jbzKID++8sQ+Bm1t0Bqe95JcYP+VZgUjD5kFKzvXhMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CKnuJKNZyZ19FtPMs5xsGma40TT7f4Dp8GM8XY1cxm8+CGNZ+sz1KKgfGQ/p7eq6c
	 vjTXaNhk2JPIqTkhzpm49lC1SlSqDAPEEMGIj88zVVcz5Np1yUb8BmJ4qH4H1gUyEn
	 W+S3cNJDNzc3vU9dGMkHlEvp5gpiIFkUsn/aiF9M1LH2My4jYHaI7DYRRor3x8pEzM
	 lvwVi0b9+EKeAQ2PIvpUYi/6pAl/6pYTyjbJoFpTkjzBeLOia8/pTpghUIap1GiLxI
	 DQfj7F+awyBSG5r0pFG/HlcO79THmNBIi/OIoXbCONSX5i6APt1QhDOP34bdv1Zc7N
	 pKelRrWRlU2Mg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7944040C2F;
	Wed,  5 Nov 2025 18:29:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Tony Luck <tony.luck@intel.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc-guide: kernel-doc: add %CONST examples
In-Reply-To: <20251104050930.720711-1-rdunlap@infradead.org>
References: <20251104050930.720711-1-rdunlap@infradead.org>
Date: Wed, 05 Nov 2025 11:29:11 -0700
Message-ID: <877bw472q0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Add examples of using '%' for formatting constant values to
> facilitate more usage of "%CONST" in kernel-doc.
>
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/doc-guide/kernel-doc.rst |    4 ++++
>  1 file changed, 4 insertions(+)
>
> --- linux-next-20251103.orig/Documentation/doc-guide/kernel-doc.rst
> +++ linux-next-20251103/Documentation/doc-guide/kernel-doc.rst
> @@ -405,6 +405,10 @@ Domain`_ references.
>  ``%CONST``
>    Name of a constant. (No cross-referencing, just formatting.)
>  
> +  Examples::
> +
> +    %0    %NULL    %-1    %-EFAULT    %-EINVAL    %-ENOMEM
> +
>  ````literal````
>    A literal block that should be handled as-is. The output will use a
>    ``monospaced font``.

Applied, thanks.

jon

