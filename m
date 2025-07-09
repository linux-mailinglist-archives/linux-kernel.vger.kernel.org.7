Return-Path: <linux-kernel+bounces-723573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1760DAFE8A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19823AEE67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8C2D9EC7;
	Wed,  9 Jul 2025 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XK0LFGIg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9105277C82
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062983; cv=none; b=qJuNzknym0viSxK60W4ReXIGbOIw6MJ+UspCdHW91/UHe5RELGT4HmmtCOhlwH0W6wTn3ylDhwGgzad8oXREu0F8CssgUYCXePXm5hrqiG4nq8T4IsinSIsNqyUD7nUHNcn7L89ZXwkrFEpB0ONEwpJIGcP0uMuOj2G+LKs3q8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062983; c=relaxed/simple;
	bh=vWjnsHaFdY57vSv5iKmGhETY4L2tSuUWtXsAYrevCaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJ5AMXskEhlCVck5H4qTZGih+HmmJAOA7b76rG/A/fkuhKZoaBepicUek6E7i0HgICN6ycKhKvBLRx9y4hQBQTyl22EE6w1xKkqJlpKMbKMDWbkZ4W2V1xML+IvLEBSr09V1p5ZRaJ0c8qnnBBkl2XvhWhsGd0jd8TBgEjKfszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XK0LFGIg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5697grYf004557
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 12:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GzAznaWmjvDBxr0Q3tW6ieQZBTpTt1BwUiW915blvK8=; b=XK0LFGIgeCIC6qbe
	HEYJm5Cjmmu9I7sT6QLpk91tlYapcdArHKQ5hGXt21y5fsG8s0uqIeBkRZKKIJwg
	2qNTZMSCW0pNZv8+z2E1zcU0gl9fMn+pHZvB4Cthp3atR2sI3sYXOYmUI9/8AW73
	Afc3q6P5wb+NX3coayjBm5p1V951ZuDB5+87AVAlmSHfWtY1WXxd2HjE28msz1pI
	hCwUwE0pfhFsoEh6gk7uIsoQNLF6rxGAeiRdbMhQT67PxCUI2bDe5FHeStI4mdTT
	Jik6wYfBH9trLGPTJPc2Q27ljmZPTR6vPleZFqxhdjKZpkhdHGIO5sbG0yf0+zHq
	Lv1NRA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9drw8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:09:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b34fa832869so740168a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752062979; x=1752667779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzAznaWmjvDBxr0Q3tW6ieQZBTpTt1BwUiW915blvK8=;
        b=U3SNeVu6uWv33ycOUq2OyblkU1EMEAiJKjEzLThOziqc4CbfCq23BXSvCUgPCTNP0Y
         PBw2V64uaYTzu0RKSxkJSof/wvQhrs0tbH+QjkDHImWNB2dZujIZj14hXUnlGp9snluC
         K5O820VkIHaZTEXib54WgZzvM1x5sX3gK8ZnQpLUOgawyTuOvDt686eb2WaseVyu2Roy
         aiDBCqFudp4c70f28tGhXlpnXEvtz28D50l+sG0hdxZ2n3eFFJ+U4EDcvfHYzU8bw+9w
         MCTHQMaeW/2BQXOrNdFpK45+u6DtbU0qGhuRMcSugxhPcJE84pW3GHESvYJPamsWKrhm
         c5+g==
X-Forwarded-Encrypted: i=1; AJvYcCVVgt82DpSss9gRLsgbkK95tSY6cQwu1h1OeLLCDEfxLSwI2EX6Zr4HuwDTF6KlAReqCqmaCQyMvoDSPpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9otBTyBBJK37rjHUtk5FE5HDe+9AASwDybRgytiFacR71bt3z
	g6K31Y4DSaeMoDQP7YL9vGA3mVlZ2fyOndDWlDM5Fos5QYbL11g+J3LsAQmwo3GsXtg4d9Ayipg
	unrfK1VDhhTlJtQcqF8uA96TpQlkTqK3YAC05t8YAY+hYH1iQzfrTpxIM+iUp/Gh/Enk=
X-Gm-Gg: ASbGncutVMFF3WtoYwt+sZ1rBC4X58gHNszj0U//DXPBLrvQtvkvuMeyHwpWN/LSjON
	g8/TZqLZ4GwUtHQ3lZUWTbTE4ppRY6folF275TjyQrLnL92tQgWNeKKLQVhmU7fuVoCZQooA7GO
	+EWqDmxBgvO0wNiGL1j+2KX9bwm0b2V8p/T1kiIYsdaKyPVOOGSekZIPjbTC7jvWWaZFB41OBzX
	EzF+YPeQEo+dbvYe8w68im2wbpFpJUDHxat4KxqrOANcykZRqCRBhzlLv7fpD+/jzW+PVghyE3m
	rBaEmLnitStex/zJu1zSSQqiPRocEZiVSvKKMXI0uz8xCpg7YZPh
X-Received: by 2002:a17:902:ef47:b0:236:15b7:62e3 with SMTP id d9443c01a7336-23ddb586dbdmr30688715ad.9.1752062979178;
        Wed, 09 Jul 2025 05:09:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5CmuLtJ9EVCj5EH3hN0FC/CSxne9G31njh1b728ZlbRWZpXih/MgtxmqEpMqJxZ6THKsVA==
X-Received: by 2002:a17:902:ef47:b0:236:15b7:62e3 with SMTP id d9443c01a7336-23ddb586dbdmr30688305ad.9.1752062978696;
        Wed, 09 Jul 2025 05:09:38 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e9d6sm144191025ad.151.2025.07.09.05.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:09:38 -0700 (PDT)
