Return-Path: <linux-kernel+bounces-753184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9544B17FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7843B7A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4A2367DF;
	Fri,  1 Aug 2025 09:50:08 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6ED233710
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041807; cv=none; b=A7B5ZKfJeCFPTElDS4ei+9WOg1Utj2Ji6ViYx5BmxSHW7NB8ajVjFG8cP1leDizy1iRiUNnAk1uJTWGUOSmcmDskfCn1xawW/XBzE0OyczNhwJZ+GC6CZ+ons1INvruSSC38bC/4WfK+jKgjttqwtt3Sz7U6daHTJS6JieJX0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041807; c=relaxed/simple;
	bh=WXoEQUWn/ZSQUD5EBrYMs/cs+NgD9j41Hc5NZc1EE7E=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JomoyRzj2Lf/zN8VVAyR+SP+5JNqAx7YuoO8cEo9u2RYYlHX1MpHqxSIP93CNuUyhvqLsG1HbcFef0dMXNAqPuSVj0aor/JdIEKZGLTS2au2dDYzjF77ysoCp1ctT2/I44yhfWvmLc9HESzrZ04//Bmj/eHOKFBSu94MvCdDXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bth0D3GsQz2Cfd1;
	Fri,  1 Aug 2025 17:45:48 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id A67871A0174;
	Fri,  1 Aug 2025 17:50:02 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 17:49:57 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 17:49:56 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 8/8] Documentation: hisi-pmu: Add introduction to
 HiSilicon V3 PMU
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yushan Wang
	<wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
 <20250729153823.2026154-9-wangyushan12@huawei.com>
 <20250731134759.00000c74@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <faf78f69-312e-32d1-d0a2-fea908c73218@huawei.com>
Date: Fri, 1 Aug 2025 17:49:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250731134759.00000c74@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/7/31 20:47, Jonathan Cameron wrote:
> On Tue, 29 Jul 2025 23:38:23 +0800
> Yushan Wang <wangyushan12@huawei.com> wrote:
> 
>> Some of HiSilicon V3 PMU hardware is divided into parts to fulfill the
>> job of monitoring specific parts of a device.  Add description on that
>> as well as the newly added ext operand for L3C PMU.
>>
>> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> There is one fixlet hiding in here that maybe could have been done
> as a precursor.  I doubt anyone cares though!
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
>> ---
>>  Documentation/admin-guide/perf/hisi-pmu.rst | 43 +++++++++++++++++++--
>>  1 file changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
>> index 48992a0b8e94..4c7584fe3c1a 100644
>> --- a/Documentation/admin-guide/perf/hisi-pmu.rst
>> +++ b/Documentation/admin-guide/perf/hisi-pmu.rst
>> @@ -12,15 +12,16 @@ The HiSilicon SoC encapsulates multiple CPU and IO dies. Each CPU cluster
>>  called Super CPU cluster (SCCL) and is made up of 6 CCLs. Each SCCL has
>>  two HHAs (0 - 1) and four DDRCs (0 - 3), respectively.
>>  
>> -HiSilicon SoC uncore PMU driver
>> --------------------------------
>> +HiSilicon SoC uncore PMU v1
>> +---------------------------
>>  
>>  Each device PMU has separate registers for event counting, control and
>>  interrupt, and the PMU driver shall register perf PMU drivers like L3C,
>>  HHA and DDRC etc. The available events and configuration options shall
>> -be described in the sysfs, see:
>> +be described in the sysfs, see::
>> +
>> +/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>
>>  
>> -/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>.
> 
> This is fixing existing stuff so maybe should be a separate patch.
> 

maybe it's just a format change (paragraph text to block text) so not worth backporting.
that's why I didn't see any warnings when compile.

thanks.

