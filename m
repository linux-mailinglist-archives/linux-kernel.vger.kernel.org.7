Return-Path: <linux-kernel+bounces-732781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C161B06C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E102D7A51FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF31E834E;
	Wed, 16 Jul 2025 03:19:48 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B310405F7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635987; cv=none; b=AKvnn2ePl9N3ZubvraNo5kwaSBncv0NKmxdQRVdTDFh8QjlNPUSzwM8HStIGWGnjV0AATWA5nnVAvrcwjhBUDoMAFDG7txlVEQ/WdVq3woLc8cDIAU+tywSMmsg3Y97DqIVeyaps++BmGgwajYnF+GwWLaeQRyfiIRNksQ3gGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635987; c=relaxed/simple;
	bh=tOCh21a4Qy83CvOWuXq3cpoYduuY2Bh1shHiteChVzo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dbZX51AGaYi2jwLSGRYAKntZ35yt2VJGgQGQ4q914EhDTts+Iu/KopYpe5GGgF8Zy4+2WAButCMyyTr7inaSx44A3FhbO12qWRaOe/x2PZotHNimtpKrj0wLuX6R5t4Z3r7rSPonquismv7hXGSEMhdY6L+S0RFzA4K7ue3d4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.71])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id AD4FDB4D0151;
	Wed, 16 Jul 2025 05:19:41 +0200 (CEST)
Message-ID: <91d71a35-bb22-4482-8b49-398899ee37ae@freeshell.de>
Date: Tue, 15 Jul 2025 20:19:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: E Shattow <e@freeshell.de>
Subject: Are LED functions strings or uint32 in
 Documentation/devicetree/bindings/leds/common.yaml
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Documentation/devicetree/bindings/leds/common.yaml [1] describes a
uint32 but the $ref is for a string, for "function". What's going on
there? Also what is the reasoning for that sort ordering [2] in the
examples, are we saying that gpios is like a register and function or
default-state is a kind of status?

1:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/common.yaml

2:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/leds-gpio.yaml

-E Shattow



