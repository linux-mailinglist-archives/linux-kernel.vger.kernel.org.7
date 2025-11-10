Return-Path: <linux-kernel+bounces-893482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65050C47831
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3BA1886232
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2040E23F26A;
	Mon, 10 Nov 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="aEij+ROR"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC781DDA24
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788019; cv=none; b=EERlGNM312qutLDcGQOijHuCtYuvRWn0pjqkjinKFOYCncCbl+dmYVINDxcJ0/kZuYQPZ1gci0IN7Vexnm/RnWPGrGumE3AT+k+P9hXwkCeAGw73hM9c+UcFGaESzXzGNiTSZN8AzBt+v8vLdfMBgzD9UIgf5FIW1oyH1GvQYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788019; c=relaxed/simple;
	bh=sO2EwoD/iYNjfdcI7NveTHw7NYQaesuq9uoAsC4fvXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kVpTWK6qsGKqBh4UuMY0TcTnrb0W6iorF7UTYg0oQqBZh7u1MqwVeyDrbRw/Oi/xaT2ONaoY9/YJbdiQ6u0fd+HvzUqEHI6kTet8X+EUZM7Evn8iu1ruvdxDxLsi1sdjvX59Wn6cNMpyKHI8PMUAS5uwkbsnAe2tv5O34gL1Zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=aEij+ROR; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4332381ba9bso34437665ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762788016; x=1763392816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHqCJdsR7z6UGezYu2PLRy2EX3z1OohmVvws0HQYrFQ=;
        b=aEij+RORaRMFW8ONPGQ9MWQ2SIC99rnZNqHsx0buzMifST7WGMnZpAxk9MePnIjJAm
         z0Rk4mmyamAHdCvYKqA8ylg2mfS4aKsJ/rwSfqXDuQ0L1cPLsKVA43GTTTfSCR6xpqbR
         t1HLDL6Y2SkQGWyktQeaC0YOwa84kAizkyOKAsNGvicI9iaH4urPRZrVo8+FsCIDfTiO
         1P38R0DXg/HLhF6roXQbQxV/FuNuIaUEBlPrxshNCjcNbih4K1hSnyAwHuEolAMFRcqY
         rF+bFBf/XV4kL+gxrJKUuUgG59wW59TccqLxz0SO+BqLpBxD2G1LCVgI68AwKcn1YdUB
         bFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788016; x=1763392816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHqCJdsR7z6UGezYu2PLRy2EX3z1OohmVvws0HQYrFQ=;
        b=pkXIzrcLCL/6U/TY2qlFCjA2XqaPkUAzE4dIZdqmeIx7DjndNaDWIjUXh7Q9TZHNzL
         wfkSxED0VyHOMILVtMw6K0r0EhE1laT3KCS5r+UeYCnO/PIUEN7xToOgcLqZ438PyZB7
         EVxQYN5SzPWCq0I2qIOzo4w8VR0DQ7XAIXTzJ5TLIRt8Ip8eO/gGVyNmLKd7hOFm9xVa
         aRymjjRz1Gnncw1WuC7eu+ldxT9Oh48W4RSTttm+JglRDcqOdbM0NpWx2Jffek5a0VRB
         YLz4leIJCFrvSjrRrSIL8lVRkH6USwhP6g3l+X3xCXkp1ZJdvEbTMwoO1hD/aa6kbNs6
         9Rqw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ohn9ojrVzCxnURC0Hdqa1lICmH9l8Lu4oPQGKrf0z9vyDTkisp/Y21OD4ik9gGubbv4gp1lQ1fqIfFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3ANuC1CcFk94ucfo0mDCa4okKt60pVcdCVK3trmUw6V3saJM
	XP7QQ0piNau95SNqzanI/NveaAn163oBOblVjBvuM5cnkHgrzQlpTkMeOwumN/943UU=
