Return-Path: <linux-kernel+bounces-892347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CAC44E64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 249604E6117
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17DD272E45;
	Mon, 10 Nov 2025 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pmQud2Is";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brZtqK2t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA4243376
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762748043; cv=none; b=gaaT9A4zN2Z66kOtHaLr+U5yO+2DB6dDy6zZU7awqC6oYLlrjIPQBdWCEduMYubh/KGgccsv6r7Y9qRmQefb3wku+IxPGdPifviZtLbjPLXOKyMxWsDxqX7YxJpAbIXmNITq4zkCH9pPpOfVUe7Ae5GoZ31Ld7oKw9oxqp8V94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762748043; c=relaxed/simple;
	bh=OvMIL+Ag7ao+WlmXilMCYV3oFt3WYL+b4oSFg7J9BrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGGNra71jNml4LAULYgQOeiUe1TtkgnbzBXidb7OxqzsxpvZo+ahhc4cJvKwWK1TmBq63ul4GhtvV4/gh/FIiX1JnQROs2kYe1tOmRfnjn7kvZo3NUirIWgs95iszQDotoa4c5vFjh+0xIfSIhilc4H9wyq1YWENy9iRouWXT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pmQud2Is; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brZtqK2t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA0XGRJ1809057
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=63Ba7zBrKoiAWfSOSCfa4uld
	py/JAKEBPUMVKa6S/Es=; b=pmQud2IsyJ6DYawFZ2q2ryuvuOploLX0UuLFG/LW
	ZVeLDF7PypHqPjgpgFTFPG+OLf+0ck9VkRP6bYasoj9oZ60qH/r07cKGMO+OPF5Z
	aw842KDcatU2CaoLRYS29YhnrkzuaWz604Fbr/BBpfpWRRnOjOZsQL7GlHOH32n+
	nAqadAjO5gWqn8Pnplkr3Yx+pZHw18rbyynGESLjejNbB8NhZFg2znuHJyhl+sG6
	I2aCrGrGKwifnNotkvuMkatb1Ss+la/7MAUGo5YvAEwtnr6Il6ObHFkWd3Sdm+NI
	WOJMbNtnnmIZm+L3jWRctqcGVOEJs/RvAsfsIshmsjohIg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1gerf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:14:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34385d7c4a7so878364a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 20:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762748040; x=1763352840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63Ba7zBrKoiAWfSOSCfa4uldpy/JAKEBPUMVKa6S/Es=;
        b=brZtqK2tI9dnUw4e0B17aEqXjttyzPjoobTe2R+HIm/epkvu9+NZZIseGJIjGrDomA
         qpEIjDPMYDqe/VdO/pOA12XnS7p1LKo4YIDwrwzANxYVDr7UWErZ7p4VAjwLEl/P597V
         rCkUFKfaI2Whn2VCSq2xixBnVpNPrf/efeR4DDCsx8ykWOBRnyt/mE2++3Z2lvgbGd0c
         f68B0BmgR2mV2h87WdZSUdadg8/95jk9KB+LQbm+rQ7hWQ31KuXmPWREyzBDj0U/CARU
         LOhACW/RZt7e/Fwpb11ToZI1A5MRdln8IGTPFeG7Zne8Novpdt0WMQcAEoTzo4aUp7tT
         WFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762748040; x=1763352840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63Ba7zBrKoiAWfSOSCfa4uldpy/JAKEBPUMVKa6S/Es=;
        b=SJhlpz84rZarRgMZaKe7Pb2FgHXkg3H4XwLZTSInDwKdRU2iDnCUghXEZiR7J23G0/
         jXnmrU+VcRlPZKRkxjoE2Gf0uvxGs4W5uuwGLttqKISupkBrQC1L/vEd/PrFyDSmG8E2
         o3geqYdEFpSyBtVuzdClytMywdC10h3LDUZ3qDJ6sKbBEq0WNS2p28gBovGC7dTBH6Vq
         qaZLip9SE0fA9mJLncSlvwHbhcxdM/Cp3m1UeuqdCBXuIlNid3bLDgmnavF0OLkxNXUB
         qmVBoOtKofMXOrBieOWS2c1bG+WaZweq2tECPXSyM1GqWsB4EUMNo/kq0kpH5sc5hiES
         3UFA==
X-Forwarded-Encrypted: i=1; AJvYcCXkhaDTtRDmh9p78emnK3X+2fw6QCYwcHjVwoRbH7xwR5QDMfqQ0Zgs7zToflFITEtIfWaGib+7umkPlEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzign41pb5dRylNPTlzPpqphs6Qu33L5A9k/0/J5okf0nUUVb7+
	bysk2x2WaSzQvXUrlJEuEBLobH393CqF3y9KgTs/jGBbOL510m3EsmNxq54u1clFNDNSmbeluPn
	x6w88owhDXkKB1qb/VuO/nVVF5fE/E52CSHWpbm6ZrU45NORjIkOzfyJ6jbBrRJN9bjI=
