Return-Path: <linux-kernel+bounces-786903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26389B36D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1658E7A725A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A91D88AC;
	Tue, 26 Aug 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cofJ7qSF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2A21B918;
	Tue, 26 Aug 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221757; cv=none; b=tHxeB/z33+BMU1fA5ZheZ29hzpyhQJSzQ04ylqQutjQTvlVJ6Lbn9rvIjl5FcQ0I0TtyfRNqkYYqumIGFw2M5L13+YiTVMSbg3Yo6IPzzB45u/sJZTLs6VFFVpj512OVqFLL65w6kRRS5hLgjlRgaFl52UZnqKCfxfaI1mqprO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221757; c=relaxed/simple;
	bh=Lytl4XuFT194+8jsAWdZGFdZmuFAhDybhprK50jJGVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f0IVqF2JkoDJV4KVbJXXgvpmHul4PA6kN7FlPsGu+LTwrzIwFl2gwuk3fPtV0wdqi+expM0TInxwElonqU14iEeg7nGpgwfqvT5wiNz+1K5IRdI3ImiyH5DBZ4l1XPIIMn5g5Uf2j5BTcEv4VUfpFJIlnM1xjnf1RgGfsN+fx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cofJ7qSF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D60640ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756221754; bh=NEcOL2ZJTiWpmrZemxTxzRc/PbK2GR5KXlpW5YiSoNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cofJ7qSFTE51d0F0Mp0bc70XKf+BtNzC9UO5O28FBMtO1uNUIt7mkKO6gT1Nzi8gI
	 OZU7Qf4h+gbObX38RdjqiD9IIWuHsZi1BevHnd0fq9fxvqo1GhTGxfWrFXGcnQGNfq
	 I96rfIfRDmgjpTXLJ4KTvTLJseOSJBZNxKx0sN2TGuodAqux0gsZ8UPCIrZUbzGuZU
	 ivmkelr0l6guUJQ9eP2V80jamzn95n612xt3xglCzJ6NKA9HrybXzc0ly3I8fVnBkG
	 tJJ1YO+4YDc0A12Z+YglUrADOfJK1Zt+DVqKGKGhy82MktbIwO3V+tZsoDSClJOtNl
	 1tf/BNvWH83dw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7D60640ADA;
	Tue, 26 Aug 2025 15:22:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>, Fox Foster <fox@tardis.ed.ac.uk>, Federico
 Vaga <federico.vaga@vaga.pv.it>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: management-style: Correct "know" past
 participle
In-Reply-To: <20250826-fearless-glossy-dinosaur-46ebbf@lemur>
References: <20250826003437.7695-2-bagasdotme@gmail.com>
 <87349ed6zj.fsf@trenco.lwn.net>
 <20250826-fearless-glossy-dinosaur-46ebbf@lemur>
Date: Tue, 26 Aug 2025 09:22:31 -0600
Message-ID: <875xeaaz0o.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> I do believe this is a clear indicator that the whole sentence needs to be
> reworded:
>
>     ... if somebody tells you to "choose (a) or (b), we really need you to
>     decide on this," you're in trouble as a manager. The people you manage
>     most likely know the details better than you, so if they come to you for
>     a technical decision, ...
>
> This change would detract from the... unique... style of this document, but
> would hopefully be less confusing to non-native speakers.

There has been talk in some circles about trying to update this
... unique ... style to more contemporary standards.  Maybe it's time to
see if that can be given a bit of encouragement.

Thanks,

jon

