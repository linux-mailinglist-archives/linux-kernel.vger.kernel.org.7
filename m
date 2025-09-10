Return-Path: <linux-kernel+bounces-810217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B1DB5175A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4387E545B67
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3B31C576;
	Wed, 10 Sep 2025 12:55:37 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC141268C40;
	Wed, 10 Sep 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508936; cv=none; b=aWMBE6DAfa1NExcSp474LnqLk5kzXrwTKX8cAMl3TAvYwABLOUrYsWkEm2pgCZD0a6QBi4Za4y8kFJeEFmaBl9AnRK/rvK245x6mrLag1boD2xzOpaNfDv5wA3SHdnlThD9rpym0Qvp6jVXdOcnaKGJpOSjGRHYvi0EKUCzn18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508936; c=relaxed/simple;
	bh=VRd6OHvO1zviiH8/zWIWyTR5W4kJN7wrHP1CDmkx7/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlfu7KuzkHxbA2vwvCv2UlU/UdxLq9a+clbtCDo7l1oVQeyhU3vHHZhdAY7uhm0KEishNsZF6XEnKaR6vqpbQrtijZK4fOp7MVDAP9h8JcP+tedBtnBijAzQFoBG1JqOS+4Vg9YJTjSuXm9gydXPMYBKoUsRldISDedxV3j/3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so6328838e87.2;
        Wed, 10 Sep 2025 05:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757508932; x=1758113732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czL3Mu97JDNqFcpEdZAJCI1Ps8ECPwFG6/c6zc3mY50=;
        b=ON0RIMNHEUTyjiSRN+iICiJRQlNCgYoJqAShlhncIvgzCfZgLPyE6ey69iucfQzKAo
         FyIhKALCWVLFiG3gkUckN9q6jMF65wTT06Pf8WOEaIZ5k2g4dDUmwGyl/oeVkirPqmp+
         QRi4KP8x0r3S+PqKoX12bapG6bYsYksi5sOApmQtupwlnA4MHLaTDJjMNnYxf9MvHyrq
         +GPaUzz4kSreuWdnmoavawUiKCnqC39167QHrTZhr8GMHk1OzmpPjPGzxQi1ZCQqu1ib
         whIAHT7YaQFReLIYV8dwvTdhljB1KaVbZl69+5vzCwhn1FqBYOZNdnOR3m1f/yBFvC6C
         at5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3f1ESDo3QHMDkc8+suTa7MTZUQZVYea45jJpzXa8mwV6X+1pQ33YmiPvbaN3raEK/S5Ez3jv/Gd/1@vger.kernel.org, AJvYcCVp2IXGfvq1K6PPZ3C1g+gouEjyvfiBVr3b3AKeXaUHAPvEsX4qLf4kNhjrZ55Sb5nZU9gXWIr7IB6fxYAM@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmD+arBIHxPg5pZ2ioCIqpPG+pK6hbgeM7NzWlgnxPW/zpOlF
	yK9fKHIrs/bX5rotq3bDQfHikGB0uN5YEHS8dWFQrTqK6uPe5jgElpQ/6VOfa+qs
X-Gm-Gg: ASbGnctBYnm6BIgby9RNsSVnOombPRdQNPhXilyYAGQZ7FBGnmbCjAcTkaNBNSSNX+S
	0DG5pQQbpgi6AlZOI/liKStm2Oqph9P2m9yNG5DPAxcRkuW4hEHQun/9UjEUkOSjV2HGivcN0pC
	u19py6ksQ/eNsx9EMDmZ85XkkgtKT4CyMy1RRylGC+DI3ZPliuE0iDy+uCPAwq7yJ37ZSrTjqDw
	G/cyIm4QMO/ybHptr82QbJ5Mp8/Q0RMJUKqSmCRX+DXWuw4VAtyDlCz1fqSrg3OO4793v97hT/D
	5tFfW1mYxgIlzq/nujtvl+pYE7X3DJTr2ltjNExxr49TLKi+xez0B9UXufH+IFwhKAOf+uM1xrH
	9vkiJF8KajLcA+lP/4qhMZqOzdhN0mgjzNlFO3LuZOoid9RwBRaR390w=
X-Google-Smtp-Source: AGHT+IFjK7k+qNIsVGIYTcf5KnM26QmoPlf5SayWVKRB0VSkAOhf4S8EpAXUsDGfoDZE84O4Ge7tbg==
X-Received: by 2002:a05:6512:33d3:b0:55f:394e:3b with SMTP id 2adb3069b0e04-562603a1135mr5454310e87.10.1757508931740;
        Wed, 10 Sep 2025 05:55:31 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56818067eb7sm1223254e87.106.2025.09.10.05.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 05:55:31 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-336dd55aae1so60593731fa.1;
        Wed, 10 Sep 2025 05:55:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxczxCZVy3Zc0KPDw8AwQZn0AlCKD/EI4MSZ7MqUQuQzjPic4mmlR1vSdg042UHcfX/bNwNfY69lD0GZXK@vger.kernel.org, AJvYcCXaDaoTbN1IxN7j5OPz6OsfqdgJJViXyWzWWkCsT6g09+thn/R6SjxErLnVrVj4/OAnpTtE17fcDdsc@vger.kernel.org
X-Received: by 2002:a2e:a54c:0:b0:336:e199:6d95 with SMTP id
 38308e7fff4ca-33b4e07f1e7mr46456191fa.17.1757508930395; Wed, 10 Sep 2025
 05:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901120020.181414-1-amadeus@jmu.edu.cn>
In-Reply-To: <20250901120020.181414-1-amadeus@jmu.edu.cn>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 10 Sep 2025 20:55:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v66wnhyv0x31bO2S1fWeJZzeQgdEze7ChcFb0VGjq5AjJQ@mail.gmail.com>
X-Gm-Features: Ac12FXxzgckCvK2PU-Ug8oHKsMc01hfEJlK1a7HMQ13AEF91phM76xhzrUy-R_I
Message-ID: <CAGb2v66wnhyv0x31bO2S1fWeJZzeQgdEze7ChcFb0VGjq5AjJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: allwinner: a523: drop redundant status=okay
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 8:01=E2=80=AFPM Chukun Pan <amadeus@jmu.edu.cn> wrot=
e:
>
> Device nodes are enabled by default, so no need for
> status=3D"okay" property.
>

Fixes: 35ac96f79664 ("arm64: dts: allwinner: Add Allwinner A523 .dtsi file"=
)

Will be added when applying.

> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index 6b6f2296bdff..cdf844eb8e05 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -218,7 +218,6 @@ wdt: watchdog@2050000 {
>                         interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks =3D <&osc24M>, <&rtc CLK_OSC32K>;
>                         clock-names =3D "hosc", "losc";
> -                       status =3D "okay";
>                 };
>
>                 uart0: serial@2500000 {
> --
> 2.25.1
>
>

