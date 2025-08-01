Return-Path: <linux-kernel+bounces-753349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455DB181CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0BB1C8250C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101E2441B8;
	Fri,  1 Aug 2025 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DG4aGNX4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB83246BB4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051370; cv=none; b=tkLbgjfdup/g3pverb2obaejEDjcMXyjxU4Y9u9hhbwHvlR9nK9juO359bkYo9699xwLTlz5YRU5OFKY+Isn4MdV5NI45U51oRFGLbXBRtRmQhjNd8F+zB7utdlzMvKpakRiLESSFMy6md/1PVK1QPlKk6m+kgkd0QCDr+H0AI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051370; c=relaxed/simple;
	bh=pbgmwZNtT9CA0LQIliQlAyv2/lGfNw6LSRHwP4f+Qk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGkGL4KGfiGVVfidtWu8sY0xb3uA0dUTtxDpmNVIGKehiSvU58tjgasbihCNHX9SoKWRXyBzSd8n3Ms0h+KbOjSInhtDansAEW2eN5dL3YJdgHrgthS27PnUlAs3tBXevUVX7l+x5Y9oH6bMgN7+dcTFLNNGXj9ikk8KmSWf19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DG4aGNX4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718jkRS025585
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 12:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbgmwZNtT9CA0LQIliQlAyv2/lGfNw6LSRHwP4f+Qk8=; b=DG4aGNX4Hj0+cJfv
	3JiaQaXNzbMw+9bwSd/f60HYG/b6B7+MdZOE2Jmw4o4XEh7bVtiJXKmhqdVZlRvA
	3I8+lEokl5CB1gjPu15zjfrzQfAk2MBu3AFcH8npxSDPpYLbSzsHSxaDcYyQfaF9
	JAxwPr+lLxxxuDdTzQeq8V7hv7sDmB3jJsIIFbP7edWpV8W3gSuOGHKJem5AxxXQ
	MiA/MXyzN9SvMRI5D09mOgunp9g+nyx5zszCb9IHFtgIj0s311qvIzYxMf9bcBeL
	RuWjhgbn+ZDnJ/yt2WFcTIiuaLx5A2TurJvmynT3blWIEHkgcFrITPxHxFsfjCdH
	IVRqwg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48887g48t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 12:29:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab65611676so6253041cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 05:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754051366; x=1754656166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbgmwZNtT9CA0LQIliQlAyv2/lGfNw6LSRHwP4f+Qk8=;
        b=W8KJSXJRRTtINkoyYSgZkFbMQcCE8SjimiG5Jg8k+fWPHfTs6mP2wEolsls9y2RIKS
         OSiyH6dsQUnRlJTnpSzu0BFCmy1SODqOZzUSzGz7vQ2EEe8Mli1FXwWQlt+9crh1w9sZ
         h2hvAh17Hwqv0lA5h9we0p++xUaYKo5uNlVzGqXyO5gToSAaF357TwQYmMOCVNfjiueA
         Nl+xnGNeWDKPfi4sxjVsbAWAcn0RDkpfiZg4qbKyhpJjRy52S/Tu3wGNivqr8UnIrhkG
         7uVedc6d8r1tmt9v982R5722hJTxNFlF8YpmjY2vQsXa06SYLuucwz8r8b18vQUADLav
         Y0ew==
X-Forwarded-Encrypted: i=1; AJvYcCVeagb3EJa89kCxLyx44qILuAUZXG6QQ8ox7zNcIjHNU44DZH+XZPZTJl1AcZJzZF2Tp+TS6MVYVJYDrvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoHukHCFxR7bmtLXTzv6BecAtsagICTvC6ofEOdNbSinqrfSi
	jB26GblpH3kchcnxJ2lccJy50lE9Cmc957MfAi42J8qrx5AfWzpMHg4wGqxv8ClB93edxjrLdrL
	+/u3bDuyleHDZfjqm5vgPoy1N3IfkRVZDY9yurCZaImYHzajqt3er6+r8hymYVlThaUY=
X-Gm-Gg: ASbGncsYRdmdurbFyqGMaNca60Ofk7/zlZ2UcSOhUDAa77xclqh46WaoyqI36gQ7/M2
	0UgtvtuMaoBrBhwJmLU6bH41cS1Q0xHCMJLrnm9BhbGC1jpDfsHGMNP4qFYfpOsizy/O8OcW4vK
	aZnlcuubuTuZwsuYR0bgiIUsdWSM9jkiNy0QRrJqBQgPlwG13op+nFD7sxj6GmP60LaOQUYxxs7
	79K8pkKNVlb9VXQWUCIijURsZxm2c+SgfWHlYAhltleaAP4B/gwlReVe5DZixizzQIJgbY8gyHg
	oc6W5tuwt8jPflSBacz4Y5poK2kNmP+jd9FZEdPN7MH9JwUerULoxlSaAfD5SsPdBZ4V4plVAfi
	q3WeLGtMT6TVNpRt+rw==
X-Received: by 2002:ac8:5705:0:b0:4ab:5d26:db88 with SMTP id d75a77b69052e-4aedb94316emr87971031cf.3.1754051366253;
        Fri, 01 Aug 2025 05:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8q92C2Wo6neQzzml5bgsNfb0UtuzxKP8kk0JsYE01X/PsK4FmcyVYqJWR7viitVa/ixIFrA==
