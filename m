Return-Path: <linux-kernel+bounces-737626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB51B0AE94
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185E416D47C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A842343CF;
	Sat, 19 Jul 2025 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYyrvCOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB991DE3D6;
	Sat, 19 Jul 2025 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752912773; cv=none; b=Bd8zym57b33D2jzESrPwKBWVrFiBIfP+uqcW0856lsOM/9KFiWCj48LDcBqDf9LAFckeWWyezCgHlfRXL2uTj0GL2j+w+mU2pmL4L3VnRSZAywLP5rVsk6AFQCKX+fiUH13+iMeOmD3MVQaE+R+E3pwBfqYMkNOgRjI6pn3maUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752912773; c=relaxed/simple;
	bh=LEEcuXOJk/YHQ2LbF5XiqcQm+O5jC1MZBGi9wHIOdGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYpbu1fkbW/s0EBiPXR3oBiDSR3n6W8VhN6egNTF12ukbJbcWYjlLdHlkjnDBAkpcPO0o39bCVVxIqKiKADFVyjgsiBD/kmf16AEJ/dwXNLOWHcSPIPPOxnE3Ur3boOJTtcykitxawtnU6Sj9NVhbVyofyPC3L57Y+gmaNNG3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYyrvCOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F2DC4CEE3;
	Sat, 19 Jul 2025 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752912773;
	bh=LEEcuXOJk/YHQ2LbF5XiqcQm+O5jC1MZBGi9wHIOdGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYyrvCOzGvwxPYFvNusB/GmcYlDzwiScqnO2ud13BfEpZvLfxmEXdeInRXv7K6925
	 K+Z8Y9pDFQ/DupX0nbDVhHWaP4iTkDG/cqRvD1MMBBZmHTZRmEd2yv5bfYsxqFOeLc
	 uVUsHB9O7KFPl415CKrjQDXUd2lN+NGHDckmgrNU=
Date: Sat, 19 Jul 2025 09:56:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Documentation for Device / Driver infrastructure
Message-ID: <2025071931-manger-earphone-a98d@gregkh>
References: <20250717224806.54763-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717224806.54763-1-dakr@kernel.org>

On Fri, Jul 18, 2025 at 12:45:36AM +0200, Danilo Krummrich wrote:
> This patch series expands the documentation for the generic device and driver
> infrastructure and provides a guideline on how to implement bus and class
> specific devices as well as bus specific driver infrastructure, i.e. bus
> abstractions. It also expands on the existing documentation of device context
> types.

Looks great to me, thanks for writing this all up:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

