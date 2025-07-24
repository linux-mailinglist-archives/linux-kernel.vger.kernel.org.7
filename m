Return-Path: <linux-kernel+bounces-743995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D547B106B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE2B1889293
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5D24A055;
	Thu, 24 Jul 2025 09:34:28 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D724467F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349667; cv=none; b=RYVjDcS3AC+qFrb62lyDBKgx6qWqTyJ23xymqrRLbymdxE6w4ELvNe14KC8EB6NxW26eHTxkZwApVcyiOb3krR6nq2Jvxj0F6rdurGKFaoHgcDjNYhkemIGktrIebiioT1jX6iXnXl2Cy2HBW2/+WU0Jraj0zKKv8M0+dvKtHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349667; c=relaxed/simple;
	bh=KUWtdkVcRRbgZxtiq3n/7NrVKWEWYYU67+SEXcf7u6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iwW9s8qWCpDH/xTIpyMys1tJ1huTsAhv3pcmGyRqGexu45AXWpzO3CC6mzjb5TGA8C0Fm0i95N7SkTqCVemvklfpgk8ZypNg0kSQHYt6hBT+AqoZqy1+3wD0zOgwo30asrvRYiJBXPznU80Q9+9RhZTZJWoeJ0bMBVBjXa2hX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bnm3k4142z2FbNZ;
	Thu, 24 Jul 2025 17:31:46 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id ADCFB140109;
	Thu, 24 Jul 2025 17:34:00 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 17:34:00 +0800
Message-ID: <220164ac-2b5f-48bf-9c72-72dd0588f892@huawei.com>
Date: Thu, 24 Jul 2025 17:33:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools/dma: move dma_map_benchmark from selftests to
 tools/dma
To: Barry Song <21cnbao@gmail.com>
CC: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-2-xiaqinxin@huawei.com>
 <CAGsJ_4x1UHW58SjpGcb0vEBdwLPz5gS4i2CFv-eMKs=KObcG8Q@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4x1UHW58SjpGcb0vEBdwLPz5gS4i2CFv-eMKs=KObcG8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/7/24 17:25:16, Barry Song <21cnbao@gmail.com> wrote:
> On Thu, Jul 24, 2025 at 4:56 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> dma_map_benchmark is a standalone developer tool rather than an
>> automated selftest.  It has no pass/fail criteria, expects manual
>> invocation, and is built as a normal userspace binary.Move it to
>> tools/dma/ and add a minimal, the original selftest.Makefile entry
>> is removed to avoid duplication.
>>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   tools/Makefile                                    | 13 +++++++------
>>   tools/dma/Makefile                                | 15 +++++++++++++++
>>   tools/{testing/selftests => }/dma/config          |  0
>>   .../selftests => }/dma/dma_map_benchmark.c        |  0
>>   tools/testing/selftests/dma/Makefile              |  7 -------
>>   5 files changed, 22 insertions(+), 13 deletions(-)
>>   create mode 100644 tools/dma/Makefile
>>   rename tools/{testing/selftests => }/dma/config (100%)
>>   rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (100%)
>>   delete mode 100644 tools/testing/selftests/dma/Makefile
>>
>> diff --git a/tools/Makefile b/tools/Makefile
>> index c31cbbd12c45..72dc0e936632 100644
>> --- a/tools/Makefile
>> +++ b/tools/Makefile
>> @@ -14,6 +14,7 @@ help:
>>          @echo '  counter                - counter tools'
>>          @echo '  cpupower               - a tool for all things x86 CPU power'
>>          @echo '  debugging              - tools for debugging'
>> +       @echo '  dma                    - dma map benchmark'
> 
> Please make it more general. Right now we only have the DMA map
> benchmark, but we might add more DMA mapping tools in the future.
> For examples: tools for dma mapping
> 
ok,I will fix in next version.>>          @echo '  firewire 
  - the userspace part of nosy, an IEEE-1394 traffic sniffer'
>>          @echo '  firmware               - Firmware tools'
>>          @echo '  freefall               - laptop accelerometer program for disk protection'
>> @@ -69,7 +70,7 @@ acpi: FORCE
>>   cpupower: FORCE
>>          $(call descend,power/$@)
>>
>> -counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
>> +counter dma firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
>>          $(call descend,$@)
>>
>>   bpf/%: FORCE
>> @@ -122,7 +123,7 @@ kvm_stat: FORCE
>>   ynl: FORCE
>>          $(call descend,net/ynl)
>>
>> -all: acpi counter cpupower gpio hv firewire \
>> +all: acpi counter cpupower dma gpio hv firewire \
>>                  perf selftests bootconfig spi turbostat usb \
>>                  virtio mm bpf x86_energy_perf_policy \
>>                  tmon freefall iio objtool kvm_stat wmi \
>> @@ -134,7 +135,7 @@ acpi_install:
>>   cpupower_install:
>>          $(call descend,power/$(@:_install=),install)
>>
>> -counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
>> +counter_install dma_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
>>          $(call descend,$(@:_install=),install)
>>
>>   selftests_install:
>> @@ -164,7 +165,7 @@ kvm_stat_install:
>>   ynl_install:
>>          $(call descend,net/$(@:_install=),install)
>>
>> -install: acpi_install counter_install cpupower_install gpio_install \
>> +install: acpi_install counter_install cpupower_install dma_install gpio_install \
>>                  hv_install firewire_install iio_install \
>>                  perf_install selftests_install turbostat_install usb_install \
>>                  virtio_install mm_install bpf_install x86_energy_perf_policy_install \
>> @@ -178,7 +179,7 @@ acpi_clean:
>>   cpupower_clean:
>>          $(call descend,power/cpupower,clean)
>>
>> -counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
>> +counter_clean dma_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
>>          $(call descend,$(@:_clean=),clean)
>>
>>   libapi_clean:
>> @@ -224,7 +225,7 @@ build_clean:
>>   ynl_clean:
>>          $(call descend,net/$(@:_clean=),clean)
>>
>> -clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
>> +clean: acpi_clean counter_clean cpupower_clean dma_clean hv_clean firewire_clean \
>>                  perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
>>                  mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
>>                  freefall_clean build_clean libbpf_clean libsubcmd_clean \
>> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
>> new file mode 100644
>> index 000000000000..6282eb41e51a
>> --- /dev/null
>> +++ b/tools/dma/Makefile
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +bindir ?= /usr/bin
>> +
>> +CFLAGS += -I../../include -I../../usr/include
>> +
>> +all:
>> +       $(CC) $(CFLAGS) dma_map_benchmark.c -o dma_map_benchmark
>> +
>> +install: all
>> +       install -D dma_map_benchmark $(bindir)/bin/dma_map_benchmark
>> +
>> +clean:
>> +       rm -f dma_map_benchmark
> 
> Please make the Makefile more general. Right now I only have
> dma_map_benchmark, but the Makefile shouldn't be tailored specifically
> for just that one. dma_map_benchmark is one of those targets.
> 
> And I feel $(bindir)/bin/dma_map_benchmark is an incorrect folder.
> 
> Thanks
> Barry
Ok, in next version.I will make it more general.


