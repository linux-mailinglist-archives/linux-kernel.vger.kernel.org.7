Return-Path: <linux-kernel+bounces-895396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E5FC4DA83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D613AA77D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833CD358D04;
	Tue, 11 Nov 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pOiyXfTS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJ7GEwXi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A535773F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863744; cv=none; b=vGoDUgzGxawp6FC6+KJydeaSdTwQKIiq02MvFubPEdGSsOSKBmfAloIL/4hAGkbkUWOv0Iyp99rP80Sw34eSJRYzaY6vDL6SBNWcywVJsdXR7TCZ9Rr91Yut+yIvp8vLrJY0LliI2ixsO7SCyd00CnO9zyidgWWnKbRQmZObozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863744; c=relaxed/simple;
	bh=uMxXOjJXaWW5Jx0Nm2V04BCLZlkXJIu5lhGx0yBPCag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNjPi9aPyMsXd8OWZWzhrCxW6vkiZ4t+0Eb3034MpRSORVUiUgRFmIl/yNXe1eyMsi7YafCimlIjIlk+B6GqIOOUV8TCNEzT/HqgZBfl4QxaeaKvPIVH9+Cr2AkoxPe3x986D/RxxG0VNRr6yzIpMDCoe0idy+zfU4V1ITyOuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pOiyXfTS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MJ7GEwXi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGYZb2231957
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h8DUvR1H6dSsGWPpCOhKkZ2y
	qS1zJBTq22Qwh3D/TRE=; b=pOiyXfTS4T80C9spBigWSNNHyC+MAApS9mtn03Xr
	TkadIToCC9c01KmX65m9g+1i7iIJ7XfW9dGhcSZcYnyxLl3O9X3LdkHVsrh7xMU1
	mKT3SDO3Fia3ohYjL12Xi4Gb6N6AFiy61zdF6dkptdx8x/Bq3Ni+ouvfXp8ttt3S
	ifhPKNYphh84/LWarDEUabz3e6lQ/vOIS47t1nvuDDsc1h52SLA1Hr+y03uSA2sv
	p4EQLxOKZ4GirWg7KNFjp026XcYwAb4l9ZSPIDFsUnusigwuln7OMX7URPCJauIQ
	qF1rJmJQFyApPTLCvNxSpEB4+bCuPo4XBJwMvR8D8yDQwA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abkwsax6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:22:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecf9548410so116419561cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762863741; x=1763468541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8DUvR1H6dSsGWPpCOhKkZ2yqS1zJBTq22Qwh3D/TRE=;
        b=MJ7GEwXi1L1Ky3brHunRcJH8JSuNMCW5xkWLr35ALoDUD+B0OVD5Min4eE+wv34u95
         7S0oiFxc5xcV8dTqqlZ3OcoCyhBsj0Su/6yYOvI/6ZTv22fZG7hXT9mjGt004F73D0xt
         /gPxGmJYnY7zcdC5JxU1pBV2Hx9UWq6HTQGMbyf96KhzVPUzOYB92Mun44uiUxw/zCEp
         vYIeFsfppx3CTHQynHAjG0uZSL9W3MmtpEKhQjwI73cQ0rxTcrCJZpH7R8BVruLjJK0+
         AwlHFld4K8vcg3aH8OYJ2/bg+vzqY0BwPaBBBkOXBnHSs5tFMEM8eO9D6xGTNHFPHsE3
         Ubsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762863741; x=1763468541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8DUvR1H6dSsGWPpCOhKkZ2yqS1zJBTq22Qwh3D/TRE=;
        b=Cq2H/NJ1vHFyn2oXlAJJmhvRCgfPqtWM68W6OVHRUfcMQSX13YnGq79KY41G2uF0jf
         BwUFqopXMgsESNKhiOX3OXGadUmesE+Zn5uoAvn3KamuQPGe6fDcjhxVeYbJGV9JN6hU
         c8pjo7DYMmguvPE119u6VvjMUEgL/DnNTqbCHz6xAoztG4b6rUtx9ve8ECBS7FNIJnhV
         8AIutbxJY/fwTsKBO7IWnPURug6ppXskjiSf6TbaG4g4lTjG4vWcwLqTY1F5egA7yGpt
         ZrOY96hDnumFunzL8qJAE0KiNHo4YzHopxenT17jXHktSLeG9vO78DYqtxo8qr4R2w3c
         ir/g==
