Return-Path: <linux-kernel+bounces-729126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4220FB03214
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787E4189D31A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9C27FD6E;
	Sun, 13 Jul 2025 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7hUGwAQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC026AD9
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752424060; cv=none; b=qPtHZ/ceTUET47fXUtjPrDZPzohp8rOKSyQ3+6wExpY/hDLp4OtYYroOSEsgUp/5iWFfogQWn/RZa5lZccvQuXEEtQcoO4N9j1/Jb8/BrNSqGral4t4rtw/PI7jV/ut5+S3UMurdk8V+RMXxkRlkMUih03SM7IVPVjtsLyiKZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752424060; c=relaxed/simple;
	bh=os7v1CoGQxJnQ+61L30sCkA48/y+wIkRcL+WdNgUE2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KERuE+vM3VXsMGrVQArjAC7NGD6gg6yBEvGcO5mHu1V/uAqYy4PA9s7LnTugjXPN+MmUxlREklYaR2GSkOXhk16W5wRYAJ2mTI0zkDwIeFrseeo5g0a3OEEzpw+eJaPNBSR7TUWQG6P3AaB31bjeBd6WVwcXju70JT4/Gve8uXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7hUGwAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CD6C4CEE3;
	Sun, 13 Jul 2025 16:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752424059;
	bh=os7v1CoGQxJnQ+61L30sCkA48/y+wIkRcL+WdNgUE2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I7hUGwAQ0aw2rJZSbXsemST2c73iBGjy9KFwZLcz2MUTMNqDO83PmoEvO7Me/DsWv
	 q+3ngqUR7q7ytHY5Ep5lKshzJKaz68BGGlr+ch0YAaGGJvI6yIrLYCn/pxG3EyS0ET
	 tV4zRluMnf75avHqkJp69JcTh/+uWac30GeutgLhczSsoOG+CuwRip+jaBIF13xgcT
	 KyKQ9KwWU+qZYL0xEkLkIVPCWWDXqcg1NouSEApPiYie5W/T8Knha/C9jMzlQEKS1W
	 wYykANdPHZyn3Agn3Xzeb6ZBBMzDMwRSAJ5zvKs042xBaSTrbm5yfPfDXvi0seMyMl
	 nTv+jFHqq0xfw==
Date: Sun, 13 Jul 2025 17:27:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: <will@kernel.org>, <mark.rutland@arm.com>, <yangyicong@hisilicon.com>,
 <hejunhao3@huawei.com>, <jonathan.cameron@huawei.com>,
 <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
 <wangyushan12@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 0/8] General updates and two new drivers for
 HiSilicon Uncore PMU
Message-ID: <20250713172732.13100182@jic23-huawei>
In-Reply-To: <c5a99a5a-20d9-ef07-1cc3-cb025f446619@huawei.com>
References: <20250619125557.57372-1-yangyicong@huawei.com>
	<c5a99a5a-20d9-ef07-1cc3-cb025f446619@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 20:36:11 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> Hi Will and Mark,
> 
> just want to make sure the mail's not lost somehow, it's been skipped for the last cycle and
> no further comment since v2.

Hi Will and Mark,

This one is still outstanding and Yicong mentioned some recent issues with
some Huawei emails being taken out by spam filters.  As such, a quick
ping from an account that shouldn't suffer that fate!

Jonathan

> 
> thanks.
> 
> On 2025/6/19 20:55, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> > 
> > Support new version of DDRC/SLLC PMU identified with updated ACPI HID and
> > register definition. In order to support this, we do a preliminary refactor
> > to initialize device of each version by using driver data of each HID
> > rather than checking the version. This will also make the driver easier to
> > maintain and extend, since only the HID specific information along
> > with the new HID will be added to support the new version without touching
> > the common logic.
> > 
> > Two new Uncore PMU drivers is also added to support the monitoring the
> > events of the system bus (by NoC PMU) and the DVM operations (by MN PMU).
> > 
> > Change since v2:
> > - Rebase on 6.15-rc1, add Jonathan's tag.
> > Link: https://lore.kernel.org/linux-arm-kernel/20250321073846.23507-1-yangyicong@huawei.com/
> > 
> > Change since v1:
> > - Fold patch which extending the struct hisi_pmu_dev_info into its user
> > - Use bit shift rather than bit mask for SLLC PMU registers configuration
> > - Address other comments by Jonathan, thanks
> > Link: https://lore.kernel.org/linux-arm-kernel/20250218092000.41641-1-yangyicong@huawei.com/
> > 
> > Junhao He (6):
> >   drivers/perf: hisi: Simplify the probe process for each DDRC version
> >   drivers/perf: hisi: Add support for HiSilicon DDRC v3 PMU driver
> >   drivers/perf: hisi: Use ACPI driver_data to retrieve SLLC PMU
> >     information
> >   drivers/perf: hisi: Add support for HiSilicon SLLC v3 PMU driver
> >   drivers/perf: hisi: Relax the event number check of v2 PMUs
> >   drivers/perf: hisi: Add support for HiSilicon MN PMU driver
> > 
> > Yicong Yang (2):
> >   drivers/perf: hisi: Support PMUs with no interrupt
> >   drivers/perf: hisi: Add support for HiSilicon NoC PMU
> > 
> >  Documentation/admin-guide/perf/hisi-pmu.rst   |  11 +
> >  drivers/perf/hisilicon/Makefile               |   3 +-
> >  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 354 ++++++++--------
> >  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |   6 +-
> >  drivers/perf/hisilicon/hisi_uncore_mn_pmu.c   | 355 ++++++++++++++++
> >  drivers/perf/hisilicon/hisi_uncore_noc_pmu.c  | 392 ++++++++++++++++++
> >  drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |   2 +-
> >  drivers/perf/hisilicon/hisi_uncore_pmu.c      |  11 +-
> >  drivers/perf/hisilicon/hisi_uncore_pmu.h      |   2 +
> >  drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 220 +++++++---
> >  10 files changed, 1098 insertions(+), 258 deletions(-)
> >  create mode 100644 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c
> >  create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c
> >   
> 


