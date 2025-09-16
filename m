Return-Path: <linux-kernel+bounces-819403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB703B5A01E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AE61BC288D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BFD29617D;
	Tue, 16 Sep 2025 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OK93RaaW"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7B27E04F;
	Tue, 16 Sep 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046095; cv=none; b=HDpf5yXtMe1sdCU+9uLh8jUr1AkaPXw9rQNGRXOI7n1tBXs2+uOoU4m2vcREF0OF8tOUhSfHQKFKVvogqNEP9MFjPD/pYyzMmjFo+u1AYSV5ZEy+flz2sz+yHsv/Y4tV9vuP15UxgMfEZ/y00P4/3bEt2NpCjVLNje2vMRL/9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046095; c=relaxed/simple;
	bh=HVIAurRXmIXwxwsBwpt3ginMb+fRbhUIRyEdhVqSAVw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Xg/6ibtGXhoMAZmDGmc8NbNA3kUm1LrxhV10FB66DQanLtfogGaZ3FGZspHL8/mvlrTlBQVPmJs+GOfEUCzfnzQF8nYWlp5B3yTG1KhdhRrWQH1Qye4Z6oikJOQX6RYCKfXmnFxoEbpRgcufNmeKZHcXnX3GFjsB6bXYiDUng9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OK93RaaW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1758045732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcU9A/tq5+oi7hBJMmArLeP3C7GfHr2OsLC6PY1wg9s=;
	b=OK93RaaWnkocTLdikKRF0xvCK4IJRIQo6zYoBR7M12A6V/i7Zi5vN57SMabR1ftqdaiI3w
	5wSLj4Mfkuf2tXJqc3W0aZuWIU8YW9Vl+dEpHg8pITdrNSw5q6QKLPi8BP+3P4qjnF4C8y
	SVEC0R9sqUpg5yxi09dHu9zRUZ+93c3QxzqO+j6BMTDoH7FsyCqDDv+c/E+4whne1ajLiV
	2TgyQ76s7OaKndeTm7VISUBiHz6Bj+3/DBGEj7Ay178jZuK2ZvXBydCsWz1KU4uFOuTD5E
	ffdSwca6Lv5D++1so5EcGqNa3YRWBnoGEb011jxbfK2HjksK7ygi34w28akJpg==
Date: Tue, 16 Sep 2025 20:02:11 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andrey Leonchikov <andreil499@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, dmitry.osipenko@collabora.com, tglx@linutronix.de,
 amadeus@jmu.edu.cn, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: arm64: dts: rockchip: RK356x: Add OTP description.
In-Reply-To: <20250912135542.2304150-1-andreil499@gmail.com>
References: <20250912135542.2304150-1-andreil499@gmail.com>
Message-ID: <957705f3b0f6407031f76ca433a0541d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andrey,

On 2025-09-12 15:55, Andrey Leonchikov wrote:
> Add OTP mapping, can be used on future by drivers.
> Contain a factory-programmed values for a various peripheral.
> U-Boot already use "CPU-ID" OTP value ("otp_id" on this patch).
> All values from original Rockchip sources tree on github.
> 
> Signed-off-by: Andrey Leonchikov <andreil499@gmail.com>

Thanks for the revised version of this patch.  As Jonas already pointed
out, [1] this patch needs more work before it can be accepted.

I'd suggest that this patch is temporarily dropped, and I'll include it
as part of my upcoming patch series that will handle the SoC binning,
with the appropriate tags.

[1] 
https://lore.kernel.org/linux-rockchip/6bd28aaf-aafd-436e-8799-fcdb07082660@kwiboo.se/

