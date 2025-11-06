Return-Path: <linux-kernel+bounces-888316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC9AC3A77A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48DB9350E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFAF30DD1B;
	Thu,  6 Nov 2025 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL6kz8Wl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B3B30C600
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427369; cv=none; b=fcmlaFXszZgFdZv3MiBxUOnQB/Hq63QkLgnh7wSrsWrCMrQR4Txb1LD2XKHxH9ZC3Ug9n7IDeoYNr0nTKeFzzOJEvK4ZfbOq1pUEM6hngjBMxDEiTK82Ned+CpDJifxB8MkEV4NyxP/eiBXhgHgJGdWqNieG4l9QT997gJDK8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427369; c=relaxed/simple;
	bh=uhM1UTWuc4g7yfe725dymwVdxVySHHcDwAeuexSN2yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozOuFRh6fhgOlLlE7WhSCXX9iGrnKuXk0xp5Zt9DMMJT2hFbpokdTOtFBJgiahleYz1jU3LbivWtmMti9u46qYQrXmnagF1D6si/ZmTX93SsyxLyubZiyNvBgsXT51yyleUEIVfWy5NKKSMYAH574G6k9g5572AtKXFIGylXDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL6kz8Wl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7593C4CEFB;
	Thu,  6 Nov 2025 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762427368;
	bh=uhM1UTWuc4g7yfe725dymwVdxVySHHcDwAeuexSN2yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mL6kz8WlTmJjNJqedBX0TY1yoHLfuUiTUGv458coMnAprpdATD5FdEwsYB2iLgnoK
	 obnRcKmRUsiZKbUTBMVHeXPEZSuqAC906io+As0NMx2GrcMUuuxPlp2Iy+cwFnmzD9
	 FMx6UAZ1Ah9u17oq0gewqQwwqu+Lr3oo4qDEKBw0lYK3GRxSiUI/B4qGMiG28vECxf
	 FsTxCW6YUlmiOQGB2Z8qIbcyWp0gK+/Lqr//0ttsVQ38QSJwtVnoFardk4P4KWNGjA
	 suvKgpPV10uslUFqx/O9rPGKGYY/wn+ePBFBiLkREqtOilY1+QCaYfCNM0QgP6t3kH
	 vJdbejYsOQtHg==
Date: Thu, 6 Nov 2025 12:09:24 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Marek Behun <kabel@kernel.org>
Subject: Re: [PATCH] platform: cznic: turris-omnia-mcu: replace use of
 system_wq with system_percpu_wq
Message-ID: <q5cbnsaka64hdfri2rktu2ddu5adcbengtffexiy6hsjwzvyeg@etklpglx554t>
References: <20251105153718.274765-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105153718.274765-1-marco.crivellari@suse.com>

Acked-by: Marek Behún <kabel@kernel.org>