X-Gm-Gg: ASbGncsRXUlPqRYgld/v9mKh6/hfVuFErLPaGy52IswIvDFtTKzlJLieTDw37eytEjf
	1fc6EYhDKwQhBrL+9q5UEUwihkxplVN+66c0AJLJWPQ9YWvRr3tmUPFffjvCrAGWP11tZ8Bgi/f
	nzfbl5hNPTx0iIp3OyhGOAro8rdFGHFXB1KsJY9GN/MqWqd9uWig9ESEh1Y3uCuxfsKCrL1PkQf
	OnRJKgdKQhce8H284XG2iK0mF1c8hALAX9F4FrbjxKsO7E8CkETVfrXOsL5EAgno0VCIeOzCdrw
	9wzZDZ3j4E2qmJR6xJUKcjkNoy77CPSbw3NO9XDp1vGAvHEmuRqqPL9nGzTbKnDEOg9tqFE5NxF
	tWncLMDNEzI/3mO6j62O35nY4vR7v/+ByESb8TiiNJZQP7WPXUbNTkorzOGDmHX55rsYUBDKbjG
	hp2UCr2CEd2c+bEyOKXe6vVZVfbFkDFRO26+DSQ3c=
X-Google-Smtp-Source: AGHT+IEbu7UkRnaq1HAZF7KJE8mC7YX4IT4qsm04tHRZF/RRVkDmdBo8SVYWqOjog8FiLYEn3hk8pw==
X-Received: by 2002:a05:6e02:1aa2:b0:433:3034:e88 with SMTP id e9e14a558f8ab-43367e48c8bmr107760915ab.21.1762788016218;
        Mon, 10 Nov 2025 07:20:16 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f4f5b90sm56357735ab.33.2025.11.10.07.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:20:15 -0800 (PST)
Message-ID: <66ab3a48-5d5a-47c7-b8eb-b477fd987314@riscstar.com>
Date: Mon, 10 Nov 2025 09:20:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Introduce SpacemiT K1 PCIe phy and host controller
To: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, ziyao@disroot.org, johannes@erdfelt.com,
 mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 shradha.t@samsung.com, inochiama@gmail.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com,
 thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
 guodong@riscstar.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251107191557.1827677-1-elder@riscstar.com>
 <aQ8kqIljwGZfkF8M@aurel32.net>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aQ8kqIljwGZfkF8M@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/25 5:08 AM, Aurelien Jarno wrote:
