Return-Path: <linux-kernel+bounces-742923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B45B0F84A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75D73A536C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02021FA272;
	Wed, 23 Jul 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3aSSJmg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530F5D8F0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288829; cv=none; b=W2EiNR5FBpunEzcDz3jpn4ZJunqw64AVN0LoyFf9Q66kekeFtQh9j1cFIcV5w+SDC9Wibu8m9pcZOk22cBK4B2IDW1jeUIull9svKK8vHpSM2wyTVkGWUkcvbk2wyG+tF5mJJOwYolgGyFZCQ41rsofXickKZmFz/iIdWqS1XMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288829; c=relaxed/simple;
	bh=zrwVpt/ZnMglqEyuji76XLtZ8HQbsMLj8OaI79Ak3/s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c18nRXs/yT6AeYJQfYk5bdjvAqNqDSWXtK3Mlz8i8QOY525UZt3nJta2y5M4goVa+lMfjVkeMe414Q+buI1VXAIKQMiDwMeV98YOHGmBfXGrD5UNRXNfP/0j5tZW/CaOiBbvnGQ5UyHQaGgoWk6BhcvBWNrWdnY8PfZnPgGhwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3aSSJmg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9K20u024755
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	asewMPoDa8OP/xKR9tMVu5Ys0bUlKWoneZLys80QK6U=; b=I3aSSJmgcVOlGK8k
	2SqRWBx3GM+FrKlJK64ARHxsYleiMUFUQiDjg9BhFlRLX8i5Dlu82EO8de26iPE1
	oaO5tRrasCmCXrsFy7KmTGiUkr3VILzBZ86mNhTVN7pEaxsxsBqmPyWxFB4XL9dK
	ESpcajABvicNkuSLww2QUEmA6S76NK4V6HF4vNpWS3jlUNjM0D1k3tvIhgoyMp27
	tPfGh+IXQG9hjAQztKaG31nI7yL5rp/yHU7g4beURnWrT/SwxPlUA0EK/N7xZiLM
	XZCGDHRC9+M19yhUlnNwFdYSVqz5CQdFMGfqK8F+1d6IwqXU/UXTkW3e2ga2gcZs
	PGYGcQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dnqvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:40:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb50d92061so532166d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288825; x=1753893625;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asewMPoDa8OP/xKR9tMVu5Ys0bUlKWoneZLys80QK6U=;
        b=LbT9QtFU2U32qsPZLCDyI81fuWkTTk8UwqqHBalgks6LSVCPuyDTFkYVDeGMVFSgmT
         sdwofM6JHc7flK0TZL7wYh0lmkxvBPa3GJyHDoBV7d3Fi0AEBU5E+m/4nuQtlGecMPNX
         1cvI6wixI7rLRKdz2f52ZL2J+kax7/no9JGjlSIJ+rH2gYlsIivjuIhhXmZtdCiXmuKM
         ckQr1ZOc7yENPl87f2XYKUFIr2OH1Gjl9ESI87RdSuogDMdrYjDOJsH/C/RDP7LgMDWu
         ok/6Wq1BkR8DjsTcSDbPGlq0MWT7kFXnUgu0dlnWbpV8W9/usE9Pg2iRGY3yvCYbbELB
         Q3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZFwU5j4gm9p6DgsRXk2rgJCAt1XFEU7yxEbe9dvrizcgJZOJOKJjeTDtM9pS0O5vLEpBTXkrtRj7VIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6eo6t51CbCmfSrLH9BPhFoXE4uMj8GKSHyAKF/qAw348dIvP5
	cMSYi6SY+DTxJ9Pkl3Q5YpXsQY2pC2iFDn3MugeogZ1PYc52UT7+m7d6ZJu+R9NkzmbbUf9ZPBC
	Q4gLvuOrnsX2+wskG6/9RUN3SxLjszANXX3kf5uXOgS7NCy8NrEgK0r8leX/y+fZdYp8=