X-Received: by 2002:ac8:5705:0:b0:4ab:5d26:db88 with SMTP id d75a77b69052e-4aedb94316emr87970691cf.3.1754051365732;
        Fri, 01 Aug 2025 05:29:25 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c06bsm280116566b.119.2025.08.01.05.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 05:29:25 -0700 (PDT)
Message-ID: <0cf8f99c-a64b-43c4-a747-d5dd6fe28996@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 14:29:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280xp: Add initial support for
 Ntmer TW220
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: aliceryhl@google.com, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, ebiggers@google.com,
        ilpo.jarvinen@linux.intel.com, joel.granados@kernel.org,
        konradybcio@kernel.org, krzk+dt@kernel.org, len.brown@intel.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lossin@kernel.org, mingo@kernel.org, ojeda@kernel.org, robh@kernel.org,
        sfr@canb.auug.org.au, vanyang@smail.nju.edu.cn,
        viro@zeniv.linux.org.uk
References: <de111b27-9126-4c03-a7bb-8cce9ea2780e@oss.qualcomm.com>
 <20250706034303.5404-1-mitltlatltl@gmail.com>
 <f2f0f25b-40b0-452c-ad9e-01b84b32e163@oss.qualcomm.com>
 <CAH2e8h6XWAz-pqmuvzK8JqOb=ggiDGb2U3TvAR2+43D_zdsZpQ@mail.gmail.com>
 <9efafa16-e6db-4227-9b47-5803f5933a7d@oss.qualcomm.com>
 <CAH2e8h5Eov+827X3W_EZSHRoaUHgP119fXJA+WEUdmdJ6f3gkg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAH2e8h5Eov+827X3W_EZSHRoaUHgP119fXJA+WEUdmdJ6f3gkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vdn3PEp9 c=1 sm=1 tr=0 ts=688cb327 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=78uhRy8ZE0Nw9m-UYXkA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Yn5SWrAtVy17wy-TeO_cVKN6r_O7xoz0
X-Proofpoint-GUID: Yn5SWrAtVy17wy-TeO_cVKN6r_O7xoz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA5MiBTYWx0ZWRfX3lUP6mSeFlSt
 iZWOA26vRwmATCjV8cWRehTkC0hUaPE6YorToRITjPjdaSr7e/PVX2iq8MYwVcx/QoUTpE2+RgS
 QKbXTRO+RqluvQDYHGjsmqz8vX7NKnycNyx13/fwr99Uuq9O2jU4GpPpry+CiKLJ4uYDp/J41Ba
 zNcBvW7Le9Y3P3ICi+6H8qm/c+UAx26WHvJCdcYEMtIDDd7r1G+kGDKwxB8nBRtCcFYw35nfB6N
 oKMV9fKhAwKey9IXwfWKq1nE1mYQzQvJiWHcXRzcCCW2g9ovkB0/gq6DpZ7dojzdhhK0PtJu3b+
 89DlWoOZ1zw0673ciJGrue1APbqbp8DKO5D71aLM+YD4frt7DuaL5mpPgUUY754VOqAH53X6g3Z
 Lb1uBfJEsmhg8vcM0gauQXf52dGBXeBXWHFyF+8xC9MzRDGDHdnEUa6+5D9jpm8EE68czypa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010092

On 7/31/25 5:05 AM, Pengyu Luo wrote:
> Linux:
>> ae94000 20050001 000001f3 0000000b dddd1011
>> ae94010 00009130 31211101 3e2e1e0e 00001900
>> ae94020 00000000 05190019 064c000c 065f0528
>> ae94030 00060000 00000000 00040000 14000000
>> ae94040 06100006 00003c2c 00001000 00000008
> Windows:
>> ae94000 20050001 000001f7 00000008 00001010
>> ae94010 00009130 31211101 3e2e1e0e 00001900
>> ae94020 00000000 05320032 064c000c 065f0551
>> ae94030 000c0000 00000000 00040000 14000000
>> ae94040 00100008 00013c2c 9bb9b000 00000004

0xae94008 differs, bits 0 and 1 say that the cmd mode engine
is busy doing something (did you set MIPI_DSI_MODE_VIDEO?)

0xae94024 says:
Linux:
ACTIVE_H_END=1305
ACTIVE_H_START=25
Windows:
ACTIVE_H_END=1330
ACTIVE_H_START=50

0xae9402c:
Linux:
VTOTAL=1631
HTOTAL=1320
Windows:
VTOTAL=1631
HTOTAL=1361

0xae94030:
Linux:
HS_END=6
Windows:
HS_END=12

0xae94040:
Linux:
RGB565 (16 bpp)
bits 25/26 are "set RGB888 for DSI1 stream"
Windows:
RGB888 (24 bpp)

(suggesting your panel driver is wrong)

0xae94044:
you may want to move the

/* Always insert DCS command */
data |= DSI_CMD_CFG1_INSERT_DCS_COMMAND;
dsi_write(msm_host, REG_DSI_CMD_CFG1, data);

in dsi_host.c out of the if (!video), not sure if it's correct
but that's what Windows seems to be setting

The other differences are due to the current DCS command(s) being
processed


Hope this helps

Konrad

