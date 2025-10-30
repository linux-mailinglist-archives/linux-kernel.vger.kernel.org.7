Return-Path: <linux-kernel+bounces-878140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F6C1FE05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B58189514D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F356130ACEC;
	Thu, 30 Oct 2025 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J416WPUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9302EC088
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824899; cv=none; b=O9m6ZvY3EQclgDPgGuTWntRj+498ozW9qErtk/l9gLmVieG3boB1/kn9P175MkfiXBfWvv7lEnGB4Ckz9jNTZ6HAI/dONP870cFwkL0SC7mt5w/wPttBljVpRqSS0Qy+S6GSVjaHX5uBzqphaz5sKaYldQzfTRpHFowFNZ0xBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824899; c=relaxed/simple;
	bh=wEoN4xXDkJ7oWH5TwOIVyXDFSBAJ1Y5zviOAiaE7DBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ugv8mnYe2FlqZSQ3Hyp5V3dlBQRA/LN4yCHBNabW9sx0PQNlgwtgU9M/4fHdjdzMllV28Eu/vr34tN8GcYcmrQu+LOgq48oI10xn5RJO9lWrCt0um+6vdKRQtflTOyQmt9hJO7jddM+94+0Wrr6jfXFENakD7fugOJYDUejewCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J416WPUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC51C4CEF1;
	Thu, 30 Oct 2025 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761824898;
	bh=wEoN4xXDkJ7oWH5TwOIVyXDFSBAJ1Y5zviOAiaE7DBI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=J416WPUzPttD4gLUOov8h5iYyOXWoU8bm3bbycgjg0hjBMGvb1EJYxrayoPUDbVHh
	 Mlcn7EwQE4guurg/12N0c22yNtGNm1vr/bmOMxVnMFGoAJtoP0pYp2CqpYtpThnwqE
	 GQySjlIESQyP3g3npSN+g+oaqjmObKEZvtGe/xHJIEysE6cGIm4qZfTCe8sZN3+34w
	 Kr/1v4aDNfehK6v2tNV+jrd42U0DLy3ThJqHtjICbSG7PqxjaJUe0X2IU4SDPUAZdD
	 WTLBCPtdUHvYZWY/UPX1lPSY4XH9P2SI621sIRTyTiy92v75JDIXES/B9sLK9BwC0k
	 0Bb/rhOYbr+jg==
Message-ID: <4e60eee9-5afb-4c97-8c05-96ab39da62b1@kernel.org>
Date: Thu, 30 Oct 2025 06:48:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] firmware: stratix10-svc: fix bug in saving
 controller data
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 linux-kernel@vger.kernel.org, Ang Tien Sung <tiensung.ang@altera.com>
References: <cover.1761740742.git.khairul.anuar.romli@altera.com>
 <b28ba544224536391e3e7e2c1aac9c31b5b01216.1761740742.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <b28ba544224536391e3e7e2c1aac9c31b5b01216.1761740742.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/25 07:31, Khairul Anuar Romli wrote:
> Fix the incorrect usage of platform_set_drvdata and dev_set_drvdata. They
> both are of the same data and overrides each other. This resulted in the
> rmmod of the svc driver to fail and throw a kernel panic for kthread_stop
> and fifo free.
> 
> Fixes: bf0e5bf68a20 ("firmware: stratix10-svc: extend svc to support new RSU features")
> cc: stable@vger.kernel.org # 6.6+

Please read the stable kernel rules documentation for future submissions:

stable-kernel-rules.rst


> Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v2:
> 	- Add CC that was missed in the v1 and original patch from 2023
> ---
>   drivers/firmware/stratix10-svc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 

This patch does not apply cleanly on v6.18-rc1. Please rebase and resubmit.

Thanks,
Dinh

