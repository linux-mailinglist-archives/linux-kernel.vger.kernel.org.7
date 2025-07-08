Return-Path: <linux-kernel+bounces-721212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E5AAFC62D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CB91AA151C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3802BEC53;
	Tue,  8 Jul 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KlTSZTai"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9C221D87
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964738; cv=none; b=lCIVSCxvmVp29ZTSsIHlD8dRqG4TD2lMMoABjckXHnJQdeePcDI5mNHAA3EDvfnZiRAbWAgpieJtjHY4R/eElMaqlaemMI0H4RRPPM8PCIk/VHWTigeCECGUkT1301S+Hrp3STX3flGcz8zpFfr8h0kHJzdFdGqdwNAO5MdNrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964738; c=relaxed/simple;
	bh=PL16pCZH8Tue1eweBeZjIlwhLZ2/ZfDBGRWDMwlxAd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVZmzDmT7jHrhgMba2G4PVShxXjtbEb2z7QTGubToqqq4Ws8JwT/c/jFunzI48LB+OZ2bm6CHUvykqoNxHURcHKG0PC+Y1pRvs++Yrzh4WNcwv1o7cyEfWfVTnAeERZqwKBWOlI2/LwcKrzggWM49ugSe0N35QPg0BE7gVTcBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KlTSZTai; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56887IhR010872
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 08:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=APQGRMVDujo6RxeasGIZN/CuhwkxdALKQJF
	FEyjCmww=; b=KlTSZTaiiOwRMJ6q6QXyFlA13NApMCwx5/w0KGjAL0jM6oOf5MX
	z/kkHTXQPZzeoJ8t1uWAr0qU9WaWkPMhZ6IK6l1pEfHDeonMQyULoq0+yELEgPsY
	8izKUaKaW+kluq0feyfc9TP9zAz8Bxn2poY61JKZdY0KsgclVjoEStRgFcfxLVnB
	S+CSRNEG4XUTB7RQx9+Adfvi6nCRDYKUAOxR2b+dFIt30WhXFuuWpL90rlpDdgSv
	xmqZ0Us1OY82gVZX9VCV2UK+NIYicddz6tMgfJO9szh+Jf6Kf/NRpHK3/d9RC64m
	6YJhVf4KTWCbPcoD9fgUgZADjy55BdjH0kQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefc6wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:52:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-315af08594fso4013641a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751964734; x=1752569534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APQGRMVDujo6RxeasGIZN/CuhwkxdALKQJFFEyjCmww=;
        b=vF5xd5Ylzi0cFDm9J6M0An4KyvRbzgiOPJdWINF6rARLmJoU4GA7BmzbB30ugJ1eDe
         0Og5n2ZSGWdQEXsKTiwObSjyDbKlNwsJVlaRH/00CAbxMQY560M2BUAf9cjthvEZJXQM
         ei9Rc3fAzVtLsBu7JPpb5L/d6P7EBPGIiJbqJEzZpS8vYHoaRvge3E9Z01/qM2LRXXkT
         vEA0coRhuefcIV9UzcGfT7ZWZV+JMwLrc7xblJviOnlllCjL18+g2QPstBbrwQ3jSroW
         08+WWZ4QDPtyat+Lpq/CQlXF+Se5jNedADTVta2nJOPyceYN02ipl7T4CD8IaON4tRp2
         56IA==
X-Forwarded-Encrypted: i=1; AJvYcCWSjOSb3DrIv/VoZUbS+j3pFJgVrENUnGusVkxdARbEyZdhWy/ywRovrWbEC7bxoU4yhgSiAigPVhW2O8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwjjrp8MaUX62k+SQCJVT6RJos9AN9G4zoAVJuDKzySgW1+K2j
	L8kCsOfHXiSFkQ3hGtM4RslFWD5bHjd43sOH5S84/L4zmWVKn+aWXDAKygyHpJDF0SqaUvPculj
	lzP5/6xN0KctWwtjySaTL16TSJM36+isf5OJWXinhOzbMcKwDfInE121Z5Hwm8U+hWbU=
X-Gm-Gg: ASbGncsUSgSLNsCSAyIg6+Y2f0XTBT6Vq+E3T+ImU5ut0L0Ntd0zaDZp0ILoLIAwB3c
	D1ln+2clkDW6eFPVD2iPM3+/sVKEg9+97XcYrjZ5aQ8zodbGHDOCpVeQmktxyLgCGGThg1EA9mG
	CoQNEgon2mAST5okixsT3Ca19xudAzsLupqZhx/6X/sTuiVYLFldb3fOMPbVDh/cb3/GeNNisEm
	ICGKkSaHsxYB1xUDw2i2ZmGdum5US8zWnrnXkZ2/7GW4RuW/IuUDSaW0pZKv1P4QMzz+1Ban67X
	Jf/w+VnRh/+jL6w2snxOULlRV66hZlh0agAHyQ9wPwdGdceBfi0=
