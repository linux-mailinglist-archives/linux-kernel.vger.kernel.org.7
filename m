Return-Path: <linux-kernel+bounces-891454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C42C42B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FC03B1901
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853352F9DAE;
	Sat,  8 Nov 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNVVwsZy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqISzXK1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D12F7444
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762597109; cv=none; b=IljcRYeVo8B0+0ZzLlg579jKG1xa4lUnkv3YLC/oL+YmD4DCmn8o6gEa46kyoAaIg7I03rkEsMZm1h2aQpjx61n/IEgK0xSp5FHR8VZ2NDiWAVM7MRtPX1YpWeQMNH7CCuXQFRnwaYo3CZs2FnyJkliN9nNOkcEjoZqoI/mMmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762597109; c=relaxed/simple;
	bh=GBQ/LxB19DrzBHbYNkxm2cmpV5l9U85tqsXTNsQMMmA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q5bmK36zM1qOt1YIzVebFP3T3dDdCGqOHHgMNcmF1XH95LxfWgxXOJvCoaR5LxgckU0wQRzSrDsKa8pLFX1noGiROF3IO6BR8hyulxjMxTJIzlio601E20cPnrKzvaIaK9g0C5mMlLw8RToJtwioWukM9Ph7x6ZQvEfBoZXXrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QNVVwsZy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hqISzXK1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A88P4kf1150075
	for <linux-kernel@vger.kernel.org>; Sat, 8 Nov 2025 10:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OGC/TTYpV1+Z4G2ykrqX5yUAV67xQo1z+FOt72hlRZE=; b=QNVVwsZy+anuPf0S
	V6fy0UbSpryq/tT4f0Q5lbmdTPrxJytYzS8Pv1AhIkSu2lKBJC9GuD/bFEn/Q/+s
	suJQzYQofIK6JM23uBzvlcLXg7+RFvTmhS9aKKzA9yuHdLiIIzl7/etmQsim4iVy
	vXgqbCBct878n4jyvWlDiq3tz8xCVhz0AbS6a2yhPaJ57CbxqppPwZC8EJQDNelr
	sU/tGUgUdztjm0mtu9Ba25d9yOgfk8Ugs5F6Hrvr7Srt4aXGncd+sXTaRPeNWxhD
	37O7NuRpj8T/78CBNSYWkbr6EKrN0dtO2u8lAAxaaNr57tmOJAWTixKwlp31Vn0H
	JX9dpA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9y1h0chk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 10:18:27 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-79e43c51e6fso1314632b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 02:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762597107; x=1763201907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGC/TTYpV1+Z4G2ykrqX5yUAV67xQo1z+FOt72hlRZE=;
        b=hqISzXK1uoZ1lciIVvCuc2YxRbuqlett+N+fuuamPmBmM8wtMqfWEGHR805e1AljJX
         b0vlHwQMrbBHsi/PPG40eBTBCmFihv/xMPZd8UM/WwOniaV/htovb3ig/7jS5ocKD2bf
         BOYMq0VkLzvQD302qkXh+BazurkexQpvM7gKBybBpHnnSQxiH0mNkK0SP93Y87Ib2nSn
         RGqsVmex3kAC+xl0306PC+pR5zablZPR+3is9l6sk0otg06Kh8FSrgfnUl0jdP+XpLOb
         05QnB5Dmlsf1u7VOMqxj//FXlAXcOZ9XYz+BKUuzrawqA2mFiMuelKOO3y84flS2Baqu
         KBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762597107; x=1763201907;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGC/TTYpV1+Z4G2ykrqX5yUAV67xQo1z+FOt72hlRZE=;
        b=ZfatJCoeEaS2OEu9onmrGM8ED2lS+b3HfkmC6tbB8zZKTEMJIK55c0O73pz+oYDwYv
         3mEykwvQy6rDUsCLumMiBpaWZzRbwjBti3QAPm5MdRcwDG2h3F2q+L/EkrHqWyZzNMx7
         n6fp5uDh57N5Pe+HwY4uO+Re2p2s4ht4Vn3roPQQWAkzQgy3EBJh2nUs4jIpwWZPPn6F
         i//mRDlJRDKf5/1KwBWd82MJP8rmZUVnwKATMumCwh9JrfeFnluLHIoL25pgYO3/KA2h
         yakiyDH81OV7DCjsVDclwUrdmW2EUtusH4XUaKgYpOwNhUp4wbSiMcvqLIKy/HDRkkrw
         XeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBC8Yzf3/UVocTQGWCINeLfg1RgvPVgj9I/U9FUg84wIXUspAsDMIdYpXh7aTebDMm0O+YZjKU7BVEz1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQmXDEAxPfKxCpe1aUww1FDhLk7j9ALOOCZf8KqssSyVvVNQ/
	dCelGtbSXnsUQPv7pDVC008XiwH0w1ZBVFSE+YMHyuVlW17XMQ8hkRhUwXTrAK9vFnc0lXR1FAn
	5H3pvfNChJfUYQgHyTh7FrquiTdS5EdaXdFSIOL9fao6H0S3bmrh0Gih+yPspv5bUoUc=
