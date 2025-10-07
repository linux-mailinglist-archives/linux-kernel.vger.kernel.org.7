Return-Path: <linux-kernel+bounces-844097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230EEBC0FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D559B3BBD9A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFBA2D8385;
	Tue,  7 Oct 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mmsCdRxU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08E39ACF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832512; cv=none; b=jcZE8f5V4W7djNhVyB0xIk3hnKEfUUxHewyj1wIiLpTby8tVCt7mctaYJDBBnjq0elWoWRp2sDx/MZmlU5K3NCiumuKpfV9JSmXoVMdOAaPYI5eDHA99ADvgbPirpsag/fKvhODMKGqRwTDPQYQseIv8kfDBcfpp6E9IMDsJzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832512; c=relaxed/simple;
	bh=Lz154a2ZjwBDnXC6QTUowOmtduFQWvUmThHqog5LYEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbx+bi9UWd4g3c7lLom/Ikhu9LvNYGqVBQJoo6TSBmNjP0fSaHBfDrzcCoubXuM5icYL5c9ncpiD3d8NP6tbFWTeftR8BZB2ZpnMYfrlxBaJO3moUgSRUPL0lOmUfo3EjaWevuU2zgEswbZBQ8b6aOusJeby1BUGAYlrzgl8ROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mmsCdRxU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vNHYGcYUWu+zhrNr0VX20BTV37QWlvHYYxUYXoY2euQ=; b=mmsCdRxUI345ERhSUGFHTcgxrE
	YEZ5pJyxwFjtu8mofBBVuNfLELkZEeDY4xtRnova6yDNGRfy3PO2f5ZJt5fhXS4EXa7H/I93ZnRxl
	KdZj8k432ZCmmibrZ4HzmNyYnT5X4GfZX/vtb+rZ7GADcumirEdb3pdbSje4L1lHZVs5E/qeUIqLH
	AlQpU9tMhCwAdFg/0IxUhhHWmj4JMO9Nr2RSXRAhMaUlTBX7VZ7GLsx9YDmR4rU2ImWVeBPoQI2h6
	E6s0OMqZklPR0pC/00tBhTg5qYvmR8s0GddYubu6n4+euFZcwYHTi1xydoKDDvkE0FiYfaeCxoHW3
	Ruy16Hqg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v64oe-0000000DixI-40cP;
	Tue, 07 Oct 2025 10:21:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 46331300220; Tue, 07 Oct 2025 12:21:06 +0200 (CEST)
Date: Tue, 7 Oct 2025 12:21:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 15/21] x86/xen: Drop xen_irq_ops
Message-ID: <20251007102106.GE3245006@noisy.programming.kicks-ass.net>
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-16-jgross@suse.com>
 <20251006185553.GY3245006@noisy.programming.kicks-ass.net>
 <c8b3c9ea-8c6c-4ec2-b01f-df3f8f487a8c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c8b3c9ea-8c6c-4ec2-b01f-df3f8f487a8c@suse.com>

On Tue, Oct 07, 2025 at 09:47:48AM +0200, J=FCrgen Gro=DF wrote:
> On 06.10.25 20:55, Peter Zijlstra wrote:
> > On Mon, Oct 06, 2025 at 09:46:00AM +0200, Juergen Gross wrote:
> > > Instead of having a pre-filled array xen_irq_ops for Xen PV paravirt
> > > functions, drop the array and assign each element individually.
> >=20
> > Same comment for the next few patches; this changelog is a little light
> > on *why*. I mean, I don't mind the change, but supposedly we should
> > justify things at least a little, right? :-)
>=20
> Would you be fine with the following addition:
>=20
>   This is in preparation of reducing the paravirt include hell by
>   splitting paravirt.h into multiple more fine grained header files,
>   which will in turn require to split up the pv_ops vector as well.
>   Dropping the pre-filled array makes life easier for objtool to
>   detect missing initializers in multiple pv_ops_ arrays.

Yes, that'll do. The latter being the main reason in this case, right?


