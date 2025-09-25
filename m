Return-Path: <linux-kernel+bounces-833429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACFCBA1F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9551B271A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976DB2EA752;
	Thu, 25 Sep 2025 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zEu5uNbk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9727381B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842248; cv=none; b=QkTGh2zxLaK85aznzV59lVsEwVISbggLKSERYGznRbbpeDpsfwFclufOk+xtwx6J5gDeXB/6v/QinDTbJtsS2B8O+O3Zz40jN3E8KaP9sIzZItOt6WZJsOHeWUPxGWh0LYvHuaV+6xryTSFVQKecPWhHxMCu8WPNCP4bezAqpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842248; c=relaxed/simple;
	bh=UwBJHVT+vWTJwWZDgObwFp0nU7Jl8uwGl6zSa7Yy8ow=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G3Aps99EP/0P6x8xfSf+/KuH/vxRXJbPr0O4o1rewNfHxXxUGBTjGR1rCShelgUSrGkaP0eWKyl01QmaHayp46NaFTETK+RKIecoyrGVGfLJKVWS5+Iq7uOfKT1HEGglrf+kQa0NAoH6nNZ7U7IDGKHIX/VXnj+1YDbG9IDRWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zEu5uNbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17829C4CEF0;
	Thu, 25 Sep 2025 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758842247;
	bh=UwBJHVT+vWTJwWZDgObwFp0nU7Jl8uwGl6zSa7Yy8ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zEu5uNbkHJ/tF/idnqJzhDukNEJsCLAt/cqSv6tmmHekUCwoTCaP46y0WDQiNW87L
	 ipPmAS3ipMBid93CHivs8o7CJ8NPaK7SW3j3hOyNv/GBxiPdQBauzCuvQGhxuJj74A
	 Acuptcch5exZ/orzwU4SsPt32okZe7NaXtlVer38=
Date: Thu, 25 Sep 2025 16:17:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
 sweettea-kernel@dorminy.me, nicholas@linux.ibm.com,
 christophe.leroy@csgroup.eu, alexghiti@rivosinc.com
Subject: Re: [PATCH v17 00/12] Support page table check on PowerPC
Message-Id: <20250925161726.2b34890070e6d8dcf8ad3ba9@linux-foundation.org>
In-Reply-To: <336c0402c59363956d0c4eefc1b8a059e1fcc8e4.camel@linux.ibm.com>
References: <20250909091335.183439-1-ajd@linux.ibm.com>
	<336c0402c59363956d0c4eefc1b8a059e1fcc8e4.camel@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 08:42:35 +1000 Andrew Donnellan <ajd@linux.ibm.com> wrote:

> On Tue, 2025-09-09 at 19:13 +1000, Andrew Donnellan wrote:
> > Support page table check on all PowerPC platforms. This works by serialising
> > assignments, reassignments and clears of page table entries at each level in
> > order to ensure that anonymous mappings have at most one writable consumer,
> > and likewise that file-backed mappings are not simultaneously also anonymous
> > mappings.
> > 
> > In order to support this infrastructure, a number of helpers or stubs must be
> > defined or updated for all powerpc platforms. Additionally, we separate
> > set_pte_at() and set_pte_at_unchecked(), to allow for internal, uninstrumented
> > mappings.
> > 
> > On some PowerPC platforms, implementing {pte,pmd,pud}_user_accessible_page()
> > requires the address. We revert previous changes that removed the address
> > parameter from various interfaces, and add it to some other interfaces,
> > in order to allow this.
> > 
> > Note that on 32 bit systems with CONFIG_KFENCE=y, you need [0] to avoid
> > possible failures in init code (this is a code patching/static keys issue,
> > which was discovered by a user testing this series but isn't a bug in page
> > table check).
> > 
> > (This series was initially written by Rohan McLure, who has left IBM and
> > is no longer working on powerpc.)
> 
> Is this likely to make it in in time for 6.18, or should I respin it post merge
> window?

The latter, please.

