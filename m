Return-Path: <linux-kernel+bounces-876182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61913C1AB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9062734EB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B5B2139CE;
	Wed, 29 Oct 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns+hBSjr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583481482E8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744543; cv=none; b=qs+XeOOpmgRaiLSg7bIc93ZPeIW58KfcQEeOr9o+dXa+rPTtXHgE/Q3DDxKd+zTCzWYPOREpFzS20uabVDMNw9j8y10jDbwtJ5H4t0sSZH+FKFpaSSF1P11NqrnkkvwHRyW9AmRHb26MAkuZxZM6keTbEOXYL5AD3E98oEJVwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744543; c=relaxed/simple;
	bh=V8J0xvZ85AOyFUwvxTu3obUZitEUBIFVJbjXz+jtx9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iD6uBtXohRJ2PM1WJHW2RiW9ewtzOVh7iOw0MvA5Lm4FSEDsBS3IZgo3UMfHZzRz00t3dbJ3NWXhHaXipY3jXjPQMss/3KhXhaMZQ0hdsglz9XL24yb3u5tMchgxYkmXaTNOmn6gNe3yDBFUu4uYYRnPuXDqfHF0vFavyA28x2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns+hBSjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCFCC4AF0B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761744542;
	bh=V8J0xvZ85AOyFUwvxTu3obUZitEUBIFVJbjXz+jtx9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ns+hBSjr/WyBh3K1F3sAyZiXTk0bBgP2+BJYgAUZquOnMGf1mlsVpS78Yv86/b/m4
	 CPMVkMiH9/4coZ7HtkXcNnqPVqlFaHRKwgKz+aXblha7cfoxgV7TvQFp4C39Cks6Aa
	 T/XwD000zfxgqh3txVB+TtIwAe36ND8kw78D2xn2QIA9JS6tyJO+CutAU249x42DrO
	 zpKxl+xQFtzLr55gO0KMj1toECeb7F/oupInCK1mxSH+S4bqOuO9vj+U7CUxv5/bOF
	 zgtCb1oG+OJdYjtdglqPBSmVOo2LLsgnnyxYV7bseQ8tC7jTHoAHE77DZiUaDoY3/k
	 WSP9P7ShZheVg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso11147659a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:29:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUP/dn45jLQY5GAed0v7ELdtB5heeCT/AtY0Pa7uQw1BoQxqUr9X+StIIuyVClo6HNEtYVIPIT3CLVFNys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjhcNOsnAaQRsH7DDwz3v0dgPTmTfMiglDfT3crJEbvksCixV
	qwCQZntMz4f6nvSlvaDCsIQwSuTJJ0NcrkO1KdfYunfCpWZmNj9BwZgNq+lrtpLdv14X8bFiso1
	T6QRJJMFnY6aRT1CMJ7RmxekVwrIPOw==
X-Google-Smtp-Source: AGHT+IHI66z2+Wy1IZFMnUdx5g+GMlZnEl4AgfredAbI3iQtA8d/rgYvCJw+HiU2ycuaI9mOG0aE98R28JLtoJ52E7Y=
X-Received: by 2002:a05:6402:44cd:b0:640:464a:56ce with SMTP id
 4fb4d7f45d1cf-640464a5bf9mr1937220a12.2.1761744540388; Wed, 29 Oct 2025
 06:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
 <20251029-knp-remoteproc-v2-6-6c81993b52ea@oss.qualcomm.com> <20251029132340.GA668444-robh@kernel.org>
In-Reply-To: <20251029132340.GA668444-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 29 Oct 2025 08:28:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJALs2=qAv5OkXzAvteSc0uUza_FMubTdEcrs7fe2r1rg@mail.gmail.com>
X-Gm-Features: AWmQ_bmQUz1cUpz-qP4YsTh-ZRfrLy4fDLLOGOf77uIu22TQpbJbLmGmD_zxXy0
Message-ID: <CAL_JsqJALs2=qAv5OkXzAvteSc0uUza_FMubTdEcrs7fe2r1rg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] dt-bindings: remoteproc: qcom,sm8550-pas: Document
 Glymur ADSP
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com, 
	trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:23=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Oct 29, 2025 at 01:05:44AM -0700, Jingyi Wang wrote:
> > From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> >
> > Document compatible for Qualcomm Glymur SoC ADSP which is fully compati=
ble
> > with SM8750 ADSP. Also with the Linux Host running on EL2, the remotepr=
ocs
> > need to be hypervisor independent, the iommu property is mandatory to
> > ensure proper functionality.
> >
> > Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> > Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml     | 13 +++++=
++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-p=
as.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> > index 3b66bd106737..8cb839ba1058 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> > @@ -29,6 +29,7 @@ properties:
> >            - qcom,x1e80100-cdsp-pas
> >        - items:
> >            - enum:
> > +              - qcom,glymur-adsp-pas
> >                - qcom,kaanapali-adsp-pas
> >                - qcom,sm8750-adsp-pas
> >            - const: qcom,sm8550-adsp-pas
> > @@ -101,6 +102,7 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - qcom,glymur-adsp-pas
> >                - qcom,kaanapali-adsp-pas
> >                - qcom,kaanapali-cdsp-pas
> >                - qcom,sm8750-adsp-pas
> > @@ -247,6 +249,17 @@ allOf:
> >              - const: mxc
> >              - const: nsp
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,glymur-adsp-pas
> > +    then:
> > +      properties:
> > +        iommus:
> > +          maxItems: 1
>
> This doesn't make 'iommus' mandatory as the commit msg says.

Also, 'iommus' needs to be defined at the top-level of the schema.

Rob

