Return-Path: <linux-kernel+bounces-738730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47332B0BC63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03527A5478
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CACD21ABC1;
	Mon, 21 Jul 2025 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="KbfKfSOg"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD50BA2E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078584; cv=none; b=JMWTREAn4OpgXQtaG0pbTUoNxdimHvdjzh3qxBP9RPPUARStJ/k7Yq362KOBKYYf4flFIDtpQuPJ8F55dV4ar17iF1H9kuCMyGma2ga9LhpXciAVrP4o5+6Y3vIGhh5JJh+3M+zSXGp3fOxS75JB9v2jXEhKVyu9EvoXlOP4X6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078584; c=relaxed/simple;
	bh=GUc4zOTrw6rvLMO40T/UgBsKF5bRBvOA/F4vuJPWfyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHwpeRHMgiA6Chr2Mu9wZFvIPjq3oL2kRXudxhEmkuM8e+/rTgkivnxbH+mlOY+knH+zNjKQnc+HTW3dJQBwk7iS9n/Ew/ZvfzdKSKHSi9TY2xjG6V68uTcqk9Z8NR1SoBYinlsCwMwrlaAAPoNORVU0yd7//BJBnN5l+AvHNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=KbfKfSOg; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e75f30452so25044517b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1753078580; x=1753683380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc+8d30/lECxDA4kACxmWGz/FYGhtz49xv0EhBIV/+U=;
        b=KbfKfSOgF98uCcn4z6goauXqL/G1n86qKeBN37hdjYhK7+ELcSV1Q5wSrmY4zx2nQT
         WwVNIxUJwSo2WMpeoZuYEIV6oFxKSAAMz/IRaIai+8UBMycol1P6+2NRwLCdepPRZQ1q
         f939z2BFKRRB6M0qVTZANABM9SeMZ8iB5+8pqS9vHMOgCFHe8eFSaV++ud91Ynv0TrGa
         XNuNYD2Ar9ZiE+UrxU8opOQgLzylStb9zTlubEGMtVuyLO0/rjNKejYQHHxSThYgc4et
         5vCfcJ8QalPROWbC3pX4slldKFFh+uj6d0MYaM6xuMobQl6YQ8501fpr0DyMcl+JUp1W
         GXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753078580; x=1753683380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc+8d30/lECxDA4kACxmWGz/FYGhtz49xv0EhBIV/+U=;
        b=MTNp4Pel7i9xrWX6CD8rZJuM20EzOL/ZKBYYcGVTacskvYrJbaa0c3oMaksGqF1ok8
         IElKU4wmLDbsMIPaoPjDOOJ41magU3SmN9Aq7bjJdkJz4eEy9j5kYdTNQu+EwCdg92F+
         gqXgji0kPIARo83sbyq9LtD/+4YSYle+a3BhqfhPVsyaQeEtA9R0kRciQZb9s50bhJ74
         8cbDZYv9nh688gUwESuXfB+7ie0aimWK7s46hNkNgJHwOVaLZrLXMVNVjTlW7qMywn2T
         WQh+IizCI/AQajSyyto+0Dcw0pR7kcmWWxOmPm0WUUsypjY2mfXxwsA0qkpZ4ZqCmbTC
         nheQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLxQAYszMKDjzyhGfjq3HT7bXyfQ0DMHMe0FMYRIizt2Suys2AMwjQLIvuxza9UFVKH0xPTWVN9YUqBjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRHiyx/5pb1KagCz3CoTVoWVBydOG1033LowC5mQqfgNcvQ9J
	XTpvdQwhAF34zC69+HYJuY0gTvRMD5Y+BtBBUuS48mP1Lw7uZ0orwehO27hs13efQpa95ofbWQW
	Tcc2O0ha37cFjFEQmMXkPE0VrM4rRtjLh0ezN3uIP
X-Gm-Gg: ASbGnctR5u3pU4UwmcHX+YcGMDzYMI4ABXof0L+S5Oa0+3qSdLGsFCLNZHO5OPTOEJG
	NzmuHtcJu22S/sUACc8/TPFwYDAxfsPMDj3vA8Uf4Yt+q877CheFjIMkCOdC9GIr4fcGQgifbec
	JoZcAvLFzn1n15wKdM5xQ6hX72+DZVdyGn3ph/qWFiVdFdzRU8gnR/6/igzlgb+xQg/wQ8BUrZd
	1NskCbq
X-Google-Smtp-Source: AGHT+IGRwpf25+vUlulE6Wz5IyRHrtuPkjnRo6VB9vcyy4Fv6C2MEkl6YVAFLufeirWkbUWkkmEFvWg2NDdISthx/g0=
X-Received: by 2002:a05:690c:8690:10b0:718:38bd:bb45 with SMTP id
 00721157ae682-71838bdd042mr172589917b3.40.1753078580164; Sun, 20 Jul 2025
 23:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721123801.78841075@canb.auug.org.au>
In-Reply-To: <20250721123801.78841075@canb.auug.org.au>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 21 Jul 2025 08:16:09 +0200
X-Gm-Features: Ac12FXxxVJYG236kfXwBQl9DCO3Im2UTmjoaPG9PJPEy64er_QDNkUdsVy8NSYY
Message-ID: <CAHTX3dLHcQe3aZ8aSyJO7KuidbFzB5Jcb_=EcEZL5D5=btKw+Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pmdomain tree with the xilinx tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jay Buddhabhatti <jay.buddhabhatti@amd.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen and Ulf,

po 21. 7. 2025 v 4:38 odes=C3=ADlatel Stephen Rothwell <sfr@canb.auug.org.a=
u> napsal:
>
> Hi all,
>
> Today's linux-next merge of the pmdomain tree got a conflict in:
>
>   drivers/firmware/xilinx/zynqmp.c
>
> between commit:
>
>   ef32394c6d34 ("drivers: firmware: xilinx: Add unique family code for al=
l platforms")
>
> from the xilinx tree and commits:
>
>   3da405ead651 ("firmware/pmdomain: xilinx: Move ->sync_state() support t=
o firmware driver")
>   29ea33866d6d ("firmware: xilinx: Use of_genpd_sync_state()")
>
> from the pmdomain tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks.

Ulf: change in your tree should come first and I will deal with the
fix via my tree.

Thanks,
MIchal

