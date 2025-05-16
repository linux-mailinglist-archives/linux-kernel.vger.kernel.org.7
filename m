Return-Path: <linux-kernel+bounces-651896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD466ABA43A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B311A541245
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3B280321;
	Fri, 16 May 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpsgOArL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E827FB18
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424434; cv=none; b=jc5iOwfNfiV9HxXEAObdwmb3grmg5YgaeUhppzZRvCyxUv9Ewl5LcEctpveqKcnsNBBThtW11EkuWdwoLtWWCkWNNqeqis4I+q7HxlM8mKwjeaFibu+8j2ga97UZY/Zc5WZZ3fkDa5kZMCFW7DbVWAyub58I7sQnw70r5HQQuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424434; c=relaxed/simple;
	bh=Dke5viz5DkYp7SAwu8Cf1opH5fNIs66Ce7w7D+pJw0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sbuhdPSWioibPaeNAs3KBuu6uIhBcTjExk3SdBNEZWuZVAcPsC9Q5SBoYggIh8CbM2uuzzRfhIv1hpgqXpo9K0WVzl4gADz+AzEvFvb8BfnCV7kUy7Vi7j/7KvDs5h1NWZTkyKs2cL5gSMd/4u/Ey94Wg7HZzS5Jo5GnnXmnuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpsgOArL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBuncY026134
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 19:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5G7ksd0wXjHCiCnsoecac/SagfBtut8BWKbVXx39nk4=; b=LpsgOArL4Lh2Kiok
	Pznd+NmIR5t0OhXFEhtzsRUOFmjpHtiPDE3whGT7OW4CwxUebgIqmnvDnSYtzfMY
	GbB8+jl0Chffpd81txe+KbFv1FG3bg/r1F0sxOgWJlK1ABCZ8fIU/bbtgEVAiGD4
	qh7YCqNJEVsufgpDJKUXzFi40agAo69W6ItEIjt1PYeOzn4o7PlsecHJyeT7I5md
	tWXhSlCLSOPDX+yhC02jZVhIL6BnvEWH7B2Zn0PTEbQayHgWEfX61/VM0dZ/muDe
	NsAfFfeLDAFFFBUQNXXqjXJkS0mB4JgHc8OhYhrpGr+jOEUmzlOG3sWKzdpOecfO
	3ya4dA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyu82g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 19:40:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af59547f55bso1463577a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 12:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424430; x=1748029230;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G7ksd0wXjHCiCnsoecac/SagfBtut8BWKbVXx39nk4=;
        b=ApQFiyAAdQD2rvCqDN9qHSDH7yK1P2YyKPp8sKhy4xOHmoRssIo7ThCnW5NGC6DnEH
         gol+d8jsoIXFEgToIDBMAynK1F5DLeQ5SyvoZ7eCB7h0vFJetg/FI1aXUl6QqYoCt3Ei
         +kG5auINjDff2yykTs32upYNZcqfYQUSvnCqlsEZCzLUsF8/PidR3oKBt3oBtt3FV84e
         naLvv3Wodg/PwbyWLRvH1yZ2dYiuRMzWemu1azOw7MxPEnCWeGd4EQOo8hoF/rMVRUsp
         hscW2Zw+LfjkBHHkGJIxtKHRTVQeFdhSzirknj5kIHsa/3nyg+AOJjbpsm2r/VPOnuQC
         ou6w==
X-Forwarded-Encrypted: i=1; AJvYcCVY7t3thJJCeJsHBw2EwK5RgyMpV7dL8pmefHXfjjgHAO0+lB763eCtFhi/ysrqed1lFkAZ6rX0epNVBE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUObiQ5rbvr59O8XnCkMS9Mmc/B7u6NAAk9SoqOs4avWZLdNbU
	zvCyAf7BTA1HlFo3Mg15tWkja/Q+Y2fRSwLguepRIofey4PE2p4jVB7tA5wG7ardaExxqAa/W3B
	xaLlN74RFtcyXYueWn+JKYTyAAl/Uu6Lp/Tb3h/sbvblwe5dcvgeBQA68TZkGCcMrCi4koGftqr
	o=
X-Gm-Gg: ASbGncv2PQor8XsqMXNI8t3cKMevmQ3Bq/faisEYWZLw6xgzQq/AkwfcSozEpSYq4Py
	MgMKlkhDj4dTVlXkRlfxZ0xXVZ+v5ifXwdz4RsxSMvLAZ6wR/59tmtau7SPsvPTtN8KvU8YaOkn
	cvm1XbyzQkxmnxa/hKOJ2x3iylPEvY4SqLpkiiQqBj1+x8mQUwtQpePlgIxmeylUeMdPdTFnZkr
	cR6FLSDvGJHmU9muni7KsjHxvCsVuFVltFR6Y/7H3fh8GsTtk1zh5JODxPWErtOLbhKM4thjguG
	Y736lZCl5P8XKwv+OyBTonDN5EOec2InVYMyesAEJd3jJ92H
