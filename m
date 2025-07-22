Return-Path: <linux-kernel+bounces-740262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD7B0D202
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9A93B9D55
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A32BE65A;
	Tue, 22 Jul 2025 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhaEt4AM"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45113A265
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166684; cv=none; b=lllU7HtpHc2SyX9rJDdE+WiGCoKzdc7Vw6VpXeLYKohgPSLwpNd+4SMes4zngNwvjJesRexw+9jWQpc8Rcrcl3dlAdzzdQYgPZ9CFUrkI77fLndMOygR3L5O0l3vBI7foiojbvNM7qv+cp4egZRaJsKMxSCH7BvVjNwhRAiah7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166684; c=relaxed/simple;
	bh=BeuJJ4I19ZSLY3NjjO7TK5iQ5WFVNpT5kZ99VkGjFDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV1sO+5HqSeqWgTuKLzOcurbqSqqFB01kp5tK7aPm0GKT9D7I3FB7ek0+lRsIhFJW6vFILhecqakMtEIzmCUdWKqBPKSab8JOhTnwBc0ldNSOZL0HekNvyWRCVs6/APgau7dtmHp86JSp+PGu0S7Q/x/XnhXe6306rPTYPAxdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhaEt4AM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso39965841fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753166681; x=1753771481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svGHCIv/rzdp18bcinuKmdlQcanQwYV8+j9G4scCHps=;
        b=jhaEt4AMLjjUKEXDarpyIPOBmqn0+fd5rWTO3l/XKkBjlDh9TL8d+aV4I1t+hgCZDl
         0GKTmU3o03+wB7qcLQdsRu75/PxvYRbcWRpPRwn5n+rxu9uqMPFdEOLbYM16h1Fu23On
         +87Vtsb2N+yYEHN9vtHtC1oMkkiYXVMdnjJqhff/4rwAF7fjQeubLH5ebm/9FJ1URby2
         E+STn+3W1zgvdOg/kRH3xPCdcsRiD3rwGhoSwdYoGly47VOfdgLhsxaPrYkRS1N1vsiw
         gM5yfwHXJ7vVZAj5fu4e4GU3xyVpZXmjv1/MCTfODD8WTR+/j+T4ctBcX9Ny9Qdmrslf
         0vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753166681; x=1753771481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svGHCIv/rzdp18bcinuKmdlQcanQwYV8+j9G4scCHps=;
        b=hiQdnDPyAXPXH6wXLlJQtMpaCVbCaHy5UsakKvG0K86r5c2kX+PVNESVAmlglBGOnV
         x8I82fLHTJitfN/PSF2xuzZyVWlC9ZfQUlpeIbUOOuJmbkOnxWF3wcggx8GCrmr88OBh
         lsJ+tOyNlPBUspyRyp24IpcfJn+JvGN71ed6TKs4f3B453XHgWa56JVNS9jzv6BpgNT6
         xTsN32s4WUH0EwbKrsYgEd7y3xW7q4iZ2DRr9iwxhlxSwLJgskRVOCnJ04Mq/Yakdnmk
         LGjk0vkHk1zqvyrym1WQ0BKNlstsn8qBLdyi10hVARZHrURhyzACQ7e/AUkyPMUqGav9
         eaYg==
X-Gm-Message-State: AOJu0YwDlfs5orEE/hpvSG1pFlVwkLnJVLg4OhGwqTakLtu/0vzzINT8
	swxSyCs6kmlLOiwAW2DdM9QXmTIfbIprP50U4LXIpsTrm8B3UJBT7sDNq/OYMzn6efPDhFku0q7
	bAj19DRblhkFQOh02GJQ5Obu5G7F84oFf2Q==
X-Gm-Gg: ASbGncsCiemjYjtbw5/YmqkjJi84gjAoGXUJ49EM/qrv/bkHawuN+4hSLBgmvxeS7FX
	ihWgGi1w7K4FXWMvA5wQAZ8cILylEMthojA2jbYbKzVn7Vz9zew4Z4m02ss+fo/+3NRaPna2yUI
	yp0Dm7bAMldqH5NbWbxYI+uHPmZEOZ3nBezIEUs6qQvSZXJNVyWR98ExzcqZPzZaGinJ5xK4eey
	5PpislP58JfB9jvRw==
X-Google-Smtp-Source: AGHT+IGKyQFFw2VnRuFUt46LVOasze2UPVsanIEKKnLVNwh8sSWROvEDp9U3X8Hn1h2Cz08X3vrAYIF4fbsYdzL7jmU=
X-Received: by 2002:a05:651c:4ca:b0:32a:7122:58c9 with SMTP id
 38308e7fff4ca-3308f4c6d4amr55206351fa.5.1753166680898; Mon, 21 Jul 2025
 23:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721174610.28361-1-ubizjak@gmail.com> <20250721154325.476b87e09aa5d778bcead478@linux-foundation.org>
In-Reply-To: <20250721154325.476b87e09aa5d778bcead478@linux-foundation.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 22 Jul 2025 08:44:29 +0200
X-Gm-Features: Ac12FXym0UR1M4tHAdKVsvyslI5TIhMZFmLaeIKX105gobO6zrZEE95QUa_VYFA
Message-ID: <CAFULd4bLXhnNzbitQ8mX8-L-3HhW1BAGN0hzCpbAu58cTcRS2w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] ucount: Fix atomic_long_inc_below()
 argument type
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	MengEn Sun <mengensun@tencent.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:43=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 21 Jul 2025 19:45:57 +0200 Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > The type of u argument of atomic_long_inc_below() should be long
> > to avoid unwanted truncation to int.
> >
> > Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
>
> Please (always!) provide a description of the userspace-visible effects
> of the bug.  That way I (and others) can decide whether the fix should
> be backported.  And people will be able to determine whether this patch
> may fix problems which they are observing.  Thanks.

The patch fixes the wrong argument type of an internal function to
prevent unwanted argument truncation. It fixes an internal locking
primitive; it should not have any direct effect on userspace.

Uros.

