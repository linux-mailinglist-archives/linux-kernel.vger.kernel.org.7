Return-Path: <linux-kernel+bounces-746257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D29B124AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD353BCE36
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15178259C83;
	Fri, 25 Jul 2025 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Gy3ZY3CN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC04257AC8;
	Fri, 25 Jul 2025 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470869; cv=pass; b=QQ19YAwAryAS6Eol4tCcT3Zi7aqKgDqyMlpTLDnJJVwHX9D8Y1nQpdeVcTQuuV9TIvEhze+6bIPMTAB5QG0fYsFWp6Yo7PRZDH/RG5hXRDQdy20RAgRszjKOdQauK0kHDE3BbqvQ7P4RsH9bFAD7n/el842ZANtMgXPi/P4J7PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470869; c=relaxed/simple;
	bh=3nWI/X9rRBiEr2NqIzAIqtYm3orV1MzmKQSYQeh0vlY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cIShXyi1fBMlxp+8dFjjUxFs9mFt3wpHYouSX+GRhIkVFGnTyt6gCG6s05v9nJmPVC25DnYCtKW8za6mjk4kT+A44YPjSKtiKXiuvTwzv6Knnyzj+un8CE1XM1Y8fHwQ0RIT1MBlKjTZysTsrsAbFHy7QzXymV3iK+W1EeZOyjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Gy3ZY3CN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753470855; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c/ChNizIilZBnl3u9pOD9ri6IJtwX7FBbpt9SZb9lvrYABZGfoZTfZbmrTNUcHRtPz1pHE3phsGcM6L5co9VDTza6X+n64Rz22mYfI2Q6zVzXs/0fb8sVa5xBeA8XqRWuIRGOsk1VC+fCFv5WEf6IvGbj+otcjk3Y3qI3eSPA3c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753470855; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3nWI/X9rRBiEr2NqIzAIqtYm3orV1MzmKQSYQeh0vlY=; 
	b=UKGzRK8Yw0tgtrnjMEMV3lR3s/CnfepjbG5u6aAVWSt2ojGrJFzXvDBBv1UZUudP+Wh9r4t/Bm+Io0RwipNEZhXQRPN8QRZvYo2WhxFgNvsbKof6JPluEPBFkXgvFI2G7ffk17KM0PWPY4HwDAp8v/08gmDVT0GtSwjiVLAinvo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753470855;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=3nWI/X9rRBiEr2NqIzAIqtYm3orV1MzmKQSYQeh0vlY=;
	b=Gy3ZY3CNERCXwvCGwtvIR3QcudSuJpycnMBiT24+uD8VPDJL2FfA4vVHdqu8D0wL
	8ea75vdfIdZwcZ9LKjbe66nvnvgY8EEsd0CZFUJeMyPT6Cq3t79EJmXtQWoANjYUUie
	uyrQKQ1om+mUDj8MH2yoGqMyHAJLH+jJ5HWow2gc=
Received: by mx.zohomail.com with SMTPS id 1753470853076366.46647032927183;
	Fri, 25 Jul 2025 12:14:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 17/19] gpu: nova-core: register: add support for
 register arrays
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <D0DDB132-68E8-43D0-B7EB-AA607C9BB72F@collabora.com>
Date: Fri, 25 Jul 2025 16:13:58 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Beata Michalska <beata.michalska@arm.com>,
 nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D08E06C1-D8E4-42F2-861E-C11712351EE8@collabora.com>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-17-7b6a762aa1cd@nvidia.com>
 <D0DDB132-68E8-43D0-B7EB-AA607C9BB72F@collabora.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External


[=E2=80=A6]


>=20
> Assuming that the @io_fixed stuff is correct:
>=20
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
> =E2=80=94 Daniel

For the stuff in macros.rs <http://macros.rs/>.

I did not check the device-specific part in Nova, as I=E2=80=99m not =
familiar with
how it works.

=E2=80=94 Daniel=

