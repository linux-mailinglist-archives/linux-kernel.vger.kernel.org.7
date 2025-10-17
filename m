Return-Path: <linux-kernel+bounces-857222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF57BE63E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A79954E3CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE3C1643B;
	Fri, 17 Oct 2025 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldBnPG3J"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C721758B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760673774; cv=none; b=fpoQntwwcZuQAe35yphMpaq+Szi3rjeQBzbmzz0vrvMoz/oTuf4dmv9RS3AFgcioCrs2y6EQbOE6kWzc1+PEikClIVgQX0bb+yYDDXWWPF9DE0xXesOl1XANjP5nzQmZNvL+TgIFOr0aRRU5f/WnA4lfYnte19P3olLrBUTUDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760673774; c=relaxed/simple;
	bh=qUCmlwco6LFpliHjmSkYBfxdHOHZ4wY/18jEY+blLK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mWjvq2t2aNkAHUAAu4SiEauSWRojZy13qTOOjspGavgKH7uTxi/4La0I6buvcYWrYWefJOr2GhPlAnZKNTMpvsdGRyb7YOM8qS9f8qkgYxXSykELB1ujn7sHdAsn0ykMNwAuufqX3vF8/X5ia+DJOd8E8Ov04Q/cWwijK7/ldvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldBnPG3J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLQ39001982
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LKJtqBqwFHaUM04CXOGGfS
	lfueOj3jTdPSGv9RKvqHk=; b=ldBnPG3JmKmhyYaYWNmI6iFjjQ57W5cZ3F/+X1
	2S2PV0oEphsf5Ouy35XIFFHEwtna38+RHjmbOaaW5FHgZYane28JeX+fnjRyacJb
	DvHzwIof+aL9tkFLS2U3QBWEDsOVz9o7sRO17aadyun3jiUNGedRNIziCbtRIb9R
	D1U2kfaQNuvQq12r9ELwjpi8q4hB8n6ptJtAsD+868u4jRC90uyTZ5O7uWf8C2+B
	lX6MuXkcPmrGqmd9sLKfCqCd/9Ab1SNwPE7MiKycKeFlgbJeqJBZjY+cmw9vmq2T
	RTKh89LDztcvbwjLxSIp1Rx8l4b0LXU/yuJwVPqsTyqPk2ug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8jssd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:02:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290992f9693so16453965ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760673771; x=1761278571;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKJtqBqwFHaUM04CXOGGfSlfueOj3jTdPSGv9RKvqHk=;
        b=D7fjVg0KZeUe6q5VGUdA/yvGL1i9i6XsQRN4XBM02Z2vjW8SVoS3a02O2kRaFnLU+b
         b4ca4Dw12vhONJgLj9s/ZYgVRquhkCbUO5D0FeQeeXwlASbiQHOz6Dh+5Si0E744vJnB
         2qz8TBAdidpsqzyUiVe65ucwuvBFgYOmYKU+JwopCdpdfIHqnnNsyo9Whr7yfu2q5zq+
         wv1cXoXansudR03uuYI63kmZUxbLlWBhaJl4UiEEHtzrxXRqk7hUEfR/XJFWJwyeKVen
         17N4RpFAANyzdPim1osBFjuq70Ynir0qE7b8808P7+lCRXWeH5F1wTDUOZE4dAD5hFyy
         zZpA==
X-Forwarded-Encrypted: i=1; AJvYcCXgE1/RJcia44F3lajfx4no092IGIh3EzzVYMT0NuDIzPcIw3WPxZxaM7McFx0GYyrq7n8seGLpdHgVyDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYoVlAlulwNjNj85qTmC11VKA56WecGwVzjlbnYoXVy/9hSGh
	oVZx/BzCTCPElnZjYA9t3BsdtCNpszpzc1PaF0ku46Z06MKRycvzgkifljhmHERtW8L+CuCeEh2
	3IRvF4PRo7hdhUi1Jcl7ym4ImDlwdwyFrW00UGFBGaMdg6vcMshrVU9OFKjVa4bnILHU=
