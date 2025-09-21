Return-Path: <linux-kernel+bounces-826251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8046AB8DFDB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B3417CF19
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB96256C6D;
	Sun, 21 Sep 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKnIYujz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D5158DA3;
	Sun, 21 Sep 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472346; cv=none; b=qo9d1XbZpd/RrLTCea9p9Hhocu6XAvCkHC52oeBG3SZtP1JYu32dWzAyjNhSziWsFi5YgBSifJ67LVY5iaH6m8hBcufq493UT8LaQ7B/NGCALVrCyKiNdWz+aRiap9jB4Dm1TP+eOvtqpXe//5vrcvTADebi3DdsGOSKqpQC8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472346; c=relaxed/simple;
	bh=soBa2oezW8nf4zezqJfB5iwthPmZMENdZKVAQmbO2XA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=baazaNrE6bxIvhwKh8JNkv05cN8ghtFbjvkDEN8+peNV/4ll23pvlORQEs5VsOTZTxJ9t2loGVs6ATdQIU8jR1ieQPBBVhi9ZPuJPFjF5OtQxcrmFknYs9ForR9dPjKFwrS3W62pxStCBbXCvzvrRxYKpIc1sk6nCPr8H/0DLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKnIYujz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4154C4CEF7;
	Sun, 21 Sep 2025 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758472346;
	bh=soBa2oezW8nf4zezqJfB5iwthPmZMENdZKVAQmbO2XA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CKnIYujzbTwu5Lo7/XYXeS7fSJU4RVXtGBdaWZj3a3/Wx3rosl+J4a6Ot/hcqFmqx
	 b8lv3xchNz3iTnEYrFvk/euKkEkQS9UARo2Yx+deo6AwqxzsxKGydhCZ3vJ/NwSPMo
	 xRzqnw4+BMY0fDCIv24EDbJdpQeo5iOu5TE79KQuZ769xCrK3FzMOLFlMVQHUhXgUa
	 J2vIIB/zPENl5ADQF8KIWuCjTC2v7RCvWAUh4F0Djit7cdHZm+1VzAsu/0fEYbX7og
	 rm/xo87sXjlU0ZD8vULeHzABHoc4m706Ze0xZRpDv4sUuQpRZeO09gOnLp3zuLA2lF
	 AX/kUxzEaVqIQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250724083907.61313-2-angelogioacchino.delregno@collabora.com>
References: <20250724083907.61313-1-angelogioacchino.delregno@collabora.com> <20250724083907.61313-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/3] clk: mediatek: mt7622-aud: Add missing AFE_MRGIF clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, mturquette@baylibre.com, geert+renesas@glider.be, u.kleine-koenig@baylibre.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, robh@kernel.org
Date: Sun, 21 Sep 2025 09:32:24 -0700
Message-ID: <175847234471.4354.16926506985701266468@lazor>
User-Agent: alot/0.11

Quoting AngeloGioacchino Del Regno (2025-07-24 01:39:06)
> Add the AFE Merge Interface clock used for the audio subsystem.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next

