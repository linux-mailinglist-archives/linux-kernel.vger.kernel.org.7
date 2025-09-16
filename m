Return-Path: <linux-kernel+bounces-819173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A35B59C71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78605828E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35E526B0B3;
	Tue, 16 Sep 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCHPOq5X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5F33EB06
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037714; cv=none; b=sRrXp/Dv0kifLLspEacZ1W0y/S9wVm819l4Lv/2tF3fkSysiai8GuTqtz7df8uGnViUmK65TsIzEKeOAX6pfhtCNu/eUYJXxsY819s3sGZLBvz/gSr/AHO3XOF9gx6cWosPxhrmIgHz4ftVIymecM8NQmC3fy2BJPaUV4/tISBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037714; c=relaxed/simple;
	bh=j4RDcnYETHvKyCD8K09Se2N75xAQidxm7TYCm142YD8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fNcAgSlA4x5Q9o6LRjWIcv6DW3CU3GdQBLXiES1flL4JLYuoxVAhcpV1G++6fPXoSbpl98U8FUEWD4d8A4jvmjY7gfLFuxm6U6RMyq9f9j5mh2VNzNehV+BfyYcgP7yMA34U4g8/EdM+Lqk8/llzc8l0CFTDcLP9+RPeIHO86fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCHPOq5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C9C4CEEB;
	Tue, 16 Sep 2025 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758037713;
	bh=j4RDcnYETHvKyCD8K09Se2N75xAQidxm7TYCm142YD8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iCHPOq5XM2td4ttqZQ9o5gw33KT4zIioa4yGEQE3NuQiHm2fBNPYlDCMZSsmfF8fR
	 Kj7AtHQQ3B02d2snfWSR7r5VZLgriACRYit2U2yQt8UbAYozqFUlnP6jLOw8cTBtLG
	 VWdcJtj9qA/HtecOj3ixnZQbfbIYHX4oZsGbpKvbTImShR16IftrXFE/BbaxyWYuaC
	 XwiEQVjxOjPZf/5FFbG+1pGz7RDKHQYfGzvjQwglprqTiOslkpP1EOBuLo8qrXFq8J
	 oYSlHYYI4qTwkG9SJ2/w39GI0zkvefxeJ30Sgdparm/3ytE8qz43zQOt8ZhFKOuHEb
	 hQ5DzLr68d3og==
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20250915112936.10696-1-ilpo.jarvinen@linux.intel.com>
References: <20250915112936.10696-1-ilpo.jarvinen@linux.intel.com>
Subject: Re: (subset) [PATCH 1/1] mfd: intel-lpss: Add Intel Wildcat Lake
 LPSS PCI IDs
Message-Id: <175803771246.3880695.1069443867843852902.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 16:48:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 15 Sep 2025 14:29:36 +0300, Ilpo Järvinen wrote:
> Add Intel Wildcat Lake PCI IDs.
> 
> 

Applied, thanks!

[1/1] mfd: intel-lpss: Add Intel Wildcat Lake LPSS PCI IDs
      commit: 87d6a21292bbc5f871c46b90416051e1e97f5f82

--
Lee Jones [李琼斯]


