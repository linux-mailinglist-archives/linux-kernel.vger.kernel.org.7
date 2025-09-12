Return-Path: <linux-kernel+bounces-814293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F9B55215
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE0F3B1B14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8730E84B;
	Fri, 12 Sep 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xtLnwq+r"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27A2264CD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688312; cv=none; b=JbkEkDsfinXLvoy1Ktgr1Y4+Qk6IJJLfkPUPJnNb1l2vUQrFTNbFuknzK1cr49hzBDm1sScSVGE0kO1D3jvO7bTpxlhLsUfFskXM2TeFZbm7Q6lMKmS9sS5Kmzd8j/pBdUSdC3goaddcqa8cC6j6DUWqNuZykQt8INZAZuXLw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688312; c=relaxed/simple;
	bh=U9KiIoN2wWAUp8EUJ+l29eyCQ1L8N80vpZij7DtvWUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGb+wP6UMOd0gH6PooMdtdPhF2YUHxdZhlnBW9iiJEZOByTFrvoR25s2DEduIkx40QEtx96AlDKa7K8f0xumVsy6QAxTna0HxoWBH8LsUYvCUdmtLVYtEJrgYjKAnirweE2+1fU+oZpcrfJmNXckywytKlIOunigpFLcDw50ad4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xtLnwq+r; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so2023827e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757688309; x=1758293109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn+YPoQmxEr23a5PjO3DGoBuuC3lsckh2uIz0y1OKGI=;
        b=xtLnwq+rQD6+WuJ2g34WOs/56qhVsAz1Y0Jmemd/mimt7s3aBIZrVe7o7UIPYCpH+M
         LxjVoeKfT7ioxBvTVR68ZZ4GCJGTnHRUSfD21kjkiqEUxIdISwH8/KvVxD1HmmQ/hxWn
         31ovnYTCIH9lwfhcd+/ffTHrw4f0SpZ7Mb7ZQQeDYmNstOL5fFbe81smahF10VuvTIrX
         xUuToHif9LyqALIHlfL7yUAXnbPNoM7xqpsEIkVyQiBZdDDE9vgj2K7zsCaCfQP0jbsR
         F8vN6S7UBsHT792FyS4a6qFevCuj7XvorMtnb/13JXpPsr8vtyE9/elJSEd0qzeVqc6H
         Qhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688309; x=1758293109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn+YPoQmxEr23a5PjO3DGoBuuC3lsckh2uIz0y1OKGI=;
        b=l5tw01r0j2uWyN3JXZCplY18D7BpaB8rCEohBRlkKtr33PRhu8X68aWMnrQWapl+vz
         FZKRVIdw1nPTNOIxDroysf7OdqNbYgaDLTWohJv9kCp3nMA+8Ejd+OAOd3aUH4lY8gW/
         3Y/kC/wren+8GWvYZUMXZIFo4M4u8FLW9wCDzjwUXM7pvRpYMrvjkQ0M9ht5n3aV46D7
         EaWMm0ofGQQesXc3gv1Z+fMagxoX9WjZz+5tbjMJeFN+LczolxJSqcIN/wknxrVtIiXA
         mH5nK56pQwrWXBzEuzzhX5eji6DSqtSgUQi66X3kZ/hjWaHEdcF4MopRNqcA7oGNW6G+
         +DLg==
X-Forwarded-Encrypted: i=1; AJvYcCXvvehCmnJlBBBZDEUIAHPnJZ9d4YqbmXyQqYzdp3r5MydLV9e+1I8XuDAQbtW2vUMrBoiW6ZAFwOi1bQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxywA/raY5uYd4KEwPQss9Y7IpPoazgGNQ2xVd8MzFl7FVjlthO
	uRhrqzt0cT18eCW60Bq6yq37nyviFtT7hC6eCpp60y373enmu0N8yPk1rHWSwo7mEeGRUqTTcf8
	69YDLSXZm4CuCoxbWSl759Woh8IT83CqTl+G1Wb8IxA==
X-Gm-Gg: ASbGncuoOW21TJl3KvGbL5DCR8Ku5ojWfdyigaxzjAjuuoJ0w6ewBFRe9Nxb19nOk9T
	RsetBHqRuBr/33Iyt8V1xA7TI2IKI6kGgztz3ZFKQ6ecbjFKjBJITDCnfvAr54x9WZncdYjxSq0
	vcTGOaFh+8tJI65f1tM4tggZ9PrHr9ZpomY5bvxAV01vOxalJJMvZAhdiL+gvUxtGaS8QtRhJJQ
	fhFlUMBMDOoKcqE11QmLXdh8HjRIjTALpAJmw==
X-Google-Smtp-Source: AGHT+IGUzZFzSTkpABUHzFqSh86WYUDg9sPFuBwIrqL8MagbdIf4wFQyUDXaF+czSRNCauv6Lx/3Dva/JflQfhQYWUo=
X-Received: by 2002:a05:6512:1286:b0:55b:8273:5190 with SMTP id
 2adb3069b0e04-57049e24115mr1136950e87.18.1757688308574; Fri, 12 Sep 2025
 07:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912081718.3827390-1-tzungbi@kernel.org> <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop> <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh> <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com> <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com> <2025091237-cortex-carnage-5c34@gregkh>
In-Reply-To: <2025091237-cortex-carnage-5c34@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Sep 2025 16:44:56 +0200
X-Gm-Features: Ac12FXwmroMltqxSRZA5meL-lv7f9pG4WBQaN79qLPeFe99REm_I5nZVDR76A38
Message-ID: <CAMRc=Mf76m51VKktGc2K1uT4eacDqhsroRxG2RgtRyhQrhx0WA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Benson Leung <bleung@chromium.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 4:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Dan's proposal here is a good start, but the "sleep in cdev_del() until
> the device drains all existing opens" is going to not really work well
> for what we want.
>
> So sure, make a new cdev api to use this, that's fine, then we will have
> what, 5 different ways to use a cdev?  :)
>
> Seriously, that would be good, then we can work to convert things over,
> but I think overall it will look much the same as what patch 5/5 does
> here.  But details matter, I don't really known for sure...
>
> Either way, I think this patch series stands on its own, it doesn't
> require cdev to implement it, drivers can use it to wrap a cdev if they
> want to.  We have other structures that want to do this type of thing
> today as is proof with the rust implementation for the devm api.
>

Yeah, I'm not against this going upstream. If more development is
needed for this to be usable in other parts of the kernel, that can be
done gradually. Literally no subsystem ever was perfect on day 1.

Tzung-Bi: I'm not sure if you did submit anything but I'd love to see
this discussed during Linux Plumbers in Tokyo, it's the perfect fit
for the kernel summit.

Bartosz

