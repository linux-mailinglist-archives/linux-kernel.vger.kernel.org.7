Return-Path: <linux-kernel+bounces-837727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952DBAD0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B3A1C803D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746CD303C87;
	Tue, 30 Sep 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LshjHvtV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A156B81;
	Tue, 30 Sep 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238795; cv=none; b=LY+Nh0N0caumvow9bfVxuX67V9yPBPZmPeYJzpr1pKkSOQ+IlGnvGjZbB2qFcbZXjpOrfKsZVZWmgVyzag+IRpAYu93IDMuUrlCLICXDuWO7gdGSVysvm+L9+hGpjwq1YPhz2ESqGdOvvaYDthDuKBkZcI24oPVqc0mqjnwIDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238795; c=relaxed/simple;
	bh=9uUYAkvXqfJcBpvMO9hdwqzS2RzQlSDU/JccIeYevuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxE+GZwQQsuh0mW4Kr8RV8tUQvwjCVRQ1rw+ywGchhEoQLMKqfZh4dHMbVhK0SZXvN5XNBK6hSKPKlwSrJgOUjCAr1Qgn15m+H8+wTEqSzWO7ZOdOrNsMlRtnKbXETGKlNkT5lvfmBxJ0cP3AhJTfRy1kivuXP60K5bToc4EbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LshjHvtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EC5C4CEF0;
	Tue, 30 Sep 2025 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759238795;
	bh=9uUYAkvXqfJcBpvMO9hdwqzS2RzQlSDU/JccIeYevuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LshjHvtVDNooSgvjmioIVN1ImWG59r81OXRd4hBWekJqFLE0HCZT9quaNlzyLD46o
	 p/8TdIpFyrpSCmG1TYZ/DnTw3DUWFb3DVKgPyL8heAp6H1CmBoSBI0mrL7sQpM+Xnu
	 mFg2XBxtwl+QpoSzgKl7iBHSwrKV/XKJeKEszxrlOF3H7V+TmCQ75ZfnA19WjyvjNV
	 9v83yEQ1HA+NL1VoYgop0ogMl+8IzO+9HrJWHYMFc6X2OjSQpAFSejtTfgWRgHHYKt
	 vP5Cu8/41lq4WwwotmDWpmBnqG8teEjd79MS1+O/+ZhBkD/bY6vqm8vdu6cxQ70IKH
	 BwpejWhVkOn8A==
Message-ID: <fcd4a013-0eb7-4a3a-b916-1dc6c444225d@kernel.org>
Date: Tue, 30 Sep 2025 15:26:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] gpu: nova-core: Boot GSP to RISC-V active
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 acourbot@nvidia.com, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
References: <20250930131648.411720-1-apopple@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250930131648.411720-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/25 3:16 PM, Alistair Popple wrote:
> Changes since v2:
> 
> The main change since v2 has been to make all firmware bindings
> completely opaque. It has been made clear this is a pre-requisite for
> this series to progress upstream as it should make supporting
> different firmware versions easier in future.
> 
> Overall the extra constructors and accessors add a couple of hundred
> lines of code and a few extra unsafe statements.

A bit of additional code is expected, but it's not clear to me why this would
require additional unsafe blocks.

Can you please elaborate?

