Return-Path: <linux-kernel+bounces-825953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FFB8D30F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 03:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599981761BB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FF156677;
	Sun, 21 Sep 2025 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20230601.gappssmtp.com header.i=@jclark-com.20230601.gappssmtp.com header.b="p7iK9M6E"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F8B323E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758418029; cv=none; b=KLYLWpk0XWtWkjIqn1vAVwQCLIcS2HfTT6siObBlqDHpoq1ClAV/8zAVfPKMbQuFqWsu3V+SttTFo2If58Fz9XRzoWbjHMMqWmbpfID2BfCzbHDtYXiPtfsmyQeAkVAierc9gIT+oX25MFOsICVP5A7YS6eesaKa/oA+BdDvPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758418029; c=relaxed/simple;
	bh=jOYRiNRH+mKFdeAGMt4fYw1emnX7ze4EEppuKHTVDXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXTT42V4yBRAfTkFcVlzedsIjiXJ8ICzlAqEwTMPImMe6eoA0qmpE7i3Sfm7wGIAGziZ/Pw3Woey4z3ekc861VGjRC6ggfUp6LYPodeVkb2sVAjOoiAKx/DoGaOTYkmSj09GGiOMQPhKukv+WnKixW7MOqlP0YQ+fqkiVOfXMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20230601.gappssmtp.com header.i=@jclark-com.20230601.gappssmtp.com header.b=p7iK9M6E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26983b5411aso23111785ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 18:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20230601.gappssmtp.com; s=20230601; t=1758418027; x=1759022827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOYRiNRH+mKFdeAGMt4fYw1emnX7ze4EEppuKHTVDXw=;
        b=p7iK9M6EvoXrq696zkfQwy4VGp3r4UTX+B5IahaGY0ju0GSAUvmHVCwamb9Adg+OZD
         YE8OH+JxxFI+nN+ZZdOTlooQGQdWDv36lFZiAHZWXdY//a8Fh392EH2fS+vciO4y99ha
         4Yqa4ABW9e4oSx3ZhCw90YAiaLyvVRkzv2hBeq9U8gbnod9VcCUR92qVmuO+NN0cC6W4
         FFNQTTf3JFEXzSCVWBg5w7MY4llSq8CDkmkC1Eusy8TvBbn+yu/cEY6IbswZ5qWJz9hd
         DKXuRf/btjzSK2LO8qs25ttecgAaHYNv2IMG0ajShiIwbKRInmzkKmGMDAoTvSSdGv00
         HR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758418027; x=1759022827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOYRiNRH+mKFdeAGMt4fYw1emnX7ze4EEppuKHTVDXw=;
        b=NwVw3AUQX32ugi9o9hhTrxOkBd0mQzFUexLbVsIOZ6x50TTgyMWL0qYtxcLRo520AX
         QryocN64v4tNYiw/EjoAiNxJUUnFsKUHjK28R9IFE469JeZ8iyWdaBWmsd7wHYIhPp7I
         UoxwaAHYlPs2Yfh/PfJSKL9hsE7zKTJxoHFU+Q7o4BaTVVriY1QhocJMI6jvewN+LeYC
         0oZYC3b4Ip9NkPsGkZuMMRfol5FBRxgwgMuSfKat2Ej1iX8wtMGQ1ublfbXZdBHwg7hD
         VPCrgo6+itcWJMAU6SZvKJEdTSL+j7X8gFBGHwcE9L4x8MB1+omiJ4CigQYHJHxnea2+
         Dn7w==
X-Forwarded-Encrypted: i=1; AJvYcCUEEoE8oOn8zmAxOWzTtNN+/wNyhenWeU4F1h/CiliCt08ZalABAyMaKLyOYIw8JMw4nxLab8/GthBlt0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rpy93pLzKADr7mQGAFOphuDSWp7F+/xj5ONxkDha+On4wlph
	7fUz/hvhTPEu5eVLjUCZ0TCtgoQvOz7gHKFKVNKwheg7eKOu973oeqV7FUnv5m61sxkmnBwKudL
	UXIZsPVwrlJMEeT90PBkTkq0/cpTxtq7vYQubzEqH
X-Gm-Gg: ASbGncvz2PkF4qJnJOcE7ZhG8PPY5ighzsZ6BhtwVVgg7y5+db0IzHyxsARB7x2eXzF
	kKilrrGBcM+65kgB9+j0Mo6p+YqBA+ZAo9Qkzx62hJoXUf4GPRahXqxsXQ6oHKpLb9dy7ikTDeE
	soIo32KmJuF7lnaVQQDzbrOhpKUJFvxpNacNGj6S7ir3ImBhbrV8pXIJ257R9JIzQX4T0O1ZaYP
	HEbtQ==
X-Google-Smtp-Source: AGHT+IHwOY9FzfFflpPvV32W3cCjKIQ/BIIsK/b8i+3x+5D8+1bzG0I/BLH1Mr/TzhiTDy+Bq31WR6MFh48QX7IwYw4=
X-Received: by 2002:a17:902:d50c:b0:26e:49e3:55f0 with SMTP id
 d9443c01a7336-26e49e38a46mr76143345ad.16.1758418026757; Sat, 20 Sep 2025
 18:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
 <20250919170445.45803d42@kernel.org>
In-Reply-To: <20250919170445.45803d42@kernel.org>
From: James Clark <jjc@jclark.com>
Date: Sun, 21 Sep 2025 08:26:55 +0700
X-Gm-Features: AS18NWA7MDIuQcCMY0KZGmS_ycTr5aATrXA1LnuYqmcgKelJdnynAr31FmXdKgc
Message-ID: <CANz3_EZO_UJc4DodMRA721Ns523x-wJeUiTuOTiNu2SrhwcgEg@mail.gmail.com>
Subject: Re: [PATCH net 0/3] broadcom: report the supported flags for
 ancillary features
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Kory Maincent <kory.maincent@bootlin.com>, Richard Cochran <richardcochran@gmail.com>, 
	Yaroslav Kolomiiets <yrk@meta.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 7:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 18 Sep 2025 17:33:15 -0700 Jacob Keller wrote:
> > James Clark reported off list that the broadcom PHY PTP driver was
> > incorrectly handling PTP_EXTTS_REQUEST and PTP_PEROUT_REQUEST ioctls si=
nce
> > the conversion to the .supported_*_flags fields. This series fixes the
> > driver to correctly report its flags through the .supported_perout_flag=
s
> > and .supported_extts_flags fields. It also contains an update to commen=
t
> > the behavior of the PTP_STRICT_FLAGS being always enabled for
> > PTP_EXTTS_REQUEST2.
>
> James, would you be willing to test and send an official Tested-by tag?

I have tested this on a Raspberry Pi CM4: PTP_EXTTS_REQUEST2 and
PTP_PEROUT_REQUEST2 both work. Thanks!

Going forward, I have got myself setup to be able to build and install
a vanilla kernel on a CM4, so if there is stuff that needs testing on
bcm-phy-ptp, just Cc me.

Tested-by: James Clark <jjc@jclark.com>

