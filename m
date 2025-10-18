Return-Path: <linux-kernel+bounces-859096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B54BABECC57
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 401D6350470
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA63288C2B;
	Sat, 18 Oct 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYnUeqjx"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B928369D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779279; cv=none; b=oteg4+gQ/jCqGhP0bApkuIwZkZJ/BByoZCJdbhbky+T4a4L/AadxT2sXdnMtEx4W+rSDbhqiTWwYEXg3sIGZi002Sqm9Ri02lnEgUuM4pCWzEuBCDE9wN40Ud8kratFJX6qn9SmXcxzttI2HL2a0GuT7++5lk4aBKL7s4QIRRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779279; c=relaxed/simple;
	bh=0Jpj0J+HGWlxpgEJDxw18icymMillm7q98N+m9wVbfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yorq6wVHl25EHfOmOb2pLxgOIpOoxn2hPcIypx+JuKFCiFrc1j/+Ee2pFbYDIQbW+h8WORtMj1kqNirafiTh9dPP/XbAAgjgoGinkIM5XLKoxFxmlvioU0D/Qs8dWLbKt4cHJs3awmPvPN7YqIKokUjH70j99gOJAD1G6R+J75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYnUeqjx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27ee41e074dso32724455ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760779277; x=1761384077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jpj0J+HGWlxpgEJDxw18icymMillm7q98N+m9wVbfg=;
        b=hYnUeqjxWo7gqKq4rs/x3BBTM9yb5nsdo9cHcc59dneoIjgUY9Yv9t74rG02ZGWE4f
         w0dj6Gr1Li++jPHEKCMohqDAsWvm/NX6JWFjt3hO9YI6CsKz9cxs8AV+Y8TlfLLb+iu5
         1OWn6X/oqBmZSE3a98aYTBgXO+B3nlPmB4D0ZLqW827UzsZTtOsG2fhhr+Uo+RntWCGD
         AEVeM8Hpd+p3NNfKOZQNiR8KkR7LA2rmfMgJ8oozpL9FPyvhyiStztQu6f44xSdKJicH
         FuD+qi1nRkctW30oPsNkSQgB4qPz9vklD+5hp9lu8KE3h0mDVIhpID8IJc8D1C9wV57z
         5RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779277; x=1761384077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Jpj0J+HGWlxpgEJDxw18icymMillm7q98N+m9wVbfg=;
        b=u7aDsboI5mP4BX9tNctEmqdqRz0zreWeoV2rKX30obupf8s5tBTo4+ZRN2eFzsx0Qi
         1YqLM20LrI+NDL7jlOk/qjSRoaoyst/pS0DKrXJUYaBnq40VzRdtmpF6ADKOtz/D2pC6
         3Drc9ZboGtV5/QvMR1kFsbIMAtFGGryotqqhVu5SuV6ZbZmJvT43Uh7aYDLXuTXyvZ9U
         2kh7r5zJB2Mw3CyIKJM8jQjVbxv7UTym37tT9vZtAo4z2xaTZ2allJ643q4TGitUHb+i
         NrQOozSLRuCSBHk1BDWLNXoiczDv2kXvqaWUgtdio9pDtw/I5Mv2LlxAy4I5D7GtaqtW
         KTvg==
X-Forwarded-Encrypted: i=1; AJvYcCX0f8NWFCzkyDdjfaYGctB8qDd5rDTi/dgjbVJB5LPetq6uvSfA0K1HzyQWGwVJzG++60w5F7qDWGShMV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvCEvlbbz0ydW792b5q+YygJ1Xi0WXS9+x1j7Stm9mMiFVXxmz
	OlrBe0/n7x4fQVFk89Q1w0rtl3haraVS9Vs/v2CICR+ejaSRC4UvyKbSpbQdyhYAGhtFNAOAp32
	7aLpMoA3SNqeS+hXigmH+WdqXMD5yIEA=
X-Gm-Gg: ASbGnctBohVTsHKXUjfwzrOSdvU3fISByqpSt5KoXsNnvRyKFDdJ2yrlaFtMKdIITxj
	axN0Nk6WM+3kMyyEL8oc1Sf9ULPrc0UMNXZTWnzKpHQcJiRI8kzcqLzwXYNciW+cmWCQ8xZk/g4
	eAELg8vMyJAJcpARNafpjuGhlK8VZXRlh2cOnkjze/SZkE6fToYBDuhsPNLJCPHbSxWir3xH44C
	sfDs4RXvyCBSU1ukB690wLBAzYlEuH/zkw9egDkN/SDuoTPVQTtzYYBwIklebQAeoPS7z7txhQ0
	2Q7JoVy4Ajy+vqTbT//Irc0kzkb9zmF6n67vjccblBjwkcfKOOfE/Pvzrsd49SHxc+PI04/qbMo
	f
X-Google-Smtp-Source: AGHT+IGV8TX8jiCj1BUJV+Bf4OxHN2PehH7nfk19H5odslvr7a563qqnctR0uh1y3bJRDSwhnrdxOY6MvlqMN5zT7Dg=
X-Received: by 2002:a17:903:4b07:b0:288:5d07:8a8f with SMTP id
 d9443c01a7336-290c9cd4b60mr68649255ad.24.1760779276996; Sat, 18 Oct 2025
 02:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913105252.26886-1-opensource206@gmail.com>
 <CAKPKb882DgYB2fZXRDU_y1Xqz6GtFEErvzzET9eOAm=db0ns1g@mail.gmail.com>
 <873C85C5-2BCB-4631-BA18-919CE448A7CE@collabora.com> <CAKPKb88VHwGp-iLMa=zZy3Czq8S8wUd9Zzkicvd4er9OiLg6UQ@mail.gmail.com>
 <8AB96B5A-1A80-4A8F-AE8B-787FF71C5A75@collabora.com>
In-Reply-To: <8AB96B5A-1A80-4A8F-AE8B-787FF71C5A75@collabora.com>
From: opensource india <opensource206@gmail.com>
Date: Sat, 18 Oct 2025 14:51:05 +0530
X-Gm-Features: AS18NWD1XKeTKZ31jaRbMn0R_taPKCa1cnrjUYA4av8AH5zKwOnKC7AcJP8OgyA
Message-ID: <CAKPKb89PJqFr5UTw0C7pQMncm+ZzskQew+mn6p7tXgTNXvEWEQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: v4l2-ctrls: add full AV1 profile validation in validate_av1_sequence()
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: mchehab@kernel.org, hverkuil@kernel.org, ribalda@chromium.org, 
	laurent.pinchart@ideasonboard.com, yunkec@google.com, 
	sakari.ailus@linux.intel.com, james.cowgill@blaize.com, hansg@kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 7:20=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
>
> > On 7 Oct 2025, at 07:50, opensource india <opensource206@gmail.com> wro=
te:
> >
> > On Sat, Sep 27, 2025 at 2:27=E2=80=AFPM Daniel Almeida
> > <daniel.almeida@collabora.com> wrote:
> >>
> >> Hi, I=E2=80=99ll review this in the coming weeks.
> >
> > Hi Daneil, did you get a chance to review this?
> >
>
> Not yet.
>
> =E2=80=94 Daniel

Hi Daniel, is it possible for you to review this in the coming couple of we=
eks?

