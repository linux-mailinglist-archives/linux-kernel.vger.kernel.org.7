Return-Path: <linux-kernel+bounces-720283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7612AFB995
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F244A6F10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2442E973D;
	Mon,  7 Jul 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfQ3D63d"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90962E88BF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907932; cv=none; b=foUGcEv22kVsL8VP8DptKgUn+LJXYmzyHiSTDTYlUEyFkHQok7CBgQi2lJTDp7QOq5mU7tU4OC4g8Z9hnIuinVaPeU8m9IX7Y8e8PLJk5R8RCweON78sl92FRl13T+p6M7s3DcTl8stk+9zVHE8b5VH5fZEqiZAweUR2xyUbcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907932; c=relaxed/simple;
	bh=V7GVXPeniRjfSBXgyWCdSqUUNadL/PC4wB6+w+kmXrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hQEgCtFdJDLZRkLgqECYUWJJHJQ0OgWG3TSv7YYyXyWs+LQnQAm9Wj4m6MC8zRTXzQ/rD34A/RxuZYXnZk6gxtKT3Q0Tqnc1/vL4OjVGikQXu+AX9GeaqpogAXmD6Dkz3R19aWQuKX82/AJAJZx1R1CV1AGU3BJdf3Rv9BsOju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GfQ3D63d; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so6685381a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751907929; x=1752512729; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57rYJvDLr2D8w3kMcZW5Qve8k2sDHgGAExSpeGzzFo4=;
        b=GfQ3D63d+nGazbk7+lWB93ffVNPgxydPzyZXj3KGUyz/vIms4FksdDaxrU0xQ429vw
         rx+TtugBgSOEJDFoHPbvG9HYkXmSU6leJ+pqVLcTfaj8G7FcqCEW5S89ZoAWI+SEDzgV
         R+dCV2bGR+srkCuQrAUqx9k5W6qnKDVtbbsZ+xPEpCd5+oZ28ot9cUeQi1R9kpBT5WUv
         AFaWPypwbM1YUFnO4YHJFENdKPAxbUQgkL1KI5BWHacbYjjWvfmR+/Z2A+/Fd8vZCHTa
         byUzedF4qHVgnhNVvmiIeNvVMGqmkWFKwxDl207Q6MGm5nGKidGmgu8kCcce9jdkyxQ9
         Zt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751907929; x=1752512729;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57rYJvDLr2D8w3kMcZW5Qve8k2sDHgGAExSpeGzzFo4=;
        b=JZvXf8beweoN33UcYjiV100m1GDN4miBsGK8+F3qiHOwoxdZoMYpfystimSWFRaQ4S
         l8xa0+wUM6mg9H3lZ9D7U/VNdBFT7UF7lyB9u1t/6gHkA32gT/mF4otspgXOBvwAZtKp
         hrzgCjfquNsIH8Ad4yWX8el39lQCIysAePI9e7fpS60CcbOxvCRkdq0ArPefXqLOAjva
         7mHVpk5PvYJ5LVsdoHMHpqrlX7suxRR5/fY/s53H2M9jhUpyfw1lPQylsf7SewaSBgED
         t48r362q6a9EhqdvV6ssBL6Me36LQKhAAJMtfpexc1euuYLfTf27rHOIcYIBfcqzsn3Z
         z0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUFvrVniTWnW7vLV4bvDi6YVRaDXpbqnXyQ2wqaU+Nyt6wIzAxYRIxBEDifdvZnv9841shU2emissqKYtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcwz1sCL63dAEXbnQQ+SOZxXl5L377QBofzQpmoFsq+4z9Hlxv
	0iRLflLyYlhE041n2kueEv3UdaTRi/3lgi2rQv1lBORoX127F6+MpCFm8EShmcpPKqM=
