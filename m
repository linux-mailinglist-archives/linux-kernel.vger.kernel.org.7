Return-Path: <linux-kernel+bounces-866691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB47C00732
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6074FD870
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279883090DE;
	Thu, 23 Oct 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgjSj7YL"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380330B52A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215068; cv=none; b=BJxQ8Rp56Km/XEyOaifvMyQavhq3dj5YXUAh4OtfnUlSfn3wo/e5Yi4zzIcgZk1/Z8mu9jKFL9XGZS4gbXyS+pjRglnmAZzhkHnzaYjxSGTF+31TGKXE9EKiEnhSuxDBdcYUcfVkhbz9UOwxJ98u6vGRPjl4YwIvc0eBHvfzvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215068; c=relaxed/simple;
	bh=TWqoNj5YdoeJ9asRq6lMhjfB3nhbhwLuJ+gEtX0Kgu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbdI7WErYnoIp2VniQEQRVTcZkMUqw1HAGuA+/BkRTY6zO7TEs9HjlacRDu0FvM4HsqlbnckeEyfUT876/0rd2W2QTFx3GFI35PoRNot4Bc+ORFAsmEbIsqGu+f9qdNwzO92WYsxJ4nOX3sy+aNhaWAC7LHUsomxl5quW/8M5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgjSj7YL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290bcb326deso1567855ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761215066; x=1761819866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWqoNj5YdoeJ9asRq6lMhjfB3nhbhwLuJ+gEtX0Kgu0=;
        b=dgjSj7YLkHRsdLp9SLAZD38kP6hxEwPLvahw3f6f9+sPnyQPOzuFYJWNWnt1r46Lw8
         uzQMWdXknRhEayElUKCjCbePA9n0i6gX+SOlUD/zPOvekhdlz5QA0XshmA9/grglK2C4
         uSyRoKHunayOhjT/Dmcf+qP4SUEeV9Z7/9ZVeIh2XW/y8yoktthY44yE4EShtUGGDqi5
         5aC+KtfpmueJMhLUWPHcTgVI33cBjCPh01feSOAsfmMz+C6va0Cvg9O3fL5AuFP8V+Ut
         UDftB8ezbwrUbJvLt4tSGs19kyxlppydFFsYdb3nfSRnaJ/y24wm7PE3iHEQ4s7PXo2i
         T1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215066; x=1761819866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWqoNj5YdoeJ9asRq6lMhjfB3nhbhwLuJ+gEtX0Kgu0=;
        b=ERx2Nr1GTuUUe9z0lwEhcp4pVFg00qDH5xt5H+8GXEKGT+Hb2uDBnAx+gcQXEI/M+O
         LLZtzG0UVa2qigAex51egSIBFwZoUFktQ/bK1/Sm5LS//hycCJU1mjzFN4JS2Tpi1ygX
         8UyYMqWiXQSuuzHqCxl9bhepBFc9MbPm2WhA4Uh9NwwT9lYM+S4vOq0vQwSpwmfm9p20
         aldtJKzL86N5yfs2qYuC4JNTb9MKRbDYD7ucuWchtS2u+WRxPklUpPRKSEhzC3cSe8SH
         /RRlCkaP9JlUxafKhcqa9S1nvPITwgvP8PXkT71dMLZO+ICtUfOeoKLOxnMfG+iMLi+Q
         2gvw==
X-Forwarded-Encrypted: i=1; AJvYcCUkbttrQFhGXHw96B9abvgwrGJzI//DfL2IJ1FHDGxunsIfLsuYAWUYmlg/OgGG+ghv18i14RM49mK7H54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+U4jdR4864BXXXVGiwrDLYLP6qSn5zRGC86VqxupcKnjVoHD
	tSSVTj5xMzBKl5ZY20RafaaJrR0fvJ0iL4vIJcgQuYMyP5heGRwA2d4fCIi/RtTCLL9qucdoM/H
	5UJldNbqlaD5rgRSX5gb782enuOXKMek=
X-Gm-Gg: ASbGncvbC7321Tsr7wSqBYbXs95cltNxQbcyTwKQZON1pt/rB/hA+yD2ZcMlvg/xOhW
	4DNfiTdrDkrYpZF6BhVyClhJXk4Uex4QccA6RLPTK2lTDluQDiO8sZqf04TcpiMxz8nBp6A/DG0
	d/dHjXIaOLFWUaTKU5lqrd0fpVhRukB7cIif0OuzRzmqmJIur6pk8bi8PUezWpEdDCQp2/8QD3/
	QDH9ypjLY/Sa7EjlIZtEtQhPbqQ0/X5EGrFaQYh3ruHVgEijHTvrLpMuXabUPXqwwJwjQUUJPtV
	d0TSOhkP+Gh2GomcTBQYmUEuJ5wTxycuJQfRRfzCmzLxGivvdf8Or0f4SVBryROkUfJFi4nbidI
	21bA=
X-Google-Smtp-Source: AGHT+IHL/NOfl30TWfKU/BaCMVnjssdI5BFI0bm1pxWmrt4ppzKzR8Akyjxfr+nN3dvIwG3o1qnBpfOu4tjDcZC532E=
X-Received: by 2002:a17:902:ef08:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-292d3fad068mr69723455ad.6.1761215066415; Thu, 23 Oct 2025
 03:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023124926.35a9ded0@canb.auug.org.au>
In-Reply-To: <20251023124926.35a9ded0@canb.auug.org.au>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 23 Oct 2025 12:24:13 +0200
X-Gm-Features: AWmQ_bnsu34G0TQ6Z1JJkqPuJ6rfaooZhtnhvtFcP91QXFBKiKlSmqUmS8utRp4
Message-ID: <CANiq72kwsk8NYUR+8Sia86YSUhYyvLXWD8kJCR8fD+_Hv6qz8A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the opp tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Miguel Ojeda <ojeda@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:49=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This

Looks good, thanks!

Cheers,
Miguel

