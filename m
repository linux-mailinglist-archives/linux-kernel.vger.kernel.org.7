Return-Path: <linux-kernel+bounces-808565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5BDB501BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8087BF219
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF72135AACC;
	Tue,  9 Sep 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUBYwksb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5335A291;
	Tue,  9 Sep 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432113; cv=none; b=nbK9T+wnkVf3soNXtPSqr7/93gsBkynARDi+4keyGwLwk91HysP+EVHA0NCwkFglniPaymb23YcRK/wHtprSqwcf0G6M9kkHEuriLRLl/XtlVTwXNz8nxVPQPn3HD1NvwhJQvCskkL5ulrpHfX53gS/hnaRzEDL5WlpNMy5fFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432113; c=relaxed/simple;
	bh=r10iZ7zeg/sR/nZIwbyfdzbIVMfWHdFFer/db8R+TlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdZ0ounaGeBuFDegGT33njtZbq7GcOz209akfRZeP7rhAL7dCfmYRN5xJsVHII8M9nEmTK3e0Xa4O4glZXnkV3x9ZAWI2ZV8rq1cvEB7two1uzLITUMrX2BN+ieYosWVEb4U5rRAqKqOGkii6MO5cp2pXuLa+yZQPC58vtnU6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUBYwksb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82D1C4CEFC;
	Tue,  9 Sep 2025 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432112;
	bh=r10iZ7zeg/sR/nZIwbyfdzbIVMfWHdFFer/db8R+TlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nUBYwksbxZTX850YqvKjGd7Pdwnngqp+BqCfASPo3dfXxvAwOIyJrgHoIhC234V2A
	 cJIzfqrlrDgeFbHX6SzkNsdccoAoehtMcavuuANykp1OSfYPUJjZ1oB2uVH0+I9NVT
	 lx7I4qXxbo8boBXZfEQBz0TLQ2EHbVqXQ1ZTCirBgDfR9egR1YTYh0a3Ne2yR6PriF
	 YD8oxCzl9At7UZyA7UN5QnpyOUqNEVwituxVHj3kFLIWloq4O/1tFy9bB4O5PDXF1M
	 fw0QwgF/0XHCg6kfCoV96dHRVngQITRX33+JxRKdEL7YxaYVin0Ym1zy19WN/diHXr
	 J6cYssdEUceRA==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74526ca79beso4940799a34.0;
        Tue, 09 Sep 2025 08:35:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX29UMbOsd6OoYMCdW/Ubn3wqBymN26bjlAGnqRf78C+OUQtMDqYrAOeYqmn9C1CAy2F9itRJWR6G7iPFyh@vger.kernel.org, AJvYcCXBWwLig5DcZZr7FHPpkitSAJ9CihtV5xxemoVk4BclsmvF1Nvm9F5E2H70MlWIpvP4fRYhEQI15YFQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5/lJ1cBMVzzZfYw0VnCMGBySs3LJBZUj/qNxeFpbIHVQMlH2
	45wfJRvUEyQxF80ctdHRendbV/T58XHfjoltGAZNOzF5+YA2I7ewMN7VOcMZe0GXorgFo163ZeQ
	AWY8VqgD0ZKRK4+eP1cn81o9Y2AUxx6c=
X-Google-Smtp-Source: AGHT+IFY52ypMIAoRlEjnBako5mUfNmKO1ctM4His3e3+VHyOFYstPxSUTPJe7B/elUpaHufT8qYmM79UMa2SAn9RL4=
X-Received: by 2002:a05:6830:25d3:b0:741:a5f0:bc82 with SMTP id
 46e09a7af769-74c74fb9225mr6102217a34.17.1757432112096; Tue, 09 Sep 2025
 08:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908053335.36685-1-xu.yang_2@nxp.com> <20250908053335.36685-4-xu.yang_2@nxp.com>
In-Reply-To: <20250908053335.36685-4-xu.yang_2@nxp.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Wed, 10 Sep 2025 00:34:35 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1Mt3cYenBSHG9Uz0j6pr0Na_E6aPfrn7pKV0ah22k+WA@mail.gmail.com>
X-Gm-Features: Ac12FXyNrhC_JrxpQlWIyq0hZrbQBd7StcRc7qJeExZMgjdtwvNrB_wOUgpGcQM
Message-ID: <CAGTfZH1Mt3cYenBSHG9Uz0j6pr0Na_E6aPfrn7pKV0ah22k+WA@mail.gmail.com>
Subject: Re: [RESEND v4 4/4] extcon: ptn5150: Support USB role switch via
 connector fwnode
To: Xu Yang <xu.yang_2@nxp.com>
Cc: krzk@kernel.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, 
	robh@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	swboyd@chromium.org, heikki.krogerus@linux.intel.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks.

On Mon, Sep 8, 2025 at 2:34=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Since the PTN5150 is a Type-C chip, it's common to describe related
> properties under the connector node. To align with this, the port
> node will be located under the connector node in the future.
>
> To support this layout, retrieve the USB role switch using the
> connector's fwnode. For compatibility with existing device trees,
> keep the usb_role_switch_get() function.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>
> ---
> Changes in v4:
>  - add Rb tag
> Changes in v3:
>  - no changes
> Changes in v2:
>  - improve commit message
> ---
>  drivers/extcon/extcon-ptn5150.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5=
150.c
> index 768428d306ce..f33f80e103c2 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -352,6 +352,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>         }
>
>         info->role_sw =3D usb_role_switch_get(info->dev);
> +       if (!info->role_sw && connector)
> +               info->role_sw =3D fwnode_usb_role_switch_get(connector);
>         if (IS_ERR(info->role_sw))
>                 return dev_err_probe(info->dev, PTR_ERR(info->role_sw),
>                                      "failed to get role switch\n");
> --
> 2.34.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

