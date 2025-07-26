Return-Path: <linux-kernel+bounces-746551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5BB1280E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799B3AE1536
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120B136672;
	Sat, 26 Jul 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv7fkjqj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A986348
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490091; cv=none; b=KLuoF8WOBC9LB88hMDtCf9q3lUCOWtRe+VNoTixCq8zOxaNxYCYpyEIzMxhRJLJKilUPMwY8lmgvJu2Rku2ULqDwIN+cATsliT91Rveh5P3UdMAzfM6gNSVocchBy36jicNLcJabacT7zAJjbHnWURK8PTUo5T5L3quc0UtWOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490091; c=relaxed/simple;
	bh=PEL1x7I2m7IqQBWT9RiBxeL7BEdWbafbTnwXBiu3okA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=icuCw/JBmwXle8QahcH5MpDpDaY9v09bj4LMjf3YOTEeJ+BVJGmBOHgjwk/TOSwC75T0QEcFmm2f5TTwskQJWFMdHRXzO1CZvrw5dRMfjxguOOSP8fvIT3mQRjsZskARBnYu8HOGcq4Y9aSxkmROaLKcRqQCyk34aGnzSUYtN2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv7fkjqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A39C4CEE7;
	Sat, 26 Jul 2025 00:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753490091;
	bh=PEL1x7I2m7IqQBWT9RiBxeL7BEdWbafbTnwXBiu3okA=;
	h=Date:From:To:Cc:Subject:From;
	b=Iv7fkjqjbqsJ108sOrKDAMpbV5LWwI9DfOX9aPiPdHHMpTKQMm/iTbm2xrjH66KNO
	 1sHXL+aqFaszKVcGU2UhMm2LAP1UQ/Z4UgJaj1ZtCuoMHEQLi3EvAsWCDW+aIz5C6o
	 qCKam6+NPPcySTR0DUINOkzge8CJYKT3l74JcDLpVpq2waKPW0gP+X62XQFDfp+dtC
	 8YF2qeaF5j8Qo61zSqHf+N0WqECxUw+HOZUuHZBQKAmfG3uMBJzPyGtxM67KgKO/Ul
	 VoXYLHwBv8U3/f81h6XRPW2fJuh/qh4GgX60E0PejsFGyy7j5sRC2GvcVx4dac8X/n
	 Uw0Spqmbd0Krg==
Message-ID: <15ca3763-45a5-40af-93a8-449a9f1f33a9@kernel.org>
Date: Sat, 26 Jul 2025 09:34:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Chanwoo Choi <chanwoo@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [GIT PULL] extcon next for 6.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Greg,

This is extcon-next pull request. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.17

for you to fetch changes up to 5f09caafc652bcee7a5247e40dd34d1de1ad7d7f:

  extcon: fsa9480: Avoid buffer overflow in fsa9480_handle_change() (2025-07-19 12:39:13 +0900)

----------------------------------------------------------------
Update extcon next for v6.17

Detailed description for this pull request:
- Fix wakeup source leaks on device unbind for extcon drivers

- Add new Maxim MAX14526 MUIC extcon driver and dt-binding document
 : The MAX14526 is designed to simplify interface requirements on portable
   devices by multiplexing common inputs (USB, UART, Microphone, Stereo Audio
   and Composite Video) on a single micro/mini USB connector. The USB input
   supports Hi-Speed USB and the audio/video inputs feature
 : This provides the following supported external connector detection
   - EXTCON_USB
   - EXTCON_USB_HOST
   - EXTCON_CHG_USB_FAST
   - EXTCON_DISP_MHL

- Fix buffer overflow detected by linuxtesting.org SVACE on extcon-fsa9480.c

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      extcon: adc-jack: Fix wakeup source leaks on device unbind
      extcon: axp288: Fix wakeup source leaks on device unbind
      extcon: fsa9480: Fix wakeup source leaks on device unbind
      extcon: qcom-spmi-misc: Fix wakeup source leaks on device unbind
      extcon: adc-jack: Cleanup wakeup source only if it was enabled

Randy Dunlap (2):
      extcon: max14526: avoid defined but not used warning
      extcon: max14526: depends on I2C to prevent build warning/errors

Svyatoslav Ryhel (2):
      dt-bindings: extcon: Document Maxim MAX14526 MUIC
      extcon: Add basic support for Maxim MAX14526 MUIC

Vladimir Moskovkin (1):
      extcon: fsa9480: Avoid buffer overflow in fsa9480_handle_change()

 .../devicetree/bindings/extcon/maxim,max14526.yaml |  80 ++++++
 drivers/extcon/Kconfig                             |  13 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-adc-jack.c                   |   2 +
 drivers/extcon/extcon-axp288.c                     |   2 +-
 drivers/extcon/extcon-fsa9480.c                    |   6 +-
 drivers/extcon/extcon-max14526.c                   | 302 +++++++++++++++++++++
 drivers/extcon/extcon-qcom-spmi-misc.c             |   2 +-
 8 files changed, 404 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
 create mode 100644 drivers/extcon/extcon-max14526.c

