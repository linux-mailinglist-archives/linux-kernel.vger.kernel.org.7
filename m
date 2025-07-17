Return-Path: <linux-kernel+bounces-735324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF701B08DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49061C23CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839152D9EEC;
	Thu, 17 Jul 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LIIXC3wC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C52DA746
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757270; cv=none; b=fyHqA1xnqgmbzJAuiMvJTfVjmlF07Cr7rqE9EJtIGOBWep31ZuoXndTQNbfPQ4dPj+w8T9GrxEqd7eomadZ8/CGHAYCygxCr1VFgyxNu5088UHBoGss/Wpp+aq/osgNH2AHaa7ckxBi4/NSlX6Clw8VBDDaVZYIEr+zT99DopHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757270; c=relaxed/simple;
	bh=vCd4NQszFCL+6SR8GnfbGLcZko3d35aaKRkLZLDDY3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f5UO64J/6BvC3BgKhAn2Do2uJYv+O+NlA49hTD+K3bk4CSLDZreqD1xH6P91XkWklZIvPLSTYGn/dG2HoDR+/8t9A0Gp7dRz+/OfA5u8z7jpAEA4TuH5Cm1YbnGD9pjk/CkfC3dmgXz/4OAuY6yIoSf6RCVQxTQV7E4EvW+KSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LIIXC3wC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCeCsF007207
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PFJBplyOVOVqVS5tVt6ls995i5hPEOXns8yrQXCIRDU=; b=LIIXC3wC7QRrPWcx
	IUNe9MczC3qCVXxrJXlHKb9xjnh5S8tkjxitUKgiJz6PpVuZATdtC6exphyLK54x
	3cE/Q0bbjV/aa3C5hru+eLKgg75j15vByV0S/mGZxDwiPZPKs5GvFzoswxyJ59pG
	ZWpMGk8OPdaR3TVWK1BhiOEzQWTG2zjThw0m/Q9pbNv7BPqXJqgWsOup7HdJRrka
	X+HWg6th4LNmYujUqNT5/1/biFmsCan6XMwdER0wsu+B1Rb6x3J91glMJ5nf3XRt
	C+ad4+4TFjhuYtyU2bai+jt/bK6jJ52ImixlwWKq9At+/1XuGvEgWAWUImu9dahu
	kVqGKQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca8wcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:01:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234f1acc707so10163675ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757267; x=1753362067;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFJBplyOVOVqVS5tVt6ls995i5hPEOXns8yrQXCIRDU=;
        b=HqJJlQxim2OvY+kjbEsD/zAEi0BzELH0oSkRugNFm35AR4Tzemb29Ows667yhz6RL5
         XMEFksOzi7PSDFGxl6HLVw12Bm7lldkiY3ZAN0Thpyc8x0ZA8SSOzLmgfXblEz2DqJrh
         uZ2xV5BIndH1VNLUMc3kTgP2NafzD0VmCN0Cwehv6OEgNtTc6C49hWCCg0pF5LT8Bssn
         cMNtCp3OGh2KO82RPZO0AZ/4AY4KqlHKuTLozBKZ75ydKdcHtG90i/nH9HjWw4EJ6W+i
         dgmRv/XlnmksBZgXHQKT5Aa2LI2Sfj29o6cQnlIimh4dJUIAFnVewQUyHp99EX7scK3m
         27Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWmX6yY1wBi2Mv3jCj9V+HOj4VeNYKGRK6s6Sa3QzoPbPuWDTINHG/2SbEzAHfM6K2pEX1VRZ4DPNYFYw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQB2sk5SgqdX9PEOXGtj103B3dOBiYqq/3PlvDAPesIb8eIIrF
	TIabiQ9ZsHDXe7dT2IqxwLYLu0t84vJMM6ZRpvO//DS7udQ7dU/5fEVq6zZQw4FozCQpeCTSJvf
	pAnZxJCp+CwEp6ijdMJyPW2g3yr8h89j9d0iFjsJQToC2kQqCLgxG7vkeajgoIqruws0=
X-Gm-Gg: ASbGncu+K0yPv6LmAp2hBevQV+ewbF71GVCl5zL+kIM4O4HDfAQAKjky54hHYMgTVqD
	U0ZTvsy/+vXCtXfXxKJ421H2V1PNGyh2+6Pd+gxskli98M/6yK2fWeqSfD/s5HsPwACDiB7Rn7i
	n+dl1cyjGOMhEYhyveJvMkWhKr7JO878uArCNPXfcpexrRw+G+vI7vkWXgofDXGAEfN+V0iM6Zk
	FmpxVsSIrOlZXjLYWRyBezF9AiZ1hguoit51k0b39nFxwCXj/iB+5QlQffjGS6t1yvKeABfNRA+
	nF7u1FKKsgyUU1gRtQnEcvYKlifCT0iVDzCq
X-Received: by 2002:a17:902:f68d:b0:235:1962:1bf4 with SMTP id d9443c01a7336-23e256b7428mr85155185ad.14.1752757266925;
        Thu, 17 Jul 2025 06:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbS0LDQKlOsPFw7HKcHFgsvu6B+PBbBhY5qMGfKyMEG7qzr7920aAD1g7Ty4QSDMZORwk6Mg==
X-Received: by 2002:a17:902:f68d:b0:235:1962:1bf4 with SMTP id d9443c01a7336-23e256b7428mr85154665ad.14.1752757266418;
        Thu, 17 Jul 2025 06:01:06 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:01:06 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250710180843.2971667-1-robh@kernel.org>
References: <20250710180843.2971667-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Remove 83xx-512x-pci.txt
Message-Id: <175275726329.8776.14270280128728418652.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:31:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfX1gVFN9NBVGCd
 sTBut7LWDvMIkzdj65TcGsVrQUb+hbaIX1fl9oYIKt+tiCZkF0QKsnkdndjVKx4nXmreMHIhXPL
 TMm15Jl6lzaiZ+nlYIpxzQce4hAsSGVcFHonEM+gZ/IEfgwe+59Z/CTlJ+7pdB5nat4F8pmTGth
 Y83mZ+6EiIQ9iR5lFhHo9oYG1JMA2kNMzsYF4v2OpYiQc5yJFkmB15PeR6qMCplwqi5QTtcMDpV
 xWwumEX+UdRrFot3kgUZesWM8OdHAJPvTSm6+fwvTwiBgG/teYwiCGE0n/XB1RuaxJW2L1B6Fj8
 Lr/+a/GeGjNT+M9LetXxVfEC7tfQiSTJtoK9nqs7rihxej4JYt/egLtG0Z3/20ZJDyyvZrwUN7T
 pLdavXC5iisb2JtVFc6Bwl1ZLWwGvEhNQ6yCTd7HLM79PEOw6c/lINHzK31eKFZLZjiX1pOB
X-Proofpoint-GUID: wtB8m2iRoiX4-wr8cYsJ__mr57ZcJuc4
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=6878f414 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=uwvIQ4CO5uxB_bX_CJYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: wtB8m2iRoiX4-wr8cYsJ__mr57ZcJuc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=823 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170114


On Thu, 10 Jul 2025 13:08:42 -0500, Rob Herring (Arm) wrote:
> This binding is already covered by fsl,mpc8xxx-pci.yaml schema. While
> the MPC512x is mentioned here, its compatible strings aren't actually
> documented and remain that way.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Remove 83xx-512x-pci.txt
      commit: 873eb218b39302654fca8251634da8f25d30c29d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