X-Gm-Gg: ASbGncsH3QPmQII363kRd/k8Lfb3g/o1ga0LqTjFlUEgmIbdEMuDJXHmsvL9Rxtb+hw
	N8X3jHNnfeTConHArQeee0Bh04w0HnHHStMVEtLbqZAEuzdeLlX5v+JzjhfL7IMIWKVgfm9BP6B
	42XLoMLSzgLWNWDMBu+DGJXw/AiM9FHbSD/pTduz9W597dMVKB7yqIR7vbG5di7HtU7feKutamb
	pE9ZJGZgFBmMUn3Xai79JMfI19lhn8VFRsksFpZW0zwXeV9v2T/6/rWVJU4MV0iaKu4iJG88wiJ
	Xq3yyikW5YFZ8F3ourXIW5Uz/iofE1HISDb8oDiTJwCDIsPXDtNA9zMDPP+zDTIfqpUxSToO2KT
	daDBHuXGdowixtFT12eCVCH8WVvsts9htStiZNmXodNVnjw8T+Jh/8IlhyFHcKMnFhhjCqmFzj2
	0LOQe8ZGhysn9dk/08xCh+xkY=
X-Received: by 2002:a17:902:f64b:b0:262:f975:fcba with SMTP id d9443c01a7336-290c68e2eeemr27479815ad.9.1760673770658;
        Thu, 16 Oct 2025 21:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKeQFKsAlvfnZHtq+UbKKvYnVqLQ2FEk0e0bHP8Q5+fYl9zuFzCeIZealt28y4nptUhJMBKA==
X-Received: by 2002:a17:902:f64b:b0:262:f975:fcba with SMTP id d9443c01a7336-290c68e2eeemr27479525ad.9.1760673770219;
        Thu, 16 Oct 2025 21:02:50 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934a8e6sm47682595ad.30.2025.10.16.21.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:02:49 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:32:41 +0530
Subject: [PATCH wireless-next] wifi: mac80211_hwsim: advertise puncturing
 feature support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-hwsim_set_punct_feature_bit-v1-1-3be1bb3450c0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOC/8WgC/42NWwqDMBBFt1Lmu5EkVjD96j6KhMSOdcBXM/FRx
 L03uIL+XDjcy7k7MAZChvtlh4ALMY1DAnW9QN264Y2CXolBS10oKY1oV6beMkY7zUMdbYMuzgG
 tpyiMNsbdfC59qSEZpoANbaf9CSsF7JBZDLhFqFLdEscxfM/vRZ2jv24WJZSolcx9YZzXZf4Ym
 bPP7Lp67PssBVTHcfwArrQ6RNwAAAA=
X-Change-ID: 20251009-hwsim_set_punct_feature_bit-9299a4b30b82
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 35MdbQccN9H7u4VyEELvuvhbX9HYkh6U
X-Proofpoint-ORIG-GUID: 35MdbQccN9H7u4VyEELvuvhbX9HYkh6U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX5v6cBu7+bjEL
 YVClCtf51vD8zIbHIHbvTXVGntI1OT5kYa2SndLlbDGD7iRquF70kOLY7cfizVBo8zT2unkzwnv
 enp8S4KsRxW0baIbXEsA/uquc/b+u6KdvdmUY+bgHdtGJUhDy0C72UdQmdJpqHIMalx9+VM1K4v
 Ept9wMDy1lva+Ey/DJNCves6+kmpqpxyxuTxKeSpjHerpyTlsKlYJ5H6AN5iulwviJH/OsGAJ4A
 7DQsJBATLms1ls4sgt44VubI50flgEbxUQFa+pH087tEhFNKFrYaTfNFrQ7TobCU3+ArD/bTotr
 t5pqhLQfPstnqg8MXgaihNpvyaO0ISQHQowMt0Of19hX+8R+Z26LEOpmYzLbNJGosxSlZEs+ENR
 RyNHwwqANIOrrQe9NDTs+T12cLz+lQ==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f1bfec cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6mnrFCliqZ2cnhrunzQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

If userspace provides a puncturing bitmap via the NL80211_ATTR_PUNCT_BITMAP
attribute, the kernel with mac80211_hwsim driver currently rejects the
command with the error: "driver doesn't support puncturing", because the
driver does not advertise support for this feature.

At present, the following hwsim test cases utilize puncturing, but the
bitmap is not sent to the kernel. Instead, the puncturing information is
conveyed only through the beacon data:
 * eht_5ghz_80mhz_puncturing_override_1
 * eht_5ghz_80mhz_puncturing_override_2
 * eht_5ghz_80mhz_puncturing_override_3

A future change in hostapd will begin configuring the puncturing bitmap
explicitly, which will cause these test cases to fail unless the driver
advertises support.

To address this, update mac80211_hwsim driver to advertise puncturing
feature support.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 9f856042a67a..cd84dfd5b47e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5793,6 +5793,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
 
 	for (i = 0; i < ARRAY_SIZE(data->link_data); i++) {
 		hrtimer_setup(&data->link_data[i].beacon_timer, mac80211_hwsim_beacon,

---
base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783
change-id: 20251009-hwsim_set_punct_feature_bit-9299a4b30b82


