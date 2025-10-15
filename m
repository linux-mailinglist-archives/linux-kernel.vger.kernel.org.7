Return-Path: <linux-kernel+bounces-854474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B2BDE788
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FAE3BA245
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1E327783;
	Wed, 15 Oct 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNqwgQiy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE72C21FC;
	Wed, 15 Oct 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531399; cv=none; b=IZeySWnYCGzz3KZO2RLNIaEWYAaWD8riHbQjwGH/qolMlN9MR1UB4iNXfjOu7MtZDP7LX1iNkIBTcePm5M/Fq7x4SP3iIoySatdyejyVVPY3nLBbQI1sjTOZPPxUjwcNvSjjtAFNCOkvXUfMWkkqb1MFaTFdqs9T8g+lAHTtLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531399; c=relaxed/simple;
	bh=PqJfoggt1kaUHs+pnswClZspb/rHacAJYxqaLklDo8Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=sReN39FR5Z/qWloQaVX35stMatlujTpx6H+x98+Rud0ycszJkIMSb9Ae24fQatALtoa6CCsSj2ug8ZlO8QrmQRhHJUHj8yo3//zx71EIC1aEOYzEF+Tz5W+H3WY6Yy7xsnT23UeDRu14EbDXtmEodQzOrXE/p9sKccchfX7c7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNqwgQiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6304C113D0;
	Wed, 15 Oct 2025 12:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531398;
	bh=PqJfoggt1kaUHs+pnswClZspb/rHacAJYxqaLklDo8Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=WNqwgQiyzevwYN1GxBKFMLtmBCihT0LReAj2GoSxetoHexRotvldlu7LuR65ar5Zi
	 ox5OjVlssvP7quoPixt1JcJYYar6RhWuH7H0GxA7mEBtSHeiUxUWYoMKRKrJ0mDmVs
	 YuY2AwkmYXssbFhBUj9VTCr49Jp/52cLVbMsksH66lNU4MzxsiAkt8FmCwoza9KYCe
	 xC5AXlH65vP8aAPFFEHumkgDJl9nq6cxXxLFU965UsRTMzTsIk3oYaH/IJsf1jgaKL
	 s8cXaFNTrtrtXumgQYNiMNu4zExL86eCOaqP+LU/2XVZ6y8sNwAWJKMooy2qgy5TOR
	 yQA2lViwCuYsA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 14:29:52 +0200
Message-Id: <DDIWAK8RNEMY.2D4471L1K87QT@kernel.org>
Subject: Re: [PATCH v3] rust: pci: Allocate and manage PCI interrupt vectors
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <acourbot@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nouveau@lists.freedesktop.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251008190726.823527-1-joelagnelf@nvidia.com>
In-Reply-To: <20251008190726.823527-1-joelagnelf@nvidia.com>

On Wed Oct 8, 2025 at 9:07 PM CEST, Joel Fernandes wrote:
> Add support to PCI rust module to allocate, free and manage IRQ vectors.
> Integrate with devres for managing the allocated resources.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Applied to driver-core-testing, thanks!

    [ Add links in doc-comments; add missing invariant comment; re-format
      multiple safety requirements as list and fix missing backticks;
      refactor the example of alloc_irq_vectors() to compile. - Danilo ]

