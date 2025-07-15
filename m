Return-Path: <linux-kernel+bounces-732266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30999B06448
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA923501736
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72218269AFB;
	Tue, 15 Jul 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vt3ZOzzj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441527A12B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596651; cv=none; b=HVwXBVDGpcyXJa2jpbVVfG2qGVjD49PfeBLJB0LVpe8crw76JZf83o1N0v+ThmDvvBiI0ir946e87Y3eLVVlsMgDtpjrfuGtjcw3RzzjB/nhwEU6DCZ2cOBAzotGypNY9YUTSbFHqBTAYMF7EV0hxOmsljJt1/HNq8YPcc/JqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596651; c=relaxed/simple;
	bh=84Zhq5Fa8DZxPg54htCnAi1mVCakbKrde37JUedCE2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eNBFZhYlCVt7/9QItOLU1I2kf/TKZkjvg2S1bamFqL16rbMWJrQaUL6dbAupvMEVW3ohjiJ2mnZrm6GfugIqnWmHNPhmRmfQOYCpbUJeGVv02a91g2e69mLJllKVeGq8IaW2STT1+okjbtCtdNqXazUdskqpvN7X1KfbcUyKAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vt3ZOzzj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDI0O025956
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mk/I29S/oFEoqtLU3bTKX52ZMG1AMTJAoA9iVUvagVw=; b=Vt3ZOzzjjI9YESZF
	9kwbCMW2PbIlu7UHN+CuiykqkVaIenmbMbM1OEMnEO92Z8+yJxCK4Eo9YFthFKqu
	oeULqdP8JstMaGvtMN5EaOE/m4Rzrj555UQ/YiLYhvFjXc6Q5azUOQt1+T/lQPTG
	DzqvmcuSlv1Mtw2vrkKD9bVV+8eIwgZJvNmXFwtfPyQ/6gksiwJUTm+HOXTPLqVl
	gP/BTTY6V9BJRUwuSZ5CYXw0RTq8UZ/2AkUs4VVwzMWWtjbi/CJ8MkkC2T2dgZea
	NF5X+xXCFtyEV5GXE6E+5uM1XgtmvppIIW+6cWLsQsX4o+L8UbSKSM/OlaDvKxne
	QvbolA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy0nff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:24:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748f13ef248so5318158b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752596649; x=1753201449;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk/I29S/oFEoqtLU3bTKX52ZMG1AMTJAoA9iVUvagVw=;
        b=kzlmnP8AQM3WFZceJErSz10GII+GXT0ASct83wi2IK/j4OrCVeXxM7pOLFMcV/65aW
         AuH3P/LZz9bN39QCMt30sJ4R7+WTLdK582BNWZzoujb7iBpw+KUJrWPaMMhCuEkbFgu+
         0ETsxngiZKy2h/PV5HKxxZGLmrTNtOIVOKrkLfZ2hyDO1hvHk0fQQcfI/ou7PJiohlmT
         JwEWXuQEOey6YuskTHgk8UA7GDWgxF3Pe4/Kfi3FyXHvjNSY+GN1QUWIpvA03ENnCJNI
         F+xn/Bre4S3TZZMMviPTccgmN4LtM27uG/RYIkLLDuDSmF1Sz+7jNi0rW+F98p4d2rEj
         QMoA==
X-Forwarded-Encrypted: i=1; AJvYcCXtHhJXuJxWAAcomFNm3hdoUMQx9j5EoyDKVlzDQJ9ekxdCoTy0578LGnqO3Fy5jxxr7g9Wh7O7ODOIPLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4k3y37nbO0B3S3payfvnvJFefhXg2+7Z0+XxWNFdG9bClDFxz
	pI82RctSjHJDTET3Hi9VvJCCM3KE/0atTFDVlQFb1y2qBfZgl0zUgm0AkCSEv8eFZ945ym7F/C0
	dBN03wjsm+yI+LS5AHy/MAnTomZfuwDiML2xwc6GZy43zE42QrWV9umPPJ550aYydljU=
