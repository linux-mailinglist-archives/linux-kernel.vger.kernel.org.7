Return-Path: <linux-kernel+bounces-862462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0788BF55CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6DB3A5957
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73683328B67;
	Tue, 21 Oct 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exNdML0O"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D2328633
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036650; cv=none; b=WDGCVKzD57H7yNocgT33xk7mzKI8F84GDM/QI5Wr5PEJ+WnZDw11dRvMN2o1mICQushXeZFPmnG4m8HqUDUc8KtFSKjwAiEhotYu3joF1jKigqFN5E9bbo5rFhN2aUf848jIXvNH1DodPIZSCeRojSe7KxGoCzM0KOsw+X9cKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036650; c=relaxed/simple;
	bh=YYGwKIw4DU78XjYwaYwxke2dNDi4SH+1u4WyDiQEDQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTUuifWE4wwrckva99tAFYScMIynqgfvm71B2xhjNGiATqK7i8CmjfoEFmWI03dxAcuedBE2+6IWAcRilC827rMz7ZT8BHiJuOlKNiW/dParua3NziHLtZSRB5OgBBFIrpAXyjxLJI6qGCeKi+B+cTa7i+1mNMXvbFBC8aaFt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exNdML0O; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63befe5f379so6996166a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761036647; x=1761641447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3LdkJEpXUwO+NWSEZVny0C0q696Pa6fK5D8TjFSc4w=;
        b=exNdML0OPXuIqL5e6eBhFDWo1OgUzlX+BD755VQARhdlIH+4Z/yM9D7x48MY6N5dWv
         W9pmcjas3RYwT12Bi2yFaawqvC+oS42k4ehaP2mbTjvhJbHtmLrxmVrgIEVHH7C8QB1o
         ilRZ31H85bDTblvONh5GG6ZjIFd1LhbAxRfuAQYjgsh3XZuHZVrVGh+gjuJDfF+WVZGu
         pzY2kOFTiqkf+OgUCC80kTckEAUdE50YH4Fc07YBEfLB1JOEIWKJTIw/tZFSZO5bJlHb
         szN4IXbjbBIlhTxdNvHfsC1jlSmWDSgCfUaavnCDhupYwxKhKF+i/+YZVkc6JbE4Ysg+
         5QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036647; x=1761641447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3LdkJEpXUwO+NWSEZVny0C0q696Pa6fK5D8TjFSc4w=;
        b=ABQtBpvsWL+2+W9GSZsTeZC8vlQmzSuBhbqmzudlCaUtloU8b19qyUAGe/z+Lrih9m
         8KsdP/1hSzR40iLdGv4zUKCwUF/UT7/BdPA3uAvyhXoDDfW7U0RdmDc0luY2k8+3vLiE
         Xw1TXabjjbqs5p9MKtefkF420vXeWnqfeQwjbcpmh1W3RmAqY34rpDk3ZTXXbuhXSS4E
         9tgocV3pMB686Az+lg3uVPCIuXg6OqGpaWbl7hSK+An6atAjPT5b8CJQ4I6m0FpY7EPG
         CeV1Z7+oTS1/rQNYwGNTqZxcd66zbcbS2rh5bx9GCYmi1u0JU9Hn7YwqCXEnqsRJ73YC
         WrMg==
X-Forwarded-Encrypted: i=1; AJvYcCVBQxHZAmvf/izbg2MmbBJ1C0TQCMoq2uHBtcHhtFChf+XDpLnKY4rWGThwiXAmbnSXysD1Ryb5aGz6R/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4yVTGdwXJhPYlhDLs2N4S4inp8It2+P48GiQe6RUHjlKtOtu
	iBwXhrzmwQ812u6MnaTQsMtNXBBje6/MBVB4arB+J1neON1wYpeHhuV9t3woLJdBrVzyPtlFBor
	2UxfSiXl+lxkblbA2hQInr+UU8KMVTAs=
X-Gm-Gg: ASbGnctVkrwG1jBHvE4LM7bCb5MU454qf1aFSQVEwblSGC7y2n8VmG4Llurq97p63nF
	3893KbeeSNT16Ap3s3tYvIT0Rukp4tR2D8kxGKm5DVvCQltJbxdmtgmnO+NTqIHgva3IWguIj7+
	2xN5fJcIXv0bBqLpLEbbg6cn03Qkfi1Jb9EmV8vzPeC062BBcRo5lfej7AFiw22Trwrqvnn5JNp
	R9yD9A9aa5nqR5CS30fKE0UzpVT5LmprAy8syvTmwDayCLmoALa57RU23ndLQ==
X-Google-Smtp-Source: AGHT+IHBY2IUN83Pw2ENBSOgJpr4Jc1uqt5wNDK5R+8Ap8x+c1BNaeQ/FRba66e2cv8DRUxHfZF+WnI79kMwhHazwpc=
X-Received: by 2002:a17:907:c11:b0:b46:897b:d759 with SMTP id
 a640c23a62f3a-b647443b9c2mr1867846866b.40.1761036647265; Tue, 21 Oct 2025
 01:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-staging-fbtft-ra8875-usleep-v1-1-9592dd390c13@lukowski.dev>
In-Reply-To: <20251020-staging-fbtft-ra8875-usleep-v1-1-9592dd390c13@lukowski.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 21 Oct 2025 11:50:11 +0300
X-Gm-Features: AS18NWBqAmjo3KOZJeoj3rpQJcbhQ65NoVyhN4fDfDmM2riHc6TQ9QZuK7Sh_wM
Message-ID: <CAHp75VeWGAyzAFBYSQS7FGpU1eSRo1Egrh44hUpXJgYZhFEkwg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fb_ra8875: replace udelay with usleep_range
To: Olle Lukowski <olle@lukowski.dev>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:16=E2=80=AFPM Olle Lukowski <olle@lukowski.dev> =
wrote:
>
> Replace udelay(100) calls with usleep_range(100, 200) to allow the
> scheduler to yield instead of busy-waiting. This is the preferred API for
> sleep durations above 10 microseconds.

...

> -       udelay(100);
> +       usleep_range(100, 200);

Besides what Greg said, the function in similar changes should be
fsleep(), it will automatically choose the best low-level API for the
given delay.

--=20
With Best Regards,
Andy Shevchenko

