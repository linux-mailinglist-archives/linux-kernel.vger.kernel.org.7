Return-Path: <linux-kernel+bounces-848222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C65BCCF19
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A64FB133
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5A82EDD40;
	Fri, 10 Oct 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsM9POjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771E2EDD45
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099863; cv=none; b=VxLm6KT5JRCFD1c4w6u12fDmyuOmjZCOWaX9Apnnaj4SX0oDl7ADaaYoA+No6aCfJPPK3pkQgQX35W9CfRlKSprkk7HLL0n0VZh1jswjXGpx9pIfze5HcK8cE57Qcmp3cWkbg7brJxXOkl8Uu9aXCCx4a7Su/fJxsHUo8bs1xKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099863; c=relaxed/simple;
	bh=FzClrbjrEqRv/xjQzJWT38TrRTYaKK7xz/qIodXf1jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQ37Dalcx7jk+2i5m8YHnt97k95402CyX77X3BKACwe4SJHN2kZ1bADU5Omftf1dTbE0J7j8aL8xlyJd9JNuqfQfvStJaig3/mqyUJixu99oD/V/czbvXLnT4La2FGz2/Y/xgMEUCggKsvEuT2WAhgeEAF+4WWfwEkYK6ntxwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsM9POjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD2C4CEF8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760099863;
	bh=FzClrbjrEqRv/xjQzJWT38TrRTYaKK7xz/qIodXf1jc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IsM9POjvwyCr1PbRX12nI+ZuNpRx8dxTXWVwRSzo8H092LcaJTXQuaj3Q4Xck8kNw
	 VzV6fLAL4L9sfCe7tTOClKZx2f1f+QVpSNRMJFIC+zAKAKhaqwdCK452EiiwBpqWjf
	 264J6TuMEK0EaD9/fsnN0OuNFRGQ25+GxjkySZ0IJCuXS7HeIk4/DqlHhijEZ5sNwC
	 2KMHz4qHU3ovsPr+KztruhGcE23KAxmtjmMCPRVy4W60Hr3C+YN/+3vPmlkau1i+O3
	 1hiO7a+pP0N2sYaORgQOriiAxLFSFLfXj3kXZ9qQh5hgG3bRFeOIpdjLWRXNLOZtTI
	 1GoeF3ET1mXGQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso330053366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:37:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkHkSmXiKJXNueByeGNci6as4fGcveT4Tx+OitmkkDBmOhwZHMm+EVt7OaxWGpz3v+9JrVefmOFSG7k74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tDUE/VfsC2B/tqBdpQdJ8+NI/Pgkdb2nkID9tQke9AZxZvgD
	5hXZ+aCWhlZJ4B1RxrjIiF+hgOEivqBB1SqFBL4x1njPvCzfXEUnrsllGmcrCiGXOMvbrjznq4Y
	W4GRoEKpwD14l7g/rs8yvKyffnkLAmA==
X-Google-Smtp-Source: AGHT+IGBfdId2xOqPFSyPpgfeIJHQuLK4TGjxZ5FnQdownP+UCJpNZuLxcTbgHzTsZqQYW4/D3kSN7NUXXPIuhIYdnE=
X-Received: by 2002:a17:907:961b:b0:b0e:d477:4972 with SMTP id
 a640c23a62f3a-b50aa7a086amr1275250466b.25.1760099861528; Fri, 10 Oct 2025
 05:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001150003.417472-1-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251001150003.417472-1-srinivas.kandagatla@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 10 Oct 2025 07:37:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCG-zY7f-gX6jwXXbE_uha-z1seqx2Dj+rS685DuzNMQ@mail.gmail.com>
X-Gm-Features: AS18NWBbuq0Y4UeZ9RroCyCV34TGF9G0nqMZ2dAG4m1y1D0Ujlkw-gQqUKpyAtw
Message-ID: <CAL_JsqKCG-zY7f-gX6jwXXbE_uha-z1seqx2Dj+rS685DuzNMQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: slimbus: fix warning from example
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: srini@kernel.org, krzk+dt@kernel.org, gregkh@linuxfoundation.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 10:00=E2=80=AFAM Srinivas Kandagatla
<srinivas.kandagatla@oss.qualcomm.com> wrote:
>
> Fix below warnings generated dt_bindings_check for examples in the
> bindings.
>
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> slim@28080000 (qcom,slim-ngd-v1.5.0): 'audio-codec@1,0' does not match
> any of the regexes: '^pinctrl-[0-9]+$', '^slim@[0-9a-f]+$'
>         from schema $id:
> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> slim@28080000 (qcom,slim-ngd-v1.5.0): #address-cells: 1 was expected
>         from schema $id:
> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> slim@28080000 (qcom,slim-ngd-v1.5.0): 'dmas' is a required property
>         from schema $id:
> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> slim@28080000 (qcom,slim-ngd-v1.5.0): 'dma-names' is a required
> property
>         from schema $id:
> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
>
>
> Fixes: 7cbba32a2d62 ("slimbus: qcom: remove unused qcom controller driver=
")
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/slimbus/slimbus.yaml     | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

You missed the DT list and Conor...

Acked-by: Rob Herring (Arm) <robh@kernel.org>

I would have picked this up to get it into -rc1, but I don't have the
dependent patches.

