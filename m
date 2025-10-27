Return-Path: <linux-kernel+bounces-871274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D8EC0CC7E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9DF19A3F87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14042F9C37;
	Mon, 27 Oct 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU2xlnB8"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22AD2F619F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558711; cv=none; b=k7MIdw6F4rIW5ahTdCfHFKm89h25iKfsHFavzbULxD2puSd7I3mEYrDHsO42U+J0s+xGwhMNttQEHCNPY0pWN/OgLfn7IxMHkRML2Lpb+C466w7uj03ggN8gS9UycAAbaSIRa4/nAYsowZwfKT61QrA1/39+zx4CZ2+jLwDGmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558711; c=relaxed/simple;
	bh=xIlMXVZM7u5N4GC7/QPTBmuvnR/eWVEU2XMt5zd3xvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKSuid99bTUGgQ4QynV779YKASSkwGJwFRqKWgIiNeb+UWK223MYLmnTHYbM3NCgEiJOV5r3iER0d6sHxFnJ2kJOEOCS/rwVDcbJW/trkx9GRjj4Tyhr6F4B63/0zDopexbwxcCbpOsNoUshPuoMT129+UqfqcPGSUKJLKNS/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU2xlnB8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so55951735ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761558709; x=1762163509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIlMXVZM7u5N4GC7/QPTBmuvnR/eWVEU2XMt5zd3xvk=;
        b=NU2xlnB8jPVF2UDNNhtDK+3QMQfQi8vXnjbpOh/Kcf9UCYBGzqRSdDYnb37CEvTcws
         i/K9A5FYCx/kUYdM5l16IpqmKvmrC9sfM55e6xOX2r6qwDm7XQGRd+vhla46Y5Oefvm9
         2vXfxxkdMgazL2DNn2YgUC7etK6NK6Si8PsKEuwIi+PgddqsGpFwvPtx1R8sLMVJz/+3
         bZRFRBInAYzd3/sAFdLL6hXmVFp02N3Ce0QNYWKf9VJDvdOvIp2jWp3dl+zlt36NRDK3
         r5mmX1o4ik+jSfxMKjrdEh2DA8T58WmyLGKYB4Ql3oHM/LsgvFg+lUd0JlWpkju3R8Qp
         vccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558709; x=1762163509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIlMXVZM7u5N4GC7/QPTBmuvnR/eWVEU2XMt5zd3xvk=;
        b=UBajKw20c3HvbNmxMKUeyIcwxrdcWUxnbZ2H3HIk2uzHej+oURaYgiN1MmFkF1Gv14
         K6TWWc9hIPmK8c6jD7QMjVwFqWkb3UyHahiyuUv+ug+HK8E3xMXvnRM1aCgsA+Xbkjc7
         SRupSP8vA8q9KvlL5Vgq0WTvnwzSHG92LxOlUHe0RYt3X5FeaUWwB2GyCbPSDLZGsPlA
         QEbtvMEyDZ2zU9LPd6wQLwJvfC66hkI9TB+s2F7lb3ibNlMS6JSpjr4M2HBT7cR4nuZk
         5276xbd8qZIXFKzXE+uH8kcmS960L74MQ+MvOmDMOpXAZTR61J5F10q7LjaFO4H9XjAW
         YwEA==
X-Forwarded-Encrypted: i=1; AJvYcCU8No9zP6UPNPSDiKoYMrJ+XL9J2ICseqnU8vXKnuWVLRgch7XxEsRrkHELNNwTfpvtcu9GXf7IW1U+D20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4clLihgUyOHJnJ7anDVcCyFjQaEuc8GhNn1mge4todZ9ksD/J
	H07FH35D+B80vmxwyiYi/K19W4tG7Et3O6xdBkKsR1/+/TtftG4QBwdq5QG0dO3giHbHNal7MRG
	Ju3SyRFGvMnuMWmnslkRPsXnZRbqUgmc=
X-Gm-Gg: ASbGncswDzj0DYSk+2oey6YuzocBJvGZtbsQn9rb3r6B6lmYL58xpZvH/crHy8Lv7wi
	/kNQ9Z+5ktmetDBiudbFkJDNGKFiKNf91qQu4ggyscLlbxuxjchQ3NcnKNPMLNCQjyiL6tPBrdp
	BC39XnYMMnYDqksrDmOUmDqNRVLXJfm69mS+hlglBhK1bBRNyZqizNwCP6dlE7kzExU3EuhpCax
	jI4zna/bqOgoqyhnWM1UYjMY5tcaZUqvAjJKltukWlIkDzBLcFoqT/rl4anqis5TNWctrUPueEC
	wt0iZWyEgXUnpNnbzLVw2MVM
X-Google-Smtp-Source: AGHT+IFRzbIzqFV7pKBghEkL/y5mdil9BPJteZ22VTJLWtgkr233BhWTD9Jj/7BDpxsKVDDIAx7A2JjJcaX7rlq1vtg=
X-Received: by 2002:a17:903:2f82:b0:290:26fb:2b91 with SMTP id
 d9443c01a7336-2948b8366cbmr145344475ad.0.1761558708890; Mon, 27 Oct 2025
 02:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com> <20251017112025.11997-2-laurentiumihalcea111@gmail.com>
In-Reply-To: <20251017112025.11997-2-laurentiumihalcea111@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 27 Oct 2025 11:54:15 +0200
X-Gm-Features: AWmQ_blOtiRFVXUmTtN1O1lNjloemNSQ0tmWC3j2G4npOc3ifmBMtfeWO07HwwM
Message-ID: <CAEnQRZDFkQ80TGvpCDRZgVtKF9oUVoKQsaAtyhYHWHAZsg0fHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] reset: imx8mp-audiomix: Fix bad mask values
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

On Fri, Oct 17, 2025 at 2:22=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> As per the i.MX8MP TRM, section 14.2 "AUDIO_BLK_CTRL", table 14.2.3.1.1
> "memory map", the definition of the EARC control register shows that the
> EARC controller software reset is controlled via bit 0, while the EARC PH=
Y
> software reset is controlled via bit 1.
>
> This means that the current definitions of IMX8MP_AUDIOMIX_EARC_RESET_MAS=
K
> and IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK are wrong since their values woul=
d
> imply that the EARC controller software reset is controlled via bit 1 and
> the EARC PHY software reset is controlled via bit 2. Fix them.
>
> Fixes: a83bc87cd30a ("reset: imx8mp-audiomix: Prepare the code for more r=
eset bits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

