Return-Path: <linux-kernel+bounces-741646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA3B0E72F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB453BF9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205D28B4FE;
	Tue, 22 Jul 2025 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSJjEwsD"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD138FA6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226844; cv=none; b=YetGb3wPkJhii+XJhWgbbP6jo6ox4IH+92cbdXPN8sQrLo5AKIT1No9RJUYa7t98l+zRpvljkrLCgEDbawuld7Twl4PZbR2O2KYxyZkmjBqh56XwEXSlr9yp6FScngENffls8zfPc/JWPwX9uP1OdxqZ56/wVZ+rqPRT7EIUs2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226844; c=relaxed/simple;
	bh=unnnsqQDFFxjw0lTZGf3VrRWeqIxQo+6b617R1eMnvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmOFxogdZRZw8lf4WBz7+AQcws0B7t1lsulf8S/Ocvqz2WZ2Hh5XV4GlgH2nFcXnFhkPJ4xyT6nV+aO9sWXkHutNxoUZx5kXu3TvhDjQjbCk2H3+KbleRQ/KTn6pC4JHyjICuYrOWexxBDBcnprGAxdEKFCaj4ox2ql5RNzyWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSJjEwsD; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ecf99dd567so63969166d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753226841; x=1753831641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwc3Fror8L4wHpcfLKE8iXNePDDpmn63CWUej31GmfU=;
        b=GSJjEwsDlH105c/R6qtac17QTCBxsUo8bQABtZZvTxh77J0d1hwdwfTkAqCHYheW1E
         lXNq9AUziw8uRvxxSEnPAa97Ik73t40dRcjYhbZIxCJ5xCoV2zYQ1cAPJYp26U5PvIvF
         CfByvP6b7QwnDO7g42vcVcyj7rUcme88Wam8UOWY6FdzT7CKnXaAItlsx7IDNg1AxfqF
         s9BQUxHa5zExK2ABjLSq5GkzFokN5FtF1ugUVvsFoL0NmDLyzseEyuHZQaFkBHuLhG4j
         aHENUHGxaBiB+7Y37805uc1uIjSnWVladZac8cVjNbFWLGyJkXS6I3M0xxk8edN8iw36
         t0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753226841; x=1753831641;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwc3Fror8L4wHpcfLKE8iXNePDDpmn63CWUej31GmfU=;
        b=EL/VxkO2iFbzmOgFIaNdxIbYEYW7RRM/gSLzRmH98FQvlGCNkS1e2VAw+auQ0b54eZ
         pFx2oy/G2SH6wlfJDhPMf+45QQtLlcu4Aw2QRzJ6WHAfGGhu5npIZAnCr4NtG0uO0pFr
         sQ1EMefDZU8RTpRnwM+IXGtHWFrsCjA4mLcpqxPiZuyia/IRRbpFpWunzFEYzw9y75Cc
         JvFFFbJIu+ZTBlHH5Dm5AGukvKZg1Z8yUZxIvQ7JHbp3Aisa6QIZveFhN4K31Wl75WLt
         z+o6w3K5mhMJpuNlgw8q7ShVWlbK8kyNST2arARO1NU6TzLv84J6xcVT2sucbirAFmoP
         96Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUXg+kw2jh9gjfh1WPTZLD3ENLWDnruxybMzSjqGQErkGVJwYyroFJrz1k+WFNICw5rB+COs6kTPN5PRpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCynBwlKxgoCCPbPel0KtCkqk9pqmEgn99YsChPHiyGLqJP6Pb
	lxNe9zMrHTmt5fPvsNaDSsiCNb/BKboflxbTWpQ0+lRLSCpkgFxy+rrK