X-Received: by 2002:a17:90a:d40b:b0:311:9c9a:58ca with SMTP id 98e67ed59e1d1-31aadcf4c5dmr23323003a91.8.1751964734291;
        Tue, 08 Jul 2025 01:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXferhNfvnm07pRcDTE8Vpv7ZMilO6rDTjEyyKv7tW3s6EaSYnRMUH7pLC5nXqxn1cz61aAw==
X-Received: by 2002:a17:90a:d40b:b0:311:9c9a:58ca with SMTP id 98e67ed59e1d1-31aadcf4c5dmr23322974a91.8.1751964733853;
        Tue, 08 Jul 2025 01:52:13 -0700 (PDT)
Received: from hu-kbajaj-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21e7115bsm1522316a91.27.2025.07.08.01.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:52:13 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v3] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through secure calls
Date: Tue,  8 Jul 2025 14:22:08 +0530
Message-ID: <20250708085208.19089-1-komal.bajaj@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA3MiBTYWx0ZWRfX2dK7IcyNMA8r
 v4DUWyE4lZhqsRX1TTGs3bmEPAw5FpU1Ac5xMLe00IjbC3+obClTlURls36MkN4ZaCtgqZc5WUC
 n1bXxg4htpUUaDrE7gOpVKfxyQbARro2AWjdEqgnfqBLP85tskDg213EVvkQ9xoCYNKBsumC3Z/
 QL8AisNAf0FGqGm5x3U5NtfJpsLWxU14AYaNhAV6pGQGXqSflMJKhTgeeVjEMnWEo6o9hBK7hxk
 otU/aLE4LaG52cctKxJILuur65bRwx+DvEAVV9gDTt5nhJkLxCN/NUp0Z2FOMoPswVmmoMQUc8Z
 nCLEhn+i03uxxAsCnatOCuNelrFxajzmiLRxT3FcsZ/LsbZWGmayyAwcrFuqVLzVDcbFDFwm1Pn
 9vls0/fXFu2lxr+OXcaRA07QkjpKxIC9BDEUMmP5P8D4LmgADl4s/s+zk6+eSYRvhU3ZAeV6
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686cdc3f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=nP5vHkG3G_wrkassXHYA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _Q-xRARIIVXmh6iza8koj37ikW0mSn1e
X-Proofpoint-ORIG-GUID: _Q-xRARIIVXmh6iza8koj37ikW0mSn1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080072

EUD_MODE_MANAGER2 register is mapped to a memory region that is marked
as read-only for HLOS, enforcing access restrictions that prohibit
direct memory-mapped writes via writel().

Attempts to write to this region from HLOS can result in silent failures
or memory access violations, particularly when toggling EUD (Embedded
USB Debugger) state. To ensure secure register access, modify the driver
to use qcom_scm_io_writel(), which routes the write operation to Qualcomm
Secure Channel Monitor (SCM). SCM has the necessary permissions to access
protected memory regions, enabling reliable control over EUD state.

SC7280, the only user of EUD is also affected, indicating that this could
never have worked on a properly fused device.

Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded USB Debugger(EUD)")
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/usb/misc/Kconfig    |  1 +
 drivers/usb/misc/qcom_eud.c | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 6497c4e81e95..f49d5ac0e957 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -148,6 +148,7 @@ config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	select USB_ROLE_SWITCH
+	select QCOM_SCM
 	help
 	  This module enables support for Qualcomm Technologies, Inc.
 	  Embedded USB Debugger (EUD). The EUD is a control peripheral
diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index 83079c414b4f..156c4f75c3c9 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/usb/role.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 
 #define EUD_REG_INT1_EN_MASK	0x0024
 #define EUD_REG_INT_STATUS_1	0x0044
@@ -34,7 +35,7 @@ struct eud_chip {
 	struct device			*dev;
 	struct usb_role_switch		*role_sw;
 	void __iomem			*base;
-	void __iomem			*mode_mgr;
+	phys_addr_t			mode_mgr;
 	unsigned int			int_status;
 	int				irq;
 	bool				enabled;
@@ -43,18 +44,27 @@ struct eud_chip {
 
 static int enable_eud(struct eud_chip *priv)
 {
+	int ret;
+
+	ret = qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 1);
+	if (ret)
+		return ret;
+
 	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
 	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
 			priv->base + EUD_REG_INT1_EN_MASK);
-	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
 
 	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
 }
 
 static void disable_eud(struct eud_chip *priv)
 {
+	int ret;
+
+	ret = qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 0);
+	if (ret)
+		return;
 	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
-	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
 }
 
 static ssize_t enable_show(struct device *dev,
@@ -178,6 +188,7 @@ static void eud_role_switch_release(void *data)
 static int eud_probe(struct platform_device *pdev)
 {
 	struct eud_chip *chip;
+	struct resource *res;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -200,9 +211,10 @@ static int eud_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(chip->mode_mgr))
-		return PTR_ERR(chip->mode_mgr);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -ENODEV;
+	chip->mode_mgr = res->start;
 
 	chip->irq = platform_get_irq(pdev, 0);
 	if (chip->irq < 0)
-- 
2.48.1


