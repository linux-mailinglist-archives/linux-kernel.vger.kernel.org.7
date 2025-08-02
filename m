Return-Path: <linux-kernel+bounces-754236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C9B19054
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 00:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8539A17ACC4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAE27AC3C;
	Sat,  2 Aug 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aeMnVJPp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286DF2CCDB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754173443; cv=none; b=q5ER408Dn2I+BaPLpy6uyNOS76UabmByy9ep0ptOujLocQRJD5iFHg5nwhnifZcZYiRNZ0B6tuf0gkNuHjAp4Yy5UGIOPpenVB+hqFZWHPmYEyIHWcMJj8PFjzQhdXqVrtUt1mjyJR8GzuKFEduhCzoTgNcHyh3MfWAlnNriSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754173443; c=relaxed/simple;
	bh=m0iEYRjcdnU65R3FMXTSoPGOUxzRvVQB9ercshE0cqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqnh5RCYUCSQ7WnPek8FUhsG92LtksCAachHWCMu2tgXNPqoy+VxaZwfYE3KeBjSA+VYiPQSD8OtEg5JPjjrUsarOh7W6CIV246sWXbEcAZn2ZRCv/ZLg1tMOUte9jraMujCD5C34a/JWaJ+OjeqeikoW6PrHk5pss+gX2yXVVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aeMnVJPp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 572LCw6r022997
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 22:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xl0OxxNA7ca072iJm6M/zPG6
	jGGT3ai/1U553419los=; b=aeMnVJPpOqTPR3I2WDmw51lqLpvUV2fYhyARPtzJ
	SBY2x5WNIE57zCPGcVper6imusSo8jxDorgVgWeJX/aCGimBRqOdNIqF+WBI6uq2
	6nHGncnFUryddtwt3fyA80U5I6LqtoW6pHJfOWSFjzspVoEbk2xGx1GPQgOxl4WY
	fvF8d7J2RFihfDNHah1LU2RCO3LBGxZVFpnZ4OB7fu6ItVyTwTZnLt17G3F5BPe0
	+rVzOdk9X/GFYA4poaOBg6Lrdk5V9Ism/2L0LX+2heAaaBLpTMa5zcFH6vKbCh3+
	GU5sp+rKsLgR8ph1MVvu97s7OnDKIPp7fR1C9fHarRMeYg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjhkvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 22:24:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4aeb8b6acd1so39653501cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 15:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754173440; x=1754778240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl0OxxNA7ca072iJm6M/zPG6jGGT3ai/1U553419los=;
        b=Z9UJ4Bqxx6vjDL4OkL22M/sz1QyS8AWXn38SWrHSSExcH56oZaUnD6wroPi62Biaoo
         Fk/JVOEPgE2apB8aEtrvoQXwopbqinsiVO6dl6loaKDkQ9GVoQ8Cf6caHJ6gwYYeAQrT
         e+WS3WDOOhyuJVbTcBdPJTDZbuJCXHsnMImPMb8pNnwueMvlInF2E1zo2CZjZnu79SUH
         z3+uHlsxbccf5tvTITgVhTu+L6HQSAsUx8BZg08bwLMpQ+kFn8ClKU28vePnFGb2kb6Y
         SlbB48L7ZaH/HyQx4PpImvaoURrlH3WQRAEiZtBzjvILPpMKoZpQ2fkeGekvq5hHILaz
         ebdw==
X-Forwarded-Encrypted: i=1; AJvYcCUlXmXZpC/uppSG2VNZ87x0+IdrryzpSymlr7gJgZt8J+4qujgGz7vGKnRkA29+t3T9Hw116Z7pmygWujM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlTvMziOWTnE3hwB4nGF4Lb+eqk6CSICiovJs0xCz1Rf7NlVZ+
	Odc4tOyU/Brmx413bRFqP4ZA1ZXZ/QlopMKFPbM/kCHSyM+w7Clzmt5/vUCL5J8R7XLAXGj+2sX
	rbFYiM/hcVYjD1QMaFJJjyRrrK6dL773smHAEp4KXxUaTD6fKDGw3QrWbgk6F3KBPk2Y=
