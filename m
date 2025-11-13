Return-Path: <linux-kernel+bounces-899728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B50AC58BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC7C4A1927
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663F347BC3;
	Thu, 13 Nov 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzriRmMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A69346A0F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049507; cv=none; b=eVh3/FeSQxsYuF4A4YgbJKC04qygxCzgcxPLgkaWlmw/eb308tVPM2Vy3K9pxL9fgFruoY/a+7OB5p3/66tPEEC4AtgjA7Taaq2NI3HC5E4/yw5opd2a/I1BJ2EIeJSXnkzF2psBpoBGckmdQOIjERgzop1Rn8Dc/TKMEr8re8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049507; c=relaxed/simple;
	bh=k0zduJbmIY/U4DZMNjziNOqHrwcxzqKHiUNiqrTIE/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mvQfro3X7WvFR5fwH1ZnsV5Ah2TKBINxUb9TY9jOngCPy23USY4NIjksSHJmPp0ZPaiLUGGGfPyJVcbSmYlAmo4E6hELql2sb3CYCtqpJiuQh4bf769V3g/ynKuqmJ3x6BnB2mbjgxwqu8aNI+oVwcEV86f1itRP23aMzEPOhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzriRmMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA296C19422;
	Thu, 13 Nov 2025 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763049507;
	bh=k0zduJbmIY/U4DZMNjziNOqHrwcxzqKHiUNiqrTIE/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZzriRmMJhPzqzg/fyv2fVw0quZkp1QppbHQ6Af6b39LbSd/pJfEE3O5hdjBCCXfGp
	 hKNWHpSfjCApODZ7l9Gu0zjjkh3Dw5FjpZdOVtba6VyuKKcsN3KtmJ/W0Hths+d7aq
	 57jghBTZE4whA9sA4uTyih7drOMx6xyYCu4uBtZ2dfwq8HrDB7nzMmpTP2O+Bs5h3v
	 6bnZ1dUhkcMVtNO6ZUsAFGwGoux3tuGZbqkeVrQ4LhIP7SHMBFI+tvGkUH30z1kq/1
	 hnkiFh951L9hWrLdrNwWLGlOqm53xp6QXdS8X6piqpLaj17KzZQsxDQLHtV4Xgu6rx
	 br0Pe+IpY0niQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, srini@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20251103232942.410386-3-heiko@sntech.de>
References: <20251103232942.410386-3-heiko@sntech.de>
Subject: Re: (subset) [PATCH v4 2/2] mfd: qnap-mcu: Hook up the eeprom
 sub-device
Message-Id: <176304950569.1556182.3664553953755268557.b4-ty@kernel.org>
Date: Thu, 13 Nov 2025 15:58:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Tue, 04 Nov 2025 00:29:42 +0100, Heiko Stuebner wrote:
> Add the qnap-mcu-eeprom platform-driver as sub-device for the MCU.
> 
> 

Applied, thanks!

[2/2] mfd: qnap-mcu: Hook up the eeprom sub-device
      commit: 4e2236230b3d6dda4a60111605e25bf482ef7492

--
Lee Jones [李琼斯]


