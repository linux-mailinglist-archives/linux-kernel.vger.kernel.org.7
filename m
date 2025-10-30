Return-Path: <linux-kernel+bounces-878046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42385C1FA5B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380D93A83B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39E34DB59;
	Thu, 30 Oct 2025 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="fRb0pGmi"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D752F6912
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821545; cv=none; b=HIMsutR+4eE3SVbFsJks14/8cSb/r1JLbb7gI+x0PYZmVjb4mPy1zJbWGLVvboU9fwwx0kwET7glabWR5550YsOAND/5sc7vvKbu2gNpTBP1pDb/9Mkc5tliGd4OSmJyrBNadkfs5C2V6Ch93c/kjb6MfJM32Br1kDuMXkm2HmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821545; c=relaxed/simple;
	bh=7qW+NaaGh/JE/ucc85gWuheRzd1Q3hCNzAtheC5l+2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cckt++ocXVt61qMS66VA1eshElWYGRiG91hsFjwd6aISgLGvBgxmQr5iKqESlE9qyvN7ELd96WZDiGHL//Gt6xmNN6zQwoCHtcSHs8vE+XoUdAAZhJznxjUY9NHfiPg1KOEfRVupZo+Oqa0WnkHznOqKIwqBizlUE7fbcHEe9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=fRb0pGmi; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Date: Thu, 30 Oct 2025 10:50:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1761821531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBHnBHSuMYckJCLbgZCu2OahfUnKzTUzjWVCcpE6wBc=;
	b=fRb0pGmiX3dK8gJZa/zjS1z3dJEB9uuqxQT5osdza1NGSdi0lHhhDfiqNCTqSSxuOdCutE
	TtGUGf9YypwzUGmubEkjG8lMMFdFXkWq9Lcd9riJSOPKCwMrurjtuoaW0qPhUJVlSAoTSe
	qrkkfOoffCkvPDrPNLwWaVNmC2KCRUdGnHnarRcYSyxSZejDIqqhLkGL/hkf3VdmefsS5v
	pYr+ao12rw7hjomsHXvZDxGHRRFnM9fASbnSRDTeJD4UnlwwHQRx46IiWPbMFatzp2e8kv
	3OmV6LQF5OfTwin8zGkIA17VE42nTlRvvZtWg1MV9FaXs/JWAkBnh5gqDsx7gw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: linux-amlogic@lists.infradead.org, Zhentao Guo <zhentao.guo@amlogic.com>, Christian Hewitt <christianshewitt@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/3] Add Amlogic stateless H.264 video decoder for S4
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com> <B9A578FB-BF95-47E1-B202-B59897C2C898@gmail.com> <9a8e0391-c73f-4913-88e1-0a278d99f90d@amlogic.com>
In-Reply-To: <9a8e0391-c73f-4913-88e1-0a278d99f90d@amlogic.com>
Message-ID: <t4xy6q.vhi5j58gpfcw@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT

On Tue, 28 Oct 2025 11:08, Zhentao Guo <zhentao.guo@amlogic.com> wrote:
>
>在 2025/10/27 20:57, Christian Hewitt 写道:
>> [christianshewitt@gmail.com appears similar to someone who previously sent you email, but may not be that person. Learn why this could be a risk at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> [ EXTERNAL EMAIL ]
>>
>>> On 27 Oct 2025, at 9:42 am, Zhentao Guo via B4 Relay <devnull+zhentao.guo.amlogic.com@kernel.org> wrote:
>>>
>>> Introduce initial driver support for Amlogic's new video acceleration
>>> hardware architecture, designed for video stream decoding.
>>>
>>> Compared to the current Amlogic video decoder hardware architecture,
>>> this new implementation eliminates the Esparser hardware component,
>>> enabling direct vb2 buffer input. The driver is designed to support
>>> the V4L2 M2M stateless decoder API. The initial phase includes support
>>> for H.264 decoding on Amlogic S805X2 platform.
>> It would be nice if you can outline the additional hardware the driver
>> plans to support so reviewers have perspective on where we are now, and
>> what more be coming? - the community would also like to understand if
>> this driver will supersede the stalled driver attempt in staging.
>Yes, we will follow Amlogic's overall upstream progress to support more 
>hardware
>platforms in the future. The next step will be adding support for 
>A311D2(T7) platform.
>We also plan to replace the stalled driver with the new stateless 
>decoder driver.
>The new stateless driver is fully compatible with the old G12/SM1 
>platforms, making
>this transition feasible.

That's awesome news! But how about the older platforms such as GXBB
(S905), GXL (S905X) and AXG (A113D)? Will support for them also be added
or not?

I and probably many other people still have interest on these older
SoCs.. they otherwise run Mainline linux mostly fine, so if a working
vdec driver comes along for these, that would be great!

Best regards,
Ferass

