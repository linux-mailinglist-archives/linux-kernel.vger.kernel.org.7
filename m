Return-Path: <linux-kernel+bounces-899625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E529C586E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0343ABF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9164D2F3C07;
	Thu, 13 Nov 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWF68tml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F02F0C62;
	Thu, 13 Nov 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047294; cv=none; b=Bfc+ecXQS3GNiMinqiCL5habLvVKe+Y610ErP3VDQa6COZQKf8VWhmdxZXlOQDOobPbBLQpH9xARAPVuREL0I5c2JWCIaxfeRx1+/FOiJnyvi0YresDHBHdo/p7aLNCpClUlfGf++umP5/89hfIumuLrSsY3hwxc3xHKP6tOQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047294; c=relaxed/simple;
	bh=JC8H9IdUVhNO56DgN8ErhD9AyUW0lvqbCJwFCyiWWoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e2Mc4vPZCV8aA0EPQ65PDhe4Dam2jQE/lLWVPDdUXVitA8pGO/96pYxjXiaGPy6OWyiHWEr2Hu/SubJECgdCTbibnsUDMY5CU0VgnGwimThRyBfbmaIiDbPuSBWzQDKHqrqIbWjtiZicMdP48fuNJW7P+BCpUC08rQ7M4nodhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWF68tml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCFBC2BC86;
	Thu, 13 Nov 2025 15:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763047293;
	bh=JC8H9IdUVhNO56DgN8ErhD9AyUW0lvqbCJwFCyiWWoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QWF68tmlBHXjEAzLpffr3/GFjUKuY2qMgKdBKs9ZnChmiGSktiowerqjvroVH3nQy
	 3e2XRzaOwR2KwjDwXz+dh7STpGbOvuntjNrQDtAvlMJVKtjaQKCiFKyK6AW7vOsQae
	 aJA+gpkzTWNGbPItGytp/NqZGzdPiEzfQipVCjhBILKf0m2KSN8JqdiZZWAVluOX8B
	 jvS+G05+Si6Eau5/BCi6vWyCBzdVSt4JbX+tD2dyChEEsL4gro75HSFgHqxUbbR5Q0
	 l4mevaT0+ur4MKtuvosO3Y9x1NoQg3w357fmSLlnx/u6RUjoYj7Ufr2xReZn12Vui6
	 vOULtNlweqHhQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Samuel Kayode <samkay014@gmail.com>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>, 
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>, 
 Frank Li <Frank.Li@nxp.com>, Sean Nyekjaer <sean@geanix.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251102-update-email-v3-1-8e2c4a4507f4@gmail.com>
References: <20251102-update-email-v3-1-8e2c4a4507f4@gmail.com>
Subject: Re: (subset) [PATCH v3] MAINTAINERS: update PF1550 driver email
 address
Message-Id: <176304729136.1534976.7630559945180133338.b4-ty@kernel.org>
Date: Thu, 13 Nov 2025 15:21:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Sun, 02 Nov 2025 22:19:08 -0500, Samuel Kayode wrote:
> Update Sam's email address for the PF1550 PMIC driver.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: update PF1550 driver email address
      commit: 70a6d820c898fc02abb7433820ed1494431d1acf

--
Lee Jones [李琼斯]