X-Gm-Gg: ASbGncv8mIFFaBBLOdhD40jbg2VanCIfpk5D5HI4/yJgMvpTuZG5tr6igr9OgPk0E20
	mOPZ/EmN5vwKI0IKBoxYYNjXAOoG1lK3NletdpZH8h56gRCGcej8Wj65w6+Y3iivFhG/bKYiXBQ
	D49HdWvbsA+rycJj1yw45QWtbVUHE9xX7uMOe8E7CJS+pEN3gIE3myhVy07aLpEfq+IWzPUQC9Z
	FIInUPt/Sc9etYtt013pwiN9Dzcp2BEuZcP/YdxXMHMw0KQD+f6Bc0sQK37ZheWzanFISLQgr7u
	jzYHIKbWPSTSA+8CxDdDvAdtnWS1Jloj1uLy8j8C9oJExA24zXCHbiWjg8lN7F7+OnHCM1PqBaH
	3Cia83XuivNF1kdh96LnfV9Hsf0juAzUm
X-Received: by 2002:a17:90b:3f85:b0:343:6a63:85d5 with SMTP id 98e67ed59e1d1-3436accd340mr8908381a91.16.1762748040212;
        Sun, 09 Nov 2025 20:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTZ3wFWABMsdQEIncQiC52zmOKq5UOdMUvgom5QS8xesVHXQPctEzv5PL538yn87n1udFPDQ==
X-Received: by 2002:a17:90b:3f85:b0:343:6a63:85d5 with SMTP id 98e67ed59e1d1-3436accd340mr8908348a91.16.1762748039722;
        Sun, 09 Nov 2025 20:13:59 -0800 (PST)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9635007sm10178757b3a.2.2025.11.09.20.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 20:13:59 -0800 (PST)
Date: Mon, 10 Nov 2025 09:43:53 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: hrishabh.rajput@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 1/2] firmware: qcom: scm: Register gunyah watchdog
 device
Message-ID: <263d1390-eff5-4846-b2c2-31f96fc3248e@quicinc.com>
References: <20251107-gunyah_watchdog-v5-0-4c6e3fb6eb17@oss.qualcomm.com>
 <20251107-gunyah_watchdog-v5-1-4c6e3fb6eb17@oss.qualcomm.com>
 <hbxtbaoavlsw7pbmg3cfkbyx4nacjfiikckhqgpvlggbh6hu5b@jyporqecfzni>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hbxtbaoavlsw7pbmg3cfkbyx4nacjfiikckhqgpvlggbh6hu5b@jyporqecfzni>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDAzMyBTYWx0ZWRfXxYQkzZYsCMIu
 6bZzdouJ8ayIyQ/hxDykqvLhGwhd4uFinM7S3VPN+GojQ6EjRmcGhHvfzYdNTIY/0YNcQvnnSer
 1oaVZbv/B8pjO3PJ4RRUp0qgs7Wp6UV+K5UawalcGVuKA3IJTuXIaPj81XcVj+unoJ/UBRq2fCO
 228cQUvN5OsEYzyxej/hRsF6XQ6r495Bo/1a/6PdL4YVngb1+ZP8H6RO+UlhTuDCLG3Du525BRL
 IEziAX+NTkOckqgWrZxkQJDZ3gIQ7snSGxqq0GvOKClDqr9euwPFQ9F8CUcp6/VUQPxT3iES6TG
 v4pzxJCnMtO4Q6au56Jo5jrOj9wQypSzXLkggwhNdo1BV0sWTTmpv/EzYiMPOh1OVOXzpsVpLNK
 bUTe0S8FVRbUzKYBSLhPdBeqoN6uOg==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=69116688 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=5liKcR6gdwzQ9ZU9jv4A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: WeUvzAx9zDQbYsq-oLyFphlfvwoVHjb-
X-Proofpoint-GUID: WeUvzAx9zDQbYsq-oLyFphlfvwoVHjb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100033

On Sat, Nov 08, 2025 at 07:26:46PM +0200, Dmitry Baryshkov wrote:
> > +static void qcom_scm_gunyah_wdt_free(void *data)
> > +{
> > +	struct platform_device *gunyah_wdt_dev = data;
> > +
> > +	platform_device_unregister(gunyah_wdt_dev);
> > +}
> > +
> > +static void qcom_scm_gunyah_wdt_init(struct qcom_scm *scm)
> > +{
> > +	struct platform_device *gunyah_wdt_dev;
> > +	struct device_node *np;
> > +	bool of_wdt_available;
> > +	int i;
> > +	uuid_t gunyah_uuid = UUID_INIT(0xc1d58fcd, 0xa453, 0x5fdb, 0x92, 0x65,
> 
> static const?
> 
> > +				       0xce, 0x36, 0x67, 0x3d, 0x5f, 0x14);
> > +	static const char * const of_wdt_compatible[] = {
> > +		"qcom,kpss-wdt",
> > +		"arm,sbsa-gwdt",
> > +	};
> > +
> > +	/* Bail out if we are not running under Gunyah */
> > +	if (!arm_smccc_hypervisor_has_uuid(&gunyah_uuid))
> > +		return;
> 
> This rquires 'select HAVE_ARM_SMCCC_DISCOVERY'
> 

Probably `depends on HAVE_ARM_SMCCC_DISCOVERY` is correct here.

Thanks,
Pavan

