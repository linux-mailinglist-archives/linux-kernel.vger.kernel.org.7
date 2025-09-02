Return-Path: <linux-kernel+bounces-796561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B76B40277
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3671B21E80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ED630506D;
	Tue,  2 Sep 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3iMWO/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815E2BDC17;
	Tue,  2 Sep 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819024; cv=none; b=R4nxL1k/ErdMJRc6lgBy1zEF/9d2utqhA6C0Ua2WrBhQY+0xSMWghX+D8cCk4VVVl4LhYeFkJ6gNJj0nqwrrCGDVQaamjil9wfvSeFgF8fXLWpofGdFkpmiDfBvPJ2lLFlvSZW3j9EYYGwrC3RDtDrruIWg8wAm1f4cY3s35IaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819024; c=relaxed/simple;
	bh=yWGTZjnQCay/KF6aZRNmaJWEUQkXtG6xIkFUtfP/pDc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Kqtf8w3yYOSkkPKolENs0M9CP/7XPEKXbbag/O/xuAEUhrqsSkfJwD+TRZzKYMvKaDV7zyxQ1uUwvpzTkgPwSgAiypR4s1rMpQfPbIvd6ACixla/ubDOG5o20TSEnqL/a74g7EBexEgCNywuxwuIYuFk4jtLdz4VtD5Qy1J+k/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3iMWO/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787CFC4CEF4;
	Tue,  2 Sep 2025 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819022;
	bh=yWGTZjnQCay/KF6aZRNmaJWEUQkXtG6xIkFUtfP/pDc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=C3iMWO/9cCK1A6Kc4REcyYqhaFrSpnRstDH8RaIRhdG7C091kjMz45r/oIXCOYZej
	 x0Cl0KGuMUXmF8L/RiU2HsviF+FjTYE/JkwcUo9Yig0uJmNTa+h1v4P1aT38Yp+F+7
	 pWC06SU2uK2euy/pfmN/6JvAlJQTcIakbkWQdtjyAlNtqCMI7Un9gmgAnZI6xZ7mBY
	 yQh+lF6bVqeK/ytoKTND5nay0cxYkDEIP9ZIHu89RIEMB9Cezk1T6Rq8hu55HjbBqQ
	 69uvotiXyZk5GCPdqZZKjbU3e+vo00QBu61fLwKGg1oepTSagedBYOs7D1bHzzL7lR
	 KYJMgJ3Xx8gqg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 15:16:59 +0200
Message-Id: <DCICD7V5OG7A.20QNKKBEDK0IG@kernel.org>
Subject: Re: [PATCH] rust: device: fix unresolved link to drm::Device
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "kernel test robot" <lkp@intel.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250829195745.31174-1-dakr@kernel.org>
In-Reply-To: <20250829195745.31174-1-dakr@kernel.org>

On Fri Aug 29, 2025 at 9:57 PM CEST, Danilo Krummrich wrote:
> drm::Device is only available when CONFIG_DRM=3Dy, which we have to
> consider for intra-doc links, otherwise the rustdoc make target produces
> the following warning.
>
>>> warning: unresolved link to `kernel::drm::Device`
>    --> rust/kernel/device.rs:154:22
>    |
>    154 | /// [`drm::Device`]: kernel::drm::Device
>    |                      ^^^^^^^^^^^^^^^^^^^ no item named `drm` in modu=
le `kernel`
>    |
>    =3D note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default
>
> Fix this by making the intra-doc link conditional on CONFIG_DRM being ena=
bled.
>
> Fixes: d6e26c1ae4a6 ("device: rust: expand documentation for Device")
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508261644.9LclwUgt-lkp@i=
ntel.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-linus, thanks!

