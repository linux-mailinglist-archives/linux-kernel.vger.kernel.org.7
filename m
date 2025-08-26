Return-Path: <linux-kernel+bounces-786401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6CBB35949
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D048A3A1E45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F331A063;
	Tue, 26 Aug 2025 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4+QgYUC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AB319849
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201491; cv=none; b=JTrzhRtAFZ1bauhDss58PwIcW2HQfM0SDOl1I4EgUhtUwHreYKWO0GyiIBZQhI7PV/jVPwPwXlJArKv8vPQZX056/9VlA8kYj9wB/n5aJvoQ41rKs4kOMSCH9wrsfx0QSIf5t3gCyoYnSErK1C6B0LmM/2xF+hSDXpghsH6zxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201491; c=relaxed/simple;
	bh=bKJ0fjdJCipGCZZemVQf2NFUT5zLKcT9eIte7Z7ZuQc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Y0r443MHVO5fiJZkEkvERCykCrRP1wMuoEOCy0rIkBF3vG/yD1zLx3f1BiNiro0JPDFSnn2nzwBMmqLH0ZcnzOs/tEAls62+jTzrlhlZ5WjW2pghV+AJt/FhClgi0rfDR3XHLVqeVj5DjOqZrqVZjVposcZ63FLgXEoY2Hq5+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4+QgYUC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8kJVD020022
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=THXD3tlh8eUkNhfT5PZNJh
	HY5CcdeoTK49zbedmEjuk=; b=g4+QgYUC8d0fGdy5J1db+XMkqGsk83v8dKbpP0
	vrEBj3W9YYImfOLv2+Wo8BIyei98A5TR5lp9jvA9M86MqcGtcUEZml27fg2y0Dk2
	vo3ri2btmuN8mw5Lh4yRN0ZuuKE/J91YsI0ycvr9JNVYrJ//8fMHfZX9lL/uzSpe
	NUAQuUTQ4oJ/I9jAY+YVa4sE9b/TxXLZq2NiSyDm/G2aW6bX+W0/ZrZRj9uBPQ2Z
	xS9sOSrStM15Ko4iRccxLqfpAXVhHkVFX9os05DyEIE1jYiwFUUuiILuNO3EJXkl
	cAl/uvU31ubvcHxGWhEFGvMSxfZsZCx8Y2km9BMOGEkP1JDQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615g772-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:44:48 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e1ff27cfaso6042201b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201487; x=1756806287;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=THXD3tlh8eUkNhfT5PZNJhHY5CcdeoTK49zbedmEjuk=;
        b=qG7bmR4JZS2W6ZEIAjpwdJe1LjQ1X9pB6/BjQrosB2IH0e5eB0KWod4a9JBewzsh5G
         S95qpzLFLaoybpWZ6nCqiKhb0IBsYzknmDPyJSNL6PmnzR4s73dytBaql92LPJY/wgwv
         lNUzj8baZOBNbs7v3iV3g85TduoiZu+CDfXwrjtujXfLHghDqPhDiPYSImA6/z6yTyRP
         9G0Gcw/HcGlZq8yeiusKLSrV2czJgONYXJ8tiPnHm2siGeJVw5JbK1RjuRpLV7h7EU9n
         rHaSaS9C9+kovugyAciehbYvBvaHwqyXyrFmN/aGyebShWnRzIJDOt1Qz49UnxBX70Mx
         8RYg==
X-Forwarded-Encrypted: i=1; AJvYcCXj4Z+e1nVeepbx7T1/7XJAIjNmVfcl9x9o+41mWqDKIWX825J6OmbElJbEg8GeUoKHWue1VuZu0xCpFdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOW9PFPkwt3jgFBPRXgoPRx6f6jNewfI+iZoGWAkI66y9Il206
	+2AoBT+B4YOY49hNJcTqNKy19/9ETZ6mbBo34leWemv/3oSdIJ2Hpvf3v32AL9Uk0B5SSDFfsx2
	d0+T+ubEtBYysWBfYP6YKMZzYP4Y2nJf0GZhKb/Gmm00I4tHaf5j0zYez3i0gvcUzyhc=
