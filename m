Return-Path: <linux-kernel+bounces-718368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA66AFA0A7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 17:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0836E7B5682
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 15:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4121BF58;
	Sat,  5 Jul 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0BNoNdK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893A1E5B88;
	Sat,  5 Jul 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751728394; cv=none; b=QHeart0+4WV83641tsZ9iJc6oWRyD1LvSwFxKocOgUmmX5hK/tKV8aVBWDJDYSnDaNjSK1Rh28F9BjkUH05+UshPm1yNokcWnQ93oH2DO7w4gMp2M772NcbkOZz6pSDE/6wJeyVTlKRuCrP9YqXQnwi1t1cJ+RSzIXEnXN4pQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751728394; c=relaxed/simple;
	bh=iZ2GtQJZx8wcOuzHRqZc6ez+U/MUhqkaNbTM8nI5K8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBUhOpapvfg8VXxVpujScVHtK3hmityk64QWoMlabx8mIb9ix/hh69ou6K3U56dzfP/c25Nul596NyI97uEB0JSGJUBOBjIsZL6h5C07epgYH7hTkWaN4DR8hwKzub7XwH/eMVzbKWDww4RMLbufV0sG8SuUDzUN4XU3gIopcoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0BNoNdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12597C4CEE7;
	Sat,  5 Jul 2025 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751728394;
	bh=iZ2GtQJZx8wcOuzHRqZc6ez+U/MUhqkaNbTM8nI5K8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0BNoNdKlrpzY+7eWB4cV+TlCRpYrF2S7csC9hSDpHu4AWhR9AoXhTf7uYiv7C03I
	 X2NTbqP7rJGfCWzWE5flnWf2O/wfFpBF4l3FV+XptJCVRZr/J+mnIMf6rPGP9TGa4X
	 vI7bVJnbbcoAsyRX9qSH/ldNqEUpuFSb0t1Q3oyKTNmLnqqd3wAiBeuiT5pPX75Avy
	 qp/3hJNWaWVRsnlCHiochtWLD0CHy9y31rY9maBx2lYdCOpyypMtqkdEaZRARWfKuX
	 JnojiUSJiqZeEXRWV4rLpWsofUlS8uUIqRa5QorA7sMbDJMsL5WjqPxDhnUNaM9lRC
	 x2AHegm77hvow==
Date: Sat, 5 Jul 2025 17:13:08 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: platform: remove unnecessary import
Message-ID: <aGlBBIbAJ7GguqJX@cassiopeiae>
References: <20250704-cstr-include-platform-v1-1-ff7803ee7a81@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-cstr-include-platform-v1-1-ff7803ee7a81@gmail.com>

On Fri, Jul 04, 2025 at 03:49:54PM -0400, Tamir Duberstein wrote:
> `kernel::str::CStr` is included in the prelude.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to driver-core-testing, thanks!

