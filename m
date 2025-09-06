Return-Path: <linux-kernel+bounces-804291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8EAB47074
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B9B17B226
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85391D5CD9;
	Sat,  6 Sep 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJDVKDbr"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F8366
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169273; cv=none; b=mYfuaI+o/h3RQecIsmXQQCPtWM7XO0sIicMKoIq101kCp4vxcK10exfMD1F6SLZgxSVQmnO75Q0ihOOhkMBineI8tjn/7CLqbANnmxe7YOUyNdgBCjAjrLrV+FN2NcFrlr6P+1AUczJv2Fu2ddBeoOHhQT1KvXMsO1jp1PU19PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169273; c=relaxed/simple;
	bh=z1/hDxQU9TeetDwz3smJ2nlGZaS1m09HT1KJDwHiW28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLEdvQtkbTdi09uu9w7l5KJ5GLvSmzqZpdIzVBt4U7H1eM0HkNCw6yWUMhtxXZtAz+IJo7gJUZob1b+cod7neIV1fibG4SuZvqmxAGSG/d0Pf7BOl12UJihHf4PUODx90tiMx9xwkR1IFaP+37xGEtdkSfGq12VKD5IEMR7iy0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJDVKDbr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b38d47fa9dso28315051cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757169270; x=1757774070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt7wFRSPB7KeMkKKORdkXgliieNDZG4Yik4/oa8YHmA=;
        b=aJDVKDbrniQc1tJ/lDsAA2ZyiiUEMzstovTwauezEY5ep37DRVnbiNxfCjW1pemaSt
         4AylbxWVA2iPMNHsVr4cQreyOOr2UDZrgI8zh0GInN79taJG99nUapsrGR81DB1QZDua
         r3ZyEFqsSVZnI4Ad0jEU6W+wZteX8ZTXj6h7dZsYQ14pcdolCqIVe1iiBSnZzwbxE4cq
         cK4b1n94PIn/ugGfosdv/sqKRUtcpnNc5mpkL6c9BgeFBbZEfXUw8RwpJdxXgZ1X/Z6m
         0O1wM+DoUykJgCR+nYA+ilZoZXd+q7PjDkMkQUtejv8zbjWx4U7lw25wy8iLQ1IjHSIk
         ZWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757169270; x=1757774070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt7wFRSPB7KeMkKKORdkXgliieNDZG4Yik4/oa8YHmA=;
        b=p3bR2666GxRdS7kM7bV08C0h2hTJbDvJ6K5jREYGAODhQCtMf/RfR43DcrV9Rug154
         pgQphGA3Lt7K4I0axEdYxcocSrfDunv8VtKgIwxVViJmFeI7TpiP9K9VLQI3dI6+hSex
         l35VfORLgvAFs4LL0JkPAVWsiL6ajF11K4kSa+DDkaGBwnRfxlJWkRjqKPkU3v7P95Zw
         UQIPKxMXKEQ54I+ximV9VEzPcZU899zzoZAU+GJZGr+uWkPOJNWN42trLSOloOq0qeOi
         ER79eHU6DA9sWiMk3j0etgCs7nLzi9I4WsiW8Xmaq2R6MaG2DNYMN3/OYeB9Nee4WVx9
         J1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy75iaQdoaGA/tBsAQltABYrasENRfFJR3NFghmlCTmyxFmPovIVjmiSgc83dihAHXsa2m/tvXSrEoDpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3VQmFEcNEiRBwFfS/xB8xH9wHbiljOOE37ahaXYGF1MeKCw0
	ePG8VLRLwdr+DqfDH5u+yzzWz5gtqc6y8tDCdwf9t0VyYmvo6MDJKgRaPGK0qJCJKvmKTh8PCXs
	IGuiOgRz5VENZ4j8MG3HtIFWxRHNlMarlTLUhlDvH
X-Gm-Gg: ASbGncvlCOJYYrwuRRkEpXOCxJiro/F6xBfn0MYziuJSzlxd6WX3L5IcF1//ubj6LFj
	9ezfcxlx31MhKQr3w0zvj/gzqAgaN+sJkcfz9eTFjNt61dJYJvtWPUoHTjtjYxcpLCLDaBbamwn
	R2MtxsmdpVrcebLjGeegD0q0Wp1lKOwSDbDUDDEkXpwAhzqxbHGNpx5SgWlS2UyUCyMZRblhfwn
	qe/JhMF4Or6P3zr
X-Google-Smtp-Source: AGHT+IHO3bXz5ygJkkb9Cjy4uYf9/lctlCTfBalrOMcgjNGe/xS1Xq17rb70hGH2ABLueaD46/y/jEA7F85RAc1pmto=
X-Received: by 2002:ac8:574d:0:b0:4b4:9679:da7f with SMTP id
 d75a77b69052e-4b5f8485257mr25068341cf.64.1757169270092; Sat, 06 Sep 2025
 07:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906134934.1739528-1-xiqi2@huawei.com>
In-Reply-To: <20250906134934.1739528-1-xiqi2@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Sep 2025 07:34:19 -0700
X-Gm-Features: Ac12FXxdwnS_xL6nfQG_FckU-3OLD5KdJuf5GD974NI0GdSm8rVVaI-5rBHeiL4
Message-ID: <CANn89iLi4CQZhAw7DKVauk0+cC+nBjoVuHgAan=cOsCP07Jh=w@mail.gmail.com>
Subject: Re: [PATCH] once: fix race by moving DO_ONCE to separate section
To: Qi Xi <xiqi2@huawei.com>
Cc: bobo.shaobowang@huawei.com, xiexiuqi@huawei.com, arnd@arndb.de, 
	masahiroy@kernel.org, kuba@kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 6:58=E2=80=AFAM Qi Xi <xiqi2@huawei.com> wrote:
>
> The commit c2c60ea37e5b ("once: use __section(".data.once")") moved
> DO_ONCE's ___done variable to .data.once section, which conflicts with
> WARN_ONCE series macros that also use the same section.
>
> This creates a race condition when clear_warn_once is used:
>
> Thread 1 (DO_ONCE)             Thread 2 (DO_ONCE)
> __do_once_start
>     read ___done (false)
>     acquire once_lock
> execute func
> __do_once_done
>     write ___done (true)      __do_once_start
>     release once_lock             // Thread 3 clear_warn_once reset ___do=
ne
>                                   read ___done (false)
>                                   acquire once_lock
>                               execute func
> schedule once_work            __do_once_done
> once_deferred: OK                 write ___done (true)
> static_branch_disable             release once_lock
>                               schedule once_work
>                               once_deferred:
>                                   BUG_ON(!static_key_enabled)

Should we  use this section as well in include/linux/once_lite.h ?

Or add a comment there explaining that there is a difference
between the two variants, I am not sure this was explicitly mentioned
in the past.

