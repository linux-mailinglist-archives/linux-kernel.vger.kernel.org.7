Return-Path: <linux-kernel+bounces-878793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA6C2177C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B10B8346FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075A36839A;
	Thu, 30 Oct 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMXewI+F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FF2E0B5C;
	Thu, 30 Oct 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845054; cv=none; b=cna1ztwDDol457yWBZXfQbawHgiI8hxS+LJQWDZP8upAbeP/MHTNZLLNQBKHgp3YqQlKAyJoh92LWB73h8TJzBwp22UxBrWV3n+Dnr/UQ9ZOjvZ+U3LGKCEYEHFrb6dgP+cZPAm2EIt7EgEgYKJDxrtyj2sVX3t8Pu6OPAbDvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845054; c=relaxed/simple;
	bh=WJgiqLXdNppUdDf4uQG/4N9IuzquIQiMfW1tlU3UWkM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SrwG7H4aKen5FMxFPGPhnFxLsnXf5QjhUcuvkFHGnIEHVR0LoLYOG2xTZ6IgU23vX7TiMJ1gVopBLlHhq3HUgjIVmbMNgluRY5RdmsUyR9ibzW/f9m737n1Q+fQSF3DadD8FOYR4HxD7Os+6rZeAiwZrdK/fRT9GoAr6RLMEkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMXewI+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE6DC4CEF1;
	Thu, 30 Oct 2025 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761845051;
	bh=WJgiqLXdNppUdDf4uQG/4N9IuzquIQiMfW1tlU3UWkM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IMXewI+FRhflVmnrdALdfmKENIjzZz/2K6eq+Rf9eLA0XZaqILXCwNHQFPY3Pzcl/
	 HbsY0HsVyPAUYkoLRVx/M4rqGp6DYyYwdbyjHw+Cyt25d93jHO8u3EWZcbyPgrO1ac
	 aSfPGP/Kgzadk7e0QvXmAeLqVk1rozAK4x8NHIWJi+Cu1iHpleh7mlCVtwnD19GNhH
	 PHz6DGm4Go/jZh8Nh/ZuDPeIrO7MRoY+02wD+ZoZi0Ccrkg27IomCgQKlTo5rJM0LV
	 9QvUDdlRb1NLxYLo3LtZk+bz7P0gzZeQwplxocPjB0dzkGwPHShOU1ILF/dJ5dZeDn
	 8GxBpw9FKFHew==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 18:24:04 +0100
Message-Id: <DDVTXZOL7O4O.SU2DN0FE9J48@kernel.org>
Subject: Re: [RFC 1/2] rust: introduce abstractions for fwctl
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "ojeda@kernel.org" <ojeda@kernel.org>, "alex.gaynor@gmail.com"
 <alex.gaynor@gmail.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "gary@garyguo.net" <gary@garyguo.net>, "bjorn3_gh@protonmail.com"
 <bjorn3_gh@protonmail.com>, "lossin@kernel.org" <lossin@kernel.org>,
 "a.hindborg@kernel.org" <a.hindborg@kernel.org>, "aliceryhl@google.com"
 <aliceryhl@google.com>, "tmgross@umich.edu" <tmgross@umich.edu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Neo Jia"
 <cjia@nvidia.com>, "Surath Mitra" <smitra@nvidia.com>, "Ankit Agrawal"
 <ankita@nvidia.com>, "Aniket Agashe" <aniketa@nvidia.com>, "Kirti Wankhede"
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 "zhiwang@kernel.org" <zhiwang@kernel.org>, "Alex Williamson"
 <alwilliamson@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
 <20251030162207.GS1018328@nvidia.com>
 <4e0be534-e3d7-4c74-b8f1-51bd869b18e4@nvidia.com>
In-Reply-To: <4e0be534-e3d7-4c74-b8f1-51bd869b18e4@nvidia.com>

On Thu Oct 30, 2025 at 6:19 PM CET, Zhi Wang wrote:
> fwctl_put() is a inline function and it seem opened by the compiler when =
bindings are
> generated.=20
>
> $ grep -R fwctl_put *
> $ pwd
> /home/inno/drm-rust/rust/bindings
> $ grep -R put_device *
> bindings_generated.rs:    pub fn put_device(dev: *mut device);
>
> Hehe. I am open to options.

You can add them to rust/helpers/.