X-Forwarded-Encrypted: i=1; AJvYcCUzZf+rzupM70acuTxS6/JRc67cuWKLqMuSz+e4wRRpLBPu4EsB6qBoO6F5WJiXli+Xe/JvfLdBNqmtm9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwexFBIOEbwTE4l1IX0jww2jfn8PDyev504q0sBh4izAnq7o/Gd
	Zk006nzu+Ud6PNplBcUtqR4OMFot1t9rRPjcNVzHYNVL8SVNqgEtY/b6OqlQFdFUc89vC6w3XV1
	/cB9NtAlnrFwYM13ksyNPtffyNNy3jxx8y2XErcAo5TcAMY3kuxiaj+XAB5wrG0is7mM=
X-Gm-Gg: ASbGncu2ZTw7CbrtHkJYjMRWmgbJpLqxMMB4UnXB13uyfX0+TwLwN9ydL430pi2ulWC
	D6MsrXaeo+sJnGcC9i5e1RXOvvSaj/V2y9uovdFsfX5QlXaygOf3gfZKHCwpCC+4aG+AzB8VRnv
	0ssbN8EV3Lmbu52dvSA2FVpZzkLQxKZEiCzSlUbo8dAyt/9uwDstxPWDQeRsttusTDEMFK7k1ul
	YrhhtVDyCPSoU5TezzKq9R5yVoNsYwYCtgea3yg2+ufcVuTmsIfwJEIu5rb1EAs3CfV1exkOU5z
	NdoRG9mVmq6bNwSw6RDcGwfwkiY6sxQ8UUSFdRNeX2Hqd5DNoKSEq2aEX4dzlQxvrHEFCaaXd8E
	jigxRljqyIsPyUHpfLH6GhmfRLzwRLzBiJ7WycU8WvMsoQK5b9YRqErbc/Pp2J8p8qFjpUOfs8m
	BB/AGFI/IuMsqU
X-Received: by 2002:ac8:5808:0:b0:4ed:b06b:d6a5 with SMTP id d75a77b69052e-4edb06be774mr109131221cf.4.1762863740897;
        Tue, 11 Nov 2025 04:22:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqlE6SPjHtKXlVAFeEPtooYjb0zreq0QgU5VB8K6LLCKt/01Nkgp4mrx5FBdtNHHl5wrpKww==
X-Received: by 2002:ac8:5808:0:b0:4ed:b06b:d6a5 with SMTP id d75a77b69052e-4edb06be774mr109130881cf.4.1762863740423;
        Tue, 11 Nov 2025 04:22:20 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a019f8fsm4832974e87.33.2025.11.11.04.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:22:19 -0800 (PST)
Date: Tue, 11 Nov 2025 14:22:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        hrishabh.rajput@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 1/2] firmware: qcom: scm: Register gunyah watchdog
 device
Message-ID: <zbwcg5pkdspkcnvaitac6y5iko346qyuzuipqhkoedcaqm2dpa@zmszuwhm5q7z>
References: <20251107-gunyah_watchdog-v5-0-4c6e3fb6eb17@oss.qualcomm.com>
 <20251107-gunyah_watchdog-v5-1-4c6e3fb6eb17@oss.qualcomm.com>
 <hbxtbaoavlsw7pbmg3cfkbyx4nacjfiikckhqgpvlggbh6hu5b@jyporqecfzni>
 <263d1390-eff5-4846-b2c2-31f96fc3248e@quicinc.com>
 <3794bb0e-5e2c-4d5e-8d81-d302fa36677c@quicinc.com>
 <56aqammkwte3tcdzni2unufjp4t4yaqazzdkigrwqsxp3ghcqe@ppe2pjwg3hrl>
 <60583236-692f-4605-9f56-f7dadb46558d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60583236-692f-4605-9f56-f7dadb46558d@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5OCBTYWx0ZWRfX6L4wHRVOzd48
 k1oZGQIzKUbYaAvu3Ia1MIhs1Gr5Tvp60toRIfn2di2r/daXzbsTQIwN/sYiH82DN+1QCxbX5GG
 CZy0lSZ+Dzdhg+1G3lmwPHiyhWAGwtYykxUzh2SwHbVj8gR4bBmiP9S7LcscAPvDxnBZZ0wmnfW
 5mwzg9Rs842FCCcmZvdtoikKS5plRYTVadj2sa24r8FBlJSPvJ6mZAr3vpbtq1GSOAr20qMTWLe
 Z1bMdzOfXnfU3yJy96eu3smt2mm1biSo9wptG7aFpolZGrFEHWUhF2g01zpf5iC1EKKUuMRUdsL
 iWVAa/iKCRZBZ53KENH6Kpmqsgtq1/G4X1jLBMpOiR1/f6cY3OcV79LBP7THmYkSu+uoWkDA34M
 0KKQT8vF55JexCaNOmBcOWzT2VVX1A==
