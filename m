Return-Path: <linux-kernel+bounces-722662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E1DAFDD7D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4BC1AA61D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE81BD9CE;
	Wed,  9 Jul 2025 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HgPaaBgN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88918BF8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028538; cv=none; b=bRn8XFLvJnokkN8ZCn36ceSaTzhfNRnNke6Si/LxcaE91OohKoabDu/T/BM7eLpiEMkleSCKjFLOCx6J3Kf3TsD0g1NxcKP7ePz3Y697pMvHochJjnmggqIV22FzGRwSu6A0ajLUWa0t7iGGV7NgdolpP7e9s24+MbgyU5veBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028538; c=relaxed/simple;
	bh=9TO0Ie/tiu0fshmmifYBLUQYkYOY5QIWQq2+zPaxfDU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nKuw/N4lk/UpsvOs/ve1/Rjw3Csf6urFLGQeHXTgvUdSldI/myuyov/kq62a9lR6vR5N/XSnKTrfTn2Rs/0iQuJ9c9xRrA4+u3ppWajv/NiUnArXHPGs+xcDrhyt6f6ncuBf1N5Rxa7Robw9Te/XzRZ+lRE2ShRBCdlSWLdUltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HgPaaBgN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Mwugl018551
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 02:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hLMsEUe26f5H9JEFiKOUnL
	PAORFVeXyz8x7J6XwjUvk=; b=HgPaaBgN1Q3w9fvb/kbMyfgbY1iCkkHoeroPED
	UVvPc+OigvogN1u5+170fcUsfxLXNQzL9hQWG9U9DqaOwbYFc6BKFEBckhwNVgns
	dSLTvrKPNG/rMcuhbuOi18/i21akVMvxEMfXgpdlhuwgQmzMyhgb/MQ1MjOOMHZ9
	C1fhwmNnvzYOv26bPabt9+iZwP0HeRkAfQKkniLm9rFpnRYt+HjxjICdg5AfNCTd
	p/kOndhWygl82cCmYas4qfjDZaJVugchWOki++9Mv3Z/9YGAmVEsRdQKkNg+HoUu
	iMAK/nx+yVrvIqPmkqCjL5QhRyLTGn1YGdJQ9/0V0X2E8JUg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdr301s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:35:29 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso7084931a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 19:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752028528; x=1752633328;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLMsEUe26f5H9JEFiKOUnLPAORFVeXyz8x7J6XwjUvk=;
        b=VwDH9P/lZkmj0JYamKPoEyjGmlVk6fzq2pyhfnQMz5xo6Fp2VYc19ZMjblH3Qmwk5t
         dPRM6lEe2B3HqY8sHIJZIh948GxmwWwE29Lc5LAGphT1mS3vH1QWkeIXgXy+YweZah+O
         FyXAhK0Wq6cqws1vQYu1GdOF1xuU5+JZ2jvOtPcN+XnlOGnCiLWKsi/qWF3AHOQCUUeM
         ILyC/6YEAUrWMLf9KvZLuaV6ea0apMEaTMhuCYdmma+kY1+ev1Yvd4po5c08fnYSqmq1
         h27YrzQSDbZq88VMX8G1Tmbouugb5iv2KIGwPW1A1d9qUOneQccRxPbQLhUQU+TzTykZ
         m/DA==
X-Forwarded-Encrypted: i=1; AJvYcCV8F4u8owemJ0YKGoOZD5ynklh0853Xbakd0WF0TT3QYwwJyhGvB98GmtjghkeH+pa5Z6SCFiHpGO7sWTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4yFohcFD3bfGrnmpmvHJwJJLuV3l3tuEZ/6JIZM6AnSni2RT
	urLyun46VS7iHrTh/hFNKQtkMPnqq/59JO/wDjxzWc6tTn/6Ch/QN1a/6vPp8ae6E/IAPPQfE+3
	uWLEt2dQEHBJBcxVQqWAFirtcVNxA1eQoVxpXaDmFR6kG1zG+GG+9OayYlvBhvf6XKPk=
