Return-Path: <linux-kernel+bounces-825361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1872DB8BA8F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A5F7E59C1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251FD4A21;
	Sat, 20 Sep 2025 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="31WZ8Lcl"
Received: from outbound.mr.icloud.com (p-west2-cluster2-host1-snip4-1.eps.apple.com [57.103.68.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FCD8F7D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326785; cv=none; b=omvHcClXEo/gdEsnxFqNM/sDaFReH2s0Xj/ylY66SD2XqMJ+BJ1uegyRyLelCyophHi6oL22QBUEfM+DMTVO1nb/T+sruX7hPMmf7LqCBLGPj17aE89vh/1G3VoJI42qS2irJ/kmdcak+n1YREv8d2KrXkGzLAO80eMisT9IcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326785; c=relaxed/simple;
	bh=46p+EkofkMxYGdtZvBpGmhJftL20PkP+8JCUrJTtAaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tengD2++TN+VhenIhNljjCkV/nL5ZTQuJPbvgx/ecY9anvG+joX0YYYDpS0DJ+x8IKDQftT+GYGN0QNqmnDXnCuyvNnqydIAOlzqkrn+M4bUsoG5ZgHfaI6ngl1OubOxZuGeqLVozbOzLqaQvk7a5vFK/An2W15GmnK5pLkzyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com; spf=pass smtp.mailfrom=bryanhinton.com; dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b=31WZ8Lcl; arc=none smtp.client-ip=57.103.68.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with UTF8SMTPS id 6D62F1800261;
	Sat, 20 Sep 2025 00:06:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1; bh=WPYi7sPUqVQFwd5DMYfPao/LFjtl0ygD3emLcV+vfcY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=31WZ8LclWRDTQbGP+SnrG8FWeDlYT314juO9n7NlUTICKFSF1iou+wybdwGtXSSgWvuvK4+ccEULhMxK/dESR05T0NxBBAH9DTw9jWgdMLifbKV1KQBNobIezSXka9q/kmun71XvI+7qewOhZyarj7GIMnGLQt21pWPSo89EVuvvV+SGjM8UAauHgm2pPuAeYX5i0e3hnBOBtdUvGm5vA9dCfDew8MCuRftl3pcbE99smSnS7tlC28DJnEAgHHw6p+8T+pTS73HjUDK89LST4eAKZTdHR9vjYEaTuJnpCouMr+QaFaNAT2Y7LIDU10N0rDkmajs6eRoHkym4qzhr6Q==
mail-alias-created-date: 1643268037438
Received: from localhost (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with UTF8SMTPSA id DFA08180046D;
	Sat, 20 Sep 2025 00:06:17 +0000 (UTC)
From: bryan@bryanhinton.com
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH 0/2] arm64: dts: mt7981/openwrt-one: UART labels and console
Date: Fri, 19 Sep 2025 19:06:10 -0500
Message-ID: <20250920000619.2643457-1-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rsqgtyyh4u-4dZ8sjJBoZ70CBEvyscKV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNyBTYWx0ZWRfX3tIQfDR3WuRB
 bhFGXsN9wpKlpFnrckty3RrHeUbKv3zAbob8yligrbCUvujw5m6hBh+mCg1KwV6E5xql5KkjI6X
 FOc6qLuC+YYMJvzaA7Siej+kPY4467e5reqlzDTbARJSSordIk/Wn7RkPRbt7iliH913OJCGF4v
 QJWy49fHg9iBtFUxuLOZzcHPkSpThomh6B0/I2gc1DlnAgUX5r2mjY/JIawml7HKjG+5NW9BiwA
 O4j84LgVTrBCmoPkedsWUbhs6Erkgd2507DvWKhUbmdgNUx7geCK9LzTefxy8n8LcXeaELdLY=
X-Proofpoint-ORIG-GUID: rsqgtyyh4u-4dZ8sjJBoZ70CBEvyscKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1030 mlxlogscore=925
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509190227
X-JNJ: AAAAAAABdudQAZpeYxNdutgiEj3zy33HQm+50+3JdYmE2ZrCz7B4y4xTkv10BO4Q3ATHDEjekSEIUBOiv4o+CpMOXQ8jTB59D44gxyo+H3azDRf1udINOSLSHuwoJmM9pxuvUNVXk6fBeT5Vs/0mih35Wi9j7nAgcAOKMShemCfkC3Kd76QVnHViYVgz8V89uQDIPX0476332OmqGC5GL3G0rqj5RMiDJdSwyd6+CpRcq64Rxzcj0tcN7bXmjC2OfdwswrpmCmF9sCzbCH1eIS8X8nHSQQfz8c4Ny1VnZzsyWOfVtuZP6SY5+o78WxkQt7yW3OKOv7di9x7cz0CXP91uAI7eVQlvSUp9tMd6OsBIyUpBGDxRfvmYYPgLavhu1Ko7oQw+YJYrtspNjEujKZ6naWtS1srdzKWbguROwshxyRfDEbaDL4WFtuhLosZNZ9Se3HdjL1+gs056nlKuhEUJ38+Hyy3wWEtARRbRxqKUZe7H9zQUBl0TczivAXLZ9bycKrGZQsdrPWPY3y78T02WZwlhpttaxCfL7qFmIxcdMHbE8S1lM1rbIIRhRc4BXbRJKIxgTCNbDWYticXv/xVGXGcBkbqhaaFcNJ1P9BzcDtl/kpd5uH1pldsLG8ghVIcmjZlH+bkYB0z7l4oS3v3Rzw7lVo3XV3lYGKyXmsktnEnR74lh5REPV1zmjq0q/FMpG/EkRoNWmbH8

This series makes two small updates for MT7981:

- Patch 1/2: Add stable labels (uart0, uart1, uart2) in the SoC dtsi so
  that board dts files can reference them directly.
- Patch 2/2: Update the OpenWrt One board dts to define serial0 alias,
  configure chosen stdout-path, and set correct UART current-speed.

Both patches were build-tested (dtbs) and boot-tested: 
mainline Image+DTB built and loaded via U-Boot on MT7981 hardware,
with serial console output verified.

Thanks,
Bryan

---

Bryan Hinton (2):
  arm64: dts: mediatek: mt7981b: add labels for UART0/1/2 nodes
  arm64: dts: mediatek: mt7981b: OpenWrt One: set console UART to 115200

 .../arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 13 +++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi           |  6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)


base-commit: 1522b530ac3e2dadd75ccb351b88d3c7c4cf584e
-- 
2.51.0


