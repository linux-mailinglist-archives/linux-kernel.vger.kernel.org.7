Return-Path: <linux-kernel+bounces-779440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E6B2F422
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820643BD839
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C02E62A7;
	Thu, 21 Aug 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmWYqJP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908E2DEA75
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769035; cv=none; b=eWFzu7mvU8mWMU3Ehco6HjhZ/xPPHq3KWYeaBS8XhvVBZpA9Xg+GzE7dcfSaRlsIY340PTbj6yxBpgjRx2R9aEjz45MT4Y7aPghpjk7gI96PgxhxI1COnm5LqZ4dddyjHOCgX5JB8y6jUDJ/xK21kBr1XHfKwGi5mEQmYW1HZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769035; c=relaxed/simple;
	bh=Z1xajZ3+05Q+UuE7jtAgc4UYFwabW7W2pYmp5EVAd0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2TJ1a6p/Z4xMFULpHjBipL3pvHMHoVuo6+oJRrajvWClDy9X84Dd8rVBQNZdZYX19mPtZ7d9WHDOjjat+vs/TeYz/x1AqqZhMRiq0MM611Y3rHBr0d5YkZpxyq9xJ2zTj+qwAsFU4VmB6u/RKR9p76Zgecr3m2C/5rpqJdBnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmWYqJP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDDEC4CEEB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755769035;
	bh=Z1xajZ3+05Q+UuE7jtAgc4UYFwabW7W2pYmp5EVAd0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GmWYqJP6+9xdwMM2mtP13N2KLVGlRrLcLUQKsuNvZ9cA2lIebr2+XKtOg5OUp/7rl
	 ZZsE0dVSDGHXv1pMJkKb6ytplsOYipwVXwvsL2M4zy296j8MqNunMHTXtTwunSuSML
	 H1TvusOqwlh7xyJh5K9XvvVsJYpCMSFB6NqpF9oBNZ8SE6QuSVLRJXqjyrKnDdLCVe
	 U4Bu1joHpiw5Z5ZiEk6eh495L57E0mJWethgPHHBKeZMqioJQ2K0inPnvacaGCIbok
	 0sjU2rZdTWm3IiKCrZUaDLKP8ckxp3RMf5CgVX3jjnGiVdCvbeXP16BZArGBDcva0o
	 v2Otqi/aOcOaw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso1144716a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:37:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOCjqA/X32GI+Xg/0iQm2EkEGM69KtkoB+CwLEwbMfzurSDzemLLED6soqfc/zhHskdqnklxPLKZ7eBSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0XJ9RATQ6AUq0Ozgqt6X+NKVGHlpUBBvah5dpN8PB0xcwYeE
	C929ZymC9OePmdAd2XzIP33BcE6rrv6o/wen/PAJ+LS078pqXFKrKTPnwbjbz27wu91WQ8tbnPh
	wftAfWZ9AfZ6H5P4NkRoZn/1FI6OkFMg=
X-Google-Smtp-Source: AGHT+IGdEZAL1HDZaBeEI7REqCxgbgwB8Bm1qPZhNWktAGRMWjWTn5Aw48GXRZvyx4s82eTiupVE5DeAdW7H6qKlIek=
X-Received: by 2002:a05:6402:42c4:b0:618:229d:7076 with SMTP id
 4fb4d7f45d1cf-61bf86dfe4amr1637334a12.6.1755769034002; Thu, 21 Aug 2025
 02:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820032229.913361-1-gaosong@loongson.cn>
In-Reply-To: <20250820032229.913361-1-gaosong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 21 Aug 2025 17:37:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6sWPQrqBPuQmb_iMurg0PJ8ifZZo1o4Gx_rEsFQ=QvOw@mail.gmail.com>
X-Gm-Features: Ac12FXwsE2tye1aLmYjgI4BclarHKvV1yS9uHVDRg1tAMh2Klsv2U2K4_TrZmHU
Message-ID: <CAAhV-H6sWPQrqBPuQmb_iMurg0PJ8ifZZo1o4Gx_rEsFQ=QvOw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KVM: Use kvm_get_vcpu_by_id() instead of kvm_get_vcpu()
To: Song Gao <gaosong@loongson.cn>
Cc: maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yanteng Si <siyanteng@cqsoftware.com.cm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Wed, Aug 20, 2025 at 11:45=E2=80=AFAM Song Gao <gaosong@loongson.cn> wro=
te:
>
> Since using kvm_get_vcpu() may fail to retrieve the vcpu context,
> kvm_get_vcpu_by_id() should be used instead.
>
> Fixes: 8e3054261bc3 ("LoongArch: KVM: Add IPI user mode read and write fu=
nction")
> Fixes: 3956a52bc05b ("LoongArch: KVM: Add EIOINTC read and write function=
s")
> Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cm>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>  arch/loongarch/kvm/intc/eiointc.c | 6 +++++-
>  arch/loongarch/kvm/intc/ipi.c     | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index a3a12af9ecbf..b3829fb4f64e 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -45,7 +45,11 @@ static void eiointc_update_irq(struct loongarch_eioint=
c *s, int irq, int level)
>         }
>
>         cpu =3D s->sw_coremap[irq];
> -       vcpu =3D kvm_get_vcpu(s->kvm, cpu);
> +       vcpu =3D kvm_get_vcpu_by_id(s->kvm, cpu);
> +       if (unlikely(vcpu =3D=3D NULL)) {
> +               kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
> +               return;
> +       }
>         if (level) {
>                 /* if not enable return false */
>                 if (!test_bit(irq, (unsigned long *)s->enable.reg_u32))
> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.=
c
> index e658d5b37c04..0348a83a7ed7 100644
> --- a/arch/loongarch/kvm/intc/ipi.c
> +++ b/arch/loongarch/kvm/intc/ipi.c
> @@ -298,7 +298,7 @@ static int kvm_ipi_regs_access(struct kvm_device *dev=
,
>         cpu =3D (attr->attr >> 16) & 0x3ff;
>         addr =3D attr->attr & 0xff;
>
> -       vcpu =3D kvm_get_vcpu(dev->kvm, cpu);
> +       vcpu =3D kvm_get_vcpu_by_id(dev->kvm, cpu);
>         if (unlikely(vcpu =3D=3D NULL)) {
>                 kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
>                 return -EINVAL;
> --
> 2.39.3
>