X-Gm-Gg: ASbGnctDqNm4OJ6V6eqMrKnRN5l3YXVlWk2bK/gDK4R45CoHzerhAIZ0XR4FxFCveC4
	fyIImxgdxYq6bxMGjX33QaId1R3aLhElxgbXoQXrNlKjK4pkeg0BzwbGg7k5xVWHeGfdgayiG3s
	m1ysDONOPfT6F0rs6e3xLirGqdzQLgP/c4sptU+JbLGPN/XUCMVBCoD9BvcMuHrva0DsOxDLbIF
	AjQ+5QK3IhEVsCZ4/54kZAwqByJs5qShOwwzq68qhVGQnDxeyXrITvIt7a04djEOpzomz91Y0k9
	774UDkCJrMSMDsjeUvD0N94KTAMZtr3JCmE1rM1GgXNyVKOIFBJg/ZJPzTJbudtIoKhekAhBbwo
	n4hXCP7w5dgWtJW4=
X-Google-Smtp-Source: AGHT+IGe1ljipZjsZbw3dRvkwQE0O5+2HUwSu8xq2HYAnP4Hbng2NYuLyW6FuyfDw5tRqvNufERT9g==
X-Received: by 2002:a05:6214:5004:b0:702:d6e2:5bbe with SMTP id 6a1803df08f44-70700489ffamr11704486d6.4.1753226840794;
        Tue, 22 Jul 2025 16:27:20 -0700 (PDT)
Received: from Gentoo ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70692e593f2sm46013746d6.21.2025.07.22.16.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 16:27:20 -0700 (PDT)
Date: Wed, 23 Jul 2025 04:57:01 +0530
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:powerpc:tools This file was missing shebang line,
 so added it
Message-ID: <aIAeRXI0k3FAjXJR_Gentoo@unixbhaskar-laptop>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250722220043.14862-1-unixbhaskar@gmail.com>
 <20250723092243.7056fda4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cSD96wCacS3lJ7MH"
Content-Disposition: inline
In-Reply-To: <20250723092243.7056fda4@canb.auug.org.au>


--cSD96wCacS3lJ7MH
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09:22 Wed 23 Jul 2025, Stephen Rothwell wrote:
>Hi Bhaskar,
>
>On Wed, 23 Jul 2025 03:29:36 +0530 Bhaskar Chowdhury <unixbhaskar@gmail.co=
m> wrote:
>>
>> This file was missing the shebang line, so added it.
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  arch/powerpc/tools/head_check.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_=
check.sh
>> index 689907cda996..a9cd06958921 100644
>> --- a/arch/powerpc/tools/head_check.sh
>> +++ b/arch/powerpc/tools/head_check.sh
>> @@ -1,3 +1,4 @@
>> +#!/bin/sh
>>  # Copyright =C2=A9 2016 IBM Corporation
>>
>>  # This program is free software; you can redistribute it and/or
>
>Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
>I used "shellcheck -s sh" to double check that it is in fact a bourne
>shell script and it is invoked with $(CONFIG_SHELL), so it had better
>be :-)
>
Hi Stephen,

I will make sure to check like that, next time onwards. Thanks for the
headsup. :)
>--
>Cheers,
>Stephen Rothwell



--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--cSD96wCacS3lJ7MH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmiAHkUACgkQsjqdtxFL
KRW35Qf+JObm2jY/zwSzo96r/QcyoJaXzVNVQkoM8tk6J2ooPFAgkNFDbt8Xn7K/
Ttel6IJ70yRkxV9mTl0eJzWM/IQ1tZlos2g0bFVvyTwfnzA2IxeeLUkk7X0+mpNp
Side4uWG/8YNvIFbRhWwGNG/+yrcOrZEbsYI4d/hSELyPGtTMQ+yb4B8tvbOgn8Y
sT5PXU//F+ysEcxblBKgJjd672OyNxeaLACXduXZ7MNUlR/SEKDxkWCePpsLvei6
xniaaMr31+TzpdYKnIHqE1zljrpUP903Au6Nu+yDKYvreIjH0lDl5DNEmAjz8M2Q
TOA8GkG9g25uZ/72B3M49y8fZR6ycw==
=L+e7
-----END PGP SIGNATURE-----

--cSD96wCacS3lJ7MH--