X-Gm-Gg: ASbGncuGxUosqaMOyGW3J5Fb/GFIFk+dStBc9cB8deU+K1OqtLsJxpbLKuhvJ+dAp2x
	E/EopyobEeQupONywez4q2uzBLXhQSE86tpYyfephSkD+YIeBB0n31v7//lNYHl1s80x6b5X4Ze
	hGtucXKzZUK0ZqO6L6iKPBDmWCzik9tIzOaAIo6wmx6CY/13T+jR5pHicdBOkW2kmLY5R9XuEbN
	YFBRpieceJKGmxnLbtBjoANfhM8qR5fT9I20vNzqrvpipS0PvomOzLed/e2VZIUTYPFGgwWu7AX
	fR+45ZXfrwBgeHTLOwAX3J9rcNUgCB3Aktj3X5Tv8yF2tuKcxj+OAbRzd862gagvMR1SfAihT7v
	gWa+Dw/vI1J4jvV+geshk/G/YH2xI+Gt+wTgZINksv8sYz6I=
X-Received: by 2002:a17:903:3d05:b0:235:a9b:21e0 with SMTP id d9443c01a7336-23ddb0c8821mr11858375ad.0.1752028528593;
        Tue, 08 Jul 2025 19:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhfR0QvmpiQ/tYvfymKWBtnaEA+zKZVZAoyoIq4XGfZxPY3DboSNdAbywwp4KVgp1XVSKJvw==
X-Received: by 2002:a17:903:3d05:b0:235:a9b:21e0 with SMTP id d9443c01a7336-23ddb0c8821mr11858105ad.0.1752028528181;
        Tue, 08 Jul 2025 19:35:28 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431ef2bsm133169315ad.33.2025.07.08.19.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:35:27 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next 0/2] wifi: cfg80211/mac80211: parse and
 update unsolicited probe response template
Date: Wed, 09 Jul 2025 08:05:17 +0530
Message-Id: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXVbWgC/4XNSwrCMBCA4atI1kbyrMGV9xApSTpqoDY109aK9
 O7G4sKF0s3AMMP3PwlCCoBkt3qSBEPAEJu88PWK+IttzkBDlXcimNCs4IL2bWU7KPsGY106b7E
 r2xQdlAmwpd6YrSnA6UIxko02wSmMs38g95CgBkTawNiRYz5fAnYxPeb6wOenT8gshAZOGXXgK
 1BcMGf1PiJubr2tfbxeN3nMgUF8oYItoSKj0hunTsAqo9UfVH6hchGVb1Qr5Yz03jD+A52m6QU
 rrCgeigEAAA==
X-Change-ID: 20250612-update_unsol_bcast_probe_resp-c88786eb5640
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686dd571 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=oCrXEwr5G_U2PBqafwoA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: B7JQE_tpbUe7tgZ75Vodc1uONh03OAA4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAyMyBTYWx0ZWRfX1FoOstG/emUa
 jB4amnQAY6OapVzyOdFJMdTwFoA3cpAv7p8HxnN23vZkFQg+RTJGocV1mKcRoT2NyI9O4F3eNL4
 +W5CXfObHjZ2SajBOtRNMelrsWDpjNhh5VHnmY6Bk22KKZYZhXBejaIvvUd2cmjsAIvAMz0hPMP
 OjJS9H00gOCFI9sv70XKyMeE69yn3k5hU8UQui0M/1gRkpLdlHbEocDIwZNIg81huCbJfBKsfu6
 e8qHDJPftdHsXbNpeYR0UBZ4SCRFQQbqaEk108TU8Q/it53b2LatbKwvZMvzKKt72Bl4DAEF5IN
 sbs2L6VW9cO4kBm/83z5iuZSsQnA7v3e5z8rM4vKtIoq6los8MTRgDKft0FlSgbztR41N2tTqMT
 KBvDQvoS+d+Re6p4LvOB3nnTRS+8ToipnsdVptliGhIw9H9FSLD4NEjEFGoEjM17yvRRxO77
X-Proofpoint-GUID: B7JQE_tpbUe7tgZ75Vodc1uONh03OAA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090023

Currently, during channel switch and color change events, the unsolicited
probe response templates are not updated accordingly.

This patch series introduces support for parsing the updated templates from
these events and setting the appropriate BSS changed flag, enabling drivers
to respond with the necessary actions.

---
Yuvarani V (2):
      wifi: cfg80211: parse attribute to update unsolicited probe response template
      wifi: mac80211: parse unsolicited broadcast probe response data

 include/net/cfg80211.h |  4 ++++
 net/mac80211/cfg.c     | 12 ++++++++++++
 net/wireless/nl80211.c | 17 +++++++++++++++++
 3 files changed, 33 insertions(+)
---
base-commit: cc2b722132893164bcb3cee4f08ed056e126eb6c
change-id: 20250612-update_unsol_bcast_probe_resp-c88786eb5640


