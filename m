Return-Path: <linux-kernel+bounces-738920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D3BB0BF0B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347B4189405C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EC8288C96;
	Mon, 21 Jul 2025 08:35:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8261287243
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086921; cv=none; b=r116TTiJKH/6FXHokjCEuXbyZ3jaf1Fy8t1KfYT0JSFF4kitMzF5FBE85zlZvlMzcuNO7BRluQrSvWs7/1DWUB6aVBu0UIyCg7skDKJRI9ApuWWEuFaX1F35jBtpOW3FEwWWFCafcUU1jGrtq7EC0whWvqKFOv9Jx7GXL9v0qas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086921; c=relaxed/simple;
	bh=kNaWZiT/2RT/JkxzOgHuM/tA1wRBJ1h7b4/6SrP59L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0FgfqVvTrGqkz1QYKIhGLg5pRQF4JLimjggW8EReJnaxPy+LZU83FbNppmW3xEm2pQgjC+PFqNc3oqyIWssrd94gEYD9YXP9faDzMNis7+t2BYLw2pwfhYFvFwcsIJKCJOG8/EIWPGA5ugCA4B48hs4ExbPDo39N1MBrXuCDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62427153B;
	Mon, 21 Jul 2025 01:35:13 -0700 (PDT)
Received: from [10.57.30.25] (unknown [10.57.30.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AA0A3F66E;
	Mon, 21 Jul 2025 01:35:18 -0700 (PDT)
Message-ID: <371beefd-2f6f-491b-8fdc-5fed44c9327c@arm.com>
Date: Mon, 21 Jul 2025 09:35:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] coresight: Replace scnprintf() with sysfs_emit() in
 sysfs show functions
Content-Language: en-GB
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
 alexander.shishkin@linux.intel.com, mike.leach@linaro.org
Cc: mcoquelin.stm32@gmail.com, james.clark@linaro.org,
 alexandre.torgue@foss.st.com, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250719224547.2389642-1-chelsyratnawat2001@gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250719224547.2389642-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2025 23:45, Chelsy Ratnawat wrote:
> Documentation/filesystems/sysfs.rst mentions that show() should only
> use sysfs_emit() or sysfs_emit_at() when formating the value to be
> returned to user space. So replace scnprintf() with sysfs_emit().
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
> Changes in v4:
> - Applied changes to 5  more files to replace sprintf/scnprintf with
>    sysfs_emit() and sysfs_emit_at()


Please could you rebase this on coresight tree "next" branch ? There
are conflicts.


https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=next

Suzuki


