Return-Path: <linux-kernel+bounces-826990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D47B8FD4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA454E18C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA926E715;
	Mon, 22 Sep 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXKZRq/9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35311185
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534442; cv=none; b=QbneQdW1YCzXKs26vNZO8kpPLtfTH+Y2b4wx9qdL3glSS4YilbNvHouSiMF4qgLGT7KTNc53Jew+Tgezgieqj+veXPMv/2s+LkZSC2Ten44OLWd7/ElB1wInSRVoORWHgXoEUaXrVHt4NHp2hy92xt6MwsGeF9lJL+d9faL1voA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534442; c=relaxed/simple;
	bh=iUm7WYS7P/wtRO0KyVFWy2NmCc/VczuVuNk9FQ+1J0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9+TTUglbtR8aJlf71GdSc5aT3uykgjPOseEowDNjzN19nwamJp0ozN+YkGB1z3iKJJb8AdU1TN7FU85G1CVQkbjbVOxDAq4mmyXqZkirJjtRNfTxnORuFK797Ofkq4udrgyz85/vSzhYVBG35Bv2kLS16sch1Qr476+HXjy+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXKZRq/9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7p62d005727
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7YluqLjFkeDBsYKSBhPJwBbp0COj/3zoNrL6kINO3I8=; b=pXKZRq/9CE6rRZBi
	Jky4PBi9rEiRdx/UtJ49BKRg39I3qn6KPqZ7JbDsFC+VZ5u7i96zjwhIbWjnyQJw
	OKsskdpkAPiWwJHqpK9W45VCgi4gIRGtbVgyDRaDxLwxnr5WAq+nRDZGKl8EeASH
	92AWXuxGg6RRhILFrJ1caqk5iyvkZ2PgVam+dVTzcPEsXwVe4bUhInEGxOHLoVdR
	VmGbjCkCkPnH+/ksnlrW22jnvtqDPm+Rfzp89mL3AfjDsEnmYC/5C77WAgu1LmOi
	ASjDpqPWKy7lis9fVDzCdoD0iX+5MrkGNfx8xG9xY2miUqdr4soYidhBHd7YcbBD
	U3pDaw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b2e10e2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:47:20 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-54a798b3508so4362999e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534439; x=1759139239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YluqLjFkeDBsYKSBhPJwBbp0COj/3zoNrL6kINO3I8=;
        b=oCSJ+whYiyLuiznOHRlD1hErpcuOD5k6+rwXcYtVGOLEpFKduwOUSjQXDDqOpF/Jjc
         35eUghvyoGzwAjIphd/468O9XUZKQCKA7L6eItvW/iK0d9ZTgu8uhzh4CCABIaMGCKs7
         EWpamQgEI5s0EFN+MJZhXQl0Q38beVK1WO3Wffj5hn/VhTcMYN+ZNB5AbAFNb+IKvtUj
         v2aeUF1J92FNgissWVdV+/47ezVUcw6Sf3OhgVRQ6eLlMLOtPIkVwvkI+KwqZD7JxF1b
         Ru6OOXN3MXoW5k9/6yojNNo//ITCipQEYxzQ9Q00c/Hpvd32LosZLobXiWdSjOKA6Mbi
         uLLw==
X-Forwarded-Encrypted: i=1; AJvYcCXFO7VrdltwcPB+CS7SRYWAVTK9R9oO6AGzniJ+uhbjnjlIa8UNTnpu3pR+rSpLca2MiL6DLdE99YZvlYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWgFLf0GHCLHQhfROCGq/M++F1sf5mh1IMGtY1PGpfSTS556h
	t5ton3v4QWhy9AMApWt+kiGSmOTIyfYFf+vWlYq2yusnge0f/L1R4JwLOMRUBw44xbRbNuXEd9q
	HgAJJxn19B3wSikU6zUMZ8szhd1hAL8AWnZfvlHRqmU6q6DkYsDpGJD4E97AQHczvXQU=
