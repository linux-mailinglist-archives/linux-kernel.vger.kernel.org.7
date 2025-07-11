Return-Path: <linux-kernel+bounces-727015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461BAB013EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CD23AC5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E21E0E08;
	Fri, 11 Jul 2025 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y9jGpgGG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90C1C84A1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216943; cv=none; b=NErQ/g8DfDkp5pmaBzasJy+/239CaGU39CXV/pjwBddY1ukAYxeIOmZzkCNimM7veeY24nuPrqYkU1q7La9Du9GPu4wCLK0FSUcHRsu1XOGmoLV+EpB3P/EmUipRrTYMCZ0Z2n45yfCeWtFwWfKAEBsfAM9do3oz2QrEfY9KE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216943; c=relaxed/simple;
	bh=KHLiODgNoFGc7Bij6J+62xV9mCNesSkcn3xJQu8lw1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOqVRFIUXJLbaJmWi05ZcNT2S1v2h8SSP3wJH+Q6BVlAqz3mCcsqBf5Qc6r20NiYDF1fVAjJ2sMAdCQzlpA+lGHKtEER2oLinI9ROfcmjygZp8N7o5qTSrN6hYZVi9GCAaE3fR692p9rCZJ/b4xap5dxH0YGtHwxxv/iMDhE2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y9jGpgGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X73F021743
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	daKF+ZJohzkAu1nVmYWvaZdsv/dnrgP3xwdI5e4aoWM=; b=Y9jGpgGGn258UZih
	YaGTYAob/UI505vhvuxU30dchHvwc69A4m8h7+lxmVd6GcFCmrs8faKmScUTlCB1
	3IDdoReTRXxxf8ZUYBDq6ZkjSSDiKFuPJpy4JWHnueHXaBvr+k7zHwQnuPcbUZHC
	CMVtIjmJsJnsWRobDd+wi/W0dr58khJr/lj5AOwQTRekBh5Hvx5uWuujbodfTjIA
	BtPfOnRrZs9aHXAbUxFDGz94ZfYWjT8v5wxAAKpycusq+Ry9DTObGdPvgaJ15lst
	tRyNr3uBXfAJE258+DB2PHwvxCXgze/EzRdxEJ7W+959V5bosvyM+ohBCI/Wazvd
	oC184A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b18jfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:55:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748fd21468cso1612691b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752216939; x=1752821739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daKF+ZJohzkAu1nVmYWvaZdsv/dnrgP3xwdI5e4aoWM=;
        b=hORCZnxl2Mr/LkHcQVdv03zwIjadBhClTTMhQ+9vA4/5jnmryXFdUCb6XFmL0Z0vnD
         S3pdL1ad0ObS66/GWOnCkbruubJJoHmrNEQ6bOUOf5yPoOR/S+BK/+b1/fKZZFbsRf8D
         FTnoXxtYjoqaj5qrZ+onecWUG18j8kgsqyUc/3aIUi8Ccz4vtfN1dc8pwBpNKH0JcAe0
         dmFKQXrUIlIsYzZFKQGJmqOq0/jkmCwZF5mHOhXilyHKDqHlX+GalTviyXBlvJ1xQzmM
         OjIZMg0jOCWq+M2jVAkrE3FEPwfX1QHQ8CCigRxMMXHMfD2DpzETiHaiogJAXAXOW5Zl
         yJNw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2uL3IrCLLpxre0ip4NpxnOcVspdgYuZlqc5kKX8yVv3Z+Wcn8gneY6RslxtSU51wHSN+hoiRl99/U4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgeUCiGUpY44uSskC/i/fv0MmojACMlnUVpHMp1J4t0lN/gfjr
	xOk1O1j5C8HBkwPZpzGGSPc32/+pSHZQsf99rB3OMPIwMBD5MY0lmLkOiOa9AsEHhkx5nG15MJW
	AIEsQ0gdijujMGS0vZuyEFdfL2OwTMxr2f0sDlYnEY9VN0KxHleO4TTfoZNvuclmc3z4=
X-Gm-Gg: ASbGncv8c0lyeMuDJmyNMSfdzgeHfm6oeQ6h4OLpzsUC4+u85cYSfgo/wvyqmnlR7m9
	bU/72aHG+0wz8c4Z3QORambbWyvacCErmhgNvlUr0re5jE/650HA1cZLpT1blLg6USYAtvH1oy9
	YjWid8wEOmvnGAHRQ8aBDgvaLIfZ8kqJU58JjuGPW0FZfwjqm551CknyPesFTqtxgg8qEn3Ydrj
	ASSeshuqZsgHslGyW4Yp4M3H375XxxJNhV01YgWgnCKcm7v/h8ZR8bQwL0sIKgAFOgCuCQJaWUb
	8RLxn+95J9WLn1rBSpCv4wcFFY6einCUP7ZSASXPD30mwnZuTuzQ+h5CbAcaLiOT5oSb
