Return-Path: <linux-kernel+bounces-867521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F50C02D48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A47D188C55C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38FC34B681;
	Thu, 23 Oct 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH6Lm4W0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3F34B1A6;
	Thu, 23 Oct 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242404; cv=none; b=jSLNcES/KNuuCGxKt3n4GTExDbttzu5ZoyvTGVYsi9TzAWJ1tSBSOU41xr6RgxexGSkNQZZQApj/bZL7eJNtHOdBVODMRTxutpzBj41Eg13B184V3kM2/gUMRmoC3v52B28nFSuk1M3p5vw4pJo3vyFtMIZUxzooaU0AbaC4MwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242404; c=relaxed/simple;
	bh=is0kS7LD/8ncxJVQOKHRS2haY2ZGilHSHz8iGcccZbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WCsfJYhTCIw2z14Wwd98EpNoOgpQ+cRMEqQ2eNfAx08BQsF640mlJ0pXaoHDrwgxjdcBeAMDc0UfMtlZYQZQMdNxnn9jowjMVTz9GP+YI1uGhxhE7AhphaA6ptoNdDDyl5sVizZDAlnrgm5KBHrg4ZWlJrq2e6Dn/on3hBFDiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH6Lm4W0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98495C113D0;
	Thu, 23 Oct 2025 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761242403;
	bh=is0kS7LD/8ncxJVQOKHRS2haY2ZGilHSHz8iGcccZbo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HH6Lm4W0v691uO1k+jw68/Opopv3d+OagIajP+7NKY51YQc8EblFwiAqdfpbz7Ycy
	 1JJ8/au2b23XWF4btWcFunhawKTl0NWBMZ8eaUOYXXjJx0aJ1FrK/BesYEwgpfX+9H
	 8qzuZwBPb56KMIjBlxQzc6/owSFDwI+7AwoTFdmWLyTR54AMo8Khnjc4/ThuQhMz1T
	 3h1W4w3MmG9KFYHQOSYWtKGgC8nIidA4ImU/wB1MhXa/GbvJhsBi54cG8JxIGdb2M0
	 ValHO6KmO1Cm0qsBZm+Q9KV++xfGgRA7L1ccdU2zapY1gKgH/jM8vT8DIA8pIvq42H
	 1C0GSmkFNiN4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF7ACCF9E5;
	Thu, 23 Oct 2025 18:00:03 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 23 Oct 2025 20:00:02 +0200
Subject: [PATCH] docs: dt-bindings: Extend the ordering list with a blank
 newline before status
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-docs-dt-newline-v1-1-1bf5e0040c0b@ixit.cz>
X-B4-Tracking: v=1; b=H4sIACFt+mgC/x3MQQqAIBBG4avErBswS4KuEi0qf2sgLDQqkO6et
 PwW7yWKCIJIXZEo4JIou8+oyoLmdfQLWGw2aaVNpXTNdp8j25M97k08uIXB1NQOylnK1RHg5Pm
 P/fC+H2hU5vVhAAAA
X-Change-ID: 20251023-docs-dt-newline-7e5eb43fe0fd
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=jfI7bnd7GDYMrmutx004zTtdSqiNRLQra6bhxGa9W30=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBo+m0hayS94Fa/yGgP2C6hYxl850hG0N03OmAlu
 WTyHv0eamWJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaPptIQAKCRBgAj/E00kg
 cvHwD/9RQmgpVxnghzO89wQCoUZ9+cq/4wSh9vOx9pOEcMjA/E/pNPQFHrHEsiPmCYuxCbZPLUh
 Yx9ZIazraG2YIMH7+CQ/z9POUrOaB/YI0rUPgDw1bTygfoF9n2YsxX38G5/zZWldVmWRwai1Xs3
 EICRYhv69zNZ+Cl3crXq8R5eXih0ge8xTvMpXoEtpESTHbi+ze5o6BKUi2iU9ETpCHpItbSLoCo
 tA8pV98T3LM1fNevPM3qXVrfdT0pVzAMia4kJZgBfF+DSbG0onXQz2bXdtwYFyennSlJm+/c9hH
 2vwGCR2ZkXW477YizfK++4388A7jPPw5PvgFlUwCwp5b1ht6fd21fRpCMViYVX7lo+W3KnQ3UcT
 hUhN92BstR0GsK4k7z5NcjF7Z3yXtjx7M0h8HBlFupqsoyrgTOViCXgD8oJRoRbI0GgPaK2qsxE
 +sO11M/lQqbOtd2sY6wwIfIyFN+R5P01E3TDl2TiTiySidLubI+saxbL7S6iREh38zcWbfSAy3l
 4C6FYjMt1KP4yQGxiqQuxHWDyXi9NqMm1dD4MIx3yars8avafdHvSVi8Eq4unor3MKxhqGKsnjo
 ML+BgkJZhBvSFEmS5iqXXZi9IxzNc+EjyuVCcoJOWuhbKhPXSZJEltgOwJ2e842P6kHJEslfuPu
 Xjb4rsWxC6jQ4dw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

For better readability, it is recommended to insert a newline before the
'status' property. Adjust the examples accordingly.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/dts-coding-style.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
index 202acac0507ab..4a02ea60cbbe2 100644
--- a/Documentation/devicetree/bindings/dts-coding-style.rst
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -120,7 +120,8 @@ The following order of properties in device nodes is preferred:
 4. Standard/common properties (defined by common bindings, e.g. without
    vendor-prefixes)
 5. Vendor-specific properties
-6. "status" (if applicable)
+6. "status" (if applicable), preceded by a blank line if there is content
+   before the property
 7. Child nodes, where each node is preceded with a blank line
 
 The "status" property is by default "okay", thus it can be omitted.
@@ -150,6 +151,7 @@ Example::
 		#address-cells = <1>;
 		#size-cells = <1>;
 		vendor,custom-property = <2>;
+
 		status = "disabled";
 
 		child_node: child-class@100 {
@@ -165,6 +167,7 @@ Example::
 		vdd-1v8-supply = <&board_vreg4>;
 		vdd-3v3-supply = <&board_vreg2>;
 		vdd-12v-supply = <&board_vreg3>;
+
 		status = "okay";
 	}
 

---
base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
change-id: 20251023-docs-dt-newline-7e5eb43fe0fd

Best regards,
-- 
David Heidelberg <david@ixit.cz>



