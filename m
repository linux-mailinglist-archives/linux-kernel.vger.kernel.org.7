Return-Path: <linux-kernel+bounces-871490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31562C0D6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D16253419E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2CF3009D8;
	Mon, 27 Oct 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaZZ4nY+"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C12FF173
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567203; cv=none; b=sWlXg0b0z2YcdqmG6lLtXnVl03QlfE2dP1LS7xmLAmNpjf7h51GHUJqGgMd87GNXLg76SsUkoYf5TJAy3OGXTIZ2LsNGMdiRXQAiKnu8VcQV5zISlOQVHnbUyZOM8oJhBtpC5b+NhTW7nSyuxun9CsbbbqA7S31eUnSbdGvUMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567203; c=relaxed/simple;
	bh=wRnjBnuhyqMXvpQh9LLMBSoQASKq7nZHyQViUHKVz1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQa5tS1CluP3HT1K0z0h/NKRDBPrKf8GFpdql4W4UL25J5y6ABYkQYXT+W0c9qMGZjVa5g0rBPYFokgFz2cwUsz1O2TDcGn0OymHve6KoB3tAD+aUOXXZftdOQZ9zo+D8tRDu/WZMZQxw91vCTQQxdMaYOfoAN5rG4VYYNPW7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaZZ4nY+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-378e603f7e4so35753091fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761567200; x=1762172000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRnjBnuhyqMXvpQh9LLMBSoQASKq7nZHyQViUHKVz1M=;
        b=KaZZ4nY+3TnvvxoHgQrbVu9+tZEK3027bFKCQ+9NiUrlxoI6bv5LnB3mMwAn7cQzoQ
         2vJVHuX26IOO/QdVlq7o92Zo1/E5atx2HzFrIpVjfoPmPiBOUgb+n/8OcO8gg7fubEea
         lokvXN0nFDrFDD03uybyQ/CuRD5zj2VK5vSieleW0j2QwyPXqUYaAkZ8LNDWAuYcJ696
         ntoUG+Ajo9ODZbDftUanUFwg16vPUQPSXFqCpQuaHRV9ay5YQu8BCTyhbw6uJF2xHMlY
         KeK0F3khxW9ePwxVjOW8sM5kytgklboAKlM9aE8nykL0MmtwADPbFOJBVaz+HAeDFE8S
         hiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567200; x=1762172000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRnjBnuhyqMXvpQh9LLMBSoQASKq7nZHyQViUHKVz1M=;
        b=X58x4qW/9+BW9CU2DCpcKexPrqLc8v4/3nJoxMHlbua/n0bAzTrgdh1oq0AwasgSuL
         R85tzAXqA9X2SLeoS9wxvSERCThaDoR6dh/5cb4CJ+779Y84/Cy8iaDDUzcz971DFPZF
         kyLPWopyXMhvinTSB2La6wLpF6PZsFBdJ5ugnthXwebeD62+bjWGlx+anjjedgQ18gEu
         sSX+KaIE3iUm4plCWPEkMzVpuRxT42OALUX3BK/r0kN4sfqgUJkjSSriau2FsTlYsM3X
         BOmp4csLJmZswNiu+YTG6Bdov/yhsM575FOZkyGi+dJIdRXzPDjOPyofiryCSRsFTET/
         JXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwgcehRkHZDU9zT7Q0PUnDTnf4VohuPPTVZWEwMw+iPCQXzsUOqTtHtHScIfYetKPSkIuT8Wu9uO3WUMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3waEKDjJdMlICtP3cq1gbdw4NX5vi519+thAeb3RsiSn7Jm5
	MZGixPJ6ECmn41ypyT8eFihB3xQmlKkaEkP30hvUNqEeTe9G0Ncc+Hw8qliQBXksJXhS0dLjCCJ
	thw/eN5t5831jZEeHCTMzEdoYdYBeg/U=
X-Gm-Gg: ASbGncvw9YpesEAFA5FFKYbq37oCzIXIPCUVWLkDVCEo4lfw2pUwHsga6cGAZnB5Foq
	fagfjdYUo7uzLEC8liiWsv36SO/IqEo1wFG8WcpYiH5+qW8vy53ZtvDKl6bnf+Tl8iTd0IPdv+d
	/xsTLEkBTCQNhPxAFTuWQnRjXBY/Rj6f4dw0DbBnxusm9kwEcKA6lfHIAKk/dwtn/sNE1/2oT1a
	4Iy3N5Yg0haE44Xs8dndvSMPZL1qDlYCt9aKFfapv1dPE/5xo7gLBDRd80NS7yYPR+1exb2mOAJ
	lVgcf41TrRP0ISZxnZ3cc4AmFFQ=
X-Google-Smtp-Source: AGHT+IFFfKN+siPeEk510LCYlRaBchkOKpAuwWhbm3bWGz56uyRA9KKdEl3XVRQWOc57AU14oMs/9BA7nmAnn1K3lvg=
X-Received: by 2002:a2e:be09:0:b0:372:8c4b:8065 with SMTP id
 38308e7fff4ca-37797a2cb95mr104193231fa.26.1761567199979; Mon, 27 Oct 2025
 05:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027110406.543370-1-carlos.song@nxp.com>
In-Reply-To: <20251027110406.543370-1-carlos.song@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Oct 2025 09:13:08 -0300
X-Gm-Features: AWmQ_bkk_6yx_Hjl3n22lrPiupz3ujJbjohrrhluMrC5cpjjXVzvvJEhkBoNxhs
Message-ID: <CAOMZO5DM5NyGdyz4_6WF7qcsMmjAdQvfK0AKxZprUfhC=882pg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: imx: keep dma request disabled before dma
 transfer setup
To: carlos.song@nxp.com
Cc: frank.li@nxp.com, broonie@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, linux-spi@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:04=E2=80=AFAM <carlos.song@nxp.com> wrote:
>
> From: Robin Gong <yibin.gong@nxp.com>
>
> Due to a hardware limitation on SDMA event enable (ENBLn), the DMA reques=
t
> must remain disabled until the DMA transfer setup is complete.
>
> Refer SDMA 2.6.28 Channel Enable RAM (SDMAARMx_CHNENBLn) section:
>
> "
> It is thus essential for the Arm platform to program them before any DMA
> request is triggered to the SDMA, otherwise an unpredictable combination
> of channels may be started.
> "
>
> SDMA hardware configuration is postponed to transfer phase, so enabling
> the DMA request too early may cause unpredictable channel activation.
> Then keep dma request disabled before dma transfer setup.
>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Should this contain a Fixes tag?

