Return-Path: <linux-kernel+bounces-852370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF0BD8C81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE61C4063B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2F2F7AAA;
	Tue, 14 Oct 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxeybXKM"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF852F7468
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438354; cv=none; b=BZcaIvM0AgoMzj3n1NQVKjsbnwr0eDXlKRoX4BbQFI9BFrBbnmSeTFgHPOFndtWgZbXKyx+dt7cnFsD+zMpJpqnFcz6UaVluXfeTzUsXZXWq32Y6lV3r0a28L+rerTEtYnlKu8CB6Fjcluqq38xtL57TDwLTQ0zY5NTQu71llXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438354; c=relaxed/simple;
	bh=F46LslSaUY8DgHN3n48eTxDvyLVCIVU6v6jJMKyIwqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9+3ooO/WfwgluTBRmbnbWi7uBY+F5eMiPZ78XUpS3fw2aj0p64pxgSboHGLQHP5f8g5/US1M9MPHc7MwvegRbTJ/7HhVgctmkofPEGn8u53xtKmoFUoQmqF5s1OY/3IGBQi9xMN1iHMLN1eq96eTWzx8XzC0AVqjgMrhoOzzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xxeybXKM; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6360397e8c7so5373340d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760438352; x=1761043152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pokQkIgmHHvIRgJkKC6alt0eQ0/5qfJ7yTlxa5V1+JE=;
        b=xxeybXKMPyFClkUlOE6EOVALKUp3IdnHkEM/kbOHi4mk8DobAkdAuUOcbKvHgl04JP
         Xn8jQQsp09mcPDrIdK1WYyrjERNC7O2odkJuODYzbGG8/G/o3Ali1RcIJKtGdqMTaeFw
         P4iUJUCVm7Dcq71H7CWSL80ZXV06d76VHl3n7MQtU2SjlGeVnBazKTsYq6d4OG4rKbB7
         re5dF9z99boMgsDuAMHfYO979xYa5B1SULcIP15fds+LNAzG7whxYvQD3cIzQVwgOTg9
         cSvECmOldOMc7MbPQW85eUimutx/SyXd8dtzBNP25PiDzGtznkazr0qvj6fg05a4aWJT
         gCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760438352; x=1761043152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pokQkIgmHHvIRgJkKC6alt0eQ0/5qfJ7yTlxa5V1+JE=;
        b=KzZ3gRqPoWQ1ARmGQnN2z9j74LFQ2b3p12uVMoutsJlHNw4TR55S0yPv0HptBCWmFu
         Vp8JjG77Y9w/eY19elBgbNMu+dDBW6W6+e8DmssQYLthtxtoALS4VMHb9p6QQNdpMFHN
         fMJ7UxWUlRZzp5Mdeh7euUPsJda6jQ+C/P9URTce9haSvs7wfb6Qh6YfztZxLL5AA7rZ
         LGeUjIznigM6hD1stmDgS13Z2OcwqhryN3DbEJHCE4MhZBUwHcJG8zFYvsoPkvr6Iupo
         j9WHi/Y5i1g59uVUmBVpKXCC5a0mUx+QggPx65HoyA70XSBPA6oJuw9V8D35aT60AAyX
         B9uw==
X-Forwarded-Encrypted: i=1; AJvYcCW6YSkn/5KhC+f1IFABc3HGD92Jpc3UXOlS6nbCpazcuwIEYl8YqS+3mx/txuIxeo3+Rs7S9aUBp2jwrZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2+Xf0qu1CbvHGSRFa7JM2OnBsLXeaOb6FVMjtzfnU+/ePRox
	K/FnSUiZnKd8O4WiPPTSGtjoI0q8T/C2TWnB7LppADA99BFnwabp0fEAZWLE2/urR4lmtMha6fv
	Wz8wFEUVtbP/MyHkbOO8hBmXGwzB4rkbmL8smQOAaFA==
X-Gm-Gg: ASbGncuq3Ts9sGeXhbigzh3LxWZHb+U84CpUSFgrLejxWo6YvZMOjIHOLnq9J0cgbWM
	XV2HELi4rMn9EXIUgSlopD1wuqAh5pSHgCW6Yd4vIvt08GtIUn+v9IJzyZDMho8dM6nAXG87xQg
	zmjhWmrin8Of6p4wupI0uFe0pCdNlkWkLEbhepa0P95e1H7DOy9LanDCULbcAjT32+rhXpMAqbx
	NLCA6EI69S3BEvXYlqPHXMUtKfg8ZjLNhJeQxJ7
X-Google-Smtp-Source: AGHT+IHX+689HJuQIzxGKvDquDFhGYNkr9Ghi5QtgsmKgFKWhP8E8odTxafNGNZGGvvjaBJpeC/l8egbUVvSv1BuNt0=
X-Received: by 2002:a53:acc9:0:20b0:63c:e930:e35 with SMTP id
 956f58d0204a3-63ce9301f39mr13020069d50.52.1760438352092; Tue, 14 Oct 2025
 03:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811163749.47028-2-ziyao@disroot.org> <20250811163749.47028-3-ziyao@disroot.org>
 <CACRpkdYC6ueVGngC=KMqh9aW8DiMKWyxoa8dqb4N3sEEkpdsFg@mail.gmail.com> <aO20G22p7OwJq6C-@pie>
In-Reply-To: <aO20G22p7OwJq6C-@pie>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 12:38:59 +0200
X-Gm-Features: AS18NWCg4FakAHKpN6u-x7lmptkHtb5kz_X0Y5yrB5k3cupKvc4MDFUSFgWvd_k
Message-ID: <CACRpkda7AMiJEVioOVANpQ1oe1rh7ejKs6=erA=hYQWoyLauog@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-binding: pinctrl: Document Loongson 2K0300 pin controller
To: Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yao,

On Tue, Oct 14, 2025 at 4:23=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:

> To confirm my understanding, would you like to drop the outside node
> (which now refers to pincfg-node.yaml) and refer to both
> pinmux-node.yaml and pincfg-node.yaml in the single level of subnode?
> i.e.
>
>         pinctrl {
>                 uart0_defaults: uart0-pins {
>                         function =3D "uart0";
>                         drive-strength =3D <2>;
>                         pinmux =3D <...>;
>                 };
>         };

Yes this looks really good.

As you see it is also very easy for a human to read and understand
this device tree.

If you want you can take it a step further and use just "pins"
instead of "pinmux" and infer the function part of pinmux
from the function listed there such as "uart0" so you only encode
the information once. But it results in a bit of tables inside
your driver.

Thanks,
Linus Walleij

