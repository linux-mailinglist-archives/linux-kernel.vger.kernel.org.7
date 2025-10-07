Return-Path: <linux-kernel+bounces-844267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61EBC169D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979AF189CA19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A372DFA31;
	Tue,  7 Oct 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj/LfUBT"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15802DF3E7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841487; cv=none; b=UFwHsxwCPPCYBNAogpK8Fy+Ae8G/6obTER9K0FTzj5shS8etTLjXS9neCZ065g96Ps96mIALxPJFezNY5HwqLvbxkGmANPHQmq0s/eSB36bftYWqzpOD9jX75G5Z45TqtzKFivQdprA84wMknThi8EiQRKtgSqiHm9wWFYe89fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841487; c=relaxed/simple;
	bh=Cva8F6I6vC8G5UAuRvxmhYK0EkV6IdIuOcxrR7JOX88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHZBH1mYVX0nRsITJUY1ifyIFbZgerP3dsXGqwu58b5J19AUVnBo0vHC3PgyQmfqrryXSLxvvrAuPl+4YNkwKc0bRweNM2gwn0dgfNxGsY4cU+0+C57hwGCdgLpwOXoEFvI1SdB2wVQ5/bAhN8+1CRgvwmZodUYXjERLPy2HQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj/LfUBT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27edcbcd158so80654025ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759841485; x=1760446285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cva8F6I6vC8G5UAuRvxmhYK0EkV6IdIuOcxrR7JOX88=;
        b=Oj/LfUBTKsgzoVoXOkEUIsvOmfq687BCB/dCoQn1tFxHBK+IrXkIf3oBm26//bDOCP
         O27Usl0eynLvoWBNFeLaFTMcyd6V1Zcs3LG6UB2kV5QGZUzo3IccwYjH3BfvX62uogz2
         crHnP9z75KnpoB4lv3e0JLoLHxKG1ojqVbAvlIZZas0l86j3wLvFhnd69IpCMXOBTeTK
         msJ+6j1K8Tsbug34YWAgLblZa9jdkOpqV3pOiUI10uNVOTpvHWEZh8nd4v0NeGtwa9vy
         0yQcKODNJRws3SEDyKaDAhNq5HX6rYeGEA9XHm2b1ix6g/gHTq2goqjAj/ly59utH/WD
         i0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841485; x=1760446285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cva8F6I6vC8G5UAuRvxmhYK0EkV6IdIuOcxrR7JOX88=;
        b=RzrXL8vhIhBq2dQ2LEMeCM0wqr6j/uQZxaNY8q18YEPklC4OiPHVgUi3ewBlY4p4XB
         XPlGgZR4bnp3tXlXn+6adpSFO5LwEC2wH3lj2ReLAttreZJ2jhqmjysBKAKInvhHY5fi
         v9C+dqqkYgIUfaTBoHaFNj3/6fzwHu34g9YYVhr+FXOhn0k3TtCos8TzTQQHGM0iFXt7
         LVOpATOR5I32XypEcNrmbg6PDOMcYZnpEz72GfvDFqaAeRFUzo5w3bXOplZze7AcXSeS
         Btmq/m+Zm0cZtA8H+G4DLNwLyWEn9M9Jw1XXLzmN2IrwUB08qQmCywLpJEiizC+DSf7I
         EsYA==
X-Forwarded-Encrypted: i=1; AJvYcCWB6Eh5Hahg8nwee/fJgXR3CEuQCFCdHmT3z9BsM0pbDGf0zTR3cbezI69FLjvMvaSchlRx9ULucd/yO1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZ0yygYl01/fzIo0g9Gal5KjmiTVCQZkxGjI0rKRJc1NphML0
	PzuE+y9dMp/yS4I6ZUhZ8TbUDW7ZorkzH0SJMZhSsJWSUFWMIxSvs1Ir
X-Gm-Gg: ASbGnct+F/4WQe9SXraOkfN/SEe1D9VCqr630xuNAiVhbc9Xsus2WBPAukQLTrfFRmY
	ZVxhlYMDcOlS/95bWCnJXaXet0CKxOw9sp96sZqNhCsHxxZkDotP7zOide0iWjJhYLScoU1aliS
	BX1umzVTL1A+SOE6ZfiHwIK3aVrc9ocOUQBoZcqEfAikGLPPBJ0hSgPgXtqEc0MgwN03zLawuAZ
	YFA4jjuM7WU1GqeHeNr0re1BGYwPmdImU0RwT9mv6z5UexY8cuXTaJfcAiHaYaGhSYlJk/pL1zw
	At/QswbwaB+wT18Q2W3CHVVhUUl+yKane5D/koUZPZAXFOW0Yp3ydvxWHcQuQPtqN0E9QPnKxpv
	oe1QEi/QneQKofV2TpD4vBqsqUUoiTpgb64A0ISxdzgUoAghF7w==
X-Google-Smtp-Source: AGHT+IFTrYmtFtu6V1DCF12R/dF1cAY3Dw1DuL07n3gmGJkW3ViP+is1CMwAjywaqv3EDHY01fPzPw==
X-Received: by 2002:a17:903:4b08:b0:27e:f06b:ae43 with SMTP id d9443c01a7336-28e9a649321mr194985855ad.53.1759841484702;
        Tue, 07 Oct 2025 05:51:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125e9fsm164605965ad.36.2025.10.07.05.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:51:23 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6C85F4233431; Tue, 07 Oct 2025 19:51:20 +0700 (WIB)
Date: Tue, 7 Oct 2025 19:51:20 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Crystal Wood <crwood@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] Documentation/rtla: fix htmldocs build error by renaming
 common_options.rst
Message-ID: <aOUMyGvkibvOV0IS@archie.me>
References: <20251007083228.17319-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqWyVnMMiWmFfUQE"
Content-Disposition: inline
In-Reply-To: <20251007083228.17319-1-krishnagopi487@gmail.com>


--aqWyVnMMiWmFfUQE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 02:02:26PM +0530, Gopi Krishna Menon wrote:
> Running "make htmldocs" generates the following build errors for
> common_options.rst
>=20
> Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitu=
tion referenced: "threshold".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "tool".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "thresharg".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitu=
tion referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitu=
tion referenced: "actionsperf".
> Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substit=
ution referenced: "tool".
>=20
> common_options.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document. It contains
> substitutions that are only resolved by other documents, so building it
> independently results in 'undefined substitution referenced' errors.
>=20
> Rename common_options.rst to common_options.txt to prevent Sphinx from
> building it as a standalone document and update the include references
> accordingly.

Fixes: 05b7e10687c6 ("tools/rtla: Add remaining support for osnoise actions=
")

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--aqWyVnMMiWmFfUQE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOUMxAAKCRD2uYlJVVFO
o3YeAP9WdHh/AKliEi1H/a68qdAmPGP1E8E/I+1Uax3Rh/iTnAEAtEZNoEUlrDTD
kmIkMjKutwIPwYQG3Yr/miznYMlg1gQ=
=R3wE
-----END PGP SIGNATURE-----

--aqWyVnMMiWmFfUQE--

