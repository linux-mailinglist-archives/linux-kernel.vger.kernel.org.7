Return-Path: <linux-kernel+bounces-733705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B1B0780E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA78618862F6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE24212F98;
	Wed, 16 Jul 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JlLHCQWe"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45F246784
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676152; cv=none; b=XcAxXD1ezqlMcXYutn+w62HmxfWp2MxovgJdp/D862quyorG/jGg4RnH2T1BI/6qwSku7EjB92vtV7aULJaOJ9/pG/fdk96tz6BAXjCLE85FIeh3JNrciAavMm9BQC3IOzxSa2bdNIUrCzL+EdkokBGhhym+Sp48XwtgIKx0wXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676152; c=relaxed/simple;
	bh=HzXwiqqDnfe41YiTu6uYFU8UDZG1ohDw66m7kk99BP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBIsLi1ze8XAsjryZ4h3pWAqrpQ0a86flV3M1ytBTfHnCtlfHnRTuD68otcQs8Ua75gJadRioq4QL7jIZjlMi6PCoo9MWAUrBbS7ssQE0PqFoNx1wE8xy5JUwzjHOwWkllHHXeGA1NvRTbRAr7DyZ6TsP+HLGdknuYHI+KboCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JlLHCQWe; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2f77591f208so445134fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752676150; x=1753280950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuHTPSN5ob/sxMMWugl2mb75NZygOdwpDw39+8JfWkw=;
        b=JlLHCQWe5q4cDkdJvpru5s74wmlKyD+Utnmfj9Ui3Glh0BiVEue9i9sMC604ZuuM0F
         rLveSl1HicWwuu5YaCWNGcKNEX2hrYrikuTSUQYHhyGfLgkVQXhi1Rt9h3wqbn8De/gP
         PWhQvwwW0h8TkxbB86BeogsopE6Aa6NXI7oY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676150; x=1753280950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuHTPSN5ob/sxMMWugl2mb75NZygOdwpDw39+8JfWkw=;
        b=HjLAFMmriFcGt+0QCcyJD4RpKlFaZUPDASl7R8K3cbW+8F/1jvs/N1NSz119BqD3uB
         qpNMane9heiapB6+mV7mcdV3LF+XIh36LNHAM6DaZubsKX86+cAmgYH9GSYh2Y5iKzVG
         VpujEDUiKCq+gs21wxuEQeUfXx1PvnsJHrJ+rcgYaenkU1z2hN27nOastYM7X6mJCE0N
         LOET4sbgX/zLzb8uSpvG0WpnNBUiYrwPKuw63xucDbZ00gf/MrQKSxztVCeSJPr28QxK
         4Dmh31LN4+N1vDVb2jYxWl+NXT4bTvLJCP+pkY26IzYNLQXPsORu6A5mfxG1+gOMgKAf
         B43Q==
X-Forwarded-Encrypted: i=1; AJvYcCWazp1HkLzGaZ0INkyb3oyXVnjPcgkm2JcT4Jh4zonQ0RF2xb1en1v6u9AjU8uHRXLKW0Pwu1sXGi3EHyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpjGErINTE60nlSIWmeHND+Mca/w6KfV9L5fRN0I4tG01kYg4
	+cHJ3AK0D/MVcJ+kdOORl4a7OIgrCxKcoX4lc8uxlEhN/f+jEpiXoqT5jz9kVyUsZphQvSv3H7A
	GrME=
X-Gm-Gg: ASbGncuhp5Thjtx6z5zUFiJPGfdkyK7M9a4Dk01gtFuhWKHZYuOcRnnngVSSjziuEr+
	oA2gMjM73mW4R2EH/SjsgGjXmvqnCOPeYQV0IRxF2MFq1jWAemd1R7jVVfa/0cAGnP9f6bUWJNf
	pZORbWUXah+2PDasIQqol+uzSYaqoD6r1NfFRotGAjYOdEu6Yt+CrmXaXN0UXkj4RdsQusgSGBd
	/1ynfeXqNQOxnxZn/pX97BGXQjNomu83qVbJEMWSnPa8oG0SoQVjGgMZjduKA8XN+LpjBjplD8F
	WR1KJkhc/dFjNZ5gfMUy0WXzf1mUUZAWgYIp9yeS8eBuhN9hF0xvfH0yEK1uyrRsyH+He+0uHYl
	RqHkS6MMqu16Ab20/nzjgGtQuDFxSzqcw9buzzzvkqeLyAelCgfNQqrm8MuqGvg==
X-Google-Smtp-Source: AGHT+IFHzatYTHFXnhr6EcP2iIXFISDf8iLe+1MLOgiBBbPDoLdmMvuFJgxcbwRfxwocsGIztAppnQ==
X-Received: by 2002:a05:6870:168a:b0:2e9:42a9:be4a with SMTP id 586e51a60fabf-2ffb099d51emr2539373fac.2.1752676149657;
        Wed, 16 Jul 2025 07:29:09 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e5ddf9a64sm1138953a34.56.2025.07.16.07.29.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:29:09 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73b5350980cso725761a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:29:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdYZsjp85Ddgvwwu6LLBnSda6jw7g3w78+dIofhMFYCZjekyACRNymKDW7HTaXptahpWsVw0Bkf0zQKAY=@vger.kernel.org
X-Received: by 2002:a17:90b:3e45:b0:310:c8ec:4192 with SMTP id
 98e67ed59e1d1-31c8f9bab05mr11330150a91.10.1752675724138; Wed, 16 Jul 2025
 07:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-3-6fa8d3261813@oss.qualcomm.com>
In-Reply-To: <20250716-topic-goodnight_cheza-v2-3-6fa8d3261813@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Jul 2025 07:21:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmwiA_gX9pF5Dja1vezson7f21WHC8u8+Rhg_6OUJ+rw@mail.gmail.com>
X-Gm-Features: Ac12FXxTIFX6vNFTUbNM5dNMu4K5yloNK1nFrEKpkxnVSSYFOEXl7o-QWsvciQ8
Message-ID: <CAD=FV=XmwiA_gX9pF5Dja1vezson7f21WHC8u8+Rhg_6OUJ+rw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: arm-smmu: Remove sdm845-cheza
 specific entry
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robin.clark@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 16, 2025 at 3:16=E2=80=AFAM 'Konrad Dybcio' via
cros-qcom-dts-watchers <cros-qcom-dts-watchers@chromium.org> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> The firmware on SDM845-based Cheza boards did not provide the same
> level of feature support for SMMUs (particularly around the Adreno
> GPU integration).
>
> Now that Cheza is being removed from the kernel (almost none exist at
> this point in time), retire the entry as well.
>
> Most notably, it's not being marked as deprecated instead, as there is
> no indication that any more of those ~7 year old devboards will be
> built.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Docu=
mentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 7b9d5507d6ccd6b845a57eeae59fe80ba75cc652..646814ec7d15f6d8a0136de73=
b7eaddae232ea64 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -132,10 +132,6 @@ properties:
>                - qcom,sm7150-smmu-v2
>            - const: qcom,adreno-smmu
>            - const: qcom,smmu-v2
> -      - description: Qcom Adreno GPUs on Google Cheza platform
> -        items:
> -          - const: qcom,sdm845-smmu-v2
> -          - const: qcom,smmu-v2

The code supporting this can also be removed then, right?

drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:     { .compatible =3D
"qcom,sdm845-smmu-v2", .data =3D &qcom_smmu_v2_data },

Reviewed-by: Douglas Anderson <dianders@chromium.org>

