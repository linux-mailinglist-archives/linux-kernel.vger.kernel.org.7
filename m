Return-Path: <linux-kernel+bounces-779688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D50B2F760
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13D5179D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A455F30E0F2;
	Thu, 21 Aug 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VM7mxTvl"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33320F07C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777399; cv=none; b=gZAeXFw/OXh4aC0gHoTm8U4+Uf6HFjAWG5EgCwG69H5kM3zBQhYXbOeriUgL/HW6iKjkOqk6wUvEw8W5Uno2Fl+7P4cUKSRRCO+8FyyNYJKVBIvvbHy9XCI3Dm891V4pWxg7UicJi1uluw8c8eK5fhc4HaDyiOO93X9c02VwjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777399; c=relaxed/simple;
	bh=uf6vS3Gl2AuJ7xqaJiaRJedxS56Xesptizd08sfMens=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRR2UaY8lgodNagIdjM/QRhnvKYIDTbhdAP2Yh+lAZS8SjN5kqmsYbdpWcanbyX0JBVwjPPCE47npLl6j0IPDp+uMp521on9oIeN5vCM7pI3LBjN6rbuO5GmNleOhB0d9VrWi7teCF9iFuEXc4vnU/qeFfPBstQkLMDGRyhr/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VM7mxTvl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f8f0dd71so7544731fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755777395; x=1756382195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTRZmz9b45Hl2bTm1apFpY/NlVi3bfWcm6ULUt78zN4=;
        b=VM7mxTvljui9g3lu39TOLUk1ZV6pCMH8OG9CoturI99lwEeKkgCehLIJXnFI4/vOQc
         Xfv7eVzvCp7gInSOBUAbKzyCXFHGSOueTtC3cCcSR7wiAwxx2tGtLVVhGe/kiivOKwFp
         IQXHPxpy+J7zMIWq4oHb1H8j55i5msEMt2S8QlNV+wlIqPKD353nNI5w2rEqAAQ6olKV
         SDdC+kFjxAF46YbZJLE2f73+tl5D39nhSS/SUjUPFsFENoN6BuEwradO09gEt8+gTHUW
         euEgTAZc7VOvIBaJPDt6XMqfceDOhVrWPWLB8QEyrZvVj7LXb8plg7+C3LdG5v9SVrka
         bj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777396; x=1756382196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTRZmz9b45Hl2bTm1apFpY/NlVi3bfWcm6ULUt78zN4=;
        b=b5xfvtyvP3e3pqVioTx8840MRCOAG0XDbvniK/9QjThlelxHliO/yl98mes/7O3t5m
         80jPhznNdZZmaC6iar38l8VNIy1fJSXmFyPZff8MkejlU0ycUcnrPgYHrL0BcBP2QRN9
         uI7OCS6CnZ72V3YqAECn21g7axNRNDXSgZfZlzyInRhN2dfYhfZJCqf/PCNW0Ih7sUBy
         oJRJaV+3bKT048ZRVbdVqOZetBcDMWhGnDXNx7gKb/JLEQB58s5bVWFYlDbfP07jArIo
         8IfcqvaBhj/Jqm+I3LFO3cFQX70VuilWvvW0TGVRnqBDWvudhkhb9N+HuAnZahqK1IPk
         /r2w==
X-Forwarded-Encrypted: i=1; AJvYcCUHBvH1cJEZFwlZLP47s1muhQJ3y8FgZ/4Zs0K1LiVN5XTCAWxEGlBwpLVlTQA+vb7sJetAf8YFstPCbPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7iOFLrdXxyYmsh7oWpzINKa8thKFDusm4eVD1WOvVeWTMBYv
	lvdMJAjLdVbNsBsBMg2V5OP9INaWOG3xTzDWuM9S/N7sSY03Pe8drHbvmzMYh8vcAblmMNnA6mk
	nAvIATnf+Bf4hB+MaqjxQJd1+9OCNTtcjElleRqfwaw==
X-Gm-Gg: ASbGncugVbiJqKtkXcPA4CcGMJoOcbzshNYjHbVSzQ8mVbeOokQfVXS53Xt3mBdjmAG
	P/fTbZR4g9aIF4ZmyJHIiXiz0SePMNoicTEVRU8a/jlwVX92AgxghVWHXShjrDwiRQSOhy2I4gh
	ewcwwQ+ARNrKD4kZcixSvFWOOpC37M4MwzOehE4qRjn4TFC7BuxKxfb5f8ie/7Gei9DgYVfh3XC
	tZqFo8=
X-Google-Smtp-Source: AGHT+IHLNT7GNgIK+Yc1AUKtRsJ+Pu3qxvF99KQLgmBORucS0GzpXEZZoUCuuB+z9QVIQwaQ+MKKQAluSVZweFngFeU=
X-Received: by 2002:a05:651c:54a:b0:332:57b8:92eb with SMTP id
 38308e7fff4ca-33549e7e81dmr7293611fa.10.1755777395492; Thu, 21 Aug 2025
 04:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820171302.324142-1-ariel.dalessandro@collabora.com> <20250820171302.324142-14-ariel.dalessandro@collabora.com>
In-Reply-To: <20250820171302.324142-14-ariel.dalessandro@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 13:56:24 +0200
X-Gm-Features: Ac12FXxjp4iK3cFyWU_S6p_GaEq9BIq8dd_UPbgZlXscJTvrfMnMiNgyqvjOGHs
Message-ID: <CACRpkdbpKqKyebADj0xPFq3g0biPh-vm4d6C3sd8r0URyfyYRg@mail.gmail.com>
Subject: Re: [PATCH v1 13/14] dt-bindings: input/touchscreen: Convert MELFAS
 MIP4 Touchscreen to YAML
To: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc: airlied@gmail.com, amergnat@baylibre.com, andrew+netdev@lunn.ch, 
	andrew-ct.chen@mediatek.com, angelogioacchino.delregno@collabora.com, 
	broonie@kernel.org, chunkuang.hu@kernel.org, ck.hu@mediatek.com, 
	conor+dt@kernel.org, davem@davemloft.net, dmitry.torokhov@gmail.com, 
	edumazet@google.com, flora.fu@mediatek.com, houlong.wei@mediatek.com, 
	jeesw@melfas.com, jmassot@collabora.com, kernel@collabora.com, 
	krzk+dt@kernel.org, kuba@kernel.org, 
	kyrie.wu@mediatek.corp-partner.google.com, lgirdwood@gmail.com, 
	louisalexis.eyraud@collabora.com, maarten.lankhorst@linux.intel.com, 
	matthias.bgg@gmail.com, mchehab@kernel.org, minghsiu.tsai@mediatek.com, 
	mripard@kernel.org, p.zabel@pengutronix.de, pabeni@redhat.com, 
	robh@kernel.org, sean.wang@kernel.org, simona@ffwll.ch, 
	support.opensource@diasemi.com, tiffany.lin@mediatek.com, tzimmermann@suse.de, 
	yunfei.dong@mediatek.com, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-sound@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ariel,

thanks for your patch!

On Wed, Aug 20, 2025 at 7:17=E2=80=AFPM Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:

> +  ce-gpios:
> +    description: GPIO connected to the CE (chip enable) pin of the chip
> +    maxItems: 1

Mention that this should always have the flag GPIO_ACTIVE_HIGH
as this is required by the hardware.

Unfortunately we have no YAML syntax for enforcing flags :/

With that fix:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

