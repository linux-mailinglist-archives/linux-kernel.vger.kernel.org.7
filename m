Return-Path: <linux-kernel+bounces-828324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CDDB9464B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D49174878
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A92749DF;
	Tue, 23 Sep 2025 05:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0sZbfYB"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466DB26738C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604948; cv=none; b=KQeTtNK7zfR6mswq1gYaUCg1QanTtpQOydZlTOXlmqADY4zzhc/OP3gOuouHx3L7v2WC2DMoalk4xz8GuJW3WwlY0fGTYst7FuYgLqmheT38FTfQ1N39uVUtp34Y5gkNKbf6CRRwRxHHwlVj4tNVjGY6ehp/iu50GcEYxxN7ALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604948; c=relaxed/simple;
	bh=lGHX5iqtB9RFLRtL8dGgqDLJYcyVFasgYEy9aB83oIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lU698lBlmB0IK6Xix6nIgzSkuxmebhWiAB8y5sE1oNcw36ojeZjOlb8MP+6He90QdUpFFdAxry2mhKGAiZ2KhWryltPrQ+9WqfG3KGWg3+hd4tbqCv0peQhMXGV2jUYrcDMeW2Vt2tHLaJ5bXeOjlu1HSd0TrVKiRQqONyizXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0sZbfYB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so5464496a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758604946; x=1759209746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dmt/sXOh8gCfdLN/NRWF2le0DpBMuP58ZmmKHufhPw=;
        b=f0sZbfYBjf6e6NQgv8F16fBNLIMk0ake5l6VmvVXgvNfoc5G7pcl2oOOrWLZIOom98
         lekmfpEAECpyrZxY+djxJDRmxqINi+R5heIQ1h+v+NOoJwiC5WQ7I1r1VEwFlGeELCt2
         QXqSz0sEX1hi88XbAFpg75cz81Sd7dLCkeJM2o3XD/fhdChPOUN22ogIxTZQ1GUkKlAh
         Vdo7cuuAzXWRLwvQMDpWhKt8ivmjrw8YOVKKhZD240Wp8D1EehEyShJTknz8vMQwlv5T
         MmymV0JTDqlVHomCbpgASU6447jPzM7OyXcasRBnBesCaPpsyX/NBuSx0Ifx0qwsSiZr
         L2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758604946; x=1759209746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dmt/sXOh8gCfdLN/NRWF2le0DpBMuP58ZmmKHufhPw=;
        b=i/nWNRkbAQCOF7VLsLEmIVnwPft5vyU3zGle4onY6fciM0JEq8O+ANZNYQnMMR1RV0
         1/moUKVLfIB83tJF3pjtibak5Zyi/K09MUpARIJ14/qIri4N9viHSXvko/YG8jiKuNGi
         sCds/CnOLjVJH/Ctj4mDWJlaf9lUh/3e7Soe3u2I/P37bD/DukKMD28fA9jB7rCsI0K6
         mNnbQR/7IWe/BfvEE1qhde0FHJw6782u+AgV3gX9gdBflaqG/sGqgLEXrQTyNef22fIj
         AK7jQWgXIczcQxbIoJageUXBN7/FtSJ2X5zezQ5G5fnRCVyPv8XrXYxzuKbTdqY6bx8+
         I3vA==
X-Forwarded-Encrypted: i=1; AJvYcCXzkVLD1FUmijW6wigbRt+1MHvcCK3MumhBM3pT0DPLYmR8rfER4CtEoexl5hI3lAuVpyvdds0sSh/wA+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YysuG5L1O7IMFxzfQ5wiuU7DzA69/LdeRYDoXOoUCjNkh/ydpda
	D+hpopt47TCdeF7KXDnaOE9tnPacb5dt64w0Dm2bpdVsD1AfgIxcIGETeBfAzexCHrqd54Boqfc
	EiPgD3+GgQUSWKV7fTkkEtYrjb8/KvAE=
X-Gm-Gg: ASbGncsGWQEegTa7JOFLN0QkfUvKB9QBxdnqugyMhvaMQN4auvxLlLACqLXbgn5XbRL
	6MiDw/hTQyCHHHh7YHaA7XWi7mCRlrVW/CqhFHz2QPZHw3aY79Byre9NGs3Ivdb7KP2/9VRc42D
	BfBKXXXeRFIwlwvRa97EcxNeJ6zOrh3GWaZvc2iHWf+WHG4hrZQvXPJai3wpdKvwInkkCGt4h1G
	lsKf6E=
X-Google-Smtp-Source: AGHT+IHjWF0OdvwVEBZ2nx87jdr7LoutqHAGG2hOFlgZ3AbCfU9cADrnOPszTGryVxRnY5J5JPGYaDNmdz6D3L0+UhQ=
X-Received: by 2002:a17:90b:3d0b:b0:32e:18b2:5a45 with SMTP id
 98e67ed59e1d1-332a92decfcmr1741778a91.5.1758604946515; Mon, 22 Sep 2025
 22:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920-imx_rproc_c2-v2-0-3351c4c96df5@nxp.com> <20250920-imx_rproc_c2-v2-5-3351c4c96df5@nxp.com>
In-Reply-To: <20250920-imx_rproc_c2-v2-5-3351c4c96df5@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 23 Sep 2025 13:22:12 +0800
X-Gm-Features: AS18NWCk-cLOeEky62DrDgsGiwmbzQDyczljQVACaIeDqm4vgeh4qeeeuazbSbY
Message-ID: <CAA+D8APwkqsAEz=xgaZ9h_4NbFemMoACEJ=xXjVkGhd4mTxmEg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add an entry for i.MX remoteproc driver
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 9:16=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> Add an entry for the i.MX remoteproc driver
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Best regards
Shengjiu wang
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df319f9762b369a2746ee7f41334be9b57e7bf9b..c25aad1ad4386623065058d1a=
7cf92e1555ec7fe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18508,6 +18508,15 @@ F:     Documentation/devicetree/bindings/clock/*=
imx*
>  F:     drivers/clk/imx/
>  F:     include/dt-bindings/clock/*imx*
>
> +NXP i.MX REMOTEPROC DRIVERS
> +M:     Peng Fan <peng.fan@nxp.com>
> +M:     Daniel Baluta <daniel.baluta@nxp.com>
> +M:     Shengjiu Wang <shengjiu.wang@nxp.com>
> +L:     linux-remoteproc@vger.kernel.org
> +L:     imx@lists.linux.dev
> +S:     Maintained
> +F:     drivers/remoteproc/imx*
> +
>  NXP NETC TIMER PTP CLOCK DRIVER
>  M:     Wei Fang <wei.fang@nxp.com>
>  M:     Clark Wang <xiaoning.wang@nxp.com>
>
> --
> 2.37.1
>
>

