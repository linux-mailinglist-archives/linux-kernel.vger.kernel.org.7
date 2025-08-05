Return-Path: <linux-kernel+bounces-756090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548AB1AFDF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D6FE4E1FB7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E629024887C;
	Tue,  5 Aug 2025 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2cgZxKH"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC3246335;
	Tue,  5 Aug 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380310; cv=none; b=E1WKueNYpoUZaLJaP+okElIRZUPqcWhs2zdVMnRzRUcCYFKwEIxLV6LRP/PndPsOggc0WwR906h2yRATMjz1yd+PPiuH6SzC2//Xrl9MX8VNNaNjAhsC+/gQEpS0/NIoWPvoY4LXOv4vD8MsF1AnOwFWjwtQpUjGx32PWX55hXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380310; c=relaxed/simple;
	bh=DF14p86C1doTAXUJtzsz/T5aS+HX53wfXuMCNvC5Hto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxKzO6+A7kt20z/CBV1LLKJXkpz/jUhy/EU5VY60Iov7Mmpw1nZmQbWd3EqvwjpSqBR8feJEarIyc+X41B3EN7dcnj35EaXJZn1tYPDrnsRP07Yf40M6KX2zYiJb14TrmM6oodCGUwvuiA1/nQwo1jz20nr5lPrY2SNZj9vGsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2cgZxKH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74264d1832eso4793310b3a.0;
        Tue, 05 Aug 2025 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754380308; x=1754985108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF14p86C1doTAXUJtzsz/T5aS+HX53wfXuMCNvC5Hto=;
        b=J2cgZxKH/eHMTeM1BE0oDCuTRYylYFR8qVR/qIwVnwxP+Tlgxb36MfbsSejxv2WCXG
         52+DjNlwFYm+nYZ6ih9bXS1gQwdcSIPZ9M8ZtZu57Ty1aTjDCWiChohpErU2UU6I5xcN
         4EI7ukt0mw9zWf8QtJKBaXQK/jFCeDRtFPWybmSDk607+hzLgz7OtBALtaL8BXH56abR
         qAxWVH1s6PDp82+mMvC84tgPLt2hFZdsz0kskZ6INPecoZv7YE9DLcbYy89VYr/eU8yV
         AJutN9UCE3AhDntpPyIfYHIomdjczQRUBBKfYPijE6GZoOUPIra+RJGhDvq/J+BdWvQc
         edxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754380308; x=1754985108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF14p86C1doTAXUJtzsz/T5aS+HX53wfXuMCNvC5Hto=;
        b=OKpDebHmK59CWaWcK8i2VkdL/koVkHZEURyzmnxH/7/Xfajg1sGv7ZL5tc6J2gqCKo
         avXmurHiSc+xOjDWPRcZrHTx0ETxr0gpEQZ7u83c4F3tyqZRurCgkyG0XfxdmZrG+W9V
         C8lViM8ztRal9nKAckbKD1R3aq8DIR2V5nzzcCtiqss0fXwQVtKuDxdKhknDOHyUpFbr
         jNrR/p/bpJlot8g8sxtJdAWno9lDP7aMs0bsp940nSxg6DTLlduR4p+0q7D25etVTgEA
         dn28a4ZY4YlxBZiwJ7QAsvd4Y9kraZn7RMPEqwl+xT2JFlCHxjr4iwAN2SlNVO5aVJk/
         6p5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvPp2633LGLJhk+jrMYYGx+Vx8r+sJkTQSLo2v3542LXFT7nFMTH6PSJ44CQgfrk+k1VIcr1TaBNWo@vger.kernel.org, AJvYcCVhI+Loki5PaNz8z0obl7JDwt4lTt5XHEojQfxCnfjmdOhDWws5xGxqH0rh//WIUElu9295C/C0Xpsj@vger.kernel.org, AJvYcCWFxZR4fIMj3Ns+0nKU91hLdWMvpCgRMFDp0ETdBqmJtOGBY3nJtq/nC601IvfVgdTEiPeGROUQ/1PhMc/o@vger.kernel.org
X-Gm-Message-State: AOJu0Yx19UTg4GG1tWbNBmvO27b+XcStVfG3s/o3CTWCgYK5F2JTMKoG
	xNCBUu9nSHaqT00SY4ymI1Lw8yuKk5oTwKssfIUXs7ppSUkhMIYc6cLurPJX5emxj4TmHllPaD6
	rxtad+KD1Ro/rm4/VVqP2p+kHFjaHgkY=
X-Gm-Gg: ASbGncviLzcFGEe7WanWrLkoQR10EbpmiUAUhD8ROp3CNGtbs/IwmZjcbQVGP4n7D08
	JLm2Ed2ut5LqvJ3PR+b5LH+HX2v5+4OUqHPnnIVGKz7UrK4jvvRUp5uY+kt/+tvrGy21DeM2snM
	UsrjqHnjtLFnOxp7c5fjOMXE22fDSkpKjI12ewGo+pI8588Rb+7yjE2E+IQk5xckZXplulD/CZI
	q6Y
X-Google-Smtp-Source: AGHT+IEWmtpQKbGUq/1bFP8Lljg+twjtflzwS9IvD3UxctPY665t4Ffz1Dc9oQm0cJB3lp//A3+8o9nPMjYNlLQTx4A=
X-Received: by 2002:a05:6a20:6a0a:b0:240:198:77be with SMTP id
 adf61e73a8af0-24001987cadmr11786044637.42.1754380308033; Tue, 05 Aug 2025
 00:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com> <20250804155407.285353-7-laurentiumihalcea111@gmail.com>
In-Reply-To: <20250804155407.285353-7-laurentiumihalcea111@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 5 Aug 2025 10:53:50 +0300
X-Gm-Features: Ac12FXzs-8MGoSs0GqH7OpNp3C2Lxecj08a45oMAKLepSFZX4ZB558QC9xKWl9w
Message-ID: <CAEnQRZDxMc43_U1kwnFDLnQbYgpKDmPYkdqB6dd44K62Ka1GqQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
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

On Mon, Aug 4, 2025 at 6:59=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Support i.MX8ULP's SIM LPAV by adding its reset map definition.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

