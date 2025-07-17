Return-Path: <linux-kernel+bounces-735323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5ACB08DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEBB1C2743B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757E2D9EEA;
	Thu, 17 Jul 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0gkORGL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528942D9ED5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757267; cv=none; b=MQaBr084CE2a6ilrwJv9DxAdQk3MKfQllI4/T0QmXVnC6exIn/y/p8reSsl1lZmVHljqfKgmJ0a+rgeqxuZ5t4OTpMgNSY6L9WujiLZ76Y9Nv5Jo2ZcA1uVw+WbP8x4FuO+9MUdME9YYqi1h8SLF2UwuvEl0MOVbQ9XxyBUZKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757267; c=relaxed/simple;
	bh=6sH3eDRC6+5CeRl8Mp2RLafDJprCk7PzL5BrNhgsMqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HZKRApz6MsAY05Jai6i+i/+sRDu2Etk815Lzsqr9qGSfyEMwI8ifpFNMLrqHR5JxaKwJh9Zu6i7EXbywFDLJopn0d+BLyECRl71k9mJrdNgigChT1SH5Z4op8D73Dd7LHRDWO9ANmX4SU1GDGCf6pL+TXmaNxQx4iVH0MVeZU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z0gkORGL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCWA6o022401
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U5UsuIaBIiPbuClHMuH4cTONIIq7r/pcY/6hVNc8gVo=; b=Z0gkORGLevPzWXlm
	vcy3MIRItHtOk71vKmNrXRumAl2/eU0FPxW4Q70JinG1rPuhQzS8hRL8b0IBZPXs
	INiXELfRkdR1z4+/7nRiH1PI8S/aW7dVdQp3FEGUZkd4DveCbrRFmt957pUXk6Q3
	/NjoY+3BEi3mNWfgDnlzmWtNHTYqlcMaGgO/HMEex9Or4Lo3HxNv2sGixEBpPJ1q
	ZY5VMfc1PJzzQZP1ZZURt4ZiPoFrkhDwu/yy2qH21rXgmR2ef7GA/hn5eYZjSOaD
	mBWGzXrklE6KIJ5vYT4cyEu2bLguPYfU8SZcx3tipCvvblS9AO5o/eWHpg6VqsJd
	fLkrvQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy7mmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:01:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23638e1605dso8067025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757264; x=1753362064;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5UsuIaBIiPbuClHMuH4cTONIIq7r/pcY/6hVNc8gVo=;
        b=KdcbMJaWV0piJBS18jC905AszXwTK/jUXlDzl1pfV4BhDMOzbv4vUGupZcBJ9PYHq/
         ofvTUD3ZtK8qiz7VrbVxsVZE05pQWxjv/jm3dOMnACiJcu846w5TBVp4Kg73zCrOE//b
         zOcwc1gm9EfQDKH7J7JMUHvQtJWjof3xhSM638MKiTn2oaQMW/pwZfcGNQ4PFzUo5lQ9
         iLIpufOsZO+CVMcB/r4CSw3miHd3eaD2ROHgfw1NnUb3D8fa0A5VZ6OmUahmOj9h9QMy
         1/Z8yEfojoaqCYU56rd6TUJEJ7Q9bgdLaPGbsicqwEf8ZFOWhud3bX/RXXnsv/a54Myc
         4sZQ==
X-Forwarded-Encrypted: i=1; AJvYcCURESSnUjxVO80HoZE1MHqBStoyx8tl4CUV2EPe7x7DWaMcPj/0BiJ0f2fRK3YCuvNQqfVCpyiQIW0X0vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoAfaHKlm0UTt5xVnUpP4NRMPAKt/Sf3NpzH9Ffuhg09lxFn5X
	zXdoQWh0s2daGnKpUiOT47x71PCA3J2RgLBqumc/aH0EmC//eOw5QR0Zi0a5pMhqXCvjwjsjaYd
	LwyIuPQif0VD1KC89sdn8hy84nJik/+LduvJB6ZQwn+xi/S3WN1fSCGiNDmpr2/FeyN8=
X-Gm-Gg: ASbGncu9Aph5+a8jQMb6qZL6R2aatTRy0pBfpNRMupPp0FeRPKGnjfj6NGCBGIkOAAU
	rjzIRAe6IWkKtThq+Tj9hrRHjPDMWOn043EztjDMi3Fyi8pX07fVrMuoNSyYsfD7aNYo3C6lsvK
	bhpWUvVyWnkuOs/KTqFveSvdNCtw/o+fxatn8tkrcgDvdss3Cu8pYU8wMibUokeCDenMHg9MSAs
	9/W6zWSRxKj4ppXjEBvAPRdLZICfEoFauI4N+q79Y3tuOW0vgJgpAv18ypWjsHsEQ4wwcwRUC/W
	krFA4lgopjNlodJb6ZWK3EF3A5ezP7IdFotO
X-Received: by 2002:a17:903:15ce:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-23e256d7899mr91658275ad.22.1752757263548;
        Thu, 17 Jul 2025 06:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9ASpEXpTUCQBu6F8TSsn6R6L7kJf/fCt8R9NgupFXmGH52RNLM663t6kjqNInnvawgUpfzw==
X-Received: by 2002:a17:903:15ce:b0:23d:fa76:5c3b with SMTP id d9443c01a7336-23e256d7899mr91657685ad.22.1752757263063;
        Thu, 17 Jul 2025 06:01:03 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:01:02 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jonathan Chocron <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250710180825.2971248-1-robh@kernel.org>
References: <20250710180825.2971248-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert amazon,al-alpine-v[23]-pcie
 to DT schema
Message-Id: <175275725909.8776.7592079694757871720.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:30:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfX1ifU6YyUWhUf
 cwTGEUC0VqDpsWznK5QefQxpfk8xEMJ/L0cvKAUUH7dqRLsOZ/t3+Pv/lIB1GGNaqEVFzBfcYE7
 rUh8kuebDUI/kHUQ3UL2MI3/iKra/vvBorgN/PwYZ9rtW7VTFjwtpsJYLcYnjTWF+DBvTQqNs1r
 1VSg9g/BYmjnU20Ku1GnwNt+Uv9++YhxMSkvsxujHAzdmawiTmm9VeIgqhJbWePINdH8pvn49QV
 K8ej9sKaOMfWt18jZBq/JKxCDDGIg+GWZf8YslEIMT1HjT40jWYVfm/vRf7paBkzzf0mz2IjElx
 K+w6yT5oGQKa3RqEEby+vQ8ndr9ZwYSFHtDzNvfoNElqgR+BPzfHBWqf0jWPET/HVxp2B5sC001
 KqKxtF0JldD1BPoXpSTH7reQby2/BXfK36SJ4d8GxeA2UsKp8I+39XOyFNKDMW4kcASr3KRK
X-Proofpoint-GUID: cLSUIZ7-d8TTl2dG9zQ6sjEg2WAUv5tF
X-Proofpoint-ORIG-GUID: cLSUIZ7-d8TTl2dG9zQ6sjEg2WAUv5tF
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6878f411 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=7zflxYQyjF-TGQw7vmYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=928 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170114


On Thu, 10 Jul 2025 13:08:23 -0500, Rob Herring (Arm) wrote:
> Convert the Amazon Alpine PCIe binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Convert amazon,al-alpine-v[23]-pcie to DT schema
      commit: a4fa6a0c4d26c8a68b288c833f53235ebce8b6e1

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