X-Received: by 2002:a05:6a20:7285:b0:220:eef:e8f0 with SMTP id adf61e73a8af0-2317faac08bmr2077201637.23.1752216938508;
        Thu, 10 Jul 2025 23:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvx99ckOFzIt2b/aGXlLiGnhtRJUfcIxw9pMJpUMfqnkg1F/jhqzFLC0Er4yYqvNDPnebDuw==
X-Received: by 2002:a05:6a20:7285:b0:220:eef:e8f0 with SMTP id adf61e73a8af0-2317faac08bmr2077141637.23.1752216937927;
        Thu, 10 Jul 2025 23:55:37 -0700 (PDT)
Received: from [10.92.212.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52ba7asm4232738a12.13.2025.07.10.23.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 23:55:37 -0700 (PDT)
Message-ID: <2c42bbe7-79aa-42f6-8af8-65d1be7253a5@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 12:25:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] bus: mhi: host: Add support for Bandwidth scale
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-4-3faa8fe92b05@qti.qualcomm.com>
 <j24c2ii33yivc7rb3vwbwljxwvhdpqwbfgt3gid2njma6t47i4@uhykehw23h2q>
 <31c192f7-cd69-46ad-9443-5d57ae2aa86e@oss.qualcomm.com>
 <eg2v3kctnztxcaulffu7tvysljimmyhnramyjj5gpa4vrv3yxu@g3pgwpwx37iq>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <eg2v3kctnztxcaulffu7tvysljimmyhnramyjj5gpa4vrv3yxu@g3pgwpwx37iq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6870b56b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=Und2-qFukKY6GsmLQBMA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA0NiBTYWx0ZWRfX6sGDHsPBVEIe
 vQEw5UvrPixVonbCaUS9PUcQjfH894/hHKWnoLTzATbYgg8IS4d7hhOlu7+ZBotgwXThW+I2EYw
 /03iZIJiZmG+bAFpIoJvU3UFwK+YiNUdeQUtyexzUrlvBnF6AX8oMjJm88yNFhq33RdQh0s+hzK
 sVJhvD+qgoHOyEgzDS255izgbfhTYmS/evN0rfjeJJqi5h4AHDQn3X/8iCX+LLaT3lK3dEkPdxQ
 tS9rld5bYflHCY8Xv5keoEmXGTokiKAZiCOKoa79b1DkOT5SA9kvktaT6rP1gOA0s1fUMie9WnO
 KBH5VJsb3V6bGg8kcsJS7hYzdPKmngXVgLEMh5O1jfAQcgIO6k5NK9hALRFmDAxGrem6TQUAAq4
 gBGm5AAUSoZCQKrFzsa76IDagQMSxD2Xu7Pv46yAeqkoroFNDvtomiDUPmH8eXcgtPA2eYjW
X-Proofpoint-GUID: VC_AbO1MlFarXEHmsi4vMJhRsKX-Pbre
X-Proofpoint-ORIG-GUID: VC_AbO1MlFarXEHmsi4vMJhRsKX-Pbre
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110046



