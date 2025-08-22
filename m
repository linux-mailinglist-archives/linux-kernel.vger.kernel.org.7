Return-Path: <linux-kernel+bounces-781466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFDB312CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241E0A08B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC1E2E3AED;
	Fri, 22 Aug 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbQCAlpl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72C2D7DD8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854480; cv=none; b=UyxPsEgSEttfGmbJ3idKDaRgY4VKPGXB7eDpe2tRGs47ScJOvXgdMjyFNCiBA3sdbvOERvcf8ptz9MfETAS8m8YlLIAeIHtRZQX2k8zoAvp1iaMdf0hsPRVYvyOucK6TAIHAiCwZ0f6cfL5t4eeWqZDSe1uCG+h6B3mkVDMvFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854480; c=relaxed/simple;
	bh=yNbdXORajyB6uUaMUAhu4mOLFE93vNT+gPSj/d3fJCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcwieoPZ1dPYmPuSHDG+3gbG84PvSTQkXG+hfXrqNhUcBWLYMp7X9TdVZw2bcEUh5WItIqmXnJ/InI3VF/QAgDFL0d3koSgLhjQ3rB/XcTT+pEPNIPvbbA08DEjzrX1THVShknTBEGUL1O6kvDSNCrxX5ngalR//nWaxRVOEHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbQCAlpl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UM8J028651
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IOCyID8v1JmSthjeoZP7YK+Yq23g9nLuF93nvuZi7jg=; b=YbQCAlplt/Wpi/WH
	yv8oHte/mq+ndlCMTemNruW3G6tGClfh1ifyy+t4UpBCCHg9R9JD6yNnm8kwbdBP
	mcPiwm7IdZ20ccYQtS2157zT3IKtJKjVw+RQXhcNjwuLbQYaEVUSDKhdMYUxI43g
	m58D04oOshRGrTnQerRdHHrctuYKyqKjNKwrC311aSmODdKmI9CTbo1zrVLeDfj3
	HIgFto3NUdgILSn/j3M3r0G6ezuAGjV4Md3BSXmwpf5ROC7G9r7RF2Pj6LLzI+9J
	8Sp2rnR2i36m69BE9wj29OYoZRQMjWJlc9ybt7ybp42KRfCSRjque6ZC3CtbB3FV
	Id1uaA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52crnhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:21:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2eb47455so3872063b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854477; x=1756459277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOCyID8v1JmSthjeoZP7YK+Yq23g9nLuF93nvuZi7jg=;
        b=Zgo+cTjYjT97DgoLMd7f1hdXHfaLWITrzSPBW5hL5EUdb48Bqli4bN2qt45GXWvi8F
         9xnC+E6zdQQAvJI1r4KeN1agZc3j4Z9j+dWK4c4zA6qPLDJSxHuiUYhBkFiGmLux+zQj
         MHxhACCDNTK/Yay5pGAOKiMb4+lo9GZkxWC/Bo9ZiQO7f6GctOKnhTErtnTQDa+4RBQO
         HFas2T6gcoj9Oz1+dPSX3AzDx0BSRb2QB9wWsF9G3SHg9vdUjCVjlWXw7m5lhT7V9koJ
         T57TVsfNZAXYW9YSTaZawXdACZD+osCol519wyM+upJVLXyOuhmaXyEcandeuA7yuF83
         aXWA==
X-Forwarded-Encrypted: i=1; AJvYcCVMnwegnB/yWwglVfuvR14JIBqeRCTEKIHKSuN/9HJK4XKGz6/DB6cDw9zyL78Qz6RFKq20aOoLeufyoh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qxAUmA9NT7CA2KzfwRO65kcVKPLXiZ26ToSpp709GaxjOMER
	NrKRzt5wzsVV0tBjjPxFZ4ohjf+A27PrTzr+vCEGBXV5i2odPPqR76jps2JMqgbp3N27aNIXJ+H
	d7/c7J8XFLeVxLkrDTFLUck2TtbWUD5lRLvfSQLJ5t0vjD/t9euzKyAfalGt3cqOAtFU=
