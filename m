Return-Path: <linux-kernel+bounces-840365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F2EBB4361
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53237B3818
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F452F872;
	Thu,  2 Oct 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ydIXfp5d"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DD2CCC0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416601; cv=none; b=jmicVvk2h0GYXoqhjKFykBVRhZl5JNHLCzFisjVo1zAgay2L4dcDZeNLvHIOst5nIXiaBPQBBdqlsZhPuLPBXY1NdC3rlROnUlqYeSvILYPWklY50kyh5rLdUqQefm2w2GyfCdAdrbFT4vVEo9qMYA/8fe6dG+pNJUgTHbkKiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416601; c=relaxed/simple;
	bh=3DEtzWzJ+5AbtUuYByrnTkKmHNnskh1UPwBWzowwkgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLxeVQdaxGJg+L6nHbs9ajqJMey+boepAK/eZ9H7wiLdmOGKeVL8F9nK9QoKTsQ7IJVMuH5DPpddPVwBQMIQMlyK7VS8H0chYSz2s19YPtCggQ3gSxtWje+VRnNAs+suNj0HDp9UTECcwd42gIeJNYaW/Q9T7MhUgdeDCaObq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ydIXfp5d; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-33c9f2bcdceso10532131fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759416597; x=1760021397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DEtzWzJ+5AbtUuYByrnTkKmHNnskh1UPwBWzowwkgg=;
        b=ydIXfp5dpkCzuZKHZsEydCQOSr/Qo6bwdcESVHpvFsJkYDN1X+GueJ1gmP5EoBZ3C0
         pPa+rLyzZnoIlryxXtJBtwjhdypHk4JIiC2ejn1bYCLNOKUZyu/jCD/9PmwFJEuk6gDq
         oP5eA2QI83QoRML+ueEm5tL2dniM6LhFcEqvXZ99mnov9ZUNwoiFC/0pKkUn+LMekX0e
         sTV6cBYxLdiCj/sOIBlXtYi+e9PYEX33zLYWLZiQh8mvjrpk8ooj8CIOnDl3E4rDr8rt
         /n2Hs6fornyHh3gqgwZ5t+NMkCN0LrLwMf6VHml1k/RYzf7HZakbg6gqnAMSv/8AZrir
         v8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759416597; x=1760021397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DEtzWzJ+5AbtUuYByrnTkKmHNnskh1UPwBWzowwkgg=;
        b=n+FFWeIfUc6gV9fM62wTjzNELKYFSaLDKe3BC2s3Tie9g0u8wZZow2NapnjNrDlwuX
         SlOCev0CEIFmjWluDj//SHz22wzfPaQ4cXIEW5HItYhQiTbzSoWcteuuk++iSk6i/LM9
         tbsrDOQ9hR3UxbP+8G4konQbq+ImO5q1I4Wkjz7FNPogQc7moqFmIwWbFJEADT/HzKFB
         UzN/KVqhJBGN8YkH52YEncue8Jony6mkDbMSPwXifBCobI8a+wnSOGfVjM3X+HbAmSF4
         1WtGX6GchE8kwhVws6WsogBzGO6qRRiBquJXruygetEv5v9S8vI6amzPlKUjVRoZhOi3
         wDIw==
X-Forwarded-Encrypted: i=1; AJvYcCVV5YYl9MXlhT82Mt22wdK8yiOkyR4fzk4f9UdZszG5BqBEXErnoKjMBH1s/UNlRPo+OrREPDd7ClaiWrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypL6Z7QC9Oin+IuvC3K48oPq0r4TBMCuGzqKbVi9pBIrF75/Si
	ujGXyvNsPFzXBr2zH3tYcd7nBfYuiJgb0m8y0hyAF9PlC0CJ1xR8Bc5xDpzhEHreW/zrZi0Jpi9
	3tzsGli+gt7yE+JkuDpzRO6L1bqrMvZkzKp4NlqGMzg==
X-Gm-Gg: ASbGncu4XrJ6cZqphCU55Jy+ee3ARdHmKk5CGAibVe0ZBrZVdYeeArlPezLDzCYd+CM
	J5NOHNk0/RPm7hgy9d3HO4iz04t8V289JIQuVjwQk6aVglkoLd9XOakW7mwlB3CR9LwTyIFTpea
	EMIE9pd9n9ekJPOvGuBKzbBaL/YM5lbPqHB9P3i7O2fHAyzmRrYWAkjKCVGgEvB3tl+OB1kI+zS
	pM3iqtpZP+wIcHWmxUh6wS3WXVtMYvjDEYt3LcCUt6aPuGJjXPB7JK+viF5Kx4=
X-Google-Smtp-Source: AGHT+IEFxaUXZbW4cydqpBo5P7Gi6kzBpFsb/v/pBDTMbOwFFLX/m9JHrRJwODjL2sU3sJEEl4mXuOKvbZUzvPir5oM=
X-Received: by 2002:a05:651c:c90:b0:337:e151:9ec with SMTP id
 38308e7fff4ca-373a711564bmr20327891fa.16.1759416597435; Thu, 02 Oct 2025
 07:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-i2c-mux-v2-0-b698564cd956@gmail.com> <20251002-i2c-mux-v2-3-b698564cd956@gmail.com>
In-Reply-To: <20251002-i2c-mux-v2-3-b698564cd956@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 2 Oct 2025 16:49:45 +0200
X-Gm-Features: AS18NWC7qjlJCo2wv35_zng7a-THUxjToC7YH2tPnfIiOSWbAAuz7_LLpy1uN60
Message-ID: <CAMRc=MdUHQmbDOGW1LMhE8iZmJszmC0oyOJYvVssap9wshBkmg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] i2c: davinci: calculate bus freq from Hz instead
 of kHz
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Michael Hennerich <michael.hennerich@analog.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 4:42=E2=80=AFPM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> The bus frequency is unnecessarily converted between Hz and kHz in
> several places.
> This is probably an old legacy from the old times (pre-devicetrees)
> when the davinci_i2c_platform_data took the bus_freq in kHz.
>
> Stick to Hz.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

