Return-Path: <linux-kernel+bounces-765289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12A8B22E21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1263417607B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11F2FDC34;
	Tue, 12 Aug 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTrh7gzG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD82FD1D7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016898; cv=none; b=uOzeQnqClrNoXrGgdt68GZ5UA2yolxHbaCwrfH1HQWLsPsqxBm1z9SxjWGZdfBqgYYa7LMtxwm6rmP8YYf3woHy9PX7qf6aK5Kwvdj574tbVQXR/00/bbVFMpSfam0QHI3s1ezzali6+4toDBg4xSbnWQ/PlED9bNSh6L1JruYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016898; c=relaxed/simple;
	bh=ptedwgzuDsEGl1cN2Loga4AsZu/U6huv+JI5qvZuTzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bSL3D0s4uSjEJta/QzJxmZ/9FIqLFehPKgogekVQ7PxILr20uaJ8871woeLZJ0/HcuD7Z2x46FtE4vXplcR88O018G7xI8lr7vBaPk5+v31Kl8u+XqFePKaN3kKTNkNMHfiyeO7IVWRitNKcGAOixPn6txEVrvFlhdv2uOxfWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTrh7gzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C259EC4CEF0;
	Tue, 12 Aug 2025 16:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016897;
	bh=ptedwgzuDsEGl1cN2Loga4AsZu/U6huv+JI5qvZuTzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bTrh7gzGt+Fd5cXKsZBHSmWy9H1GO+/m1PHOz39g5+TR2f+zx6L03J6M0t2iY8qd9
	 zuMbyjQlE71g2ZHkDn5qDdgMJUxf6ZliEy6UINEmGfd6v0V8eGqAmJR69KKivA8nuC
	 zgsTHpDYduKaZAhaf+ut3RmW/q9vMjANjCNl7hAZgjIK5aJ6U/NhwqK+od1RgOzElP
	 MuU3lZapBcpaBlSJvIcGKVSwlIywFI6odq8mVoTod9zuvNBO5UvH91KF6KuMyiMQVg
	 mUi1pMf2fJbNPuW+vBR9L86nUthYxvksOZk6elxxK4t6Px/qbB0sdxVcrAp4Xq8o9V
	 nFgv6evA468Nw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jai Luthra <jai.luthra@ideasonboard.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20250224-cdns_phy_pm-v1-1-0fe2c544cc87@ideasonboard.com>
References: <20250224-cdns_phy_pm-v1-1-0fe2c544cc87@ideasonboard.com>
Subject: Re: [PATCH] phy: cadence: cdns-dphy-rx: Add runtime PM support
Message-Id: <175501689535.633310.5617884055739697680.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 22:11:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 24 Feb 2025 18:10:05 +0530, Jai Luthra wrote:
> Enable runtime power management for the device. The PHY framework
> handles calling pm_runtime_(get|put)_sync when powering on/off this
> device.
> 
> 

Applied, thanks!

[1/1] phy: cadence: cdns-dphy-rx: Add runtime PM support
      commit: a230d52c90cfb48f1f32d3957dc962165373895b

Best regards,
-- 
~Vinod



