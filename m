Return-Path: <linux-kernel+bounces-873857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C0C14F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D11640481
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A4334691;
	Tue, 28 Oct 2025 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b+vDaaHS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D31329C7E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658651; cv=none; b=NO7tCUmcD8ME3oFUy7CWpRO4tLrWYHvPhy6itF6vp4qCI9hy/kBuZQBJgyHFsRArC5FAWgRijNjVOIGx35GZeCpAv1KKe2UC1xQQnEVqavdfD4guVpzgoRDmdfBtJMSXOOfceaBYLHMS9jkMXWgermUH4FTLiyuG9OjH9XVKJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658651; c=relaxed/simple;
	bh=vRZIvPDPWUNfJ3D75q3Z076kD3mmb2bKH8s/v8dJzDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAblE719ty9zldZ8AzxVzRpdJlvPSiGXwQaT2zQdUWuw8kfXDFv+srMqeeEzQK9QfTZZH59q4PrOHMJ1fwPjbi66nMw+xUmb/RlLIlhV29QRg0wuTdzKxwvK+NAj0+aAxvNwUIT0lUs9N24noclrPVK+TyuVpV/q0iLvqI+BQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b+vDaaHS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7CBFE40E01A5;
	Tue, 28 Oct 2025 13:37:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Nbx6tKafUGdo; Tue, 28 Oct 2025 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761658634; bh=xN7DyMekRKe/FGcxd1q4dV0LToW+6yk3O5piEP0SiUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+vDaaHSCAjv8nA9AbrFC60fyiYK/P+Jv2oRSP2OTn1n/hsYFzG4lakZvmuiXdXP4
	 aegCWU4AInnzHCZUXiR2Oc8rcK88mS1apoARHguTeqaJJv/qt7aYRh1lEQNvF1KIWg
	 NhyVJ7nyGS0N5ihxKCYq24pQ1vCt7TspUzptpdPYWRmQiieC+dYcGLTLd7QRwOKagY
	 Nm9tBYOepur+MV6uQUT5qaXgrSqeKkn9RyUjjRNms6D8awxA5AMf6Nv7thDb0zuitb
	 hjyRoaA0XoYttAaYfutZszvrmWlIP7zd9W6tk9W7m4etxy3ehV97AB4FyKWU/tisab
	 Cfmc8f/icO7BP/QSwvHotSSBsPfhVuJbNQJrWeTVlf0ZisQvyR6YhMKV1Z56aW4k3U
	 OZmL2aL1weUvsqvHxVr2KuGK3eo3Q4b7bPnK66YPY6FMJLn7fwCoYLU6xOH/jpcpMC
	 IoyNB74uWJ5thpKX9JWaioU/Baw+NYO4umZxDTYI+qgnO22rlirNN7kDFV25/TAoyz
	 WhCArgwU3K9anyCKPVliWWN6Br0Ur8FVbFEg45gA5kLjvxL1j4J++ZWJjdwgIWDkB2
	 6hWsjtvFdLabtFiln8SN/Ri7fYu2MBiUqmW4uK5iEX4dvaMnzm+HqBUnrZ8D2753k6
	 8xt784koJeaU+A0q4ZP/48Ks=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CB75440E00DA;
	Tue, 28 Oct 2025 13:36:54 +0000 (UTC)
Date: Tue, 28 Oct 2025 14:36:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
	willy@infradead.org, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 4/7] x86/mm: Simplify clear_page_*
Message-ID: <20251028133648.GAaQDG8PfOwrSiHYuk@fat_crate.local>
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027202109.678022-5-ankur.a.arora@oracle.com>

On Mon, Oct 27, 2025 at 01:21:06PM -0700, Ankur Arora wrote:
> +/**
> + * clear_page() - clear a page using a kernel virtual address.
> + * @addr: address of kernel page
> + *
> + * Switch between three implementations of page clearing based on CPU
> + * capabilities:
> + *
> + *  - memzero_page_aligned_unrolled(): the oldest, slowest and universally

So I don't see how a memzero_<bla> name shows that it belongs to the
clear_page "stack" of functions? clear_page_orig() kinda conveys better what
this thing is. In any case, having "clear_page" somewhere there in the name
should stay.

> + *    supported method. Zeroes via 8-byte MOV instructions unrolled 8x
> + *    to write a 64-byte cacheline in each loop iteration..
							    ^

one fullstop is enough.

> + *
> + *  - "rep stosq": really old CPUs had crummy REP implementations.

We spell all x86 insns in ALL CAPS. Like you've almost done.

Also, it is

	REP; STOSQ

with a ;

Otherwise the idea for the cleanup makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

