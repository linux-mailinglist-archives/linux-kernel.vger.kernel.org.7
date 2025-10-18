Return-Path: <linux-kernel+bounces-859239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5361BBED195
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC8F64E1F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DF320296E;
	Sat, 18 Oct 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi+z+SvN"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FF153BD9
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797843; cv=none; b=dCW/wYkFSYExTtXrSkSzOX6nryu2pOxIxwd+XqE0gAzBRjyAiTut/1v235KxyEwbvWRrUfYbdTHQzyk3HFPgt6EGHE2yUm8eT7nHnhN97CgSKUpFYsPQm2grj9R975jxeG40IF5SqATwq68l9ctOEDpMDQpmTT8I6g1gW8Xlx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797843; c=relaxed/simple;
	bh=H5AzUI1YR9TrA+ShwSblAD+3OTi6tR9slfhzioJEg/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHYkc6OoUytOpv+EQhtF/4FZqkUBc7YIl7+OWgXPaG4/wccW3tprsMT32tSiQJwmemM7RB2/5mO3oa/EICPIxF/vs2hxwejBmqNUoD5U5e6b9t73PHZnmz8RVMSmuC3n22Q4kkzVp8n/ikdaL1oSfwAY/ySS0SFTFrOi+CnqQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi+z+SvN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33d7589774fso377700a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797841; x=1761402641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5AzUI1YR9TrA+ShwSblAD+3OTi6tR9slfhzioJEg/c=;
        b=Gi+z+SvNsHkZO9AAIyWP+0DeGfslFOUz69IO0fYboTt/sdoCGN3HRsHrQEFQpekhiu
         bswXiZb+xoDAzrfqIBq0I2WKq6gk1ejJ1vcRzEKvmGRK9T9gr40h+O7AeSu0UL0qP1ck
         6GxeYIito3xbM9qsmE3aRAiGqfCbcPYycV9YhbyhdP+DyxlnIiiI8J8o/EMps1ghjKTv
         cRTJdH6BCLP1gLWYZsH4x0uT3Ssyz7qKzCfd5ahUwgLuBf0uwOsm98NOmfGBjTqlecJT
         SdokDU6gbkHid5y/PeLBBomoYu+kkg0JhPhDU2YKB/gKbGOczcFWUP/Pw/hjDA6aSyND
         JaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797841; x=1761402641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5AzUI1YR9TrA+ShwSblAD+3OTi6tR9slfhzioJEg/c=;
        b=ihSLMuDtZsD46av0OZBIjObIvJWrusBa4wJSWyYoffBfS7ZR0Mqrum6EAFQsUuI9Zw
         i8z19uFe9ja+l6EwxRAd+OOWUXpjIu73y4NvI10gxuqRxhBPCZQv4MRndQL8iooFyCsp
         +r1qt8XVoolGhB96+5RHjUIhGM1u82WyST5VgF7F9OPXd/d+B6BfyRbhkoXx+Hke/VtT
         XE7VAbfa7e1HJfV4SuZ2crQcYR9qiFmJB53piOytP4eM6cXqD+WyyAIYPj/bCF8WpR1m
         RQ4XUtORogxQgM+NddcOCSl2oBS9ZCigpl3hizuX1qCrwMuk6fyZxSmn1ASNH9k8+A/J
         fAWw==
X-Forwarded-Encrypted: i=1; AJvYcCXC240Sg+Up5W/HnmKayuehe2NDKVr7387fjrtHlQbi36u4/W68FIyjaQK6116nX2tZVsFBnZ+G18elsOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGoicClE4fUEXkzaZolop65J4YKuqCIxoxCv+4k7i5SXpE+A5
	Hu6+QdNNDHzs+zSqif3qZwt0PRe0xXUS70pJ4d1x2MKAHqAfbit992IM
X-Gm-Gg: ASbGncvqIABwh5x/W+LvVU9o/nit8/1hDPH+1tn9OGrwZqjYCo+sb0l7CYO1ikoNydN
	4IhsZFUxQgyLfCq5zfTvNvHf965EL1sR4NQETqBA90Bcmph4JDbCI7RvCffCU/GSIRikRV11qL/
	8Q7P8w2OYypFbzVLhIr6P2fWVGIq82q34BULjvdob6IaIc/UKAs3kcB276hAM4qDIpBDmLRWWDk
	Ou6NfseW6HeFqqTBuA+GfC9ak1MPQWtmc4uPaRkPnRIjo/I5RPvtmFfHlfwKlOaSSxXqWrzlV+5
	ZvwazjipnenkYxKJ+8s+22pFjTHP0XoLomrjhjv38C7En20CLOL3thck7i1saNI6AdXB/hXYnca
	PhxLPJfCU1utDErYZXfnFBlMtKMbRk/v1r4DLWwbTRVXDRvB/dlQ1S/HMfOyPOkZFlSJDXO8cDo
	lYYqUu+rR/2WGl07jjq8N07+Cp
X-Google-Smtp-Source: AGHT+IHWngUQc7B5DhoG9VaMeEWADlJVoOxl/VKkyFHP2uKToZpaKxsuBioQGNTpHSbiFcVbfcshrA==
X-Received: by 2002:a17:90b:3d87:b0:33b:b020:595e with SMTP id 98e67ed59e1d1-33bcf8f78cfmr9188242a91.25.1760797841284;
        Sat, 18 Oct 2025 07:30:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bae2a4e03sm4525492a91.4.2025.10.18.07.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:30:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 560444241822; Sat, 18 Oct 2025 21:30:37 +0700 (WIB)
Date: Sat, 18 Oct 2025 21:30:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gopi Krishna Menon <krishnagopi487@gmail.com>
Subject: Re: [PATCH] Documentation/rtla: rename common_xxx.rst files to
 common_xxx.txt
Message-ID: <aPOkjdKXDKeIIsCE@archie.me>
References: <20251013092719.30780-2-bagasdotme@gmail.com>
 <87zf9pz33e.fsf@trenco.lwn.net>
 <aPMqTSbPucoqNhA1@archie.me>
 <87v7kcz3yl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybs29haJIQVP26Hi"
Content-Disposition: inline
In-Reply-To: <87v7kcz3yl.fsf@trenco.lwn.net>


--ybs29haJIQVP26Hi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 08:20:34AM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > Shouldn't this more appropriate as a fix for current cycle (6.18)? I see
> > the warnings on Linus's tree, though.
>=20
> As a general rule, I don't see warning fixes as being important enough
> to send outside of the merge window; the next cycle isn't that far away.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--ybs29haJIQVP26Hi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPOkhwAKCRD2uYlJVVFO
o3NPAQDfJXtSqbwM4/sAhpfkKAvqBkJII1d9MZNDlAgwoiq+qAEAnu2ndfw7w1wu
QyJdeJuxkPc2xpzvRc3YXL3d0wwuQAU=
=jsrl
-----END PGP SIGNATURE-----

--ybs29haJIQVP26Hi--

