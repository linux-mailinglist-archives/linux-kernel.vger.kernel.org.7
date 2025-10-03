Return-Path: <linux-kernel+bounces-841832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890BCBB8582
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8EC4C3D9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34292475D0;
	Fri,  3 Oct 2025 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOFEbPpl"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F25B19007D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759531598; cv=none; b=NGkS3wRXa8FCaX6A3j95UHTFUptgRrQJ+R3HGU11w2p1IUdLOHUJBULgsEvCu/VZpnDoFVijhUQWgSd6A54y415zUobbgdYVCKBQzyq+fJE/VuZi8NQsdYTAmYUCRaHIMO1Ai4VG8p7mky9SpD19t8FPqHxthFVIwqKuRn9QMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759531598; c=relaxed/simple;
	bh=RRzb9EbzcWaKe/kIz2wio1rQXzcELI4wLEAOTIZ6APk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqpR8nO6Xyx4tyc9euo7YE2WN17ogtTEleWWuRtoqLmp6GRu2J8pSZ9s3Q4Z6hlVQW7TquHkqlTj3cm4Bx4tPD+ZyOavp0Y/N9WiVg8pCDYhZWPednZ7m/OVOMvn6UuRD4earX5gTnj16ie8yY0zStWsQZxlhQGzldTBmRHQej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EOFEbPpl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so34288791fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759531594; x=1760136394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRzb9EbzcWaKe/kIz2wio1rQXzcELI4wLEAOTIZ6APk=;
        b=EOFEbPplixx9Z3X39cTXpZkqsO68l3mc7DPvoKSZeN+d71SG3cNakQAReKw0V7WLoD
         Xf7kyacmZcshTBhwhZ432URbjPIiwqzXSvzWyd5aISgrqc1wDsJXzjP8VVDDHW9g1d3z
         c1oszm/SnA/WSn+73Qq3wbLhxKuF4zSEDPlrya2Yxt89VUJghnGxDK6zubf+I1FG3f5q
         vYbdSuBZXiI5diJHfz4BdBHNblZWJAhAZNhDNprgEmbM+F4hib1LdRC5brRApq02S8Ta
         DuxemBKKFhOfVkprR03rEmgBEylUcv6Bp+gUlXHsHUrh1bjc4V4NyEeiT2i6LHlL63XD
         2mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759531594; x=1760136394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRzb9EbzcWaKe/kIz2wio1rQXzcELI4wLEAOTIZ6APk=;
        b=woeCPyrNxehbSsfFZBZzSnUmye1dUWtdbR/8kMtLAlYBk8Ep6orDKEaT/qOtP5vU30
         VsYNk3K6IPGBrOcLgQf+6FU1ESrYXvp+VPqPlfvzjhfhfHFiBT5/+F67ekBo2wmSHqIB
         pdgGVwEGbFmSBdML2NKuMc7K0P7izr9hcDnWYTWSXv4CBcJDhfCY1voJovQZiL2Z7iqw
         iA7yKZkLydfRFXf3LtwdCiV+M2JMUqQHsOntJfCgdx3QD+mRT2Q5wOjPS1HUzgLBO0ej
         SxgRDPUKtW02dEVC0IC60Wha04HynIr2F06jDbp1FSOh/M4PWb4kIbucd0AGI7KNQb1Q
         fQVw==
X-Forwarded-Encrypted: i=1; AJvYcCWE/1ynM4MXfm0hA0zMGhbwx3MTVAgEtHJwDnLpq/axsVS0sIdFtF4Xjddm7cPtNCNvYzB7KD4Hfj1eaSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQkEUWGzTwGyqD3XA1XMLQowrt4ty9x5b3mrT+1FCGbtdPYTr
	GbezkqKxde0KZJ6mrqy8mb6NRLZcEGYQ05X2LtIvpMYGj/C2dcljyfmHwnWolXhnr2wnIPZoiYi
	7yYqgX6LYBEFcf5wLwAR0BVzbw0+CyK6gEVVpnXW67A==
X-Gm-Gg: ASbGnct8hZxEBIQcsCFo+pinFznMo5PiAVNjVGbUYIR+fTQkQ70Igg30naZCbzl9CiC
	NfS9VxkEwIrHIiCEmDn3CFNw0Aka2XQ5yqCCTxXHGyqKsa4QPwh6hLfsYG7O8Da4/iP2rOwNxE4
	BgTIygJdYOSS0plM/inuc8OlkUbHVYAOVZ8xdeX8g0bZYYulaKK8L4JML/xGoJHBy26l6Ib0iu8
	7YxWgHurh5yuG34tgRHCiM4o18lJDVljWE=
X-Google-Smtp-Source: AGHT+IF/HadVZ/92XnzRKZdK+N5eKPEieNy36VOYYb42K0muyCIWuHpmbNHkF8Gh53V2KRmz2TRbCILzngCFrxV358g=
X-Received: by 2002:a2e:bc06:0:b0:35f:a210:2a02 with SMTP id
 38308e7fff4ca-374c37ed984mr12920071fa.26.1759531594406; Fri, 03 Oct 2025
 15:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNrm_14uJmGE7MYC@yury> <CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com>
In-Reply-To: <CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 4 Oct 2025 00:46:23 +0200
X-Gm-Features: AS18NWBp7U7Lh1vgRmqbcum-97h39jeTdBguBCpXZNfuY1eJAl_RI3gdeJHEUvE
Message-ID: <CACRpkdapL6aZMSD06dniM11D+q__ZVKRGhDphEnvrsGV70HwzQ@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap for 6.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, 
	NVIDIA <YuryNorovyury.norov@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Burak Emir <bqe@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Jakub Kicinski <kuba@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 6:46=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Am I the only person who would find "BITS(1,11)" to be much easier to
> understand than "GENMASK(11,1)"?

You're not alone. It's obviously more intuitive in many cases,
let's add a generic BITS(lo,hi).

Linus Walleij

