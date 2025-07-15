Return-Path: <linux-kernel+bounces-732453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B0B066BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BF01AA4308
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C42BEC20;
	Tue, 15 Jul 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqoYeKB1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC429A9E4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607350; cv=none; b=kv4dbk7GC7yYGzN13Tk7x0gzjIepGEWIKPEDvW75VIeyn/jyxdAoKs5eRNlPp2XHw4AlrbIuHSC5/O9QbPKJQfAw6BK+YnaltppIxcdXAjMQ2Z4ZIOkkeU+olZsRkk4YKaqYbHIXg1OJ+Ic1XGEjoVN1BgA3F01jOfXpRLYA7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607350; c=relaxed/simple;
	bh=19KvyjqMmU2ow8TIsZWBmVsN9hw450pUe9rTmQEBA3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIuUeRifmtPuLQFx+tO0aDaGMzPxNn6BlwQsNooYlV+9ThMjg7lBsEVuuy6l8XuM13Lk8yW4jHd7CU+SiboalMXlLR2Mnb5u56mYAhCQfUBswbGYFrTTqYygPCKF2bWq5Fs7rK0H9lkfP9HIpkC7E20ObN8y0cb+BbzrcPxFTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqoYeKB1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDHc0007394
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zI0oX333gQStniWEomZTauYu
	g/oMZm960vNJLdTExhg=; b=bqoYeKB1hGzW6afVwzAHQbUcOyf3IMDjhWdfH0CR
	a0aJfMWo+p4OuJLhEuUKVuxJM0a97OhTG/hsWqRiNz/2oUGu+DWusCbB78P3Cxe0
	rhPSJLCRkbwuORdiAb+nZrdoTNoQU6pFb/WSRLlvjJqlHm64pjCCe1HXBEbqWWCv
	jaKgHzymBrI9OyJ5fjBkB0vRUoi3o0Zq1xOwARmE8Qq2WWpumazYl9zprk1Q8s2+
	Hv3ju1m99vpaOqUJb795HmnbgUhDMsGrCKqyX7NHHEw4Ki5PPPsW2oB5l+0Cyz1q
	htv1D8sztQNrLHhgfdhnbWXHzOJbKiLNRM+r5HbF32e95Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5sjhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:22:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e095227f5dso558920185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752607347; x=1753212147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI0oX333gQStniWEomZTauYug/oMZm960vNJLdTExhg=;
        b=DcM2MtwZMJcFv+tOx9Kyvwhk+o6KPAYl5boVwWP848AJKI16OJ5qhrdbvWzXeCQlGY
         tdcyUe7WPr7KAJqimfw1gDihccCBnlHb1E+pRBbo6Va6jLpi9ZpOKbnO134wCfcbQZqM
         OS4HMVRFpCY9bVTBjdCJiBVBOPuHX+focVdsTiJM0QUAfMWEd/mLTN2iMie1h6ZaiDUu
         cYTnRyFuugzoVdwqjoj8a4EptbcjwB5OJyHj5lEpVLaWwrB5DIg+nLFg06Q3w81yAXXO
         2DPdHo1e3oGpTeZsPCIFMlbgBv6wvXb9CeLgw6oRpwBAh6W0QOAW8OvDlrM8CWA+vYHv
         D9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8nVfDOPW7ltHwGhEbWsrkePXUnzWRY4x9JFUPGRnurq9gLbPoY/4CAFNDEsUY3Hwfy1rsK2RGiaQXW3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9PFENnFxadC6fIsiOg4ctdkg1GN65vxESWsvfULuyM9vO2Ubr
	NouUucnTMQidiCezAVDlhDNZ4PpHdAwck308iSXbtlAddnUdPR6rPZ51yoXEsURFu0qNYyej1U2
	hU7Yzwa7kmw5k8D2/7I26MGXImO11Kl1k4R4ItxtQYNQIUUDUNrdqMnjd5hkk4pM4+NQ=