X-Gm-Gg: ASbGncuaPwX3xX5NWMXro4Bxq/CUHiFjIMbgTW3LIl+UaiMt4asZ85WtiYrUlisg32P
	Fv5MTofvOp4y6ZD4JQjgbPNQXt/Qe9jdj79qac0+Slw4UmOt3q4Krj9aIaxVCBKa9OGKvAPinBQ
	MDm8cE5iiLHMQeqaM6DY5Tc5IQZa8J3PWPFfqpC3JK5JCVzy61bGPRA2fP11mLaog0HAcu4lz0Z
	soAp/Q+slc02tYNPK+UppRtTC6ViWv9fBIvD7O/wJrQXGezdDAlBrmkSM+G9u2YR9b6q0KiYjP2
	pjnaMEgfE3yAPu8Ddsq+KsmJdoc5mhMSxmLCMVmqswelF+cOS0YX3hK4jAGlu6h3dndBcUg3Ywy
	6
X-Received: by 2002:a05:6a00:2d0f:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-74ee274ca3amr23360040b3a.18.1752596648475;
        Tue, 15 Jul 2025 09:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO5K/Ti2kibTcVezSPr/Btb6+QkxnAHpHBFdUk6OSkSLttpdbpfSEnYCz3S+XnOjsEPhkUyQ==
X-Received: by 2002:a05:6a00:2d0f:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-74ee274ca3amr23360011b3a.18.1752596647922;
        Tue, 15 Jul 2025 09:24:07 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b715sm12815373b3a.93.2025.07.15.09.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:24:06 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20250715-ath12k-unneed-semicolon-v1-1-9972fd4cef07@oss.qualcomm.com>
References: <20250715-ath12k-unneed-semicolon-v1-1-9972fd4cef07@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: remove unneeded semicolon in
 ath12k_mac_parse_tx_pwr_env()
Message-Id: <175259664635.3448282.2749790548342441986.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 09:24:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1MCBTYWx0ZWRfXxLzKxdeICSi/
 k9CI7VgG3khlsuXcgLckx3siKxIwJnJfZjcEo8WNocHgt1D+XPc70jyNVHaQVOPXs3CRu4BdQ8z
 lVPov9xc/Of5O37WHAAwZNmE08+fFFVflxjYK2erWDbrFo08EN6/ddXlmFkBDzz5woITcvlq2vN
 JcW10U09w0mUR1mUye4dDvTsv5BNzylpY59C9tcWKKwM/LVmfUbOEgDjHbnUbxUbIct6T9gOTHt
 2lHoZFHCdi+7cZI44hmzQrx2HiaahkTdHeQ0W2SedkHBOU8ZG4wk4ZCgW9+fn+aNQOJ+fOSHiXM
 jBavcFpSSViv11W/sWL8EeqyCkAHwFiR3vwctZBZExDtWdSiOYVUunLlSDsNbyWIFT8am5kGcFy
 6R/tX636CvtXqzESlxfFw/8fvenJkpGrXLHKj5kEKks+bNURSaIqtEVNlGwWnxm9w/tMqTlx
X-Proofpoint-GUID: EA-ZSf8vTEyjIlKX0MY3I6iZT8abUChj
X-Proofpoint-ORIG-GUID: EA-ZSf8vTEyjIlKX0MY3I6iZT8abUChj
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687680a9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=J17AwlqV-Ij9UdG5oKoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=892 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150150


On Tue, 15 Jul 2025 10:07:35 +0800, Baochen Qiang wrote:
> Kernel bot warns about this unneeded semicolon:
> 
> 	drivers/net/wireless/ath/ath12k/mac.c:9785:2-3: Unneeded semicolon
> 
> Remove it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove unneeded semicolon in ath12k_mac_parse_tx_pwr_env()
      commit: 8ac2a383d4ce9e6229494c2a36df876800e6750e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


