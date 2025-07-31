Return-Path: <linux-kernel+bounces-751623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC10B16B94
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B315825F5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5923C8CE;
	Thu, 31 Jul 2025 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4WUWTFB"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0D1DF267;
	Thu, 31 Jul 2025 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940082; cv=none; b=Jh3aZeLmwyDAAOEPUbxQ8v8ALU38sngbf/7ISvkjYXaR3yY4s4xtjv+bbL4Md/ePWA6fRqVA4wR1DlH+0EQrf5LO2V5UhCqFN9Ng/AIPNlCb+SfdAyAt9BClz8x47hn27NITvo3yw2GSGZ/YbIgUSM5JxqkhXT49tNsmdRHTBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940082; c=relaxed/simple;
	bh=P4Sp2GDUfFML3x1uoKRtS9TflaYxWalc0AI94nd7XtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPJwem2SrC6BugzgKViFm1juAZACp9sB0XlYZU2pcFvOYaNNCgjEu9nrNI79jZksw2SrplycaiLtx26fgHct8qdhRQbjRic4CHTruSKCPU2gnkxKWvXpjl7nwe9eJ9+P2SCdwBXAzWqfNqfD+AbZD2flghw/LtkA7GEGBzlqcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4WUWTFB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so89001a91.3;
        Wed, 30 Jul 2025 22:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753940080; x=1754544880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4Sp2GDUfFML3x1uoKRtS9TflaYxWalc0AI94nd7XtQ=;
        b=G4WUWTFBUjCbLHzMpfOvhHVmDOB43CEbUwPdHJZeNudZuvQVupLg3k2+XG2DjyA7kP
         pn8rHFUx4jEIiYa88nn1WaH8ynXkHUk94zo9/B4Pg123YvixQhXm4XrkSPi6xc99Wx/B
         iT2C/lgzhx3Hr41D0dKaKwQSsuGnD8D2XwT28aQMMrHf8UN7LWo1cwcplDo5ZAwge6s8
         y7JXy1/YA2aPWF+aRcXm+Qm/1SFbip7hPM69n3S8auFg2JKvo8I0RmmZbHXnjFAP/1Ql
         /CznT/ZrhN5/5FwJVSTQBP2MojCeyy0j0TFvLPUsAHsWt9HptaG7xELbhW+0uM7ZmWt6
         tgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753940080; x=1754544880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4Sp2GDUfFML3x1uoKRtS9TflaYxWalc0AI94nd7XtQ=;
        b=R/dbN0b1aC94z3P9sfi8wHzqAmRrxvB7Q3h27VfUS85HdHJtlrkbJ4mv0Psj8a+cAX
         C+tVkcwR6qRBOp9fPI0zF9am55PMitvv0Ps2yowMhpwg6ZzUIVGxAirUxjeV1BzqlcWT
         y12qxTk3gugPgkf42jk68jCoZLChrMCOzpNbhpstfwFdJMJMIi7Yv8GUQFYM6iisAytR
         xI14tYJoz1xRQtbOdSh5HXjSHMXo3LjuG1dxSxbwFDoffeKAAEGzkL8g/VzQiCITf/+N
         +j+Z441wtLn9FzvdZNbI2qNA57nlr846F0WYYSINH+N3oOEYlmNDhotdb0+cfreqnoh7
         oiwA==
X-Forwarded-Encrypted: i=1; AJvYcCWywLHM3fmZX2sHCiCLGKRUgWeTQgq0+qgyLuzwU91nhoGqudT1SpXuGdK0bWNGGTF+aNBdHmUNhBc=@vger.kernel.org, AJvYcCXtWjxNs1W2UO4Llg4hB5/3UNHnAq0hIFi+PFqT2Z3KcVbg9hGk+ovv9LPUXJIyKkgwbZQ7PDFglokebd2K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2s1e1OBt7m/0BVejAhhtgkKyZpd/CKGxAS7q+y1+odyWkEZnF
	GIOIJhxurmSWJLOaTkhiNvmT4qN7Gpf7EanYjolMK3LTboSu8pFHtm4mMFTO8kbG9B/5zw4hBwS
	3RSanUUnaxIsHzU18xKmotdGnuyvH4uA=
X-Gm-Gg: ASbGncteS/S9JQP0q1Y6Ncv+gJ2c/Z+IQiQ28SrpyquRCuDpfMaoCOFhl3x2MD4Voje
	DzqUnX4rDWMd2Ms/UzGOyG3NoZv5hBo0AO5dagfSIJQo0OFylS684K/9xfD9tXYvf1VjTidhVQC
	5Zta9ISR0l7fz14nTm7/eBs2JPiD3dEEOTVS82egl/kCzC4Mh08mk9X2svrnqReF2B/wIf69zMz
	A1e
X-Google-Smtp-Source: AGHT+IHXrxbbNNYCinyHQoskYKFqoXHqmo6YX2SFTgg5APWeBRHOh1sgrx3dY4RlljDqEABe85zpkVvrzPg+EkqADTg=
X-Received: by 2002:a17:90b:5847:b0:31f:42cd:6900 with SMTP id
 98e67ed59e1d1-31f5dd9de96mr9675756a91.12.1753940079962; Wed, 30 Jul 2025
 22:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730125932.357379-1-laurentiu.palcu@oss.nxp.com> <20250730125932.357379-2-laurentiu.palcu@oss.nxp.com>
In-Reply-To: <20250730125932.357379-2-laurentiu.palcu@oss.nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 31 Jul 2025 08:36:47 +0300
X-Gm-Features: Ac12FXy6016R5yBjERUVNjJ9NaURXNKHJ2pnztmaFYpAtiC1FehtoRDqe3M3hL0
Message-ID: <CAEnQRZC5UDTMeF==2POenjw+YK6X4rCPCH_XN1Jq+ULJLofuqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: imx95-blk-ctl: Save platform data in
 imx95_blk_ctl structure
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 3:59=E2=80=AFPM Laurentiu Palcu
<laurentiu.palcu@oss.nxp.com> wrote:
>
> Add a platform data (pdata) member to struct imx95_blk_ctl to store the
> result of of_device_get_match_data() during probe to avoid redundant
> calls in suspend and resume functions.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

LGTM,

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

