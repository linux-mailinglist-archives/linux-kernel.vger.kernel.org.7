Return-Path: <linux-kernel+bounces-823767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97976B87673
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDA37E2179
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB482F25E8;
	Thu, 18 Sep 2025 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJvILq70"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5C2C326F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239246; cv=none; b=GNkHXD/Z8xdJ9dimH7zlMCBdukLEDu846oZsD6HJVFSZPJzn3ubp1qN9NmflgCgqevSrLFqo7f7Q9+zpk5IBKTuGiE+nu4pG6NH4+TXAQB5kwIVzfZmtfxIUJeLttp1SjNihNBydWXgVjQHygCZEHMMIbvR7lIsQAz/gWUOhgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239246; c=relaxed/simple;
	bh=W+VZMioL3cyeN/iZzuHFELSbehOTVHCsB7I6ctk9ryY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z1fLid+hoM6wtr914gIMUN9JisznPQuAXtQy0gJv74Vvq+HzFPYOhFsiwmd/tCZ9SnYoz/ubhFH5xk3pJE6gtTRbZu1dL2J412FS6chE2RLoMrsGO9yrdmBiXYyg3cXEpqApELz1wKKFf+7TMNyy2CtKCV7oSpZHsk23CsXJtiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RJvILq70; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIUJVb010955
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GGhKWo06xdjZ1sk8lDnAZ11n0wQycBWzDYLA/JUlzxc=; b=RJvILq70UFY9u+hN
	ggNWmmvUT3e/O1/W+F+WiF1U/lUOkYNiU/jhnmi6L9piNdrov4I8Iw5yzGqJJkhX
	XnCDjmN2Hrw8vdMokbROXC1qTWAZ/tJnEZ70VtTzKTcabsJLhAULP2CV66jqxvlT
	scXp14OszAAckmaKfieWnFHRmTA9VgWKvkj35ak+2obRfebfv4f9+PKwoHzhkCU8
	gLRujYf1T1aBv6YY4WBcdVvFV3Rep4Qhg5xwKCzJU+gJ3QnrCW0JlLDzdvXJ7V/N
	4rbCHo13ot8MreZkT7cMh5eCoCTCLu4BLpWM5EQNxzEmgacpIhCW2S1XMkduK40G
	fd2+gQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxy0c7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so2667844a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239243; x=1758844043;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGhKWo06xdjZ1sk8lDnAZ11n0wQycBWzDYLA/JUlzxc=;
        b=fL36Z6R2fqh2e/QgeVRxC96k6FlLHtB6gpXPgwTrmeZDLR3BnQ/vmw3w0Ln1Jr4D3O
         jRLvP7F0H3P6CsanRb7UHQNts+3uGjZVuuQPP4W/DsiXcCWfvWQJVTuAd4f0MEKdD1Jd
         818S99HN0GkaaDl8xhWH1jEoxgt7HVu/O6Ab+EBHX7a9nd6H5gLIgamnB+XPZvseY0Tj
         iocyka3mMWWCUtxc5KfXXQn2XJoIixDi3AMrEM/uEonV1bI3RxwrAYvaBI/+hYUT34ly
         lSysakVfAUA+1AaW+ZdLcoEU3SGzg7+EWR1grxb0lTox4KzmxpnQoTble94Ll7hpGrpN
         4u9Q==
X-Forwarded-Encrypted: i=1; AJvYcCViQTuppvld85xLCxxssZTO/Ena/UdBRAeFo4hImn3mSfa6tZWBxQPpfGY40wRcggSsQJrmmwETxyAINcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzQeGF+Wi/lh4NeqH20wccDTZYv9yp+tmHumUX3RD/IebLQTm
	vt0qf8Qr+z5vAd84gVZ56AjSb+0aVjqbzCSF0zLftUmoBlLix0DCU9a77PXMqSbmCZrm+mrMWRn
	WFxkzQ16D8x5qZNi5hlxXuEVgBTxCsieAYrPL/GufdRssEO009PLADPCZywlaxZIDVM0=
