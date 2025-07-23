Return-Path: <linux-kernel+bounces-742109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8450B0ED62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7053AD8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1EF27FB1F;
	Wed, 23 Jul 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWj6DVk+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569FC2E3713;
	Wed, 23 Jul 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259817; cv=none; b=INj89tAV5+fy5jVF5mY0nwSEf3ZxIuakglEitnEPmLq2rqGiqJqA4V5gqPrHCiGjfEyq8NUr9BMlCXw5ELExqpJrsfdRc9AsAFYSqQtEt7VIRBYV7y0Q7N2/u+DIQtoT0XrfMqil6lgt3LXrIia0FnWXcFvuTo6mySMklWkz8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259817; c=relaxed/simple;
	bh=ONT5ZX5NCm9shdOwNeXDfmALn7xVdTc26uSm3XLiKZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fUwTsdZAZ3l83PfhOrjCZSktNTI1/7Sk1mEh7CWoEYFiPzjcS4xYFD9rleJIngYIlz54Y9gnEj/yzM6W6uJeNwx67ZIz6h1t+kEgByFfkckxx9Rz3dkdAdaCTLwZQ9BzJJ52OREzZYFQQFF9sHYh5tmcYjMFigspxQtW6PzQgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWj6DVk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E06C4CEE7;
	Wed, 23 Jul 2025 08:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753259816;
	bh=ONT5ZX5NCm9shdOwNeXDfmALn7xVdTc26uSm3XLiKZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VWj6DVk+UC/jdTRQ27pU0nZiTZcI92j2qMOQS+Lv4megEq8UK68JHwIJdvG1m2p77
	 wAzJSEmxNT84oFNhggjDCPZl1i6HuA/svH5JlWVCfvVGyGurILFSKLzSjH46oFWs4r
	 Eh9k+DzDY44uvenI6e8U2UZpz2KZlgd3PNDa1HjTTQWqia+cSQG4t95gpHk3s8R+9+
	 8j2AiES/GKN1CHPiEkNy8oS5owLSqLcNlUsnfhtF0dFiwSRKVq+fWvKcjxeyZXrcMg
	 JCbH9YA1zh6v+Kld35npEZRe//s2I5/QZI3x4Zt24BzwtG53T7187K6vbI5oH7blBq
	 zXn5nqAmfGWyQ==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1753174515-23634-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1753174515-23634-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: add support of multiple
 ports
Message-Id: <175325981286.1215182.5412142337949885984.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 04:36:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 22 Jul 2025 01:55:15 -0700, Konstantin Taranov wrote:
> If the HW indicates support of multiple ports for rdma, create an IB device
> with a port per netdev in the ethernet mana driver.
> 
> CM is only available on port 1, but RC QPs are supported on all
> ports.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/mana_ib: add support of multiple ports
      https://git.kernel.org/rdma/rdma/c/60c9a34df2d83d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