X-Gm-Gg: ASbGnctAO7AsKkZ9prGZs0UgVNv968V0pMBgwVMsFCFnddtbo39ZaAeJlWToLXsQ8lN
	FNUyddipD1nPhkackjhMNhLUvxAFV7nKglJiZ9HWp+P+iPzvIPSSRaAJIikZjcZOf+5xuMogyjv
	/538r0jZhzauqXKNUECR3LKaJCK4Uyzkvwyu/UQxfZ0o7EZJ4oaVqk2EHuSwIyXbswsHbQ0G77A
	hPwHIzbTBWyFygI0ue5dxus8X3PwIi0aI+OIC3xKtncQsEW0gWC2Ln1ZPw1sLyBn53WoFEKIDFA
	NhQ+ZBsvPJ6FeCMgd82MyRN3IEIpIfq/7slKVM1Ahud9154Y+vXgVYoRxiW1yjPpZPY=
X-Received: by 2002:a05:6a00:1ca8:b0:76b:dedb:3048 with SMTP id d2e1a72fcca58-7702fa0a9e3mr3338308b3a.14.1755854477067;
        Fri, 22 Aug 2025 02:21:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE169SwcjAeKFg+hGSDS6nNE0NmrbfptvokZy+amX2UJ70H+B4WuVrskBuZjtYUqvzfDL1gJQ==
X-Received: by 2002:a05:6a00:1ca8:b0:76b:dedb:3048 with SMTP id d2e1a72fcca58-7702fa0a9e3mr3338263b3a.14.1755854476577;
        Fri, 22 Aug 2025 02:21:16 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e843bb510sm9369488b3a.53.2025.08.22.02.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:21:16 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:51:09 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 06/11] remoteproc: Move resource table data structure
 to its own header
Message-ID: <20250822092109.awrfyqz2tfaxchjy@hu-mojha-hyd.qualcomm.com>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-7-mukesh.ojha@oss.qualcomm.com>
 <aKWDXySSt57tXHVP@linaro.org>
 <20250820151822.6cmowxfsheqxfrnb@hu-mojha-hyd.qualcomm.com>
 <20250820163250.hszey3i2gtd3o2i6@hu-mojha-hyd.qualcomm.com>
 <aKX9kO5eHUp40oRj@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKX9kO5eHUp40oRj@linaro.org>
X-Proofpoint-GUID: r6IgSDsWRdvtrzF7vtg8noZOCBT1HFLV
X-Proofpoint-ORIG-GUID: r6IgSDsWRdvtrzF7vtg8noZOCBT1HFLV
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a8368e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=iMW2xQpcS57KE3qV-eEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxVa93Fwpyas4
 GAPMQ5jPKxsAVXtvhMiqGCNd3yutont7CXCnbupCRTQMMukDYNBl4CuZ4fTQnnmPrso8RAmxZI2
 +GNE5k9xubFkSdGjfTZHVhnkfZkaIW+LG5VPjav3EdiEJLF4xfkMunnx7nERPhrSkmiY11deSCK
 eVqSFv1zSoan+N4VFu3kYmRSVarjIpFFtqj2iX5gb2/RX20EUwU5R4XlaXU/wBw/MyQDB0BQyUM
 7mi0G+apuPaxbo8qgwBWG02OHK1wSsZgJYbkKoHOWDuBNdd2B4m3HjCszwIbA40yBBlOfw+Q9MW
 ACMFfdvwwPkghbd9n7Krh1e1KzkTvsJDRMRhKbCUlAa3IwwuFMowHXK2xjZ9sd7zKPYs0KfBI6V
 X+VW1gqN8lTtxBejwNfhxb5iERTPGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 06:53:36PM +0200, Stephan Gerhold wrote:
