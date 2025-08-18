Return-Path: <linux-kernel+bounces-772968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47DCB299E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5264E3BE5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EC526FA6C;
	Mon, 18 Aug 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW53P1pO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8926E711;
	Mon, 18 Aug 2025 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499305; cv=none; b=AVcUOJn1fsRlgN2wr6CcIMpFxG0nxJEqeH8URhW/95UhZKS9RK2dtI8S2jKTYfTua3CHBE2QmbmnY8iDrEapYnz7ABTMcp4qasWIBtwNtQ1w4dYmRZEA9EgiLHho3Ls5WZ8PkXOo3+svOMaCnKMiN9icchfesIVVFeNLTenH2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499305; c=relaxed/simple;
	bh=ReoHzG+zNv98uIu1Aj11IEXevCivZsTCQF+wUJYHh9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UdIlJT5qKhzjpizzIRCveiibrRXAqClHuan10NdaR8yGAPTlM85qbzYz9TPUpmg0fd+fBHpQji8QNBPoQT1o1JiQZDvE8hg/LLx3urt65sqRJrTpdaDRhXvTWMk6eYbeNro6z2lwl1N3fJ7M00Ybag6jm5MPDAiI87m11ZO24U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW53P1pO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457FEC4CEED;
	Mon, 18 Aug 2025 06:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755499304;
	bh=ReoHzG+zNv98uIu1Aj11IEXevCivZsTCQF+wUJYHh9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lW53P1pOh4ODYF42yB12KKgW6367Rmndr99CU3xhKKmozRsGcFcqRpzfOaLM6ZU7v
	 I9HqKflmuNcc/3KFKbDkffU/o85AhwIfO0vl3r3KJRSGVoLVM020PRngfyaQFUEJjh
	 AA4dGBVIJCZwahwQ9bFvAxr79rY1qqoKCBFoNG8/IeJFZFIUCNaR6yyZ+U3ZO4f7rp
	 r1Ao93wMqeJPkzUQ1mMaiZc6BMsV0kABMdwAMhtGLxWSEv0jJjyTgaMPOs2LuUfcL5
	 /F8XeyjyuHmTEYkoqWtukCO4yxARKcefaeX86u3jSvRSb5T2xNQlb191VXNqTozYtA
	 NYAQnnHl9wA6A==
From: Srinivas Kandagatla <srini@kernel.org>
To: lee@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250730172248.1875122-1-heiko@sntech.de>
References: <20250730172248.1875122-1-heiko@sntech.de>
Subject: Re: (subset) [PATCH 0/2] qnap-mcu: add nvmem subdevice to read the
 eeprom
Message-Id: <175549930285.1087640.6198387962915096421.b4-ty@kernel.org>
Date: Mon, 18 Aug 2025 07:41:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 30 Jul 2025 19:22:46 +0200, Heiko Stuebner wrote:
> The qnap-mcu is firmware running on a Weltrend WT61P803 MCU and there is
> an eeprom connected to it, that can be read via the serial interface.
> 
> The eeprom is somewhat important, as it contains for example the
> assigned mac address for the rk3568's gmac interface on TSx33 devices.
> 
> So add a nvmem driver for it and hook it into the mfd.
> 
> [...]

Applied, thanks!

[2/2] nvmem: add driver for the eeprom in qnap-mcu controllers
      commit: 117c3f3014a929464c01622cb95b566bd27244f8

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


