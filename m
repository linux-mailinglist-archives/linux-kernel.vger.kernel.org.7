Return-Path: <linux-kernel+bounces-795801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B8B3F817
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A437A3CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D02E9746;
	Tue,  2 Sep 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kymjQBQ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2182E9737
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800817; cv=none; b=cHim7d0g3tTIfr2WSuGWOClmZgqRBy/moUcv/KfLPr7WT9CZaYPuigH+StLMcnVdpHxOR8JO0KOXQcxMcxj0iPfe8MGCfS4wdbTb6TXVR1a1ZQxitiFzsiYRrkYImi63xVLYXhwM9a+gppr9soZofHu64vVLvFpFgb4p7qmSnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800817; c=relaxed/simple;
	bh=dH17mHT6Hgd/00oH7t+KQOwx4aGQnK9BGMQ2Ki1HLTk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PQr34BSl54Hfi9m9+OsRK2JNM7UN48T3XFBedALt48mXZAugCvVM+ECsQfw0r5UaxnDpwTo0wCSz7vm1roKEQVlq3sMQzLtm+hVLpKPW4pfcz07d2dzcEtgYuc7cvtHmJH97/kDSO1itcvduvWV9yezN9GTmWKuiYYHrkkxeXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kymjQBQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C470C4CEED;
	Tue,  2 Sep 2025 08:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756800817;
	bh=dH17mHT6Hgd/00oH7t+KQOwx4aGQnK9BGMQ2Ki1HLTk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=kymjQBQ0zYC1sPfoIKTI5SrKHQN7lap/ZLixzvrQ417pKLMK1aEX/QoLDrpPqZ2Sy
	 LgwTGGElKCIblubT/mTWIwggtCY1Rl9NW4z0T/JfmaQ+2np1Z7vT+OCN2BuOQyyX8Q
	 uPtcCYJXjUV+d/eukkdNJ6+W/nP83Qi/idg1uM8CBTywHhFHe7lRsMfR2J1Q52giUo
	 fW+z3F3dyoEIT/1bwuQCJamgvYQc/YK0UwB3krCcEYhzIUgx8MWtCNb0r5RGwNT9/i
	 M+fWMWZqUBBV8ojr88o8o6+QeMaamzY4npn5GHgA6AVnC0AbkUNcsqKJ/90BWn3J4w
	 DYXt6F2NzY28g==
From: Lee Jones <lee@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 Jens Kehne <jens.kehne@agilent.com>
In-Reply-To: <20250804133754.3496718-1-jens.kehne@agilent.com>
References: <20250804133754.3496718-1-jens.kehne@agilent.com>
Subject: Re: (subset) [PATCH] mfd: da9063: Split chip variant reading in
 two bus transactions
Message-Id: <175680081626.2184374.7626461049800985884.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 09:13:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 04 Aug 2025 15:37:54 +0200, Jens Kehne wrote:
> We observed the initial probe of the da9063 failing in
> da9063_get_device_type in about 30% of boots on a Xilinx ZynqMP based
> board. The problem originates in da9063_i2c_blockreg_read, which uses
> a single bus transaction to turn the register page and then read a
> register. On the bus, this should translate to a write to register 0,
> followed by a read to the target register, separated by a repeated
> start. However, we found that after the write to register 0, the
> controller sometimes continues directly with the register address of
> the read request, without sending the chip address or a repeated start
> in between, which makes the read request invalid.
> 
> [...]

Applied, thanks!

[1/1] mfd: da9063: Split chip variant reading in two bus transactions
      commit: a0d1178ea4778fc1eb1691a97619ecdb8a3bda13

--
Lee Jones [李琼斯]


