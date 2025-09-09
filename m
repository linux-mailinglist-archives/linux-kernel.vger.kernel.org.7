Return-Path: <linux-kernel+bounces-808291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A4B4FD98
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9564E18BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E4343216;
	Tue,  9 Sep 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="f9/DX6Ds"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE757215198;
	Tue,  9 Sep 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425071; cv=pass; b=ZhJ1XwM7k/Po4re3QEu8vCmm7M4PtqKYSblZenXpGcRHIcF9YBF0rxEdYTduo7JrKgFAj8u6hlcrsMoPXFVGaoR8Uiatl7r8dWiRAz5dfcddNd4z4UOC9HdkseKu5up5X5MNydBvFVFeMcUoPVH7xUsQwrcuc519Byojw+uQoJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425071; c=relaxed/simple;
	bh=vDE7ir/Q7thEdsekL5zUEuO0QD6TAng9vUKCP9GpxY0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rCihdFRcsjsQ6xqIgS62anN4FrBc4uqefV4JVcUCaYrHEByi3fHdiEDnmYvX98aWrrknUKBsUE1M2XwyH82YxBrpntT+Mc2JALcYquA2spfUKtYbAdmcPH6cyNkmv7DlFzZUAJ0YdDFafkY6zHrTDE8QR1u2o2LSlRq+9UV7exU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=f9/DX6Ds; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757425041; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DRnPNZ9FHg1EE306zf6op9Zevb/+iQaio04QrAjfKBKqzLnOKx/Gyf8WGThBNPFwvBmIymAzpZjZXXtDliSBHCqfV8PCsLpT4ZrGaudhzzlxUY/RUV/81fJCR62sjvcNp+YkMRJ61khDrPE7zCCPcv5gg9s9DHFGbasXThQDyV8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757425041; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vDE7ir/Q7thEdsekL5zUEuO0QD6TAng9vUKCP9GpxY0=; 
	b=T4/bkpB4rMwgDlBai5GzPPrf4NkcBwu1w+MVr+cIyqLBEDcHoPKrj704pjbH1Xez+8GV9z5JDv8cSIY2E6RdJvw+X1OqMeSeD+ZXlKaPEPs87nEePvB6A0tHBNOvo8nW+Y1Q1b6M///3NPDCP78O40EpcW9+IOrf86DJSqoJgDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757425041;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=vDE7ir/Q7thEdsekL5zUEuO0QD6TAng9vUKCP9GpxY0=;
	b=f9/DX6Ds175Fx2Ou0TuHIOvCArr7HoYsjjU4d7PS+PrRtjfHpnZ3jLEWuJUN+6DA
	ozRjAISzPSTY9wsYKHv1ZpRxBCnsn2eUx4OnqEWsCU3Y+uvQDkf+j0vJN243M78RPyI
	GqNu0VskkGUuYIq3rRQS3GH6It+tS9fXM7Nv6xPE=
Received: by mx.zohomail.com with SMTPS id 1757425037616341.77359567758015;
	Tue, 9 Sep 2025 06:37:17 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1] rust: refactor `to_result` to return the original
 value
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <C424F7A6-524C-4A37-8513-B3BA2178A709@collabora.com>
Date: Tue, 9 Sep 2025 10:37:01 -0300
Cc: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 daniel@sedlak.dev,
 dirk.behme@de.bosch.com,
 felipe_life@live.com,
 tamird@gmail.com,
 dakr@kernel.org,
 tmgross@umich.edu,
 a.hindborg@kernel.org,
 lossin@kernel.org,
 bjorn3_gh@protonmail.com,
 gary@garyguo.net,
 boqun.feng@gmail.com,
 alex.gaynor@gmail.com,
 ojeda@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDBE5225-831B-4C70-BFD0-FDE034871DCA@collabora.com>
References: <20250909123258.29304-1-work@onurozkan.dev>
 <CAH5fLghVt6MKfiDkmd-5DMAKA=yXQzMu3GNHAqB+HRGhyJ0tqA@mail.gmail.com>
 <C424F7A6-524C-4A37-8513-B3BA2178A709@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External


>=20
> What exactly broke for regulator.rs <http://regulator.rs/>? It works =
just fine.

Please excuse my weird email client here.

=E2=80=94 Daniel=

