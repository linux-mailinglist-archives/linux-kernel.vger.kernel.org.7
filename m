Return-Path: <linux-kernel+bounces-817351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F513B580F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8833A44EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA89212568;
	Mon, 15 Sep 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YAdyjo0S"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2611DE4C9;
	Mon, 15 Sep 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950753; cv=pass; b=IuflH4BpYmWTzrEuw4FAhDqcz4cKYH8TOCagBT3upTRFluLJufhVg4MkDIQx9btNHfEfJjzCawCiidi5c60+XQamOcrU86WozTRhfVpHHUQ5WjbvUsMvKScvnljjOdURu6/MkS+Dafk+xCnD6GlpEv6NuO9UkLpEXbBch7Ghung=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950753; c=relaxed/simple;
	bh=5kmvQnBymQMrJfGDO8l0+E8qI+rwZ5BMyzqkwT6KPUo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Rcq4xWslZJF8/ekqR9G94UhxpnRg7s0lxsuJcvbvC7EVGGisCyznD4GvaD4Ge0ItubzmX6waFhCbblU85BTpwRe96po1aolZ0pOUrWuEQKA1kREkrDBwAOnQL0aufpNEw5JODN50NnbU0uUnjT72/Umpys0A1neQTVdWOvo3U28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YAdyjo0S; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757950731; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jx//BjnUviO745ZA6pbnnW++OyROvK57X/zX+yUfjLMZKD7SlHnOTUMlyLekjD3vetTiM44W5S7J/sKfnjEayofAZEJ+g8gZcMHofbgsUfmMR/POo68sXUZ0/2GaboL2/ByWvxwaWJETUp3pc/+GsIwwzBQgAxaJRMCNTT9oURc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757950731; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5kmvQnBymQMrJfGDO8l0+E8qI+rwZ5BMyzqkwT6KPUo=; 
	b=O3lq7xi0VJgQtQxFFC6AfKFVDl2kIifLCQBfcA4Koq0pF2hAiRYNArlAdAVhvUkh8otPEqPUea91gTXrP1rRLMtlnS7HpG7WniFvClw6yaaqsQIHhq3AKy46jomk3jrO6aDPKORsIm4Ca2qwGI6g3boWftQ1sx2qmOswaEAbaV4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757950731;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=5kmvQnBymQMrJfGDO8l0+E8qI+rwZ5BMyzqkwT6KPUo=;
	b=YAdyjo0SEwsFhyP2ZOH+hUN9zQ1rbJklHHzYs9Afgk4BDaWMBwL5klo7R4Rd8QHd
	SczU78NnydtndgX6+Ka3RsLhGrgaj4PZMjOe4jOxYr1LFHxC+5zaV6gXVENu6aeUGcB
	2dBXEyI5nrX/tJzHTYFw2AI4pxvfSeCrac5bYiSI=
Received: by mx.zohomail.com with SMTPS id 1757950728174458.07732891061437;
	Mon, 15 Sep 2025 08:38:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: less allocation in CString::try_from
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250915065401.20141-1-work@onurozkan.dev>
Date: Mon, 15 Sep 2025 17:38:32 +0200
Cc: rust-for-linux@vger.kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 tamird@gmail.com,
 daniel@sedlak.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3208F1A3-CFA9-45BC-85D7-74C8C47CA11F@collabora.com>
References: <20250915065401.20141-1-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Onur, thanks for working on this :)

The commit title doesn=E2=80=99t parse very well, can you rework it?

=E2=80=94 Daniel



