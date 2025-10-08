Return-Path: <linux-kernel+bounces-844908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DBBBC308B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17193A2867
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A761B1A3164;
	Wed,  8 Oct 2025 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQePr3PH"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70C10F2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882222; cv=none; b=FGyPDIUjzmFvWx8pSnQZixBFnaxodO/Crc5sCxAB2BpWGcyivl2NGTTS5cp7D+JekNNTm1Mzt5e3UZxONNHo678ahzzV1aKc52W2aji9NCjYNSpCWar8Dl1R0mc5wcu8Xpf0K1YQFxvwqCmB4x9bS0Un2iDyKtr8pvdmGlkNCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882222; c=relaxed/simple;
	bh=drQLTEcf0s9aDQXkyASHEbZdCPNdt5PbIV0XIqvxYGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jds4BKS1AflpH8FTHQJbrQBzZFZLpV/OpKDIAodkQS5kR9aGORz0ZcqEX1iFItarg8YKAk0yzclS9umYrT/KvXJA4ykbEzuHV5PBtQ57uZjp10SyhtufMH8pUMSe6P1MmX5PvBxK6Q+DqGJ1WPm/WD0kLr1QW93D4CTJ9WRca1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQePr3PH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-269af38418aso82438075ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882220; x=1760487020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=drQLTEcf0s9aDQXkyASHEbZdCPNdt5PbIV0XIqvxYGw=;
        b=dQePr3PH9dxlxO+TCuwqGtwrGTndkebpOdifkUngwvjgw4Gq2Yr5vPJ7M5S6ITkOgV
         AXAZ/THC0sU65WsXx95TpzTXl+8Ma+U06Jz4aUWto+pOso+nTcOOpZsh7ItWiNl08L+w
         g/c7okkaLRcsuzqwWO5EArWriyigXNLpWuzoWqBKgaq1NkZQFfm50+rQfTn3W1q8O1Tz
         /YN4oLVuzy3CjFaM670gqnlb6O6+nhUQcaSuq3KxRS0NHkLO9g+EFFQmpkBtvAM7d23U
         DAgN50mzQYXyQawtfZO+0FksxXH3wrKiIVp6WL8FRwQmVhdugwIBBWIUZ8R1NIiAc0LW
         Fksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882220; x=1760487020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drQLTEcf0s9aDQXkyASHEbZdCPNdt5PbIV0XIqvxYGw=;
        b=TzR52DSzw+yNxpnllBXxSzeS9PKSgfSHWi7CONsDAWiE0aqZb6vRgPpERdgtPsF+uc
         U+oIbfc4eJtuECdwvMOjHJRuBOfzDVhUEiCdunhl7n0brO6ExYRprKKlQIHMntZ2zdas
         2sxXEfmKk68MXh/JboJObyPsT8uzrruUbiqJPzZzWd5b4u1veDoEpkHEfF0DVLEA50gH
         bgFo6O/CEqweBP/tFN9zqnOTPSuXNIt6h/VUSoYK66qmMVnT0Ld3QMmmBX1a9gc0IkE+
         nHTQJHEGyWxhDtWkB5EFyiHJs72u3lHqrZCqW95O18h/pFJKU0aWFn6aS6hLYz+tIDR9
         aM5w==
X-Forwarded-Encrypted: i=1; AJvYcCW5MP8ni0nBCt5lKRUsEYGf7WlehBTZmCSs7+JkDj/9ctDpnay/8svuUe8Sd5CM5EXTk0AogaEN+D0O4OA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86DHCRFSzbhDF4rLKpqz0Mr2bcMJXVuZCszgD/spWdudl1JRE
	+8nJC+rmE9+5hS6G49MyFkFrTFdYVJ/8QsI2+4HBXyzs2pKK0hjCcp/a
X-Gm-Gg: ASbGnctcI9VtUpJWhth3OUeUUCjjNDBjnKzUQdob6wMqsmBgrWS0kop6hDPxrt+uIiA
	VugeBAF8atDM8BRd6E1FUdOW6xEz0ptZNcDGoN2Jn9uVSnuTDzPoJnul1sv62IxaLs1nSsjIJdz
	5jUnI69F1fbyMjoi4LwnDK1hEYn3V7iK7NbDOY93G+AHh1XQ6Gxyr4WH2AnHF+eidveFSFZb5m2
	47HM7dgMel/Mw0frIfE2i2rzAAuK+HI9asqxm+zLblIOuxxFeT5FXOPon6FEjhB1GY9H99gvUk0
	UlvUivgWwLMQqICyRJOsI0V7CXwdliU0TvxzW9rXizApsyJoW2Uj3jObrwKaEkOS5VMvl6YE+7+
	yFkkeSmccS6zckCDNY3mn4E/fbE00ep//4UjnubKh1RrpxOHkfw==
X-Google-Smtp-Source: AGHT+IESzqjvqNWRLBhUSfgdQA0DbNktIOO7T7mo7zBI5D4i2rQuwbdLk49P2ILdFhIuxAbr8RriAg==
X-Received: by 2002:a17:902:ef4e:b0:28d:190a:1913 with SMTP id d9443c01a7336-290273edfcemr19418575ad.38.1759882219780;
        Tue, 07 Oct 2025 17:10:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e9cbff2a9sm147087985ad.32.2025.10.07.17.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:10:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E747D4233430; Wed, 08 Oct 2025 07:10:16 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:10:16 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 6/8] Documentation/rtla: rename
 common_timerlat_options.rst
Message-ID: <aOWr6Ga_UzUsPfoi@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-7-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LlIS5/VYPbtMmilJ"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-7-krishnagopi487@gmail.com>


--LlIS5/VYPbtMmilJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:55AM +0530, Gopi Krishna Menon wrote:
> common_timerlat_options.rst is intended to be included by other rtla
> documents and is not meant to be built as a standalone document.
>=20
> Rename common_timerlat_options.rst to common_timerlat_options.txt to
> maintain consistency with other common_*.txt files and prevent Sphinx
> from building it as a standalone document. Update all include references
> accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--LlIS5/VYPbtMmilJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWr6AAKCRD2uYlJVVFO
oxP5AP98xFQWDMEDF9qmYQ0B2Wtvoh8Q9kx1bnbfFDCX6IqjJQEAk+h5fDL4OXEc
i5PQIL+OKPTBIi+wbjKY+z5qbTgraAA=
=XW3K
-----END PGP SIGNATURE-----

--LlIS5/VYPbtMmilJ--

