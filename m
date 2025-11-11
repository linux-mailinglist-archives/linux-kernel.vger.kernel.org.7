Return-Path: <linux-kernel+bounces-896131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5BEC4FB88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3463734D0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2A2FFFB6;
	Tue, 11 Nov 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/mBL3VH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F325783C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893564; cv=none; b=Tgho2yuH9watvkgqpuM3NewezJDSY1ch+YGoZpXmfefBr8idwV9vI8UMS+xYzgBCQkjN+n3jwhsp592sLZvWBre/FryddpNgjJ5Zy9vKfOrespmsfkU7s7A9O3OHtOrabFuZE/R/8d1DZiMiN/C+yk7GOF1eVBTdk/iEfrYNwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893564; c=relaxed/simple;
	bh=u1iRB/FagiRIB7UpPaeARkCuG/fTT+SIP2ZHQ2tbwnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdlbWts0QLMEO8InbR6U2wtgvlZt6MSP/PKxIV/JGv9qdOLbbSJRla/5ApgouMA5HxQYVitqsFXCefz/1lBjX+U7MHaizWAQhWG8cOXmPF7P12/9zuiG0SUdhyCwAw3jOyzZTCeFixbPre+0gZwAWrTlKbngAuTsJUzhZ6RWMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/mBL3VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD50EC116D0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762893563;
	bh=u1iRB/FagiRIB7UpPaeARkCuG/fTT+SIP2ZHQ2tbwnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l/mBL3VHCPRusfj+VtMLNiPKUrE/0gms/KIhypU5BRrs6+LiEZTcSMCHArGDn9FS6
	 bZCV6dLpGeOJkOZ8ous+xFmDKOOUgru71IJxORsJI1jxb+xrg3RN5Q+P161Q1TuU6B
	 8ElMoLbg/CM0RRIdUpEDtcXnOkDQdGsvV8kHljs8c+mzLOQTht6o5QWXRMmoBmgBk5
	 XVSkVJIlCVVDXnAes733BxgSltbMhHmsTIl8DJSLI2m+IYA/uUWbfqcUMUFlGJVReK
	 /PKuV2wO6Mo21JYuOn4yDvMjRjMuXciHUImnqw7HfTcM18H4GWig+6OXonWDdJUqd9
	 EuXU/sJDa8rSA==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c82bf86bso43027f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVL5MbvgXjPLSpukdma1Xhp8M6Cz5JSWm5F2NjqT5Icp8mVb/s85x4eWHpnsRryXyKddWSt2cwZLeEnFfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYv5zfJivCeWICjoCrJMJBS4vp+6h1i6hVwt72VvzvGOS112ct
	TzRpsThX1GR5d2S050jVm0rPf9ZGVcoIXkNrYFWT+MCJg/7rMBVCtBLkCCAXKaQUTjY4Qr8W2u/
	FRboP/efM0/B8qH2RCUWkWMLSpxVAJw==
X-Google-Smtp-Source: AGHT+IGvpEcD3av3nMae+EjmI26O/IovDwBiGXp0LnaaAwRRYnwAtL98IODaAhI4juu7w6dSw+17AGxnVtjXf/0jDGY=
X-Received: by 2002:a05:6000:24c7:b0:40e:31a2:7efe with SMTP id
 ffacd0b85a97d-42b4bb98114mr461806f8f.14.1762893562134; Tue, 11 Nov 2025
 12:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
 <20251107-active-uber-impala-8d9118@kuoka> <49339695-615c-4a89-974c-ecd4ea1b544a@oss.qualcomm.com>
In-Reply-To: <49339695-615c-4a89-974c-ecd4ea1b544a@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Nov 2025 14:39:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ7+czY0=98PtpVDJB3XkLA0JumYan=22Y-TXpY1UFRiQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk-Z6Q7oXVD8FEdhINi7jHzcZfPOjZcAWC1Z8NaeO_NPA6fgfgsGYJ6W8Y
Message-ID: <CAL_JsqJ7+czY0=98PtpVDJB3XkLA0JumYan=22Y-TXpY1UFRiQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, 
	dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com, 
	bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org, 
	krzk+dt@kernel.org, saravanak@google.com, prakash.gupta@oss.qualcomm.com, 
	vikash.garodia@oss.qualcomm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:45=E2=80=AFPM Charan Teja Kalla
<charan.kalla@oss.qualcomm.com> wrote:
>
>
>
> On 11/7/2025 1:37 PM, Krzysztof Kozlowski wrote:
> > On Tue, Nov 04, 2025 at 02:20:59PM +0530, Charan Teja Kalla wrote:
> >> The iommu-map property has been defined for the PCIe usecase and has
> >> been hardcoded to assume single cell for IOMMU specification, ignoring
> >> the #iommu-cells completely. Since the initial definition the iommu-ma=
ps
> >> property has been reused for other usecases and we can no longer assum=
e
> >> that the single IOMMU cell properly describes the necessary IOMMU
> >> streams. Expand the iommu-map to take #iommu-cells into account, while
> >> keeping the compatibility with the existing DTs, which assume single
> >> argument.
> >>
> >> Unlike single iommu-cell, it is complex to establish a linear relation
> >> between input 'id' and output specifier for multi iommu-cells. To hand=
le
> >> such cases, rely on arch-specific drivers called through
> >> of_iommu_xlate() from of_iommu layer, aswell it is expected the 'len'
> >> passed is always 1. In the of_iommu layer, the below relation is
> >> established before calling into vendor specific driver:
> >>
> >> a) For platform devices, 'rid' defined in the iommu-map tuple indicate=
s
> >> a function, through a bit position, which is compared against passed
> >> input 'id' that represents a bitmap of functions represented by the
> >> device.
> >>
> >> b) For others, 'rid' is compared against the input 'id' as an integer
> >> value.
> >>
> >> Thus the final representation when #iommu-cells=3Dn is going to be,
> >> iommu-map =3D <rid/functionid IOMMU_phandle cell0 .. celln len>;, wher=
e
> >> len =3D 1.
> >>
> >> The RFC for this patch set is found at [2].
> > So that's a v2 or v3? Then number your patchsets correctly.
>
> Is there any kernel guidelines that patchset should start at V2 after an
> RFC? I do see many patches are follwed by V1 after RFC. Eg: [1] is an
> RFC followed by [2] as V1 -- Or it is the maintainers preference and
> expectations?

RFC and version number are orthogonal. RFC is a condition the patches
are in. You can have "RFC v10", though I'd hope not. RFC is like
'draft' in Gitlab or Github PRs.

Rob

