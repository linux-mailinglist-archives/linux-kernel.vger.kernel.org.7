Return-Path: <linux-kernel+bounces-743113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403CCB0FAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03966188DA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7AB22FE0E;
	Wed, 23 Jul 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dY9FdImd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A47221FC8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297738; cv=none; b=qC0nJuqpXI0zNocWyGKxI7BzMoK6Fktj6ncZxeyXBxAJRfSiQLb1xuHCsx4O4g+uajLGAbkZ8FGv0hiTV3FTLRmSZRTJlvbqeBtc8qgxJbij7u/v0IADWJhsYPiCy5Ql341/aYeu+Ax5TJerEyxdqhnhfB0vbwBQwgoFUpILZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297738; c=relaxed/simple;
	bh=acgo5G7ZdqTzyYB04nooD5h9TSK7dGPPQPyvW67Wy/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itlDmIcaqYTo7V50IDwWj7tiaasOcii/iofY2I2JalJWgYZOlx+4OAaoFCC7xm/9h0xV3sLkzKAJvQjYuhTWRdot4/UZGNZ7DMFSqIPJlZYz5G3m0CrYlKdeFyJRfYW332fcX2KzmS3wz8c82zTflp0POPnOujdL0eN5ye/mfdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dY9FdImd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH8TAe016083
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mASOgsCi7NBq5T98FPC/x55U6eCvkphaYtG
	YjqMVya8=; b=dY9FdImdDR9/7eLvB5z/muueEDREJzyboWBxSOLntKGdkenKupL
	19gbBWE4IN96sEDEKmNnsOorRLY3yOZ+ScfhLcoIaJknbgmpeM6GhRtjl47DnT21
	0Pf8v6kEfnLz2upXp/AV9L84pvK+0z7fIakSAwmSpI4RrPdV7s/0xIpP3BIvNmdD
	bCGYaMDGJR+9X/p5PTONCcTrvic+qz0zipnngxozjzjntjyH/YAjujokB6OtqjNy
	8fiea5orKNWNkTp3mnlaJYDJBkiCe+Ev/Bzfuf0OLl4CeL0YkimmGhv88mHszUYQ
	aR7BOf9iBfUkoKvEd34q6MAiC+oZUcgcQ5g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vcn88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:08:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b0e0c573531so163187a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297735; x=1753902535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mASOgsCi7NBq5T98FPC/x55U6eCvkphaYtGYjqMVya8=;
        b=gFWRg/eThEmGvw6NRfN83+QAk+EOJxQ67B+1qwkdCVaAbWxJs068r+R7XloZ9+j9kY
         NbqDC5itJ4AprsUb0ktiRTMP5tNZrXqNeFUkKAdiKsLPRsOyJ6Nh33ywCY1VRNYGvd1f
         pOfBiKbab+nnwhxB1Z7mpLwHOnNnoe8dP2TlBOcsToPFVZwk1CdiN1Yi7rpcNxGlf8aE
         FA8FvdeAgXOpsCFbXlffOyK/GiVkWiho38m4hpPcH2H6qx7R8fYsYcsGZkf0yvtolPI1
         OxpxXAIk8aVV27uO3CFMpAZYoOPkBrUO/99Kr7d46EhOf8Rnhxc34FirpLR+dsBiXcIG
         nPpg==
X-Forwarded-Encrypted: i=1; AJvYcCWDrEfKqk9f0qzbMeC1YluZ7yUg9sc40m8K2TlOGTtwiSYo9b9p/I8bGY4NQ2lyliVAPJoQeNlSx3+TDhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhRLaKwTiiPBSi0dRTi06RCyJ5+VKGM+o3BVN4CTarxhnaCKaA
	FtrbV6odjkefX6Lk5c0BQTXClV6AlYtgWo3CNvTjBoAR6sdqZ9KQlt4uai88T0bsQZuLggiWOJD
	97xXUjulNbjKORsVwe06e8E4VlDce8+2+PkPU/PPQ3mOa56LfBapbCPjUHp6qra6KrqM=
X-Gm-Gg: ASbGncvdEG3FzwzpWqZ5sjndFf8VMV+e0+jr1lqYfWGrmCqcVFgBohrlyUJFXpeKzs7
	AUNofHI/LXH1OPjHu0GotYga+NrP6/99uNueMKl4gbBSSvIlTbFbKpZ00mt58DsLep99NRn7XMq
	tsuixkc+ntafthxyHxAq4JEMWoBqJoo+5REb8EqmgDaPZAGC8fVwKoNbz8IF/rzjokNqlodCEVJ
	Q7EFAqoxeJtsflagBjG7U+CGmNq7DINV6FgUw4K3lvM6PSn3PYJG72/GNpPxo3VadJkOyiTnb6y
	I+nuxLr6uObiub2ytGiHgR5BEUvVg32gZovXR4Vrk/jYkUXGCXo=
X-Received: by 2002:a17:903:1109:b0:235:c973:ba20 with SMTP id d9443c01a7336-23f9820283dmr69182765ad.49.1753297735439;
        Wed, 23 Jul 2025 12:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhVi/6gfyiJ69GTvshRkz/NQIrNp1El4Pbp2UDbBc4h/tVujCiVC1TqjgOnUvKlvGS+Ua0kA==
X-Received: by 2002:a17:903:1109:b0:235:c973:ba20 with SMTP id d9443c01a7336-23f9820283dmr69182405ad.49.1753297735019;
        Wed, 23 Jul 2025 12:08:55 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef9aesm101308975ad.211.2025.07.23.12.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:08:54 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/2] drm/msm: Error path fixes
Date: Wed, 23 Jul 2025 12:08:48 -0700
Message-ID: <20250723190852.18394-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BO4Dr5M7vjLKa3hflvKqgtA8_iWO3uHh
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=68813348 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=eljiBBwz-SQjAQrFlygA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2MiBTYWx0ZWRfXyAC7DE1IpaeN
 3+fC/h6M8CQKB7aH+IWNYsL/AnoqlaO1Kf1UbHcGJvl1MnrsgCtWvxqb4x7FP7kN2CI/B9n2vux
 d4SEtsZxWN8CX2o8aEEZXjNdtyMYfEjHvWSIOunFn8PRSVoPav6XOymQCvyl2wwCVPfjG1X7xYv
 AEmJwWcVS+5/2A0SjfWMWnmniLx5VcrUmW1iCkz3rxtnHaQRtLTtUi2yXTCgFmB88lAcY2ICk8h
 VQkYbVVRupaOCY4NjJ0bh5vBZf3L4tJuaVTKvhCmhcX1YUsjh+m+VegJl6JTgMzLt0EUVALpOCw
 Z24ckxk0KNOHAbNtmaj1c5bbPpTnh3pBETYG9vIAPC6rOI9C5jepJCsMb0+Als9Z13fd7p/QN4u
 Stf7H4lAm+sqEXYryu3S3EwgYztqA78THGpshh0nWpwho9AGxI6YkdhIomklApNWOmTcH0K/
X-Proofpoint-ORIG-GUID: BO4Dr5M7vjLKa3hflvKqgtA8_iWO3uHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=987
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230162

For reasons unknown to me, systemd-udev recently started limiting
max-files to 64k (at least in f42), which exposed some problematic
allocation related error paths.

Rob Clark (2):
  drm/msm: Fix refcnt underflow in error path
  drm/msm: Fix submit error path cleanup

 drivers/gpu/drm/msm/msm_gem.c        | 4 +++-
 drivers/gpu/drm/msm/msm_gem_submit.c | 9 +++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.50.1


