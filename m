Return-Path: <linux-kernel+bounces-775452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02FB2BF52
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADE668361B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC95322C87;
	Tue, 19 Aug 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="ZDU2UDfW"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9AB308F21
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600439; cv=none; b=ib61XyXWgdDkNpr67qb3KL8faSHnOTyWFR3x9WK4epRBjdpczlDIivK9ldW0oxL4MOYSU4WNNPyQ2K31euOK+ye1GJR8BlYrvL7DG+RYNccPo1BBDpDAtgqWVmc6AMYTgaQcwaY83PtflAcGIrx+MK0pSv8Ss0DFsCvPdU29GLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600439; c=relaxed/simple;
	bh=h63OmaVsTOo+4EVN1eb+eB6UUR5CTBNejqqlb4cmN9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CujTTFI/FELqBpKenMVSn8MYJLaB8y4GOfV6qLlwqSGC8RslJ2MrO4wCK9FhS+QhQNFkbUddw5HYacxHav6en2xN1gxCbon4aWsa3up43qpVWXYSniC3VpRhW4VlJkKjrf2k2uXta2WiW0fQj4QcibNWVhdHo/bqs4FBR4scMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=ZDU2UDfW; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 2F389101BC0B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:17:03 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 2F389101BC0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755600423; bh=h63OmaVsTOo+4EVN1eb+eB6UUR5CTBNejqqlb4cmN9g=;
	h=Date:From:To:Cc:Subject:From;
	b=ZDU2UDfWLXoC8XSoYelVaDAdDaYS8eFJG+IWf9VbZEGZb5a2dQ6xqPhdzg+SZ0YmL
	 8xDNTNEWL+btvqJ8JSjtE6DpN6GbwgHjWw8CyiuvMIkh3NmIfrPB8KDU18WJlhMakW
	 +w/k3yreKP2NiGL3QVfZdHg7h+R8MhUi4QZjbGRA=
Received: (qmail 11986 invoked by uid 510); 19 Aug 2025 16:17:03 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.552856 secs; 19 Aug 2025 16:17:03 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 19 Aug 2025 16:16:59 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 0ABED3414EC;
	Tue, 19 Aug 2025 16:16:59 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 712051E81492;
	Tue, 19 Aug 2025 16:16:58 +0530 (IST)
Date: Tue, 19 Aug 2025 16:16:53 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: alexandre.belloni@bootlin.com, mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH 0/1] rtc: ds1307: add support for clock provider in ds1307
Message-ID: <cover.1755599808.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all, 

This work adds support for square-wave output from ds1307 rtc chip. 
ds1307 rtc supports generating 4 rates of square wave output signal,
1, 4096, 8192, 32768 Hz. This output can be controlled by device
register - CONTROL_REGISTER at I2C address 0x7 as follows: 
OUT [7] : control default state of SQW/OUT pin if clock output is disabled.
SQWE [4] : Enable/Disable output clock
RS [1:0] : Select the rate for output clock.

Other devices can use this clock via DT and Common Clock Framework.

I have done testing and validation using CCF's debugfs interface.
Below are the details of test/validation done for this patch.

*** Test setup

Hardware:
* I am using Texas Instruments AM62x SK board (ARM64 based SoC)
* ds1307 RTC hardware module.
* I have connected ds1307 module at I2C0 bus of am62x available
at 40pin user expansion connector headers.
SDA --> pin 27
SCL --> pin 28
No pull up needed as board already have pull ups on I2C0 lines.
* 24MHz logic analyzer to see the waveforms and validate frequency.

Kernel:
* v6.17-rc2
* define CLOCK_ALLOW_WRITE_DEBUGFS manually in drivers/clk/clk.c
so that we can use debugfs interface to test setting clock rates.
Note: This config is intentionally kept manual in the kernel and 
should be defined manually only.

*** Validation steps: 

Step 1: Probe the module
$ modprobe rtc-ds1307

Step 2: Mount debugfs
$ mount -t debugfs none /sys/kernel/debug

Step 3: Instantiate device
$ echo "ds1307 0x68" > /sys/class/i2c-dev/i2c-0/device/new_device

Step 4: read initial rate
$ cat /sys/kernel/debug/clk/ds1307_clk_sqw/clk_rate
1

Step 5: Set rate to 8192 and enable square-wave output
$ echo 8192 > /sys/kernel/debug/clk/ds1307_clk_sqw/clk_rate
$ echo 1 > /sys/kernel/debug/clk/ds1307_clk_sqw/clk_prepare_enable

Step 6: Verify rate
$ cat /sys/kernel/debug/clk/ds1307_clk_sqw/clk_rate
8192
Validate output clock using logic analyzer.
Probe at pin #7 (SQW/OUT) of ds1307 chip.

Step 7: delete the device
$ echo "0x68" > /sys/class/i2c-dev/i2c-0/device/delete_device

Step 8: use i2ctools to direct read device register 0x7
$ i2cget -y 0 0x68 0x7
0x12
0x12 shows that clock is enabled with frequency 8192Hz by our driver.

step 9: Redo Step 3 through 8 for various supported rates
I have put few important debug printk() on various callbacks
to validate codepaths. Below is testing log for various random rates. 

$ echo 81929999 > /sys/kernel/debug/clk/ds1307_clk
[  913.107859] ds1307 determine rate callback rate:
[  913.114978] DS1307 set rate callback
[  913.119598] ds1307 recalc rate callback rate: 1

$ echo 10 > /sys/kernel/debug/clk/ds1307_clk
[  976.439016] ds1307 determine rate callback rate:
[  976.446192] DS1307 set rate callback
[  976.450849] ds1307 recalc rate callback rate: 4096

$ echo 5000 > /sys/kernel/debug/clk/ds1307_clk
[  991.732748] ds1307 determine rate callback rate:
[  991.739954] DS1307 set rate callback
[  991.744576] ds1307 recalc rate callback rate: 8192

$ echo 9000 > /sys/kernel/debug/clk/ds1307_clk
[ 1007.463786] ds1307 determine rate callback rate:
[ 1007.471000] DS1307 set rate callback
[ 1007.475636] ds1307 recalc rate callback rate: 32768

$ echo 40000 > /sys/kernel/debug/clk/ds1307_clk
[ 1020.292701] ds1307 determine rate callback rate:
[ 1020.299934] DS1307 set rate callback
[ 1020.304563] ds1307 recalc rate callback rate: 1

Regards,
Akhilesh

Akhilesh Patil (1):
  rtc: ds1307: add support for clock provider in ds1307

 drivers/rtc/rtc-ds1307.c | 139 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 2 deletions(-)

-- 
2.34.1


