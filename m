Return-Path: <linux-kernel+bounces-730323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F467B0431F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244D71798F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF2225D21A;
	Mon, 14 Jul 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1UMDOTP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB725C821
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505824; cv=none; b=cTs/XAINJjYsCaFMzOXH+vPtnVhCsQieBvfj7lmG96aTdTyadpPHi9IktaF51Pik7nOFYzJxodYJUq8F6ewwyo/bK5+7mUwvgpp6QrduqEiDrQjKEJ4XK/b+O7MziQpLXZpicsT4ypJMJxToy4ghcNqpSdTxdnMRkCSer2UgOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505824; c=relaxed/simple;
	bh=uMFTP7eyQLPoIYG0BRVJ3E4Yhfci1xgM3+nFkDbhxQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuMJBiPgJG5t1U7gOkOSKEJDq4iT+jnGUEgcpZDDLCacWT8m4yknjDnKcGxBIgnFMM2VSCl/8xZyLIgck0IMX1IH6l1VRfUWzcXHlDsZxCuNGWQYhfKYYDMJbm8aK5WSY6AbGpzkBJcoyzbRLacnAq0j4Pd1zw5mYMK0OCxLgb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1UMDOTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B17CC4CEED;
	Mon, 14 Jul 2025 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505823;
	bh=uMFTP7eyQLPoIYG0BRVJ3E4Yhfci1xgM3+nFkDbhxQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1UMDOTPuEQAkZ+fVJ/TyCjeU/OL8dqSnsyY7onRVnphCY3dO3olPAhsVt28C+t4M
	 Ju0b8MxOQJWsQ0xZEOTLaMeoFGOmcXVFrApOpee/FY1HAPoBEG69Xc1u/6waJEbVsF
	 xb1pRJsFocsoJ+MeHFjFfe4AlSk69Gy2Lck15ZpBVRLCBA7ucHw4br85IYo7SVEcKQ
	 lWLR1DIo83jK51SzVgBkAHsGxoUd/Js0j8CCpMOiKpbo+pJWbnY//OwzozswU3MGZY
	 PlkgaEZeZYUPziRUwMXHL05l890baPB8mFGNzQGPy5Z39h5dxlF0BLRsDIwrdtfbLU
	 7vD80vbUcttnA==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	hejunhao3@huawei.com,
	jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com,
	linuxarm@huawei.com,
	yangyicong@hisilicon.com,
	wangyushan12@huawei.com
Subject: Re: [RESEND PATCH v3 0/8] General updates and two new drivers for HiSilicon Uncore PMU
Date: Mon, 14 Jul 2025 16:10:11 +0100
Message-Id: <175250413862.1548947.3288364780792858607.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619125557.57372-1-yangyicong@huawei.com>
References: <20250619125557.57372-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Jun 2025 20:55:49 +0800, Yicong Yang wrote:
> Support new version of DDRC/SLLC PMU identified with updated ACPI HID and
> register definition. In order to support this, we do a preliminary refactor
> to initialize device of each version by using driver data of each HID
> rather than checking the version. This will also make the driver easier to
> maintain and extend, since only the HID specific information along
> with the new HID will be added to support the new version without touching
> the common logic.
> 
> [...]

Applied first six patches to will (for-next/perf), thanks!

[1/8] drivers/perf: hisi: Simplify the probe process for each DDRC version
      https://git.kernel.org/will/c/dc86791ff68c
[2/8] drivers/perf: hisi: Add support for HiSilicon DDRC v3 PMU driver
      https://git.kernel.org/will/c/17aa34e86936
[3/8] drivers/perf: hisi: Use ACPI driver_data to retrieve SLLC PMU information
      https://git.kernel.org/will/c/29614c55fe6f
[4/8] drivers/perf: hisi: Add support for HiSilicon SLLC v3 PMU driver
      https://git.kernel.org/will/c/1fd20ba0a1dc
[5/8] drivers/perf: hisi: Relax the event number check of v2 PMUs
      https://git.kernel.org/will/c/35f5b36e8cc2
[6/8] drivers/perf: hisi: Support PMUs with no interrupt
      https://git.kernel.org/will/c/e480898e767c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

