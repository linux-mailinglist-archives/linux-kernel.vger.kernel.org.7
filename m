Return-Path: <linux-kernel+bounces-740745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B782FB0D88A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936DD1C278BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4C02E4270;
	Tue, 22 Jul 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LqIPgit6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915EB2E425C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184887; cv=none; b=aEIqxB0sYBpo74RrTwAd+eOqvioGQnbpNckY5SuwKrudcXCb236uc6cRpk0N8OWeibU0L34B1k3g9kYxCTSp05rEv2zoDSk+ttADJlh8sINoBzGT5ZU4h6Jf77//Je0jBSIjDnuftJqteoT5ucWNeVYsBnEO+4j8LHq3O48AX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184887; c=relaxed/simple;
	bh=HgmqSfWO+1Qv89IawgIrcQorcabXHoxhcjMblkphFi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ2jvVWTeDwniIrWvigZX/XFsAi1hBIwfyZ2KRtm20ys6z2KdwBnHIqPqn81HCvAUBHvm+6GlVybdni0alF0nGpQt4QOnt6+/d2btkq5b8pZcYeXu+j4Xu/g3ylBzZMLXNlOELushZygeaI5KnBBD05Z+ijYKQDIde271HcIsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LqIPgit6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6uBea020176
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e/uV9a7Jqnj6kSvl5ZYFA/WJ
	se7QAWXeSsw+XPt/+Bw=; b=LqIPgit60cWkMCFQZtUxfk+sA6Agc8gMiVS0+DeM
	/YMX3nfW8oakR3qdO8tj9a84bSgu1hbtltywBEQrDM0kWPIhHYqMBG4NokzNx6Tb
	pug2QlPUUM40Kjww+NN92hKaPgXUSdYJlb884hOotKv1fX3ksi412fI7lOyj+J3k
	jsTBhArmG+YC9jEyHdpyTPYyd7pRq+40ERBCpreFJ+uqZ/6PuaM8Zm5/mdUHBdaE
	2ECvsPpDby+++LY51tTPn6LY5v/3pmqbhDq5qaZrIhnCbSLCRNOt279XY7ozZGGx
	IYCJmQrNB7tGKg51KKMsLaXLuVSSH5ziBqov/EVSxtQvtw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804n9ynmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:48:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e03ac1bf79so439694885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184883; x=1753789683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/uV9a7Jqnj6kSvl5ZYFA/WJse7QAWXeSsw+XPt/+Bw=;
        b=rM1G69Au1nQnfx5Uotk2RWm5f0E0cpb+8S32TNBnhHG2zji4mluOJtuw1kiJ9un6EF
         IEz0AtarVIHk3TVN9gEDMhLelF2LxZRYyXI/1KzDFhPAMSTsG4U45Gbk8lwyK8sYwnBO
         1pBPZ3DLlA/Pmzs4dTIkIbDzkL89EqW0E34NDRhzyJgHBR/fvaKFkakHJ1tTc9E1k84g
         cOC2KJNbiDGUlyu26dqBoOgGmD4BPGE197fLLLwYUJTHXEf7lp5ZR4qQCUh+qm3E2RQG
         UmmAEdvKOHBgxfjqKTdaoSv2pNJfXbn4NgI6iBVVzlXwWjE3O/a+Bnmw9FTK2QwU3UYA
         foaw==
X-Forwarded-Encrypted: i=1; AJvYcCVaAAxWsQxfxWqeJVNTXPS1PaN7CXVVbfL7IMNo31O35PkTOt231CCa0eEUlZZRTd6XAE6xcQBunMErqpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznEjYgTfVYpsdA95TM27SI2o7H0ChgRCP379nZ16Clv5Y5C5MO
	DKtJ1NioxFIfQrqVRm/AnNlfrHjKKjf4nTPAewow/tgeCn1cHqaXfkVO1gzGrYrvVWGgxusXejC
	+0UCFzULHat+53M/jZyvQ6sqGKV6QmZGqxmds+xqfmocC2st/SivzIvsnDL62wCBtB7k=