X-Gm-Gg: ASbGncsO6InZ/4vxzMQPViwAiBUF8O730sZv18qJjoCZ0CH5w2OBlVrMwndF6G+LgcQ
	OnPENl6hmBWvwL02iyZ8Gb34iUDGL/yeD2nmami4l4if152qwDFtk3gOuAaR4cHjbIBSNv9E08u
	ZX6Ss2q6Yzulq/o9ZQGWIUGWZZPxwvMQBhw+BTyfs5nlIMlpVt7SKlNHCTG8/K5OZQ9BUzFDDeW
	pERA1W6K3+NG3XgNd2dWsmTrwuYby6lyZcjgUU1USMgXlI2pe7P4Od7vj/2US4MtzZu1V9M06nG
	IeQSxJ9bS3EMrD/Gt3zJXBw5kzQdA4u4AVsW6T8x+7DYiWnMI5VH+7IutrgfC1S07pbCAO9l5Ao
	YEXI2JxuBAM/LYAPi4EtNfU14tw==
X-Received: by 2002:a05:6a21:9990:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-2438facc696mr1246054637.11.1756201487020;
        Tue, 26 Aug 2025 02:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvRL2Fy9sI3oGMG7jx+6nF6YDFCIRE8NYEdNTyKm+HWJTBqahFHayZ4KaRSOkfwszakqi1yw==
X-Received: by 2002:a05:6a21:9990:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-2438facc696mr1246024637.11.1756201486520;
        Tue, 26 Aug 2025 02:44:46 -0700 (PDT)
Received: from [10.133.33.184] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f9f289c3sm1329536b3a.19.2025.08.26.02.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:44:46 -0700 (PDT)
Message-ID: <ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 17:44:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: is dma_mapping_error() check necessary for dma_alloc_noncoherent()?
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: iommu@lists.linux.dev,
        "linux-kernel@vger.kernel.org >> linux-kernel"
 <linux-kernel@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX0cKkk+L7om7q
 hb4ZJtAFlWz5+AIlQWC+WPbqtlBZhbvzMAOyG/M4N24F6V/SiuwqWDVyJKy/RSQguCW8p0qrk1d
 5w4mImnavnRxIwWmpPpFArJD7d7KSIzOpCAp9edfZcsn0yoYuVFrt0uX80K5Upensb8FhWLiFJc
 ASHGDIFXPTEE2C/53VFisxiacNdzmZdPyf8npSnVQOYFtjMnkj9wqq6qf9eSNs7NxBBYSU1lMoI
 fFcbFl2XZXKLN8rfI64e4uz4g+5bCQMM93S5QGZBazDuZnCIJIXkMhbKCRo3W9k9tCUqoxq9GLx
 CjDN4plCHXrQ90akiWIPmvo7AXGR237ZGUVcMk+rI2Z26kU7kP7jBLZJhUufNnr3znX6va1pVib
 bg0Cw6R3
X-Proofpoint-GUID: bjKeJhQtm_BlDqBASYzr9Ze3swkuCcaP
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ad8210 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Q74vz0maYr0LruRLZiwA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: bjKeJhQtm_BlDqBASYzr9Ze3swkuCcaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Hi guys,

I have a driver which allocate noncoherent DMA buffer and get the returned CPU addr tested:

	vaddr_unaligned = dma_alloc_noncoherent(ab->dev, rx_tid->unaligned_size, &paddr,
						DMA_BIDIRECTIONAL, GFP_ATOMIC);
	if (!vaddr_unaligned) {
		spin_unlock_bh(&ab->base_lock);
		return -ENOMEM;
	}

while free the buffer

	dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
			     rx_tid->vaddr_unaligned,
			     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);

I get below warnings:

 DMA-API: ath11k_pci 0000:03:00.0: device driver failed to check map error[device
address=0x00000000f3ad7000] [size=639 bytes] [mapped as single]
 WARNING: CPU: 15 PID: 64303 at kernel/dma/debug.c:1036 check_unmap+0x7e2/0x950
 RIP: 0010:check_unmap+0x7e2/0x950
 Call Trace:
  <TASK>
  ? free_to_partial_list+0x9d/0x350
  debug_dma_unmap_page+0xac/0xc0
  ? debug_smp_processor_id+0x17/0x20
  ? rcu_is_watching+0x13/0x70
  dma_free_pages+0x56/0x180
  [...]
  </TASK>
 ---[ end trace 0000000000000000 ]---
 DMA-API: Mapped at:
  debug_dma_map_page+0x7c/0x140
  dma_alloc_pages+0x74/0x220
  [...]

Checking code gives me the impression that I should do dma_mapping_error() check as well.
And indeed with below diff the warning is gone:

+       dma_mapping_error(ab->dev, paddr);

However this does not make sense to me since IMO testing the CPU address is good enough, I
can not imagine a valid case where DMA alloc/map fails while returning a valid CPU
address, no?

If I was right, should we remove invocation to debug_dma_map_page() in dma_alloc_pages()?

