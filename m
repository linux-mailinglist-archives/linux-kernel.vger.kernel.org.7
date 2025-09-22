Return-Path: <linux-kernel+bounces-827656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DBCB9253D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7F4175F09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F33126CD;
	Mon, 22 Sep 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="slDo/3Zo"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DF3101DF;
	Mon, 22 Sep 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560395; cv=none; b=mTgfguAuLCCUm5aTrAipcLh8Qb/KFjjzZ1sFc+PpGjQfWcyxKKWBmWlL3nr5CkG8X6sQCwBgYHXaImYwipFRctbPNJZUKshgBvJxCtfcJ8n5ya0f1C+8VINkPEelYwoWGbXJ7FyogNzVnY866QkNeIgkCIGUpEAV8pzXTL2w0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560395; c=relaxed/simple;
	bh=WyeVZUr9UOZR4eTTeq2TQ6nQmLS0wUEiryNXHPbN7vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbOTcAkXm2N6lMKIeUdv1cSFyf53hYK8AyPmUN7c399MpxzMr6gaWf6XVkgobzMa1QMI2kknZriRz4vxf1DK4KxAGSbQLVwgW9diBT/Wij9Gh4Zoj7uq1aP1eq4TPghPrfBIcJDgTfNJQl8Ax9sO5LKBgjl3bjlQh/YjnYMVmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=slDo/3Zo; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1758560384; bh=WyeVZUr9UOZR4eTTeq2TQ6nQmLS0wUEiryNXHPbN7vI=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=slDo/3ZoJZMXKAxwXZ2fFlY2HKpdeQv4uMNN0M4TPjwwQU0XUl4h13ygGpKpa56N8
	 GXChkY2h37tQtX+bipUYaLibgP5/56F0ko9Z2TZ4/0OCIrWLEHsbTQrrSHib6S9wQE
	 iuHA1la2l/0MXjJYoSoollugh0WYZuwlHYCsquIU=
Date: Mon, 22 Sep 2025 18:59:43 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] arm64: dts: rk3399-pinephone-pro: Add
 accelerometer sensor support
Message-ID: <kkxecpaatgeqk7ru4maqtbgftiqmdjjweam2zw6xrvbbzpqy4a@nz6llsm37qdx>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Rudraksha Gupta <guptarud@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
 <20250921-ppp_light_accel_mag_vol-down-v2-2-e6bcc6ca74ae@gmail.com>
 <5b6ijumsm6bgqymsfc25frqzjlpiryq7iupuk2pokcb6d4bz56@yqrz6j3oj5ga>
 <649ca4a6-3158-4c52-bad3-6c266edd177d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <649ca4a6-3158-4c52-bad3-6c266edd177d@gmail.com>

Hi Rudraksha,

On Sun, Sep 21, 2025 at 02:07:03PM -0700, Rudraksha Gupta wrote:
> Hello,
> 
> > I'm not sure where you got this patch, but it's not from me (I know for
> sure
> > I never did any mount-matrix testing/DT patches) and should not have my
> > Signed-of-by.
> 
> This is where I sourced each of the commits:
> 
> - Add light/proximity sensor support
>   - https://codeberg.org/megi/linux/commit/f171bc7013bc7ad3de9af817bfbcbfa548ebe01c
> - Add accelerometer sensor support
>   - https://codeberg.org/megi/linux/commit/b0bb7633e073a6760fa213b8c4a78ea2e73c7bf1
> - Add magnetometer sensor support
>   - https://codeberg.org/megi/linux/commit/2f7e67f451f16eaf15b81aa1dbdf126d54927d35
> - Add mount-matrix for magnetometer
>   - https://codeberg.org/megi/linux/commit/d7cd2eab931e32fa94408a96d73b4e6c0616107a
> - Fix voltage threshold for volume down key
>   - https://codeberg.org/megi/linux/commit/7c496a5cc27ed4e38b740f36c2d8b2c62f80ae54
> 
> I will add my sources to the cover letter moving forward.
> 
> 
> 
> > Looking at where the magnetometer is mounted, it's mounted on the bottom
> side of
> > the PCB (U29 chip):
> > ...
> > So based on that mount-matrix should be:
> >
> >         mount-matrix =
> >             "0", "1", "0",
> >             "1", "0", "0",
> >             "0", "0", "-1";
> 
> Thanks, addressed in v3!

Well, it's not clear this will work as expected. Someone should at least test it
with some well working userspace sensor fusion program, that uses this
information, (along with the mount matrix for accelerometer/gyro) for eg.
compass feature or something like that.

Also I don't see this matrix in v3 patch set.

Did you test it? Any suggestions on what people actully use for sensor fusion on
Linux?

Regards,
	o.

> 
> Thanks,
> Rudraksha
> 

