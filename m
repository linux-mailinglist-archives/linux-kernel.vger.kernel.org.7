Return-Path: <linux-kernel+bounces-894340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C322C49CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65C394EF4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9382FE568;
	Mon, 10 Nov 2025 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvXUmJ7x"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEA21B196
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817920; cv=none; b=swYdjjAnVTpe/UqSZouBz6k076hQIkpdLhgVwoP/x9VrTAQBrazw22qTqEwbw4syLnFhvgVtMS6XHTKPRJnVAGMaaAVbM3Nmpd+Tfm8XG+Y4NJWyl+KQYyLT9Vb1rHI4JwXuR7duPDu2SEuRqMSUkub0hQ17LODL/guuy6I/LIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817920; c=relaxed/simple;
	bh=1BkOzUxSSedtqRPqjCFUt6WI3IiHiKYSTgbLQupojII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsMYxvIC6WhWbgHSLjkt70ZzejNXYCECkQzP8Zmrc+ZR+VS/NmglnGPypW4g67rbXtOyzrTn8vxkTRg3hGk3uByqntdjFyJLuz0D24vnpj9WkaI4eVwTDXYaCfHfinudMFGhqkun1yXnKODXZRHBwbc6oWgJsRZioblGYJfJc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvXUmJ7x; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29586626fbeso32133195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762817918; x=1763422718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BkOzUxSSedtqRPqjCFUt6WI3IiHiKYSTgbLQupojII=;
        b=UvXUmJ7x3TFDhikIkdX2moxHG3ubtVqkOYHeXcup9fwnhrc4lB8/rMriAn6mOrtI4Q
         13Pqd3Hin19usfl32931uRDBiMUvdPMiXmyWoNuIGdKlmSKQ1DtgWvZ/3YIs7bM7fidx
         hXn0ywaqTTAi/07hxvy4dcCEETtYTnDVJr72bCs7X9YABlBvx8O9pp/Jv/69qbhchG+w
         1QjFrYj8BOW+3oEJQuqV973M/4dQ2vNWXdDGelvcEZbCWvkvcBrYzc/S9xErzv542kTD
         O0OPp8DxptsT2ualHN8NZlEr2B7grg1Ogq8jx+UlGlY61+BkOVVeq/rWQ4CdXI+ieQtJ
         vtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817918; x=1763422718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BkOzUxSSedtqRPqjCFUt6WI3IiHiKYSTgbLQupojII=;
        b=MPzU4K01HPbthwiEG7qXIOmqIxd6U+qCe1Y9wXCA84ZU/ZGCffnrpiUQmNiK72J0ok
         BPZO1ft3HAktoOGpl8moga553Ow5ZY84DoSWJqKIc3gao0HX7pDJPHfklHzCx95kqB30
         FTlSrW25Om5dsoFxtUpgo6ONFtGmhL0hBkTmAWnXDhB4iVNv47AXeEd36dNr4uZyWS8S
         Wp74CDd+/uGTZphawgzEzMRMQHFQYIghvCSFMbrHgdrieqwFvciuF+eNhsT+5In1+5s6
         2BrVJ8DamMyi5xmnFBeNHc0CjLi9pXzIdqtpqa4wuJaWNMbR7gU0sMeuCiZ54H+p2res
         UgSQ==
X-Gm-Message-State: AOJu0Yx9Ldk5qkQFLAMbbvuJaBHzTxb6a1YAJVlTfRnC0/1z/PeuQdHu
	/0LJrKM7gqIR42+TlKBHffZBFT7pBk5MqN20bZSdC0IIW9nWxyVxCFod
X-Gm-Gg: ASbGncs4nALiciwcDovzd01dNGhSdCkz+boUSwOcYGs/XMHNLIjD/JuSMF2DTTFbToR
	EkiPd2zr9FWeRmUoldnAQ7MJVyVIYWN1NoGDHbiDrFY0wYUEiahcVmgG2+PM33/odrW6PUi/lZK
	smTt/XQTmiDEv91vYMCrVDvKYmg6SKEtrFcIsfHxbQ8B5B1bhBFokKwGvK+SW+TihNP0BtfHYyp
	FNzhRPB7wiLgu+TvxcGxB0xthDkq4MZ8D9lkFqLx0mtr12yu2dTghP/FU8KbpBSGY1C0wHe1cxA
	SUDbx0OR17OO4IT8B0IG1k+N4ZV+amVmMPpXBatNHXWEzaXZDYqXaVjzOp1k2bz55oA0aaCywv6
	n40lXPiMHdWC2LYXKm7qBbmtBGUYVUm+yBmAH5fWEPM61ngOm/L+Q+jQpL9wlKjJgPa80kzdCAH
	fw
X-Google-Smtp-Source: AGHT+IEi4+N5BDziRzYZppfNwadzwEcVAGlfkTK26ZrdelRRWzwfF3onPDRQ6fnIWoeut03gtLxsdA==
X-Received: by 2002:a17:903:3387:b0:295:4d97:84fc with SMTP id d9443c01a7336-297e56be1eamr90395435ad.32.1762817918122;
        Mon, 10 Nov 2025 15:38:38 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297f2d9c971sm78403165ad.55.2025.11.10.15.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:38:36 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 7C0B741D950E; Tue, 11 Nov 2025 06:38:34 +0700 (WIB)
Date: Tue, 11 Nov 2025 06:38:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net
Cc: Corey Minyard <corey@minyard.net>, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: ipmb: Indent boot time loading steps
Message-ID: <aRJ3ehfBJRWrWXzm@archie.me>
References: <20251105125449.45643-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mv2ump0qL64iQ07O"
Content-Disposition: inline
In-Reply-To: <20251105125449.45643-1-bagasdotme@gmail.com>


--Mv2ump0qL64iQ07O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Nov 05, 2025 at 07:54:49PM +0700, Bagas Sanjaya wrote:
> Steps for loading IPMB driver at boot time, written as enumerated
> sublist, is indented instead on the same level as its parent list.
> Indent them as appropriate.

review ping

--Mv2ump0qL64iQ07O
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaRJ3dAAKCRD2uYlJVVFO
ozgtAP9FBSCB6sCH2m2OzgdgvYFnDNhf4q8lD0YGD0CZMa798AD+Oa5ZvTB46NoN
+wJXKtedF9+doRDFvq87lIIDuxXTsAM=
=iucy
-----END PGP SIGNATURE-----

--Mv2ump0qL64iQ07O--

