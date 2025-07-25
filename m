Return-Path: <linux-kernel+bounces-745598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8DBB11C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74F9AE4749
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B22E764E;
	Fri, 25 Jul 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigon.be header.i=@bigon.be header.b="vVoB57PZ"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA42E3372
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438352; cv=none; b=sNoCj9tm+IKgxKyN9ZzZM5Mn6At9eNTnfwqkBZTJ3fNBjhwlkecBA2wq9OPCuPSBU0BiHkO4Ju0/R124NMm8nI7B1hU7ox2tXIvfzcWWVwCCXFImIHdTCETJDQY596h/ycX2ofRfDdYbq5wvw32LvDThVEhMzhYEFO33qNSSnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438352; c=relaxed/simple;
	bh=HzdYr6TAFrPloikwWPVtgbN47x8owuMBGbrlRD9d7V0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Fee/7Y6jjY4d5au2xt5uBTtFE0VdI2yXzMWBJWF1uDrBuJz8ltrHzVYKhteQ0MZ04ldm6znloKAsa60vdiAJW69orhYQ70JTNTX8UE7GPwzzWKS3SWjytItvw6eGrh2K/Ine08UJ+dGtnpwV0mDHWOPE2lsUKItwQnaEmV5Xivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bigon.be; spf=pass smtp.mailfrom=bigon.be; dkim=pass (2048-bit key) header.d=bigon.be header.i=@bigon.be header.b=vVoB57PZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bigon.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bigon.be
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bpNwB0tfFz9slH
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bigon.be; s=MBO0001;
	t=1753438346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=bRWeZ/8dBzRH3g8mKfACr0qQdS8AGLysU9VSBvuJ6x8=;
	b=vVoB57PZxLSDr75eKxiTdvpkDCoPvZKCqb1Wr3UN9mDz1sj82L+hRb35fy0VVevuf1E9tV
	GGNedW2lq0fBKD2FLS0z3mcFVuI6cmGpWxvAhKQKc8tHSqcqmro3oRPKXFFO+RELriXeeo
	D8JE9Aan792LKcC1cIVZSP+28l4sg2a/US2r15mKifmXWxTems1AU0yz8TZrGj71af0tow
	0oqrHz4yITyjSZ4P7drO42tK2DDapMLak5LwgoeMCVm79D//Sq1NJ9qu60h9MU8gnd5Lni
	xbMwx/3AGufRYCdCK7NIrN2dWYa3LbtkH729jcyFTduuojxRjGYFKo82vYXaLA==
Message-ID: <c939f4df-b35f-4429-968f-5bf623485af1@bigon.be>
Date: Fri, 25 Jul 2025 12:12:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Laurent Bigonville <bigon@bigon.be>
Subject: Realtek Sdcard reader and Intel RST/VMD prevent laptop to properly go
 in s2idle
To: linux-kernel@vger.kernel.org
Content-Language: en-US, fr-BE, fr
Autocrypt: addr=bigon@bigon.be; keydata=
 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
 Gub8y8YgCrSTibbvx1KRJA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I've a Dell latitude 5530 that doesn't seems to support S3/suspend and 
that relies on s2idle instead.

For years now, the laptop is draining a lot of power (50% of the battery 
over night) when it's (supposedly) in s2idle state, I thought it was normal.

But I had a new look at this this week and now I seems to realized that 
it was actually not normal.

I ran Intel's s0ix-selftest-tool script and it complains about Intel 
RST/VMD (RAID stuff) and the integrated Realtek SD card reader.

I disabled both in the BIOS and s0ix-selftest-tool is now happy and from 
my quick tests, the battery usage is way lower now in s2idle.

There is no difference whether the kernel SDcard reader module 
(rtsx_pci/rtsx_pci_sdmmc) is loaded or not.

