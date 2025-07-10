Return-Path: <linux-kernel+bounces-725909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA546B00560
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9AE4E5FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3073F2741D4;
	Thu, 10 Jul 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BASj/fjA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256122E3FA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158177; cv=none; b=PPXOk2ErQIMjsv2cYPhqFouCZda45t0llnpoqw4U6KHtRTFGoR9ouO7thnRALs/Gzh53jLqUHf8M8uujCtt8axfIhceZKNqvNfX/Wk4WGMufdVKxo6DPWLTjS/EBkGblpSAVCS5dUMubZldsWnI6pVJI0eA9OtnsNk5nVUA1MZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158177; c=relaxed/simple;
	bh=Ytx25GY/nU2VdOgti3tVVr3OQnWg7YcdFoOvC8ch0v0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pcTcR+KErcu9pc7qK2HTsFFQYfZ7SRKWhi/WdcTm/X9sy9thwWu7NZg0tB+N/t3P7E9LBvQUYH8njfyU3Q/j/4Uem6CMmO4KBbulNVITNMzSHsex2dKasGlag13YYZBDkT8iUBoNLT0bB06aX2fYXyNhHDuvFcALp69owMfA0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BASj/fjA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9FN3J011560
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dg7JRVt95il8s/jz7TuZQeqrrUbBN3RXqv3GEYrwXmg=; b=BASj/fjA2/M3JW1H
	Jjzwo7BNCShSOzIgYCtHAkZcjMTlcqsowPg7g4GiX+ES/LbqfBtw/eHMYr6PH7E+
	SnCxpFMNGak4XtwuQegrknF2rmDVrCVX/NSa53kTm1wMntgsbrHwAHV/S6EBh39F
	GY2ZV2+cPFsjBhBDnPdg3fYc9kh5GV+Pca77/sgmOmtrmvIVXsfiWOMtdfrXyyrq
	uljgQgO5HKl+aHGddRgCTtopYdi1Kb5yfOfITvts9Cg0Pcvmz+Kg8NxhhHCu18eo
	W5dH0tF81N5Bb26kpH9ATYQBos9pdOWfyuqtKpwI3gzafjGsVtxT1TGhd8cGHicB
	+jZZFQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smafn7bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:36:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235089528a0so19201635ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158173; x=1752762973;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg7JRVt95il8s/jz7TuZQeqrrUbBN3RXqv3GEYrwXmg=;
        b=bzplGPkJcVhha0ucf1bkBOmIHK7PgvW5OnwMxLNLBi7xPdvJoS3kEz1hX+XHfK0BAa
         tWL7otyVQpSbJFcKNnkSFCwgEZb9pfga4LCTW0P/fMvqR1mMtDbtBAIqmVyGdd83L3aL
         tUXb/oPwLsn4ojtxUYF7uLW3jcsN+P63oYCBsdNtHWfipBiIyUW6De1DCGf22WsIYQD5
         gGYWDWUh8ucc/AoTtsuB8ve4itNz0YJM661k8TrNALQW7FmUb8Uh6GowU3m2dP5X15uE
         7g4vIAJB1h18mDV+7PRyN+aw8jQKNivzXQl8rUqgd8Wqh0R8VGmyCMx7mqSOyNXFSzBF
         aCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsmAHEtuBirP/ghzkzEkNeqruNRCEsSjK2O6fD9SSgLfcXJCBTCn3+feh3XA91FhP0/RAYa8BNLlSO17Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaWR27DK++Qx+ieqroUPRppsSZXHTWZG0TMfTtXFeJu5qVePy
	Z+6TyaW5KfOGF9awSkQBrdkIjx8c++X42cQA9JMt3ToaNduFnMEjW8WFTJ30up/OxX7q+PYYCwt
	CFJ50vngx6xpHCCCyKa/qIQpR7dw+hWUV4B2WL8fp9iDsFyVQd9E8Y9D2BgyP/zp6b5Axle5tb9
	8=
