Return-Path: <linux-kernel+bounces-756083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85517B1AFC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82C93BEA9A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E424C664;
	Tue,  5 Aug 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EadUrHEr"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D342494C2;
	Tue,  5 Aug 2025 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380193; cv=none; b=cM6KmndKSzD0akYC2TLo6FZk9j9S5+1RsTNLiRNXvqoz07Wm+vHfakl0h13UoKgGilmsqyW1rrvQO7SNN5Ltik0kX+j1Q8pkHu94rRu8lOzoFDNFVsbqb7toaiAJR/u/DOOR0jtwbM2W6t7+JwlNdxJDTfqcuYGFi8GzzXfYbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380193; c=relaxed/simple;
	bh=nWNH5eCqyP/FjxukcloV1DRoOBCv8QarpVQi1BOYK0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=javb0XHf7I4QoZ+4thDE1FITeZGWxGbq3O9ijk0sa+MK7xWT6ZC+RgKSXq0Y0IVoAyT0sGfOzxMx1FCm2Ck0IdDuCOBEO5sUZydJkEI2MPb7xfZOqsdI1vlareiXJ1Irt/nb+bbpwHTP+Ral09lY8CPJdDDE5f68lRx1d3bqdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EadUrHEr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so4217064a91.3;
        Tue, 05 Aug 2025 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754380191; x=1754984991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWNH5eCqyP/FjxukcloV1DRoOBCv8QarpVQi1BOYK0s=;
        b=EadUrHErW7vkKVzl00F3FnUKop06BdBOUwAWBTJ/jLXlgIsxqZ+8kqL88766on1UwV
         eQfx9ktCLHWBeq/H0YuyzJ0+kMN0iTz+/ZJQvlRjbaD5bzE7f8ToqGKr7xjGvRN3BzVi
         xmAworfeB+0VRbIiGG03DsDUBwHGl/eJzHfcgd3GNu94nBwQzEK0XnnRNAk6TFzeLK7O
         X9ZK5lnoI/i2NpMg4VZDacHorXYwVxFB+pF3hcrlnMgr5/l+oAygz2BuOqJFADamye46
         pJPEBmWiqyg9dnTsSDKkc9iVCHK3OPENjEmIg2ixO27gRZ1q2VhChzNt89v7lZUtN1tX
         uP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754380191; x=1754984991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWNH5eCqyP/FjxukcloV1DRoOBCv8QarpVQi1BOYK0s=;
        b=cFb4j6q0HqXorDVtP2O4iKF1PoB+PW5tII80FMsjzb8B35sP3V2Tkq6aXtnt3ornEF
         MxQapLveu/XNvhetzV6uBrL+Uovq+Q20OzBre6gB5LJfK4OSFLsBpS3IlfQjXwmHc0Wn
         mNaWDWLlrzjTWh6tQvtxT2vV6kp/TrRWwPLDSf13TMm7ODZbjjE8WD4gHnbanKlZe24M
         OvXxGgbkDsu/PkSs6B4GQ5Gc1gHNBUV9uJnKzyLVllxQ+NS11ztAfPFrUSp2YbbGsHvG
         IRX6nI4s0VG6XGggGyrCn4N0E6Q+vNxyZH1I5mCvKfaLwF896htt2g18YD86qpWHgM7b
         Yc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnUnVDL3BKkr5HOjapt32R3IP27+U58Ti+hUGXizeeWy0o+6t9E/UfuRppZx6qFmgkV2jzVLMSyeZFh+x/@vger.kernel.org, AJvYcCV+lNOxyNTWseiE90V0eJ2wgcxgxp8Qum/TrE2cA/uOvtkH7YLFGBouJs8mZTv5NlJm180qibnd05D7@vger.kernel.org, AJvYcCWvirG7aCPvtX1SyV9/dw/42nM36oIe+HYoFW9ZYGBuftTePQdL0XWv9T64zEc+xoTVlYOqdBrtzugd@vger.kernel.org
X-Gm-Message-State: AOJu0YzrH0jkNSrgIqzG6gT3xMgXqvjC6379zBYxGVFjXJXsImGpePfU
	DuwTxrrGx89AVHpBiBRj9wknUlCLSdVOrOUwtx0v4tZ2+4ESoRV/vb6lCke8ibgonbnsML5lswx
	iI6me6L1znQ4SnNcu0QGb3q6AzxwNNMI=
X-Gm-Gg: ASbGncvFd4momJpNrv6P7wDbpE1ASeMcC25ZvhCTEb1oXCYZQo7OnZCGbINAelFljfX
	bj9ZwyJesdlqIRuV8CE84v1A86N98aTTpSaqp0mVn4TEoi3WfG0DM7sqXQ189lawizbIA1PU848
	6bPRLpu8rjS4aeY1qJhi5dENm2e/e/FAUKMXMfCpyC9dsSGdD0jBsLMqGECgDyHviwQg7TpR6MP
	DJ9
X-Google-Smtp-Source: AGHT+IGzN/lG60iP8C5y42/6GZHUdwFTfQPnirMANk8NvV5b0No4/sTpu/QFLlH7OULW0Qi45yw+Mon+tegHBGVKjCQ=
X-Received: by 2002:a17:90b:3e84:b0:321:1df6:97d3 with SMTP id
 98e67ed59e1d1-3211df698c4mr12468336a91.4.1754380190738; Tue, 05 Aug 2025
 00:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com> <20250804155407.285353-6-laurentiumihalcea111@gmail.com>
In-Reply-To: <20250804155407.285353-6-laurentiumihalcea111@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 5 Aug 2025 10:51:56 +0300
X-Gm-Features: Ac12FXz_yTxmGlhhGe-fi7WMSXizT1iAGAYfFnkICkWhi-5XkkI01xGLjDZkakI
Message-ID: <CAEnQRZAAwmivz-uu2Z88Ky71eJ=5oRjdSJqqSQ2S4JT2cwQpOA@mail.gmail.com>
Subject: Re: [PATCH 5/7] reset: imx8mp-audiomix: Extend the driver usage
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 6:57=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Some NXP SoCs integrate one or more, per-subsystem, block control IPs,
> which allow users to control the assertion and de-assertion of the
> reset lines tied to some peripherals present in said subsystems. Some
> examples of such SoCs include i.MX8MP with AUDIOMIX block control and
> i.MX8ULP with SIM LPAV.
>
> Some of the aformentioned block control IPs exhibit a common pattern with
> respect to the assertion and de-assertion of the reset lines. Namely, the
> user is able to control the state of the reset line by toggling a bit fro=
m
> one of the IP's registers.
>
> Linux can take advantage of this pattern and, instead of having one drive=
r
> for each block control IP, a single, more generic driver could be used.
>
> To allow this to happen, the previous approach, in which a single reset
> map is used, is replaced by a per-driver approach, in which each auxiliar=
y
> device driver holds a reference to a certain reset map.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

