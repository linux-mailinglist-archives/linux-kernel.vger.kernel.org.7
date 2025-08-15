Return-Path: <linux-kernel+bounces-770085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8303FB2769A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA0362817E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9818D2BE028;
	Fri, 15 Aug 2025 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1f9p2lt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62D2BDC21;
	Fri, 15 Aug 2025 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227575; cv=none; b=PYMHETB//uGvmtG4tGhGmlxC/XZcZ1WBS+KiZqRFUk+mCSr40azB5V5ztlLmY1wOCoPhfm7YnM26T29DG1G63IH6aHgTpQl4eXCkcSi6jcWsMY2U6UU+qNbI4J5DggcNrluqrH87ekSteQy/SptAkUcM5d0+so9WvCxSNRc4ZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227575; c=relaxed/simple;
	bh=C03dOmNnOqBE2+8uBcpUMnixcBGRIOifUTQNa6baHCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVfTWUa2M2gNIUJVEeMTZ4PajgQMVgf+JHdAEBuBqvBk5Y/HunMXQfYOe1ycqiHVgeKcWabNcS6xYrbaGltiLjwXjLUU64EDac7IV707Gy1Wj7JIDkXO9zxSOs186QTbZFSk8AqVOV3hw+qYIuchPyaxu4kkwu1QXy7AVtm4OSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1f9p2lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D14C4CEF1;
	Fri, 15 Aug 2025 03:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755227574;
	bh=C03dOmNnOqBE2+8uBcpUMnixcBGRIOifUTQNa6baHCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1f9p2ltvF0EZ1vbcd0lrlvLbWWRtrN8iPnYsSctU3s/kPb9TKRP2oGrODLiZHg26
	 TvcNeR0IrFleGDs4UHwolwAJjw0bOPVWn1bDiTx1aXtYiWL/Qh5eZK3usviF0ItifR
	 DsX1LsItdCJo6Ysit4roy3o2GihxjilOzp7gEFVqOOVjV3tjBVTkvgaIUA/dV+Dk/l
	 aYY5J8OYKQKj7YQyiclQzdAHzslXDkzptON4AKZvnqGQzQXI9s4uKRRMC4w/9U4CuJ
	 YXs/HMyxIFtMYU/zWYEPhj9Llz8HmHY0KuWokkI1gQRXWV/pRbCrzhqbz0b/RsA70C
	 2DsOJ0e7iw9Qw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: usb: usb251xb: make reg optional for no I2C ctrl use case
Date: Fri, 15 Aug 2025 10:55:39 +0800
Message-ID: <20250815025540.30575-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250815025540.30575-1-jszhang@kernel.org>
References: <20250815025540.30575-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make "reg" optional to allow the driver to be used to manage GPIO
based control of the device.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/usb/usb251xb.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb251xb.yaml b/Documentation/devicetree/bindings/usb/usb251xb.yaml
index ac5b99710332..4b676c010f3e 100644
--- a/Documentation/devicetree/bindings/usb/usb251xb.yaml
+++ b/Documentation/devicetree/bindings/usb/usb251xb.yaml
@@ -240,7 +240,6 @@ additionalProperties: false
 
 required:
   - compatible
-  - reg
 
 examples:
   - |
-- 
2.50.0


