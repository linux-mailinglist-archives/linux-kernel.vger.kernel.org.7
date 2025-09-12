Return-Path: <linux-kernel+bounces-814266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF90B551CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CA75C1495
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CF731D74A;
	Fri, 12 Sep 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JloY9SSa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58A3164B8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687398; cv=none; b=SPa6lm3QS8vwl9bxLYa+gGnJ3js4AtS4sKPsuD/j0MUyV6HhHisJjKbyPEx3wcIGNu23rCBEXxxEp7JSMnbPZCH6+yAc8Usrj4j575+wbEU8HxFpoOwGaHttBoCUN2z5X0nNo6LFyzuhwiJffxvIDTqjCUY2M96ebXMdkhJB7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687398; c=relaxed/simple;
	bh=vVe2I9E2DhRASqs+H8As0PLyRNGee7jFoSDQdou8tQw=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=PCa3D2vk5NqEngy7XUZNvrgUxwB4QU7phDFKRYQ/bePBYjnw5HgLfU940lYGvHyDQXtFjs7ECKwhAMTm41cozVwpQ7Q4ck3mTZ0rdUmUW4s7sfVX7DYplKTehtk1gibABMkaia1eQS/D6eJ0AxW/9/NMX9ddnThRXgP91dFDRPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JloY9SSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4526C4CEF4;
	Fri, 12 Sep 2025 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687398;
	bh=vVe2I9E2DhRASqs+H8As0PLyRNGee7jFoSDQdou8tQw=;
	h=Date:From:Subject:Cc:To:From;
	b=JloY9SSay7/Rw4N9TEfIUaowhvf9NtttB4W2Yi2/oNLBn+KD0Xc20d+86CeqOHvgx
	 AJNDoAxk2FDvChiTrhQRpkt2lVXmkI080Tzija0kRuBK5usKHYy13ogJE8QBdtRTQ+
	 rbPNQNWs1NPKrKS2j04CexYkQKVZoj4bbYI1jaoPsBinkoTM1s8G47QUsTR7VFZuYO
	 +7sKB59vPMeCw8sXC/xgSs37JFHj86P52adYCjqyEFc1es9RxnR2pJC9wM53o6/F7C
	 o0YgQFTXRgscMn5bUw8HeFV4AzRtIJGnQDXQU3Sr1+ppQO+StAhnDCpVEiVIbj2wKS
	 J3LVvCJjv0wRA==
Message-ID: <c88d98fb-cc14-435a-b943-ee3be4eaf60f@kernel.org>
Date: Fri, 12 Sep 2025 23:29:56 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
Subject: [GIT PULL] extcon next for 6.18
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Chanwoo Choi <chanwoo@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Greg,

This is extcon-next pull request. I add detailed description of
this pull request on below. Please pull extcon with following updates.

I'm sorry that I did not send the separate fixes pull request.
This pull request does not contain any problematic patches according to your comment.

Best Regards,
Chanwoo Choi

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.18

for you to fetch changes up to 94d885eb8ffe15b3eb4abe92e03d852fce8ba81f:

  dt-bindings: extcon: linux,extcon-usb-gpio: GPIO must be provided (2025-09-08 15:13:06 +0900)

----------------------------------------------------------------
Update extcon next for v6.18

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

- Convert legacy DT binding to YAML of richktek,rt8973a-muic.yaml

- Add missing DT binding information of that must include either id-gpios or
  vbus-gpios for linux,extcon-usb-gpio.yaml

----------------------------------------------------------------
Artur Weber (1):
      dt-bindings: extcon: rt8973a: Convert DT bindings to YAML

David Heidelberg (1):
      dt-bindings: extcon: linux,extcon-usb-gpio: GPIO must be provided

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

 .../devicetree/bindings/extcon/extcon-rt8973a.txt  |  23 --
 .../bindings/extcon/linux,extcon-usb-gpio.yaml     |   6 +
 .../devicetree/bindings/extcon/maxim,max14526.yaml |  80 ++++++
 .../bindings/extcon/richtek,rt8973a-muic.yaml      |  49 ++++
 drivers/extcon/Kconfig                             |  13 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-adc-jack.c                   |   2 +
 drivers/extcon/extcon-axp288.c                     |   2 +-
 drivers/extcon/extcon-fsa9480.c                    |   2 +-
 drivers/extcon/extcon-max14526.c                   | 302 +++++++++++++++++++++
 drivers/extcon/extcon-qcom-spmi-misc.c             |   2 +-
 11 files changed, 456 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-rt8973a.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
 create mode 100644 Documentation/devicetree/bindings/extcon/richtek,rt8973a-muic.yaml
 create mode 100644 drivers/extcon/extcon-max14526.c

