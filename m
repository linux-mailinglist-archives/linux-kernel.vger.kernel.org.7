Return-Path: <linux-kernel+bounces-822155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2C3B832D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191073A8244
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073312DE6E3;
	Thu, 18 Sep 2025 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASTpu7rd"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBF2DC33D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177709; cv=none; b=HdYxhh1w5Xyd6M+nZFuAd7ZTapSr8e8+COAfWF0PgL2uN6bRDM52Bc8phoTxKJlik1gP/R7PVgXUVo3AbeYTSvYItnBQdH7EedUc94JoK2vadGz2HefJNsUZgiDtbtyKd20Rs/fScHbtt5jvrmWf4dVoY+IvE2BnQgdlLOl9W7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177709; c=relaxed/simple;
	bh=uhTbUPVJFOyAmNdzQk98ubzkzQEcGMZ5ZsZfB0f+IFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Djd9jphvOJs/i1XK66NWT0QQStlVpR/rt49nGfX9T+dOB4mL3iR75HGQyK+xDitDsNejfJ2M7gGeBe54t+xTGUGpEOEvEmLEXPHPo2oK5gZT61THsQiZ7oIYSDs1XvBhq/kcV4RPU+qKbs+YV4TDWKH6WFjEgAt94gDu6106whw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASTpu7rd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445806df50so5056615ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758177706; x=1758782506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhTbUPVJFOyAmNdzQk98ubzkzQEcGMZ5ZsZfB0f+IFw=;
        b=ASTpu7rdhCzP6+DTIhJjKumYJptkqFUiG9vq8gUICQ+ro6fxWhT9Ehcf2na8Z5d32Y
         PU29NMy3wMfLnC3wjGz8ukf3er6mxSKO27O7/ZjJ591pQZix9RfcIIpudmMYXHtd34/T
         YnMkgY5XDqFX4QnJRrriSnxG3LY8LIjFulI8csJAJ3Ty10dAOcAIIPIG4pLe8rljmCO3
         W6zIVPTuuhlSZyGEBPDv+XTawGAk25gG+/gb8nOAgXVyauRijMxiI0V2HK159xMuonBP
         rZ8quD1wSjtvEqM5ZyVD8M4I60cjINogwcbHvDZVz0Nkb7IMgw54bQwqSWwfs9nnIywQ
         Wwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177706; x=1758782506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhTbUPVJFOyAmNdzQk98ubzkzQEcGMZ5ZsZfB0f+IFw=;
        b=jL8lu8dJKKD/his5ucu4fzvhY14wU69REi89ys4m3LlGJrJVRImF2HGotX0jVeVcRk
         Nho2Cq8Py9l/jsGUqewRxONpDKu2WqJWzi4w9n70aelorfC21Y6naEORWLKxlHPE/ved
         6TcTBTigkqdPJVF3gpTSSDTVTKmXacI93MD7d8FKaFfq/z0uMeLiaM1Fl96QIbD/t3mQ
         Rah8Rc8CiSaRtFMurvQS8lEgaCPGse+wZXoBYAszHH6F/bIGEHDzIz9CHjcydt15kIX8
         ojueMvQGu3d9GEaiYxcXqf1h2k2onGFU/oaWLDRiLZm7lyrcDteG0ffnR4aEVfCcoXl5
         ywUA==
X-Forwarded-Encrypted: i=1; AJvYcCWM007J7xlzKhoB6++D7FnpFI/FalwXUlMnG1fH8cjM1d0xQ4olqZKYTinlncqFHzHAx2IAVd0rQX9Bd3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLdqxIzeQpATe4+vs5FFzPcqkdlX2h+fbNErUv0+zK8laSxV8
	n3F7Jc07vTxF8isW42o7CiBbqob2dZ39UjqLiJRvHKjZ/etOlKm+9fBOHecgWCiXlTm5I+DkXn7
	lKuNGdtNSEUiGL3N1FeKKpBl4+G/GVeA=
X-Gm-Gg: ASbGncvCg9n4RPPRi5kS7ryrpDv99WkdXaxhUNkCMsX57KrZx8QJqq5iUG5/cHgS0TG
	DEgPW35eD/Tdi+WMoNu2Z7/44K7K5bg8xdbaYwY/c44SF3e6a5FdmjMciuX41dk+Cvj4m3HwuPJ
	MBtENK70yp81ydi0KCggT0I1lEu7Mt6wGMMDnA7gQ3KpLzT7WJ+3ANttVJTIXcXtc7YxmMqs5yH
	DNuKNB3RU5Gvp6Bsl+lLgcR989U0u5gxl5ONxSxA13SnjSxP1OsvA8=
X-Google-Smtp-Source: AGHT+IEr8P+L0TJR3342JH9xYHQV3+Q0WGlxdbCLJmGp2Q+KPgwKRAcFBDBLv1ory2mNLCloivvxGbpVxzz0t7SLcf4=
X-Received: by 2002:a17:902:8f8a:b0:248:ff5a:b768 with SMTP id
 d9443c01a7336-26811ba5363mr43004575ad.10.1758177706285; Wed, 17 Sep 2025
 23:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917-imx_rproc_c2-v1-0-00ce23dc9c6e@nxp.com>
In-Reply-To: <20250917-imx_rproc_c2-v1-0-00ce23dc9c6e@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 18 Sep 2025 09:43:52 +0300
X-Gm-Features: AS18NWCPevQZqr-17ld4WpzvBigiHU7qwZn_PzyMsJ9Y7iuvJrnxcIFdLFQmdb8
Message-ID: <CAEnQRZD=1hxMmR98qfpoH_RFFrSrYMQ6ithFkjyqVgtqWKB_+Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] remoteproc: imx_rproc: Use device managed API to
 clean up the driver
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 4:33=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> This is the 2nd series to cleanup the driver.
>
> Patch 1:
> Fix the runtime usage. This is not critical bug fix, so it could be
> defered to 6.18.
>
> Patch 2-6:
> Use devres managed API to cleanup the error handling path and remove path=
.
>
> Tested on
> i.MX8MP-EVK, i.MX8MM-EVK, i.MX93-11x11-EVK, i.MX8QXP-MEK, and i.MX8ULP-EV=
K.
>
> There is still a 3rd patchset to do further cleanup. After this patchset
> get reviewed, the 3rd patchset will be posted out to list.
>
> Thanks to Daniel and Frank for the internal reviewing.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

For the entire patchseries:

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

