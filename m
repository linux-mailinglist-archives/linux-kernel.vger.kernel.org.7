Return-Path: <linux-kernel+bounces-844906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ACDBC3079
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F24E19E00B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1440D72602;
	Wed,  8 Oct 2025 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvc7zp2Y"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322133086
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882137; cv=none; b=C1pVsFzk2KLPIm8Nd6iRNjJ/uZsWBe0Dy2jq7AzAZGsmH3cM4lzyTazjET4k+Hap6yQKjGmgjTiVYyCnko1ozoWYNhN1PVqNVmgEl9/y1Cllzy+5rxNT3kV5t3NL7dZH9y2sRmJBPHET5x2Ni6JOtkdyftrQxcIIoM58IpNKxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882137; c=relaxed/simple;
	bh=TzNbj5F09hehstERxCAIDX4BS8a4whqVaxlUmycH1V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaSnLhhHnjf4Obhz9SCp3om8ofGQ1PtWj762jq/EC5E7wkpb4anESw43/YFntWD8n3+M6ZYA7haOHnzJZPJfzQCZpbxkKqsDj26aar+kdb30y4aszrTFp6be4fB3QnbbNS2xMcZEKh1Io856Y9jtceOD8ju251DZM2TtSIHd860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvc7zp2Y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-267facf9b58so43402845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882133; x=1760486933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzNbj5F09hehstERxCAIDX4BS8a4whqVaxlUmycH1V0=;
        b=Uvc7zp2YtLGsPEPTE4M12zTHbD2E/n0JxnU+r3OqlxYyEciMsvIPMCoksg80JJqgyd
         QUh74XE906/BgKc7yuwprYfYm+VR0eI8MxtLc2EQtbGj7FYdarFXCSTPmwZNjrQP9xuQ
         ikD5iRbJJi5H/6S0Lz30BmN8e6pz4DXZhqCt23GCtWPq5GGUIliS+8D3v1800ymu/eTu
         Crlc+xRJsqDsuFGWoAB2ByxQAmp1rWkB915XipFdpYIqZxRsRyY0xLTtA3wnJiaYFZ+w
         keVCBKiL5CoSaobO4WjOGKd6ZJxBXG1zicxQp+72rzt0vfrjiSYayZt6OzKloBG3wajK
         WWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882133; x=1760486933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzNbj5F09hehstERxCAIDX4BS8a4whqVaxlUmycH1V0=;
        b=BiGyMH4taKsdjf4paC4QktLc/5hHjqbApxgoGPqa16OtZc70LRrvpjN9gtyzIeKjnN
         rVBmSFj7WMC8I6ZwiZXV490zpZa+fqt0jxUJbOMJI0HN15Iy9rq/OHierGl6P9Fm6XgQ
         mbx0qzA7KJgAfRych6Onu5toVIewpACyF4O0G+SHJm5eTfrwbDoCuHjQJ1efSr2IdKf5
         UpLMpLQyGEQrB9yyV898YnAJejgPvwCElaKIqeU8HWSjfc02N5VgLTQ59uUlxBDY8uOE
         UNm6vmRim+942ReiF88JOY+a7CoEt6Kv/JVE+S/qW1iq2o5L5rEcxCMFdBGmG+X+KIg5
         QK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO+vzkAGbDBZLSC2i4SPrh82YpluJwJoTWDjKp3o/I5AIEXYXa/4tlvXqRbnkAxlnJOuzoILz36aBBRHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi/qxK48j8loKmdo64ScY6V2jP2mPB+JI2WhSHLm0VajCLciWP
	qjnbv/mKCIvucKc56SbTReOqYP8ZYZQCe/3M0vvBfz84P7aOUSdRFitn
X-Gm-Gg: ASbGnctnS1fyXovLYw0hNLTZs2TVGb1Amw3cpH5k2p+ezGIuwKHtVq9v/GtltwsdE1E
	XCePU52OMaq0NKs8lqWg/ejwMWBsNxpdiPKZ7gWR2tc6jNv/LcMFKY1HzShFGMlmBqKdLzzb7B7
	8aUqeUP2fkHAfingtp6btTA081XDaBI4zOV+zkqZGNUyHWuI/BbHR5M3bN0GWbQEZujX1vzRe6T
	e4W6ulJtuJYS2e4e6OfRqUNMhLBwmtHaFzpqTaw2u/UJWKinOTxJMbE8eKY/sU707v1CoNY8umC
	EgMm2zWvthC1D1sKqEaGe4va7owGxcS4xonfSKe+24ErwpRpTq50I3nZsZL1apnDdh8UDYu61VQ
	nq16Cg2tjXesOGjDUAZEYJUJT7ACSAuHnLGBQeO7BkVb4M+hM0g==
X-Google-Smtp-Source: AGHT+IFz4iqQnGC++UNb9avJGyf7WNgIxVS5Iniz0mvnqB7gDtzJOUwL4fBGjQJWpj0aVrcA8Elc1Q==
X-Received: by 2002:a17:903:2302:b0:263:ac60:fc41 with SMTP id d9443c01a7336-290274030a0mr16042285ad.48.1759882133374;
        Tue, 07 Oct 2025 17:08:53 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1267d7sm178391575ad.49.2025.10.07.17.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:08:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A68294233430; Wed, 08 Oct 2025 07:08:50 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:08:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 4/8] Documentation/rtla: rename common_timerlat_aa.rst
Message-ID: <aOWrkhlBoKDH4fRi@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-5-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UKApmRWlee9TbfyG"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-5-krishnagopi487@gmail.com>


--UKApmRWlee9TbfyG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:53AM +0530, Gopi Krishna Menon wrote:
> common_timerlat_aa.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document.
>=20
> Rename common_timerlat_aa.rst to common_timerlat_aa.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--UKApmRWlee9TbfyG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWrkgAKCRD2uYlJVVFO
o15NAP9cMZH7s50QpPUQSGh96FcYFqRpcCt7ov3hAmYqpMrSTQD/ZF0oz7pf16FU
vZKihKt7nGCu8ziutqKJOZ38dw3sEQg=
=whcv
-----END PGP SIGNATURE-----

--UKApmRWlee9TbfyG--

