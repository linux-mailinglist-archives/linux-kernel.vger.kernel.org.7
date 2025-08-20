Return-Path: <linux-kernel+bounces-778191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94419B2E268
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4031883ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1030832BF5D;
	Wed, 20 Aug 2025 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnIY8P6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602892D9EE6;
	Wed, 20 Aug 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707698; cv=none; b=M/3rcjuas5Yu1/bJYmnRnLd4ZYQPMB9knTgbjPJlt3Tciyh3y0Z1tjf2hahug3qK7YbNBNyrU9SSi6pwQyOCFBYJvW1dxNH6cWf1wTMFA4HzsSK9fD16RHyYnJnt5CoAmrAvMVS/glwbWRrjP+v3/C7cfp50ODu8SC8D3VBw514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707698; c=relaxed/simple;
	bh=k1UR+GG0otyO1qJ2r59t7k1ZcXWSqNV1MoXw5+jfitA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdGt9RvOnOHz3KhJYWBaCMoHMENShD5driaAHUeOoLCYUyvJ5HjQ72g3aim5QLm71bI/0QI+Tk+259euT2/xNY7xnIs5Tkep8GPpzZoLftswrGmMZaov29pgr1OaUgczDR7C8cuXG/XcrGyRFd1FD8mehjiZSxejneFKFP4BQAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnIY8P6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA9BC4CEE7;
	Wed, 20 Aug 2025 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755707697;
	bh=k1UR+GG0otyO1qJ2r59t7k1ZcXWSqNV1MoXw5+jfitA=;
	h=From:To:Cc:Subject:Date:From;
	b=tnIY8P6c1hXonqTCWWhQ2AC/Gkr9n7axwXUrAAXTO075UsBSjNBJ/GemoAnN9C0Ct
	 GZ2rSmI3ZHNgXxfc44UIPKqbiGZgLV7lF9W9CfnJu5GjZa9fBgs+9UyqGwGQH1KY2c
	 hbiyyKHlusnh+QPZUKYFs2aBWw9wxxVCWiF+O4hR0XhVzvPNgo/Rd1uIGAUIaTzju0
	 fx4piWYdJDGBxFAmty08cbx2Y/l4SuVOhihYVAT2wCen8YCYYKr8RDShBOoUMSNPtE
	 VHGLFUlR6Ipm317Qj2WiaZwI3m12kQy/zPFy2+Rno3qQWG4Z5MSehNBzuLXxqmr3l2
	 rm6Le5LAeIpww==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] usb: usb251xb: support usage case without I2C control
Date: Thu, 21 Aug 2025 00:17:40 +0800
Message-ID: <20250820161743.23458-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the usb251xb assumes i2c control. But from HW point of
view, the hub supports usage case without any i2c, we only want the
gpio controls.

Refactor the code so that register writes for configuration are only
performed if the device has a i2c_client provided and also register as
a platform driver. This allows the driver to be used to manage GPIO
based control of the device.

Since v2:
 - add usage example w/o i2c control in dt-binding
 - update commit msg
 - remove of_match_ptr

Since v1:
 - make the modern pm macros usage a separate patch
 - use pm_sleep_ptr instead of pm_ptr for usb251xb_plat_pm_ops, because
   this ops is for PM_SLEEP only.

Jisheng Zhang (3):
  dt-bindings: usb: usb251xb: support usage case without I2C control
  usb: usb251xb: use modern PM macros
  usb: usb251xb: support usage case without I2C control

 .../devicetree/bindings/usb/usb251xb.yaml     |   9 +-
 drivers/usb/misc/usb251xb.c                   | 108 +++++++++++++++---
 2 files changed, 102 insertions(+), 15 deletions(-)

-- 
2.50.0


