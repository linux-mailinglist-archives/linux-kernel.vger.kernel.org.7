Return-Path: <linux-kernel+bounces-625710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED0AA1BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 22:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237041B67FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 20:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8426156A;
	Tue, 29 Apr 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGo59lmS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2AD25A2DE;
	Tue, 29 Apr 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957257; cv=none; b=DQ32oRozSTFx1BrNejNkP0y4D55RR4lw8vIXrL2XXQbBKn1qs9IfP8FFfv10+OjsjgmB/8S2nHp+/P7YdFQGD6EZZFS8rzKy08n7hXJCS3ruMFT2VOvGJLRHc+Mw1cdd3+1wZwxxCFsdejPFnL9VXamgG+Z4Dq5hF2tsS3EOtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957257; c=relaxed/simple;
	bh=HxUcW+K0ownBOPm+klHuYmAbEOpz4/+IawPZ+9mnLZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t8JeCTAZNJkLnqxT+A8S50z47aMjfKZuo4vETCSmyGRAjPtIP7sPxw3wOl9WiSE0jk808XgzQc+8g0FX3kyT0rUTwGk8ntxj/FqRrLmzMBcMJ4p/dbYYit9RJHYLNdEzIRKfRlldeIF3TNco04R5q68fHvIWLj7KkGIxOlApmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGo59lmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C70C4CEE9;
	Tue, 29 Apr 2025 20:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745957256;
	bh=HxUcW+K0ownBOPm+klHuYmAbEOpz4/+IawPZ+9mnLZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OGo59lmS/VpGDV10MIvU8dVCgxetaeWKSLqkFS6tcac988lbdqZzIwPnctNV0TdXC
	 rIZHXHmPVjbSDMhgaqQm+86rdQ7PNyuJIBqf0VrCWzBED04yVQyuKOJjUvp+bIg6hl
	 lNgfQQWqFW3J6p9sZiawKs31VYfDs4wcldImJ1oQjjcn0P/0ENhpeIQfWCJeQycl2q
	 Db76fummc3mfdmnOxWVE7B+PKhYbEr1Y3fiPh6WJrxcWlNP60hXoJbQbduAwxobTfa
	 /dFkON3IuixkbrpdrNsrrpT54wHOA4kncp7PPZuAMDLu1dAKPXAHef5coThmp27DDX
	 jL/tADZAzZB8g==
From: Srinivas Kandagatla <srini@kernel.org>
To: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>, 
 Kalyani Akula <kalyani.akula@amd.com>, Michal Simek <michal.simek@amd.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Peter Korsgaard <peter@korsgaard.com>
Cc: stable@vger.kernel.org, Kalyani Akula <Kalyani.akula@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250422142112.2364822-1-peter@korsgaard.com>
References: <20250422142112.2364822-1-peter@korsgaard.com>
Subject: Re: [PATCH v2] nvmem: zynqmp_nvmem: unbreak driver after cleanup
Message-Id: <174595725468.31828.5794331995738765114.b4-ty@kernel.org>
Date: Tue, 29 Apr 2025 21:07:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 22 Apr 2025 16:21:12 +0200, Peter Korsgaard wrote:
> Commit 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
> changed the driver to expect the device pointer to be passed as the
> "context", but in nvmem the context parameter comes from nvmem_config.priv
> which is never set - Leading to null pointer exceptions when the device is
> accessed.
> 
> 
> [...]

Applied, thanks!

[1/1] nvmem: zynqmp_nvmem: unbreak driver after cleanup
      commit: c708bbd57d158d9f20c2fcea5bcb6e0afac77bef

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


