Return-Path: <linux-kernel+bounces-881462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E14C2840A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC75A34979C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4532FB09A;
	Sat,  1 Nov 2025 17:43:34 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E82FABF8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019013; cv=none; b=M/aMJ9HS35pzpr51MIPmjk7vUMSsNt/YBplr7OpQTbztiYwY92ww2nYErS2E+Q8GVLFD6rp6NPiiik5MJo3zOjo+UMv4Lvg0YJWb3esOBbaHmmFsGixjXdECBzmvn/RUpzDHCJ2aKDMJGYl8qtwH+cxo9HVbOm5GJHRDQIqMnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019013; c=relaxed/simple;
	bh=o0eiown53fe7mK/LKj//alXONUq0VIY8OfJfEjRu3xw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mkqshk375QSWRrHFQJylAhJyCG9or4+zuuynZ1RB9AMyw2b6jSx/O3xzFCRGITLwWW9LReElUQ9083k8/gjUmAjKQG09oNwOOojK5dtZJ2bui39b4vjqL7ahzF9PzpuB7luUiacNqbIOpEZsYAAGtessOX4/Oogn2LjUyJhshUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3A97D88A8E;
	Sat,  1 Nov 2025 17:43:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id D19052000F;
	Sat,  1 Nov 2025 17:43:22 +0000 (UTC)
Message-ID: <1189b6b0a67eef57f824f200121c8d46e73e5f24.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add IDR to the deprecated list
From: Joe Perches <joe@perches.com>
To: Carlos =?ISO-8859-1?Q?L=F3pez?= <clopez@suse.de>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, Dan Williams <dan.j.williams@intel.com>, Andy
 Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn	 <lukas.bulwahn@gmail.com>
Date: Sat, 01 Nov 2025 10:43:21 -0700
In-Reply-To: <20251031111908.2266077-2-clopez@suse.de>
References: <20251031111908.2266077-2-clopez@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D19052000F
X-Stat-Signature: xuohni195sg5t888mb3hr8cazptxuxkg
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19avXQfbgyS4MjPj/QgSfbVV166y5wlDUA=
X-HE-Tag: 1762019002-310553
X-HE-Meta: U2FsdGVkX18kFvFkgy7Pla7wIYr1cTwSaBL/lElk07aWvuV0UI86zpS4xI2ieWHL7cnDsgP6Va+OiG66G2GI0T6dwAnfuBv0r8O1HYaT5748kTaecL4ImGL7ja227J8OAvnWazlEg29/MIRVr0QshmxddRNecxlmO0dbhRmrRrIwYAfI2LCTmOCUE/UZcmp2+1qFipy43Ah06ryfcV57tolAZGKE7GsdpXEz/alzoL8Wf8V3Cbu7SSN38UOYnndPf9uUENDqHwV8U5VItohm8zFhK1abhySNRfmnCg+FRv4argx1DevWwd2w2vBBOtsJTZfU7p+5ZPyCRBg2UTuRrjIkTK+ctMAQyjs1DDEgXuznxkAQYoNqnAbvDeftvf/5DEGX+up/9O0CVV2QhT8SfQ==

On Fri, 2025-10-31 at 12:19 +0100, Carlos L=F3pez wrote:
> As of commit 85656ec193e9, the IDR interface is marked as deprecated
> in the documentation, but no checks are made in that regard for new
> code. Add the existing IDR initialization APIs to the deprecated list
> in checkpatch, so that if new code is introduced using these APIs, a
> warning is emitted.
>=20
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Carlos L=F3pez <clopez@suse.de>
> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 92669904eecc..bc72fa66c0ef 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -860,6 +860,10 @@ our %deprecated_apis =3D (
>  	"kunmap"				=3D> "kunmap_local",
>  	"kmap_atomic"				=3D> "kmap_local_page",
>  	"kunmap_atomic"				=3D> "kunmap_local",
> +	#These should be enough to drive away new IDR users
> +	"DEFINE_IDR"				=3D> "DEFINE_XARRAY",
> +	"idr_init"				=3D> "xa_init",
> +	"idr_init_base"				=3D> "xa_init_flags"
>  );
> =20
>  #Create a search pattern for all these strings to speed up a loop below

Acked-by: Joe Perches <joe@perches.com>

