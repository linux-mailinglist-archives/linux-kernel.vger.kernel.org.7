Return-Path: <linux-kernel+bounces-871303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F44C0CE04
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF4404B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754561C84B9;
	Mon, 27 Oct 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqNkvpuJ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B825F984
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559228; cv=none; b=V0EQzzwtkjHnbch7GLIvhG0AF4lP9SbiRiqEK/4I/YUjPa0n2wCVTZuwynu4wu1rvXdJHe7BE6tF7a20Bkb+/TB2+fFazA1hkLWwL+dAmnQXkrOQsBS9RlTMOrJN54n6KsaVEu6NTFPSwc49+AsCaqjfuBFBg2BtX6qpOKAiCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559228; c=relaxed/simple;
	bh=llevhbx7w2gVPSgxchYQykyfF3P6kCmvO3Z+1l6bNEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgHkxiTFGioEOtXeYEW8bRbn/VmKwMnFtCvmd5Q2eWss9194kCJeWkrz2VMdEVmwknlTpy0MlMR5LUgEtp1vIHJW4nJovknMWgafGzI+hoDd0A8VQivDB1/Xkds0L6USMrRP9fZ1PwXnr2wYNF3wEWo2CZIAFl0+6tdMoWs8mwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqNkvpuJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so4040909a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761559227; x=1762164027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llevhbx7w2gVPSgxchYQykyfF3P6kCmvO3Z+1l6bNEw=;
        b=BqNkvpuJxdLFFaYQmH6TFx2FCGfBO5dYTF27G1SnJK+kZOD3xPEY+kn1E9UrVkf25g
         zkawesYiDwVSXoFYjTeE77r/8zObUTIRlzXL7I7x3RpZAQmCJsGfvZHw5E0vXocKVcyx
         qa7vHdSpwKSv+QjfiXm/kKdWU7rLhXRza5V9xNeEBz0mNKF65ObfuLGrUHDL8ePslbzR
         Uk1eaVlqxFoH6Lq1DJVUd0EDiEk8KFT4xIPDOV1QpJI4Ol5kw3qZzxtuyTMD5NCWZ2aD
         M23eFzYXu92ymZdM4P86C8lXJt6ha8Un5PRq8uEbBwg7ShdTZ+5T6vwFaENWI1YBiMLm
         7Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761559227; x=1762164027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llevhbx7w2gVPSgxchYQykyfF3P6kCmvO3Z+1l6bNEw=;
        b=cuKkk07epVKJEQEpYLWbUzesCc5lmK0h8Gd0LUWocQB8GSnwHdp6EjPhauk0SX1U+V
         KshE8ATB+jLy1gID90Y8LdKZsbRtpR12KmAl+7AB6uMUC5z6pdPVJpLB2T/eP8Zcl4TO
         YE3wz+AB/iTSpKz3iTvnT26OTlr5gnT801n/DphzwnNPZj4b/mTGAYGal4EV++V4IRYt
         xYgrvQ++wiDRs0DMBcqltgWclgLZmivD/hRTpjXZaUStqiwp7SrG6EjaJQCfYanmfM/Q
         ZOxhGjaZnqkj5FleN0AZ2Z/wWKGxQ0fVZ+/pokb8ChcGMCVXEAFAiEXozqtz4Tb+yR3R
         OG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYkrPLrtU7VLPtntubMAz+VHJrvUC/nUfeUQRDDl0fxnb26vwnCLX/MmzbpOsRSb1yPtkKz3jwI9A5mYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNj1Yq6IXw8mk6aiuWINe/XE9LmOAmkdkUlcrv6QirUk2KDppi
	BjhXC8340/icbWJZM9IPLJJNIl1ZwJC5nrw96J1vpcpbLGwuCynbWCcSQcrHT3qDfxkG4d0lmRb
	vrfYxUfsXyN+vdrXEeZ/1Qj2UICY1eOQ=
X-Gm-Gg: ASbGncuE/ljR5iSQSFN+9twQ/H1AuN4dDrUZcA+upd28qT0NoUnTONpEAJEP262lCFa
	zeS+Bk7E4atcz3yhZLcu6E/Cz7iSbvd6eZylppu2AklInA4TFkNDJqLV8zVuEOAOUITQFyhWA7n
	oF++ZF6u7AFdNsUIRZk30oVd/f5Nadk4hxSIN5T9dzEdZNDuQfi03YcZEXhK74MKfdrQbUFkOZj
	0Ygs+Hwwzdh5iEkTFMNZ/Crt3eZGaWs+3A/8Me0OgucaBD7RQT4TmbUHFBAHYkZRryZ2tb6hyVh
	V0+ocWgfUN+1tmXvJaqbsxpt5jGPD6uobDw=
X-Google-Smtp-Source: AGHT+IEVKeBh2X8nn5edN2JNYH0ip6RRsXlkactmrlxMJ24ltADBqpxEPIq5x0ftvH+xeOzwVb5LwOMRmctLYx+ASlY=
X-Received: by 2002:a17:903:18d:b0:269:b2ff:5c0e with SMTP id
 d9443c01a7336-2948ba5aac4mr144470455ad.46.1761559225678; Mon, 27 Oct 2025
 03:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-5-laurentiumihalcea111@gmail.com> <aPJWUDXmGkb8QGMz@lizhi-Precision-Tower-5810>
In-Reply-To: <aPJWUDXmGkb8QGMz@lizhi-Precision-Tower-5810>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 27 Oct 2025 12:02:50 +0200
X-Gm-Features: AWmQ_bnztc34-LVMElYU3hA5bxPnJsvEFVV1IWI00q3s-IiPzNkbThRFF6roaYA
Message-ID: <CAEnQRZBFCi9GPaAw+NdKboADSpzPKGL-1B3WNh1M4Nuxd_9rqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] reset: imx8mp-audiomix: Drop unneeded macros
To: Frank Li <Frank.li@nxp.com>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:47=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Oct 17, 2025 at 04:20:21AM -0700, Laurentiu Mihalcea wrote:
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >
> > The macros defining the mask values for the EARC, EARC PHY resets,
> > and the DSP RUN_STALL signal can be dropped as they are not and will
> > not be used anywhere else except to set the value of the "mask" field
> > from "struct imx8mp_reset_map". In this particular case, based on the
> > name of the "mask" field, you can already deduce what these values are
> > for, which is why defining macros for them doesn't offer any new
> > information, nor does it help with the code readability.
> >
> > Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > ---
>
> Register define still prefer use macro.
>
> So far const string, hexvalue prefer use value if only use once.

This is simple enough that we can use the BIT() macro directly to express
the masks.

As you said you can use the const value (including BIT()) when the value is=
 used
only once as it is this case.

So I think this patch is fine:

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

