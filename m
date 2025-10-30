Return-Path: <linux-kernel+bounces-878854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A12FC219D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3EBE4F1BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E461F4CB7;
	Thu, 30 Oct 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eQq+vxVU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wp3fz8V4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4B36CA7C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846995; cv=none; b=LAGNESO+8W0TJCET7/AaFBSU2aGH3E46P5EbtbdBQBiJoWjwSiJfZuyNZxLLeChO1iAbFCGKWh3lsPgS7ZISJ3cMHKiHe7L7e3g6NsQR6HTHZ4o0kMB9Yj5tDmOsKLpOjO50gaS5L5XgZvNAuRK+WxPsg4PlT87YcskSpMLEvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846995; c=relaxed/simple;
	bh=3Dt/rlrRqj6N/1r4mQm0gKfab49hbWWWCK2mMOdP1Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYEL+9YsM248m98vc3fh2GGRWRYU2MB95hvD6Ert+EkxDJ98Slcimo44vQrGKqYluWNn0K/YP12kukD3L/11QVFp7IsKDDmeDYLcZ7n+ej9qJLRHTzGoI3CHpaWBZ8S5pujsCM9lezxGcdz6UEQKnY23RZt7OpBIa91KTG0+N70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eQq+vxVU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wp3fz8V4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UAPNuk3281504
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vehAa8y1JkGkskeznsNK9Kcw3sMCXaLIMhNgGP3BvL8=; b=eQq+vxVUNgrL78u5
	UB3aruuKZ326V4FXkcCLNMBEtp4ZykYoEQ41ZVMkNoDs92lK/z+VM+xSMwLBnoPX
	Z25We6SQ3MhP5zb+U6w8Xx8Kn4ZhgIkFo3wRzGOyK71EYKbz/8hc0DH2rINQz0JL
	YFrbxun3WpfKmzknP4Ra4DgZc/Hq4ODsOKUSp20XepAOPd6dO/1Ibv95JNSdMnD5
	pGyWq544m2A1Z1iycbLQ5PzXOAil/JvGHxycNxu/UUmLXv9Zx7ZT7I8KdHy6AqCe
	kfKxv9coApxd0yHsCBFVBB7yj7vlgPrxU4WYejl75FSSORvZsbMpCZpNEdv/gtMq
	8TZh7A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a468kh8kw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:56:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eb7853480dso35097201cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761846991; x=1762451791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vehAa8y1JkGkskeznsNK9Kcw3sMCXaLIMhNgGP3BvL8=;
        b=Wp3fz8V4XCHinGlF1iKieRVOnD2rYu7RBqkR4bwwxljnDJDGhkh/c3BglRpAb0Zhwr
         1l+rEiw5DjFcDFiTAwAHJ+4siAaEorGu6dvdFt+j5cJqP/H4wxF+DaN2KJFxp7QfTZBo
         eQ5vIf0oGXfZWMER3NbawMQ3TAwbU7JxHrCCNL5J1Q6HOJ131PPMEDHXvHLV2Fk9Bntg
         QBSZ2vWypd2K/dRItv9EWpAZ92bmVioCPlOkcocj2KjqcHBeWvajQ/r5s+QpC6m13jUa
         ZypJJu9fjI4vgySB+Gh7Wevd6mOwWgo7Qsov3rZtuB9ubU/wQXeeYsMhCBKHozqdf4Rn
         Jl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846991; x=1762451791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vehAa8y1JkGkskeznsNK9Kcw3sMCXaLIMhNgGP3BvL8=;
        b=BJq138wuLW1vdAUDOkGFKSQ3S7lBmt9EDJPGyVaqkgp6gB3vyFIlPaTKFhFU/zmVxw
         6OFodeeWc9VNFuOUDPgakW/HMERpdu7E0yi+r/n3xhAr9wsmC7HDW7/c67svNrtwfb3r
         gNPYG9cY+KGrut6X6BE6PEfqNZT3H5Rgt3nPJq8sWHb6L7KYsAH9zbSaWBRuhBs6NToq
         pJ+g166D4Rim+AceJDt4XQaZDM6yCV6nD8Pth9/RatesgbJj2yPHfoSf2ke5HQV+5kBN
         1vNLyD1Aqby5JdPsziYbMdcUkqHoLXSl8/PagG9zNExQ+q3yNzv9mViW6Xah2cqTn73Q
         ZkeA==
