Return-Path: <linux-kernel+bounces-809694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C2B510F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8054678E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F8E30EF84;
	Wed, 10 Sep 2025 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/yl0ujl"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3C3009C3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491990; cv=none; b=gpE0bofAAvUsOUsDWuD/p7fQKcN0nMkIoWH3xpsr2tjoyzNcxYiK+kO7qvu4HYwdwFw+dRs2VLzG/P3BmgGTYYOwloXKxo092X/2cT7V3KnrQGHZnQ6tlMhgdlLLY7WVX8Rd92GXaeEpzp/pbKUgPLL1RsAx2JRDRMJgTvWBK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491990; c=relaxed/simple;
	bh=WzuI3CMsDUiGxWbPrHa8EMk9iyln79qsPIz6k8J16HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4DR69GJVNrA22Q1VrQ3QnzXEyzWrqmJ2mKqVBpZe3bhCH3dQIyski9US6EzXQmkQLU2Pf557tCgwQkRBzna1Z16d2CDdQAdJ7WbAQAMDdSnwLgk8Ew7Yt+Uh8MH7jKJl1Q/vWI6KO2gku3KlaBbX1sv0xR4ISkpGYRedjBL/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/yl0ujl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e249a4d605so5229774f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757491987; x=1758096787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WzuI3CMsDUiGxWbPrHa8EMk9iyln79qsPIz6k8J16HI=;
        b=b/yl0ujl7jCtvtVHI0mgGhlMT59/Q/1n7d7/KVljpycf2Gs2NKDy9QCzcYVaK51jNH
         rGHEXYSs1L6ma5kwj2W5ofvL0yyBvik4ROM8Elraxptzw+GXeLTLXA+M5JjKCJ80uAWR
         ka0cAXlHjmMkjP/ZLUoTihguecErF4ZzTdSYwtUztRuefvCUt0upeUSLSzl1gs2ggB6+
         Fc/U0YGA//0G38mq21L7ntBQbBdETLlSVDLfbcoNzNQrSB+YriS5igSB4W5hmD1kCp6s
         cVVbwmaGDlY3mL8zOCyeJByKncwegQZFT/9YHmgQZaApc7MdarQq8BP5XNbU4r33h78B
         +l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491987; x=1758096787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzuI3CMsDUiGxWbPrHa8EMk9iyln79qsPIz6k8J16HI=;
        b=ZVhLge1cnG9nF7k5LLQd0J4XTe/QRRr5wkJsDYvzkXZbinNsGUvCTvROhKwe4mShPu
         JiS1ozwjzi48mQW5eCPUBFfqmUhuIuEckrPuUP5c7xd3aMbMAI3qt4gBcBetJFvPURfc
         1QMXxnEFcB6dEal5xOvGsLbUbnPWSYjPcdSfa28ximLcwZztcawqIF8/33ZUt8grU3aD
         mKWbCm+jfElVtk8vbVx2pUZ5KQxCKISJVzkmYRRmCFFfgShH4QcC6lDOCBMgrDLlBrpG
         tOgUxEDtydEso6gk3VKuKX4obVLHofsel9pRX/BZi1dxjCDcPxbQEBbEwfEkr+Zc6AE0
         MCww==
X-Gm-Message-State: AOJu0Yy7irDm8i8XPpnvyNkN1ZFTDCrfGiYHO7jcUEij00Wsah9IUGbR
	l5FxxZYAcvl2JgtRMA/40Hpm/Fr/I7vDynO116c0cwQbd+VK9bJXT+LHt/FpG/gXdn8=
X-Gm-Gg: ASbGncszWVnAAoF7FNF0PvL2EADfKW9dbOq2jLb8I8nnE3Pfn+KciQGE/OgIc8T2nOk
	0JyN8ERBAjWH1xZyQyknojiUnsahyS75b8rrl55MLAq10LoKAppJl6rSeRpqO8El/uMgNkPGzBM
	5WTMmfgFR2tKUEgZ/jBUpAswrIXEXH2QVbC5wJ8sGewNCdBhRAJZdAiLCqvqtP8z/wP4QMzIJfA
	8aPBMU0bZXTW9JnAvbUorzzYiniQ6nnvGPONQOwU/Bv3mxiMrKnndpAnclBtfqjd2z45+ZOAtRP
	0OxvC0yr0/RQdJJOYIUPJGto4ondiXCyByYAy0N5IWb8wdlSPu53Jzj/GfDTcXaWFePXesawd6z
	NeXSlGqK+xMmUPFPxJeYeBZBNXggQLDlBN6MLM8AXc/xyBHybqh/aMg==
X-Google-Smtp-Source: AGHT+IEQFBT7dp7RNc2ogdQdpjqsbXKvm1ZndRkmh8I7BnWy1MBMxBpMsBWKneKvH3SpeB8F/HcCIw==
X-Received: by 2002:a05:6000:26cb:b0:3e7:42d9:e0d with SMTP id ffacd0b85a97d-3e742d91343mr10263125f8f.11.1757491987198;
        Wed, 10 Sep 2025 01:13:07 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca2ddsm5932578f8f.23.2025.09.10.01.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:13:06 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:13:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux cgroups <cgroups@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrea Righi <arighi@nvidia.com>, Johannes Bechberger <me@mostlynerdless.de>, 
	Changwoo Min <changwoo@igalia.com>, Shashank Balaji <shashank.mahadasyam@sony.com>, 
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>, Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
 <20250910072334.30688-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fjrh6im5iknzgd4m"
Content-Disposition: inline
In-Reply-To: <20250910072334.30688-3-bagasdotme@gmail.com>


--fjrh6im5iknzgd4m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
MIME-Version: 1.0

On Wed, Sep 10, 2025 at 02:23:34PM +0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> manually-arranged table of contents (as reST comments) gets out-of-sync
> with actual toctree as not all of these are added to it.

Is this true? I generated HTML with this patch and the resulting ToC
matches what's in the comment.

> Replace it with automatically-generated table of contents via contents::
> directive.

Mauro, what's the best practice wrt consistent ToC and having it in
plaintext form?

Thanks,
Michal

--fjrh6im5iknzgd4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMEzCBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjMBQD/czZJpdQcPqjKDSvqxMKL
C14p0XW7rwMr8yfTpDWhSHkBAIZ5qwuYKRcjhrXgD7FALHOwDlB6kJdMj0DFfVOz
u8gF
=IlII
-----END PGP SIGNATURE-----

--fjrh6im5iknzgd4m--

