Return-Path: <linux-kernel+bounces-845774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E057BC6134
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B93D18976F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF02BE7C3;
	Wed,  8 Oct 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="djWFSYF0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE8629D29F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942271; cv=none; b=YiMyGh+thQnNnp/RvFh2QxVWEoccVuvCaCwb7lkQaQiQ68jL+41bR5kACuh/UPjMcjWP2LKVDuiGSg3rktZ7Zzy8bGZnp+Pp73ThoYxahNJ4uV1hBD1Ha8o2E1vW+IXZnf0Xv3uKbRlWZExW3H4jRzGpC28JoanwlCK982JS4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942271; c=relaxed/simple;
	bh=qCvdqWh3DPpfxbQGE+g5mYNSTzs+ojt/MxeyoAGETVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD0NQ3dpFJ/SJrT5avVLRCVIlQZQpMp0U76qtgi6kqs/maYvGCPhN6Fvi97nCyKgcrK5GrheVSuCtxvgXjMzyN1ZNlRICW/E4T2ELooZKUrupsWkN5qum/Oo/DzmmwMkCuEdGwdw+d+OU+y6/mnpdkjJYGWAoNoiXDH2oJkwqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djWFSYF0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890VCC028952
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 16:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=maqQv8jukNN7H8+OTGdtneuf
	SwQ7FHqm8dGuYbwSXjQ=; b=djWFSYF0eLnlQ9aPUPDcClV45ZH/Jd4EUJ8vNfhW
	DSa7Q+Cvl4c80b6XpZsYvWk2qwpQHhPk0kzOdlwxpIncZfBW90/l8+oW/CQRDiQk
	kUb/GyeV/uyyuUnFog5wezNe/HWuZAjhgGwX65djvkQH9G5DFKHfudiTDociN4fx
	aqjaQ7PVD2mtDnhE/l3qz4Xez0+YE38WQlwRIxQHU45GdtGoGnwgVD8LaYJNaKv0
	LGZOfxEPf58YmhVoz+Og+56uaQyBIu9q/E7CCMZx/g6tOWIllC+V73PV3bxJ9XoX
	M/FoOrJjY4I1Qorfz9YCrpqDJTpNLfFoG3GIlVwVVAXnoQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwguc9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 16:51:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269880a7bd9so222625ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942266; x=1760547066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maqQv8jukNN7H8+OTGdtneufSwQ7FHqm8dGuYbwSXjQ=;
        b=Zi9w7F57ZOOJl3ytH6zN1dbHqtf+x534DpGr/8gHa1jsHMNi2aUkflvQZnucRWNr56
         0dT2d1hHrLF9fSeEmwGCq+c4D5WWLAT63GRLdmkhXgSxSaeVp3fiR3qLNVOgF/JxpWYY
         Y2H4Y3RL3r0sjz8yvfdOxIrDnXLMLa/qm50Q9lVB024IMsetwJUp34jtdPJXcqmBUU1h
         clztIQB8o95Kh2hVgfBNcRvElCjb6agOpJw+9DUwcPwrbC4qwK8XNs1iSUb74bOBEaVp
         5Av6N7fyK8EdHWYTPltfml2g1qPvW7y3V+g4oCyGnCsClqa4ASvxMzKPu3Jb1vc2fOR7
         dyLA==
X-Forwarded-Encrypted: i=1; AJvYcCUyVk4U0hxzgz2A6MdeMecxqvv6ATIsSXbvXejMRQRp7clslHYa5QNtTe0pw7sPX/3F9mAHIZyzrYgdals=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+zJyHweTVunknijld7zF8Zw+VUnAqKmoQt/k2r+yUcH5TbGs
	jjLB1b/aBZuFF8NrWcC2vlTVJFc9vRYdSDeuVuY9/aEUL1vkL1uIaeLpD2y3mI6P2mQR5OYBGIR
	q921lhfzfVnR4OMlIlaih2hduXe+B4XYI59/pgMmEFt4ExrSole57RsOIoVq0N1xGTtE=