X-Forwarded-Encrypted: i=1; AJvYcCXBhPpgkHJd8Zsc4VfREA+JK2ug94v+bXak2OZwyro91sP2ngMiGRPKIPF0s3AzAOAcIJ+v1qReAXUrxFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN03b/AOnwLm9T96ItTjeyml+0Xpv9EgrwyLtgE4p38pSOBcJt
	KpyI7/wRmEh7iYYmI48fNC5XRR7ReyOILMJuSclqwKGLp+8vI34WKqbhOBrCSaVSNaS5ehtqwzF
	cnpdvNlTYlpGWMF0TEOs6fe/ADLnNiwYBrVeI8zJKPwZS5no8zzxIsmRjbjsraJis71M=
X-Gm-Gg: ASbGnctbK27O1iFvf4hMe4IDic0raBeYmjGWSL4jgPC0rhripLEtQri+CskcdHMVPdo
	eRtrYRsB+cK/L/hZSUIe4nyTMf+p5BGsQrKysOW4VRhne0m4Tec9tT5+Oexmr8eEH4qbJkmKISW
	U+F6qiyyhs0/yc09w9Rl5GDTUgYMLPHW2dM3wmbKAn73xK7jM+A2GBM3tcNtKAK0OHbuQciKlBv
	YqW3eN4g2NcQzJbtpsNU0I17kqyHZKnluuXEZqduD/zD5nj4mjOEVMXX08Xf8Dc+DlLjg9hJ8jE
	WBaQCez+gs43AVxi8lc6AhUMMYQtSNEHMtVqVs4pIxWpZ/pFlSDwpL6iFc7rGPcmrUujSugM0P+
	uDv1N/kKdakElu8gy2GHTV7WBVVbkYdbC4h4zRJMz4Dj1zhwzuQXUr2XWIN188A+O7YIyVfJa/W
	s6mn7leYloRpJ8
X-Received: by 2002:a05:622a:5909:b0:4eb:a4fc:6095 with SMTP id d75a77b69052e-4ed31079258mr7180781cf.68.1761846991182;
        Thu, 30 Oct 2025 10:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1gTOZ9j/WQ4KYwl8p6DGINz2A+gvzkJGhTk6NeUfZTCXk3lRg0VzU9uLbO9XlJIFNowmF4w==
X-Received: by 2002:a05:622a:5909:b0:4eb:a4fc:6095 with SMTP id d75a77b69052e-4ed31079258mr7180431cf.68.1761846990617;
        Thu, 30 Oct 2025 10:56:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37907dd2312sm20061201fa.37.2025.10.30.10.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:56:29 -0700 (PDT)
Date: Thu, 30 Oct 2025 19:56:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jesszhan0024@gmail.com, quic_rajeevny@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <abhinavk@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC/WIP 0/4] arm64: dts: qcom: sm8750: Enable display
Message-ID: <gbcy2uegaf5xdpsgwby3m7sj3pwahjboykfh6bxachsvabvhad@m6dbgxnigp7d>
References: <20250424-sm8750-display-dts-v1-0-6fb22ca95f38@linaro.org>
 <w6f3s56gx7psqgweuntqvkzrot7elhc5pdrxhvenukzwyt5eys@fndmaszfbo5k>
 <921afe20-42b1-4999-b5c4-035669dc831e@linaro.org>
 <32eb3b4f-b2c4-4895-8b48-ade319fd83de@oss.qualcomm.com>
 <CAO9ioeWdJpKfpu3jGyv42Mf5+02ehxyEu_Lj+Boz0NyDjPZ-CQ@mail.gmail.com>
 <58a658bb-7338-442f-ad8c-845b5fa5ce00@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58a658bb-7338-442f-ad8c-845b5fa5ce00@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0OCBTYWx0ZWRfX0fdex+eLQ0xv
 wYpcb12Np5tMSTx5JnvIDicStdWi/5hms5BICn8P8X9V7MkN25vhsbj77lCMc0ap9WUI+1g5M/T
 jYIJt59SW6D/unQMKWQCUuxkzPzcWiPiXAmN9F29OOjJ/pDupo1SGEqsL43f/3oCJCgZUKb0+Vo
 dQIEG5Zuf7lyhFJm2WaSSdn7qPXWOlJ1Vd7nOnrhUhm1BFT/lPOAcoWlUgN7oNTBYGkJhg2PyWQ
 9O4Sp5bUew/dL1bYfsLNshzrTXx+RYNadADEV+d2gLbpM0bIiWnrcBMhPh1Dfbsz9mtRBz8+miy
 kjhEXIMykkzlMAMVeceiFbP4UIlrfBKvAso7mv3RqL8jsBUM7nYOJtl8/57YPqOKXC+0NcSglfV
 mtnombEm+1tcd66y/gYgTsJP/Nlh5g==
