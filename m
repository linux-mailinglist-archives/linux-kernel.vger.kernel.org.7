Return-Path: <linux-kernel+bounces-856969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F864BE58F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F015E34ECF9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE8E155326;
	Thu, 16 Oct 2025 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nki/ULUq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC222ACEB;
	Thu, 16 Oct 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649574; cv=none; b=OEi+vw9XZpY+UUQ+AaYs0vkktajBsfcTOTP51Bx+Aaa75sikt4gVhw5/u87TxYR+U1Zk1LPM5LKup9+NdgxGLchkKhSbbIXWGvDJAdzNecgTnZCvrcbG4LG7bVMX8dCLm/PZo2+Q0nwnE5hUKp2W9N0Y78IJm71+aiE8kzEJqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649574; c=relaxed/simple;
	bh=tLht0hogKAd9moeHeSio4bb2QbKG78zvDKNBY8e6Beo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdgP6Hng+17vJ78i6q/3oGMphJeYJ5G6WE06o2NoDWqI0cIW1uBJwrGJxUODQREfOAoeLu69ct9HDQL20UG2NI9ndU0j2YGtKuwCf0bo04gFm1lzUlulc4gd39OHKcQK0ptf/nkQS2QU8W6TxS2KEG+HyxcZmxo2Di6Tkb3r6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nki/ULUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5463EC4CEF1;
	Thu, 16 Oct 2025 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760649574;
	bh=tLht0hogKAd9moeHeSio4bb2QbKG78zvDKNBY8e6Beo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nki/ULUqCLt0HVz0H2BEsvB08XnDngifRrqfMIme7ex6WmWEZFW/+PNYok88Ye1gk
	 5NkZym2m9SvUva0L9vOd3k24C/OrFF5ArJXswfzpqive3b1e6TBqC7xi+BpAPcBjth
	 byES0LmjEvfGbSdV0K6MbJTkGWbZJqoCiF3HAwMoKhDIPsNgayYLGxZRhDg2nGtqGi
	 1DB/Oox6qsSFGDFDyvLAP86L4wi5LOcBQLe4SSwCBP9ZCjIcGmmjFsMPayp1GWxg8y
	 Rxd2xN5GUFocpj2VjzV3n9k3pn7OKq1frxrABPcAQcMk4l/H+7F6XETeaT48Oi81KQ
	 rZeNKKHUmRNdw==
Message-ID: <0eedf2b9-2e80-421a-9356-d5ba8e49a147@kernel.org>
Date: Thu, 16 Oct 2025 23:19:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nova-core: Solve mentions of `CoherentAllocation`
 improvements [COHA]
To: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org
References: <20251015194936.121586-1-delcastillodelarosadaniel@gmail.com>
 <409f2f03-2bc2-4cb8-9ca7-4e30f82077ff@kernel.org>
 <21944b18-ac36-4acd-9d36-cc05579acc0d@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <21944b18-ac36-4acd-9d36-cc05579acc0d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 11:13 PM, Daniel del Castillo wrote:
> Sorry, I thought it was okay as they were part of the same task. Will do.

No worries, no need to apologize -- thanks for your contribution!
> Thanks for the other comments as well, I'll apply them and send a new
> version soon.

