Return-Path: <linux-kernel+bounces-731709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30177B0587C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBCC4A50B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C0D2DBF45;
	Tue, 15 Jul 2025 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="m7VPJ1O3"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685E2D94B9;
	Tue, 15 Jul 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577747; cv=none; b=nGhASlM3N6Kyh9bXj2XUfMcGJp9y3b2lk5lXvSlwu8ORTtwWx/S4ytdVKwAkm8oZVSenYwI4K/8UWvNQz5qMYFMatEIH9Lczv2C6+dJE5OvbUTtgTTeTDb2YsENWcQe2YYx3dONfwhRI+UnhIPEVthBL+3MLSUrjetux65T1MHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577747; c=relaxed/simple;
	bh=Z0W99cVCjNlo/B4idgF9JWDf4KMcHZYlMYlHARzMZZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNRQXHWcf4Qd3U63xf0A7RmQQM6fyjExdm6E2JJQjS0s3uJeSrMEfRlVrrShKGNMmkmw24Xm9rIIpV01LikgLVY5/TLNf9ApwGPD6IiiY3Cjal+o8GVE1mU07k37FjFOJ2Y/JTVRwAVzVDESmcm/QSe3kaj5CPcM+h3WUCPJCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=m7VPJ1O3; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=B21r3yBV8EHsHdXf3f8cxXR6HEpvLw0yL1lX+xHT+kg=; b=m7VPJ1O3O6DUfh6rqmXFORQS7/
	eRWs7mntRWU2v/yjdiS7WDiJmRSzfOus7j8fHrF3KEC/Oxl1QI9oVz7rnEKPOQhdWiqXy/d5OfNmy
	uPoGOQHMvgasS6ZjjzPGOLU1CkdD602FF8k6q8j0kPLOHkklpXY5EFA8ouQz2JxYcDlFkG6LgiWJc
	nl71PjZ751ZXqvAk+wlnJoy6QgtyXgM+feTsjJDoIsRf1sHAnkiYwrUR1Y6HlH8gZz8WieJ7v6Pq4
	DjikX0AMfj2994OoPkCV7RNPIf4EVqJnPxwQFRcrqcBzGiE7oG72Z0OIUasU76lj24D8oxsnK/LwR
	yqtc85jw==;
Received: from [194.95.143.137] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ubdWr-0000O7-6T; Tue, 15 Jul 2025 13:08:57 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/10] rockchip: Fix several DTB validation issues
Date: Tue, 15 Jul 2025 13:08:46 +0200
Message-ID: <175257771277.2527819.16255685231485653626.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709132323.128757-1-didi.debian@cknow.org>
References: <20250709132323.128757-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 09 Jul 2025 15:15:13 +0200, Diederik de Haas wrote:
> This patch set fixes several DTB validation issues and consists of 2
> parts:
> 1) dsi refactoring
> 2) various low-hanging fruit
> 
> ad 1) The display/rockchip/rockchip,dw-mipi-dsi.yaml binding had:
> - #address-cells
> - #size-cells
> 
> [...]

Applied, thanks!

[01/10] arm64: dts: rockchip: Move dsi address+size-cells from SoC to px30 boards
        commit: 98921ad2494a85aa7edde33a3a478b9ae3d621ef
[02/10] arm64: dts: rockchip: Move dsi address+size-cells from SoC to rk3399 boards
        commit: d9c9115c6127636efbdc0fad8184bed1cd42fe3c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