X-Gm-Gg: ASbGncsYQjGFEZHCKZLSjlSfbUQFWK+BGivXPGiNf5cGR2B33OCm/OT1jeCw5S/C/ck
	L10TW707h6/arbAa+eMwf80YCwsP13YmryRRhYjn/3hgwq1A4stZqDB78HF6iGJwlnmd2jO0QGL
	TgST61xh8rArJ3F/dIU2VV9/aUZWtnvjiQ4ksLHcc1GF4rn3YSQ+KqDi8YqnpiBRlWpCQMkbrS4
	Xb3uvWd506mgiH3kVZHxntFbR4EmGBCUaBctBfkepjyKU/ypMX5GfLm0zHVYhbSxSxicHxznzDj
	uME90jUhgOMnOd7aYBAsTIRTtAH8C3mmr1AXfIa9fIp4J8K/8hWEngeiJzBbhyPtk4Q+wsfxsLW
	w
X-Received: by 2002:a05:6a00:91cf:b0:77f:9ab:f5 with SMTP id d2e1a72fcca58-7b14aaebb2amr4980330b3a.14.1762597106625;
        Sat, 08 Nov 2025 02:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYAGDn7oNGP43S1VSP2Uam7XVLMvwdXyPhG1Pnyl37aZgcRRZoZ2Ct7oXrIFzeFeOC2vpZ2w==
X-Received: by 2002:a05:6a00:91cf:b0:77f:9ab:f5 with SMTP id d2e1a72fcca58-7b14aaebb2amr4980315b3a.14.1762597106139;
        Sat, 08 Nov 2025 02:18:26 -0800 (PST)
Received: from [192.168.0.104] ([106.219.179.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc863a09sm5511813b3a.53.2025.11.08.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 02:18:25 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@riscstar.com
In-Reply-To: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: dwc: Warn if the MSI ctrl doesn't have an
 associated platform IRQ in DT
Message-Id: <176259710138.9726.16225246756188234387.b4-ty@kernel.org>
Date: Sat, 08 Nov 2025 15:48:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: oMoaMk9acF8fIhj4kouBGVUygMKAKI7G
X-Proofpoint-GUID: oMoaMk9acF8fIhj4kouBGVUygMKAKI7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA4MyBTYWx0ZWRfX1z6pHtICjwHW
 Mfz/QhDTiWiaZ7Se5fdosqnRHPie1N1UT5Riii40pNYjcuycD8UtqW1cPNZGABXSSO0H9MIuC0d
 h/Cf+lLNX3Ohml+/DRQAGARsy2+6lJL6HK+xfJ9m2xovh438HhjDmbPQRfe14iE2RiRUXl/lL6l
 tvyR+RBZkMOpIAL6/nh739e9aD7/f7Bkve98NNQNkyd1ClZWz3+QQHn+w0bJLPz4cYuVN6p4Ckf
 f18IXz8G/aKx4VAO/BvgHU2qGrOvqk2FC2QEcHMCSHbvF2l0p0QASsSLyfVje42njA3bQENDvuY
 Tk2Om7dg30DyxXYWOL4UKawq+cLqSgm6V22OuoGtsb+4d+QKY5NYu7WzccJojlzP+RrFcUCZxJq
 I9sQYwg5KKE927Iduz7RlwFzScg5yg==
X-Authority-Analysis: v=2.4 cv=Xuj3+FF9 c=1 sm=1 tr=0 ts=690f18f3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qronr9GGDLuyXDLutoyxMA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=OjHfIHeS4pxvzZ7QD-8A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511080083


On Thu, 30 Oct 2025 22:43:46 +0530, Manivannan Sadhasivam wrote:
> The internal MSI controller in DWC IPs supports multiple MSI ctrls, each
> capable of receiving 32 MSI vectors per ctrl. And each MSI ctrl requires a
> dedicated MSI platform IRQ in devicetree to function. Otherwise, MSIs won't
> be received from the endpoints.
> 
> Currently, dw_pcie_msi_host_init() only registers the IRQ handler if the
> MSI ctrl has the associated MSI platform IRQ in DT. But it doesn't warn if
> the IRQ is not available. This may cause developers/users to believe that
> the platform supports MSI vectors from all MSI ctrls, but it doesn't.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Warn if the MSI ctrl doesn't have an associated platform IRQ in DT
      commit: 571dd53fca80508de39cb2edc49a43be3ea5ae12

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


