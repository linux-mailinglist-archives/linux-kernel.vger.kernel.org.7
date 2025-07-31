Return-Path: <linux-kernel+bounces-751524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF1DB16A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC1A567926
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEFA2192FC;
	Thu, 31 Jul 2025 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O0M6sFdQ"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702611531C1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930400; cv=none; b=aT0biPBbvJMUh81DBXbA0hE5mAT1+KHyjfZg1yQjYEFEoyNidMK2tr192WkwGgBEqIBKwSklq3PKoCJlIMqJQ21bQc+4jkiZwECC+/+Qyas7+N/5k5dvey1aoMjmaqYvM/z6N0KcwRJYDJ+Rav/yoaUl7RF0XK5yuZwmtgqYLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930400; c=relaxed/simple;
	bh=3e7o79Fpm9ojzWbREEqJErFCPDye4agxdfHKY+I5s04=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=uX6zUuEe+3vYMasi0uJ2joLrmEKSxHxh4GWQvJl3U577YJCmwOUxICTRrTJThctNHVIcDss4cmHMmW61z/pBjPtq9BVB+G140V2lem8j2W60obz9N+AUoharVgTpMpChrcFn69s9eCmD+3LwcNeuHf1ZE0OY1clIYrY0t2k+k3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O0M6sFdQ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753930396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9sPE4WJWqKMr+7/29xfbY0+Xa2H/DJawk+nioYYxrs=;
	b=O0M6sFdQgH9jBtgnC5B7qP0304QV+RApJ9MxCUUlBriwSrd4GQ4bXpKx1seZmoUTP89X43
	rTL5Ze0QDPY9SI0aadBkkc3/RzvyP4ab2j95fGtaS2HRvFzvhr6mpkuzJ0ANEaaYUaKqsw
	OAYJc6E/JWAtW4Jyg6tlcocbEG5e9SI=
Date: Thu, 31 Jul 2025 02:53:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Hui Zhu" <hui.zhu@linux.dev>
Message-ID: <21002139ec43d04f9fc6f58ce9250c7e8a4998e4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v6 2/2] rust: alloc: kvec: add doc example for as_slice
 method
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R
 . Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, bjorn3_gh@protonmail.com, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 vitaly.wool@konsulko.se, "Hui Zhu" <zhuhui@kylinos.cn>, "Geliang Tang"
 <geliang@kernel.org>
In-Reply-To: <aInRtC5CRxyDTy5B@google.com>
References: <cover.1753841900.git.zhuhui@kylinos.cn>
 <786e88abea2557080bde65fa9892df3b956731f2.1753841900.git.zhuhui@kylinos.cn>
 <aInRtC5CRxyDTy5B@google.com>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B47=E6=9C=8830=E6=97=A5 16:03, "Alice Ryhl" <aliceryhl@google.=
com mailto:aliceryhl@google.com?to=3D%22Alice%20Ryhl%22%20%3Caliceryhl%40=
google.com%3E > =E5=86=99=E5=88=B0:


>=20
>=20On Wed, Jul 30, 2025 at 11:35:22AM +0800, Hui Zhu wrote:
>=20
>=20>=20
>=20> From: Hui Zhu <zhuhui@kylinos.cn>
> >=20=20
>=20>  Add a practical usage example to the documentation of KVec::as_sli=
ce()
> >  showing how to:
> >  Create a new KVec.
> >  Push elements into it.
> >  Convert to a slice via as_slice().
> >=20=20
>=20>  Co-developed-by: Geliang Tang <geliang@kernel.org>
> >  Signed-off-by: Geliang Tang <geliang@kernel.org>
> >  Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> >=20
>=20It looks like this did not change since v5 where I gave my
>=20
>=20Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>=20
>=20tag. Please make sure to include the tag in future versions if you ha=
ve
> not made any changes.

Oops!
Sorry for that.  Fixed in the v7 version.

Best,
Hui

>=20
>=20Alice
>

