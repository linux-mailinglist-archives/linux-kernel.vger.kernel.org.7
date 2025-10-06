Return-Path: <linux-kernel+bounces-843437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E48DBBF2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A4E3B113A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E314725A33A;
	Mon,  6 Oct 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDYgQ8MR"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00D3227EA7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782031; cv=none; b=OS1Dj4ZoAylTw1xXIQcvwBSBZGemIpQTzL156j9Mm9jjyrOwF+8FokLkP0vDkOvwXMHH2jrAZz+Pb+LANQADcz4XSIfWZjUCvNXF7/mpUUacpF1+hjx20ekHnGTmo4jfIaQ1kI9wrgB0CYLXs87tgj0BDvqXY0e/26YF63gc2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782031; c=relaxed/simple;
	bh=waJ+EtoVbt8cHBF6XzkKAOAkmHbwYz0y9N3nZLWS7u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfAN4rKYvTP3QZbLMx0OXuKzwavrvi5HSFipcNaz3rg4wB60ryyoL/6EQ2EgvWmLhchYfu5HraIBSDL+0pDVeOlSP/ZrBWe0ISEzl3+fpAIjQQ0BcbZAY0GiBUPFQhQNTrvo3fVzdORk79+Id7jtWxSRPD3Un6DSSyZHilnaXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDYgQ8MR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57b35e176dbso7039767e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759782028; x=1760386828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waJ+EtoVbt8cHBF6XzkKAOAkmHbwYz0y9N3nZLWS7u8=;
        b=jDYgQ8MRb1IzRuyv5LHs5GqM5FY7yTaHwmH9KhxJuFwp3kVCaKJG7VOX/tkBKiPdsj
         Y+SNHf2cp80qDjKpQ/5iESO6itOcB0Lg3WVgFU0zkHfKY8QVHURcEbLc6CI3uxGVGjYi
         qSTmuCGdyXL6I8feAskIhJhOSxniNAj8LBPTPu2j+J5KfvdzArd4PSGXr56pY+kZai31
         o8T+TwoHmft0DQ8Ak4uu1usl1Vdwopyj3juv/LPjzP2fBfWY8g+KsYWGZbvnLJpZs85/
         GoUbT/8J2dCHfh+Nto/ObW/oO/ImsBSLz2N3Hv9r+0VpaWNEiJJd6OF0cG47bBj0bJA2
         WB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759782028; x=1760386828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waJ+EtoVbt8cHBF6XzkKAOAkmHbwYz0y9N3nZLWS7u8=;
        b=hbNGg0JXsuH0rcIjVBEetmpwARL74ZlGTz/QieZktwYSvkXi/xQGfH6kX7ZCNDfzC4
         5+veQCE/+z7g59rUFgaE/MfUcKCT89oryxYHxMPpZAYO+e/fOQYknWGKS1HfFDtTDLpq
         WpcIkhYaWYubwoLmS0RabMeXPDKVGoKxk5D3dMJVH3LljMwcqZmf9gAUCXYyF2LKRd3f
         MRYzjve4oR2NPNsdqlrHltqu6L9T9KSLT0scPSaleDgBnCZmtZo2qghMdj+ApXg+TqFS
         +vMksSmdYQsvYJBLaOV38s6gtB7JRx7m3LdQ362pvebeBYG3NYIUm3QgAQyKBw8L9qg/
         DqiA==
X-Gm-Message-State: AOJu0Yxc58BlxZvTdbBR3sUgxQA6XroNKOe425KUtywU2VQmHCggA+Kt
	Xl9+xFuykh7RguxO9XJ42/2CLJ3c0BOotNJ4yoKjogbwZi3OPinpE2R53ZxujfTeJ05uFxIwW9R
	bNJEEhqCPXvZkoGTVLmtBUVH/FJt92To=
X-Gm-Gg: ASbGncsqKY55IqtJv+VA2rF99CNpnGznmyb4QzhM4FkYfKvFZjtSue3FqVuyzO25p8a
	Wqh+oY34CckwFpdrlZxBH0c8U971BN6/FbJChoZsCIqhPvX396a/t1t8Inpqn9lstR2DFKhm0hA
	2IlT0TAyBQQwTaq59vFwmENeNcSvmwuFOGeUXkZnmzrEBpeYhlx7/VqhPF8gZ2yV2rFP6QGwc5E
	tagJXGEuTpgvmK51I1qowjMp5nboHeW2eY8GNW/dXUp1VBRVpEHU1IAIlcHPZU=
X-Google-Smtp-Source: AGHT+IHnd3YhCFuN7botyJFWdxxq9Z6XV4clt26xvTOPjjkip+ArH3kt6LfKx5P2Aigke/aWDuktuLfD9jlfAgSMtME=
X-Received: by 2002:a05:6512:1326:b0:576:fbdc:e3de with SMTP id
 2adb3069b0e04-58cb956997dmr3918445e87.11.1759782027443; Mon, 06 Oct 2025
 13:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com> <87o6qjaiz7.fsf@osv.gnss.ru>
In-Reply-To: <87o6qjaiz7.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 6 Oct 2025 17:20:16 -0300
X-Gm-Features: AS18NWAzzK_qXM1IP78cLrCPYQAYSFfZ6oionausHKoRzSZwMCvAUFl5BuMtivE
Message-ID: <CAOMZO5BwoAzf36-L0uCTdKriGaUHg1MqZoKg56Fvob6S4coMBQ@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>, Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Mon, Oct 6, 2025 at 5:11=E2=80=AFPM Sergey Organov <sorganov@gmail.com> =
wrote:

> I've checked that I end-up with the same DTB as you sent me off-list for
> this configuration, so at least this part seems to work fine on my side.
>
> I also tried the imx_v6_v7_defconfig - based kernel on my board
> (obviously with my custom DTB), and the kernel still doesn't boot.
>
> Further, I've found that it's enough to disable CONFIG_REGULATOR_ANATOP
> in my custom kernel config to get kernel to see eMMC card, and then
> mount it as root file-system.
>
> I still fail to see what I do (or don't do) in my DTS (or kernel config)
> to confuse the kernel, and how to figure that out. Any ideas?

Please share your dts so we can take a look.

