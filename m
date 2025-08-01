Return-Path: <linux-kernel+bounces-753749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F84B1874D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B92E1C82FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8B2797AF;
	Fri,  1 Aug 2025 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="S0oBfob2"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D917BA5;
	Fri,  1 Aug 2025 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072598; cv=pass; b=DHMInATSMHu2mXI6/is6+gxjX6XYRw14VnAsigyAbOY9PxTOEnj0ktzKh+F/eBm1LgAD3j07Rx00wPMTFqZacnlhbuJWJGDUnZly/AruaGic3TSPfhQo86fBHnyoZmJoHPyQHa+jj6y88Z2lnNuJU79lT2gFLvZy14gdfPbHWxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072598; c=relaxed/simple;
	bh=5VfOKq/BiAYCkesCvuK6rwc8orWBgVr/+Qao3m2gKRs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kI0S9XINBgWNWAIGnX/CZR/6askUiTXj2H8vxvs7Q/nvAlZksMdooXVHoM+aicmuoj8VbsKTUdfDslhBKrxfS33oRMPE3fofW+NwVvXk83aSkB16Rw5Uwl+/f3YbsPu4WedkJYP1Y78KBImN8lVU63Xox5wc5BANNhZ4/F4Hwik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=S0oBfob2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754072493; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f8pnnb43YIO0pPCotDgfMCLyx2/baHDMi/fG/qN6ToQ+fmVX9pOf1zjuHbjGOVYUdPeWSxyJLMvu1b1YmQilELSKuBvQVx+D+MsBZ/qg/lamRj2LljdrKF43bba8GqjeFRMv/z9Jo7Jl5PcvH/DebOfV32z/ZXA3Wi2icBFgwGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754072493; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QI7+Fsnpi/tC3LsZUww26BnvDe2yssc8ivO/+cxs2xA=; 
	b=S68hGea7FtsZ5NNiXtoJPjeW4uXILyHIKsyXzRIKeJoo4S8eZ0igCvdzE9ReNeUHCS1xybCtqI8YoOfamSyycQLh4oE13x2PhWSUzQy+HQL6xMHnRJv8ysz/wxnVJrSfhMan4sqwPnDFDkssNXE7GEoE2cTm8LBkybwJVc9s68o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754072493;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=QI7+Fsnpi/tC3LsZUww26BnvDe2yssc8ivO/+cxs2xA=;
	b=S0oBfob28IAbr9THnP6LRXeMxOYGbKj0PV9deTW0uP5yJ4eVMPvrLYtDsSrQPmMa
	TVB3V6f7a46ofXIoDwmwJc48Ik54ZVGmwJNoaqEKvmt8b8WorKRNCA2BN00y2bBI9Rc
	Ml44rk3v+05Sq6g4/JQbFDphJInhanqtXCf0HqFA=
Received: by mx.zohomail.com with SMTPS id 1754072489043310.1216853362323;
	Fri, 1 Aug 2025 11:21:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 1/1] rust: update error.rs documentation
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250731204115.13669-2-work@onurozkan.dev>
Date: Fri, 1 Aug 2025 15:20:57 -0300
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
 me@kloenk.dev,
 felipe_life@live.com,
 abdiel.janulgue@gmail.com,
 dirk.behme@de.bosch.com,
 daniel@sedlak.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B56FE7C-5DD3-4D28-864E-1A4457B66888@collabora.com>
References: <20250731204115.13669-1-work@onurozkan.dev>
 <20250731204115.13669-2-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 31 Jul 2025, at 17:41, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Adds missing header links.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> rust/kernel/error.rs | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 3dee3139fcd4..7c5dac20c480 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -2,7 +2,9 @@
>=20
> //! Kernel errors.
> //!
> +//! C header: =
[`include/linux/errno.h`](srctree/include/linux/errno.h)
> //! C header: =
[`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic=
/errno-base.h)
> +//! C header: =
[`include/uapi/asm-generic/errno.h`](srctree/include/uapi/asm-generic/errn=
o.h)
>=20
> use crate::{
>     alloc::{layout::LayoutError, AllocError},
> --
> 2.50.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


