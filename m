Return-Path: <linux-kernel+bounces-767169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE704B24FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BCA5A0400
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9F28B7D7;
	Wed, 13 Aug 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpB4CbJ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DE281368;
	Wed, 13 Aug 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102704; cv=none; b=JoZaMKhHRATK9G1/Y0XW5q71M7Ww0Dw3gXqe8lMfQnJqWjz7k2tilmQxS+DAxZyGnG3EvpxVV/OUHRn1b8FqUy2+hf9WjuvOSub7572s5PDqOxoeaeclwjNh20lX3nXGADKkUR9fX/bH3T033OHxMUH3RBcZqkRJen/ejdjcsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102704; c=relaxed/simple;
	bh=r681/UoqQ77m/rJhh7Rim7rhRtBmAr5NpXSkVeeo1Fw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZgagrZEsQdi4ydLeQU2VVLaij+WSBYOVdP2XteBuf2zZnn4A6DedlPiVPDYFWfjjciRAZyKoJ18yzrL4KidRZN1qwNd0Qj0eAj+bfPSc4PhfmnOLcIkuZ2RT9Zym78R6XMKUv6oQZNYCuov+CC7EjoGKsHNovWEuGHgWiLrdDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpB4CbJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8787DC4CEEB;
	Wed, 13 Aug 2025 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755102703;
	bh=r681/UoqQ77m/rJhh7Rim7rhRtBmAr5NpXSkVeeo1Fw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IpB4CbJ7gK0ezAOWJVESoy62k5C58j4Ml0ESZxa07gHhycK+BOQOvOQ1hDfGf9EYU
	 pWK7b6BeDvQQz8X9/3s9SQN4px4u24wmiv1Nfm0I4pIvpTPsr/vIvVAD28edA3QbNg
	 +hjODPTOvZO5+9PsHmPujpIAj1EXjo7x0zRNFZKl0O9iBHSfx+kB5cHukCp3pEwidT
	 4CSrlvZhJu7DLUHn91oTEeF8OyociqpQpQDWwfK/Kf934Vvokhz0k35wj3jXIIYUIZ
	 U1kojyydubopD6Tfy8tkDyJjzi6Dfkly7DgdksS909FVdQQByeBz2fpYArCPd7tGB5
	 xJRTaJW78fyxQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:31:38 +0200
Message-Id: <DC1FZCZFDPV6.2TODOFP4YKJQR@kernel.org>
Subject: Re: "Re: [PATCH 2/7] rust: gpu: update ARef and AlwaysRefCounted
 imports from sync::aref"
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
To: "Shankari Anand" <shankari.ak0208@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <DBQYD7G5SOZA.2MSKKQWXTPCBB@kernel.org>
 <20250813142814.31576-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250813142814.31576-1-shankari.ak0208@gmail.com>

On Wed Aug 13, 2025 at 4:28 PM CEST, Shankari Anand wrote:
>  This particular patch in the series is restricted to inclusion of only g=
pu driver files.
>  Can this be picked up separately or should I be merging it with any othe=
r driver?

This specific one is fine, I'll pick it up soon.

