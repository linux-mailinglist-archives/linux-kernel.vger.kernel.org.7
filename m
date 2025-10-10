Return-Path: <linux-kernel+bounces-847768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 733C4BCBA47
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10299353BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CEA1F4C96;
	Fri, 10 Oct 2025 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFy3OkaD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C41036B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760070573; cv=none; b=UlbVwz1NaVohVqL2PAkB01tZZy2HjaAa7kWbiGUwdTAHBH+YcR1TjPm4XQ8SXfFu86+Q90s/PSBmJmelojHkbW/bvchZRFMpRvuewuVbJokxkY4mUxFzfww3P++tKgJ8juRFACvbi51OHwDSbLAmVZ5v14IF8Pkgl20xzSAV7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760070573; c=relaxed/simple;
	bh=xs+V22aaSxwBl1Gu7cjT/YDEQtN0yA74iezrgRksE30=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l5Elk8tQYhgpoCJLSt5OtmXl3mR563Haf1gazXBnlZzuWEZ7RYm/a+oQplW8zAQO14sKWbeRwlg9H4W3BvpHqhODBXk0U5OA0T7kCEn0wg/I6vlBEo3Wc/KhBU27z2H/96JvtsNchk0XnvaZ4fzi42nyQnxfOVLhlJg+pJV1KSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFy3OkaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C23C4CEF1;
	Fri, 10 Oct 2025 04:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760070572;
	bh=xs+V22aaSxwBl1Gu7cjT/YDEQtN0yA74iezrgRksE30=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gFy3OkaDZutiIoe1wLgghY2Ep/u+17daSkEK7ut7IZIaPHBTCDnYlWeoahUVNN/pa
	 KhGaumlpDNrS0U8eYxgUL60Pa7wH7DXV8EiNTr97qJSpPs6O+bLX4PmMqTtAmV40nK
	 bj8/W3E+L0WyuS4uy663GAqaBdZtd7eaCvUb0OkhGGBo+NYJAbTqDIbtd4dsoRdKU3
	 rBI9KM2YEUspKqkxlAzOE1/EmV6A7LcOZrmybzEhcQXx95oQwc4Sjkog3zG1rfx0tv
	 h1aQBdTGXDHzbd2/Ey0Eed6tSuYBEFDti1YZnh4ro2QD1GisJM6evA0scuLXn22VsI
	 U/BABgIDUr3/A==
Date: Thu, 9 Oct 2025 22:29:27 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
cc: =?ISO-8859-15?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    Himanshu Chauhan <hchauhan@ventanamicro.com>, 
    Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>, 
    Atish Patra <atishp@atishpatra.org>, 
    =?ISO-8859-15?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>, 
    Yunhui Cui <cuiyunhui@bytedance.com>
Subject: Re: [PATCH v7 0/5] riscv: add support for SBI Supervisor Software
 Events
In-Reply-To: <86817f9a-c601-81e8-b95b-0f2396275f95@kernel.org>
Message-ID: <57486d42-f736-5e2c-552c-fa7f2c273179@kernel.org>
References: <20250908181717.1997461-1-cleger@rivosinc.com> <86817f9a-c601-81e8-b95b-0f2396275f95@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 Oct 2025, Paul Walmsley wrote:

> I updated these to apply on Linus' current master, commit 5472d60c129f, 
> cleaned up the checkpatch.pl --strict issues, applied Anup's pr_info() 
> suggestion, and pushed them up here to make it convenient for folks to 
> integrate and test:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pjw/riscv.git/?h=riscv-experimental-for-v6.18

Sorry, wrong link - here's the correct one:

   https://git.kernel.org/pub/scm/linux/kernel/git/pjw/riscv.git/log/?h=experimental/sse-v7


- Paul

