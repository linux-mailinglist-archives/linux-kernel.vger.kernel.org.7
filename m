Return-Path: <linux-kernel+bounces-778260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B7CB2E346
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38D21C84DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15BF3376BD;
	Wed, 20 Aug 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AIk9Fv75"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E0322C7E;
	Wed, 20 Aug 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710100; cv=pass; b=BHlr7WhpNkM80QVJYVuucxm1THa5IFlaO4B/Ke00TZKF/NQmEesc6S5hNUenL7SgYp08abaIGilAFopp4ygqx1bvLu4PurhQc4NFRVN/IqZ1Si/soWQMge0mIzHZPvUrM1E7SvAN23ASgMVIimEdJxWwDWlHUrBHl1dmAGMCAzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710100; c=relaxed/simple;
	bh=N8W6u0n0FaxTtqQ+qTTeeurhAD0ppUS8fGZH/LKQioo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mU+CuOeYP9sMOu1vWEpMWmZbYV03bHP0cpsxvIzp7hB7kERsd1kSJG4/e4f23UJAj1nZqzUpUZ5wXpwz3sWMgkdhdQVKa5e4EUGwdeuLhsgdCTYLNM1eTmAPQxWC6W85lBrOqAI/uo+Vb/WyF/bZAT7TG58gvfjnzNpe2vLE/Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AIk9Fv75; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755710078; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZIjL5EUbkrKeGABEOvJSo+4NTcQa1TWLnotnecItaBOwkII8qcTU2yUTliEmSz/BNTn/5YWzZy9E5HqANlqLOQT7oFW3lhMgSFQbkHJYfDHJ4GvLJnFu5pbJ4/vZGhewihk0aDsWBnhn+FhAxAE0QUzW1I/3127KFJ82puuFCeo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755710078; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N8W6u0n0FaxTtqQ+qTTeeurhAD0ppUS8fGZH/LKQioo=; 
	b=Ez1M2m7DKZfrwHcvBdnCqau+IVIMcOf7rJATV3JGalkX0TWr17zxiCrAgBn7chgkwWgk4Rsr1tsEgNJaK7voYiJT7F7Q96ADQ0YCClMiMNs3cO+Hn61mZz6vpCwmSXW+Uh30uo3Q0SEtVQxUrhRudqBZAsfksi0AERkLU4Kcnqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755710078;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=N8W6u0n0FaxTtqQ+qTTeeurhAD0ppUS8fGZH/LKQioo=;
	b=AIk9Fv75jvm+E2OTVj6/BzpcxN0TSg1MuOafqJwQPmNgmxR3aAgW1R86TqCdcx9w
	wU0yDnwH4NJ8ALkt8kjApcyP+K4YeO5BwApCRRIJUKcdu8oHSX/l4ixuBGo2qNfad4M
	czShEcimr7E4QMPboqEyslxQPKbkMh7mT/x7Y2/c=
Received: by mx.zohomail.com with SMTPS id 1755710073244425.2366016584442;
	Wed, 20 Aug 2025 10:14:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction for
 sg_table
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250820165431.170195-4-dakr@kernel.org>
Date: Wed, 20 Aug 2025 14:14:15 -0300
Cc: akpm@linux-foundation.org,
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
 acourbot@nvidia.com,
 jgg@ziepe.ca,
 lyude@redhat.com,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <34610F27-8A3E-4B97-A06B-91DA6609A034@collabora.com>
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hmm, I see that you=E2=80=99ve just posted a new version. I had v1 open =
the whole
morning so I missed that. Can you check my nits there?

=E2=80=94 Daniel