X-Gm-Gg: ASbGncsa1exW0uvXoVFdHVOtAguq0Rvg/IbKktFGCP7AKKTua2XkcQ5/VIcHLOL2WID
	b+DiW1JLECnh858MrbE7MS2jACrN4XxGo1TqiwjC6artIrDhpzraTroK5n9zldb64e1WU4evd1B
	MdnmbuR7Wj8LlQDVR8Kk11jEHuTPyZ50M+4yQFUnVp3cLodzSAZnm9QzvdP56SppT3fPvk9H4Ql
	kWhwJ7YO6MFZ1AIvXFcfF6cM49aTCvrF3f1mQpMIvWCUao8+PFO7d/GSUfF+GL3WGI+zfz/9IL2
	02Rpl4chtm1RrSihJ9+45Opje1myBbXQ7loT6S9JY0rHtI3nvUso+4F6zUflp8fDHg9RmHI4CPt
	3qwkdPNoYSJloPCH4I/yRPrQHe48dql3D2bPkQ5B7LBNR65ji/Z8/
X-Received: by 2002:a05:622a:3cb:b0:4bd:8a70:8419 with SMTP id d75a77b69052e-4c0740771efmr132175781cf.49.1758534006513;
        Mon, 22 Sep 2025 02:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHPdl7qbXwWAyMzAb2xrKkqm9pTpnhem1oin/ZkSbUrYmV5Vp09P9ycfD9quaP9yIYnQ94uw==
X-Received: by 2002:a05:622a:3cb:b0:4bd:8a70:8419 with SMTP id d75a77b69052e-4c0740771efmr132175461cf.49.1758534005900;
        Mon, 22 Sep 2025 02:40:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875b8dsm981204e87.2.2025.09.22.02.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:40:05 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:40:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v5 05/14] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
Message-ID: <ysxjabaah6rcbsjlreteo32zdljjcd547vgqeoxototwicjj74@rwovxeg6rnli>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-5-eae6681f4002@oss.qualcomm.com>
 <z3phuuokrhonbukct2siz3ujear5ymtnoviea2epxzvjdmsvkj@w4puf4c44tmk>
 <83b5a265-1c5f-49f5-a89e-22f466df3304@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83b5a265-1c5f-49f5-a89e-22f466df3304@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA3NiBTYWx0ZWRfX7ouQmnqJOXQZ
 s9mGoD4mqpK8n5VEgre5i6tv76QBbFUc3naLVqCBjBTd6AEma3NNiqtSiZMaDzeVRuz5oJPVa9H
 p7apvUV0Q7tnSnSYJGtGw7vsvc7JBDz746Uy0u+zNf43aixD6pfVXJiAE4gfF4UPyufnn32ofQ7
 TTZPkEpSlY5J4W59JajWv1N9U44SVxp3luagARNop1y3pM9WY84HQNnj1rGDkW+GU/inPL5ssvb
 D+Bh+hB7GRJR+VwB3dT1g5p/SYL7Tx9l2Ol3GEEYxHZ1iv7vd2X09L+7uovhFFnBivSEOHybMYY
 NHaPr5J3LavrsVcLL2hVSOGeOP2v8TmGLOrpkUzNWGIXk71Kd2Wh9isCpumuMfAUq9wRwadyebi
 OFFCCaVD
X-Proofpoint-ORIG-GUID: vn35JZ-cyqC33zJG5Fz6sLuJjcGyoK5p
X-Authority-Analysis: v=2.4 cv=HM7DFptv c=1 sm=1 tr=0 ts=68d11b28 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=zhdrUoIqCuD_tm7jGOwA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: vn35JZ-cyqC33zJG5Fz6sLuJjcGyoK5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220076

On Mon, Sep 22, 2025 at 04:04:42PM +0800, Xiangxu Yin wrote:
> 
> On 9/20/2025 12:45 AM, Dmitry Baryshkov wrote:
> > On Fri, Sep 19, 2025 at 10:24:22PM +0800, Xiangxu Yin wrote:
> >> Move resets to qmp_phy_cfg for per-PHY customization. Keep legacy DT
> >> path on the old hardcoded list; non-legacy path uses cfg->reset_list.
> > Why? Start your commit messages with the description of the issue that
> > you are trying to solve.
> 
> 
> The original reset list only works for USB-only PHYs. USB3DP PHYs need different
> reset names like "dp_phy", so they use a separate list. Moving resets to
> qmp_phy_cfg enables per-PHY config without special-case logic in DT parsing.
> I will update commit msg with issue description.
> 
> Or do you suggest using (offs->dp_serdes != 0) to choose the reset list instead
> using new attributes?

You can't because othe DP PHYs supported by this driver will use 3
resets: phy, phy_phy and dp_phy.

> 
> 
> >> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >> ---
> >>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 18 +++++++++++++++---
> >>  1 file changed, 15 insertions(+), 3 deletions(-)
> >>

-- 
With best wishes
Dmitry

