Return-Path: <linux-kernel+bounces-811923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB7B53021
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CD71BC5766
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB63168EB;
	Thu, 11 Sep 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM53fV2N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB07311C10;
	Thu, 11 Sep 2025 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589827; cv=none; b=cok4l3x4PSsyMZLFD8M2r/38fWZ1vIfKSuenQvuBQSlgkAM0TqsEYVLX911ynDWpIDQBi/B/1JiWiu1g/bwx7Glr+alDOrZhpdImZjp/mhZwlGtlgtt0BAo2GZ4jq6Zp8G1CaJkewPnckjN3RPTW6kH09QrNHmdzR+GFO92/K84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589827; c=relaxed/simple;
	bh=p4waa9LkxC8TTbVh+HqVY69fXLYJWft8thFtWQWeKzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNWlNkgOft5KUN9cKh26FEotXcwzpUGxFeuJo0EA6lowvJNS6kpnaN7irEnubpNXym5ukfliuOMx+XQvXiF/xyfgTUH+sgGZh9YqdJ8Mwecp2HjrxXPNACzgsspkSK1vxPC4viECGtLEY5WaGLte5qR7XBKCMumyABboZUr75iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM53fV2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA3AC4CEF0;
	Thu, 11 Sep 2025 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757589826;
	bh=p4waa9LkxC8TTbVh+HqVY69fXLYJWft8thFtWQWeKzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OM53fV2NC+l33RRDjaAOxmYNre07SpJ6jmrQ8VFbi5RNanuG5K5lirnRtn0uwFmh/
	 rb4or7E6glMg2cWFY3Ymlgyx398Y6cKWJpzvdETAQHkUdMipZ4HG5Ah9Wu3nPDJ2QX
	 B5R269ptR+hbjRldrlhrLAhBVMIc0AwR4YDpcFA6TCmgTyEHfyvKUvnUEE1GzLqmtg
	 w4Cd/hpJp1ut86yD4mMwKRn4oWVvkUKPLWy/PQpmKepsj7MkCXyiN3MJ6U52gjn//C
	 GCFGgW0bsObFVCJEwcUGuke5HFPfV3eKCR3KMuGsAkrJkBUK4ibQU0hwPAh1iZdtPk
	 gulQKZ1hUfhpA==
Message-ID: <694e6b89-4d83-4a61-87e8-5c420b60114f@kernel.org>
Date: Thu, 11 Sep 2025 13:23:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] gpu: nova-core: firmware: move firmware request
 code into a function
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20250911-nova_firmware-v5-0-5a8a33bddca1@nvidia.com>
 <20250911-nova_firmware-v5-5-5a8a33bddca1@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250911-nova_firmware-v5-5-5a8a33bddca1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 1:04 PM, Alexandre Courbot wrote:
> +/// Requests the GPU firmware `name` suitable for `chipset`, with version `ver`.
> +fn request_nv_firmware(

I think just request_firmware() is fine.

