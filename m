Return-Path: <linux-kernel+bounces-801097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E9CB43FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78E37BD9DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF030507F;
	Thu,  4 Sep 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJhgkvxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C241302CA3;
	Thu,  4 Sep 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997992; cv=none; b=P3cOSpsOweDC0t7L1OFQKQCtPPeS+CVWhf0kUI8QmyDh4LNmEHkU/JjdGInxmKJXJqD9HrssFeIxQ3LT67yypCenZYFPzCDtJiOgh6igawEokWkPNVJ8ypox0l7mL1/bdolUaPzGQlAR0xlz2GiJNFMYCbqDP6xMK3I1I+mQhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997992; c=relaxed/simple;
	bh=udHWoPxWg1mjFfCL+w10AsPqaLRXEEO6ytemFRxaR6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dt4+LuvUFKl0DS98shVPPo4SaXF10U9XG9HfCzkV55hF4HYqJOpQd6DkIW/c8kqjZGPod8Qf2Zc9pDtvwR/cp7sEIxAWHGjqe5bamgAnq7LYFxQDmuJT+mFRfyVOkIxfTqryja8WdW2xtKTIbNr4nsno5DW5mNCIoWdAaDdBF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJhgkvxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AC5C4CEF0;
	Thu,  4 Sep 2025 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756997991;
	bh=udHWoPxWg1mjFfCL+w10AsPqaLRXEEO6ytemFRxaR6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YJhgkvxViF9CafbblXNdKIHdDbdWMESCBoHwe5V61jXTyX2ujXPH1iB9PKfHJGokq
	 82BFECZwl0EYcMMNO+1VQtgrXG+CApP0Z6mRXrNE8MCFQXikLuGCf8LCw7gMB6o9/Y
	 rpEA/bfYlB+b36+mOXyiK9Gxi0ajFgupDeT7YPDx5rB8uydKFED2L21muNrwHHNVYj
	 HYs1HLX8ZQoLEdiV0+rODGOpjdgMzoiDer93/ZNBjwtm2wd+z/J3WjLEYIZI6YU2vz
	 drWD2MjU7MFnQz4L5lyX3GHtk/YvgjCctGFJOk/LNDltK0ub9wd3Mz9Jf3/hehchR3
	 aw63TWxAZr28A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Gleixner <tglx@linutronix.de>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Lyude Paul <lyude@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20250820203704.731588-1-lyude@redhat.com>
References: <20250820203704.731588-1-lyude@redhat.com>
Subject: Re: [PATCH v3 0/2] Arithmetic ops for Instant/Delta
Message-Id: <175699797762.553433.9071557042089300894.b4-ty@kernel.org>
Date: Thu, 04 Sep 2025 16:59:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Wed, 20 Aug 2025 16:26:42 -0400, Lyude Paul wrote:
> When rebasing RVKMS against my hrtimer additions, which themselves were
> rebased against Fujita's recent work for introducing Instant/Delta, I
> needed to reintroduce the ability to perform some of the arithmetic that
> rvkms uses for vblank emulation - so, this commit introduces such
> arithmetic.
> 
> Example usage:
>   https://gitlab.freedesktop.org/lyudess/linux/-/blob/rvkms-slim/drivers/gpu/drm/rvkms/crtc.rs?ref_type=heads#L167
> 
> [...]

Applied, thanks!

[1/2] rust: time: Implement Add<Delta>/Sub<Delta> for Instant
      commit: 22b65a40574e597e1919ca22cc3535c2b541f764
[2/2] rust: time: Implement basic arithmetic operations for Delta
      commit: 4521438fb076f8a6a52f45b0e508f6ef10ac0c49

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



