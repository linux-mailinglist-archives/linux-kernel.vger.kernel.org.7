Return-Path: <linux-kernel+bounces-886167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B742C34E64
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 711904FBA8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FDA3016E8;
	Wed,  5 Nov 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5xyrd2t"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11741760
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335234; cv=none; b=VWKut+9RdhV4FjPn/cl/zn4+BDUBD9ent3PHqaqJy445Kk/bfNWBW8+VGtYBw1Yz3iGw9Ua5COY2EuYrYWhBHwamHhNlyIk3dc5KkXDVM9ZAQgo+I8J2lbyt6K+nR9ox/SmsbZX5oQPGJc+1ODTzO2zMnDQ39Gld5wVSllxs4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335234; c=relaxed/simple;
	bh=xVz41K+WHW2r1NR5xRjnxTEmTL3ZEN3/EUCpmw5NHe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFdOnWn6vKKqGhHP4L/PjOxjyv2Yowgg3L6ifz3zNxnLcjnGi8dmLNtDbVLUxITd1+oYYOUYcYt2anDS9K2hyFRSCH2458MuJl+YSwdLrL8nuPYDzjgsCgaX8stZuVQcuK85opA9p0msm6SUZLS2QLoUWTg93zY36Vfuf1v38us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5xyrd2t; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so5907596a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762335232; x=1762940032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVz41K+WHW2r1NR5xRjnxTEmTL3ZEN3/EUCpmw5NHe8=;
        b=D5xyrd2tWg/Oh5hwcEHSeLOjURl5et+LBeg7W+NnAvM06/fVKs/aXlU5p3JmAT3maF
         rIR9DxyQFDcC06WG/+L8tbwWOObZKP2d9eZ45/UgUiv3rOOx0z94ltOaahtRhLLSaTVO
         tMUSf9ZQU4Yp3B8/4EQPq1siLJMAX3ogfnUsoWh0/BywrDaW8St8CAnJhrJ/k10KT8TP
         114g+MPMKjdUa5+dH3VTWB1OLD2qp+eOPkzLNaqVjKdcuHXSGReDRamvn21fD1nM7xz5
         fnp+qvDqnvtOAQUj3lehIngY6mIUnLTGsmQK4x1UDaNcY62fnIu/2K4R6zwTB7ykuuw1
         7M2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762335232; x=1762940032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVz41K+WHW2r1NR5xRjnxTEmTL3ZEN3/EUCpmw5NHe8=;
        b=fHtUwozbHqNSgX0GvpUvs4jq9TnB1Fn6R2Cg6+o8E0iluW0oOsb3voQk0c7xaN3AJM
         V9eEHrcURsN3I93/XvHc4yQXre2QoSLqNimv+PgUWS975EA2/7qE6waxcEvloy7HKcN1
         FIOj6yTr3RkX5hzo6U9vxABYz7NsLaYcSK4MJs/vonmPGlmDkvylwv/qWRILw220XVEM
         SK2bUxOm3yPiIzvG3XPVunz7E8tIZDdr5u/t1T70vV4H8NNFPhyzg8fKpkQzSdDk72gz
         Qp37fwODRisS6yZkteUlwwdPfXM0hece7lzqSxHzsNLEhPxh99IbbvTdfePOPWkORLRg
         UeQw==
X-Forwarded-Encrypted: i=1; AJvYcCWkZhwxlmfITh0xw8GFsBHQRdX02StBMw/Vgt0qlHRyM86bmF09DxOzXbqLlSVpMArdHXTKRpp0xcbYtko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/+WHlOajbl776fRNVPhwkUYnYyvLBBH3LY/1Aese4uWBT3uu
	HLF54oQDEwxG2QQmwMqPHiLzz7ftiRkhDDpvayvE+7a3J1KusLYYusJ1hWPIPTXUhWysVMDCBlt
	6WqNMjVdlKlFnlqH3CmxXw+vEOhGJJoA=
X-Gm-Gg: ASbGncuZj7kd9yX82F+tlhKGI1RSl33zEmq4gBi3WXEDY8dRXZTMF9Xg0NpV+glIzz3
	cO6AT2udU9GmCkDPcqj4fAfxRvCTDD1z3htsRl8Pl4DHaIZ31MxSXbpJ3AY6A2Fz0CaHV4c0WY4
	Wz8nM6uxivR8l7w3sbm4q4FNKWZpTb5gK39VLp6j7aQ07E2qCE6NF6rJ5YdViXbkKQv5IvwqjzA
	2VssH9n8pDwfc29zYFYlBYWp2MLp2tYlOzaJB7dtifnx8htPyuMFNgB4w==
X-Google-Smtp-Source: AGHT+IFGxIq2XgduSb+stuaocak2phBxCIezkzwd+AAubIHJ9Z+vhmNDyViyBoMY0DIaLUkKe02kAuU0EhMWtzwP5ig=
X-Received: by 2002:a05:6a20:6a04:b0:350:5b75:6959 with SMTP id
 adf61e73a8af0-3505b756d29mr452994637.32.1762335231830; Wed, 05 Nov 2025
 01:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com> <20251104120301.913-4-laurentiumihalcea111@gmail.com>
In-Reply-To: <20251104120301.913-4-laurentiumihalcea111@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 5 Nov 2025 11:36:19 +0200
X-Gm-Features: AWmQ_bnL9LXcRTfkqLXg0rjUqS39MT0GLWaNx8agMRC1jfxbVmtMKne3NHlmeiE
Message-ID: <CAEnQRZBENqUOTbdubTsNsivGtfKOqFqqTadr-jKkMGEwBvvnAQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] clk: imx: add driver for imx8ulp's sim lpav
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 2:05=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> The i.MX8ULP System Integration Module (SIM) LPAV module is a block
> control module found inside the LPAV subsystem, which offers some clock
> gating options and reset line assertion/de-assertion capabilities.
>
> Therefore, the clock gate management is supported by registering the
> module's driver as a clock provider, while the reset capabilities are
> managed via the auxiliary device API to allow the DT node to act as a
> reset and clock provider.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

