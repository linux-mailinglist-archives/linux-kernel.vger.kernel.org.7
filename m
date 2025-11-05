Return-Path: <linux-kernel+bounces-885914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B7C343C5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD50C4EBA89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4047C2D23A4;
	Wed,  5 Nov 2025 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CK5VLrZO"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107F20E005
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328062; cv=none; b=DRPSCs5pwtjtrBPVSqW5aTDNCErzriYvzYA3OwJ9h5On5LFU3UqD3XC6DGLMmjphfFw7fDVNAWQ9unYefVNqIpFTnRT6DLuuT6GXZ2XneKpFrae+vJVbcxUctr9YX1wCdKCXMMTyY0Y2ryjeZOka7j+/9AWTprrZiRKtgVuHOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328062; c=relaxed/simple;
	bh=zJa+pItKng0BXhWto1u6cdPxoM7x4Bspfd7HU6y1v1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjmOSbxET6CVS5IG+v3V/6yoPky9YXnnYJfcobSRQnQF/2uA/B5rkydFfu5wG9e2iiexcHlf1lSGrf32lOUdpw4abI/NvdPtd6QmvJnOTML0euJf+hlSoiLFtxCZ99oX0kF/VElCVo3vkM1zOUqgiAFFY3f15zK93+4IkDb8c8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CK5VLrZO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 49F714E4151E;
	Wed,  5 Nov 2025 07:34:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 13E9F60693;
	Wed,  5 Nov 2025 07:34:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC47D10B51601;
	Wed,  5 Nov 2025 08:34:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762328055; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FuM477eIKThQiCI0oDzUFgDYIGV14xqrDFhwTESVrWI=;
	b=CK5VLrZOSqjoJG76MRglqgRvwIQ8n/1oMFtmXvSuyGVRfMGfDcEQKD5BmRySdjVfWwV6xR
	wZV1ePhyX2X+MPF6sivQPIZyTplFMclDwBwHDvu4xcM1YCz4ut5z1XDYLhzv61af5Hzyqm
	lM9HMRMGzdiecg6E501C2IXy3IFTl190b66YAzKO70nl6TYm2VmyG/A/SJJam1Jh/18it4
	wHqYSnMubxtJJGQq06ZOaToblk0ydKJ+wgP+25ZsT9rlgCjwn6Aqx7ArcDgjnLJQ/wOsmD
	d1nQiI31RqRTjYkXC051vw8QwjByolIMWxsZ72ahaDX026ePPD21/T7zD9hEog==
Date: Wed, 5 Nov 2025 08:34:08 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: wan: framer: pef2256: Switch to
 devm_mfd_add_devices()
Message-ID: <20251105083408.71b8b6ee@bootlin.com>
In-Reply-To: <20251105034716.662-1-vulab@iscas.ac.cn>
References: <20251103111844.271-1-vulab@iscas.ac.cn>
	<20251105034716.662-1-vulab@iscas.ac.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Haotian,

On Wed,  5 Nov 2025 11:47:16 +0800
Haotian Zhang <vulab@iscas.ac.cn> wrote:

> The driver calls mfd_add_devices() but fails to call mfd_remove_devices()
> in error paths after successful MFD device registration and in the remove
> function. This leads to resource leaks where MFD child devices are not
> properly unregistered.
> 
> Replace mfd_add_devices with devm_mfd_add_devices to automatically
> manage the device resources.
> 
> Fixes: c96e976d9a05 ("net: wan: framer: Add support for the Lantiq PEF2256 framer")
> Suggested-by: Herve Codina <herve.codina@bootlin.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

Not sure that 'Suggested-by: Jakub Kicinski' was needed according to his
comments on v2. Also, you forgot my 'Acked-by' I sent on v2.

Anyway, the v3 is ok on my side

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

