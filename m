Return-Path: <linux-kernel+bounces-720616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A15AFBE4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC821AA5268
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD61028C5A4;
	Mon,  7 Jul 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BhmZIHvw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2BB259C93
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927787; cv=none; b=WR37YbiwzgoowDNJ7p4nkQRNEQw+E6KKdHsgASUWS3CyB5LPt/9BDUgmv9Nf453+tnI2MajzJZxdt8wsQULi+6q6jtIIZSCqiUUUNJnRAvU64VgUiP9B+/OQ4fOL83JJqTQ2m1fB+upiwpC0GOHideJeokzEOx6720AoYjFLakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927787; c=relaxed/simple;
	bh=YkbuhjDgaRmvtKN1aWFXpA8UZhqLcaMciIo7JBfvJf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NcWg0+viMAlQKrJziqS9etytenuY2Raoe79CxlVx0wiEAFZW+fkjAYjSGnLVOee6yYbqm9C4jXQGv8zsPuA5Sb0ZZUT8QyABa/O00HKmBLcbt2nBsHfrxdeiYtFkshQ6wCaJ4/hfhLBzLeC9QBJn+okmsnciLlli31p1RFJ53lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BhmZIHvw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567E6ZwI028902
	for <linux-kernel@vger.kernel.org>; Mon, 7 Jul 2025 22:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	58sLsyVBxSODICZUsU9uTkMyvgRokbpHZA7Sf2AjOd0=; b=BhmZIHvw63tpvk/8
	QpeKBX5hTMzaabOhnxdkJjDkNVtM50WxVy3aGR5SKBcG83JFBPg3XSwCDME169Z3
	i7nsETj4OGz+5Wqi2aVerkRTkgo12QXYXGln08SQMzc/2g5x4Ij+ulkF5MasdbJL
	a+GdJVrHBWU8uSHx7y3jZvjLqZw6SrRgk0IWwnQYh3yeHZW8mNlVjWteD5H4Cd9e
	+Lhz6KV4F7TUgVHcWHtjWiiOy1BDNIWvXJ2WrzdYJ/L0YfKNElt4WOCEBho5t9VY
	Td/UkHQlEmz6TY3tjsr8SDoyuCJfxnA98OadwMBx0w61sJfJ6QN0szGnu04r8enn
	Xz+64w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47rfq2u8h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 22:36:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74927be2ec0so5538949b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 15:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751927783; x=1752532583;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58sLsyVBxSODICZUsU9uTkMyvgRokbpHZA7Sf2AjOd0=;
        b=rKhVeNAc2l51ioi8fjdGhhDCH9dIe2RYJLHTSqWkca4bey+UK8+H11ym3VBzTFy9yD
         vH5mZA4Q86ejj4oJ0XASsS/zvuhbjU5ufJvKtXGtfYUho0acZ3/GdMl49i9JM79eXB55
         X+oFudoS9Nv+lsnRhjRgpTo3eqMb4r2GJlmW5DTVBLVULxonTOkEL629YD2MjvLq0a11
         EtIiNIbXRxgqs2v/CM3j57nY1Ku1O1DcfAiAbkwDaOOyNoY5DsjKfo25cjomzTYKm8dd
         5tWjzFa+O5GQIrHLiPlzjdBTkvec8bbimax8WcXc6CK+hT/MHQyE/89mJ7KpMPHMFGKC
         ymCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNQhlfKGReiqmpM0dtaQXBdYNAfUG8MJaZy9oXZv2OKjh3OVwM/hf64/pOG+OWvB9X6ehqPoPBREKfxno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIhBAZglDZ6C43rXSQTgxahaAtrpvq1v3jw59j0sfa/DDqUp40
	BtbamKscIRpl3JM6DzXujVwaZdn1LBgCBeSH7fT26pRItfRane3XCG0ucaBX6lSo/+OEbmqCSK/
	GCE9QJnFT3bywCkPUg9R76jyvDVUNT2DpLY+Q1vGutCVLf0V5TciF7mAWA/VSoUDoW/phRLrtA+
	4=