Checking PCI Devices D3 States:
[  133.377966] intel_ish_ipc 0000:00:12.0: PCI PM: Suspend power state: D0
[  133.378112] intel_ish_ipc 0000:00:12.0: PCI PM: Skipped
[  133.380685] i801_smbus 0000:00:1f.4: PCI PM: Suspend power state: D0
[  133.380699] i801_smbus 0000:00:1f.4: PCI PM: Skipped
[  133.389974] proc_thermal_pci 0000:00:04.0: PCI PM: Suspend power 
state: D3hot
[  133.390090] nvme 10000:e1:00.0: PCI PM: Suspend power state: D3hot
[  133.390673] snd_hda_intel 0000:00:1f.3: PCI PM: Suspend power state: 
D3hot
[  133.390744] i915 0000:00:02.0: PCI PM: Suspend power state: D3hot
[  133.392965] mei_me 0000:00:16.0: PCI PM: Suspend power state: D3hot
[  133.394565] rtsx_pci 0000:71:00.0: PCI PM: Suspend power state: D3hot
[  133.394830] e1000e 0000:00:1f.6: PCI PM: Suspend power state: D3hot
[  133.395923] intel-lpss 0000:00:15.1: PCI PM: Suspend power state: D3hot
[  133.396238] xhci_hcd 0000:00:14.0: PCI PM: Suspend power state: D3hot
[  133.396372] iwlwifi 0000:00:14.3: PCI PM: Suspend power state: D3hot
[  133.398157] xhci_hcd 0000:00:0d.0: PCI PM: Suspend power state: D3cold
[  133.399158] pcieport 0000:00:07.1: PCI PM: Suspend power state: D3cold
[  133.402331] pcieport 10000:e0:06.0: PCI PM: Suspend power state: D3hot
[  133.403157] pcieport 0000:00:07.0: PCI PM: Suspend power state: D3cold
[  133.414710] vmd 0000:00:0e.0: PCI PM: Suspend power state: D3hot
[  133.420276] pcieport 0000:00:1d.0: PCI PM: Suspend power state: D3hot
[  133.423235] thunderbolt 0000:00:0d.2: PCI PM: Suspend power state: D3cold


Checking PCI Devices tree diagram:
-[0000:00]-+-00.0  Intel Corporation Alder Lake-U15 Host and DRAM Controller
            +-02.0  Intel Corporation Alder Lake-UP3 GT2 [Iris Xe Graphics]
            +-04.0  Intel Corporation Alder Lake Innovation Platform 
Framework Processor Participant
            +-06.0  Intel Corporation RST VMD Managed Controller
            +-07.0-[01-38]--
            +-07.1-[39-70]--
            +-08.0  Intel Corporation 12th Gen Core Processor Gaussian & 
Neural Accelerator
            +-0d.0  Intel Corporation Alder Lake-P Thunderbolt 4 USB 
Controller
            +-0d.2  Intel Corporation Alder Lake-P Thunderbolt 4 NHI #0
            +-0e.0  Intel Corporation Volume Management Device NVMe RAID 
Controller
            +-12.0  Intel Corporation Alder Lake-P Integrated Sensor Hub
            +-14.0  Intel Corporation Alder Lake PCH USB 3.2 xHCI Host 
Controller
            +-14.2  Intel Corporation Alder Lake PCH Shared SRAM
            +-14.3  Intel Corporation Alder Lake-P PCH CNVi WiFi
            +-15.0  Intel Corporation Alder Lake PCH Serial IO I2C 
Controller #0
            +-15.1  Intel Corporation Alder Lake PCH Serial IO I2C 
Controller #1
            +-16.0  Intel Corporation Alder Lake PCH HECI Controller
            +-1d.0-[71]----00.0  Realtek Semiconductor Co., Ltd. RTS525A 
PCI Express Card Reader
            +-1f.0  Intel Corporation Alder Lake PCH eSPI Controller
            +-1f.3  Intel Corporation Alder Lake PCH-P High Definition 
Audio Controller
            +-1f.4  Intel Corporation Alder Lake PCH-P SMBus Host Controller
            +-1f.5  Intel Corporation Alder Lake-P PCH SPI Controller
            \-1f.6  Intel Corporation Ethernet Connection (16) I219-LM
-[10000:e0]---06.0-[e1]----00.0  Micron Technology Inc 3400 NVMe SSD 
[Hendrix]

Pcieport is not in D3cold:
10000:e0:06.0
0000:00:1d.0

Full logs on: https://bugzilla.kernel.org/show_bug.cgi?id=220362 and 
https://bugzilla.kernel.org/show_bug.cgi?id=218500

An idea?

Kind regards,

Laurent Bigonville


