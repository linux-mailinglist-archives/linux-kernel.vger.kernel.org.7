Return-Path: <linux-kernel+bounces-871311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B0C0CE43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0413E4219F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E882E6116;
	Mon, 27 Oct 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD1KCBdt"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FC2D3EE0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559477; cv=none; b=iulgQwQPyZa3B5VxNhPCk94pYpDF6xhbHbOXlXPMnkMKWXIx85+msIxtSvk1BD3lHF22zcf9QhVwvywhfNlKSsMIfMgExRpELQ1JOW3wGlr505/kz2saNsPwOUhLJIEA2zbUf+/bObmQDYhX0gB3lrTSkYexOAPWVFjGj0KCOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559477; c=relaxed/simple;
	bh=bZ+q597kUNGqIq8Y48TGj7KcH72hkRPIAwT7wzsSsNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cocPfV0BbHwcXJ0RbYCjqzmridJFEvzCglLG9cyByHliucBwLD3rTxITpBLknFoZ6R0egfkOh4xdrGdzhQ/IIE8q+LifwUP8s+Cnbn2RY0n+Y6wqozf7GN4aXvoGO4XkEj60uxDLuo/iZox/8nlKi7Vsqan+ds6kxjNSkN1c87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD1KCBdt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso3334175a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761559475; x=1762164275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZ+q597kUNGqIq8Y48TGj7KcH72hkRPIAwT7wzsSsNE=;
        b=WD1KCBdtVr6Uaf9+9XtB5USN+vvFfrFollNT/kQurwRdF5GgPxZU6Piej6sbf/Nmso
         pS3WSR2v5QqFrKbcDiAWkIf6U5tgqeh2lJ3tNNAsToEv7ldL0UerM22oPjbPXurjPPKy
         Zfh9h48ml1aDyZoqIwPT8djKKyIGTTg8iNowpKfnZ4/qWLgPq72lNYYFbu152iDyUgjO
         zyOq9DUHZUfTg0U/SLqr/LAfqxg8x+pGcheMMrfV7kR6fzZOSGG7vE1GiXHC2IZD+UTG
         MfDj/5pDUVv5aVrizCoakLxOHa8njkfTRA5kk8mTbz1nxtqF5NmyKqIXGd+8TJFPoWtI
         iqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761559475; x=1762164275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZ+q597kUNGqIq8Y48TGj7KcH72hkRPIAwT7wzsSsNE=;
        b=DNcge6HVctIfQegjsi/l4XjV9f9zL21P3U4gwGwprSxoPxoOq4Hy0GTRtBnEmZ8cIO
         OBR/aavYIHThzVkdbtwBWp2FgTx0DFKNAg+z7RjnEntRWKty0yNbXRRELKpPSjYn52lI
         vmLweCY9HpsHTWpdNXpD1PsVaZPqWARbgiO8SObyaCMnCsED6wmkHxc0RyCf6R22mzQb
         KXwdwNY+pDzkRcIyDYWfStwBsBz7vEJgahzj7BOrWvsf7Sk+SFSfpAWi3rebvVFO9YI7
         SG//leZGJrM0D3IXDzK57cbPUmG8Ro1NEYPhQg0rv0X6nlUbSJxUlVnK18GPn6bzJqvv
         0f4g==
X-Forwarded-Encrypted: i=1; AJvYcCVNR3oSL0wz8flNeVLjGRx/6in1anRi9LDubNyluip+K1P4GLuxU8oRPyI4xRMcAi4gOml+xeNZ5aDp/Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUyqqb7g7zJueyzIZ92P3S+uVCFCHYHeHJBk6SFqrnJpYbW5d
	zw/f6wOwceP4RVy/sH676dCPD1/d4LnKNQFyl7eLoiXDPzn1qcpj5XMsuHhkMY1Mi1GAZvzqy42
	U5YSgqSL5NTBIx6e4XDAzwCHwdHdrLfU=
X-Gm-Gg: ASbGnctHcJ6TGwwAdafX9wpu+Sj6jyFmdLo38Gs5nI8q8IQDKyy83sBmgl2b3Py7xNN
	uIJbfe0DdMV6mOT5ft8CeREplkp/bemN/6YD/SD8HcsGBAcrC3TB0xn/dkoofq/bvD7EvvfyS04
	J9qksv2seXiVUAoA1bK7yDAlhbNB2kjnGtGbyaZa7r131Z1/CReCzsWVFd2Qr9QLJmmxaBSWa66
	ahj1yGRIXORuTAJe7MHTiul/ygdg/f54VmgZLGQbaWfMvPwO9j1FvnVd/YQgEp8+70nbTLEseqw
	tIK1+pl11P+8ZQ==
X-Google-Smtp-Source: AGHT+IGw9d1pKeseKB3lkBBW02LMj7kEUpU+h4+fmOwbWm1TH6VnLmuaWiTPpQmTwuE7imUFGIVOUC22U7kWNosjmns=
X-Received: by 2002:a17:902:ec88:b0:293:57e:cd70 with SMTP id
 d9443c01a7336-293057ecfddmr246648875ad.28.1761559475507; Mon, 27 Oct 2025
 03:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com> <20251017112025.11997-9-laurentiumihalcea111@gmail.com>
In-Reply-To: <20251017112025.11997-9-laurentiumihalcea111@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 27 Oct 2025 12:07:00 +0200
X-Gm-Features: AWmQ_bkbCiTHPHYYWScVXCVLYPxiC042hgQVGHC_daQ-QvhcSia1ZdA6dYYMWm4
Message-ID: <CAEnQRZAN0Kn=3hnw6dvCDsXXrQc17E87_hRT1R78ueKh+PzKjw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] arm64: dts: imx8ulp: add sim lpav node
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:24=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add DT node for the SIM LPAV module.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

