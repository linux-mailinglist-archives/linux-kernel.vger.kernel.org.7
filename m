Return-Path: <linux-kernel+bounces-761974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDE4B2009B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661843A846A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F7213E6D;
	Mon, 11 Aug 2025 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="z5eyhWlY"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852120E011
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898448; cv=none; b=R6qMocYFUVmrmuHDgfa5whSJRj5dYgwZv68UfBdrlEQ9zM+LfV1YbdnTaIIGk9IMOeCGNE2kNIW4Nh4KyGE9ywYLRaXuhof1B5NdivUQHSQECkklqJEGDdJix1Ol+c2F0+CGrvmiuOznPUEErfamUJW7YJlBOlxQJ6mgrYyt6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898448; c=relaxed/simple;
	bh=vLH1gqawWVrkH8DQwd8bbA3uokxzUYBljc36Sbl1pxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dw8FDXgdR5YNvVR84gZclUQecwLLIHbElqlIaRE4UJnRq4FM2DSGiWyTTpYreEuP6+kHZaphRiF2XnjgnCErjSGh867vesYhwMChiIyfrDSqwMeM0AyYrZ4G19EPiush6eGXJmwQJfCrqx//vAo50617z5Rx6pfoxSbsyEK7rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=z5eyhWlY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55cbf9a78dbso3062436e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754898445; x=1755503245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLH1gqawWVrkH8DQwd8bbA3uokxzUYBljc36Sbl1pxs=;
        b=z5eyhWlYcC0ekP85q1fTl01IJd+PFVXl1S2aQH52S41A8RpG8v8twrEOSK0UnBxdN4
         M40OBtJJrIDi4Jw+PK+gPRSdTIe9ND9lIQ0p8LS7zPF9FmCVXV1HshR699TxyUKr1XbV
         +TARM74PvIhx7INnDGvy4Lvhfcn4CP+KpfI77739EVBv/rTo6ANgztL2JGRCMUKFuro1
         ui0T7s5s4BUwpDsTV0HMNBpzjohVAw582YfpBsX9K1ru65u5tjBR0EmyzX7mWqRrsujA
         mZBV/vmxiK5KG13I1BQ/yF6okLkbBc40icYqcBptvjMCwI2hKChTzn6RXX1+wPahjW0i
         CXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898445; x=1755503245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLH1gqawWVrkH8DQwd8bbA3uokxzUYBljc36Sbl1pxs=;
        b=nWYjJ7G+B9wZXARUtkBxnkl/lV9R97NXts9uEYeZVOJ5PvFCJGtD8xArcfgz/ctQA3
         tYNw46fpzTE4MOsAz0YoWv7lXnO0MjESyhnbl0in4RAtepsFVtAhA5DNvxvUK9Lbe2Bm
         EwdiGIwPtsprTwwiJwr4/60RZZHEyoQbwKq82VWnz+wTVa+DOLedjnCPiLQJsSlzVnMd
         Rfi3bqClhCjeydbwnGhsoKiSRmUNWBCAsgOMcyQSHO+VIJ6k/VF/1O8yWQcRypJ8QHiA
         OH9ZioaIBl27q8j5ts7KZxdG/+yXuFk5UNxqPEbfxOjYJRFbUKQ7E2PKd782TTL9hdta
         3/VA==
X-Forwarded-Encrypted: i=1; AJvYcCVvELyIXMHVI8uFjywVKeJCd+Yc3r0hQ6Y8ornmXxoVuqHYZ/Q4XVwBLQpVBIAe2EUNXXt8mjrzl2y1EaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDN975sSorsDRtu4DFU/SW6pGKBN3vF5AHTSyVQqoytZkFcCa6
	+pO/EQPRjmDyd3ry/hr9qs4o5VDZCzEAgirlPCrD1hqY7B3j9B4uQpFZSdK9scWRoHPxPSEw3yJ
	lxbwv7WnQjJCfOv1K7KDNro7jKoKo1Na0tbElLlxwOg==
X-Gm-Gg: ASbGncsdAtjNzyaK4IwxCiIA8cmNM9RYdKbBafIveZSv1NsaLc8il2wyJglqmRZL9zT
	qFrrH87pzPb987Y0RnPLpV9Jak6HuEClnfaedOA97+vzeOMy0Rh1Xl/tckpv4ralwbnu1SP0poK
	M+fzJUhQKr+RAIUyU9dQRA1/BTh4L62DroRv7GqHvR4af8D6D4d8DGopPMESC0BF+YF0Q+fAVSd
	E9BLMM=
X-Google-Smtp-Source: AGHT+IGrFAG3iXdJPs/ctpG63OOV25kZZFsNWCDuoZ2UqRMQ7MyguVt1VFp02LLWZKTkikVtnSijWjDPt0HkNcVhTyk=
X-Received: by 2002:a05:6512:3d09:b0:55b:57e8:16c4 with SMTP id
 2adb3069b0e04-55cc012c003mr3193177e87.30.1754898444992; Mon, 11 Aug 2025
 00:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJd2Zho5QRUTAEzm@bhairav-test.ee.iitb.ac.in>
In-Reply-To: <aJd2Zho5QRUTAEzm@bhairav-test.ee.iitb.ac.in>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 09:47:13 +0200
X-Gm-Features: Ac12FXwMS3WB5EsQUQKu2BBekh_xFvZvqabL6It5COncLghaTwCpsk8JkuP-0Lc
Message-ID: <CAMRc=MczvR7w28Zw6Yn51W7wrkSHjitE3pimHBMgbL_zS8wYhQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: virtuser: remove debugfs_create_dir() error checks
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: linus.walleij@linaro.org, dianders@chromium.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 6:25=E2=80=AFPM Akhilesh Patil <akhilesh@ee.iitb.ac.=
in> wrote:
>
> Remove return value checks for debugfs_create_dir() wherever
> appropriate. Follow guidelines mentioned in [1] that callers
> should ignore errors returned as other debugfs functions handle them
> appropriately.
> Refer commit 8bcbde2bb1374 ("debugfs: Document that debugfs_create
> functions need not be error checked") to clean up unnecessary error check=
s
> without impacting the functionality.
>
> Fixes: 91581c4b3f29e ("gpio: virtuser: new virtual testing driver for the=
 GPIO API")
> Link: https://lore.kernel.org/all/20220222154555.1.I26d364db7a007f8995e8f=
0dac978673bc8e9f5e2@changeid/ [1]
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---

The commit you linked says: "In many cases (...)". This is not one of
these cases as this driver is completely useless without functional
debugfs entries so it very much makes sense to check the relevant
calls.

Bart

