Return-Path: <linux-kernel+bounces-812139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71711B53388
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D264918981E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B91A320CD9;
	Thu, 11 Sep 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="igDt690k"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D36311594
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596828; cv=none; b=n2+FaFaFC4WfIwB3r4Gez7NgS00YTyQDZ8LadoHId7bH4HWd5SvbicaQy7rw9dA0a7vTfWRLRdLED8GrSpF4nXDqNA6vRe04f+KIQ5PuQx85oINvbWieWCJ8Pg/F6grnJ636Hv8ZseRXm9eqirpBozHJ59/wAdZkDe11uRuGeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596828; c=relaxed/simple;
	bh=O5VXtAOP/OmIhTsuzJDvPX+XiTm+lHL4PKa8YEVkr/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cy1AsPAT+Dl0xpnln81dFykdhhdD79cAC+57F8kIgT8e413zwI9ORUr+A4dxeorVR2g2CCSvk0TqeD8mrGLQGQ3cdHbDzuSGEkMYm3DHQcs6+yluHbgw1TOwmuTGbxvp07hc5wDgP+JVM8uvfVFhf0ZWBMdzn/M+nBDnx5uNmxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=igDt690k; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32dd4fa054bso606179a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1757596826; x=1758201626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O5VXtAOP/OmIhTsuzJDvPX+XiTm+lHL4PKa8YEVkr/s=;
        b=igDt690kF/o23uuWt9s3pSRwfzAOMeyiG2Dt9dDkmYpEFPS2hKWEK/6mDs8tYnG9Ii
         3SvTnc8Wem4NflwGycWNz96PqdS4ePjQy7qQLNf0hDQt6nAhsNYT0fY62tbDoiPYb8Rq
         WCPE6BGs8ldNs3Ad+U8qkdF4PBKJbnwRBgPgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596826; x=1758201626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5VXtAOP/OmIhTsuzJDvPX+XiTm+lHL4PKa8YEVkr/s=;
        b=MaPLkACYXbipMZyZjf3/BobW21zSdvlZlHuQqCvc2sKemJmrlnpsOvcY7M9DP0EYP8
         nd0gCLw+eBM68vbNOHHMiC486FN0zlasQ4jXPE2HFV7lx+WWC82Txgwxv+IbAe1ZvR++
         uMP47lDoJzfEErqTdyUrVBp7uPuDLypqUQ400nVWycRhJvoHFZC9P8vkDaaP0E1EPHo8
         DLdt6Y021lreXQoMGNESlOWi9lV6b+At53R47Njsc9Jw+ZeJy3bXz8gwgFwSLr5aE+jJ
         vXt7ecOGKl8YyR3/9A7H9XF0XSkbssVr8T8jxZd5Lpx29VIVaHpEl2euYQ6dnCnYdJMO
         W4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUmIJb25H++a+nxSinqPNXtryG/Z9EwRbyCTQyXoosIztECFaCoGGrxSGIpNxvqzh7bKA/gB04cPBoOib4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQfd9pnTkMnAlTEJx/nu40xWXZVXfCxEuwcYyqGaKFGTdId8+
	rXs+4RaEkJvnPOVjXOWm80w5EL9fkrSDq63nxnyeEQpYjeuDHzVEvoScE0ReZXNF6uZArHkmdEP
	1RC6jIaq5TNshNgEMVL2M8Q5HR//NxWKvgHBo71Frjw==
X-Gm-Gg: ASbGnctbSQkwbR9ECmuz0yuYXlNabSLfFmXqdQQuUb7oiYvxIzuEFSg+a8QOBM+RT/c
	fehZST42IqCyy6nuRmfJFe2p3hFn6zUP6vAogVVxjLF5FxuIZ4bCB3mkw/6ZfEZjjjLHcv/OeKT
	9/DnpL+bieScnM4fIFbQDX2yASd9R/cDfb8qW5Mn9pT8ihsc3uYhow42zc8XMHAHGRuHdEuZh43
	vFW1tyBUVuT9v/INUZn
X-Google-Smtp-Source: AGHT+IHd5xyJNz01wwrpJhDl98T45ztJd8ELgxgaEy7iQhcAjFMhM3czPP8zaiJ5J9c40XxE1kOBKaWdJoKiiAcymxU=
X-Received: by 2002:a17:90b:2e51:b0:32d:a37c:4e31 with SMTP id
 98e67ed59e1d1-32dd1ee82fbmr3766136a91.17.1757596826023; Thu, 11 Sep 2025
 06:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907064349.3427600-1-daniel@thingy.jp> <20250909181322.04dc2fed@kernel.org>
In-Reply-To: <20250909181322.04dc2fed@kernel.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Thu, 11 Sep 2025 22:20:11 +0900
X-Gm-Features: Ac12FXxQ70xmDrhK5rD-Edf9LkLgt_jI1IVW96Rk2Cd3DVeZZ2SdNbJQT5z7MVc
Message-ID: <CAFr9PXkYyyCQqHt_-75GM_uup3bSvxDgjDc0-O0t=j3UY_JN6g@mail.gmail.com>
Subject: Re: [PATCH] eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 10 Sept 2025 at 10:13, Jakub Kicinski <kuba@kernel.org> wrote:
> Any idea if this is a regression, or the driver would have never worked
> on your platform / config?

I don't think this is a regression. I think the PIO mode would have
never worked.
Without that option the driver probes correctly.