X-Proofpoint-ORIG-GUID: bDvQEZmuxcvYTe2KCA9I_-VIoAExul_e
X-Authority-Analysis: v=2.4 cv=LoWfC3dc c=1 sm=1 tr=0 ts=6903a6cf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-oEtJe5RtmD9yeKdI3YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: bDvQEZmuxcvYTe2KCA9I_-VIoAExul_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300148

On Thu, Oct 30, 2025 at 05:51:02PM +0530, Mahadevan P wrote:
> Hi Dmitry/Krzysztof,
> 
> On 10/30/2025 4:46 PM, Dmitry Baryshkov wrote:
> > Hi Mahadevan,
> > 
> > On Wed, 29 Oct 2025 at 08:20, Mahadevan P <mahadevan.p@oss.qualcomm.com> wrote:
> > > 
> > > Hi Krzysztof,
> > > 
> > > On 4/26/2025 1:24 AM, Krzysztof Kozlowski wrote:
> > > 
> > > On 25/04/2025 21:34, Dmitry Baryshkov wrote:
> > > 
> > > On Thu, Apr 24, 2025 at 03:04:24PM +0200, Krzysztof Kozlowski wrote:
> > 
> > Could you please fix your email client to _never_ send HTML emails.
> > You've destroyed all the quoting (quotation?) levels. Your email was
> > caught by the automatic mailing list filters, etc.
> 
> Thank you for your feedback and I've updated my email client settings to
> ensure only plain text is sent going forward.
> 
> > 
> > > We at Qualcomm are currently working on bringing up the DSI display on MTP. For this, I’ve picked the following patches on top of v6.18-rc2:
> > > 
> > > All the DT changes mentioned in this series
> > > [PATCH v2] drm/msm/dpu: Fix adjusted mode clock check for 3d merge
> > > https://lore.kernel.org/all/1154f275-f934-46ae-950a-209d31463525@kernel.org/
> > > [PATCH v2 0/2] drm/panel: Add Novatek NT37801 panel driver
> > > https://lore.kernel.org/all/20250508-sm8750-display-panel-v2-0-3ca072e3d1fa@linaro.org/
> > > 
> > > However, when testing with modetest, the panel appears blank. I wanted to check if there are any additional patches already posted that I might have missed and should be included.
> > 
> > Any errors or warnings in dmesg?
> 
> There were no errors seen. only panel was not lighting up. Got unblocked and
> able to validated modetest on DSI and working fine with this workaround on
> linux-next
> https://lore.kernel.org
> all/20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com/

Broken link. Just to point out, this patch is NAKed.

> 
> > 
> > > 
> > > Also, I’m curious to understand more about the DSI PHY PLL VCO rate issue that Jessica had narrowed down—could you please share some details?
> > > 
> > > Lastly, I’d appreciate it if you could share the plan for merging these changes upstream. We’re aiming to enable display support on this target as part of our program.
> > 
> > Please see Documentation/process/, I think it describes the process of
> > merging patches pretty well.
> 
> Sorry for any confusion in my previous message. Could you please share when
> we might expect the next non-RFC version of this series, specifically for
> the DSI enablement patch? Alternatively, if there are no immediate plans to
> post an updated version, would it be acceptable for us to take it forward
> and submit the subsequent non-RFC versions of the MDSS and DSI enablement
> device tree patches by adding dependency to this https://lore.kernel.org
> all/20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com/.
> 
> > 
> Thanks,
> Mahadevan

-- 
With best wishes
Dmitry

