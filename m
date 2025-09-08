Return-Path: <linux-kernel+bounces-805997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 899E8B49087
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82C618872FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8030B512;
	Mon,  8 Sep 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm03CAil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F54A33;
	Mon,  8 Sep 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339816; cv=none; b=WISwztbBNGD+PyGQ6j5FIDc4yKIpKACKovHCkmqHuc0qcwd78y/jRW4oIiczcxub+arlTDIsXGgS5JN/obEeUpmhpXV+yvjBynDdkP3InI6AJEmPBoUU6e/gujsRwEdd9nXFekcZUmmZQrgatH/291vS2/0ZtKHpz7+r+Ms+HQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339816; c=relaxed/simple;
	bh=zRYexB8bj4GScDf3jj7zv+A1nsXQZmKkRKsKp2/PZ0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECslleqNJuPS8GIxy/6gDWvQVnmKOINmXBhx1VsvXcuW3JzSsBy69C2u1kflzBJEoXSaW2Bq2COags5GIjSh6EO93iyE/cjvtP3qlXS1miGkgLtJIVVGMa7b6YjHAF2jSp3naHrGBsvXpzmQEnH7VUQuAcHqxp5erOVkZA1NcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm03CAil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0D1C4CEF1;
	Mon,  8 Sep 2025 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757339816;
	bh=zRYexB8bj4GScDf3jj7zv+A1nsXQZmKkRKsKp2/PZ0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rm03CAill+YlAHZghvUXvTt0aZ2mrKayqNNcLvMJbBWrP4R7/96CvKdE2pAa4cx+6
	 EcSxQrVK85M45C9kKolpiNs5ssqmxyvElBYg0cD2WTBdK46KsnWe+zzJJvnma55BGH
	 pHpOvPMQ3Gky4fyr5hkVE9SfATNJmFdKQNq4v2ZAMQD7bzHZ66ymRUrt1mVK3cikNd
	 xN6i+Fr9XbpxkenYeCmuw9lRr+qpadxRteQhBJuzWRX29eMwKwh9DQeX4eUIG/Ov/R
	 1qnH/GLznu+Xny2IDVayLHxmEPkUBgS8oz7z2qVO13NZWd0pQP1Rd84UKFAvlnZ/jm
	 fhV15UeCd7Q+Q==
Message-ID: <8a41b893-cb4a-4380-a671-f554bd6d0cf3@kernel.org>
Date: Mon, 8 Sep 2025 15:56:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] gpu: nova-core: use Alignment for
 alignment-related operations
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org
References: <20250908-num-v5-0-c0f2f681ea96@nvidia.com>
 <20250908-num-v5-2-c0f2f681ea96@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250908-num-v5-2-c0f2f681ea96@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 3:25 PM, Alexandre Courbot wrote:
> Make use of the newly-available `Alignment` type and remove the
> corresponding TODO item.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>


