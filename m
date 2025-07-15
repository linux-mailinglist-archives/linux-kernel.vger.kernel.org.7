Return-Path: <linux-kernel+bounces-732267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B201B0644A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68E7501769
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24079280337;
	Tue, 15 Jul 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OxC6Der0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE927B4F7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596653; cv=none; b=HcOa7UeJH/tGnXyCVnJbQFTukrWSh66yect389rOwJS1Gu89/5KC8Rf9M4Sw25J+Bkzhiv9NjYMW63VrrxlIoHnqdmH2uTTVKFS6ISQPEph580X4CaX4/RPb5StpYOVjhAApNAlXm0T8uFAO48DuCHxuaZpsq7dvNLhl7BBcqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596653; c=relaxed/simple;
	bh=3BRrrCD1sfNXTBrrgpO73lYmUnWtjUBqxWg1ohTTyJk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LjKoKdSB9GcVAiU6s8KD6qlVn85R/YYMZ1PlOtiRK87VQfeofkNEkltfDEbWq9W1FAKMdhTfvJTA5nb/6ND2W7IabpMqPbelyUUUWQZMXb7pzB/AlzYCOz5rL4NRNkWaCxqY/dtWDXJLzBMwOeH8+Qr9u2IS+NmLqQfPLkFbNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OxC6Der0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDKEH023068
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e4fSFHObIUj3YUKeRKs7ynYBdg6+3bGvb9S+7Q7qNEM=; b=OxC6Der0QTFQA2E0
	hDU5SdcIHXWjz9J1IxwPR7cozgiyTrxVc4MPBN1oW5QISypXZYhOWUK0jTDDE7ZE
	L+FxSkEkdcxQBb2CPcXnpy1U/xceVqh/+u0O1HEqKE+Y2vduPZ0fovxoQBJDP//y
	BCozYSDumwSnKMG6QpUXQWh2U9FZHrewSwye4l6hRw9/6YlcH8dw/S1OUXqEErE/
	Fe4fnc2IXChxEkOrWsDQ0caN8FW8k/aws4WZ4v5YZmrM+GrzC5I35M/8kGfcSnk5
	vgTqhHA11xychrQ5sWJvCiodSiE+k/FlRuFQ5EocKaPatUki/qOYvRGIvoIBoPkQ
	jnsKfw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkruhjrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:24:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74ea5d9982cso4492933b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752596650; x=1753201450;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4fSFHObIUj3YUKeRKs7ynYBdg6+3bGvb9S+7Q7qNEM=;
        b=rEwN6fHNY0xOzsoQZEtBYAl9+TzdjHJF6CnisaO/luqDV4zK/eO6ghD3Zh4eG+VtIB
         9qukVA+ZLMdlfo+eH3ZnjmzcNt294MUsEf1H8pek1QLEJG4qDAj+9Z1KMdA+M6+u+z6U
         tqKPrSASnS8r12/MR9ZAnEvw7s79uM2FdDNEcT5Hg194xWYfqzIPLFfvt37LLI0pL+qU
         vlwGsBo0cpUDBGyKnoBYqq5H4arnSB7UY4t2vveeGvH7ehmvU4JgdhC3lwhB1nZvdg5M
         WgrZZdE6dlN9RO8WQkmpxj61DU+Y26wsQhghR4AUIrCvjxMBxkvW310kykkGCgklxt8y
         k2QA==
X-Forwarded-Encrypted: i=1; AJvYcCUf51BNN7uPoJUksU3LGi6QuIkbZfP+lykVRMU3Le1C+53xrrCRg9laTcNomv1WZn3eQSU+MYhHaVNpM4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaF47wMUsuh98JF5b5uc4jLwD02WwccJvRJRRuHPmF7+DTwM6y
	JkficHnR2eVwdftLlfX7dP32iRZSMGQq4OPQGxXm+UZPhnnCLxrnABx8nVrMiTFwMrEn/Ty5eqH
	Bihhe22+rO6yVlA03YaYItI1+3CjX0pIVAfoI4Zg1cjISmcVf0FgH7YlgrCLy7Wo/Gas=
X-Gm-Gg: ASbGncteoZsmZMzgxBP8hySScZWuOu441NmzatlPn3iA4GJhuU9hb4LngkK0DvPzh7M
	3p6aosc8j/vB9c6oP1ovs6OEwBWlLbCLwwPlJvgIDjWc/8GRyQMYLxM1VlogxfARll9dD567yTM
	kgwVKpe1xBfynXvHadyQIjai31z/2U/CZe1a4TMBtCr3La+qHT2Sw5Wv71nkWLZZlYdTgkcmpI3
	+Ynwnf4a03aVUdy329M2YiU+wx/DTPMyZ/DFD6sDoNfuiVYkdmYAz9B+NWyn/0sLyIGw2B005o3
	BcQxuOfmCaKaj+FUqujyn9mafSrj2ixfhcYOayWDbnzHBza5WqmURiWhu9tLTpq3PaRZKrTp0oA
	y
X-Received: by 2002:a05:6a00:b90:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-74ee2c51089mr27047190b3a.11.1752596650259;
        Tue, 15 Jul 2025 09:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEODAHKCVBUNHeifRvUwFCvNewJnsVyb7ieobPeB9FXo2Bsu8LjYS3fLHbakYwxdlvD59V3fA==
X-Received: by 2002:a05:6a00:b90:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-74ee2c51089mr27047153b3a.11.1752596649673;
        Tue, 15 Jul 2025 09:24:09 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b715sm12815373b3a.93.2025.07.15.09.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:24:08 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jiri Slaby <jirislaby@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250715121721.266713-3-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
 <20250715121721.266713-3-rongqianfeng@vivo.com>
Subject: Re: [PATCH v2 2/7] wifi: ath5k: Use max() to improve code
Message-Id: <175259664810.3448282.1721666863713781747.b4-ty@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 09:24:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 7Toj2t6rcGHvWR4C4BOcyB_11RzZFs9H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1MCBTYWx0ZWRfX/GBpr39wbR/P
 GNQkz9JBc5cL12T9GnTtcGPvXlzPs1oJYXmudmrE4KBGqYvfmkGP6uW3g8hE1UhiybiJsC18S7k
 8zVQ0/mOaGWa5th9JrcP3x1OXfR8C6PSDNy7BGUqk3T77CT2zReDSX51UPiPVPgpXxBeLYnwGDb
 QDBNw6LhksOOcsTdZg4gYpOJ15v6fRxoOqcK8yPNronh5BSqj1xm9NMJ+E+aXirBkRcpAirsz+3
 /UP3dVe5NcXzoTv/d+RpuD+KO6sACWd0cKGAYtTb23m/Ju42mSoa5UDnyoXYTcNMCkz5hD5V2vh
 eMrCoGduUUA815yaLn2z7Ikxb60QHurBeC13vKuHLm19OPXsop5zSD2ycbWYRo1lle8h0OnGWLu
 FA5ND4/TKORVrzXccQSSjqwXoBYlXdhuclsgyWajtp7i7BP9DxMHMxsE3NqI01UXOyytG0Cd
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=687680ab cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 7Toj2t6rcGHvWR4C4BOcyB_11RzZFs9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=836 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150150


On Tue, 15 Jul 2025 20:16:48 +0800, Qianfeng Rong wrote:
> Use max() to reduce the code and improve its readability.
> 
> 

Applied, thanks!

[2/7] wifi: ath5k: Use max() to improve code
      commit: 5dceb7dc745c755d61e01ae4d214a800025044fd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


