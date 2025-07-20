Return-Path: <linux-kernel+bounces-738289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F232EB0B6CB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479C73A6DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFE21C190;
	Sun, 20 Jul 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bs63e3Nl"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273991A23B5;
	Sun, 20 Jul 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753027003; cv=pass; b=d1ZgOOaF8uDKsD6oxgNgbJg6KkqxNjts73hYgS6i77jRDj4G5BpFzuASafJAABZKKLcJElXctl2DvDdICN5gi9/mnEmSCQljg/j+pnR0aDMBrNylHgwVD2joEMwkjrbYpn2myUXnOINqhYyexCDu9uQJGxU15nhYgNrHYpHpeNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753027003; c=relaxed/simple;
	bh=Kgf4ebbbmC8TJqXyyg3h4tJI/2IZL8J2RWSnHBNB46w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BTkwtGXG52Cx5tT2G2DJgmKYAEZBS4gLaCzsbojZTngUepXdwUNQibY3c4HESWO3/Qfs4Xaui3eNSBdjIqjWK0JNQXKyKu0mPL02G6ECeVSH1STd9ii6Ztu4dJXIL/rob/yARDPG+QOgxu3erM+cMQjpt1LE7BH9e3HJ1SJG0Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bs63e3Nl; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753026987; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c0JEC5IJwdmsxYLINfk++Adwtmf3NvSn76tI1Ujh584KqxmypiSAvlqgnxf/JQbsGRg2ReJu/H07eUvoYAXrXXtlw8xxs48mrO3i+QVa3mZWwaqDhXppzANORNGK7vRjPC2tacn4SCY7oYsFF8INtm7Am61cA7UIALrTAeoUSUk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753026987; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+cxba+U6S+zEpagJWyQeVlVivVci989TuaHo0BdsYdw=; 
	b=SWWgfX5qvVkDBVGmWOlCGpGx06gTLcmfeoVcjg/ss54gxW2k1RFXTHiplXHrnWauO84glYFPU5z55T9IBcnad/SKwV2RIPzqxrEvLGsBCXmIOHLdTlZc/2UIIHndvbY2UpMt8W/xOZ4dVKRHpgLaszsgcHgqF2mI93uwmaMFqg0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753026987;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=+cxba+U6S+zEpagJWyQeVlVivVci989TuaHo0BdsYdw=;
	b=bs63e3NlZofJBnTsPFCfWUiE6J9z20YeLnn4ODvwxkAtC0XRT6PESq0nvhOh/jrt
	gKYZmyeSWinuSAX24FeIm75mfS2Wla0WykS7w0llNhyz5z1LHzRHG4uyBhX0nvhQaHr
	qM8DGjsGPsvRnLvQRMcDCHdT9AwLyB8LWP+a3JHw=
Received: by mx.zohomail.com with SMTPS id 175302698407049.503546430246615;
	Sun, 20 Jul 2025 08:56:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/3] device: rust: expand documentation for Device
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250717224806.54763-3-dakr@kernel.org>
Date: Sun, 20 Jul 2025 12:56:07 -0300
Cc: gregkh@linuxfoundation.org,
 rafael@kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E4FAF7C9-F210-4EFF-AC29-C969A991205B@collabora.com>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-3-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

This looks good to me!

> On 17 Jul 2025, at 19:45, Danilo Krummrich <dakr@kernel.org> wrote:
> 
> The documentation for the generic Device type is outdated and deserves
> much more detail.
> 
> Hence, expand the documentation and cover topics such as device types,
> device contexts, as well as information on how to use the generic device
> infrastructure to implement bus and class specific device types.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

