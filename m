Return-Path: <linux-kernel+bounces-735320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC52B08DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED133B9D90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948A02D8DC8;
	Thu, 17 Jul 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3paOvIm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DC2D879C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757259; cv=none; b=Elx5VokQnyPKOzFzOMMhYE0qNCnZFnlaxQTt7Fa3gTBpG8nkypUQVjbLnrewY/MfmoJjGOghnPev95t95D0KuPY+MgdxFPA9ihyBUjIM1mcqyxeqNCD5dzBc6iW8SPM8xkj9ukSLC8wQJKTYJNuwfXAjLEFHtS6SQUWYp+djDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757259; c=relaxed/simple;
	bh=4R9lsc48a67psU3Pr1dtqISLFfU1EyeEeVLBRsDHQ9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RjIFmZECkErCFFpp3YIVG0SmdPEfDll2smLvv/MMl0F2gWV20xqXs2Uw4RwUdZN9AD4038G3t+A1XiNfkbjPWfYvLEbzNpETwkNLIpkosUdHdBcq8rUkMJKG7KzzAIdlh1LKrlh18O8ZD/6FQcWU9ctkTr/ji+OW1M6KqDazZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3paOvIm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC61Ig021601
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UsxenPoC8lra25vGZoVrKrqJsQX6ay90sm0xWM3ltaI=; b=D3paOvImo+HHDZvK
	1z6eOiH0RTwW/2Py4ROR3hnLNj3h3ebsfNzQ/3W8L0g23byXPueN4aMms8HvDxrV
	xz/hyDD3gC2qlFA6teiUO9Cepsy0V9wMoJw06X0Cg3YdEy0wQi95fw4lMw3sS1KZ
	LcWAH7330IDbzB1EOeFp5pFG/7IArmBl7u3bb3kdasQnU8IMKjj9qdA97Cb6D5wk
	TKUXqz+HRxYv9GcVpXrW5x5+RppDVtZ/gGL/DL/GFS4iSdgjsuAiyxiDYX0ai8GN
	kL3QU2lrByBzCP9RkH1qPpeT68L7mNJEgaJW4x+jO7U4eRzeqczGt0H9SttGt0Fo
	WQK2ug==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpjren-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:00:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23827190886so9832315ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757256; x=1753362056;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsxenPoC8lra25vGZoVrKrqJsQX6ay90sm0xWM3ltaI=;
        b=LGpwrScFeaH05/fJddIUW03nWyZyCmSewMSV0ZzL7U/OKazuiavbX/Gzg0YF6an5L7
         nLW5IynNPswK+zRT1NfZrW4I4MQ2+fdBzUpJRILsLftGut5gwovw7042ilKyyXVMDkrc
         hP76TgBWRrBHTC2QiXUuu8S5dBw+XItMagp8tJxpDddoZTJOoyRz2GsVdfctP1GEl9Tw
         sR97YcoHEOe0FIY8A5QuoLwliK2vPXUI2CHObVlVeVeu1ymk4kXAVuoZiog9au4aeOx5
         UpnPXlrUV3eiWHOjqic9ah/ESNE8v6Zy8Qz2B1BIKiAZ79eXXq/ljHLlhRvvfGt/hqog
         uclQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+0p7F4dB+s11BCqpky+yHaeftPkkJ10Fp/obCBT+ARKGKapuAlV7THzzfS+eU1zuIX5+OJ/NZkTIAFZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFKhK9Z+Gey2nqkSGzkjB10ko3Q2LgnRRRgllNiT+h2RhQjKv
	7Nq9d7Djw5cFC/bywX+axglSnRzgu5KtP4q6ZqrfEDaS576EFVjPfh1cPzovHrCvZSTIrJmvBpL
	2MKgB2eBc3q7Y4+4tOni9JrcD+pD6zLHacVNLx6M4ipSTHNE3OfIIu6/Eg+nSAPEnb2dh5tL5Yo
	w=
X-Gm-Gg: ASbGncv5/BqIsS0EM9n04hhXVfXkkJzAfXoWCQa++L/LP9q5jdtyD7mfwg/8/XLkPkj
	kofhqQGsLE5fEaVssCMIjDC9kE9FcKpvLnmo4Kw0NwPDj4Nu3Niu0vqmqonLKaUtAL6wiefTiXT
	uWJgDFTUW1ecziqNtg2fmmUl/fOTlibwm51otnEUHrWfHfMWGMgU/sOPcKPI/8NkbKkGxtp8fFB
	J/cf3Mv54Kh6Y5tjfLNN8eDsf7LMsOuIPSYUai4oqDznFjd1ZUU5NW0CU/nZI9TGXsd+O+1BRjZ
	i4DVi2Lk4hvx7AOlQ+0RD7FahP1cttSKNTwd
X-Received: by 2002:a17:902:d2cc:b0:234:a139:11fa with SMTP id d9443c01a7336-23e2566ae85mr106699075ad.3.1752757255538;
        Thu, 17 Jul 2025 06:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6kLQyELqoUaThRM/8jo3nwD/JTvp0msjb/NlH5yEoYUZGlu5Twk019E2H65MO9AFL6Ponlw==
X-Received: by 2002:a17:902:d2cc:b0:234:a139:11fa with SMTP id d9443c01a7336-23e2566ae85mr106698245ad.3.1752757254911;
        Thu, 17 Jul 2025 06:00:54 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:00:54 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Toan Le <toan@os.amperecomputing.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250710180749.2970379-1-robh@kernel.org>
References: <20250710180749.2970379-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert apm,xgene-pcie to DT schema
Message-Id: <175275725132.8776.11740165619532481906.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:30:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfXw73FdG2ihjvY
 ELVqZfxI+QHWL9WmKgYoYd+YLm8kb4xGO0vSDqPrNR9BhX/NmFRmbVhMZia7IaX6qax2TiI4qrm
 DY5a9X49qdvjq30tHxCgATN3pndCXjvDfkfecA3avBHCmEGYCUzpXQWGngF0Lgudd+JK1OhRbG+
 JodCW/2Pwn4828g304Ju5/kUlko0CN5fq4CvJO8yKRzvH92dwA5PCBpKnnIv0jlNo54kJcmQVVI
 tCcNh1tPgBjIa6Xtw8xX44YI/hhfeE2cPL1woRsWY0v+UWLrQWKWu54g0W0f1qxSkT+LOsiKDkO
 imHqUNA6tj4Hz1iwYnfOLX0JXbH154qLvVNYqJIfuZqa3SanGIvUX1r2fwzfb9foJ9rqqMRM84I
 bk56W9MTNhVdV7KDXxrG6majnQcI33MrbyAyxyrU/g/B2JBH0lykroqRRUxcFHQQg0AjKvRQ
X-Proofpoint-GUID: IN3XqVmmaiv2oFUV_CvrotdnrAlOue69
X-Proofpoint-ORIG-GUID: IN3XqVmmaiv2oFUV_CvrotdnrAlOue69
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6878f408 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Tk-7pMtUu1chtXBpElQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=795 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170114


On Thu, 10 Jul 2025 13:07:48 -0500, Rob Herring (Arm) wrote:
> Convert the Applied Micro X-Gene PCIe binding to DT schema format. It's
> a straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Convert apm,xgene-pcie to DT schema
      commit: ac8ff3e15ec6c54f11d38a6f5016de323ca1d576

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


