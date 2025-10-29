Return-Path: <linux-kernel+bounces-875928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2B1C1A27E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 276ED4E177D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738330B526;
	Wed, 29 Oct 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="OuiSYElE"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7532BE029
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740102; cv=none; b=EOn+jaC8Wbb+aCQW1yh/JZI7eMYzxxjBBHzD5t2c41NLLFQd5ZDFoiaAHSE7h9dHs4x0gLPX85tap1WYc4MPZ6vVtGVVyqfT0NM5c5gtqET/ZsHAfQT1axM6GSRcIMVk7Sv/oSsWKbZB5Nn6O03yLvxCbxsHpo2WgqSgXdEUP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740102; c=relaxed/simple;
	bh=4F5sp4xcDzN409xfAeb6HN//KheRBXsuiCSpc6S1qF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzTneRGiXBiwBk4yvtHT7WkYJJKpjofpprGD9V4e+PrWt0zV04/h35nMNj4W8vuKpO45qqeKDfWJtYKVwFMwz5b+qj/8NSLyPiZrb5A4m66959xXkHjyk+JpZAGiRBEI9el3zTu6uBmOAXMPsk18nrJKc//72hjh032rx9Csg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=OuiSYElE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d83bf1077so487937266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761740099; x=1762344899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfdgCkjf6Dvq16Xjewrrl+WIt5oaPnZgbIkIulsqup8=;
        b=OuiSYElEkORLIBMQHUxJEi09R2nQPB1vPTyDIBqLnGlHDpz7WpzbnG4a/2yTNKrYhl
         3tCIMsTEAF3bJC19BS93ZhRwv139ta1tJwJ97imaJa/SRDtvwsyS/DTKAOMPUUY+khP9
         xF56MsiSxM+hH+YrJFhOOQVYjr0jV5+AVqyyIhSvE9xI6p3UKejfJMx/Rllat0MnWzFU
         hxQvVmGMsgZLwDLr61k6N7QP2d7yUn0jXOJK1kkYQSGmj/mahxwurwNA5yJZKAIv5N3q
         VmZ3bGuycQiPwdenqNz6EI4JCDpz3r5bMeuBOtyC1Q7HkX0EiQCORHZKz4XwSwy6m3kE
         Y2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740099; x=1762344899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfdgCkjf6Dvq16Xjewrrl+WIt5oaPnZgbIkIulsqup8=;
        b=qBUHpM2TUwoYvyGDGPsr9LifX/6sho0kNQP/+0ZH72y2Ybk8n55iYGyY01gyiZFDSb
         V64S0T3+HqRty5PS5NV43n7T7vaQt52g7Y4fa1qLGCQ7Wh2pBRDbcmFZ+BIpP0jNmsH+
         X0KE1BlckGjE9D9wGKC+Rm9gwVXNaUqeOJQTHF5ClWf+ZBqPkCsViTYt86e/vggWZwfG
         rH+XucUNzErvLGD7yl6ELgI8IeMpwmVz8wAQ5olPPW6yHJQ4V2voF41Ac/O+Q96hbNGW
         982CJYGEtBhNuRJQllUED28Uy5IONUWEe+IYSzQKz4ae64iy00tSftkRwSjbgAT42qZs
         McAg==
X-Forwarded-Encrypted: i=1; AJvYcCXztCj0RNKGGSh9FAXPCFCEfdJhQIGUnEJigeWcfLoU7vSbLk/HF8TQYzJVRVprTy6TnFocluNJoqEUIlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1TZ7EZGCFPgWXntTndGyprEKSOkcGgtYe6vZ7qydNI4ilIOAA
	WgDoc4jFurfjALCj50077k3U2HzI4BgjJSDQnfgXXTce9OmMxR/PYu+G773lMu9UkJ7IP+hc7Sw
	dpZVTVacbKYBdyV2yI3rlpqvRJ/s9JmUD+oCBIgcsdq9RDfiX31NL
X-Gm-Gg: ASbGncsGwUGr5PFpTUpo6+L8UI867mt1o+T27lbyVevwrZRnKBW01yi+YI5I0o1INoS
	IABAleaWNfVhyiOkAFezN5ikWtM6ZimBG+3mFk1cj61h7+mjLKljF0tH6xcts+eZKvONb3oYfiu
	Eji6IxK8ngHWXA3uqhe8dma8TvGBxFlorYmyDbBGbCfKAAA1xFoVStXEyQeh+/VTqO0su8g0dOr
	mNf8pQzNOIekN968tNRRw4edR7sClqJMKenYo6kOQySEVlwW+gr8YGgjiRJ
X-Google-Smtp-Source: AGHT+IFshWb7jzNyyU6ez2u0+L5vTwFP/pSYeFZxnpO9nxdrMJpELvpuMzbB9JEsK4A89hE1IYFcIQmkgCRDM9n8HVo=
X-Received: by 2002:a17:907:72c9:b0:b54:25dc:a644 with SMTP id
 a640c23a62f3a-b703d5cb645mr241872966b.60.1761740098766; Wed, 29 Oct 2025
 05:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-fix_gic_dt_licence-v1-1-af70840c5e61@bootlin.com>
In-Reply-To: <20251029-fix_gic_dt_licence-v1-1-af70840c5e61@bootlin.com>
From: Andrew Bresticker <abrestic@rivosinc.com>
Date: Wed, 29 Oct 2025 08:14:47 -0400
X-Gm-Features: AWmQ_blXxoAIGva9lz29zEL4bFZ2YDEi_RXAlhnztkgdDefGbYfYyjaOj_TdcdU
Message-ID: <CALE4mHqi-aj9_WL=3BeTztQHt5FLC9DEJsJA62tWXmazvxJuRg@mail.gmail.com>
Subject: Re: [PATCH] of: Update license for MIPS GIC header
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gregory,

On Wed, Oct 29, 2025 at 3:22=E2=80=AFAM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> According to Documentation/devicetree/bindings/submitting-patches.rst:
> "DT binding files should be dual-licensed." The second license should
> be a BSD-like license, allowing the use of the binding in projects
> other than Linux. Initially, this file was submitted without any
> license and was later automatically converted to the default Linux
> license. Let=E2=80=99s now update it to follow the preferred license for =
the
> binding.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
> Hi Andrew,
>
> I=E2=80=99m assuming you are the same Andrew Bresticker who initially wro=
te
> this file. As the author, would you agree to update the license for
> the reasons I outlined in the commit log? If you=E2=80=99re okay with thi=
s
> change, I believe an Acked-by tag would suffice.
>
> Let me know your thoughts.

Yes, that's me.

Acked-by: Andrew Bresticker <abrestic@rivosinc.com>

> Gregory
> ---
>  include/dt-bindings/interrupt-controller/mips-gic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/dt-bindings/interrupt-controller/mips-gic.h b/includ=
e/dt-bindings/interrupt-controller/mips-gic.h
> index bd45cee0c3f05..647f22d5f0622 100644
> --- a/include/dt-bindings/interrupt-controller/mips-gic.h
> +++ b/include/dt-bindings/interrupt-controller/mips-gic.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>  #ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
>  #define _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
>
>
> ---
> base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> change-id: 20251028-fix_gic_dt_licence-c876fd6d709e
>
> Best regards,
> --
> Gr=C3=A9gory CLEMENT, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