X-Gm-Gg: ASbGncuptOc4hn5GHqFFWj73s0n1370gKROofHgIovnGX2chSJ1qFbHMqANdC1ywrDZ
	FDVlEdLVpBRUbp9DP61z6LJhIxxHMTYVV7IT+4EhsSVT4EMpTMNDpL92t/QCiurg5EnAu2g6EtI
	rdwHPfjGZK/3dnHPf0E8u6RxYW6bptfi5UT/UGaOcOPd7v4+5dBGTUyAdy+exQc2KyZMqYsHMzv
	oEn3nEoEykJvGYWqGIVYBbNqNpmIc6L/Wquaf5jOXVsAckMAYpQgjr9Ih7EMJkhXejkv2A1V2q/
	6dLZscV/yQ1tBM/BddsVfq+lK1Xw4HImcRo=
X-Received: by 2002:a05:6214:2aa2:b0:704:881d:3102 with SMTP id 6a1803df08f44-707007112e2mr46418416d6.12.1753288825542;
        Wed, 23 Jul 2025 09:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8wpQf4uwxEj9EM5lfb3sTkgXtWQrBB6/j4Y74ae9n5U8jJuU6pBy3PedPAaibkrHp47c2iQ==
X-Received: by 2002:a05:6214:2aa2:b0:704:881d:3102 with SMTP id 6a1803df08f44-707007112e2mr46417976d6.12.1753288825056;
        Wed, 23 Jul 2025 09:40:25 -0700 (PDT)
Received: from [192.168.1.17] ([61.2.112.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70707ed62e8sm6103776d6.109.2025.07.23.09.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:40:24 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Salah Triki <salah.triki@gmail.com>
In-Reply-To: <aHsgYALHfQbrgq0t@pc>
References: <aHsgYALHfQbrgq0t@pc>
Subject: Re: [PATCH] PCI: mvebu: Use devm_add_action_or_reset()
Message-Id: <175328882109.33917.12360207254850484850.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 22:10:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=6881107a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=L2vWZV9GmkZVUxua0bORKQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=MlpMO9RAmn1aYvgnbukA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: pii1Yfr5TdApqOqqf8AJVAmya-mZ4MGV
X-Proofpoint-ORIG-GUID: pii1Yfr5TdApqOqqf8AJVAmya-mZ4MGV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE0NCBTYWx0ZWRfX7RjIN9CpzmsI
 8UzqZmVwZO+D5xCVOdE7A1tGJ87tEeqRq/vtePZivDSPTy8ybrjy3Xqm49/gmUcOVpctyNvZ7E3
 aGGsGeVjUzfcrBPSw2l5pVkvdjOAULqUx4QUYWDdbUAKFABNMawVS7GmDxbdXDELKWnTxl3Sw9s
 plpvoWI/nBxeDrFKzh+VWnQzkKlYZu3gD4DzxZxrwgc/0ZAc9gIR2wfHCFG/i+b5GkeNNkzVW5Z
 kiv64wkTQCStbTvnW8llbxdGdDWLw1eInqWumyI3PpEZ7dA57MaEP9QHIYhzpQnNPW7gLbqLHGm
 U5EbsNOKlccYbtMUyAjLVEYxn+C2l8YHaMv/KD6PM5ZZzas0R2IJOTLFro74LaE9wL4fKnEpwbM
 ih3eI1owAGy+1GFXk9Kr9iggk9C34IA9uX1Gfr5DTPD5BhQ4MNfg4QmU+kD6xcteEZgMPURC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=625 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230144


On Sat, 19 Jul 2025 05:34:40 +0100, Salah Triki wrote:
> Replace devm_add_action() with devm_add_action_or_reset() to make code
> cleaner.
> 
> 

Applied, thanks!

[1/1] PCI: mvebu: Use devm_add_action_or_reset()
      commit: c79a7ca8fb72a17db03e916438c44d9afc98998f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


