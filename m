Return-Path: <linux-kernel+bounces-842084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC682BB8EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 16:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9087F19C033D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0C214801;
	Sat,  4 Oct 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="K3G0EyBS"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8183205E3B
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759587544; cv=none; b=h9ICX7t+g9f/ZDOrOZCmCFsjFQ3+/V5454VxmdALUP03FgYPg/SaIuTR7VfaZBKj/hUyMNDiTDIs3erjwZ7IRY4kF+vMQr1pdpOaU733dVSVfxcRxIsZZ79+rcmRteiK60XbehSgsfaxLOP0q9ei/+ET5xaGAAT2PZPmWi1tHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759587544; c=relaxed/simple;
	bh=Fs4Td0PMqDAvZesXBf5elElYymUDiUmK3kzTJ0Fbdko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2WXoBJwlAumHLz+qQZMNgTsI9mYas/jO2tlXvLIOtndMwA1hLXgCRVyNF9aci+7U8atq2IUNMnmoTh2W7Y7fJ5ctPL8x6rGZvy8LpuMKoTxJJRhvgb5O6+XYHgSa9JM16Q5sjibUtVOMZs5vY79M0//kcgzna6S6ny2KCA2teo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=K3G0EyBS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-373a5376d0bso33237591fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759587541; x=1760192341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs4Td0PMqDAvZesXBf5elElYymUDiUmK3kzTJ0Fbdko=;
        b=K3G0EyBSwWHx1iAfcC6afwTtsP2B6M9yC+qZtrjR7pukrDoofASiGwa4fL5oVTXk4a
         heVPlqQpKhPXEmGnGW8hYITnle7Zs6XQ+VXGcmlHLnwMGjmN1e/lr9Pkc8dy0oMVAnyZ
         oisKcfyY3wwinAlsfGiZvK2ScCN+o7ZbqNkOMWjBIwwPoco4I+k7w59gZ1PnkwSRjzHf
         qTkdbTfKyCSghmLAt02qHHfT0tYlR+3VPgYsbe9K7kS7iiDam0wwon9p9IEbCMnJ7wiH
         UrlsR96FCtog3GeHPELoibwT8arYilnfP+kn8FnrYASKCUxLPQYwWVwV+Qyh7gMZQoee
         C/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759587541; x=1760192341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fs4Td0PMqDAvZesXBf5elElYymUDiUmK3kzTJ0Fbdko=;
        b=wbNUbIpv6ahhu4s8ol2XPHsQhfzlbeYtoz0DwtgMZ5CUt7LbUX/cyEeA80SlDNH7Ne
         cs6AYb0pHtsCOuMoJjkeZsKZU2F/eXCUB9ItnJXtdg6NTZAgGz4pBt6qmQUsNJXXyTjX
         Mup5SfzB38T7Lw0jppzTlvLvyiJVdrbyHqulvNsL7xs0CHLyI/EDPZkb38ZBTgtvK/rl
         8qKNpKCKBJFfm/xJPA4CZWcrgIjT3FX6TpKXJg5fD+33BDlP9uYVg0liPhuNJagmdPZ/
         dykMKOnK0XWsmKVfs0S+NhHfr7vbpl3HwXq+gbFdxiQVcD7aznnQo8uSPGzH5p4aLsqK
         BG3g==
X-Forwarded-Encrypted: i=1; AJvYcCWfH9URwjkej6VmL+Zxu1EI/GTFoGoFedFYMdhvsFu0LB8ThWgUljz9F929Fa5F5Y1CSeBKU54urgUv5ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6YSTLSDK7m5FYn7+XN/vWh4X5s+kbaTAkvljeNsW55VOc8OQ
	8/vV/M2nJToXHiahzS2kLLJ7VtgG0LA+kjsalNPm73iBR88kWb23NHlcQxbeq9OG+vFewMSUaXA
	AYqQTZPF9DMJLpEwVu/KK5KEb/3nugNgy363erjfkIA==
X-Gm-Gg: ASbGncvo7zjPI/d1p1QjTFoaTzz5gVOwrMbHP5+liDtGLFMK1eZsnryrVE+OxtwvZRI
	NRtc4+D3fPwaFzCF+7Y71qM4jwjjJ4ZwwoZNjtBMFLPQ1gt3giH/79lE7+PB3W9eDoQp5iKjra+
	LLHfsNLjqoT3IVTUb4rsp771igV3tvQcnSm8RlmKsOpzKGhYnrFMf+V/2PQGmp+cgR93HXtiNcV
	IHA3XFX57xrul8jwsyIfGT4S+yLSxA2JtHavRM0PxbWo7Y5PPEqqRi+fIHwHVJBSm3GJNz7hA52
	8l//EBLX
X-Google-Smtp-Source: AGHT+IFxJhujf/JEJFinAISvCYQxGDap6lxZLW3dvJRDEoihGAkLv91WxlPHii/cSibBOV6XplK8oqH8DyeoFN75R/k=
X-Received: by 2002:a05:651c:a11:b0:372:88fa:b680 with SMTP id
 38308e7fff4ca-374c384e15amr18469051fa.29.1759587540893; Sat, 04 Oct 2025
 07:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004141539.6512-1-brgl@bgdev.pl>
In-Reply-To: <20251004141539.6512-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 4 Oct 2025 16:18:49 +0200
X-Gm-Features: AS18NWA7nwSBIvK3ZCwEcd_HigJdxeufjWRzlxAnyotRQRzHX-B4cb1IwxlUYaw
Message-ID: <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Johannes Berg <johannes.berg@intel.com>, 
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, 
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Ilan Peer <ilan.peer@intel.com>, 
	Daniel Gabay <daniel.gabay@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 4:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This reverts commit e3fd06d1d8869747e02a022e3c9045a3187f3aa5 as it broke
> wifi on my Thinkpad P1 (Intel AX210) in v6.17. I don't have a better idea
> than reverting as - contrary to what the commit message claims - this
> chip seems to still be using the commands removed by this commit.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

And here's the kernel log: https://pastebin.com/zrTPbE0j

Bartosz