Message-ID: <5625ffa1-f952-4646-a17a-fbbfffcdba2a@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 17:39:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] bus: mhi: host: Add support to read MHI
 capabilities
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-3-3faa8fe92b05@qti.qualcomm.com>
 <ttjbjmixxbzatcfthaucuy3j4hosu4azpizes6ptxjnkzsawa5@5axodfdyjff2>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ttjbjmixxbzatcfthaucuy3j4hosu4azpizes6ptxjnkzsawa5@5axodfdyjff2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5NVlzKoeKFUGTIxXoleZ75BKvIJ3b3vt
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=686e5c04 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=wBt9fhMRhOodALO6grUA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5NVlzKoeKFUGTIxXoleZ75BKvIJ3b3vt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEwOCBTYWx0ZWRfXwCIwTIE9/gW0
 Zv2cd9Js1MLrANGbm2o17EMB5o1B3p9xi3uOLb9k3WW8Mxo415bRmvJ5YJc1e8rU9FHBV/sq2DL
 45jaslOSB3LBgI197QYNQTnIR8L6Y5a75+j0Dr+baGPsJxZ7hIAL0CON+N96TDZUt5YH0INzWal
 /B5IFZLKLHHCT21FKqiNs1+YvtfgSg4qQtZKtujMp798DgJMy6Sx4PDTgYghwdFoiyG2UqrhBYt
 zpiTxQdIf/dS4nLBOxhVkIs7ra71CGI4ahsUwxNojPF/hLVHh/VgK8n0TZu8Po2XGyXRei2WJin
 hVD0bcfYpYE1W/Ofs8K+wNEaKVeCowKHHhxzVh/Uqbxm1Vvv8JudqdBTeJTXf5Ek7pCfmukSX0D
 c8qDht9pQlLTQzBgXEpnnTbsKil+OI2Mm+KdXBfVj+eSerUPWeL0hXQSrM3HsgiMcgw3pHLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090108



On 7/8/2025 10:06 PM, Manivannan Sadhasivam wrote:
> On Mon, Jun 09, 2025 at 04:21:24PM GMT, Krishna Chaitanya Chundru wrote:
>> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>
>> As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
>> located after the ERDB array. The location of this group of registers is
>> indicated by the MISCOFF register. Each capability has a capability ID to
>> determine which functionality is supported and each capability will point
>> to the next capability supported.
>>
>> Add a basic function to read those capabilities offsets.
>>
>> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/common.h    | 13 +++++++++++++
>>   drivers/bus/mhi/host/init.c | 34 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>> index dda340aaed95a5573a2ec776ca712e11a1ed0b52..58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd 100644
>> --- a/drivers/bus/mhi/common.h
>> +++ b/drivers/bus/mhi/common.h
>> @@ -16,6 +16,7 @@
>>   #define MHICFG				0x10
>>   #define CHDBOFF				0x18
>>   #define ERDBOFF				0x20
>> +#define MISCOFF				0x24
>>   #define BHIOFF				0x28
>>   #define BHIEOFF				0x2c
>>   #define DEBUGOFF			0x30
>> @@ -113,6 +114,9 @@
>>   #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
>>   #define MHISTATUS_SYSERR_MASK		BIT(2)
>>   #define MHISTATUS_READY_MASK		BIT(0)
>> +#define MISC_CAP_MASK			GENMASK(31, 0)
>> +#define CAP_CAPID_MASK			GENMASK(31, 24)
>> +#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
>>   
>>   /* Command Ring Element macros */
>>   /* No operation command */
>> @@ -204,6 +208,15 @@
>>   #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
>>   							       MHI_PKT_TYPE_COALESCING))
>>   
>> +enum mhi_capability_type {
>> +	MHI_CAP_ID_INTX = 0x1,
>> +	MHI_CAP_ID_TIME_SYNC = 0x2,
>> +	MHI_CAP_ID_BW_SCALE = 0x3,
>> +	MHI_CAP_ID_TSC_TIME_SYNC = 0x4,
>> +	MHI_CAP_ID_MAX_TRB_LEN = 0x5,
>> +	MHI_CAP_ID_MAX,
>> +};
>> +
>>   enum mhi_pkt_type {
>>   	MHI_PKT_TYPE_INVALID = 0x0,
>>   	MHI_PKT_TYPE_NOOP_CMD = 0x1,
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index 13e7a55f54ff45b83b3f18b97e2cdd83d4836fe3..9102ce13a2059f599b46d25ef631f643142642be 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -467,6 +467,40 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>>   	return ret;
>>   }
>>   
>> +static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability, u32 *offset)
>> +{
>> +	u32 val, cur_cap, next_offset;
>> +	int ret;
>> +
>> +	/* Get the first supported capability offset */
>> +	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF, MISC_CAP_MASK, offset);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*offset = (__force u32)le32_to_cpu(*offset);
> 
> Why do you need __force attribute? What does it suppress? Is it because the
> pointer is not le32?
> 
yes to suppress warnings.

- Krishna Chaitanya.
> - Mani
> 
>> +	do {
>> +		if (*offset >= mhi_cntrl->reg_len)
>> +			return -ENXIO;
>> +
>> +		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		val = (__force u32)le32_to_cpu(val);
>> +		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
>> +		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
>> +		if (cur_cap >= MHI_CAP_ID_MAX)
>> +			return -ENXIO;
>> +
>> +		if (cur_cap == capability)
>> +			return 0;
>> +
>> +		*offset = next_offset;
>> +	} while (next_offset);
>> +
>> +	return -ENXIO;
>> +}
>> +
>>   int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>   {
>>   	u32 val;
>>
>> -- 
>> 2.34.1
>>
> 

