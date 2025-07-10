Return-Path: <linux-kernel+bounces-724902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B5AAFF852
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F09B48600F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208702206B5;
	Thu, 10 Jul 2025 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Pjku5i"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FCD21C173;
	Thu, 10 Jul 2025 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752124085; cv=none; b=sdFvlwB3dwK/PK+i1LxLwBVp9jxODirMHIgs0uOLdnG0Psi6/kqT+hJCzC2xyPANaprF2s62Iwe5GGUgavQJGM3SV9GR14/vBhPUH1nFm0VM+LTM7gQrJLxhUECy+552p0tjOX+fvGX1lVTQH2aH0HB/V6U866Y15RerKj9cnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752124085; c=relaxed/simple;
	bh=62i7GbnPDACSx+81EQf0xh7RDunrM0Fpi9UKFjVH2oE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hLvEA7x/7EfSB4ZJAcu++pGqGlLwtkBCC8PRLTQWQLjTKTgPGvR9IWyHZP13ysEBjotVxyI0bYzLAnsVxKWJ7PjQfgayqaw66hQvL4RYyBs326d2dW58vtq/1zcvpbuQ2Zg6CZ9guh4AiPpp1Ot4feo1iW3coD4XZpDBVKVTA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0Pjku5i; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31329098ae8so597603a91.1;
        Wed, 09 Jul 2025 22:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752124083; x=1752728883; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbGrNvu8hiaUF4KJPNmJO47DxCjsgZKfJWKkYHjN+1c=;
        b=b0Pjku5iEW+7bnwp/1oA0NTaEUfijwvxWg+PaH92dDOy89z9234xhMb4u2+76I8h9K
         eVsn/Qr0w0TZ1//NlD/FahiaFT8ErLZLOuKSDVajRjlUcGDhKpD1VBZe12eHGTD+BJim
         NQs/TGP6R/QTik/CpAJapyUOZk0D7sTeGqgbTRah4pZOjQk7Auccyn2TUl9cUNs3IgXx
         eQfi3eaZtXRIlNSUjM1As1xVTwywezkwzOeoDw1Tlj+mAzyHCqxUwQr3qYU6AO7UAkvH
         1qvUjn5tF2j9BmHwAHZYxg9OlD6oEozddTp1H2NBdmE7+Km2m4Prebh0FKfjFfKC7mAx
         qXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752124083; x=1752728883;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gbGrNvu8hiaUF4KJPNmJO47DxCjsgZKfJWKkYHjN+1c=;
        b=dCIERntecPCAGoc8qRqn1NQI9cV5a8N9S1UBDN3EZcMdRlDe7fL9YlqCPd6rD3RfZ4
         4u3AsoX3eWWFeGKZvRO3Wbc4vx6ylqWhe9zofsAQ+eNvdRwqytHUqamq66mrf9vdv5Qy
         KauFdDmJwr3lx2i2tsJwKcsfz9VWv62aXOm7R3aopWyHK8/lYESmqCx75MhLrPg0MWgm
         5VZJ4Z1R5e6zJgHqDGOaqMA84r5Ps7RbsUzWqZnJk6wLBLtbtxKaYKQVRqw0hi8VNDEV
         3hNS8WQnG8bq1U6rHt/drY3o48C0xwxXZjAO2ZjKSMIuHGp5dy78zy36gN2bg9TQZ9jT
         22+A==
X-Forwarded-Encrypted: i=1; AJvYcCUXyErcezOCRMl42u0HpXnIWDAlmiMbUT/D007rO/KU8vN3YdOB0Y9hWYzbBa7USfSa17QfW7diwvc147Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NduXeCfDbOykMbmA11VNViX7t+oIOIlAMw1POR/UeK7gEniZ
	jkvva6EzS0Vj2tZxSzwDsUaryzIOyM28LNP82mGCR1InFWMDnPCApd26
X-Gm-Gg: ASbGncu/XZ2QnzfM3STvymK1Ow69OCTJ2ZdWd8dyvCRozpzxyJA4zQsC5myFdzDLP8g
	znYknra5rlghY1tvY14o5lTU+aAv3mtBBMH5J42CmmGnwLzy5GzyPsZq0qemEZbpUi68aI+iGER
	Cdo5eA6GyIWV509nkWZxOQU4JtkrMzjmqeZLHpCHE1WCl5+oE4geEGL9fg1i0FjwcttEJ5ygS/q
	cIP+izPL0a5a0lHG5sqDivsmzO5LJCdVjOR6bud05/V0iiMI05KHvWlTI7s/fPmpWeoCsAIItSM
	iuZA55fpH1MZcgweidWSEstBzlWT6UpQrgmJwOTnHU0bfUgPQ+/pYrzRs7Cp1ANVEQ==
X-Google-Smtp-Source: AGHT+IF52pFfrbGeBbMqAaG3sScelcU+r0jOAasje2Vl9yyb/k39t6KZXw8BFgKYIQxzmDxPkQbdEA==
X-Received: by 2002:a17:90b:4d11:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-31c3cf7778bmr3275886a91.10.1752124083319;
        Wed, 09 Jul 2025 22:08:03 -0700 (PDT)
Received: from localhost ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f633sm945378a91.48.2025.07.09.22.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 22:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 02:08:00 -0300
Message-Id: <DB845EJ4BX1M.TK8J5TWBAQ40@gmail.com>
Cc: <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, "Andreas Westman Dorcsak"
 <hedmoo@yahoo.com>
Subject: Re: [PATCH] platform/x86: alieneware-wmi-wmax: Add AWCC support to
 more laptops
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Kurt Borja" <kuurtb@gmail.com>, "Hans de Goede" <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250710-m15_r5-v1-1-2c6ad44e5987@gmail.com>
In-Reply-To: <20250710-m15_r5-v1-1-2c6ad44e5987@gmail.com>

On Thu Jul 10, 2025 at 12:11 AM -03, Kurt Borja wrote:
> Add support to Alienware Area-51m and Alienware m15 R5.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

For the Alienware Area-51m model:

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com>

> ---
>  drivers/platform/x86/dell/alienware-wmi-wmax.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pla=
tform/x86/dell/alienware-wmi-wmax.c
> index 20ec122a9fe0571a1ecd2ccf630615564ab30481..67e5dd0f140aa73ac73ea99fb=
e081a6b08e520ec 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -89,6 +89,14 @@ static struct awcc_quirks generic_quirks =3D {
>  static struct awcc_quirks empty_quirks;
> =20
>  static const struct dmi_system_id awcc_dmi_table[] __initconst =3D {
> +	{
> +		.ident =3D "Alienware Area-51m",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware Area-51m"),
> +		},
> +		.driver_data =3D &generic_quirks,
> +	},
>  	{
>  		.ident =3D "Alienware Area-51m R2",
>  		.matches =3D {
> @@ -97,6 +105,14 @@ static const struct dmi_system_id awcc_dmi_table[] __=
initconst =3D {
>  		},
>  		.driver_data =3D &generic_quirks,
>  	},
> +	{
> +		.ident =3D "Alienware m15 R5",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R5"),
> +		},
> +		.driver_data =3D &generic_quirks,
> +	},
>  	{
>  		.ident =3D "Alienware m15 R7",
>  		.matches =3D {
>
> ---
> base-commit: 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a
> change-id: 20250509-m15_r5-7ade3650ca48


--=20
 ~ Kurt


