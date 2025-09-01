Return-Path: <linux-kernel+bounces-793923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A73B3DA3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9401659BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16770253F2A;
	Mon,  1 Sep 2025 06:49:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30423BD1D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709358; cv=none; b=qAkFoJ9QhdfgAE8dcZ7E0guGiTwnUMVU8DQg5xj2QPOqnfjq3GCgCZwEtJqrcdG7PFUvVZl2e193B5LzGbCv2tsn6H8DQIVhgo7Tk80YrGoM0BiejVMm0mkVFXJH3U5UXiN0zIKvbfAV33ooY7GEmH1c1KdlVoLG2O3PvUmfiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709358; c=relaxed/simple;
	bh=eJcfF9rtOKXBk9WfKeHc1GpkZq75VxEhRbYEx/p6oSM=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nMCuCqBR1itbcKPFjrWV5ItSlwW+ZfAsY6gJx7aiiXpEddBUVjk58vZoLt5Hi2ouvUpzamzLn7fqMVIJ9KEMAFBHVdkTYJikWIj+0Q7hYOcE/skYy2TWPqVw+3xXGUrQ+LI6kqYgi/1fyGz2c2F+cM/nhRGVVQwcLLRCqxsxH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cFfXb5p3rz1R97H;
	Mon,  1 Sep 2025 14:46:07 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 42879140109;
	Mon,  1 Sep 2025 14:49:06 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 14:49:06 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 14:49:05 +0800
CC: <yangyicong@hisilicon.com>, <robin.murphy@arm.com>,
	<Jonathan.Cameron@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@h-partners.com>, <linuxarm@huawei.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v3 9/9] Documentation: hisi-pmu: Add introduction to
 HiSilicon V3 PMU
To: Yushan Wang <wangyushan12@huawei.com>, <will@kernel.org>,
	<mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250829101427.2557899-1-wangyushan12@huawei.com>
 <20250829101427.2557899-10-wangyushan12@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <ebf838bd-93ec-15ea-bc98-d3afc5629256@huawei.com>
Date: Mon, 1 Sep 2025 14:49:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250829101427.2557899-10-wangyushan12@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/8/29 18:14, Yushan Wang wrote:
> Some of HiSilicon V3 PMU hardware is divided into parts to fulfill the
> job of monitoring specific parts of a device.  Add description on that
> as well as the newly added ext option for L3C PMU.
> 
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  Documentation/admin-guide/perf/hisi-pmu.rst | 33 +++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
> index a307bce2f5c5..b78381a1e5e9 100644
> --- a/Documentation/admin-guide/perf/hisi-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pmu.rst
> @@ -113,6 +113,39 @@ uring channel. It is 2 bits. Some important codes are as follows:
>  - 2'b00: default value, count the events which sent to the both uring and
>    uring_ext channel;
>  
> +For HiSilicon uncore PMU v3 whose identifier is 0x40, some uncore PMUs are
> +further divided into parts for finer granularity of tracing, each part has its
> +own dedicated PMU, and all such PMUs together cover the monitoring job of events
> +on particular uncore device. Such PMUs are described in sysfs with name format
> +slightly changed::
> +
> +/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}_{Z}/ddrc{Y}_{Z}/noc{Y}_{Z}>
> +
> +Z is the sub-id, indicating different PMUs for part of hardware device.
> +
> +Usage of most PMUs with different sub-ids are identical. Specially, L3C PMU
> +provides ``ext`` option to allow exploration of even finer granual statistics
> +of L3C PMU.  L3C PMU driver uses that as hint of termination when delivering
> +perf command to hardware:
> +
> +- ext=0: Default, could be used with event names.
> +- ext=1 and ext=2: Must be used with event codes, event names are not supported.
> +
> +An example of perf command could be::
> +
> +  $# perf stat -a -e hisi_sccl0_l3c1_0/rd_spipe/ sleep 5
> +
> +or::
> +
> +  $# perf stat -a -e hisi_sccl0_l3c1_0/event=0x1,ext=1/ sleep 5
> +
> +As above, ``hisi_sccl0_l3c1_0`` locates PMU of Super CPU CLuster 0, L3 cache 1
> +pipe0.
> +
> +First command locates the first part of L3C since ``ext=0`` is implied by
> +default. Second command issues the counting on another part of L3C with the
> +event ``0x1``.
> +
>  Users could configure IDs to count data come from specific CCL/ICL, by setting
>  srcid_cmd & srcid_msk, and data desitined for specific CCL/ICL by setting
>  tgtid_cmd & tgtid_msk. A set bit in srcid_msk/tgtid_msk means the PMU will not
> 

