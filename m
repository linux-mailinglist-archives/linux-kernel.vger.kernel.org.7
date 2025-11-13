Return-Path: <linux-kernel+bounces-898763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4AC55F46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B3E434E6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBB320CDB;
	Thu, 13 Nov 2025 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="puyJj8V3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SntrsJZq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD466320A3C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016080; cv=none; b=cIwjAMMQnkmKIoCYbgp6eYf3R7lOsjqbjPlTfUklecC2DvFV98TZjt8iYYkKgj1odCr0KqfVrtodu6XQC+3+ZkxCEJBD3mzAJR0lXCzxWAxUNjvJ5mnWGsdH2MG/KG60v6w9/KGH5Z0b6dC5pns5fWOle4dB0DuMCMzocdBxdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016080; c=relaxed/simple;
	bh=+Ke+KFsTtiPqM4IHJhRaW6f4MSw/B+01CP19xDaeQTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uxr7gYPSRLbm+N/E/p9TcLSNFNHiACkuIZw9Cb6/AbWlrKCCciLGybJvqfWOKqNHXIDUJFgyAyNxHfG4BvAg5NeuKrAb5MRU1AHpLSx2IzGdFUEVH9JsSWn7oEhAKblSFIcwMJ18pmzU2XXva6P36SFJVhj6n3lO7CJJgUuzY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=puyJj8V3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SntrsJZq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD5SEbZ3440692
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vU7vryC4Pt5YAZEAUaqbqwIE/ZqBh1IMXki
	+lNsih68=; b=puyJj8V3t64zL2rMenQUWUyTass2Wo0MxT+c3GlImgMb7zTrHWr
	1kzenpBC7nxzDRAadM0OziYwLhbyVIRjZlq/F/DF1953RABLJRN0Y5TZqHkKw/fZ
	sXm3Q37U9KHUwzZM86C894w10pv+xMJuVZ5vWYJDnL3h5hPMM8tOCFru6t+1T2RX
	38kyHunV8vrHEDKp0MwbTMt3nD/+s7NLc3N5vqyXI8uxddrhc7A0tCO4MxYJ84Z4
	neDoOhCZPEgcQWdp4JswHGo+ZzXegF9lPq7grDAhXHksL+yYnr7wO4vk1IXmajBa
	mo2u7iZqineMSn/SdiBbk/ygLbxj9KItJyg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad97887ay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:41:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bc240cdb249so459957a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763016076; x=1763620876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vU7vryC4Pt5YAZEAUaqbqwIE/ZqBh1IMXki+lNsih68=;
        b=SntrsJZqU2Dt1Ps1eVMlKcdW2EUgB+fYaMaY8NYYq0BT2kSTtwpqMKIALKGWYj2Zaz
         hOjdHXmI3FNb+XljCNsWWZgyitaSPIQc7+cXcwROvd/sC1ufB9GKT/C52w9UvGVxFFp0
         QU79rlITfAwLpl4dClv0fSSjvnVD/Qm1vJswAdm4UV41eIjT02RcEGUAJ5ebLQtZ+H78
         c7f9slSFuV/DKuXAT1Z/F24Mc1evgxOgOjHjjF1YViCUGYH9PlXTbWTCe4EFpne+JlXb
         BuYvF1XPbW+KgrmHzTA79LDKv5Qr+6IfjHiUfrLAQCtKuobO/0uGMhCIDI68x0aR7Qc7
         VfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763016077; x=1763620877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU7vryC4Pt5YAZEAUaqbqwIE/ZqBh1IMXki+lNsih68=;
        b=Q4onI37UjdTgrApjgvM69lMIEDuAUFq8srRytwgzY2PU5NI57ppP/FjRF6WnLZsXwz
         TI3YiN4QR84/1h8UTBh5yN/r6Dj5PURFFqns//E50btz7wcoPc1zb5EukxYBqCsBt5PJ
         MALLNY3TGfN7TNoBnS4asZtKA28gwZA4zNkPeNddrSFEKf8U0f+WJXRuHxE6sjfQ8mf+
         wZ3nVizu7mZN6pALTFhLmv5/o2hyJdeu8+JoETeS6FSCcUOmezommFT7AlY4Mk6oFlgG
         pJRWloMy94hBHST6lFD9EloMoXo8herTEsRJWPnp3fLKXLg5N8x7O8xBCxKG1ArUePsY
         31EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmFzTjajbJD8TtzQxnCA+r6fe+4f8e9qM5SdQeXjLUDpN2+YOuCxFRS2aFl2P7Za5/XNGmn+x0hDEvumY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fBS33kaNh2jNAcJ/2C87xbhm5I3jDOb+hhhW/kyBIzlOOAGn
	g2eWBAnaPoNc+zEU2PSZyt7BSAyiwU6rqLOXy9uyHBq0H4ZdqfleUpVe8fKqymO5k0bQCHy8X7r
	Ieoj0Kuyyf5jPm06bHF0ge879BfkEVtD4LZ2sYBTuXNDp5VGbkdu6DVPPd8dW6BFCqlc=
