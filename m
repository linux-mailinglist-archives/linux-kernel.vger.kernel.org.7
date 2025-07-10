Return-Path: <linux-kernel+bounces-724753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C82AFF69D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218324A5FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB727E7FB;
	Thu, 10 Jul 2025 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fD8YardS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AD27147C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113437; cv=none; b=qo10grINSq63WSx0HY6+bz+ywj9oLCs+Rrq9EEQ9Iy6IeBlnHM8+c7CS0kcfHZ3NjeW47eSxWevc1L64A75tr4yWRnRSPKq6DPWQi79tAOnPl38xkcyeJDG2loXlV5qwcj4aQ0X37AMamWImajAONQ0BRsPZEQrZf85sS3kWmos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113437; c=relaxed/simple;
	bh=Yr9GbybC/w2sH7/MIXF4I5fw9NjZp0rHNpJWYgnlE+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+tTiEjQHIThMaNDQAsXKzWx1ioxqzgLBUZ9N5dvZnQFrzFir0aa3B6RC9PtnMEE669IbQhp1pp0tgGJgJJFOuw2ZfON2gekZKdgctbn1r/gXbGOS7i0J3gnelzBkQ0qWPaloNxBsoEvKejHMqHmrYElGUzzm9GAu4ssdTjy9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fD8YardS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54d98aa5981so609903e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 19:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752113434; x=1752718234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr9GbybC/w2sH7/MIXF4I5fw9NjZp0rHNpJWYgnlE+o=;
        b=fD8YardSTYDjVtKZNh3hTIOOnFivQwAXxl/Agtnc3vOdT34MPKxoF7m2q1bVJq77ch
         SZsLgiwtWfogI85r07egUZD0LKvqvgclCDMJRtnF8N29Ln8ArrArbf4IOTOWatYnx36m
         L0iWoWaEvBUl462EI3a3IzWpQcVzprXImRfaHq2Zozep+CpgcMoc8PUGq2FcozNE7mfB
         lsFaUBCIuYNVpj63agoAgEL0AeslIuMDPexVF6QuDPyGoqvb+5Mawsvh2GQxklDF4Z8R
         NGfPz79ctqLf4Rdyt8mr0U3s8UiQSFKKwu7NK3LhSP//qCSTRQZTTxeUTW2dPQTSjz39
         47Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752113434; x=1752718234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr9GbybC/w2sH7/MIXF4I5fw9NjZp0rHNpJWYgnlE+o=;
        b=h2+w5AvN7EjIoKbhJjN6IK/cnY0xwKcfrqnYC9SP0sYG3nskvuNcIMJgWGEHF9gMUU
         IZFwItHFyqBpyNiegIhsVNe91Z+Dix5Ow3AW5lyfjpB7AfUdrUfOVHK1YdUh6n5BaQpI
         xNAYTS5k6ikQIGofDA5mAvuQuk5FoZqdKaq7A8evSjvwvNXZGy1KDaatsMg94/JmVDBr
         +St1bjUFLziKhbUqheNJ/lbFmNzQ0tABGPKlenzGPTfB0zsROUHjSAuaxhJPLEk2G8EM
         isBZonrm4LLPDDXlQ02e8D1q5AH8c80kLtaKeDYJQcKWdv17d61o/XVqVSm64JsUpzO8
         Pppw==
X-Forwarded-Encrypted: i=1; AJvYcCVPHuKBnYRwjwskcpke0H/6PsVTiRgcASji6cpo5GDPS38457DFfbI41qpvV+X7gsD79P/jWF8tt061WBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+ojmW5kpfX7PMXZsMig7qkesEnNAS/0QWbSY9Ve3JxH2IC5F
	lIRExwQFBIIXXkifKRtQE8lYz4M1sfUSNCgx1BVGneteviykJvh9a1hu2x1eIdRTUfA4YnXHZy0
	HIrX6kxGuJ+PTaAP4+7kIUn5yCzFEbLrSVcxUjxQ=
X-Gm-Gg: ASbGncsOPY2puEExcWtIQGsZwyWR87QhuL5PmCM+omnW3XosIS5uHOcCjS3MJCxcufK
	vHWKIsN6YOhcAIkSovAAQ9qrdOGCaQ+JdCuI2wNx1KuLgFlbWWSeyHM4x5gPxR+t6MOqgQhbRd+
	sSpl3ShC14RTmM75qXtqG5KnOz3WvhUtePJsdHV2Fe3Y0D4gIgUP0SaLB2+2t0D2AM523+qUlJ
X-Google-Smtp-Source: AGHT+IF7CSRMfXUjWAwZfGydsjg8g4cFnxch3Xoi14AEJwAmrBxN3hebeIFO3GyVLoADPLLKkeaVoOM8ZqUO+Qdos3Y=
X-Received: by 2002:a05:6512:74e:b0:553:263d:ab97 with SMTP id
 2adb3069b0e04-5592e2ebbf9mr191604e87.1.1752113433736; Wed, 09 Jul 2025
 19:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de>
In-Reply-To: <20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 9 Jul 2025 19:10:21 -0700
X-Gm-Features: Ac12FXyw_-ZFqOEmEG4gp9Vh5ErvO2eH8QSE_aH1c-f2EfnXicZgK4MYIbiWaVc
Message-ID: <CANDhNCqQ0JgCN+5sThMT3nnNxVHR351LM75eUMqMaHucGyhneg@mail.gmail.com>
Subject: Re: [PATCH] e1000e: Populate entire system_counterval_t in
 get_time_fn() callback
To: =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, markus.bloechl@ipetronik.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 7:34=E2=80=AFAM Markus Bl=C3=B6chl <markus@blochl.de=
> wrote:
>
> get_time_fn() callback implementations are expected to fill out the
> entire system_counterval_t struct as it may be initially uninitialized.
>
> This broke with the removal of convert_art_to_tsc() helper functions
> which left use_nsecs uninitialized.
>
> Assign the entire struct again.
>
> Fixes: bd48b50be50a ("e1000e: Replace convert_art_to_tsc()")
> Cc: stable@vger.kernel.org

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