X-Authority-Analysis: v=2.4 cv=Vosuwu2n c=1 sm=1 tr=0 ts=69132a7d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mhC3O9B1GX6jFu3mhFkA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: BuD-z16oFaoC6d9nW95vGoZa4hzY6mwD
X-Proofpoint-ORIG-GUID: BuD-z16oFaoC6d9nW95vGoZa4hzY6mwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110098

On Tue, Nov 11, 2025 at 11:41:51AM +0100, Krzysztof Kozlowski wrote:
> On 11/11/2025 11:34, Dmitry Baryshkov wrote:
> > On Tue, Nov 11, 2025 at 10:51:43AM +0530, Pavan Kondeti wrote:
> >> On Mon, Nov 10, 2025 at 09:43:53AM +0530, Pavan Kondeti wrote:
> >>> On Sat, Nov 08, 2025 at 07:26:46PM +0200, Dmitry Baryshkov wrote:
> >>>>> +static void qcom_scm_gunyah_wdt_free(void *data)
> >>>>> +{
> >>>>> +	struct platform_device *gunyah_wdt_dev = data;
> >>>>> +
> >>>>> +	platform_device_unregister(gunyah_wdt_dev);
> >>>>> +}
> >>>>> +
> >>>>> +static void qcom_scm_gunyah_wdt_init(struct qcom_scm *scm)
> >>>>> +{
> >>>>> +	struct platform_device *gunyah_wdt_dev;
> >>>>> +	struct device_node *np;
> >>>>> +	bool of_wdt_available;
> >>>>> +	int i;
> >>>>> +	uuid_t gunyah_uuid = UUID_INIT(0xc1d58fcd, 0xa453, 0x5fdb, 0x92, 0x65,
> >>>>
> >>>> static const?
> >>>>
> >>>>> +				       0xce, 0x36, 0x67, 0x3d, 0x5f, 0x14);
> >>>>> +	static const char * const of_wdt_compatible[] = {
> >>>>> +		"qcom,kpss-wdt",
> >>>>> +		"arm,sbsa-gwdt",
> >>>>> +	};
> >>>>> +
> >>>>> +	/* Bail out if we are not running under Gunyah */
> >>>>> +	if (!arm_smccc_hypervisor_has_uuid(&gunyah_uuid))
> >>>>> +		return;
> >>>>
> >>>> This rquires 'select HAVE_ARM_SMCCC_DISCOVERY'
> >>>>
> >>>
> >>> Probably `depends on HAVE_ARM_SMCCC_DISCOVERY` is correct here.
> >>>
> >>
> >> Dmitry / Bjorn,
> >>
> >> We are debating on this internally on how to resolve this dependency
> >>
> >> - QCOM_SCM depends on HAVE_ARM_SMCCC_DISCOVERY which means restricting
> >>   QCOM_SCM compilation than what it is today.
> >>
> >> - Adding #ifdefry around arm_smccc_hypervisor_has_uuid usage in qcom scm driver 
> >>
> >> - Adding stub for `arm_smccc_hypervisor_has_uuid()` which is not done
> >>   for any of the functions defined in drivers/firmware/smccc/smccc.c
> >>
> >> We are trending towards the first option above. Please let us know if
> >> you think otherwise.
> > 
> > The same as before: 'select HAVE_ARM_SMCCC_DISCOVERY'.
> 
> HAVE_ARM_SMCCC_DISCOVERY has a dependency which is not always selected
> (e.g. ARM32), thus selecting it might lead to warnings of unmet
> dependencies.

Then `if (!IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY))` might be a good
option here (and depend on GICv3 selecting it).

> Whichever they choose here, they need to be sure to
> actually compile test it, because existing patch lacks that and reports
> are proving lack of building.
> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