X-Gm-Gg: ASbGnctIMJD+/xaH63hxJv2yhVtIm1+bVN+fu+MLHgjSuIRDieF5Vfy3hWIyZ+/JN6J
	g+2SllB2FYe/wwwJZo8PEW7jnI/IFibt2kqbXoxhTLpuNu/VGhdJPUOv/N8rswT2gT2jLDMUVV0
	qmnLK8AVUpkahfU5qX0D5LO18UqDC5a+0R6iTE8r18XR5hDDGzcoMzEW/NBNt9srKAfr9o/wErS
	+Nz2ryYltI3ZCzwJSosXQCisGxKtZVaUXo8Cgr+DtmPPQ0VmwyxKH81sfSjJFq5EstnpSt8dLtS
	2WgUdpkT245Yh3r38mb1twZlgA2cLITFB8yPFcvjrnNzAaoQehD/pmT89S0Ua4tT3psKkO2zf5h
	tm9mMJihkzXZX2zYR26zVrCItkvwf5sks2INAJ3pCl7GxqcVyUUzE
X-Received: by 2002:a05:620a:2992:b0:7d5:d0a1:c907 with SMTP id af79cd13be357-7e342b368a3mr43518285a.30.1752607346980;
        Tue, 15 Jul 2025 12:22:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyvyU8q1VztPYAnznpjtyu7x55IjSjmKm+4cZLhYOyyteqfz9dyaEsAo3ZVngVC3/SzLpLbg==
X-Received: by 2002:a05:620a:2992:b0:7d5:d0a1:c907 with SMTP id af79cd13be357-7e342b368a3mr43513985a.30.1752607346476;
        Tue, 15 Jul 2025 12:22:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a0fe70bccsm1067203e87.30.2025.07.15.12.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 12:22:25 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:22:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arseniy Velikanov <me@adomerle.pw>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Luka Panio <lukapanio@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v1] arm64: dts: qcom: sm8250-xiaomi-pipa: Drop
 nonexistent hardware
Message-ID: <uvw7usijkllom6cox4fkhrxpckqf7gk65b4hn244hpmj62utyt@zlbxwwmj5t6u>
References: <20250715185636.21758-1-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715185636.21758-1-me@adomerle.pw>
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6876aa74 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=9pW74NbYAAAA:8 a=e6LoFHyyGpLHkRjQ_EwA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=67o8LzlnqLyy2xoPAWJp:22
X-Proofpoint-GUID: IvDWDAnqf3nzDFLUOoHt6chU7s31OR_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE3OCBTYWx0ZWRfXyLa1UNKTfyCb
 lFkL0X5AbeUhkJMWXKYbY/zPBVBAlJTitCWwklWtD9JXFa2oXDbhJiROIelyBg4B8pzAMPDpkZg
 aoyVLxdJWh7uEGL1qvrBCsN9jKVXEcqmZCrboaymJfQdoAlZ78E2VM6QRN1Ng5fYsiQvTOZPsIt
 kKZ6qjaO65+U+YHPPzvG7fB6WrgSWlB/X7YVs5dAdCs1FkNS2RyRVh8rVKm49Dk69OQkWg0C0Eg
 Zgs2XnnVUyPLNsHBc9ZRB2VFyrDH11hOO36VJz4ZRDOq6kJbomWwVUX1PEbatcxazbKlu7uoUzT
 HmkgdalMjWjPlJ/2saxYQGdGyPmQ8/5uLaLvxaabJevCNn2Uwm4pNERdsZ+Q5FUudZPUz/yA8pK
 Z0Zhs7wpPRq5RB9JWnJGNG8TTkPJO7zNqUp3ZF/3y5L4Zg16J95Sf9Umf0pjs6ITNTO3aIkP
X-Proofpoint-ORIG-GUID: IvDWDAnqf3nzDFLUOoHt6chU7s31OR_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=874 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150178

On Tue, Jul 15, 2025 at 10:56:36PM +0400, Arseniy Velikanov wrote:
> PM8009 was erroneously added since this device doesn't actually have it.
> It triggers a big critical error at boot, so we're drop it.

Might it be that there are different SKUs?

> 
> Also it looks like the fuel gauge is not connected to the battery,
> it reports nonsense info. Downstream kernel uses pmic fg.

Separate commit, please.

> 
> PMIC fuel-gauge driver uses mixed stats about dual-cell battery,
> so I combined it into one.
> 
> Fixes: 264beb3cbd0d ("arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial device tree")
> 
> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>

Please remove empty line between tags (i.e. between Fixes and SoB).

> ---
>  .../boot/dts/qcom/sm8250-xiaomi-pipa.dts      | 95 +------------------
>  1 file changed, 5 insertions(+), 90 deletions(-)
> 

-- 
With best wishes
Dmitry