X-Gm-Gg: ASbGncuGXbmJ3/30IBcvMLpwPzREZEBrs/8szZBmN3UWyeI79zxO3DzZ7GdVa0iN8n9
	jAVY6zA5ifxdV7seotO+Ksapo6usF5tD0U47S3cL7Lgq18Y54llh1CddCXh8zqfyp1M+DIbThvs
	/O+bCpu5fmo5yTWrL+onIazajN+23wqu4fKxRP45Srb1qp9s0mm9m6EMcP5WyajEFs/CDWXFgej
	XCenJc3OPqi5GvA3zPI/yBTc0TsWWT4bWHyFIJzAkRrHcoDwdfV3f1dVvueSZAu3a6eYkoODHcX
	r9bImcZM3vURJGKcSr4gszr1M7WzTgCQTGSYj7IE7mPNJ3utK+sO7zFdi1LuKjHr6ml/ah6n2gB
	lg+pODP8HeGkGQwj8emZ/WslsNeADqy5DXr6/QX29ptc6qA==
X-Google-Smtp-Source: AGHT+IH39ie4cMyXIg4z35kSN5NcopH3AiyCIAZ7/0N31t7b87LaPnUMjOhDIkjPEUdI9Xt4zZAZOg==
X-Received: by 2002:a17:907:3c91:b0:ae3:70cb:45d5 with SMTP id a640c23a62f3a-ae3fe741335mr1295648966b.48.1751907928992;
        Mon, 07 Jul 2025 10:05:28 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac54a0sm745507266b.109.2025.07.07.10.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 10:05:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 07 Jul 2025 18:05:27 +0100
Subject: [PATCH] scsi: ufs: exynos: fix programming of HCI_UTRL_NEXUS_TYPE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-ufs-exynos-shift-v1-1-1418e161ae40@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFb+a2gC/x3MPQqAMAxA4auUzAZqqT94FXHQmmqWKo1KRby7x
 fEb3ntAKDIJdOqBSBcLbyGjLBS4dQwLIc/ZYLSpdKMbPL0gpTtsgrKyP3Cq51K3lkzrLORsj+Q
 5/ct+eN8PxFjj5GIAAAA=
X-Change-ID: 20250707-ufs-exynos-shift-b6d1084e28c4
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Seungwon Jeon <essuuj@gmail.com>, 
 Avri Altman <avri.altman@wdc.com>, Kiwoong Kim <kwmad.kim@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-scsi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

On Google gs101, the number of UTP transfer request slots (nutrs) is
32, and in this case the driver ends up programming the UTRL_NEXUS_TYPE
incorrectly as 0.

This is because the left hand side of the shift is 1, which is of type
int, i.e. 31 bits wide. Shifting by more than that width results in
undefined behaviour.

Fix this by switching to the BIT() macro, which applies correct type
casting as required. This ensures the correct value is written to
UTRL_NEXUS_TYPE (0xffffffff on gs101), and it also fixes a UBSAN shift
warning:
    UBSAN: shift-out-of-bounds in drivers/ufs/host/ufs-exynos.c:1113:21
    shift exponent 32 is too large for 32-bit type 'int'

For consistency, apply the same change to the nutmrs / UTMRL_NEXUS_TYPE
write.

Fixes: 55f4b1f73631 ("scsi: ufs: ufs-exynos: Add UFS host support for Exynos SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 3e545af536e53e06b66c624ed0dc6dc7de13549f..f0adcd9dd553d2e630c75e8c3220e21bc5f7c8d8 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1110,8 +1110,8 @@ static int exynos_ufs_post_link(struct ufs_hba *hba)
 	hci_writel(ufs, val, HCI_TXPRDT_ENTRY_SIZE);
 
 	hci_writel(ufs, ilog2(DATA_UNIT_SIZE), HCI_RXPRDT_ENTRY_SIZE);
-	hci_writel(ufs, (1 << hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
-	hci_writel(ufs, (1 << hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
 	hci_writel(ufs, 0xf, HCI_AXIDMA_RWDATA_BURST_LEN);
 
 	if (ufs->opts & EXYNOS_UFS_OPT_SKIP_CONNECTION_ESTAB)

---
base-commit: 50c8770a42faf8b1c7abe93e7c114337f580a97d
change-id: 20250707-ufs-exynos-shift-b6d1084e28c4

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


