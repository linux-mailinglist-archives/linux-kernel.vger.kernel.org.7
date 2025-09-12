Return-Path: <linux-kernel+bounces-813434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA09B5455A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C38B61103
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE792D7DEF;
	Fri, 12 Sep 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsWZYBBa"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5F2D6E56
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665677; cv=none; b=Jd+7b/y07z8ZWerKqx/ucAj/R+yU5t7Zk99CegCzcbtAGmMX1yyR2NhYfqxFg8Wcrk8yYqciPjB3FjjZwmW1/9qdpXFefXEUgkZmfR8cfGyQn90H11dbXo6FuaRzIgEIht0DnxkL9X5Bbi3ooByk6eAijVvZBNcyxwsrZ33+IPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665677; c=relaxed/simple;
	bh=gyafARm2+5+HraSg62syFphF8W9ftxH5KWVkzqAeKV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPHCiwlGGI1tJR04DyOTaek2EaBYrapRTGWsOKacCSmlo0Yv2igZxcfR6tnLlpxX5aQAfACueDx3Rc0HaBJi/3WDdKMTjsKZV4ciY0xcPcC+wCOTnSaoJH5mazR5OACUCYGxg9czTgPMP/eB9GqgSsF4saJyi4G6gfGM7/j/vdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsWZYBBa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-25c99c2aa12so1315405ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757665675; x=1758270475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyafARm2+5+HraSg62syFphF8W9ftxH5KWVkzqAeKV4=;
        b=nsWZYBBaUNHzrN6FP4KdFo1Am/18J4tSRrl71pXa9B537UYPi8CBsuqjqif4UdFJAC
         97it5gZTE/iwrmAiuQnrnIcYthEzA6Elertol2jRC0mDyOT9Ek1ZOtc0UdDoHxOnOCo0
         4M3rb1pRe+VO7HxFicxULy+hWxXt2EHk04vKJ3VYIXRpBKveyp+5tR54vwS8NPPgUcOR
         umKrdLcqW0sHrq4CHroJCgTON+rAg6OQMY9INxaxpv1bZkPeJfo1S7zaWTMNPdbA0gFE
         DsNBH0iwycZH+1lGHcCv8Awvgb1fVF30iCQxHBCq+HknGpoT8JX5otw3JJgEr5nZekC+
         XcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665675; x=1758270475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyafARm2+5+HraSg62syFphF8W9ftxH5KWVkzqAeKV4=;
        b=kg/2uY3xCuhIfjuPbitssjEnPlwpUX61kEct3MrsnIjf4oKylUy4EcNiwqoKv+H0z9
         MaB7oSm6OtM87zc85o5+8yYSOhgRUM83A5/fG8bv9DlZpzDla6qp6zmNKyceb/edU4Kj
         cztibrnTJYqElEIqDcd6uR6NHvempqjtPacN1nHAKvCpkNcfkaL0OXPZtEeumaq2ilQ9
         1Joave78sZ96bmW109TLwqUDyCje3rW/aqKmAeGX02AEHsSXYeFatfVHCVmX2arIVCau
         ZH2a+mvTdOu9O/1ij7njWrONjdfl5H++WzPj31FAhcv4celPOVAzA0qP/07G3rfwPp9R
         h6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUSzciAdl9fj6AU+HYhUPakXSKaNHd6MNyU9hc7i5v1ntqm153VoMhfLEl2bNfpQa4571hSD85HGis0WuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNUvITH59zsEQX9nVnAUpF3ClGDGSlk4pAPf7VAvUra4mK7YHK
	AjffqLK+jmvv9hsKlDMHonqe52VrZVH7w8Mk5YpoTWyEVWgajGaIIce/xAez7NMbRyT4kl7YIZH
	WNYjmiOcJhSb1wT8t5mB+B5C8H9wE6A0=
X-Gm-Gg: ASbGnctO/lY1tHn6CgYeXk1MUtPDL4splKatzB4LhifV63DmS7uJTIp4+5199R7m1On
	bx0F3Fd40T0nW77xv/usgI0hWfh0doU7dNKf/3+/N/eeWMX2kjg04P0nH+LIW8Se1TLL7UzR8gW
	st5cbMGxYgrKbcffkYFuhMQTvcEqWtW265WQbkWcvWirIIeuldobSwGboHqxJcN5745CuAZgQ9m
	8Ve4LyHH6jjNOhkjGakPI1qgDMoKn4XCl6/AoH4GWCjIT291TESRSa9sJfpeswuRDp1yowZL8Q1
	rXH9QVebvo4RxF+bZD3XfGXH2Q==
X-Google-Smtp-Source: AGHT+IFXtk/b+mBcCvYGj0Siyd7M1xdtwtm+rgr5hC4xpHP7Y4e1MWcNVn5VfaCSvjXJxZUU9Q7GdujGkw54EvBzg/k=
X-Received: by 2002:a17:902:c40a:b0:25c:9a33:95fb with SMTP id
 d9443c01a7336-25d26d4c80fmr12553565ad.8.1757665674856; Fri, 12 Sep 2025
 01:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911213157.GA1039411@joelbox2> <aMNo7qRCp_yprUAW@my-computer>
 <20250912025343.GA1376629@joelbox2> <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
In-Reply-To: <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 12 Sep 2025 10:27:42 +0200
X-Gm-Features: AS18NWAksCJUI94FyECCBQ1v6323LDTQdfn2krc8zxB7QJ_YxljDTqr2dN0MuY0
Message-ID: <CANiq72kZgZdU4Dut3rmcWT-cujyJaP_99ekis_XdfQ-7LmgZ5Q@mail.gmail.com>
Subject: Re: Printing with overflow checks can cause modpost errors
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 6:08=E2=80=AFAM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> The pointer passed is const so rustc should assume that the c side does
> not change offset, but looks like rustc does not do that.

That is not possible -- a const pointer does not guarantee the value
will not be changed.

Cheers,
Miguel

