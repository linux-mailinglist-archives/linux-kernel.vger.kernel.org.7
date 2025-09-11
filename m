Return-Path: <linux-kernel+bounces-812785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DF1B53CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC2E1CC63D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF2267B89;
	Thu, 11 Sep 2025 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp4fV75B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0154315F;
	Thu, 11 Sep 2025 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620658; cv=none; b=thaMhutmAhioiQONrOo1R8YATtF8BKXyj1YfXoc2e/eLan7pAhi0Svhu3ZEUVfydi99R5C7AL6ISwqPduBp8U2ypDACtXGLSHfLjkRKdzbKakA/FS2ADFN14oGr5hrBjbmpaB8IeDddWTO+GANc+dAXcIRVjgFlmLYAhWDwBM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620658; c=relaxed/simple;
	bh=qvZGaMRgnngt+aIivbrtkO1FDOUULEq9PP1s7JMEYlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLfzthdjy7xkHJA8wpzAZMg0XEWfFZwvC1nKsP9lArf2nvr8W+GLa33ZpBu8ppNtiQ0gt72AiFqQxI6teAccV6JlfUAfk+4HgGSJjlJs2fE/69Z3SKwASZrzYaHJel5I69qFjX2qWOBQqtoEu/Rs1GtnS77DmWXSr/+mxgQvqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp4fV75B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A11C4CEF0;
	Thu, 11 Sep 2025 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757620657;
	bh=qvZGaMRgnngt+aIivbrtkO1FDOUULEq9PP1s7JMEYlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hp4fV75B8HjcDeQUggPW+JahNGtfBa/MjVq8UNViaIbduH/f/firHL1WmgY37x7Hm
	 7gVO81CNHcGyJYKbEP1sp4oUyL9cxHz7Ep28ig63U1TRCm1NALFXVMDwFC2/8TY4ee
	 cZWEORtiTciO35JTUngpZ2gdhveKvUglPifHOCwDSDb4jLTxYe0jw2kujIkMWkZIKb
	 lge80MRl0kuSiDwkl3B0ufydM5Pg7biWZjuCBbtJILfNfVj8i01C5qKUtiOwn1vE+7
	 WQHhxUqh9qoYSjCULBZSEeaRRduFuIK+c0ihHrfYGf1TXbDtZzFylwWiQaW35NN8XN
	 /Zm7HyXKNx+XA==
Message-ID: <5c2b66fc-35c6-485f-b721-c8d57f77262b@kernel.org>
Date: Thu, 11 Sep 2025 21:57:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update the DMA Rust entry
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org, abdiel.janulgue@gmail.com,
 daniel.almeida@collabora.com, robin.murphy@arm.com, a.hindborg@kernel.org,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910094015.11551-1-dakr@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250910094015.11551-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 11:40 AM, Danilo Krummrich wrote:
> Update the DMA Rust maintainers entry in the following two aspects:
> 
>   (1) Change Abdiel's entry to 'Reviewer'.
> 
>   (2) Take patches through the driver-core tree.
> 
> Abdiel won't do any more maintainer work on the DMA (or scatterlist)
> infrastructure, but he'd like to be kept in the loop, hence change is
> entry to 'R:'.
> 
> Analogous to [1], the DMA (and scatterlist) helpers are closely coupled
> with the core device infrastructure and the device lifecycle, hence take
> patches through the driver-core tree by default.
> 
> Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Link: https://lore.kernel.org/r/20250725202840.2251768-1-ojeda@kernel.org [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-linus, thanks!

