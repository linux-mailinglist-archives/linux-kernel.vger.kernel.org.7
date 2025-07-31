Return-Path: <linux-kernel+bounces-752192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB491B17248
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AE74E6E49
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90C2C159A;
	Thu, 31 Jul 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn+3uQVv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621E22338;
	Thu, 31 Jul 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969642; cv=none; b=PNwSVQ1/t7jDQNLfshKy16uIGWtiXdJfScmlZnWLqnR75WQLKF9V7fG5Z0TjbQmF8/mgx8iV5hwrQ+8Y178ZQ1Q9fZwHn6hiv73+8Omw9dTczHKbb7vK0NFk/VGX07mYV898wRZDGV5k91i2cysEig8d7AtC+Qd9R2TZiSu95EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969642; c=relaxed/simple;
	bh=7RhNMBrX2jn/uNli2+XXW30WJyQE48aW0MMj724k4so=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CmCaZZCMb8rTgzwxxmX3CRuJCxwwDouFMn9PJpYGcIcehQwCfcYYOU/5BHyO2GW1NFGY4q3luz90g+BMDzJFxwGzVXBNYe1IZPIsubqdM2MSAdEUarHJ1xHKFY4x7XTzEeaSX36JfYLXXMQ48kRpKB+BiJjmQsyezxUrJsn22sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn+3uQVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD1CC4CEEF;
	Thu, 31 Jul 2025 13:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753969641;
	bh=7RhNMBrX2jn/uNli2+XXW30WJyQE48aW0MMj724k4so=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dn+3uQVvvoWN0XKmQ24NlhoaOK0M4bHQEtTkhRIytQZYdxlSjVG4ZOnsfsTE9xKrn
	 F/P2jtgD4Tk0p+K6PiBnlXbir4fNz0l47oj3tmK7N/exJi36cUTUMoBQTfYFNinNrh
	 d86/Kt7EKCLSiq1MBMfVZmHWeIsVOlLUIlcBS4NFLN7RBmSCPfUEHKB2vJUo4w06Ev
	 NjuEMQGQxQgR/3HA74SFcE+JVqYswLh75Civ+Ud4qow6Ddfx1U/LMZgvBE+SvI+AFH
	 uR3qtJnzAKbQm/gDhOtJhbnCiOR6Wsa4+rBmEVk3f/e67LJ26Z1HnZkoL6+ZaYDQ/t
	 mQJr4aRho4zDw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, srini@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250730172248.1875122-2-heiko@sntech.de>
References: <20250730172248.1875122-2-heiko@sntech.de>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: mfd: qnap,ts433-mcu: allow
 nvmem-layout child node
Message-Id: <175396964012.1212829.4001330716835123166.b4-ty@kernel.org>
Date: Thu, 31 Jul 2025 14:47:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Wed, 30 Jul 2025 19:22:47 +0200, Heiko Stuebner wrote:
> The MCU has an eeprom memory connected internally, that for example
> contains some mac-addresses for the soc gmac controllers.
> 
> Therefore allow defining the nvmem-layout for the eeprom.
> 
> 

Applied, thanks!

[1/2] dt-bindings: mfd: qnap,ts433-mcu: allow nvmem-layout child node
      commit: 17edd13a0916c7c84966b4db96fe744986c3a04b

--
Lee Jones [李琼斯]