X-Gm-Gg: ASbGncs6A2AwPFpjhtFMxT9FqZQ0VKCgjMD0vDZFEX92CZcDYqevBhMwVxIhJR2yzqC
	N54/wc4yQQxdStKhEFlPXNYHBdtvVnUSGD00S7XLv1QahgHXwauohE6CzKitA69AjBXLF6N73zV
	SHeMjDfTw/DlJuEIZLm0BUGpkCgIfVxXC0VJvkpGjmUF0E6d3esqKM0OVKgTBgZBlaqvxcECnTv
	EruZQFphVCl/tkWN9Fwu0UIZCFuhloMX7h7BFCZ3/n/Nntve/8xzCzYUaoTbpIAoCyEgDQoTnOZ
	jL3M0MeMn+VxONnj4g6YYcyCCYiYW/ofGKwRIVWCQNRLj5V0Mv8CAta5rm1wTPCCuKSKWskA
X-Received: by 2002:a17:903:910:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-290273eddc4mr57353035ad.38.1759942265856;
        Wed, 08 Oct 2025 09:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBnyYw2oUnSj0/vAnQp9qQPbGmtscQ9X7zMVjR7NAsTZxw3H0Mc84Q9Hd7PLjq/ibke+2cdQ==
X-Received: by 2002:a17:903:910:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-290273eddc4mr57352535ad.38.1759942265189;
        Wed, 08 Oct 2025 09:51:05 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36b67sm2086715ad.90.2025.10.08.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:51:04 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:20:58 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, alexandru.elisei@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Check cpu_has_spe() before initializing
 PMSCR_EL1 in VHE
Message-ID: <20251008165058.lcwiapdnar6hvw3b@hu-mojha-hyd.qualcomm.com>
References: <20251007182356.2813920-1-mukesh.ojha@oss.qualcomm.com>
 <aOVckTSJET5ORY1n@linux.dev>
 <861pndzn4w.wl-maz@kernel.org>
 <20251008124040.GC77665@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008124040.GC77665@e132581.arm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfXzlsFw1zTgARO
 GY2udJZF0EaDQ64MQTEBOCGb5KF2T2Mv3pG7OkeND2/lrEZrlkLpD+h1VOEM8nRkPqL0+b6dt0x
 y2+qkVyjgcNOtWLifVBiGmC3ix4oLzuJ8q872+70zn2PszHhqNk6UdTcb+EQ5r29VoLLl2lTuI8
 qVJDevwwBw+A3z0Ua9qR4DDSEX95To5FccobFu7lsPhU+X8w3oE6i8mLoHcIYd+39qbnjsgTC/F
 9PfgLrBUxtx30alKdUxIOvgJ5vSytkOjd45W56sV/8oyitK7xhuB6fMuaNP4e6JoJECwLexmNHB
 EDCOq7kaGXvRqKmiFZ6kUqQixhBtEYv12o2Hq7rTC+45NFuMqiYEsPovzgme/lFCmyicNbKq+BQ
 d0IebZ+2399tgykEogS7dxbG4zU5lQ==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e6967b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=b45o4kL6AAAA:8 a=Rx5nSmygbvK2v2nqR1AA:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-GUID: 7LQ56pXhCN5w9CQxHX9dO7lP7y-nFmh7
X-Proofpoint-ORIG-GUID: 7LQ56pXhCN5w9CQxHX9dO7lP7y-nFmh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On Wed, Oct 08, 2025 at 01:40:40PM +0100, Leo Yan wrote:
> On Wed, Oct 08, 2025 at 11:46:55AM +0100, Marc Zyngier wrote:
> 
> [...]
> 
> > > > Lets guard the change with cpu_has_spe() check so that it only affects
> > > > the cpu which has SPE feature supported.
> > > 
> > > This could benefit from being spelled out a bit more. In both cases we
> > > check for the presence of FEAT_SPE, however I believe the issue you
> > > observe is EL3 hasn't delegated ownership of the Profiling Buffer to
> > > Non-secure nor does it reinject an UNDEF in response to the sysreg trap.
> > > 
> > > I agree that the change is correct but the rationale needs to be clear.
> > 
> > To me, this smells a lot more like some sort of papering over a
> > firmware bug. Why isn't SPE available the first place?
> 
> TF-a grants permission to non-secure world [1], only access from secure
> world or realm will trap to EL3.
> 
> So yes, it would be good to check if any issue in firmware.

We have our own implementation of EL3 and not using TF-A.

I believe, we should check in a similar way as we are doing for nVHE
case.

if (host_data_test_flag(HAS_SPE))
	write_sysreg_el1(0, SYS_PMSCR);

> 
> Thanks,
> Leo
> 
> [1] https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a.git/+/refs/heads/master/lib/extensions/spe/spe.c#52

-- 
-Mukesh Ojha

