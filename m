Return-Path: <linux-kernel+bounces-746006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA6DB121D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4F8AC795E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87D2EF291;
	Fri, 25 Jul 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Mxm8gs1O"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65B239E75;
	Fri, 25 Jul 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460334; cv=pass; b=CU4eU1rRBv1V7R27OwNbJFgmbRkXqgcQrqSatUZyk7V8DkG7YK4OJYz9siy1bl5a8PlNZL/UG4XXjABRkrO15PgXNm83es24EX3iijSq0fgGWmI5w++kGViEf8fAHgwINrmlEcrtEaEQiIJ5FJuWTStw2u+Ph2sOyiJGxtdb/sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460334; c=relaxed/simple;
	bh=VyLVOo0NyZRA67UdGl1GMbDvYECPSj/OhPj1X9feTlY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HgRjqw7xAUTGft4g5qkrndTdCCUg5L9MpLF1DfWSRDka6hoZSUsfxZDDhLmnFAaGtJitGxcec5IXlnaCeGXHFz8nYEHpyKMvXIg52vkSe8osMdKipoqIbfARj6vW43ISRkhuHCAN3Z2ok7jNoLo/bIZLbuGrIFqjuopQW2p4lXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Mxm8gs1O; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753460320; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E3HnPgc2eBYNDuIYlicEbg96DDSkVOp4CXTYWfixNOV/okz4+kHMrDNCSPDa6U75Kp2gq1/2hWgR1n2nHaM3xqayabBd/QBuggSA1SQoJUnQmZ3pPfJIsN1nU72Psz8eh4hCd3mWrPQtHdFdx83xuKOIYHGtHIZUquDnyPZddcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753460320; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hNWsklfhKoy2efLRs+iJB61xdGvPIUy/D6YVu5hHEgw=; 
	b=ZxWp78LS+hhH/aZAUEg7/xZV2zD1x03RIS0QNuEUSdRJ/WLNKn4caRXaVM7uHX5BjYQR5xzAcH27DKv3qs5p9TSPYt/XOVP4jEmzvLIKZDmIk+QTqyAqM18m111KEriyOJ/YFJRH+zRKFb4zVJ/aU1l5UteCcmdaWl/sQGlVK4g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753460320;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=hNWsklfhKoy2efLRs+iJB61xdGvPIUy/D6YVu5hHEgw=;
	b=Mxm8gs1Ocl4n8oCJ5x+rZKxCG+K8/Zm+D5ZE3ENQouX7WmiEdg5mE2oQazN5+ALr
	YOXVTgMMSjiOwB32+yAvo0u5Z972iHRASY7phQQ+IyBk4ETLoQgf73tkfVgTxLeD60d
	8uwnNbI9mVqsWudzz7ChHDDjnISVQLJvI5yqE1BY=
Received: by mx.zohomail.com with SMTPS id 1753460317999359.60159706229695;
	Fri, 25 Jul 2025 09:18:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 02/19] gpu: nova-core: register: fix typo
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718-nova-regs-v2-2-7b6a762aa1cd@nvidia.com>
Date: Fri, 25 Jul 2025 13:18:24 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Beata Michalska <beata.michalska@arm.com>,
 nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6641734C-5331-44BF-B2B3-93CBC2F0E3D6@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-2-7b6a762aa1cd@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 18 Jul 2025, at 04:26, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> A space was missing between arguments in this invocation.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> drivers/gpu/nova-core/regs/macros.rs | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/nova-core/regs/macros.rs =
b/drivers/gpu/nova-core/regs/macros.rs
> index =
864d1e83bed2979f5661e038f4c9fd87d33f69a7..93e9055d5ebd5f78ea534aafd44d884d=
a0fce345 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -116,7 +116,7 @@ macro_rules! register {
>     ) =3D> {
>         register!(@common $name @ $offset $(, $comment)?);
>         register!(@field_accessors $name { $($fields)* });
> -        register!(@io$name @ + $offset);
> +        register!(@io $name @ + $offset);
>     };
>=20
>     // Creates a alias register of relative offset register `alias` =
with its own fields.
>=20
> --=20
> 2.50.1
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

