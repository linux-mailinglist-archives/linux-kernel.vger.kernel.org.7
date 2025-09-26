Return-Path: <linux-kernel+bounces-833475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB389BA21AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD857562B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587EA72626;
	Fri, 26 Sep 2025 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl57E7fh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEED27E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758847407; cv=none; b=BYdYgO8oT516b7vnOS4Tz4xEmd5WrkdgCSXCmHI25Ua/AJv4mNSXjbqjumucC1TY5W4BtvmFQE5hmX6scRxLMPmPreT6mgJuVw7oJWbSovYOc2kzT40L6/htbSuAgPjoivZdMNK8cgjYLpdL8vCBPSyybztfzGe56p0N5DwRkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758847407; c=relaxed/simple;
	bh=R5AwY6reMT+hkszq0jHIk6/O1YZCgIsgfU6+UQvCVWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFRVIy6D6OMuuXsxWHxjLDzz0AdMI0q/dRKCYaOUAUC2GD6Ah3mEKf2QVu1AAN4UmRSIpvsj7syQoHGTgPg185KbaUCfS2mEPlhEIiP7ZTn7q/jD+51ujoYLuUTsLVqXtSNEqLJ11sDSGlni8cFRtKoKfniJFovkAeC9pGxxQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl57E7fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8A9C4CEF5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758847407;
	bh=R5AwY6reMT+hkszq0jHIk6/O1YZCgIsgfU6+UQvCVWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gl57E7fhZ8DqIgvwM0nMRP/DXf1FSjFCABVk7knk87AQP8l5wVjJ1OrEhIXLbFCjO
	 oKbYphKQ23LWUvnDBos4CsbqDejomkbQu4/Wl8KRPmzUibjkav8/bdVkDfxLMZjCPO
	 qLuEne61x6zG9UGnULFtGGci6PcmmfegCInhv46MHyhGShywlwavRJx/yAYJiymgdH
	 jiSr/51tjrCBdduQHEQWshMruCiNpjt9n9HpnA4KZVcRpRus79SpqfI9QrOx5FPfoK
	 z4A2gHO2pcOLwA8ptAGFJMrceRlxGM+tO0ipFDTC18jW5wq279TRrLF6ujsVEkUsqX
	 zJ9AmG5YKLY7w==
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d2c35c459so13672625ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:43:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlLm/hTEP04mLGdoJmllLR6OBUO8WM8jl9vXOH421krjCux5GEa+a2dWHpsK16VnxAj8la7yi/M8Fyyfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8cFjiLkV9iYZlRqmpvtx+W9KAf3z0+mAHWLCrSLwJ76xed2c
	Zvh0oVZJ4VzRS6aHQV+bvF96bWfllcLn3ECPjJq1pfQDPfML+klaqyQz+W1jhVRIjb/6I4tiJe8
	ZSnxolfoXe1/9ws8+ITwWXUgnCJV9bLY=
X-Google-Smtp-Source: AGHT+IHuE7lUJTM5NjBq9XyNywbeXtrU6kRpDRkGAl4f2osXROh+FGe/vjUXxkTy+Xyl1QFb2qNvoBguF7HigB6yATM=
X-Received: by 2002:a17:902:c94f:b0:24c:7b94:2f87 with SMTP id
 d9443c01a7336-27ed49d0885mr59873295ad.14.1758847406872; Thu, 25 Sep 2025
 17:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925092058.16648-1-ot_zhangchao.zhang@mediatek.com>
In-Reply-To: <20250925092058.16648-1-ot_zhangchao.zhang@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Sep 2025 09:43:14 +0900
X-Gmail-Original-Message-ID: <CAJKOXPeLRZR9VkB3XHtCPDxT6-6xt6GkwJ-mLkw9hQNV2piJZQ@mail.gmail.com>
X-Gm-Features: AS18NWDL9JQ94XF1lGikABrmZ_SQTpxybLBch9JyjPz9vNsiAWV_NCfTqCxYNZA
Message-ID: <CAJKOXPeLRZR9VkB3XHtCPDxT6-6xt6GkwJ-mLkw9hQNV2piJZQ@mail.gmail.com>
Subject: Re: [PATCH v8] Bluetooth: mediatek: add gpio pin to reset bt
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Luiz Von Dentz <luiz.dentz@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
	Chris Lu <chris.lu@mediatek.com>, Hao Qin <Hao.qin@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 18:21, Zhangchao Zhang
<ot_zhangchao.zhang@mediatek.com> wrote:
>
> Support the platform Bluetooth to be reset by hardware pin,
> when a Bluetooth exception occurs, attempt to reset the
> Bluetooth module using the hardware reset pin, as this
> method is generally more stable and reliable than a
> software reset. If the hardware reset pin is not specified
> in the device tree, fall back to the existing software
> reset mechanism to ensure backward compatibility.
>
> Co-developed: Sean Wang <Sean.Wang@mediatek.com>
> Co-developed: Hao Qin <hao.qin@mediatek.com>
> Co-developed: Chris Lu <chris.lu@mediatek.com>

Wrong chain. Follow submitting patches.

> Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
>
> V7-->V8 modifications:
> -Currently, the universal reset GPIO can be found by configuring DTS.
>    USB bus can get the device node and reset GPIO in the probe phase.
>    It is fully compatible with other vendors' methods of getting reset
>    GPIO. Therefore, the previous complex methods of adding the compatible
>    string in btmtk.c to get GPIO is discarded. Abi files and yaml files
>    are no longer needed. When a Bluetooth exception occurs, the existence
>    of GPIO will be determined first. This change improves the robustness
>    of Bluetooth recovery on platforms that support hardware reset, while
>    maintaining support for platforms that do not.


You didn't even bother to compile this code, which is obvious from the diff.

I think you don't understand how patches and Git work, but these are
prerequisites for submitting your work here.

Please share how this passed your internal review - four people had to
write this code which doesn't even compile.