> Hi Alex,
> 
> Thanks for this new version.
> 
> On 2025-11-07 13:15, Alex Elder wrote:
>> This series introduces a PHY driver and a PCIe driver to support PCIe
>> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
>> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
>> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
>> one PCIe lane, and the other two ports each have two lanes.  All PCIe
>> ports operate at 5 GT/second.
>>
>> The PCIe PHYs must be configured using a value that can only be
>> determined using the combo PHY, operating in PCIe mode.  To allow
>> that PHY to be used for USB, the needed calibration step is performed
>> by the PHY driver automatically at probe time.  Once this step is done,
>> the PHY can be used for either PCIe or USB.
>>
>> This initial version of the driver supports 32 MSIs, and does not
>> support PCI INTx interrupts.  The hardware does not support MSI-X.
>>
>> Version 5 of this series incorporates suggestions made during the
>> review of version 4.  Specific highlights are detailed below.
>>
>> Note:
>> Aurelien Jarno and Johannes Erdfelt have reported seeing ASPM errors
>> accessing NVMe drives when using earlier versions of this series.
>> The Kconfig files they used were very different from the RISC-V
>> default configuration.
>>
>> Aurelien has since reported the errors do not occur when using
>> defconfig.  Johannes has not reported back about this.
> 
> Unfortunately, while it is true with v4, this is not the case with v5
> anymore :(

That's too bad, but thank you for reporting it.

> Fundamentally in the generic designware driver, post_init (which is used
> to disable L1 support on the controller side) is called after starting
> the link. The comparison of the capabilities is done in
> pcie_aspm_cap_init when the link is up, which happens a tiny bit after
> starting it.
> 
> In practice with v4, the link is started, ASPM L1 is disabled and the
> link becomes up. With v5, the move of the code getting and enabling the
> regulator changed the timing, and ASPM L1 is now disabled on the
> controller 2-3 ms after the link is up, which is too late.

Yes in v4, we relied on the root port driver to enable the
regulator, but (on my system anyway) that happened too late,
*after* the PCIe controller driver held PERST# asserted for
100 msec.  PERST# is not supposed to be de-asserted until
power is known to be stable.  So v5 went back to having
the controller get the regulator in k1_pcie_probe().

I am supposed to receive the WD Blue SN570 on Wednesday, and
when I get that I'll have a chance to try to reproduce at
least one of these problems, and can ensure there are no
timing-related issues like this.

Thank you for your continued testing and feedback about this.

					-Alex

> I have added a call to pci_info to display the moment where ASPM is
> disabled. This is without the regulator change:
> 
> [    0.386730] spacemit-k1-pcie ca400000.pcie: host bridge /soc/pcie-bus/pcie@ca400000 ranges:
> [    0.386970] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bus/pcie@ca800000 ranges:
> [    0.387017] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0x00b7101fff -> 0x0000000000
> [    0.387047] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0x00afffffff -> 0x00a0000000
> [    0.387062] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0x00b6ffffff -> 0x00b0000000
> [    0.400109] spacemit-k1-pcie ca400000.pcie:       IO 0x009f002000..0x009f101fff -> 0x0000000000
> [    0.490101] spacemit-k1-pcie ca800000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
> [    0.494195] spacemit-k1-pcie ca400000.pcie:      MEM 0x0090000000..0x009effffff -> 0x0090000000
> [    0.850344] spacemit-k1-pcie ca400000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
> [    0.950133] spacemit-k1-pcie ca400000.pcie: PCIe Gen.1 x2 link up
> [    1.129988] spacemit-k1-pcie ca400000.pcie: PCI host bridge to bus 0000:00
> [    1.335482] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.340946] pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
> [    1.350181] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9effffff]
> [    1.358734] pci_bus 0000:00: resource 4 [io  0x100000-0x1fffff]
> [    1.362033] pci_bus 0000:00: resource 5 [mem 0x90000000-0x9effffff]
> [    1.368289] spacemit-k1-pcie ca400000.pcie: pcie_aspm_override_default_link_state
> [    1.375967] pci 0000:00:00.0: [1e5d:3003] type 01 class 0x060400 PCIe Root Port
> [    1.383043] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
> [    1.388927] pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x000fffff]
> [    1.394826] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    1.400061] pci 0000:00:00.0:   bridge window [io  0x100000-0x100fff]
> [    1.406460] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> [    1.413245] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> [    1.421012] pci 0000:00:00.0: supports D1
> [    1.424948] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    1.432718] pci 0000:01:00.0: [1987:5015] type 00 class 0x010802 PCIe Endpoint
> [    1.438698] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> [    1.445426] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    1.464897] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> 
> And this is with the regulator change:
> 
> [    0.410796] spacemit-k1-pcie ca400000.pcie: host bridge /soc/pcie-bus/pcie@ca400000 ranges:
> [    0.410836] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bus/pcie@ca800000 ranges:
> [    0.410889] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0x00b7101fff -> 0x0000000000
> [    0.410917] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0x00afffffff -> 0x00a0000000
> [    0.410932] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0x00b6ffffff -> 0x00b0000000
> [    0.424651] spacemit-k1-pcie ca400000.pcie:       IO 0x009f002000..0x009f101fff -> 0x0000000000
> [    0.436446] spacemit-k1-pcie ca400000.pcie:      MEM 0x0090000000..0x009effffff -> 0x0090000000
> [    0.513897] spacemit-k1-pcie ca800000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
> [    0.559595] spacemit-k1-pcie ca400000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
> [    0.839412] spacemit-k1-pcie ca400000.pcie: PCIe Gen.1 x2 link up
> [    0.847078] spacemit-k1-pcie ca400000.pcie: PCI host bridge to bus 0000:00
> [    0.857600] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.868702] pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
> [    1.146409] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9effffff]
> [    1.373742] pci 0000:00:00.0: [1e5d:3003] type 01 class 0x060400 PCIe Root Port
> [    1.380963] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
> [    1.386883] pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x000fffff]
> [    1.392808] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    1.395394] pci 0000:00:00.0:   bridge window [io  0x100000-0x100fff]
> [    1.401811] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> [    1.408583] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> [    1.416354] pci 0000:00:00.0: supports D1
> [    1.420294] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    1.428220] pci 0000:01:00.0: [1987:5015] type 00 class 0x010802 PCIe Endpoint
> [    1.434034] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> [    1.440772] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    1.463390] pci 0000:01:00.0: pcie_aspm_override_default_link_state
> [    1.467000] pci 0000:01:00.0: ASPM: default states L1
> [    1.472093] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> 
> Note how the line pcie_aspm_override_default_link_state arrives too
> late.
> 
> Regards
> Aurelien
> 