X-Gm-Gg: ASbGncvFZGuabT9i+VpokFVTcu2152LZnuPG3IdcOjpcurvaFTIAO/KZVJHihHHzHTw
	03zCvqgdt7Euy7IUR2vyftznbACAvpHmGc0AWFPCgU1ChdLI8GK5M2mTkEBmfLCO5wOu3CFNygy
	5pyw21xH76fZ6bCnvtwkTtYJF7fM1lUZl61dOIqJxkIbTrfHMPMX+Y83DdBmV5or8i8/oU1+JoM
	uiX1SzV0/1BheUQoKwxVXAs86VWJB0Xlnwz67I0T453M4TWeGEN+Ls9d3ZWLQ2ZWIBgtPd1uDpT
	W4iVHgwk58j3L2CWdFaCf9NVoTo4wvOy/1L7Dm8Z5XwKBxPFWNtA5cbNGZI=
X-Received: by 2002:a17:903:b50:b0:234:adce:3eb8 with SMTP id d9443c01a7336-23de2f7dcb5mr61822975ad.12.1752158173439;
        Thu, 10 Jul 2025 07:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7OiZudC6nBSVY2ndwLIYd90vpOrAhe8RwjSa8EPgDYPyCW0TtT34tHP6hcM40vgh3hSHMbw==
X-Received: by 2002:a17:903:b50:b0:234:adce:3eb8 with SMTP id d9443c01a7336-23de2f7dcb5mr61822465ad.12.1752158173010;
        Thu, 10 Jul 2025 07:36:13 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359a86sm23758055ad.210.2025.07.10.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:36:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Lingbo Kong <quic_lingbok@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250702-debugfs_htt_packed-v1-1-07bd18b31e79@oss.qualcomm.com>
References: <20250702-debugfs_htt_packed-v1-1-07bd18b31e79@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: pack HTT pdev rate stats
 structs
Message-Id: <175215817183.507672.13750771482128165327.b4-ty@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 07:36:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ZJ/XmW7b c=1 sm=1 tr=0 ts=686fcfde cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=UczwlVCNLZ8JH68BmIEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: BKtFDOBPnHojO7C-bMGo4UOMBrhqiMAK
X-Proofpoint-GUID: BKtFDOBPnHojO7C-bMGo4UOMBrhqiMAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEyNSBTYWx0ZWRfXw8bjVKJxL9vM
 6lGVbkrPTl0phKHecWfSvgrF3Ump44zHpFer0hX9SNPysCLWidgVExD8JPBfeptCWWguF8KaZH8
 zHuyJli9jIWO0QEMnoCKw0PbnJNMq8ryFs3eJbH7m9Q3hoW8bKvnobG3pNYLRmurNUH6XauDaXz
 h24ui7+dMwtVJg7uSJpoP6uQcqWoGQtauvOpjp6QPrYmK0ZotHf0IjSdAOtpnjlBsalmbd28aJR
 lMiWsKFHR/ZxChumjPCXARHKMN81FSO8eG8boaDK2bsF6V3YQv+fetij/nOnbc7NsiHgx62mLe4
 2orFT5+KXMtcjS9TyHQEXuzUCkh0IsNSk16HvZhEPYHfCVMawkzqWQQzgFv3S8JJEtO0g9lpjeA
 +UKUronCAomfFibdkm8lvHt/c0E+5OLnmqhqA/NNcYjyJRkUN5K+B6945S1ssfcFjto9pcCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=819 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100125


On Wed, 02 Jul 2025 14:29:12 -0700, Jeff Johnson wrote:
> In order to ensure the HTT DebugFS structs shared with firmware have
> matching alignment, the structs should be packed. Most of the structs
> are correctly packed, however the following are not:
> 
> ath12k_htt_tx_pdev_rate_stats_tlv
> ath12k_htt_rx_pdev_rate_stats_tlv
> ath12k_htt_rx_pdev_rate_ext_stats_tlv
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: pack HTT pdev rate stats structs
      commit: fee9b1f6691120182136edacf590f52d62d9de7f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


