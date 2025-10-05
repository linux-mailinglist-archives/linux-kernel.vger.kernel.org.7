Return-Path: <linux-kernel+bounces-842471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD333BBCC82
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD6718962E9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6782BDC14;
	Sun,  5 Oct 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vst49NcP"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B331DB95E
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699419; cv=none; b=r9MvRpFU0D5XyCERlRhV3pf1EdXjpt3V37+mQcl6R/eQ1XBc+OSKcaLfC3ci1+9Is6/KVEdZsb3ADqfZL+k3MbS4w5QKbFi+ecx8pbPA1cnTOP0bbWUVE/1N2v1/mKt688ICDYX5O3G0lG7vCUqiNSYPRJ20A5clRYj2nkynYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699419; c=relaxed/simple;
	bh=2CwbguicZ0S+J7V+YRyWURgOs8HjQKz6ZlZ3racUZoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbRnP86eFkdSXwWhGd9YKEFAlBqa+3K3wtMFQCaXVmb1lwJG4pc1/eVNVQuAYRwa7qSdqAawRV1+5GUprcinjVv3sZkwAobp2Ddzbp8Iuwlbg//0wKZTaaU2kDDIDvwiOgabJGUSSai7XZT9j96fNYFozXf8Ve1LNgVyctQtze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vst49NcP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9AD514E40EE9;
	Sun,  5 Oct 2025 21:23:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F4686065F;
	Sun,  5 Oct 2025 21:23:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4149102F1CFA;
	Sun,  5 Oct 2025 23:23:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759699414; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=T+Q5QIbzZsyio6/dIB1c7tf9it+A69APCK+Fhn5DQW4=;
	b=Vst49NcPMalVhdZ7kL5jQ8d0qhbPcKJSu7ypniyQcJHTFQVWpElRzrY3guDKGe3xXPSdU0
	O0edYuvMwDR5KuTafvfgiiaRM6nBySwbfsAAMIuae94hrTY8Nax8753X2Uizy4z9JDmZN2
	3TCl1aR6EeX+k5tmxd5l6x29wz0nweRmuFeKIxU7v4d/RyX+2HAoKozCpf1CYvaXci0H/w
	6QNJAo8raJ1Rd6Ahg+1YZI6Z5g5yHOHTmmUYzE2EL5a7RNZkkFQrBGOsncZhzHnCgvhFIn
	Nm5OpbnN6DWPVrnnbUMB/veiXy4JmN4LzQSFzbg5gyn4jwpI/5/FOGDve072lg==
Date: Sun, 5 Oct 2025 23:23:32 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: michal.simek@amd.com, Harini T <harini.t@amd.com>
Cc: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH V2] rtc: zynqmp: Restore alarm functionality after kexec
 transition
Message-ID: <175969940416.3796539.10765849167176771730.b4-ty@bootlin.com>
References: <20250730142110.2354507-1-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730142110.2354507-1-harini.t@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 30 Jul 2025 19:51:10 +0530, Harini T wrote:
> During kexec reboots, RTC alarms that are fired during the kernel
> transition experience delayed execution. The new kernel would eventually
> honor these alarms, but the interrupt handlers would only execute after
> the driver probe is completed rather than at the intended alarm time.
> 
> This is because pending alarm interrupt status from the previous kernel
> is not properly cleared during driver initialization, causing timing
> discrepancies in alarm delivery.
> 
> [...]

Applied, thanks!

[1/1] rtc: zynqmp: Restore alarm functionality after kexec transition
      https://git.kernel.org/abelloni/c/e22f4d1321e0

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

