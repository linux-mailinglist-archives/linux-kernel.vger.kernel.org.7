Return-Path: <linux-kernel+bounces-880039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624CC24B99
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBFDF4F4AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73833451CF;
	Fri, 31 Oct 2025 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Usrcukr4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="acqbTkB1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E734677B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909139; cv=none; b=Jm4xPl2j2/4YrgAQ6PaS+qIKWB0LEdmkpUDKnlRBz58P5gOW6+nA8obKsWGL0e59uL2lCC7RIscmUBnO1yDvK5jjI3ho/vFJD1NYg4EJYvI3OvbeKop03HTg9JbHDd2xxrcPAe7U/24So8NJ2OwLH9ifnvkmxzR2jjEyjjrAZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909139; c=relaxed/simple;
	bh=kRgViZa4KGaZCel0lL7UaLwBZ4oTyRhW1O/XbfTvd4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ecpyXF9DP5Ij+CVN1NlFRq107soC0LDN9U9Mr36VNOl8YFn10mOgDH7IkASdqaZWSB2VB9JxiKe3lfcwi443tl4H7YY4Hn/YUFy8RY7GoEy3zI4AkO4NJ80M9mHmG425/sJeph7G6OIUVolZWIBgGt6TDtSzbl2lT0Z1Ehzz5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Usrcukr4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=acqbTkB1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V85Kf9833768
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=; b=Usrcukr49l57A1aS
	1nQW0kFBQrOVre0mECjsOjjH199lj3BVFUCGOfosUokPi0MzJMgf5vVR5G1FKw8w
	pR6a89vf/VNyTRZdoblYNRnQ4fWm4U7fEb/qq+49Gna4c4iRJ7vi9ouJ1xl/QBLQ
	X4A2dVaRCJuKzLuEoXP3BjZBtNl9jCUoy+bbuWi1IHZ1XVlAJu4e48jA03elz93p
	d9MzZGVpr/0/LKzjBnhpoJK5MKdqm3n2OgyKNCggnBviaFpGtUS4STe7OXHOpBZe
	scFMEB7Wl7mI/hesN7Ui8Y27+3VCjYVP8Jr5muWGZ1iVdMc0WkXGgua2MccbdWZ0
	XDJjbw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb20cw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-781171fe1c5so2097759b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909136; x=1762513936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=;
        b=acqbTkB1arKLS03vqzLxFSZAgwo8TD7mGq6+4rtfiM3lElHSwD0EDXn3GQkialf9Bw
         NQmHZAt3/D2a7rPV1BNHjdhbkebBHaENtijp9evrp+tk4t/ULJIgGnUnhsx9eV1tX9R4
         Z074cCrVVVL3dbHndEkrMaRerw+DQqvf9jIWPORp4VdNh9KnOWfyNannRqdrmmsjcEgI
         Y2boMlpIsymtM920HtCfjI/NqC4KbpBT9I7RKJ+qBD/Y1VLEK+g+XxTpYG8Z4AJVjcp2
         vWI72p7WEavqXBFjEZWt7THT9c8EON/zKe6psgA12gsCjLAOwFPAa55i9rmpGBAEfLW9
         YSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909136; x=1762513936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=;
        b=AA/Y4bsvWEeGiLDOTUZtDflDzq03/Xqz2hseADyg9+XsYdwf2yFE0aq+SvDLayF4oD
         myPk9KNIxK8wlSMRqEytJoLEu+f5TZNLhLWbqOTNHp/tf43+pzlpTynVT//1UmB9MmVy
         En0KMb7xHm1l/Yl5QwAXPuKhM0OsLEUhZ7+k+9H/txKy8cB3DX607Nd0sZF9IDl4Yab0
         5fMKf5iHT3/6GkheOD4TcbiQV9UjHrYMCO4l35w6nnbBxO6OeErgSKVfdY/s/Iv6nxWm
         P3HcCky/quh+e3FI8r9aeStPCRwsoj84xiYR3cA4PKqFF1v4IGT6IfFtq87ecFSya4vZ
         uc8w==
X-Forwarded-Encrypted: i=1; AJvYcCV2jnhYojivmw4IDDZmIes/tbJhWeidFgwFpX82fE+N/gPGubdU0JD2pZ7v5A5y+sVbWRfdXm9kxZABt9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbtRRksB6nVCWFXK9WnO5Iyh1C0xCJ35KB+ZJkw0+ezfhLe9t
	WJcH1188ze6MAGqQE+PP8GR6VzkquNM37s6I3VE8gdUJfVaMtzorv3xurOCV/NF3WUzrQGgrVac
	Yk9IEYarJ0rzBtMoVKCzt4651dZs3IHwEObZySGRGSXR7/1Nei8MeabzfLIvP2Ma93EM=
