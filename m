Return-Path: <linux-kernel+bounces-872482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A62C114FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D2564E6DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D1233155;
	Mon, 27 Oct 2025 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="s+Er8bD0"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFB2D63F6;
	Mon, 27 Oct 2025 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595356; cv=none; b=QnQuCcqWTty5amxx81FF8a0VQA5TzppVFCV1Km470VUKSeLq9tTxpGOKUeztMhYgfHOje+6at9hgqh9LNR1ZYTvljCQ8hqi1LbMt2n3B+tO8931Lc05z6peMwTwnsd9F0oMbYPAl45DERKMHh31zjcH+GREOLb73HkKCppENOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595356; c=relaxed/simple;
	bh=uZM06T+w1ikMeWwyZNy/+H/hwOfViLTy9qKNMRqlBMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKRxSmIg7znB4noSmv3O1c85oVgy05xKCokzgLQFQLUjLxvxXNJ85mJT05NfLrtYo4Ijb/tHo4jlweAJvWnu7ox0aXUZfhfmb1YLncCfOLGlufK1rNDgdm5q6OAozDaDpvXaoIibORUtVlobzPgjCH43I2161d5HQRGDZZgo514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=s+Er8bD0; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B47740467;
	Mon, 27 Oct 2025 21:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1761595351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wlz4c6idBHgoakGdogx07IHOxQ08Zrz28QTnBsOB96g=;
	b=s+Er8bD00Vh0zoFn1jyeFeDozj4hRXhzbJySMH1fBS4fpcF+R/hRSjBYDDQ8A418n6f5d7
	UAbllmRWq1YZfRBjDizPOfTxF0c2uzyacC/4PRUSFDWoEoiDPmOxE9ygOBGyxPobAx4EPS
	M0vaQFwmPcvidS6cWLk6Q4oejdCPxbepVGNkEVfgJfLDbFeejOP6lnPVV/w9B/M7xxFqfV
	Tbq1Qt0++TTEniW4WEj5A8ZtFnVJvdhhYO8yLaqLQZ8X8MztfasawpW6h8a9bGp4tCrvoe
	EMdi9kYJZVQ7CMhGn8LuGGANIr1yaiokCBht15DHYQRrkaaRRd8aV0xxNXCM3w==
From: Dragan Simic <dsimic@manjaro.org>
To: sigmaris@gmail.com
Cc: alchark@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: pwm-fan overlay for NanoPC-T6
Date: Mon, 27 Oct 2025 21:02:13 +0100
Message-Id: <20251027200213.1821809-1-dsimic@manjaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <d583ee43-38c4-40fb-b33b-ce3153c9723b@gmail.com>
References: <d583ee43-38c4-40fb-b33b-ce3153c9723b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Hugh and Alexey,

On Mon, Oct 27, 2025 at 7:08 PM Hugh Cole-Baker <sigmaris@gmail.com> wrote:
> On 27/10/2025 09:14, Alexey Charkov wrote:
>
>> Is there any downside to enabling this unconditionally in the board
>> .dts?
>
> Only that it goes against the principle that the DT should describe the
> hardware; the board .dts would describe a cooling device that doesn't
> actually exist on the base board.

Having a separate DT overlay is perfectly fine if we want to
describe a board absolutely correctly: if the fan actually isn't
present, the operating system shouldn't be made to think it is
there, especially if there's no fan RPM feedback, which is the
case on almost all Rockchip boards that support a fan.

Preventing the kernel from managing a non-existent fan might even
save some CPU cycles, ending up producing a bit less heat, which
can only help in passively cooled setups.

However, the practice so far has been to describe the fans in the
main board dts files, if the board provides fan support, regardless
of the fan being present in a particular board setup or not.

> I guess then in theory, an OS might allow the SoC to reach undesirably high
> temperatures if it's relying on the nonexistent fan to cool it down. But I
> don't think this would be an issue on Linux, at least, in practice.

We're safe, a thermal runaway isn't going to happen when the fan is
defined in a board DT but actually isn't present.  Thermal CPU and
GPU throttling will prevent the overheating from happening.

>> Overlays require more user configuration, and not all
>> bootloaders support them directly (e.g. systemd-boot users would
>> struggle). Compiling with overlays enabled also makes .dtb's a lot
>> larger due to added symbols information.
>
> Nowadays (on Debian at least) using overlays is pretty easy, I'm using the
> u-boot-menu package in Debian, I just copy the overlay(s) to /boot/dtbo/ and
> it detects them automatically and adds them to extlinux.conf for u-boot to
> apply.
>
> Couldn't systemd-boot users just use rk3588-nanopc-t6-(lts-)with-fan.dtb as
> their single DT to load, if it doesn't support applying overlays and they
> want to use the fan addon?

Yes, that's an option.  However, that in general doesn't resolve
the issues arising from systemd-boot users wanting to apply more
than a single DT overlay.

> FWIW, I haven't noticed any problems with having a larger .dtb (using mainline
> U-Boot to load it) and several other RK3588 boards are also compiled with
> symbols enabled already, and I haven't seen any issues reported with them.

After thinking a bit about it, I'd support the extraction of fan
definitions into separate DT overlays.  As I wrote above already,
not managing the non-existent fan might actually help a bit with
passively cooled board setups, which is a good enough reason for
me to support separate DT overlays.

If we end up agreeing to accept this DT overlay, I'll have some
comments on the way cooling maps are defined.  I think there's
quite a bit of redundancy there.