On 7/11/2025 10:03 AM, Manivannan Sadhasivam wrote:
> On Wed, Jul 09, 2025 at 05:51:34PM GMT, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/8/2025 10:36 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Jun 09, 2025 at 04:21:25PM GMT, Krishna Chaitanya Chundru wrote:
>>>> As per MHI spec v1.2, sec 14, MHI supports bandwidth scaling to reduce
>>>> power consumption. MHI bandwidth scaling is advertised by devices that
>>>> contain the bandwidth scaling capability registers. If enabled, the device
>>>> aggregates bandwidth requirements and sends them to the host through
>>>> dedicated mhi event ring. After the host performs the bandwidth switch,
>>>> it sends an acknowledgment by ringing a doorbell.
>>>>
>>>> if the host supports bandwidth scaling events, then it must set
>>>> BW_CFG.ENABLED bit, set BW_CFG.DB_CHAN_ID to the channel ID to the
>>>> doorbell that will be used by the host to communicate the bandwidth
>>>> scaling status and BW_CFG.ER_INDEX to the index for the event ring
>>>> to which the device should send bandwidth scaling request in the
>>>> bandwidth scaling capability register.
>>>>
>>>> As part of mmio init check if the bw scale capability is present or not,
>>>> if present advertise host supports bw scale by setting all the required
>>>> fields.
>>>>
>>>> MHI layer will only forward the bw scaling request to the controller
>>>> driver since MHI doesn't have any idea about transport layer used by
>>>> the controller, it is responsibility of the controller driver to do actual
>>>> bw scaling and then pass status to the MHI. MHI will response back to the
>>>> device based up on the status of the bw scale received.
>>>>
>>>> Add a new get_misc_doorbell() to get doorbell for misc capabilities to
>>>> use the doorbell with mhi events like MHI BW scale etc.
>>>>
>>>> Use workqueue & mutex for the bw scale events as the pci_set_target_speed()
>>>> which will called by the mhi controller driver can sleep.
>>>>
>>>> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>>>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>    drivers/bus/mhi/common.h        | 13 ++++++
>>>>    drivers/bus/mhi/host/init.c     | 63 +++++++++++++++++++++++++-
>>>>    drivers/bus/mhi/host/internal.h |  7 ++-
>>>>    drivers/bus/mhi/host/main.c     | 98 ++++++++++++++++++++++++++++++++++++++++-
>>>>    drivers/bus/mhi/host/pm.c       | 10 ++++-
>>>>    include/linux/mhi.h             | 13 ++++++
>>>>    6 files changed, 198 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>>>> index 58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd..6e342519d80b7725e9ef5390a3eb2a06ac69ceac 100644
>>>> --- a/drivers/bus/mhi/common.h
>>>> +++ b/drivers/bus/mhi/common.h
>>>> @@ -217,6 +217,19 @@ enum mhi_capability_type {
>>>>    	MHI_CAP_ID_MAX,
>>>>    };
>>>> +/* MHI Bandwidth scaling offsets */
>>>> +#define MHI_BW_SCALE_CFG_OFFSET		0x4
>>>> +#define MHI_BW_SCALE_CAP_ID		(3)
>>>> +#define MHI_BW_SCALE_DB_CHAN_ID		GENMASK(31, 25)
>>>> +#define MHI_BW_SCALE_ENABLED		BIT(24)
>>>> +#define MHI_BW_SCALE_ER_INDEX		GENMASK(23, 19)
>>>> +
>>>> +#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)	FIELD_GET(GENMASK(15, 8), (MHI_TRE_GET_DWORD(tre, 0)))
>>>> +
>>>> +#define MHI_BW_SCALE_RESULT(status, seq)	cpu_to_le32(FIELD_PREP(GENMASK(11, 8), status) | \
>>>> +						FIELD_PREP(GENMASK(7, 0), seq))
>>>> +#define MHI_BW_SCALE_NACK			0xF
>>>> +
>>>>    enum mhi_pkt_type {
>>>>    	MHI_PKT_TYPE_INVALID = 0x0,
>>>>    	MHI_PKT_TYPE_NOOP_CMD = 0x1,
>>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>>> index 9102ce13a2059f599b46d25ef631f643142642be..26703fea6272de7fd19c6ee76be067f0ff0fd309 100644
>>>> --- a/drivers/bus/mhi/host/init.c
>>>> +++ b/drivers/bus/mhi/host/init.c
>>>> @@ -501,10 +501,55 @@ static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability,
>>>>    	return -ENXIO;
>>>>    }
>>>> +static int mhi_get_er_index(struct mhi_controller *mhi_cntrl,
>>>> +			    enum mhi_er_data_type type)
>>>> +{
>>>> +	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
>>>> +	int i;
>>>> +
>>>> +	/* Find event ring for requested type */
>>>> +	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>>>> +		if (mhi_event->data_type == type)
>>>> +			return mhi_event->er_index;
>>>> +	}
>>>> +
>>>> +	return -ENOENT;
>>>> +}
>>>> +
>>>> +static int mhi_init_bw_scale(struct mhi_controller *mhi_cntrl,
>>>> +			     int bw_scale_db)
>>>> +{
>>>> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>>> +	u32 bw_cfg_offset, val;
>>>> +	int ret, er_index;
>>>> +
>>>> +	ret = mhi_find_capability(mhi_cntrl, MHI_BW_SCALE_CAP_ID, &bw_cfg_offset);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
>>>> +	if (er_index < 0)
>>>> +		return er_index;
>>>> +
>>>> +	bw_cfg_offset += MHI_BW_SCALE_CFG_OFFSET;
>>>> +
>>>> +	/* Advertise host support */
>>>> +	val = (__force u32)cpu_to_le32(FIELD_PREP(MHI_BW_SCALE_DB_CHAN_ID, bw_scale_db) |
>>>> +				       FIELD_PREP(MHI_BW_SCALE_ER_INDEX, er_index) |
>>>> +				       MHI_BW_SCALE_ENABLED);
>>>> +
>>>
>>> It is wrong to store the value of cpu_to_le32() in a non-le32 variable.
>>> mhi_write_reg() accepts the 'val' in native endian. writel used in the
>>> controller drivers should take care of converting to LE before writing to the
>>> device.
>>>
>> ok then I will revert to u32.
>>
>> I think we need a patch in the controller drivers seperately to handle
>> this.
> 
> Why?
> 
what I understood from your previous comment is from here we need to
send u32 only and the controller drivers should take care of
converting u32 to le32.
As of today controller drivers are not considering this and writing
u32 only.
So we need a seperate patch in the controller driver to convert it to
le32.
>>>> +	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
>>>> +
>>>> +	dev_dbg(dev, "Bandwidth scaling setup complete with event ring: %d\n",
>>>> +		er_index);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>>>    {
>>>>    	u32 val;
>>>> -	int i, ret;
>>>> +	int i, ret, doorbell = 0;
>>>>    	struct mhi_chan *mhi_chan;
>>>>    	struct mhi_event *mhi_event;
>>>>    	void __iomem *base = mhi_cntrl->regs;
>>>> @@ -638,6 +683,16 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>>>    		return ret;
>>>>    	}
>>>> +	if (mhi_cntrl->get_misc_doorbell)
>>>> +		doorbell = mhi_cntrl->get_misc_doorbell(mhi_cntrl, MHI_ER_BW_SCALE);
>>>> +
>>>> +	if (doorbell > 0) {
>>>> +		ret = mhi_init_bw_scale(mhi_cntrl, doorbell);
>>>> +		if (!ret)
>>>> +			mhi_cntrl->bw_scale_db = base + val + (8 * doorbell);
>>>> +		else
>>>> +			dev_warn(dev, "Failed to setup bandwidth scaling: %d\n", ret);
>>>
>>> That's it? And you would continue to setup doorbell setup later?
>>>
>> event ring for BW scale and capability are exposed during bootup only,
>> if those are not present at bootup no need to retry later.
> 
> I'm not asking you to retry. I was asking why would you continue to initialize
> bw_scale resources (like workqueue) even if mhi_init_bw_scale() fails.
> 
ack will do it in next patch.
>>>> +	}
>>>
>>> nit: newline
>>>
>>>>    	return 0;
>>>>    }
> 
> [...]
> 
>>>> +		goto exit_bw_scale;
>>>> +	}
>>>> +
>>>> +	link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
>>>> +	link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
>>>> +	link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
>>>> +
>>>> +	dev_dbg(dev, "Received BW_REQ with seq:%d link speed:0x%x width:0x%x\n",
>>>> +		link_info.sequence_num,
>>>> +		link_info.target_link_speed,
>>>> +		link_info.target_link_width);
>>>> +
>>>> +	/* Bring host and device out of suspended states */
>>>> +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
>>>
>>> Looks like mhi_device_get_sync() is going runtime_get()/runtime_put() inside
>>> mhi_trigger_resume(). I'm wondering why that is necessary.
>>>
>> Before mhi_trigger_resume we are doing wake_get, which will make sure
>> device will not transition to the low power modes while servicing this
>> event. And also make sure mhi state is in M0 only.
>>
>> As we are in workqueue this can be scheduled at some later time and by
>> that time mhi can go to m1 or m2 state.
>>
> 
> My comment was more about the behavior of mhi_trigger_resume(). Why does it call
> get() and put()? Sorry if I was not clear.
> Get() needed for bringing out of suspend, put() is for balancing the
get() I belive the intention here is to trigger resume only and balance
pm framework.

That said mhi_device_get_sync() has a bug we are doing wake_get() before
triggering resume and also trigger resume will not guarantee that device
had resumed, it is not safe to do wake_get untill device is out of
suspend, we might need to introduce runtime_get_sync() function and new
API for this purpose.
mhi_trigger_resume makes sense in the place like this[1], where ever
there are register writes after trigger resume it may need  to be
replaced with runtime_get_sync().

This function needs to do mhi_cntrl->runtime_get_sync(mhi_cntrl); first
to make sure controller is not in suspend and then mhi_device_get_sync()
to make sure device is staying in M0. and in the end we balance these
with mhi_cntrl->runtime_put(mhi_cntrl) & mhi_device_put().

An taughts in this approach?

[1] 
https://elixir.bootlin.com/linux/v6.6.96/source/drivers/bus/mhi/host/main.c#L1080

- Krishna Chaitanya.
> - Mani
> 

