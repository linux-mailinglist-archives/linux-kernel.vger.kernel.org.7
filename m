Return-Path: <linux-kernel+bounces-727880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB9B02101
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F384A74D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A092E9745;
	Fri, 11 Jul 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OO/lTG3l"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA71A0BF3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249618; cv=none; b=Geg8aEoQv+Ost0bR4DinBeu46mpxqAXQygUZQLohhbCFZZq8du0yhb0T8CmwIIy/7qrX2Vl5ZNuLS5faN0Ke7CtaARo7SuIscaLt4VtSZSTdMAPgEyv5ouHUFz0mMxFqiEwhS96nROsRVUJejJCXaXfLfdya6Cn1E86XDOO77q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249618; c=relaxed/simple;
	bh=ilXSp1dPDBPZtY0cNIzwyHE0LKQ/bY1ESho4fUW0cyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvj3bYCddZJSP7wQ3aj/Z6mhKVQnzd5YoANQgjXD0CjT39b787sC/THZzjjFZdEFH3YVOMlrqtorsZhFeIqYyPXGWVFRIbAa0EC3R79fKCG0CCWHO5JwjOjeKwgxW2i+L+dQltKHKw1+CL7lIGGHnSQnvK8WNnJYTOqPY5ub4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OO/lTG3l; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-716ee8947cdso24282367b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752249616; x=1752854416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCB6CevJ1bK/c1vVbFc4dLpz9PDilKCAUnF2cmyMuTI=;
        b=OO/lTG3lbzGZXS/k8iWzMGpFZr4CJgSTzdJjWp7s+hrEYv16Uw2R8420WUApwV+kTP
         FUifpm5R+EJ1XyrNy386TRv7MgQ2nRl03uDLcKundXnJKCN/81/Ubqg7ouGMCQMx/Hm7
         oe0+X69yqqEq9EgkueCUdvrXUq5+a1fFvr/ekstp8Kt83aXm/BcDa/UM9Etc/olzoqEH
         N0DSodi9n6mjDJ+Dr7ypWuPK1Auxrhw8aj3Mx2ZwXid8pFWFJKUfZbPgjeQyAO/Nv6Jy
         CrYK+d9U9GwC/TNo7dLPpsBppvt+GC8VYio0Q2CWf1JrCFBAfEsI8HQIoxVdD2S2J+VF
         6RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249616; x=1752854416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCB6CevJ1bK/c1vVbFc4dLpz9PDilKCAUnF2cmyMuTI=;
        b=wqsgMX1Zi+n88Tr1BUtfbOmiVbXEmbB7jtJ48Pug0yNUgOZSMnbjOhTDnWAaJgRtaK
         11uvCD91USXrI3Qf5r17+CRgt2Nu0Kxo9QSTBj1xo5kehBwbkAK8Cyxj18lnsAY1HiQU
         BPSx1ODRU7okhBCArDAPRL7tOz2SKzztrp5HPCzPgMFg8KDIs9IRkB/I77nPT3FuwXuo
         sO/KFRcnSPitVQgFi6g8/jf5iDwESU8cpw2YoI1fiwiSXCyS+pu0goMH+XBKaD8jDCTW
         dxJ/V7adA23aA4BtcNyEKwy/VawjhkNtaeRgwgrLoVXQaCqENHy7+G3Wubl1buQG4Qf1
         LF2g==
X-Forwarded-Encrypted: i=1; AJvYcCXylSHUfLpQlgbFa5SXGgUPNNFcmmu3Okyxsr4M+GMdduYFsYpDUwc4XixTCyI6ewxKNLVdOb0RMpnX5Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCyMEbYSrPaAACPB7gSms2sJ97dDfD8L4bTsoU65J/iMVvSg8
	YJce3nmtlsm81yonmlR+A3fmfAJz4D+xuagY73SjG8d5xxlly6MIeI1IR1iSTF6YGKUxvA5vh4y
	Chuv9H8KPpny8VFnkpZtDtazMIU6slvhQJMFlp6P+
