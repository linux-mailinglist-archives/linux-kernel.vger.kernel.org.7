Return-Path: <linux-kernel+bounces-787117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1480B3719E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C47B36800A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C84287250;
	Tue, 26 Aug 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="PyyRfr+W"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AB288C25;
	Tue, 26 Aug 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230350; cv=pass; b=U4wPqh64vOJPGILxce7chvbb2cHKERKcyd48gR0Ox7n5R7c+8G1MM9b1amoJCsVZ8ZCnEUEO5VuOlIMIW2GTp624lVZGjVJc3atlHfNOQRkkBy3i5XSzQCyNAmMR+sLyXdEZSLUGCqjOxhWZLtGoTr2mJaHJix7TEXmb4wwxCHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230350; c=relaxed/simple;
	bh=MjkT73njIoYLHYxZ/ah9madqXUjB5QIg4OTz+jKaasc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YKkRqC7bVFMu4vO+C/XXFY3Gh6PcCqNkBwQ8vLctNRmzi3RrVpvhQXi8xebBEFTQC0m3MJQ1/2GFn1eXDZ7rarXP4kya/9HPSLeKwmJ5RQRAkkRAb0Fu4e+hba/BhFNlZ4foyYyPghL4WyivT+BhOKsM/0+jZcZsUFrqTO9oPA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=PyyRfr+W; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756230330; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PIiZwFCGOnznmCn+lk3Q7dGKMjlW15ywnH+FCv64vir95en3voy2g8vtWKRnDQI++eMD+CrxP+LvxOMbr7ceFokkukYG4d4mZWXIvyhd5K6E5XGk2z9Dj4sCLPnMAJiPciikbaZGJTSQ5ccGOMtcNys3tC94zdhk6dVnR37l/oY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756230330; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MjkT73njIoYLHYxZ/ah9madqXUjB5QIg4OTz+jKaasc=; 
	b=btoKdqEfDmWn2zNIbOqbAA973deNcrmgnzeepx5lRv7H9EBEKi+kzKatabjHBK1LU/3LUfHZrS3hckb4yY0QmIRDTNv8QX2xx6N0/RyQEKi7Ul4Elz4p7laNDFOu5tKJq993gfMtZrQSCd++91mGxcy3tUU+dKRQvvWJs7DUscw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756230330;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=MjkT73njIoYLHYxZ/ah9madqXUjB5QIg4OTz+jKaasc=;
	b=PyyRfr+WQ4gUpFFiSUS5ExuVhaROugTYoiN2ARlV1YtR3sFwlGRS1pLcsMcKUMrb
	3TXwLBhnh21lIoOvrCsYdrVVvZQtQQ3eztkHMdUHetQUCzRkGCGrjQ6KOHguBGwXxxS
	YrDQn1o4wyakI4LnxntUiNrrqbq7Bk7TKrYXktJI=
Received: by mx.zohomail.com with SMTPS id 1756230328084762.8686626892185;
	Tue, 26 Aug 2025 10:45:28 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCCGKLKK0D08.1VOAVWOJIXIIO@kernel.org>
Date: Tue, 26 Aug 2025 14:45:10 -0300
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 akpm@linux-foundation.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 abdiel.janulgue@gmail.com,
 jgg@ziepe.ca,
 lyude@redhat.com,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA71DB2B-B87C-428A-A128-5B95DB6AFCE0@collabora.com>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-4-dakr@kernel.org>
 <DCCFOGR3BPVC.3OW6B74N372MB@nvidia.com>
 <DCCGKLKK0D08.1VOAVWOJIXIIO@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External


>=20
>> <snip>
>>> +#[repr(transparent)]
>>> +#[pin_data(PinnedDrop)]
>>> +struct RawSGTable {
>>=20
>> Even if this is for internal use, I think a short comment explaining
>> what this is for, and why it needs to be pinned (pointed to by =
devres)
>=20
> That's not the reason this structure needs to be pinned. This is the =
reason for
> Devres itself needs to be pinned.
>=20
> In fact, I think RawSGTable by itself does not need to be pinned.
>=20
>> would be helpful to people looking at this code.


+1 on having some docs for this type, even though it is private.

This will be helpful for people working on this code in the future.=

