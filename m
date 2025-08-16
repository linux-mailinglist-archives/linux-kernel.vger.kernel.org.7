Return-Path: <linux-kernel+bounces-772296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 430D6B290F6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 01:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02F21C82E69
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23010245005;
	Sat, 16 Aug 2025 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQDseDI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB701EDA2C;
	Sat, 16 Aug 2025 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755386872; cv=none; b=kqgPW+qsan4WSkEB9ahu29tEfu5ZwUoZGb9ds12HamJWvlLqsnOy6AA3anHkoiMNzVzeRMgBStMUsPGRCsSMCqx9hauLo531HTF6TxwjURJrMwVSt4UnG3SEuo/IQtLS0D92rYce3zQpWwQaAGkpHiMXxocEorKj5omNK+dQZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755386872; c=relaxed/simple;
	bh=MH+pLrfbqWRbgWT2IxanHwfX7q2c5M1yYZ9GbKJV9eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib9lQMpQKArl0hzXJTZIGibeX4dMKNA6Js1cafKZArx3xByWiopNpLcGjrGjEnjn6oX31YqfUjgh6kk36KyM4xzFU/XoOtr/z1qtMGLkU3ioOZpEfaP8G5GzPGuRh8epf9E20UrKN8V+vR5ZTLWEHA5gCUERHah2NmrhX7jBQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQDseDI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BB7C4CEEF;
	Sat, 16 Aug 2025 23:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755386872;
	bh=MH+pLrfbqWRbgWT2IxanHwfX7q2c5M1yYZ9GbKJV9eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQDseDI+FFcvvdiy01zIsv/Uf0VWNABprBq5D2c7VYRYlj2++c8UJXCvMqvIk+pYl
	 5/Twb+qgl2XMD84h+C4e+My2OQfYEz4UBWY9WqV/XcmKCZsrF8I5zTN8wQcigef0s9
	 /S8Lkgfs3DXkNG94GNK71oeC7PiyCUfbx2zjGEbBCZut1Hjlwu4WING7S02RdiXxf1
	 wbKqcqBE2zZsdLjKn1fgwzcH22omt8GIoCedunvJTVenSsxcYraXeo/gfHRmBqX7or
	 qn7ke9AaP0rJ8ald/m/LKEYZCkIN0IL258E98xa1PrXt99ElR35J5Mw6XSrNzTiiAW
	 o6bY4nXkuBhhw==
Date: Sat, 16 Aug 2025 16:27:50 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: dts: thead: th1520: add soft PWM fan for
 Lichee Pi 4A
Message-ID: <aKET9i0/+INnOMoX@x1>
References: <20250816093209.2600355-1-uwu@icenowy.me>
 <20250816093209.2600355-4-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816093209.2600355-4-uwu@icenowy.me>

On Sat, Aug 16, 2025 at 05:32:09PM +0800, Icenowy Zheng wrote:
> Because of the SoM+Dock design of Lichee Pi 4A, heat dissipation does
> not work well; fortunately it comes with a fan port with PWM driving
> capability.
> 
> As the hardware PWM controller of Lichee Pi 4A isn't ready yet, drive it
> with pwm-gpio driver (software PWM) now.
> 
> A long PWM period is used, because not only software PWM is used, but
> also the fan port is a 2-pin one and fast PWM might confuse the BLDC
> driver on fans.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 53 +++++++++++++++++++
>  arch/riscv/boot/dts/thead/th1520.dtsi         |  2 +-
>  2 files changed, 54 insertions(+), 1 deletion(-)

Is it possible to reconcile the work that Michal is doing with the
hardware PWM controller series [1] and this series?

The PWM controller does need Rust which works okay for me when using
llvm but that might not be the case for everyone. Maybe there is some
way to use the pwm controller if available and then failback to gpio if
not.

Thanks,
Drew 

[1] https://lore.kernel.org/linux-riscv/20250806-rust-next-pwm-working-fan-for-sending-v13-7-690b669295b6@samsung.com/

