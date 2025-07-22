Return-Path: <linux-kernel+bounces-740912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BC3B0DB05
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A409F160A18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726802EA72B;
	Tue, 22 Jul 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os3M/V60"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35D2EA73A;
	Tue, 22 Jul 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191459; cv=none; b=H3Znpm5AP12mKgq3bDt2jWdqHZlx72v4zMko6AcMcBNHcnWduys80/E5syljPjBBMr3BDf6OFEINnrvKUMpewyMAfDz5BiBtFRBNyJmxJEVvMk/iJ87+0okZ4PygwO94rNHBBJwOif9X8L9XpQC8HNwqhLEtuADBsMBkhYPTmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191459; c=relaxed/simple;
	bh=SNlXAgT++4m4TKztvKkQemORHWb8VSygCQCGkQvTGqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GdPDbrgCVPU38cMMAS9EPblpWXFVtzyqdLqRjXFsrrokc7X6DD9XIEusTvIP11BKvXEzFi/tX73RFRCbevbfqPQ8P68HekviVbLvc1jAfv4JT/72L6wJdNYZ3s3ObfWivSsVCgBfdX/Bv1O+IoV/oJc2T39oizujbf3q7m3MDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os3M/V60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02005C4CEF6;
	Tue, 22 Jul 2025 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191459;
	bh=SNlXAgT++4m4TKztvKkQemORHWb8VSygCQCGkQvTGqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=os3M/V6064U011WPLr6/inhse5tmffGbF+A/kDc7oWH/l96EUna0n1Uwap08rd+4l
	 +5xbh88EjKUOnhZFHR9Eqgg6BhIrGn9A9F/nAccoiTcuJZP63xLjU6+DCpT1O/uI7o
	 0DT/5bakRSDKp+izCyb11VaFIS6JtV4wrL4WpBh/eJyYhkyg+pODGjeA8rHvJn+E0c
	 6qkkxrXC++tmpWviZZX+88q/l44W+Ha8NHANOf0Rh62UQZEA7TDsDQhQt9hSAQwXPL
	 YY39QLPrHsSkrPWjifBI0h1bnP1/4xy3FCyj3mfu3H5zBF925BZtwWelPAeskyjew6
	 odi1KOfkMebiw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Liu Ying <victor.liu@nxp.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20250707-dt-bindings-phy-mixel-mipi-dsi-phy-allow-assign-clock-properties-v1-1-5e34b257e1ef@nxp.com>
References: <20250707-dt-bindings-phy-mixel-mipi-dsi-phy-allow-assign-clock-properties-v1-1-5e34b257e1ef@nxp.com>
Subject: Re: [PATCH] dt-bindings: phy: mixel, mipi-dsi-phy: Allow
 assigned-clock* properties
Message-Id: <175319145662.114152.5665167328510255793.b4-ty@kernel.org>
Date: Tue, 22 Jul 2025 19:07:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 07 Jul 2025 10:47:00 +0800, Liu Ying wrote:
> assigned-clock* properties can be used by default now, so allow them.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: mixel, mipi-dsi-phy: Allow assigned-clock* properties
      commit: 429efeb1900d4a3164e1233b392ee5f489b6c3f8

Best regards,
-- 
~Vinod



