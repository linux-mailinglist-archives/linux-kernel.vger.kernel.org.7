Return-Path: <linux-kernel+bounces-795743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBD8B3F741
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F1E4E2E03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076112E7F3C;
	Tue,  2 Sep 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffFZXkUr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659FA2E7BC7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799889; cv=none; b=FBQdzrmTz/+sBpGmTChu2f+VGAEOOHH1mIMwMqv210hct5xCzZbwofkEbciwLB/eWf9aJhGtN6G/jn8UNoiquvR5ka2EXrOeuW/fZ0fhxwLQxGyzpU1gX58Jl4r09DzLlvk524jvpEm73IFNT1WROS7oFSP00E2WnYwFuDVRFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799889; c=relaxed/simple;
	bh=riOnAUL1YikSHM62NdMXH51YihXKSKw+RyHmow1WIxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XEXTmbSWEMvGeH+vTQVjOTJezAimoxu+kJeWc4vWuhh7phQ+CqWHYM1v52diU0X+VJvg0lZ/CbFuFnKKzf7wSKUAU3+ZZQo7N5DwJRiyk92dafC1T/f0ewsd0xVTZLDz8AqK8gXZ9A+9dA0BSxrlwVW67DnEJmJ5EJpxXJWxK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffFZXkUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8DCC4CEF5;
	Tue,  2 Sep 2025 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756799889;
	bh=riOnAUL1YikSHM62NdMXH51YihXKSKw+RyHmow1WIxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ffFZXkUrM2n6p0P5TVZjq/FqCHhPooh5t3XbJsFtxYG8u6PptaqCntQSYAWvu3cHt
	 32CzNSsXbhVi0xHnBhVGYciL1LQVjetcGSbBGoTXaoM3S2/SsaeCA9Y0sL+kr7TBbn
	 /98mMCTVxmnU7kpMbXKF9mJ4ET4k+TP3wzq3l9bUVKKNUTkcTcPMvpo6+nPd4RBinr
	 Wd60hoAPRjpdHB9v7/iVzeNGNEQyuGTa2JB2tg22mbnzbx8l3guLNQe36MpEHV5uiX
	 zmsrlBN32PItAZI39j/QfV+T79EVsEzFPnJbhxaDxftRsB1BSjPYtk+/KKQJl0pucD
	 WqnM421cnaM1w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250804130726.3180806-1-heiko@sntech.de>
References: <20250804130726.3180806-1-heiko@sntech.de>
Subject: Re: [PATCH 0/4] mfd: qnap-mcu: Some fixes / improvements
Message-Id: <175679988816.2174534.8796703637805096491.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 08:58:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 04 Aug 2025 15:07:22 +0200, Heiko Stuebner wrote:
> While digging through the mcu functions, I came across some deficits I
> introduced with the initial driver submission, so trying to make that
> a bit nicer with this series.
> 
> 
> I struggled a bit with the ordering of qnap_mcu_write error-check
> and conversion to guard(mutex). Converting to guard before the
> error check would need dropping the ret variable, just to re-add it
> one patch later - to not cause unused variable warning.
> 
> [...]

Applied, thanks!

[1/4] mfd: qnap-mcu: include linux/types.h in qnap-mcu.h shared header
      commit: f7ef7c03d8599a0d86b2a05929da73358cd56dcf
[2/4] mfd: qnap-mcu: handle errors returned from qnap_mcu_write
      commit: 3d02c538ec5337b66750d83ce6f861aef263fbff
[3/4] mfd: qnap-mcu: convert to guard(mutex) in qnap_mcu_exec
      commit: 5fd101541c6d0f0ad3b14d86dfcf9347c3f3bffd
[4/4] mfd: qnap-mcu: improve structure in qnap_mcu_exec
      commit: 6cdb0fbe090be966432db041d5650907a4dceac4

--
Lee Jones [李琼斯]