X-Gm-Gg: ASbGncsssQsam5Za2IgZxF8+rvuhG/90UI4OJDbSFJGCP35TL1ULlqj6/RE8xUTslAe
	JUIEJkQI9wdFz7rklhz39Fn8+ulEPxmnnWZAzBGeTDBsGnaLGmqeHN+/XlKqCrEKVKRDTQ72W1M
	LbT4Na2WWlu14Dt1ZzkgPDWxIdUGoQ7YP/GKfVqI4Kuo+FgNbf9L12PhSFzdn83f6HDkm2XZ9X+
	I0SlC/7XtzYO2SLy3ykG+I35ZPj40JeLNDkivLY0WLue5iDRq/METvVIEOQdfOoyACMtgZoZJS8
	Yx/7PicWL2YU68hfRNwUEBennYXVuRCe6bBRHs5SyHD4qXaT8Xhl5CQggxGSH4E8jL+JkDzVYTO
	Z
X-Received: by 2002:a17:902:e806:b0:263:a2f7:60a0 with SMTP id d9443c01a7336-269ba54f32dmr18333045ad.48.1758239243523;
        Thu, 18 Sep 2025 16:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS5ESImz9azKWgPEaT6zJE0wYFMba62mGhYFWVz45LYnnJ/jvGx1WRG7NesaMARFfeVaFrmw==
X-Received: by 2002:a17:902:e806:b0:263:a2f7:60a0 with SMTP id d9443c01a7336-269ba54f32dmr18332805ad.48.1758239243126;
        Thu, 18 Sep 2025 16:47:23 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:22 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org
In-Reply-To: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
References: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/3] wifi: ath: downgrade logging level for CE
 buffer enqueue failure
Message-Id: <175823924196.3217488.6845685039081313219.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwGWamL891668
 gD1oB0nL9Kq9i64kxN6cPv8lKeumVa3QI1XmbDg9hm7rJDDz/1WXLAhDBc3ygec6hheuZBQhlj8
 gxFn6mLIXiRh6YAbv2oVCW+8p8tR4TYrcqZ3Zn7UVUk0pQueO4Ye6qyvGjgNs4vfddRnQs0jbY9
 ohl0EfVAq/Vt7j3hb9VHpCmOirWtcGvwcXzEJV3lE2V3Z82ykmLJv5PiNJleYIz7isgFnJE0j7k
 pU59SFOdc0Y6bI9fHPKvst6Pur65Tn8Jxps8RBqIXI6yoVLVnYZLktO0lo4jjSQER/VqEr/p0sy
 0nCCxQrJoWSwVILqlpcrv22FXoXLM6xzv0Vt6E2eMFqcFhaoOpi87hPuUa4iaK9ciWgQzVWQJDG
 k56bQnwu
X-Proofpoint-ORIG-GUID: pOav2TVYwQpVHhd98Q8TO4m00uKbNWJ4
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cc9a0c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TpeBPK0GJKfZ0rfD3RcA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: pOav2TVYwQpVHhd98Q8TO4m00uKbNWJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202


On Fri, 15 Aug 2025 09:44:55 +0800, Baochen Qiang wrote:
> The CE buffer enqueue failure won't cause any functional issue, downgrade
> logging level to avoid misleading.
> 
> Also fix an incorrect debug ID usage for CE.
> 
> 

Applied, thanks!

[1/3] wifi: ath11k: downgrade log level for CE buffer enqueue failure
      commit: 541a201e9f46c6633aa1a08df4ab17cc7c96bf89
[2/3] wifi: ath12k: fix wrong logging ID used for CE
      commit: 43746f13fec67f6f223d64cfe96c095c9b468e70
[3/3] wifi: ath12k: downgrade log level for CE buffer enqueue failure
      commit: 8873edecb38888726ce411b32de91b96cf41bbdb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


