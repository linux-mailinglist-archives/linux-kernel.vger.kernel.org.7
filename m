Return-Path: <linux-kernel+bounces-720989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D47AFC307
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EF5164550
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5347221FB5;
	Tue,  8 Jul 2025 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="W8RwA7Nl"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDEE221D87
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957044; cv=none; b=Y+CyKT5LDM4wuqP0e9+Bdu4ErxlU1pE7NfXBwVeRHNV7Urjg7wwqpsuca9UM9GXG8/SPdwYaAHjC3RvFu3iI4xKywO0ZRClO85lvQ7H5xBHjqzjvVUiZDdRikbjQGZ4osvtitIY8qET8z70nKn1j5aOLu/iDk2o5ccMmp2B/E3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957044; c=relaxed/simple;
	bh=VwcmJ/ZhvGTQZtfzPShfeClIbetsIVYAmTNQ+zOrI/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7sIQd07nYMTRjYHQBj0RPYHqnfxk+oI4JF0Vsbi4AsbFMsIp93CkK9F6upWj2vaKgeZDpTBFHCibrxTxAHNTz57Yh8B5dachUjH1ZV+hVUyu/i5T9CgySJwSpwpiNOu7xlp0Szj9+DUCMrnWfF5NWayFgcQQrLvhQo0v9xJlSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=W8RwA7Nl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b3316160so4682468e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1751957040; x=1752561840; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwcmJ/ZhvGTQZtfzPShfeClIbetsIVYAmTNQ+zOrI/Q=;
        b=W8RwA7NlpO7O2p6czkNsNu4slM6IhviQmFwW3pUq696RLuOQ2QKcIzQVFTgCLVFraG
         jAAsOO33Xr6aJUSmB+re1QPDnNH2TqzOaOuS57MbwKjooIU8iBNuQ7Dg5BmFQysA5+19
         Nn36YCwSqD06S3lMpvch8j/2sKf8+/K8rmbu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751957040; x=1752561840;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwcmJ/ZhvGTQZtfzPShfeClIbetsIVYAmTNQ+zOrI/Q=;
        b=jvmw9CeqgoTmo5DzvH6mE0pji3YFy9WysM0RJKQjg/8mH8peEva/iO0nfzb9aL64qJ
         Q+PLgwrCO5HDWScair1JmxJGSWxssy8YoF9FDihvdpJoMxW30lCmHkGDsFinl3Bbv7BK
         Zd5xb94uJcOFTeNPYLgPk3A2Ujqjto68G/wYWTa+K6yqXhqzZzwd7fN1CRKMG8XqIjKM
         ecuiV8YxWLx3pMvxi7FnDftwyx0iw0TbhkjNah1Oao8Ka3a+2+2lNwhvVwTqQWtY8S2C
         gd6aww8ZjmqFI2lxZIKvpDS08N7uRcLIHruKvzcbqeWJVG3eK1mDk6yTnDsuGKbpLVsT
         WZCg==
X-Forwarded-Encrypted: i=1; AJvYcCUsRN/nyOi0+kZWsctZoeLbv5b4ZgFrsX8YKk7ivnZ0FApAOuQEJFRp1GWDHc2Ypc9+GxaPfzAhG+WiOxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrlgmcGaDWAUOMZvpZViNVRjtxsRfjo0uEh3G3rSZNzvBhkki
	62sSujCP70FIMiHd7oHfjEHmTBx9XyR7MZLFI7cvW6MJIM1QoGHQ8K8cQZew+rkuO4g=
X-Gm-Gg: ASbGncsHpsc1927IBU7XrhWj16ukoPY3pTQbpLoNaxo04e/l7dnYI8fbdaplBRehIj1
	22ymQVu1LxXxnom2ANSc9NmJpqf5nBgylvtup/3RRFoXJfCKA5gV1A66hbACPgC9QYwhD5ORuoW
	Ym8xtWGWSvyz7iyObaNaxlxKqYVOiJz7hCyOLiVVsKyiABVc460+/wFHeTWnVr61owM+45b5slA
	En0GRHYdVNPLW768IpbtMDuCWlwaPjRiBTAODICOknsEGXUBDyBRCn/k4C6MP3I1VeMGL9Iqe2j
	1s5BZw52a1r9xisFLUrd3EwdNDEPwI033WVrmT5h+ZcDgi6KD5cT81E6BgIQB6US
X-Google-Smtp-Source: AGHT+IGLpwW1oPOTvsZefKXTXlcktttg7ftS+Us6Recfkko3XFC9QR7DbsdqK2cC4ebFUT2MmTV7PQ==
X-Received: by 2002:a05:6512:230f:b0:553:388a:e794 with SMTP id 2adb3069b0e04-557a19df4f8mr5244040e87.17.1751957040069;
        Mon, 07 Jul 2025 23:44:00 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-32e1af83038sm14820851fa.14.2025.07.07.23.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:43:59 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org,  linux-hardening@vger.kernel.org,  Kees Cook
 <kees@kernel.org>,  Christopher Bazley <chris.bazley.wg14@gmail.com>,
  shadow <~hallyn/shadow@lists.sr.ht>,  linux-kernel@vger.kernel.org,
  Andrew Morton <akpm@linux-foundation.org>,  kasan-dev@googlegroups.com,
  Dmitry Vyukov <dvyukov@google.com>,  Alexander Potapenko
 <glider@google.com>,  Marco Elver <elver@google.com>,  Christoph Lameter
 <cl@linux.com>,  David Rientjes <rientjes@google.com>,  Vlastimil Babka
 <vbabka@suse.cz>,  Roman Gushchin <roman.gushchin@linux.dev>,  Harry Yoo
 <harry.yoo@oracle.com>
Subject: Re: [RFC v1 0/3] Add and use seprintf() instead of less ergonomic APIs
In-Reply-To: <cover.1751747518.git.alx@kernel.org> (Alejandro Colomar's
	message of "Sat, 5 Jul 2025 22:33:47 +0200")
References: <cover.1751747518.git.alx@kernel.org>
Date: Tue, 08 Jul 2025 08:43:57 +0200
Message-ID: <87a55fw5aq.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 05 2025, Alejandro Colomar <alx@kernel.org> wrote:

> On top of that, I have a question about the functions I'm adding,
> and the existing kernel snprintf(3): The standard snprintf(3)
> can fail (return -1), but the kernel one doesn't seem to return <0 ever.
> Should I assume that snprintf(3) doesn't fail here?

Yes. Just because the standard says it may return an error, as a QoI
thing the kernel's implementation never fails. That also means that we
do not ever do memory allocation or similar in the guts of vsnsprintf
(that would anyway be a mine field of locking bugs).

If we hit some invalid or unsupported format specifier (i.e. a bug in
the caller), we return early, but still report what we wrote until
hitting that.

Rasmus

