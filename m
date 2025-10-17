Return-Path: <linux-kernel+bounces-858432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A4BEABDB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE993941A13
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F2F2E7653;
	Fri, 17 Oct 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="z7w1eEHm"
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78492E54A1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718073; cv=none; b=tHrPlsw8WTIZGdJQdQH0woIZLnLIZPo0t8OwBKhhkIsXzvcZIwGIvY5Dm+jL3qQ0j5VabqB6cgsHO+AKSppbVIf2o5Kzmg4lEu7KkJSkVtCAgxqQp6RWkdRBKof7toIjGk+BIxCbKbjTSC452cFZWhNGomZd3QK8VmKziSlXTWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718073; c=relaxed/simple;
	bh=a1NVbX4HwLDN8rNhr+HKeFlbDVEvCUamvM/dlLKhGKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UAdoRQLTG6y1zpD4Oy2Ud0h7sURUN829oxBRdRWdUbx3Kh1t+7rarsXwGb1u7Jb466/Y+veRJ3UJPDx3+Ns9A85DYd2ON2xrwZi5alLUnQh7ewXOMj2CRGv02d2GSJsV0Ou6JpDwKQC47/pPyHzSJBe8vXDITIN8XFfx57fSMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=z7w1eEHm; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-937b40137b4so131995739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760718071; x=1761322871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7+Wio6b8w1yNg9Tem9uVrRYlYIL3Mf5C/3BZyCBdIc=;
        b=z7w1eEHmMK6SJwdLgx3/wkbXboBQ3nMpMugN4K5IyP8BUzm1uCP4DcgOgMibKDzbVX
         i1MOirs+vNM5KSD6Ifxoh3iO00aSr5kW9OVfXlkvQukAbCmtRVJ+B6j6YAlzb9/O4Z24
         kCvmZCgFcL/Yx2eO6sqLZxwVhUBuA15bFFvfyw4DISHf2IOa+dO6GkjY+ib526wezw7o
         SnSxacEbas7wFD2gZvpZSCB808t3bwetk7J603Su2jpsPsrIRmJijWjwt1xv1yclOGrG
         wYDvKKEO7/aTNgQwJGpD2IwQOPh5qW4kwC7qoSegfU+UtN0q4W2olEm160+nH4BG0nC4
         HdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718071; x=1761322871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7+Wio6b8w1yNg9Tem9uVrRYlYIL3Mf5C/3BZyCBdIc=;
        b=gFi0Y0n7Ya/8pTPZh91qO47yC3A38o1w34+A9ozyuCYXN+25oa7Abv9VyTl+PZxVHg
         CYERfmPn1Xu2ah7CZ6z0q/OukA0m9UnSWY652580Olh7LgCrh2DFn9BA1Av6apgakfOu
         0nf6tMEKOSOGBZinz+jQytt+3IvKcd7DsJmRqB9eaiDxKACgJbWoLh/QpR5Qdo6RPzDC
         sUWrQmX8b7FQzS8YeG9j8pRr7g+CSEtqAkQMvlK6Y7m+iSInq1lGbBeixqA676vuhU7f
         5rbqFH/lJyRYpqWQSE6HOZsOcoH08EtIz/6cSCKudTyhFuWBBrSAZVhjR8iZxBistkLK
         DgpA==
X-Forwarded-Encrypted: i=1; AJvYcCW/SmrqiZKYJitPPqRA6KSJqDDi0BqVj3O0yCXw/5UjYdYb2jd75oA0AS48cKovskQGFIhYKOXWBueBwfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQM79KISbzs8eS7phWwi+pXQfbXbfSmIUKa9ufxTc75zCXxDwC
	2900Xd8b2ouWVUy8yxyyMj+0hihK48COIuAUgRmQgpSj4E3FOp+Qx4KKH51wsTbThc4=