X-Gm-Gg: ASbGncvE7GgaXKcx7b7dmsLPPH6DQb7j6meguR49MIe8Upzj0luE+TiVi6ThUkC8rOk
	ZqXwxIwKCs48K1OwD1haKqbN1zDSZaX8ksLi01dbXZAJMupWJpomvqtDUUoKQt7byFcSPMieOO+
	nXE+MD7UAEyfU0eJJuUceHnaO4undjQkOsvuvGP0iqF+W85r/wLeGxmpR43mOa22kljZvBSwlA2
	TZLgLtBAT/c38dhLomG7geHEM5xIolPBIvVo8Je/6uCy+7cR/ieCJuRzxjY8ckqt5LCksJUmEjg
	yeiKf5KW/EhSUaZ+PwO5JstlmXYTxfAutZXWgCLVzJZr0VuqyL0wbE2pSpCt4j+RSfqNkfFEnt0
	WP6V9590wb2wh00tdasSJExT/U1I86VFgzg==
X-Received: by 2002:a05:6a00:4f8d:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-7a7791d1125mr3910392b3a.18.1761909135823;
        Fri, 31 Oct 2025 04:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhubKPPE9D0JeUD5go47qodOpssjwUn3GwTRVSQBCP7yHbELN2ptPRHkakDse55oZJV5R7HQ==
X-Received: by 2002:a05:6a00:4f8d:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-7a7791d1125mr3910338b3a.18.1761909135279;
        Fri, 31 Oct 2025 04:12:15 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d7793fsm1887363b3a.25.2025.10.31.04.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:12:14 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:41:59 +0530
Subject: [PATCH v8 2/7] PCI: Add assert_perst() operation to control PCIe
 PERST#
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-tc9563-v8-2-3eba55300061@oss.qualcomm.com>
References: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
In-Reply-To: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761909120; l=1537;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kRgViZa4KGaZCel0lL7UaLwBZ4oTyRhW1O/XbfTvd4Q=;
 b=HrAyKeLouCz3nx/+f3+TeNc5DoW/Qgx9BloWz6GcfHSiQxuYfJFNO62EKl+/6nGVXm3dt4O0E
 45aSdLQoOpYAW7vKoeIdYI/cz0UMi4JzErzLjHNJWdTgv9X2GE0Su1J
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 75UGT8A07HYTwJl-l7Bg2IKMjXq_4fyv
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=69049990 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 75UGT8A07HYTwJl-l7Bg2IKMjXq_4fyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfX6cFDg3ucCkEn
 56CpvSdcFbESBaO3B0dgWB26vgqsHctRbMstEybc9z8Kcmxqdvfh2q38vSro/4RhZYpTQZ+a9fz
 qmuQLEv/SoiqTj08roVp3Upy+AyLGMlsajljBRFqI9yn7XcyrYOnDGmdjmSRMRaefMkyx5gCYjo
 tCsaGTG09/oYsEKWr6GkHANFcIURtJa3nvZs+o7lMGZI8TKJy0mn4rf1+S3RTxWb8gtWVSuDQJs
 U20+WZCWMUHmlpFYYQw3yZsPYDr7I1vfwL8BHK2J9RHYLBzuqdsfGnECtamS49/YkUovN3hDyIV
 GTrfSkwciPbNsku3VEeUKRkPM/sD0svc8+e+hkiCYbaO4TpfJNbua9wRp8vlvK2RzfhS2oM6SFd
 rxm8JEZsTLB8blCvABiZa33S5qPmkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310101

Controller driver probes firsts, enables link training and scans the
bus. When the PCI bridge is found, its child DT nodes will be scanned
and pwrctrl devices will be created if needed. By the time pwrctrl
driver probe gets called link training is already enabled by controller
driver.

Certain devices like TC956x which uses PCI pwrctl framework needs to
configure the device before PCI link is up.

As the controller driver already enables link training as part of
its probe, the moment device is powered on, controller and device
participates in the link training and link can come up immediately
and may not have time to configure the device.

So we need to stop the link training by using assert_perst() by asserting
the PERST# and de-assert the PERST# after device is configured.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e427aecbc951fa3fdf65c20450b05..ed5dac663e96e3a6ad2edffffc9fa8b348d0a677 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -829,6 +829,7 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*assert_perst)(struct pci_bus *bus, bool assert);
 };
 
 /*

-- 
2.34.1