> On Wed, Aug 20, 2025 at 10:02:50PM +0530, Mukesh Ojha wrote:
> > On Wed, Aug 20, 2025 at 08:48:22PM +0530, Mukesh Ojha wrote:
> > > On Wed, Aug 20, 2025 at 10:12:15AM +0200, Stephan Gerhold wrote:
> > > > On Tue, Aug 19, 2025 at 10:24:41PM +0530, Mukesh Ojha wrote:
> > > > > The resource table data structure has traditionally been associated with
> > > > > the remoteproc framework, where the resource table is included as a
> > > > > section within the remote processor firmware binary. However, it is also
> > > > > possible to obtain the resource table through other means—such as from a
> > > > > reserved memory region populated by the boot firmware, statically
> > > > > maintained driver data, or via a secure SMC call—when it is not embedded
> > > > > in the firmware.
> > > > > 
> > > > > There are multiple Qualcomm remote processors (e.g., Venus, Iris, GPU,
> > > > > etc.) in the upstream kernel that do not use the remoteproc framework to
> > > > > manage their lifecycle for various reasons.
> > > > > 
> > > > > When Linux is running at EL2, similar to the Qualcomm PAS driver
> > > > > (qcom_q6v5_pas.c), client drivers for subsystems like video and GPU may
> > > > > also want to use the resource table SMC call to retrieve and map
> > > > > resources before they are used by the remote processor.
> > > > > 
> > > > 
> > > > All the examples you give here (Venus/Iris, GPU) have some sort of EL2
> > > > support already for older platforms:
> > > 
> > > Example was taken from perspective of remote processor life-cycle management.
> > > You are right they have worked before in non-secure way for Chrome.
> > > 
> > > > 
> > > >  - For GPU, we just skip loading the ZAP shader and access the protected
> > > >    registers directly. I would expect the ZAP shader does effectively
> > > >    the same, perhaps with some additional handling for secure mode. Is
> > > >    this even a real remote processor that has a separate IOMMU domain?
> > > > 
> > > 
> > > I don't think it is the case and think the same that they can skip
> > > loading and Hence, I have not yet added support for it.
> > > 
> > > Will check internally before doing anything on GPU.
> > > 
> > > >  - For Venus/Iris, there is code upstream similar to your PATCH 11/11
> > > >    that maps the firmware with the IOMMU (but invokes reset directly
> > > >    using the registers, without using PAS). There is no resource table
> > > >    used for that either, so at least all Venus/Iris versions so far
> > > >    apparently had no need for any mappings aside from the firmware
> > > >    binary.
> > > 
> > > You are absolutely right
> > > 
> > > > 
> > > > I understand that you want to continue using PAS for these, but I'm a
> > > > bit confused what kind of mappings we would expect to have in the
> > > > resource table for video and GPU. Could you give an example?
> > > 
> > > We have some debug hw tracing available for video for lemans, which is
> > > optional However, I believe infra is good to have incase we need some
> > > required resources to be map for Video to work for a SoC.
> > > 
> > > > 
> > > > Thanks,
> > > > Stephan
> > > 
> > > -- 
> > > -Mukesh Ojha
> > 
> > Since I am not subscribed to any of the mailing lists to which this
> > series was sent, I am not receiving emails from the list. As a result,
> > your recent messages did not reach my inbox. Additionally, it seems your
> > reply inadvertently removed me from the To-list.
> > 
> > 
> > https://lore.kernel.org/lkml/aKXqSU-487b6Je2B@linaro.org/
> > 
> > https://lore.kernel.org/lkml/aKXQAoXZyR6SRPAA@linaro.org/
> > 
> 
> Indeed, but I don't think this is my fault: You have a strange
> "Mail-Followup-To:" list in the email header of your reply [1] and my
> email client honors it when I press "group reply". Your email client or
> server seems to produce this header without including you in the follow
> up list, as if you don't want to receive any replies. :-)
> 
> I fixed it up manually this time, but perhaps you should look into the
> source of this weird header in your replies, I'm probably not the only
> person using mutt and just hitting "group reply" all the time ...

Thanks for pointing out.
I am trying to fix this, let me see with this reply.

> 
> Stephan
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20250820163250.hszey3i2gtd3o2i6@hu-mojha-hyd.qualcomm.com/raw

-- 
-Mukesh Ojha