X-Gm-Gg: ASbGncukKFWo/BW6UyQiirJm86ehzOBZoCVpWH5fw8vkarG4o53Sd3Y3MNzTuVvpSjL
	+VS+bwa6Qq25LxtSgSdx/XqItnPvrkJ55FZymfzByw4zBtgI3B76MApbqhTeqHePBfeqFKfeGbL
	0DfYgp1/30DTfbQDo/lDvd5IYWiBIlB71J+Y8b2QTwOHaW/8wdCSC+lj1ujDHY1CmDl4lDCRiPs
	lzVYx4FRg1HjIkvunlGCejawYZC8oyMViDdow7oXTcJbQEdrG0hcamLMDG4XRP/1vk0OgelxDSI
	/7gn7zU22JrfzjMvbQ9i3Vp2DArbqzoC3XpaM0fTzGVPFw7vPfxf3o7gSb3xToTE1p+E11nWfTT
	8VH+td3Zj9VFjXgk4d899GpJbo/OABiA=
X-Received: by 2002:a05:6a21:6da6:b0:33e:84f7:94ef with SMTP id adf61e73a8af0-35908c8a6ffmr8002119637.11.1763016076566;
        Wed, 12 Nov 2025 22:41:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtYraI0TKB7wHfSTVlzFGmjGWRnrZ7crCPf2287nYk+GoGEXlI8vnXbcHt76kEGplJFqjP/A==
X-Received: by 2002:a05:6a21:6da6:b0:33e:84f7:94ef with SMTP id adf61e73a8af0-35908c8a6ffmr8002087637.11.1763016076030;
        Wed, 12 Nov 2025 22:41:16 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db25bfbsm1138419a12.1.2025.11.12.22.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:41:15 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v3 0/3] misc: fastrpc: Add polling mode support
Date: Thu, 13 Nov 2025 12:11:08 +0530
Message-Id: <20251113064111.2426325-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA0NCBTYWx0ZWRfX7Ixf45/mbh29
 YUm1plWiOsDGOjoiHuk0SaMHMqAMTwy9+STLx3OqHitHjzJrIrrqu5bNnASHbM2TUF/8Un5pEcy
 LqNb5R8a6z1oxpvTL8oLYe+5j2dQfk9L5PmJjuwVv3J4AxnsFZG4JAJ7qCwN8bB8lr3YjSR3RIS
 SjlJqRSC6aFCXk8XC9sIHdowDwFkbD/LYkqmLVXHGESKuQ1b5KaFZQsedH93EiFrTqrykanRjYx
 OGiuaK0Na9aTwR3H38IyzT6bnCJwf6aH1UUaP8k8Wj8JgBTecqfWjVMfRjL2Dhafl3FVUHVG0VQ
 pua4nEVhbTzYkIMq3ev1opAfxTxy4sKpKZMowVpeSln/c/fpxrDc/I94CLOcjSas1z/5mfv+KBs
 YJER1mSp5D8zlfbYWshHrRdQ9JKIRg==
X-Proofpoint-ORIG-GUID: LgnAgaGDR5zzQM6Be2yGvdcDEtXvHSmk
X-Proofpoint-GUID: LgnAgaGDR5zzQM6Be2yGvdcDEtXvHSmk
X-Authority-Analysis: v=2.4 cv=PIYCOPqC c=1 sm=1 tr=0 ts=69157d8d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dFrkBzGdCdqBpI6tlPwA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130044

This patch series adds polling mode feature that have been missing in
upstream FastRPC driver.

- Add changes to move fdlist to ctx structure to avoid code duplicacy.
- Update context mask to support polling mode.
- Add changes to support polling feature.

Userspace change: https://github.com/qualcomm/fastrpc/pull/258
Patch [v2]: https://lore.kernel.org/all/20251106050839.3091707-1-ekansh.gupta@oss.qualcomm.com/

Changes in v3:
  - Resolve compilation warning.

Changes in v2:
  - Added comments and fixed commit text.
  - Defined context id position as a macro.
  - Added new IOCTL to control polling mode as always enabling
    it might cause excess power consumption.
  - Cleaned up polling mode implementation.

Ekansh Gupta (3):
  misc: fastrpc: Move fdlist to invoke context structure
  misc: fastrpc: Update context ID mask for polling mode support
  misc: fastrpc: Add polling mode support for fastRPC driver

 drivers/misc/fastrpc.c      | 163 +++++++++++++++++++++++++++++++-----
 include/uapi/misc/fastrpc.h |   9 ++
 2 files changed, 150 insertions(+), 22 deletions(-)

-- 
2.34.1


