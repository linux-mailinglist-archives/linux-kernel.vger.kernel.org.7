Return-Path: <linux-kernel+bounces-812286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DCAB5359A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124751CC3090
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CFF343D8A;
	Thu, 11 Sep 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfmtpwAN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760463431E3;
	Thu, 11 Sep 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601224; cv=none; b=lWeg2XHxsHcWZ898CyV96U6uZfR8dLBAYaLH9sT78Y5xZdT/n1zISMT/eganOOuNb4yYk7K+NtmL4vcqgU8VS6Szh0+mb3MLgpo+aOwuAgAqb2dhjoKN708aMyeJR8iJbMdXgCMPWQ+zBsxJBDUrFA0zoCheYrvBAKCR6eO20ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601224; c=relaxed/simple;
	bh=ev0kH+F4I4aR6tb2Y8LgzgF7MQQFKIRMaQAG06rDm/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s9WmKcMlvziWzroVcnq7QmB7L6yPcttMQ/xRYYvE43HUtbj4AAIAMBgEKxGSAz9eniU5GO2cj8klEePEGDnv6C4/HearLW9v95hgFLrEUKGncSm4Z0agpFj/1M0Ko5v0LNMLeRTSdQH+T7Svq0F6K3x1+RGOHVoSNnNNJjt2Mog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfmtpwAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCE4C4CEF1;
	Thu, 11 Sep 2025 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757601224;
	bh=ev0kH+F4I4aR6tb2Y8LgzgF7MQQFKIRMaQAG06rDm/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GfmtpwANiJZnUEikmMTN/7lHgpKrD+U0DENh1FJRZ2C1uiy1wAzbL4yJdmzIG0tMb
	 hoFe/9JIQ811KSg1nA5wvQ5oa526Kh4yO4dAh73TSBayGh5CVwCQeHkpL5NEsK+P5D
	 lN/nyZIvyakH5mq/o6yWjwXP2x4oOcZxZ3wYQGhvGSm5aVaZ24/OzUEg2OzKpyIjCl
	 +rHJPH4xrouQZZTE6vfaSL0hXMDYIA8IjTgI11zMlqPIykwYc2JK+/MBmlClso7dcI
	 oP6KFl00kHKE72FS4ycn1YK/76uy/MeM5xhpgTUPK2bLF2uXlwc17siUbmwFoRFxJX
	 0owaH42L7xglw==
From: Lee Jones <lee@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>, Lee Jones <lee@kernel.org>, 
 Corey Minyard <minyard@acm.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io, 
 kexybiscuit@aosc.io, wangyao@lemote.com
In-Reply-To: <cover.1756987761.git.zhoubinbin@loongson.cn>
References: <cover.1756987761.git.zhoubinbin@loongson.cn>
Subject: Re: (subset) [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC
 support
Message-Id: <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
Date: Thu, 11 Sep 2025 15:33:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 04 Sep 2025 20:35:04 +0800, Binbin Zhou wrote:
> This patchset introduces the Loongson-2K BMC.
> 
> It is a PCIe device present on servers similar to the Loongson-3 CPUs.
> And it is a multifunctional device (MFD), such as display as a sub-function
> of it.
> 
> For IPMI, according to the existing design, we use software simulation to
> implement the KCS interface registers: Stauts/Command/Data_Out/Data_In.
> 
> [...]

Applied, thanks!

[1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
      commit: 67c2639e1fc1a07b45d216af659c0dd92a370c68
[2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
      commit: 2364ccc827e44064e9763f2ae2d1dcc5f945fdf3

--
Lee Jones [李琼斯]