X-Gm-Gg: ASbGncv8EY/jtTuepm0bsHPh2w7ulJ5FZPrLHDsPUmENROtm19rvca7sS3o46Cvf3mD
	Our2kG5RYD9YpUkGAxYxet2Ko/hn07d9szWvZLG3FQAnnNuOz1i2b3TrurFPL9Q39dF4BK3PWJ1
	thXQprIrY+fNe0odVKtMNQP8g69/HdEUIymQkgKYHv1s7QtOXmPAMWyFxl6aU7X5/PU1XZcE53C
	njiQrlF2e3vZXlfwR/CbQnY9B7gfc2+xfUKnjrmQic8KqZCunwF16Pf9kyx4YfQI/Wk6J5WGwBl
	DvzHjnju2az8OcL1CsTbe3RvLEINYBeElXbsOCbJz7louis1kok7qOdOTcmb9qO6irsCJG/BKb6
	jiJJd5r6I3wEyqZVJiYn03aG5yE55SuUsdryEDiG46JHE2fq2RNE12JpUEYt7xaAcAXnlT57zFh
	BxT1FTqtKk78WWgPC6JwSiQR5pnF1F0w2G2mYE9I4=
X-Google-Smtp-Source: AGHT+IEIgP2oHx8F177Q7uZqnuNLPeZz2b0M8yBXR1aqrI1laVD3XEel+UPyfoDNXtqbVVX4QNo+pg==
X-Received: by 2002:a05:6e02:440b:10b0:430:bf84:e94c with SMTP id e9e14a558f8ab-430bf84e9e5mr60046655ab.13.1760718070850;
        Fri, 17 Oct 2025 09:21:10 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97b92b1sm10677173.68.2025.10.17.09.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:21:10 -0700 (PDT)
Message-ID: <92ee253f-bf6a-481a-acc2-daf26d268395@riscstar.com>
Date: Fri, 17 Oct 2025 11:21:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <aPEhvFD8TzVtqE2n@aurel32.net>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPEhvFD8TzVtqE2n@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 11:47 AM, Aurelien Jarno wrote:
> Hi Alex,
> 
> On 2025-10-13 10:35, Alex Elder wrote:
>> This series introduces a PHY driver and a PCIe driver to support PCIe
>> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
>> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
>> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
>> one PCIe lane, and the other two ports each have two lanes.  All PCIe
>> ports operate at 5 GT/second.
>>
>> The PCIe PHYs must be configured using a value that can only be
>> determined using the combo PHY, operating in PCIe mode.  To allow
>> that PHY to be used for USB, the calibration step is performed by
>> the PHY driver automatically at probe time.  Once this step is done,
>> the PHY can be used for either PCIe or USB.
>>
>> Version 2 of this series incorporates suggestions made during the
>> review of version 1.  Specific highlights are detailed below.
> 
> With the issues mentioned in patch 4 fixed, this patchset works fine for
> me. That said I had to disable ASPM by passing pcie_aspm=off on the
> command line, as it is now enabled by default since 6.18-rc1 [1]. At
> this stage, I am not sure if it is an issue with my NVME drive or an
> issue with the controller.

Can you describe what symptoms you had that required you to pass
"pcie_aspm=off" on the kernel command line?

I see these lines in my boot log related to ASPM (and added by
the commit you link to), for both pcie1 and pcie2:

   pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 AS
PM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
   pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM

   . . .

   nvme nvme0: pci function 0000:01:00.0
   nvme 0000:01:00.0: enabling device (0000 -> 0002)
   nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
   nvme nvme0: 8/0/0 default/read/poll queues
    nvme0n1: p1

My NVMe drive on pcie1 works correctly.
   https://www.crucial.com/ssd/p3/CT1000P3SSD8

   root@bananapif3:~# df /a
   Filesystem     1K-blocks     Used Available Use% Mounted on
   /dev/nvme0n1p1 960302804 32063304 879385040   4% /a
   root@bananapif3:~#

I basically want to know if there's something I should do with this
driver to address this.  (Mani, can you explain?)

Thank you.

					-Alex

> Regards
> Aurelien
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
> 


