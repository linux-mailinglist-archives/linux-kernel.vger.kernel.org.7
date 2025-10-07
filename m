Return-Path: <linux-kernel+bounces-844008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A621BC0D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88EF3A8436
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8E2D661D;
	Tue,  7 Oct 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="bH3h03gJ"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370432D6E4F;
	Tue,  7 Oct 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828270; cv=none; b=hfmZp0QNU2wt+uURnbNGT4biyXAFPHvsHzn8XwEcOObFDet7Z0RD15DItF2lH0a9kEU9LlhlhxU4NIpKjAKwBqybj/SqwaJBIHynLLhQMR306Q9vrvqfoXDHFj7iCQthoM2edZkfG02VxqKNcVQV6/+oc2Tcb2QKCJ19GEsM5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828270; c=relaxed/simple;
	bh=YCPXdnG5zQAocVXJ3TiIrBnpkKTBpqwF0eKVaj6G9aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay1E1N8xiBXvizIHdq+BVCF6JIl/Tl+GHHJXdiyOkHbj3tae/Ezkm1vHNqT1mRCCNpzbbmq2s80GFf/K2pFwYFWQ/h3iABzIMKJUwSvzGpzzqF9MU2jtoAx0pFKbWjKeas5nnLBAGGUOBxgYRX8AlBNXhRrzIfWExOdwMnXcz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=bH3h03gJ; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1759827912; bh=YCPXdnG5zQAocVXJ3TiIrBnpkKTBpqwF0eKVaj6G9aM=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=bH3h03gJn2Olv7O538Cv+ijkF+N4ZzLrxe9yoduUJCcd0s0Y6p9ALFEaiYfj+65hL
	 /JxpPE2biHy2FiKR8xH65AJKuZgQ92CyWpPPiO6dTW3UH3Lfyj6hMJDloe3/M3moz/
	 fZCZ1z14I8IYXdy/dsYZNZn1X3wWAFXoAysyMr6Q=
Date: Tue, 7 Oct 2025 11:05:11 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"Leonardo G. Trombetta" <lgtrombetta@gmx.com>
Subject: Re: [PATCH v3 0/5] Upstreaming Pinephone Pro Patches
Message-ID: <6joes3gufls2bx37gf2uoywyahlqprn73qfz6gfico5jxkua7z@irixdgkqp66p>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Rudraksha Gupta <guptarud@gmail.com>, Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"Leonardo G. Trombetta" <lgtrombetta@gmx.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
 <53eabe34a310ea9c74315fa09a604e4a@manjaro.org>
 <b01ed528-8b29-4a6a-bdff-88f2e3b5dd2e@gmail.com>
 <115da845d9161e6ecfa67cf189b84aa8@manjaro.org>
 <37f2603e-8c51-4f92-a7af-0e60cd577004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f2603e-8c51-4f92-a7af-0e60cd577004@gmail.com>

On Sat, Oct 04, 2025 at 09:55:19PM -0700, Rudraksha Gupta wrote:

> Awesome! I was hoping that others would comment on the testing I've done
> (especially for the accelerometer and magnetometer patches) as I can't tell
> if userspace is wrong or if my testing/conclusion is wrong. Mobile Linux is
> very early stages at the moment, and I suspect the Pinephone and Pinephone
> Pro were used as reference devices with Megi's downstream kernel. Wrong
> mount matrices in the downstream kernel might be affecting userspace. This
> means that with the corrected mount matrices in this patch series, userspace
> is slightly broken (eg. since I fixed the accelerometer, the screen in Phosh
> and KDE Plasma are upside down. I suspect KDE's Kompass and Leonardo's
> compass app might be the same if I'm changing the mount matrix for the
> magnetometer). This is why I decided to showcase the raw values in my
> testing. If my testing is incorrect, please feel free to let me know.
> 

KDE Kompass uses this as an algorithm: 

 https://invent.kde.org/smigaud/kompass/-/blob/master/src/compass.cpp?ref_type=heads

which is largely inadequate and doesn't take mount matrix (in_mount_matrix) into
account at all. So that's not a good reference app. Also it doesn't even
claim to support "af8133j" sensor.

Leonardo's compass app has its own mount matrices, when kernel doesn't contain
one:

https://gitlab.com/lgtrombetta/compass/-/blob/main/src/compass.py?ref_type=heads

which we can also use for comaprison/confusion and is different from what your
patches are trying to upstream. :)

regards,
	o.

