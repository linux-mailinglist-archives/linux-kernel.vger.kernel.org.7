Return-Path: <linux-kernel+bounces-802002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B45B44CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D3D5652DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847B223715;
	Fri,  5 Sep 2025 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htMXJrRR"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07D1FAC4B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757046364; cv=none; b=MN75hCwIDyF+rXJwtrUJt7eueCIvUhm1CxU5t68quZM42hkgqPmT6M7FcnYYDIf+rglc9LyMvpPFtV/Lt0d6Lb/D1+1FnujPtWREz3kQY1D/9e2vfF98mGZOwnx/JozIWD8slw3sy5/PVMGQ3XVoW0g8Ksak23GxasHmiCz8TAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757046364; c=relaxed/simple;
	bh=IHmo68YQ7L/duddAgclVIEvUtWdksnELEMP5v/s9PNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKRFVcp0qrdTU2Bnx7Id4b56okYgCT8goOpoS6Lu86WV6qwFbonJgzlXFTSHK17nSdZfh56xkp3qu5shA4hWhwaDBfpBIm6aYaX1wOxmJ7+SoSdnehDbdnE4PJxkg51Wjey4XY6Axdd11xcLg9E3UCT5VXcNUtiZkyHmrrGZzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=htMXJrRR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f98e7782bso2062913e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 21:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757046361; x=1757651161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHmo68YQ7L/duddAgclVIEvUtWdksnELEMP5v/s9PNQ=;
        b=htMXJrRRMGYyCmihQClevvmjDrLBJX7Z/3XgUtOCOU7dthuqse7P5iUGq8/t1mW3V8
         fcpakuzx0HKkJ30QzYlnKffMhb+SdxpVUetVkESl6QcwonkAFCf2bUV1fGGzNQiN2Pve
         2oEnzR5onaauL8sipAf9CWGwPWzL2IUhU1GmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757046361; x=1757651161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHmo68YQ7L/duddAgclVIEvUtWdksnELEMP5v/s9PNQ=;
        b=iUx+0k3aRF1J/vpbwY20JSCJMmP0pYTH+3vE4N5Lae70bHi3Vh4uOoRnebiaJ/+vX/
         oXsFdCSG3FneJlUEEAdRtpV/CPeEwHcAEmnIUd2hUPMyXemn9HYPF4UqG07j0uEUvEwH
         X4xUyOKdBamwO3YPbatXrM7r8PbwftnbHMJ1Q5AvvByMcF1EG3DzAi1GZ+M+PL9sL76q
         4xGe/jzkDnO1szG7ZPfaySsbNn8XQSqUhTLKyLrPSSoMxuv0wN5UQhr1O6HdAkVoH/bu
         t/6bWEmbONnlnIWyFgm/VrNzVC2w3SJPnQLxNEXYnCR6fR7WQx5yX+n2+oJy3Ai1Cvqf
         iF1A==
X-Forwarded-Encrypted: i=1; AJvYcCXZhhOFj7cNGyCqYQxYFxp+N6nDz0g4N0bVSSfUGmwbyYgvX7qG8D/0TG85UG/j8aUQEMAoWBkKOccJcZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3S+R5tF09IK8752mFFvYxRQwoJ1CZSh05PmeGdkOlmG24483N
	IP7QjppCG2JgUW9Hv3s1tbnZM9Zq0WC6Wa9YFsmZykYjjT7FTXEceNG0WUrV8m7py70Nb4ecRJQ
	1cAfAPRV9+dgcExr2XGFyTMG7o3ruVKRwaeJ9+3Zq0xQl2624uEsAvA==
X-Gm-Gg: ASbGnctJXQCTv2Tpse5pt2VrUvfJeATTe9hat+05HzFshY9NoA2StphimdIm9/mHHe4
	5rLnC/LnhTtUSQf8/cbSFAxJv5gjMSO/uHGkRiVjtubtmv0b0UwNcZdRaFNzJW3sFgdftIeOsG6
	XYncfOPWyGbec8eMtZjBVfUBrY/Pra5dJGoQ1azcX9sAVBSv6OX1ZTwuPFA9geas952EdwVdwnH
	h1PAEfWa8KXebS83opUZAlmqzI4pkxWRSpj+w==
X-Google-Smtp-Source: AGHT+IH5pWHA8nQf6AbDXyeEcMeTEINpq+oHNFsdmhAJKkVR1+KEZHE+PC3gHq59gfSmiiSALqCN4LCODqxkvK4xsXI=
X-Received: by 2002:a05:6512:3c93:b0:55f:552c:f731 with SMTP id
 2adb3069b0e04-56099453ef8mr666761e87.7.1757046361254; Thu, 04 Sep 2025
 21:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-8-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-8-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 12:25:50 +0800
X-Gm-Features: Ac12FXzDHpGuz6HiaGhCY4WidH-LRTm2axo9L1u6x0u8-eqIT-uiyLk75FyGJCg
Message-ID: <CAGXv+5FgKsg0sM6EXeTL=du2BY1xgH6jVmtQtb2M0kY3iix-tA@mail.gmail.com>
Subject: Re: [PATCH v5 07/27] clk: mediatek: clk-gate: Add ops for gates with
 HW voter
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> MT8196 use a HW voter for gate enable/disable control. Voting is
> performed using set/clr regs, with a status bit used to verify the vote
> state. Add new set of gate clock operations with support for voting via
> set/clr regs.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

