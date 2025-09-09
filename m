Return-Path: <linux-kernel+bounces-808563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4FB50192
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA681BC3421
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C58135A298;
	Tue,  9 Sep 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzIa7Kh8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620435A291;
	Tue,  9 Sep 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432076; cv=none; b=GBbmLd1b/mkvuvc/QsxlMiqFQFriDcYUiYVocOFYg7NqbrZ7hDGeISrIpzY9+zTHvWUOnB/EXM2g2CymstlapvBwQ5DrNKUpg+imq89twU+dKRzIHakrbgRlnfNgp3bzUQcnUcFJDB1wDYtYe+CceTzBYDqeipGAOB6B2hy40A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432076; c=relaxed/simple;
	bh=8qTa9xeWxgzia/87N+H0CPE3siON5KYKzADDzEoot48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8cfrJ1SL3P/Sl6NYKVPjXU/szfGS/o0vZoJFx4zBXJ1Lzz/f1NubfhVfII+LLavQujtCT9iNuCeQf50E01518MaOfCUiaEIFMw0meKMH/xofdHvSUWvXbuGkYEWvd403wsVpQBhpj6zP1GyCOrHb1BAoep7PXbjmXMQTa3LbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzIa7Kh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5073FC4CEFB;
	Tue,  9 Sep 2025 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432076;
	bh=8qTa9xeWxgzia/87N+H0CPE3siON5KYKzADDzEoot48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fzIa7Kh8A+c4euikmlUP8hLomx5oWx3DBAZ6jCnnIagemusOCdrxQi+2KaoWh7TMZ
	 +MBpoROERj82RLZTPYdtuJgmmggYqlwvNIvQ/O1S73WoMPpMxauUMKTp8RR98ti9VI
	 ZFq/XjW3+lKnz9kl0F2gnCBxkUPJpOrXyBEtlDtEt1kItt8TIk9xDp5gIieCD+Vyhy
	 Yv739grGcrfZ4042PoTWTfnAnT3j4cWC+JPaN6TjwMt9IzyWf1kLRxv+rFtCdKjs2g
	 uu0wbaC1EtIMudDV43mbstoOiQy+H+0dEqMgTDqpYVVetuoqNoINgsS9OMipNkb5+b
	 ehhNxx3sXZAbQ==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-746d3b0f7e5so4329064a34.2;
        Tue, 09 Sep 2025 08:34:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0odrrSJNYxr2OIK8VXO7cUwBa/3ZcNlXD1qZugZn2UJOVc/hVPxJw7OQ/jgOw/dlf0zlv2IGepAcdg2iZ@vger.kernel.org, AJvYcCWI1xmzb/JXbwEwQ/GIBMKmIx+Z5jxk8xWU5+/nbkYS/aqNjkwREfQDEWGkxJ0epzNNBNqXV1ctCwj+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/XdlfVCFTqe3d9w3bRZLaFLQvARQF2mXiNoZU9pcCjF4081c
	e+unYK+l+3hYNtNr2qP3gOxopjO+tSzOgCfW7DB7FtqAOQW4igSGPm7kHv/nBlr4B8bYRPUAFEr
	013SuLWb+yLbGezBVvd4tzeRw8EZce1s=
X-Google-Smtp-Source: AGHT+IHWaK8rYsvG12LJ1v+wQd3FH4Ew6lJ7hajdwsT4NMXGUbcx+CA4lOF7uu7KaVTgx45qL5upgAToWfN8TS73sR4=
X-Received: by 2002:a05:6830:3692:b0:745:98e8:d7cb with SMTP id
 46e09a7af769-74c7192d474mr7456377a34.12.1757432075741; Tue, 09 Sep 2025
 08:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908053335.36685-1-xu.yang_2@nxp.com> <20250908053335.36685-2-xu.yang_2@nxp.com>
In-Reply-To: <20250908053335.36685-2-xu.yang_2@nxp.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Wed, 10 Sep 2025 00:33:58 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1ts4_qO4L9X1ZoYtr0SGLW+3EBCqSybntQLGQztALKSA@mail.gmail.com>
X-Gm-Features: Ac12FXyorylKhwqGw0HT9IiTuqn3a-WrKEI_gkRmAKNLzi4HndmDxi15M7mbjSM
Message-ID: <CAGTfZH1ts4_qO4L9X1ZoYtr0SGLW+3EBCqSybntQLGQztALKSA@mail.gmail.com>
Subject: Re: [RESEND v4 2/4] dt-bindings: extcon: ptn5150: Allow "connector"
 node to present
To: Xu Yang <xu.yang_2@nxp.com>
Cc: krzk@kernel.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, 
	robh@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	swboyd@chromium.org, heikki.krogerus@linux.intel.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it .Thanks.

On Mon, Sep 8, 2025 at 2:34=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> PTN5150 is usually used with a Type-C connector, so allow a "connector"
> node to be defined under it.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>
> ---
> Changes in v4:
>  - no changes
> Changes in v3:
>  - add Acked-by tag
> Changes in v2:
>  - improve commit message
> ---
>  Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml=
 b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> index 072b3c0c5fd0..79f88b5f4e5c 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> +++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> @@ -42,6 +42,9 @@ properties:
>      description:
>        A port node to link the usb controller for the dual role switch.
>
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
>  required:
>    - compatible
>    - interrupts
> --
> 2.34.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

