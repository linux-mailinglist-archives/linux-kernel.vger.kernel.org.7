Return-Path: <linux-kernel+bounces-727971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6081B021F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BAA47F28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDA52EF9B1;
	Fri, 11 Jul 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSgiCvwI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864824886C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251881; cv=none; b=tERDP/HVicBKESvnl6HTR1w9gJ9pZEZXr/P6v/ssenujLQQZWwgXRpo4m7okRQ9EwUYe+2fD/Gd595MSWZJPrFLkM5fR7p5VLRjNMAImUmVpa8gLwPGoMvwJBHVuUFdSwT7qODbE9gK9AJKVamdh/yQPZej4KOE43YvBUIcrmvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251881; c=relaxed/simple;
	bh=+LhpxaDaFneXMcBCB3s6VxYb18z5vlm0AbN9xklBKIs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QtQ4tJ5Bagv6Iux1e8nW53J3qwgo6N5HBBIW5+BZU8ZIUxaAvWXvrO6Evf6saATOx/LRbGD2UOzV0K++kmTUCjYCQmhZL9Q+t8Xs9nEZHGO95Ja/VXnS7FSLvTmyOJqaymREZvNMt/ksgedF8ITya/tJbyRJAnvyiX3zkznK35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSgiCvwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A686BC4CEEF;
	Fri, 11 Jul 2025 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752251881;
	bh=+LhpxaDaFneXMcBCB3s6VxYb18z5vlm0AbN9xklBKIs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=VSgiCvwIO5XDZ3jS0gjyniMNfP6IrN9z73HPDCaJR47fTVwmLv6kQaDMSLVr5D8Fp
	 ShrkeiPWhL03O438YK6Y7XQVdtK9wc7hKTq3bxYeXVrEv2cXSJBlJ1uqMC+478UdSv
	 xEn4Ihevxx/7LMHG6V2oGQi/jNQN3t+DaQXsCirDoYGV5v3MEljK0dxQwWq9bP39KQ
	 6u9q4chudS0FVImOc0roplubWV3nFvdQz87eJjE0YqnuceV8dV++QyTzdNXzKYlLRD
	 Qt5z1e+6SetYIwQbTd44afdf20iSOAR+geXMTR0TmtaKdoUjBRz4zALeG/LUtxQ0Ng
	 qnan3gomWE7iQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <2025070123-spray-denatured-dda3@gregkh>
References: <2025070123-spray-denatured-dda3@gregkh>
Subject: Re: [PATCH] nvmem: make nvmem_bus_type constant
Message-Id: <175225188043.5833.14661360054468410161.b4-ty@kernel.org>
Date: Fri, 11 Jul 2025 17:38:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 01 Jul 2025 14:02:24 +0200, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the nvmem_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] nvmem: make nvmem_bus_type constant
      commit: 40ae493d572497956b275f755dc80ee3b87a1559

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


