Return-Path: <linux-kernel+bounces-831580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F4EB9D0FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6AD189C65C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF052DECBA;
	Thu, 25 Sep 2025 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF1vzTsX"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3C2DEA94
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758765025; cv=none; b=uZbj4EBXT4iSJgTHDLysP8PBaLjeS/QdCu5UGLHeaIcXLsFrgFwKNQYl7of31ucgpvoZc2WfqKo3zI+LEmHzipoXI6ucIR9gTJ4kMZd8oqUnNkamGAqYRibjDmmtzYhDO07Ql9G93MPyepvIm/adG+yNzWxrij3WMJfjtQAv9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758765025; c=relaxed/simple;
	bh=owaS0D9XXND9vT6YXj68RtHr8CmLFuARl6LEZicjSX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVPeGQQbchm4EdhiYO+8ctlyIQhixgmu7zvpw8Np/QXKFPdnbDfweDbbO22mHXKTiMMAVhEAswhxn1LG9s+WeaOnqbkc+qzrQ3gOrgwy8mkBHdaV63AQ+/r8unrtgVzlGOzM3+eLDLLciS/O3l2RSdPwIGZylqHTJ85Uurl3Wo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF1vzTsX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b57bf560703so354199a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758765022; x=1759369822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hEJQvsmE/hbyjQkBzjPY8kB2xy+I438NQVnzcmtq/VU=;
        b=PF1vzTsX8updoHYLQrXbk5Ft6ipQyWyO/FIzAqDmLxcsMgKSFQhZ/XeEeHa6ljh4D/
         WJy42vSJq43fdBkXmU9sY76G/cLJ/rLU7RzO2Ju3JRhE/R0EvDyIB49b7ijLq2X+xQfL
         yGvWPfNdzQh0EtFc2dzDfzVNuM8CLq2bIBVO/HgnTxjQDNgUOdjF8x5gFjPsDmNAuWcE
         GSQNb61tNviARIUktUkbnvzQOifAkXGHbpzjuO9j5B/sMYB1ADnAtOdt1qwJLDUqVwZi
         IFdLEHTtCftN0xt4G/OyqsyhmdxiORCr2nSRINt9C3LFV5sGab4XfFgYrhoOAaUuU7Ur
         oMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758765023; x=1759369823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEJQvsmE/hbyjQkBzjPY8kB2xy+I438NQVnzcmtq/VU=;
        b=T1VOrtFw7r0UYG9AeFBloGbWSlfBTaoUygU/JAUt9AwEyG2S+tHVibOkt4wghEgnx3
         2SjK55w0qJV9jie+ZsnrERkLNM4nlm5dvywZQSVIUiSneUQ2ZbxOf5xfELfuZs4LdiWr
         8TMPRVP3mkiJMnISsMUjNe51YDguweIW0hacVTEqIHDr7rZYhua2MzBL+QJuUi5SwQyr
         a2h/hC25V9PuKiW3+awdAm9XRIDRwUrO3lKAPHSEZCIuLkku2ft0NoN29JdMiBvJWkrc
         Ecwcz20/JANxX0Cd9l5vq9k166WUoYl/sZsC8nVjHX5JPX4WGgDKcnnIHMBEftsr+Fsq
         IEcw==
X-Forwarded-Encrypted: i=1; AJvYcCVSs0eRCjtG1lPJdYtQtCBfG5X72fXHC7txIWaechi++iMH+CfFXMffVIc2ZspO1bMsiggWU6f24ZZ0dkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6O2FBaTPKdPWXaah4CfxvVMaApNm5GUYyEvSaey3lQaBGLKl
	Jidbhb7cv0OhEFoXmV7+Vu3WsozKSx2OsaCJmW6pB27N8Iol7p2/sIkw2k6RiGOBbVhpsvr3All
	RxaA5MnZHWFL5ucI373fX5uTX4MbXNK0=
X-Gm-Gg: ASbGncsTYHiw5EuyhuSQGzCj7OsDlt7sCJZFZxpp+xcNvh96XP2xcXM3mGp72FM6QyM
	fZadwzgi2qoSXtNBsH4ye8I/7G3AGQuEKnyvKGX42yEUQTvgI5n1dCsNioRuxZvKuXTkAvB7HAw
	n1s5lKLV5iAdF1VtJeYXSeINgH0BW1RArom9xVMmgLiH6dKKENtHKY7IO3LJr/Fm/m63skv4k6C
	KQNWPRyObHmbSCy6eYvbzc0wGxQfL1clfIA
X-Google-Smtp-Source: AGHT+IEl7et+7OeLoEdoDmvJumc2FzyDuQRGyuOq4dHhRQ/gB+e14fRVVIkDC+7iwxulpgcerYiG0oyjO04opcvWDZU=
X-Received: by 2002:a17:902:ef0b:b0:248:7018:c739 with SMTP id
 d9443c01a7336-27ed4aab56fmr16467205ad.28.1758765022657; Wed, 24 Sep 2025
 18:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com> <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com>
From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Date: Thu, 25 Sep 2025 10:50:10 +0900
X-Gm-Features: AS18NWDVnkrvIrL2FuXY2FROte4PMl-E9EOOPzKJH_8e7zTtzCUsO-xFczLqIAs
Message-ID: <CAJKOXPcbJY4JEjfZLvOAXEWCTYFpe7En+Riis2t3K5fWJgNU5A@mail.gmail.com>
Subject: Re: [PATCH 06/20] arm64: dts: qcom: kaanapali: Add USB support for
 Kaanapali SoC
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, 
	yijie.yang@oss.qualcomm.com, Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 09:17, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>
> From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
>
> Add the base USB devicetree definitions for Kaanapali platform. The overall
> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
> (rev. v8) and M31 eUSB2 PHY.
>
> Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 155 ++++++++++++++++++++++++++++++++
>  1 file changed, 155 insertions(+)
>


Second try, without HTML:

I really don't understand why you created such huge patchset. Year
ago, two years ago, we were discussing it already and explained that's
just inflating the patchset without reason.

New Soc is one logical change. Maybe two. Not 18!

Not one patch per node or feature.

This hides big picture, makes difficult to review everything,
difficult to test. Your patch count for LWN stats doesn't matter to
us.

NAK and I'm really disappointed I have to repeat the same review .