X-Gm-Gg: ASbGnctovmmfrWnb5TqMJgTWjjpZRzC8tGMXiZH26JHv5MbIobqoErV69LVvP3M9vRj
	4ecuMhu2vbFzfaox024m5mFBj0cnAamBBDZehB6e3CfsplewUC1zSYj7QFC0ayZHzlb5+1AWXHx
	wX5q/HLRxkAuAEYjbtMCI4YNvGTpwxQEzdpqgL5B+AC5legxvModQ85/5dqz7nCJZlbHzH0YB7I
	yqXwAaTxTY0LCQW8Jh4416m5hs4Y9NprZ2ifuGoyxQby2HdlFF05hV4Hh1ZeFPOfJq29Gv94MF6
	wkDf69/ms/7c5yE6zv3KmLM0P8TgFilicoS2Q8xxfG1faDXXUvlfG9a2RRg=
X-Received: by 2002:a05:6a00:2354:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74ce8ab166amr21446833b3a.15.1751927782738;
        Mon, 07 Jul 2025 15:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwBqL+fxR/ucQx5k8AE51TsXkHh05PJEkfhYYKNNad+uzcD6SMzfUayMwxjD5BCxoUPKNXaA==
X-Received: by 2002:a05:6a00:2354:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74ce8ab166amr21446812b3a.15.1751927782351;
        Mon, 07 Jul 2025 15:36:22 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee6358edsm9668064a12.58.2025.07.07.15.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:36:21 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
References: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: add support for Tx Power
 insertion
Message-Id: <175192778158.314276.5668474308481760371.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Jul 2025 15:36:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDE1NiBTYWx0ZWRfXwbK+FaWBGfPp
 58z/UXvh7nSBnZ6zZFRIxA2cEbypCVupmETdrb6zyKMzxgxibNeu2DN28agM38U+Sb+60N12QRY
 CjUtv27QM1/YVOtPPfDxsHsHtNhcZiw9a6LQOLuVl4Gr6ixnD7I4a1ost2b4b5QYO+vPwcb9SZ4
 iHtNqmIH3YvZItFb9m+2x63y9nEtz6ZMqgBHHw9kbr4nLOLteIJ19XErP+ojVsW/EvTa+/KyZeV
 whlRhFrMIKz6tZGwNqxs4viC0X1F4FJVspRVLhO/MPc130AGA10ps20HsFEPE+9l8+kxuGSXoWE
 fYq2ezZXgaCRSjV6qMFIf74WWYNus8hCeLQGt9YlU/ONpNM/C/MO0aQkwhIdae0k4fCV0r4M9IQ
 K/mfHWMA3w6fZgkdSwT5/NAy6qxlZcGR1xEbGqMjEbFZCFnkZyFQI/z9Ok3fwa/CCfMT83Ei
X-Proofpoint-ORIG-GUID: vNfw9oWE4SSNrjZpTHlc9IYasuWU_TE1
X-Proofpoint-GUID: vNfw9oWE4SSNrjZpTHlc9IYasuWU_TE1
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686c4be8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=bhy6XtatztNBMhLyL1sA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070156


On Mon, 30 Jun 2025 09:45:14 +0530, Aditya Kumar Singh wrote:
> For certain action frames like the TPC Report IE in the spectrum management
> TPC Report action frame, and in the Radio Measurement Link Measurement
> Report action frame there is a requirement to fill in the current
> and max Tx power of the device in the packet.
> 
> Add support to populate these fields in the relevant packets. Advertise
> this capability from the driver using the feature flag
> NL80211_FEATURE_TX_POWER_INSERTION.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: add support for Tx Power insertion in RRM action frame
      commit: d45d015448fcfbb5dde7c09f2b0dffe5d689e6ca
[2/2] wifi: ath12k: advertise NL80211_FEATURE_TX_POWER_INSERTION support
      commit: 93a1cdb9cd94c7b8a2aac33e4b13ca61d712f5eb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