X-Received: by 2002:a17:902:f54a:b0:231:b7a6:df1a with SMTP id d9443c01a7336-231de3ba25fmr45392925ad.50.1747424430261;
        Fri, 16 May 2025 12:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqVFV7Kgb6vfQ/FeDrtMUl3/8u4tdcjBCZnmJAEL8s50lZlgCge7RMn6WiFDEbR5w5NzOCcQ==
X-Received: by 2002:a17:902:f54a:b0:231:b7a6:df1a with SMTP id d9443c01a7336-231de3ba25fmr45392675ad.50.1747424429850;
        Fri, 16 May 2025 12:40:29 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm17955255ad.147.2025.05.16.12.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:40:29 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
Subject: Re: [PATCH ath-next 00/15] wifi: ath12k: add support for 6 GHz
 station for various modes : LPI, SP and VLP
Message-Id: <174742442913.3316767.4054734425093603053.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 12:40:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: oZBhXGJFQ166TTM8O_cTePF43kKxlVxl
X-Proofpoint-ORIG-GUID: oZBhXGJFQ166TTM8O_cTePF43kKxlVxl
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=682794af cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=kn8lAQMWUTpYvoNR6e0A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MyBTYWx0ZWRfX5pFXh16Pm+7I
 g421CLR/I+VJWnmAa2F2GjZ4k/phCdTko4cBXAtcIIE0zYByRz7APUKu8dJ12neU+q/hNRw+g9u
 cZNGLXG+o6v0M4OROBZ3HSiXBuQvZ41bYXCZtSRT/c/ELMIYccNd6Hahj/CId9FPRyaEJkzQsKu
 eHikO6DZK4jk75U4xY0CAp5244U0C3DP9yRpml6lwpxuw7BPv0ZtEXvqekqV0/D2zyXjQ9yndWq
 q9UO6rRc0CV+qReg0A+kFxjwFNm46Lhknr4OvsWGysSgoIIpeyobv19zHg9pO4yhVpvpNZlq5Gx
 tsaF5Bk1F62ydpqQCCx8aSX7lOiT/japlgQGwgNIRkxJorUHwUIGCYdrWAOAAIN6L43P0wLyR0u
 YYX7X0LG70NS/ItvR/34VKWw/lpxI4oIJeXcKjukg7KPL0qOrcy8gU89z32rGecTZj6Dilx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160193


On Fri, 18 Apr 2025 10:55:33 +0800, Baochen Qiang wrote:
> Currently for 6 GHz reg rules from WMI_REG_CHAN_LIST_CC_EXT_EVENTID event,
> host chooses low power indoor type rule regardless of interface type or AP's
> power type, which is not correct. This series change to choose proper rule
> based on interface type and AP's power type.
> 
> When connecting to a 6 GHz AP, currently host sends power settings to firmware
> over WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G commands.
> Actually there is a new command WMI_VDEV_SET_TPC_POWER_CMDID with which host
> can send more detailed parameter than with those two. So add support for this
> interface.
> 
> [...]

Applied, thanks!

[01/15] wifi: ath12k: fix a possible dead lock caused by ab->base_lock
        commit: ef115c265a21e3c11deee7f73bd1061775a7bf20
[02/15] wifi: ath12k: refactor ath12k_reg_chan_list_event()
        commit: 9e8e55c5832d4f905d7ca306f976669d523e9ff2
[03/15] wifi: ath12k: refactor ath12k_reg_build_regd()
        commit: c96bce15c568fdb8edd29b35aeb0f20c2524108c
[04/15] wifi: ath12k: add support to select 6 GHz regulatory type
        commit: fafa6ff0823b79bfe4d1950e7bd51bb1c6dd49cf
[05/15] wifi: ath12k: move reg info handling outside
        commit: 75639b743515537b6ee56bb89c857aaf8726713a
[06/15] wifi: ath12k: store reg info for later use
        commit: eaa027a1d83f87c83f0b4138ca2427875a21b446
[07/15] wifi: ath12k: determine interface mode in _op_add_interface()
        commit: ee2fc1f7347e8393b94d35a0d2b9d24920c9b24f
[08/15] wifi: ath12k: update regulatory rules when interface added
        commit: 4c546023d71a2b175ae7dd17b42efcd5a832a1ca
[09/15] wifi: ath12k: update regulatory rules when connection established
        commit: 7ed3e88664e328bb7cda5e71568b83426b3f3289
[10/15] wifi: ath12k: save power spectral density(PSD) of regulatory rule
        commit: d6b11d0ddadb9e7addd0f582f31ae8e6c256ba9d
[11/15] wifi: ath12k: add parse of transmit power envelope element
        commit: cccbb9d0dd6ab9e3353066217e9ab5b44bd761d3
[12/15] wifi: ath12k: save max transmit power in vdev start response event from firmware
        commit: b0501a0ee772222e3a7fa5c94eb7c6b16fe20610
[13/15] wifi: ath12k: fill parameters for vdev set TPC power WMI command
        commit: aeda163bb0c7b9fc58bdd6ae90c0eef4f4050b7b
[14/15] wifi: ath12k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
        commit: 9a9e8ea7f6d31351039343e9e3b1927c61a2ccc3
[15/15] wifi: ath12k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz
        commit: 29cb3d26d01c275ea652010cc62f324793e34a31

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


