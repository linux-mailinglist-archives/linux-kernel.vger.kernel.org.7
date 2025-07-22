Return-Path: <linux-kernel+bounces-740915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD7B0DB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BBC3BBFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E152EAB99;
	Tue, 22 Jul 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNFCReVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EFA2EA14D;
	Tue, 22 Jul 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191469; cv=none; b=J+QJE8fkoQ5isXmGhaD6xtffmGUc4BN4Y4WQ6daTk/y4SwVg8M+xNMsK1XrkepfvxumVcK+jikaSBrNxfTvgMvbm0zqDituoxTHjg8UT8fKVcyxwYyiIuCc2sTPXoQQvh9zBEFxT0i8MIfvHB+3b3D5aeitPI/8aAYYku9l9OV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191469; c=relaxed/simple;
	bh=wC1RXxQIm9EggCGpr5mxoFHZrulqQ/Ry2RyskGcaurg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QCiXr68bohmBJwmXK90T8QxmJiS19MuWBZwB/LzMmhpangG/65m52dPsak3+gpOiA5xuQ/OTFYi8lnFUb+E6ZNzO7CMT+C0neExVdSuGZrG/Kc+BJAbrX3YrAKn8RG73iIeMRWDCLSXUhdqmzK8ZgXglcuOtcSzh+VD3VodpffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNFCReVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21798C4CEF1;
	Tue, 22 Jul 2025 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191469;
	bh=wC1RXxQIm9EggCGpr5mxoFHZrulqQ/Ry2RyskGcaurg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vNFCReVw33rx+cRYq3uv7R+665IbodnXYV4q5AluskgBCnoh9L2+lXciDRq2Rsaph
	 LUpQD3mh6wK7YpPYRE40E+7TPfViFZXfrtGi4HvH+YbrmQZ19Bjw5lpPhvJfUkqpwz
	 H5w1DEgkFmy2wMQvLSnL+/tZih3o97KnhGaoDia5H9xxb5h8yEOMBBIb2orDZiBrgk
	 AcoFAek5m+Wqx3jV0j9733u29yWhNe2Z2XDtPxUAuGs9TRk8JliINicTQFMI3Yz/kt
	 lqkSwd590XNK0Plj5Ke25EEmqBUHg6RtKBQz7OS8jaK/oFt/XtU1G3N9JhxG3JGzDg
	 O+dMDWSRuPp3w==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250627220126.214577-1-robh@kernel.org>
References: <20250627220126.214577-1-robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: phy: Convert brcm,sr-usb-combo-phy to
 DT schema
Message-Id: <175319146575.114152.5994506906661121885.b4-ty@kernel.org>
Date: Tue, 22 Jul 2025 19:07:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 27 Jun 2025 17:01:25 -0500, Rob Herring (Arm) wrote:
> Convert the Broadcom Stingray USB PHY binding to DT schema format. It's
> a straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: Convert brcm,sr-usb-combo-phy to DT schema
      commit: 4c3d05da59eb75bdb7869f8668778dae87229168

Best regards,
-- 
~Vinod



