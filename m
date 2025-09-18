Return-Path: <linux-kernel+bounces-822640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F387B845FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F421BC387E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC13043DA;
	Thu, 18 Sep 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxRZA+7C"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4F303A06
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195356; cv=none; b=nYioEe5oKrUxSCYcIuGa6wjGnJIA7OMILuJH0JNk+r+V88j+mCMDsOCb1XHOgGHAjyXTOLxKaf/1ZpmIdePur/LeA3+x9eZd3IteeHWnE4eE0fDvd2K3HLlxS7x+Ej1HxKIQsMbGLJhAnbtt6DNcXV0f5+YT1WbfsyLhBSkwVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195356; c=relaxed/simple;
	bh=CH1PrPamLBcIL2akQUYxoj1jI5NyoHazD5PXsVbHZK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCVj95CEr2mWSwwmjEElEfLsmrS7xNh6ZGw7zwC3n0IJ4Bjkiebsj8GWGkLmqcpENeHpTEEsute17sDey70O5lO4dcAryocPgq08rIoh6xLlhs64Kxts9RzzChTFnO5lsSD+z6/utbZyxhRNjT2vaF6Gx/he65ouUgla0vOiEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxRZA+7C; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5500891f00so443364a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758195354; x=1758800154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH1PrPamLBcIL2akQUYxoj1jI5NyoHazD5PXsVbHZK0=;
        b=HxRZA+7C8cTiMcln5T+H8C+z3F8oif7sV4JrK+7+bTCTPUohOltquEACiw29uq2lFg
         GwnIxeL5YOAlzqmJY7pXQh9sS8U4HkCXW6HYyqvPRC2fuj1nvBU22v3UrPw/M8hUnPmT
         O2H8sz6jdoM7jJJUOW6dd7vp5D6GqfnrxBKLYGREu4XBK8Yi5j3MAZdNPvzqzM9znZvP
         lyxgMV3uRZt7JgHkKZguEcjWIY5zKkdKH35Yk2cR34VztBJlGvduTV1l7DedbOSlRuw4
         c3+c8HQHB0nED8l7X98KKa8xsNVwgrK5vgmg1kj3qCCoH8Wim1WJk3kVYLJPUSqkbpBw
         j5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195354; x=1758800154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH1PrPamLBcIL2akQUYxoj1jI5NyoHazD5PXsVbHZK0=;
        b=iCYeEENJrdHB/5pv6Js2mGQzumuOuiP8d4sRbsywmy3W42bLRJuOEc03rdJ8F4v1QT
         2rEpKLV7YJhf4krmuNJUADqK3LcrWPdY45IWMHnrK2V+rOq1J03YFYrgWTzkgpUsrC3l
         EdKkY+rnaHSo7pdN731yZjQDnK6wGiQQiU2ftBsfwLCI9+aIGA5Pli+oc9SeY6UjIIqA
         4uScv2R+zmYvF9suGXh1taWQ30RBG2iKN7+PmR4sRUdt+o3LhQxkXCshb9Ghdg46nKh4
         lNVDL706+0qRUCL+f4WIAIsR5/Glctj4o6Dj+OdA/BCL36NSFfVcHiRcfnZK89lLKB5U
         wi0g==
X-Forwarded-Encrypted: i=1; AJvYcCUzRM47SxuyRhPsIwrXCv2uUobZ7/HycwipB/XhLqvAblUzrCq7GTYd+853aPvyiAn1tki3Hais7f1LPwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vAnM9nADOiwYlF4O2CI/LuTJdpVovbwi0eKnG9ummImMJ//N
	SBkKJhmDmxLtWvIaJTWla+xXBMi8+GYMZ9yCxJELeGnWYbFyjngPKsqNpYHAt6W5Oe05BBSigvi
	86CgVF0W6HTRZcloj1yCHV4PbBMy4r2M=
X-Gm-Gg: ASbGncuLnIae6yf2+LAR86tv1Xl4q2AWggp1C1gxHF5ajqbhKKYPP2KeEXhaThY5Mks
	EVjnUDsOGQ4nR1/vwD606Jh+gJxs6TB3zf2fSgYfQSckmxmGxKSXWe6vdFI5X+AIgKaBR57APz+
	1U03dOkpyY+FtUs9qhCwJRu4wfaNftnFHa/n8EJwYaX9VqxvX3QdyaDtZLQJ1y0UqveLwPm30QK
	jxtfbdcXOyJtPAl4fo8+WYjWtQIIB4QM2YvIEoQyhSQkpBrOrfu79E=
X-Google-Smtp-Source: AGHT+IGj6a4sc19wyzd63Dixg/UySiquRPpGXq2m5G0nsVQ6YbTUTB+pMgEHhGrVA5tqjbsOrjjh+YB6F+lqKoiYvWE=
X-Received: by 2002:a17:903:1b25:b0:266:d648:bf53 with SMTP id
 d9443c01a7336-268119b832bmr72456925ad.7.1758195354344; Thu, 18 Sep 2025
 04:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918014053.696710-1-rpimentel.silva@gmail.com> <20250918014053.696710-2-rpimentel.silva@gmail.com>
In-Reply-To: <20250918014053.696710-2-rpimentel.silva@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 18 Sep 2025 14:38:12 +0300
X-Gm-Features: AS18NWCUGtPgOgXzmXtowvoHWKNQHRraFSnJDD8RcxIe00cDqMMkAGlPM7jIMlk
Message-ID: <CAEnQRZBb+FOah-owK2u4CM_ngLm675_tbrn5tdyUTnTSu-Mmbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
To: Rogerio Pimentel <rpimentel.silva@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, alexander.stein@ew.tq-group.com, 
	dario.binacchi@amarulasolutions.com, marex@denx.de, 
	Markus.Niebel@tq-group.com, y.moog@phytec.de, joao.goncalves@toradex.com, 
	frieder.schrempf@kontron.de, josua@solid-run.com, 
	francesco.dolcini@toradex.com, primoz.fiser@norik.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aisheng Dong <aisheng.dong@nxp.com>, xiaofeng.wei@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 4:44=E2=80=AFAM Rogerio Pimentel
<rpimentel.silva@gmail.com> wrote:
>
> The FRDM-i.MX8MP is an NXP development platform based on the i.MX8M Plus
> SoC, featuring a quad Cortex-A53, Cortex-M7 co-processor, 4GB LPDDR4,
> 32GB eMMC, Wi-Fi 6/Bluetooth 5.4/802.15.4 tri-radio, Ethernet, HDMI/MIPI
> display interfaces, camera connectors, and standard expansion headers.
>
> Based on the device tree found in the NXP repository at github
> https://github.com/nxp-imx-support/meta-imx-frdm and on imx8mp-evk
> board kernel mainline device tree.

Hi Rogerio,

Please keep the original Signed-off-by from NXP (DCO [1]) and also please k=
eep
the Copyright line from NXP.

Also, adding Xiaofeng for comments.

