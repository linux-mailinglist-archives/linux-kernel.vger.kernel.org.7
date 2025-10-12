Return-Path: <linux-kernel+bounces-849395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7407BD004F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 09:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194A21894BB5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD702221710;
	Sun, 12 Oct 2025 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="TrGI6pKb"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FC219303
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760254421; cv=none; b=lIGRjepp2CMc3NGechj0iXpTVv03+JRWlDvN8ENGQTqtVU9EH7qmIlQJG8gSlXpsWnpUrN7vozf/e5afCwA5F4qVYhZheMG1/GlFUAeRafbKwJDVXnvXmWCoeneMSRdDZ09QfS1VYcHmqSBsfoH6meI6kaTKGB/TFc4cmbvR18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760254421; c=relaxed/simple;
	bh=MwCpKT69m4IhAGIWTRVH10JE19CizMzQ0u1S/kvnpfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fpJk05pd3lw/5eTSbZtW0XMpSYQJvvHyMK22RnLb05TEklAoflZ6fkN+5fGz1xPstYuVOM/KoD2KbubmXZG6osYJYD5rB/ev5rRpF7PQURrHQEflkFye9PIb7tRx8ugbxnR/xFEgqj55XBTC8yaroncm9q5KWJ9a1wNpHd484i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=TrGI6pKb; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id A39ED240027
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760254416; bh=r72tR826k4cXIYhW7DqZL7KD3+nJ6IHBlQQSaSJ3wkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=TrGI6pKbEoNxXwc4hPiWbKyOpWGI5iFj1h2+9jJ82RdImwzblGD+U8Y0ZvXFPc+7f
	 mlsfCP+omTBH6oGLuv5D6cs873oF82pDlEckeQGIOWJ5HH6aG5YrpnvmbHLP7x8fJM
	 f6UyyNMb+s3P/noKqVXf+XlTGP4QCc2HVzsXBQFXd1k00bswNRBJOSeyvzlF8S7D15
	 GU0pumK4ZcRG+2+oQc1sJFwcJgV0CWXO/xMG+N0LOrdztg3ZZhTpj3zyXgdmCVUAvW
	 KVrlQqdiPnIkmOz7OziGljwt8U8X2Mi2cVAMs0vt/PYJlPY+1ihK59vCI3aHFojGOf
	 GxBRPfiCcqebQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cksfS02MDz9rxX;
	Sun, 12 Oct 2025 09:33:35 +0200 (CEST)
From: =?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
Subject: [PATCH 1/3] dt-bindings: iio: accel: update Martin's contact information
Date: Sun, 12 Oct 2025 07:33:36 +0000
Message-ID: <20251012073314.9035-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update surname and email address in order to be reachable.

Signed-off-by: Martin Kepplinger-Novaković <martink@posteo.de>
---
 Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
index b0dd2b4e116a..91f73872ff60 100644
--- a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
@@ -9,7 +9,7 @@ title:
   triaxial accelerometer
 
 maintainers:
-  - Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
+  - Martin Kepplinger-Novakovic <martink@posteo.de>
 
 properties:
   compatible:
-- 
2.47.3


