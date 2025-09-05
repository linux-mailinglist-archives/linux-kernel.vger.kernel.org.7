Return-Path: <linux-kernel+bounces-802509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F19B452FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017A8540784
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1E28642B;
	Fri,  5 Sep 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azFKGk2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC026B2A5;
	Fri,  5 Sep 2025 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063779; cv=none; b=jKQmRgtktuSaNgqGuSHOZql6XKz3+NzMx077/rK9RFSV9rxHSv/s3iwNKw9LHolnSIL5oR+yTaDK5llQIj9eDMkeTWLBPDIsm1VjEP3YU3lR5Rwvd8JcN4wFdQLY2z/HQVj0Flcy6/bPV1twZhrwP9X/Km936Xn5icphGxBlMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063779; c=relaxed/simple;
	bh=T5HJJYUKQJ9hO7AMse5j6cs8VcPegOThWM/YU5kdugY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V/n8b/uWuo4Y7nNiPB3n5GgreEFjiLNx0LH8Qw1IUJUAo4Spc0VmulzDYQgraMEgSOOI9LMVZsvTi8ORglPRWOYDL5Xgnki43tc9kNLTHox8gMe7oWBHV/cFMNGzA4Q6lBF3LicHsCXo5GgVQgDMZZHJ5dcSJRxQStlX1X48OJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azFKGk2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606E4C4CEF1;
	Fri,  5 Sep 2025 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757063778;
	bh=T5HJJYUKQJ9hO7AMse5j6cs8VcPegOThWM/YU5kdugY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=azFKGk2XclM3SuFP1j+Bp9SiMWrQeHF5cZHsG0OXoIZtgbVsajk3mzq6YjIvO8pTl
	 AkkpeUYHTiRnBenDQhRywb953uUdupgngWQur8LOK9tQNlGyC4ofywvfTl79PG/j6u
	 rS7XCuVjU6OfpIXozrEeXHeOiRAkP+f7PPwNnReJObwS6dcEwEFBJH1nysmsEqOTap
	 5NZxQOAZijYY15qJt9vgkN+CIxINqAEeN48+f9PmPIO39q4P59Fa/IZK+XrdZaMjst
	 VuUtvVEjjaDrt9KSVHbRDls0MFHSue9etSgHcmK/sHiMuSQ1OZXDi2DXReysD/Zwu7
	 lFF4IVFsXK6fg==
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, 
 Marcelo Moreira <marcelomoreira1905@gmail.com>
In-Reply-To: <20250827221830.23032-1-marcelomoreira1905@gmail.com>
References: <20250827221830.23032-1-marcelomoreira1905@gmail.com>
Subject: Re: [PATCH v3] xfs: Replace strncpy with memcpy
Message-Id: <175706377702.443134.17306614735589034340.b4-ty@kernel.org>
Date: Fri, 05 Sep 2025 11:16:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 27 Aug 2025 19:17:07 -0300, Marcelo Moreira wrote:
> The changes modernizes the code by aligning it with current kernel best
> practices. It improves code clarity and consistency, as strncpy is deprecated
> as explained in Documentation/process/deprecated.rst. This change does
> not alter the functionality or introduce any behavioral changes.
> 
> 

Applied to for-next, thanks!

[1/1] xfs: Replace strncpy with memcpy
      commit: 33ddc796ecbd50cd6211aa9e9eddbf4567038b49

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


