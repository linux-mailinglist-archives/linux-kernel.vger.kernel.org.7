Return-Path: <linux-kernel+bounces-844907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F073FBC3082
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B7D19E00F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087F19AD70;
	Wed,  8 Oct 2025 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7rFcjW6"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638F17BED0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882179; cv=none; b=f9zcRjeyLw0/LtghVJdaCBWVVMqqzt31wiHhYwIUX4nrgrWX438TbjQcEOTFkGth81PthLN9nWTmvhv9mrKt1+OedNRLE7IGL8UdCDkMmnkEJznqYKY/6sBD0ZoCwwFYl9scVkFKqo2lImwcDY8o608CgRA6otJdRML/p0V+N3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882179; c=relaxed/simple;
	bh=SiqBsvlUVBV9X2tD7iHdB7FMlNgyz+EJDz9g/wHLMx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEJTyzs9PdsRJfTEKNsm/xrEuPrljsNmW13wtQC9nWQmOhW0SnoeeP7tEE1vI0eBGa6/biK9PQxGGIEmcoDAwfB486GMyMAXv7CLASd3OjyKoNtxViTDISJECJFzzUA/2pcO8xeKd98/KxsIEJysjAUbupAARWLSdGlU5ktYsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7rFcjW6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f1f29a551so8746248b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882176; x=1760486976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SiqBsvlUVBV9X2tD7iHdB7FMlNgyz+EJDz9g/wHLMx0=;
        b=a7rFcjW6r7uDt3uV3PmBelfsOSHGwAHATvEJXxATW+XYosSTKq5AGyirIGO+QdQPDZ
         6vQUrIqZu/l4jMVDiytw6HqVMWmdLJVsf1H3Y7ZGOXTIudixJTz3/lFQsUCKuzPW1tRY
         O3GX8NiiJHkE24LywVW0VHheuriOA30oZfMzoHvZf4AM6HAiMibmyjbIylPaO57ku6iI
         Jb0J5jTN7l06hRGFqACvKK701qRvDM18ttZ5raUoo9KvdDm/8sYUKpeuLRFUYyfsNLGp
         7ILVQ//bgEOSiphPsulS0zA0G8ibFRUmXwnbToG7N9rRrOs3qded4YeoTbN0TRic5wtj
         NC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882176; x=1760486976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiqBsvlUVBV9X2tD7iHdB7FMlNgyz+EJDz9g/wHLMx0=;
        b=W/+f7Vx9ZNqmyWyCMn9En4QodebjiFWcoxX7hYhI9A5c8ce+yq0kjFU9pibFBnxyD7
         zFWAS8PNJ+oiZtd/KbIPXAl9RrP4U0IiyVcV9C5JhdKg2x4+8P2XLQoHDlR2l4sQ5X8s
         Rg3VsXYyAvhiCKCoRu/ji3kzfax7DLg3a5Dqagpk1p24VSYZiQOQIMkG51InhpkuILzd
         v+XjnSo1iwCMtc55Gx5/jIES315OqCAesTpEMcvVJu/y0bItlH+r9x9/HE8PzRNuYnP2
         dsG8mafVG9c2QUZUxJHQ+pS4DHpYMasgQnULny/NA8m7qzaymA87k0JH5A/whPgEO8PQ
         KcjA==
X-Forwarded-Encrypted: i=1; AJvYcCV3pQ4gX/PWTi8qXTzCuqAWuI2q0/he4yfjUVSuEmlPvmksaRBrFK7tOKzMKlyIQos2GrNEc/TxWabu5qI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8lB7n/ozKYEnLLq4nCdz0fgOq+5DiE5KQ4hSR3EouDXBZBg8
	Zr2jbzOmiGLfE4a1S9p5nUewuP5s4cdqUKwsd8Ea51cFlEf+k1gwmr3J
X-Gm-Gg: ASbGncvjImd2pMYBmziiZFAvk/zxo9pvSg4aprocLCWywvLlL6fbIOvGC/xAP2mYMbf
	kpQtenGivPhEnlvczmfmu1hoO/2iaPqVyAAQE5WWiGXkFu49iP53AQatKt7rgE4PAwhz0znZk5R
	9gcjRpT13jMMd9HDYL6fq57RBON/xwJFHouiS1iV/Uk3D47tQg5JSLuAWrNK08GztrQtr8BNjMn
	VcUbMwDZgZ01FlZ7Lw/EYh9GzR0EL+5+424r8KpX4MT4Qt8fGbkWY/+zCWxDFj/kCpyuESI49Ng
	1AQVXstz9yvM+oDaRBx36aQSZLWCeFxQyxQHh2j6sLM4ghIsB8CLb329FbMsctWiFjhlwQ84uJb
	550UNy052JHkqL+EYmMQK1uGAcDRpxqefksGcQlW0x8rluA3VVw==
X-Google-Smtp-Source: AGHT+IEHG1de0uoqO9lTHMhoFoIvSH90FZPEhO4rUV9YGSfs1T4dWZ9gPM/Xr/7y7qCcN9U5mlfWcg==
X-Received: by 2002:a05:6a00:80c:b0:782:5ca1:e1c with SMTP id d2e1a72fcca58-7938723daa6mr1650070b3a.21.1759882175592;
        Tue, 07 Oct 2025 17:09:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020535a7sm16838884b3a.54.2025.10.07.17.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:09:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F13204233430; Wed, 08 Oct 2025 07:09:32 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:09:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 5/8] Documentation/rtla: rename
 common_timerlat_description.rst
Message-ID: <aOWrvAA6AO27pI6_@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-6-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="II6TKWeT/WeCoHc0"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-6-krishnagopi487@gmail.com>


--II6TKWeT/WeCoHc0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:54AM +0530, Gopi Krishna Menon wrote:
> common_timerlat_description.rst is intended to be included by other rtla
> documents and is not meant to be built as a standalone document.
>=20
> Rename common_timerlat_description.rst to
> common_timerlat_description.txt to maintain consistency with other
> common_*.txt files and prevent Sphinx from building it as a standalone
> document. Update all include references accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--II6TKWeT/WeCoHc0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWrvAAKCRD2uYlJVVFO
o4FmAP9/w4MDtIyaMU+Ss/owPly7TFCYgH/WICY1CZthinPMBwEAzV1VA3ObJgkL
f0XErbJOut5p53OZ7XcUvsO9/0GmNQg=
=4qSZ
-----END PGP SIGNATURE-----

--II6TKWeT/WeCoHc0--

