Return-Path: <linux-kernel+bounces-828533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130FDB94D18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9254E7B2639
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F40315D42;
	Tue, 23 Sep 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ5OR6Dn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071730FC09
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613176; cv=none; b=mAsOQcC2vkjMV7oSVsJjyquZxVlI06Lv0XbQfpeSfKpfkj/jE1yvtUG8qGry3jJ890G35+WY/2gIuAtZ70CuSd6GNOClq7x9xkH6aX+v4eUerueazzPupKT2OGw5GT64AhS48yzNw8ENnGOru/9irUQZyIKvaTFQVEN2HAc13oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613176; c=relaxed/simple;
	bh=4LD+9tlazlAYecabznNJ1WYuNPYD1yZ/lQfKVw3iKtk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pXG0IYiDHFUusykfC/y/w4GFbWFaYpG/ftid9Nc9KweJqHEEdjgMUwpowui1LdiZ/ubd5cSjzsz6XItCP+D8+QA+G/6xnp2W+x16DMwtmYSQAQj4XazTHNoD4TTwWUuGXNo0qSX+ChuT3qI0SXZFspUFHm01UQCp7f5Du9Pe4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ5OR6Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B4AC4CEF5;
	Tue, 23 Sep 2025 07:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758613176;
	bh=4LD+9tlazlAYecabznNJ1WYuNPYD1yZ/lQfKVw3iKtk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lJ5OR6Dnb7V7/Myws4odvsdC0WnZLsuS+NLc54W+QKkYmDIuuU2QgwZUnrnONeQRz
	 TMpZ9GQedfHihALvGkmrufqvPE4UV/h8ZaJGn4GYhgQZ/0tQLWvAVDSqdXXc70B1Ex
	 qfpUIQ6YnyGSSW4+sHezv4gMitLMUAorPvEe2lLNTOTzHndy482sAEmjpA0mHW+2Xf
	 NAD6Y32/IALEUHVfroobArKsgTtEqeQbcbKBF4nogRcZRxsZwd5bp8QhsrTKxBhn/d
	 2al5yvNGTvwUWEuzrTGUaEHwtvvubnqWc9H+JxsVsrfSCQnwRfFGw/CJn2AxCIVX8s
	 U68DX1hrQlgmA==
Message-ID: <f6f2c45d-39ae-4065-9b14-f0c94a41965d@kernel.org>
Date: Tue, 23 Sep 2025 15:39:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v5] erofs: Add support for FS_IOC_GETFSLABEL
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org
References: <20250923070112.16644-1-liubo03@inspur.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250923070112.16644-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 15:01, Bo Liu wrote:
> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> 
> Add support for reading to the erofs volume label from the
> FS_IOC_GETFSLABEL ioctls.
> 
> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