X-Gm-Gg: ASbGncsB5AbASIp8xATrxVHcK/jmzKOlTEn1UR3+GdPLP2Y5MWyOfLQ4ZYivMqPEAYN
	9/ruMvk57ZSFgZxKx35TzoeUq6TAJ8aQ9F8YBXZcrBqf4eEme25fvx7eC5QilzQqXtGH8rf+ALT
	o+xx8p0NNZiCGa3LJyJYCjJiP3GHxFFsrwPS/0yt5r+FyBCN5SW2q2viFTZd72RHkkGuieiS/ed
	033qCwc
X-Google-Smtp-Source: AGHT+IFfR/cNNJjg4+RIPxVvQVW40HsZqZMjcC9Rp74qm/udkO1oyGvobFpgvO5YmPcZPMOvEQXWO1WB1r67pOQA9M0=
X-Received: by 2002:a05:690c:7092:b0:710:e4c4:a938 with SMTP id
 00721157ae682-717d5e367a4mr64185537b3.38.1752249616214; Fri, 11 Jul 2025
 09:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624110028.409318-1-dawidn@google.com> <aF5N5jrRUlj3SUGS@google.com>
 <CAJ_BA_CppC58kc-Uv49PSmWFcCih-ySuGDuRcO5-AWQQqcqWVQ@mail.gmail.com>
 <aGOiu-sXFj1EUQAB@google.com> <CAJ_BA_CZWvC2=i8riNe5LReLKzPXK1vPwymiG2dzLEntda7TRg@mail.gmail.com>
 <aGSuS81Psqm_Ie4N@google.com> <CAJ_BA_BQOQe61r9t9rL=UiOqpHwOoTSbQcZNe=CrCcjMha_YQg@mail.gmail.com>
 <aGZrhe8Ku7eEIRqm@google.com> <CAJ_BA_AMaz0GWxOHJYws95h3fRdErghqUXPBkhrB1_eYegOJ0A@mail.gmail.com>
 <aG4zf8rGnmt5xVtG@google.com>
In-Reply-To: <aG4zf8rGnmt5xVtG@google.com>
From: =?UTF-8?Q?Dawid_Nied=C5=BAwiecki?= <dawidn@google.com>
Date: Fri, 11 Jul 2025 18:00:04 +0200
X-Gm-Features: Ac12FXwc_XLYukHrauxzKnmHKi0DZp27r9JC4VLYNd_vnFbqd6Py-pnUP9LBjK0
Message-ID: <CAJ_BA_BmPXrMqP1VxAAGDoWHffsU2pjnuYRO3MhCb=VRq-hS+Q@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Add ChromeOS EC USB driver
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, chromeos-krk-upstreaming@google.com, 
	=?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Resending due to HTML incident

>FWIW: It depends on the bus details.  If you find my previous message, SCP
>over RPMSG also re-registers everytime after the firmware reboot.

You are right. But I'm not sure if it is a good approach. My understanding is
that the HAL/API should behave the same way, regardless of what interface
is behind.

>One challenge for current version: it makes the driver more complicated than
>others.  E.g. what would be happening if some friend drivers try to access
>`ec_dev` while the `cros_ec_usb_probe` is writing to `ec_usb` at a time?
>It tries to manage the device's lifecycle one level upper than USB (don't
>know what it should call, "session"?).

Yes, the more complicated driver is for sure not a good thing.
In that case, it shouldn't cause anything wrong. The disconnect field is set to
false once everything is ready. Before that, there are no transfers handled.

>Another challenge: it doesn't call cros_ec_unregister() in its driver removal
>entry.  What would be happening if someone re-inserts the module multiple
>times?

That's the same case as reboot/sysjump. We would get the probe callback,
the driver would notice (by Product ID) that this EC device has been already
registered and would replace the USB related structures in the cros_ec_usb
structure and the same cros_X  file would start working again.