X-Gm-Gg: ASbGncuU9KyQiKK545pNLVm3Dv1rnUXWquUUZZLnQx/LBLxo1DBnNuZNr26EWr0Zd+5
	VSKQvyz1DSOH97sbJDwjVFVCy8eTZKtB7wqoAvf8CWS9EoedethaWylo+js3m+4Ox7v4FQr+EiJ
	AZ8cx9CXoBWmzq+bOebG25cGBkyA2gOTHdHY1gUba2HchdT+VM0xTunKJ+CZfHCy/gf01Cgd715
	RlNt/ovBRTAu7/b5E9zcWDqgQPicRoHJQA9w+IBbY8nqwBSNpyQDDAw6B75aKpjKjBeGAxUCqRH
	qixI6wCCB5AEtj3phSTQfEKGsFXqVbZW4yQ6DJi/dvOR+eOiuYQVtoaxSrUN4QgkCgo8mm9lrzF
	/WXBQK5wr9YIl2l4+lnQhjwKu1fZNIHaTh80dfxj3LiqWW+z+Dg2l
X-Received: by 2002:a05:620a:2612:b0:7e3:2f8d:59e4 with SMTP id af79cd13be357-7e3436168c2mr2621825285a.39.1753184882793;
        Tue, 22 Jul 2025 04:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiKUU67trOd5R2G3OmZaeyDZK2sYFxK5CnKSSxD7DTzEXFdVZTER58keZzaYO6YjVhiNEKZw==
X-Received: by 2002:a05:620a:2612:b0:7e3:2f8d:59e4 with SMTP id af79cd13be357-7e3436168c2mr2621823385a.39.1753184882424;
        Tue, 22 Jul 2025 04:48:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a99696sm1934653e87.34.2025.07.22.04.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:48:01 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:47:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: tzmem: disable sc7180 platform
Message-ID: <73g3u4ekk3e22a2n5zymugor2itqvdt6jyohb4qf7wltx25l2j@obxegh5fnnwq>
References: <20250721-sc7180-shm-hang-v1-1-99ad9ffeb5b4@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-sc7180-shm-hang-v1-1-99ad9ffeb5b4@trvn.ru>
X-Proofpoint-GUID: WcpoEyMFFQUK818G-oKAmO_uNTEntiEn
X-Proofpoint-ORIG-GUID: WcpoEyMFFQUK818G-oKAmO_uNTEntiEn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5NiBTYWx0ZWRfX2d9tS+rJTUKJ
 LtPw0O6/vfSBxIEdIU3p7t55WpV4hZyI+pOiDcQSwTwwQbuxInSbjwyZeXpz4AHolNfcy4VjYx9
 TW3drGkSAHekw/zgqlmZnhNSN6em1zVsv3lnXT8FGGRz1PlC4g0y0oLYQfwpPE3MOTv+SHhQtvH
 PDm5WzYJ2LPGl7eXgOuNL0HlcxawCrRcpmAWDGwti13iIpMzXKQxZvyGggdlEJPo0Cl+aoS4zSG
 O885+jZ1VlnK6Te9AYskXlGnqeSG9BaAdZhzwTKuxeB6UX+HUni9kiAb4bF5olbKWAPJ1VsAWUo
 f7GIw0BoqupgusYq0jRYKmiiNEDoyzuUittUhto6LC6QeLqUcJbutltLW/1c2lSpqFMeLUPUSu3
 bJIPA24hgeT6NEuK/1g9YldO5NEui5YJdXRDvZmxyjdq8E+RN7qReCx+cSpRNdFki8lzFWh1
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687f7a74 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=InlpzHCLAAAA:8 a=EUspDBNiAAAA:8 a=MnaHLJqymsomQlmqN2oA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=j9sqBCYxEfXq8HZXc0HF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=861
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220096

On Mon, Jul 21, 2025 at 06:28:03PM +0500, Nikita Travkin wrote:
> When SHM bridge is enabled, assigning RMTFS memory causes the calling
> core to hang if the system is running in EL1.
> 
> Disable SHM bridge on sc7180 devices to avoid that hang.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  drivers/firmware/qcom/qcom_tzmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

