Return-Path: <linux-kernel+bounces-739631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C7B0C8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615E37A596F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A0A28A71D;
	Mon, 21 Jul 2025 16:32:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB526ACC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115530; cv=none; b=AmoeEqQl8P6XZuCYNybW8AxXOGkHz1VMMNhRq8PEsuzGjbj7orAaFLumoHB1VKjJHHnWQjGx59THc2nPYYc4jMbpoXoKiOFBO9gamftmu32wRLnQUmWko8tJHVFvCVg8HZ7KVQdyDpy5fYrMlJ8OJm2p+yBnG3vNvNFPAdu6v74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115530; c=relaxed/simple;
	bh=kvgRpImLW/WY6NBgrfY6eeV0OLhSsKBmPOT+2MVTDxI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/8gNsnfb9nU/XEq+3HORnI8bVc4lUkx9OFbKX9yqkMFgur/pCtpRDi4O0EnaDBudhyAgpKvrWxkAImb297DkYR459q5UGu8Ko09i2huf/mQYxmjIdQy1QPmn9i+0kb8aNA55yYuXWx79lU4y4B2urZQSEDKxiStQ8gVhnRnZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bm5Rh62Bqz6L4ws;
	Tue, 22 Jul 2025 00:28:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 914F51402EC;
	Tue, 22 Jul 2025 00:32:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Jul
 2025 18:32:03 +0200
Date: Mon, 21 Jul 2025 17:32:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Rob Herring" <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>, Rohit
 Mathew <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	"Zeng Heng" <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
	"Carl Worth" <carl@os.amperecomputing.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <lcherian@marvell.com>,
	<bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, Koba Ko
	<kobak@nvidia.com>
Subject: Re: [RFC PATCH 12/36] platform: arm64: Move ec devices to an ec
 subdirectory
Message-ID: <20250721173202.00002b51@huawei.com>
In-Reply-To: <20250711183648.30766-13-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
	<20250711183648.30766-13-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 18:36:24 +0000
James Morse <james.morse@arm.com> wrote:

> commit 363c8aea257 "platform: Add ARM64 platform directory" added a
> subdirectory for arm64 platform devices, but claims that all such
> devices must be 'EC like'.
>=20
> The arm64 MPAM driver manages an MMIO interface that appears in memory
> controllers, caches, IOMMU and connection points on the interconnect.
> It doesn't fit into any existing subsystem.
>=20
> It would be convenient to use this subdirectory for drivers for other
> arm64 platform devices which aren't closely coupled to the architecture
> code and don't fit into any existing subsystem.
>=20
> Move the existing code and maintainer entries to be under
> drivers/platform/arm64/ec. The MPAM driver will be added under
> drivers/platform/arm64/mpam.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>


>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4bac4ea21b64..bea01d413666 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3549,15 +3549,15 @@ S:	Maintained
>  F:	arch/arm64/boot/Makefile
>  F:	scripts/make_fit.py
> =20
> -ARM64 PLATFORM DRIVERS
> -M:	Hans de Goede <hansg@kernel.org>
> +ARM64 EC PLATFORM DRIVERS
> +M:	Hans de Goede <hdegoede@redhat.com>

Smells like a rebase error as Hans' email address chagned
to the kernel.org one in the 6.16 cycle.

>  M:	Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>  R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  Q:	https://patchwork.kernel.org/project/platform-driver-x86/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-driv=
ers-x86.git
> -F:	drivers/platform/arm64/
> +F:	drivers/platform/arm64/ec

Other than that looks sensible to me but obviously needs tags from Hans or =
Ilpo.

Jonathan