X-Gm-Gg: ASbGncuvngqMfb6nBGFHPPUtMCuUew7mBKzb/PPn1t0QmTzncewPu4ZpHiNSaH7wMbL
	pAoR3IoRMLKHYVA7LrLhfbJwU8ZHtvA0Lg7x+iDMM3ndr1cpHkjJryTL218ihAbJxBQqK+fLOJu
	AElLK/IACRNsFny6X6IKL04616nljfxKfWjM0Qq6W/tZTF1oMaTDFfksHxsF6vyOUdQ93qZVLOB
	Z9db+bO0bMhhTB9MdUssPrb7Q0zKGHKSnFHELy6UFfngJyLnXqb/csNOjoeM1eEkMzjyMX34yKV
	Ghme6NL+QJvGYSEGV66Dpb87DsNYG8bD9c2XIW9go6voEQ4+mixu1hbZr/bnZOLqCZyLFeRNrIT
	D2uYnbGYv/18Wh/Eh6nqmOBy8KeW4uHmgHewBUnYlw3IU7FPcLqqk
X-Received: by 2002:a05:622a:2614:b0:4a4:2c4c:ccb3 with SMTP id d75a77b69052e-4af10a4a6f8mr71115881cf.38.1754173439768;
        Sat, 02 Aug 2025 15:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrRsxcmSymm/iOQUBWA1JUQnU1xwsXzPXR9p1T+dpkt3Av38hBwrNFCZmoKC0DXjNEzzqClg==
X-Received: by 2002:a05:622a:2614:b0:4a4:2c4c:ccb3 with SMTP id d75a77b69052e-4af10a4a6f8mr71115661cf.38.1754173439390;
        Sat, 02 Aug 2025 15:23:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca6776sm1105446e87.141.2025.08.02.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 15:23:58 -0700 (PDT)
Date: Sun, 3 Aug 2025 01:23:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, jie.qiu@mediatek.com, junzhi.zhao@mediatek.com,
        dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        dmitry.baryshkov@linaro.org, lewis.liao@mediatek.com,
        ives.chenjh@mediatek.com, tommyyl.chen@mediatek.com,
        jason-jh.lin@mediatek.com
Subject: Re: [PATCH v9 00/23] Add support for MT8195/88 HDMIv2 and DDCv2
Message-ID: <2eq5je6xk4ly5lxijit3ufor7pmm7mgivbuigzr35lrbe2ryvr@3axnsyabigm7>
References: <20250415104321.51149-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415104321.51149-1-angelogioacchino.delregno@collabora.com>
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=688e9001 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=k3YYP44_YlkhweOvE2wA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: rJoV-H1Q0fDS_gh8Xvp6qtp8apAkcJd9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDE4MyBTYWx0ZWRfX59tfrvXR+XOb
 vG7y9GUd+UXDUDorjTFCXM+IIUX91Q5lTErwiCIsWhDgn+onMy5RVcvVlK8g4LAbx+l+wycKpJr
 O6xKV/m4m58klgahPWrKXgVEKIX3bV+C4Jdv/ehvxrpd8HYJzAJC52r5hMKE7P5C4ud5SmILJeh
 mOQ1ZlJhNmDEvLg7BhP/hIo//ZXrO51siJRreMEULM/f7miuJ/c3UUyvtpb8iutu1U85O9J/KYo
 h9QOlSsquyO9TeLDdfg4ODbz0TVffMasKG1Em+UBLZXpov2eryr+q/XdDCXdlIqz/eQjchBZeZP
 7k+1BN2pR0tu894HSIlOFu7tVlyb8q6KRizZLHgtf7VOzzDKsABeg1vArLUaZ8wTGuIbXHIRPtF
 ut1tT3tKPRjmBPNx6y2TgFzwjw/SGecKeKDP2shJb/g3/IWwsWCz15Jr156HvOeaDYpavJlY
X-Proofpoint-GUID: rJoV-H1Q0fDS_gh8Xvp6qtp8apAkcJd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-02_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=691 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508020183

On Tue, Apr 15, 2025 at 12:42:58PM +0200, AngeloGioacchino Del Regno wrote:
> 
> This series adds support for the HDMI-TX v2 Encoder and DDCv2, and for
> the direct connection DPI as found in MT8195, MT8188 and their variants.

Angelo, just wanted to check, what is the fate of this series? I think
it wasn't updated since April. It was a really good example of utilizing
the HDMI framework(s). Wink.

> 

-- 
With best wishes
Dmitry

