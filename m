Return-Path: <linux-kernel+bounces-823234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7223B85D32
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2837B7328
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE75313D4B;
	Thu, 18 Sep 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="NB543TVh"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5912F83B4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211043; cv=none; b=Pt8G9ZVdPpBh6Vs8xgF3s7QA9ERHzJTb7uOeMmr5/jc4SE0zUjb2xNYmXijXaPQDIZPcLjztp+yD0kA57nAu0ygLV/AwDpyg+NteYxHs2UqEL7B26xqhjoOnTDFR57yl7VaObWg6kTQtV38lXN0yIwv7JG7+JFw078N5E+2ARx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211043; c=relaxed/simple;
	bh=zA6/OnTfTyUR4ReMbBgbAS7Aeu9Shy3hTUxFOIVTxpw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyS/BJa+poDs8nvqXEVeUofJHZG6j/Nz2ZdwRiB7UWLDTzmg4INYlRM2BcnvQXwp+XcIMvia7idA0gaKc0vABOyzm1ILDdVeTuAH+rHo4JbTA5amAUdUf9yPqkl8xkup6KSRwfSax6yQaCJGnC6J2NORs8Ywq85t1EOtq2mQHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=NB543TVh; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758211040; x=1758470240;
	bh=zA6/OnTfTyUR4ReMbBgbAS7Aeu9Shy3hTUxFOIVTxpw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NB543TVhzB6EFCSkGtashONtbosi4Z00OvwULl8ovAseHr7H4D/WMtCVeEHVwK7qR
	 wCA4OaOdaKObASbqnNxK3rq2VNAJWsQBuorAn65LXrJJQ5Nk4xYonqrMloxfwuPkCG
	 07Pv3srXl8B4YdRqAYtVicr/R9CkqPOgSpLsB+8+7UqKT5x+PTVslh9BgDbAhZyAit
	 a9tfkQkBPK/bHtOsmgwEDVHxpjP4bPbIhynAi5hJ2wsumna23s6fL39kgllEVo/XXU
	 giPN2g8OVIQLf0a27rfkp5DuNwsKJ9F8AxWCnW/ozbd42tSBvg2IpwpThmo65YYR3Z
	 MhjL7fmECQHGQ==
Date: Thu, 18 Sep 2025 15:57:15 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: ManeraKai <manerakai@protonmail.com>
Cc: "aliceryhl@google.com" <aliceryhl@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: miscdevice: Implemented `read` and `write`
Message-ID: <5cf242fd-ded4-4aea-a5b7-9c856f75fdb6@protonmail.com>
In-Reply-To: <2025091841-remindful-manned-a57f@gregkh>
References: <20250918144356.28585-1-manerakai@protonmail.com> <20250918144356.28585-3-manerakai@protonmail.com> <2025091820-canine-tanning-3def@gregkh> <2025091841-remindful-manned-a57f@gregkh>
Feedback-ID: 38045798:user:proton
X-Pm-Message-ID: df1acba63728c7bb4ec2049c7df8555582ead7d6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

 > What type of real misc driver do you want to write in rust that you
 > need a read/write callback and not just an ioctl one?

I don't have one in mind. I was reading your book and experimenting with=20
char drivers. However, I found out that you prefer new developers to use=20
misc instead:
https://lore.kernel.org/rust-for-linux/2024101256-amplifier-joylessly-6ca9@=
gregkh/

So, I wanted to safe-wrap misc for new Rust developers (me included).=20
And go from there to write real drivers.


