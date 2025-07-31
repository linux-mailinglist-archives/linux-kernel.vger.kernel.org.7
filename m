Return-Path: <linux-kernel+bounces-752191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE23B17246
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EA51AA51CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABBF2C15A6;
	Thu, 31 Jul 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw8cwRHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041D4146D6A;
	Thu, 31 Jul 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969617; cv=none; b=XZht8CFza02gbKhfkos8d7PpzhQ4jLdjNLfUhsNmEQoIdaRLwAzjXziM/mLtFCD/QOG+hwHh4zeVqagxyB0P7pklEccpKEnOcdNLopQqSOzu8lG2IO4YdR3vaNE1e72IXIhvyAZloxRrit3zqzX4j4QKvpiTjzCn4NYFeCoWBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969617; c=relaxed/simple;
	bh=FQGdA/kgua3Ezrs2J/gUZOld6oQPDapLrvIw7K0op/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gmd69RFx5jK+p/3uyYO770KWFpFCmS1DeKFrk1Lv+LR9BWTMYZaVkHQhkWGp8ChVNzxONJAaiDlIkDS6x808ah2496Lg+2x1ARFKA5oPp3bT3a9snoJISHlDort8UJppX1hmdSkZyyX7SoA6ybUjPvmGgsHaB/SHhqqi6x+FgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw8cwRHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6012CC4CEEF;
	Thu, 31 Jul 2025 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753969616;
	bh=FQGdA/kgua3Ezrs2J/gUZOld6oQPDapLrvIw7K0op/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Aw8cwRHvczijxPQAilBvNR/DNf91I5VwbNcMH3kcEvhD+I1OouAldcMXxjty17WTZ
	 4hThzY8JLtsm7Z429cWPsAbQiXtn1Ultlq2o18muLo3CpRYJTyUMl90R6AhN86he4I
	 HD3ioKnWqpR+xp7hOiqh/wbQgJnhpejRJ8i9BnZ1vdyAbvGgcWlvIM1WI1jsunKsNA
	 UK4r7rlOAUPX6Ttf6pyLLDa/bth6M2j+78XcNxOfrON+SDrkwjieEeL3nSAofFa2vE
	 yYSZE5rMOKVDree90N+9Rz2Xepl9FvvKeUu4st8woEaFfzVyn8GSfJXBymjmW4aYeh
	 xlb1I88usRgRA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250730173423.1878599-1-heiko@sntech.de>
References: <20250730173423.1878599-1-heiko@sntech.de>
Subject: Re: [PATCH 0/2] qnap-mcu: add ts233 support
Message-Id: <175396961510.1212211.4176671261815163862.b4-ty@kernel.org>
Date: Thu, 31 Jul 2025 14:46:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Wed, 30 Jul 2025 19:34:21 +0200, Heiko Stuebner wrote:
> For a better return on all the investigating I did into that MCU,
> I got myself a 2nd device - the 2-bay TS233 this time.
> 
> Add the necessary driver-data and compatible for it to the MCU.
> 
> Heiko Stuebner (2):
>   dt-bindings: mfd: qnap,ts433-mcu: add qnap,ts233-mcu compatible
>   mfd: qnap-mcu: add driver data for ts233 variant
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: qnap,ts433-mcu: add qnap,ts233-mcu compatible
      commit: 38dc76168a92a1e8fb28a901607ac24c4778141c
[2/2] mfd: qnap-mcu: add driver data for ts233 variant
      commit: 5f1edbae853329b8a6e637fed0f7202727aec545

--
Lee Jones [李琼斯]


