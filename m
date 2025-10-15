Return-Path: <linux-kernel+bounces-855375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB2FBE10B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F345519C2584
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141A3191C5;
	Wed, 15 Oct 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Geb+KiN0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAE0316903
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571630; cv=none; b=SW1I98GbAEOFKee+CSJSot9IMhsd4/g5A5OwoVTze+v2WD2PzSw6xdR8GSaRd1qXMeAANBBFVawudTTwf69rj9mGd+a1+79hvHSp22qMLyl6lE5N42NSLb+TxcaD/UfcdKRdktZuPVTVR1pURLcXxoL/yqIA3XP0Wo0D9iE2h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571630; c=relaxed/simple;
	bh=5G7ZhYyW1+yTfWAQLw2XStW9Ido9fwAuEy2K+h8cipQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YXJWX+o+4zqWkNPdXiDyV41y4Zg74EWNnr/HTJ2oIDqAnNREiUZv9sVYZz6L2XV6LoPl8gqqSUXQvGRTkpIaCldv+D9NB718dMKmxrjNgsIik8SC4wAIKD0OeIRsBTw/hNpnMTe33C3HEiCw/kWbrYF0Cb0+Wy13gvQeUvoDIzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Geb+KiN0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJkjK2016853
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DzB5aLxCajfa5GMSNAJ4Eb/AVG7nZr0Yfp5fuGdHQqY=; b=Geb+KiN0HfC4pTZe
	dijQRwAwJVpm03rYgKTG3OSCawsLWkWJQ1UVE1lI5Dx+QQLpql4ZTv0QHaXaGGE6
	UalX7FXNhbhkO5qb3DEMeWPDCQBrL4INRkZg77jeADO+DuHIpFUPPPA8uAtUc8id
	0OKGlvLK/Dp40sycl659edd5fkV/eyVb3ODi5VAQI6kCUivqCleHwlMwwPK/NPa9
	GPKPzk2dg6V3bl0xDd62DUcT10tiGfQO4gIb0QTLoXgWZOi7doYpY3jNxNpU52Z4
	wj6AaYUUGO1es//6spYPixPeoPyhPEfg1AsNaQyBLEyxlN3AORrHSjI6bXZNLz5X
	/QkBtg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrtb7gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:40:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909daa65f2so2264185ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571627; x=1761176427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzB5aLxCajfa5GMSNAJ4Eb/AVG7nZr0Yfp5fuGdHQqY=;
        b=Cs05HRAg1wHQjadgrLZPfmWCvyjS/eozNEzpBw3o83hEOt3BXwyNET0btWGMOQ9b4H
         6NonkFZlb1IfkVtC5AseCGUF0omZye/GVl7M3ulAX+EOdnE8xz/kqhcAvIEYIGArcHQu
         fMSsyw/p9cn+WvKqYPbmNN9rVuN35m5pExrmPridMn+5boYnmvFLKOPJAh79puYY4Clp
         FHk+2Quu7HYqKjvC06kn8oo78KiTpYcfTI8mIqddYQZbxm/M6UE8gsENC/7MkHQBmSJU
         En0e9Fv4hs46XWUcA8kl3oHtGaLlneosqoEb8tTS6LTYORFivcxPFuh6klEkT4c0nJZW
         JETg==
X-Forwarded-Encrypted: i=1; AJvYcCXPvF67XMkO13z+TH3ykPALi2ksdRcBRqQlZiqMTKc1G/3TujMG+CtFLSddFhSPGpsN+roinro3xKEFEgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybNpw3y5LTxcJwEr2eA89UFi4L/Z8YaqA4DqbGU2v/jEtfzt/e
	NZDHvYFjCp5/61tQnk+aE9hKbFOvsazL0ZvnEINfSf3IVZNhuenBjmgWGhBE+a1ujKog2N+2aTP
	brtZ3GY90YrVwEBWecJwaToFAaN4F/SEa1NVudFALQwGk7D10vWFfeBE4yjDEdr7kk0w=
X-Gm-Gg: ASbGnctpbncn2CgosxOEGZg35h3inXZzG9eucrrPnM6F3giLMfolSQeE5bPP5NHr5rx
	kOLtm2NTuq8UbQ9iQjVM4WEAopd60hTM6JAg/eYX4XrcS/zjj71SQd6w8ooPbleHDI1jg6jbtFN
	n6McZhcYb4aLdtyMqCDrzDxQqqpu7rNZGrESjo+KBL8Z8vWdP2kOKK/Dn/igf9NORKJWtbzAIMH
	V2P2moLkoB9SyVVShVb8nqo/wvi3cdxTIwLGKsRk8039oSwwxwtVgWSG6XN5zyt0O6mVkknXn6H
	d2YjTwhN4Kj3Dt/lVIY75hd+Omyzdfh4GGwIFThlkLUmAnUmOV3Te67MUWi5HfKPCCNNoV6TbQt
	R3k4A6ZtzvKOr1T9YwlE0NWBQCrR00HFESVE=
X-Received: by 2002:a17:902:f54b:b0:24b:1585:6350 with SMTP id d9443c01a7336-29091ae4cd0mr21934265ad.11.1760571626724;
        Wed, 15 Oct 2025 16:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGagydBD16UpR7uTmLN/2+yvKL0NUF0tG5fUuFZf+nep1BW3UPO/UuVky60XXWexQq6YEDFCA==
X-Received: by 2002:a17:902:f54b:b0:24b:1585:6350 with SMTP id d9443c01a7336-29091ae4cd0mr21934045ad.11.1760571626263;
        Wed, 15 Oct 2025 16:40:26 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251010-ath11k-nuke-wmi_bcn_send_from_host_cmd-v1-1-bfb5118d9018@oss.qualcomm.com>
References: <20251010-ath11k-nuke-wmi_bcn_send_from_host_cmd-v1-1-bfb5118d9018@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: Remove struct
 wmi_bcn_send_from_host_cmd
Message-Id: <176057162556.260563.9941291705002350620.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: adhN2SbPuJL1cMUdjA9gPy3nG7x0bKCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX3BXAWgJIXTCz
 zidHriDA0MzwdkM32yZ9odiI9iMZD2HNzndHTlKz1Hl2F6C5mVPX4UN7MHX2BgENm+cqY85DQJn
 r94GRBQ4HmBCGRTkPC965IPsRHvy/hsYpy9YS16WaLk0Osei1dn2xDNYHiZQi0fECUG9ObcEiX1
 vDDnb73GGX0WDETcfcxirPz8RRWHmeDjvN6HYJLUdYvI1ytQJREP8Nwmu7KyqFf3A1juzlqWii2
 w6LL+lQGkJlRQUHElktptngIVlEQfk18Zg0NpRjS9CwX2kXC4DSAnOply5xYaQAEHeufP+fuvnp
 cSWJVd5cHMsEmJtKjUhpjTFdOF0Y5jhfWzO6Y7ADN2UzaXMFIGbuhiRYZhqnWYY0Qyh8rKJahK0
 W0UxL5wh1MIsivqcfVsn3UKOy46Aew==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f030ec cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=skVgQ6i2UJWBhP5xJtIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: adhN2SbPuJL1cMUdjA9gPy3nG7x0bKCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022


On Fri, 10 Oct 2025 09:46:27 -0700, Jeff Johnson wrote:
> struct wmi_bcn_send_from_host_cmd is unused, so remove it.
> 
> Compile tested only.
> 
> 

Applied, thanks!

[1/1] wifi: ath11k: Remove struct wmi_bcn_send_from_host_cmd
      commit: 960fc268a9fc269190014773c81507e695bec3d4

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


