Return-Path: <linux-kernel+bounces-834527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F521BA4DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4FFC4E0FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6379307AEA;
	Fri, 26 Sep 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jYfYDEcq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F5215191
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910759; cv=none; b=PObNx+UR74vxmx34bxsfN9L6GraIwfcfEx2lPPMCPsX8eDUIT35WRj5hDHqITCKiD18YclAQgrs7yuxyiR1bb3JnZDgE5z4doZeJtrAuL9qk8SO5IjZ3C3vuI2AxyVmTcDDRyIgFLjxK3qpfH5xxSz73Ym1OB7SS4RmOXnbQh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910759; c=relaxed/simple;
	bh=6MmXObhartxTKBIJxPnOvuJOiEQeaG+QxajNTKgUPhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYwDQk7wMN8OmbN8ggTzScfDBKta73lmtUYRIyh/LTkyc/7QimXlglZeeoV7PK1wif0D+Wy0i0oK/QxiqI3iaYvc/nBh1qFLadZCdjahGczpcLcSI20ILjTOuCKAg70fM5yjWpNBO+grGodEi2gEMiAl7sNgWZeg2ZTLAJl0HD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jYfYDEcq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWo07012020
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	blZigSJg8fUUIgUvfYWVJAQVHVIs1fx8MnzwUqxJoO8=; b=jYfYDEcqrEOKd4sl
	Zh8LOKEClpvMplj3i128n/SrsNADz/hFJ7FFuHJhqtRUFY/ldO8DHbiZYo/h4FW2
	fteEAhlOrdJrJT4fKhi3gECHJ/N2A6F1AuDFHCaNoupjnT7NnSJAy/IuTOhwTtAr
	zVxKUHonU7hlD77JXt2pSW25upgFlvmXBJlqEwBI9GiFRuxpmuSeRUAtP4CepkW9
	xumNt8YtiqWyaYfV1mdii7BHzaFutFxf5ncSDtPiVio0o/GJsLdD/AguKlbA2/Hq
	E8QJPzAgJvib+E1Sjiqvq0jnLxV1kfzGWphu9SO/vs5iD4ZMXaJrJHOLTFGtQEJL
	cxYAyQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q3r90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:19:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b57c2371182so2266334a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758910756; x=1759515556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blZigSJg8fUUIgUvfYWVJAQVHVIs1fx8MnzwUqxJoO8=;
        b=XecaXUpY8DKqHqKYsxFPuQfNUQfDu3SnLOf5gMrFyLEEVUbU+HVx6K8MqWxpgCOi5n
         ZYwyVaNjwjEoXbHdENUR56rJt76FnPNMguAbKt8DkZYV/vrzSWMnkZsu3ZpeskSzSuIp
         ddBs7a0r77Q9kpOx6bFm8NcJMTbTpgvPDOaWs6Ddv/ZPca5Yg+aIh0ZDCX1ThsPNofM4
         FYGLaeXQ5dmlE3EJH2267TedaDXpzEtzpm2EYUvYwZm8kgI9hh/ucad+ktPHgI1p7IM/
         o/QvetrX+ffllrJY9gE0uZhBVgvcvj6J7NOTyDmPx4ullpsudmJ/ul2/7y8WTiBVs/V1
         W4wA==
X-Forwarded-Encrypted: i=1; AJvYcCXpaW9xFy8s2HwdgN3hxyQw83LfH2vGbxhtlx7DCu84Gw5DVG9qZbnb0de6QRenOyTPZsuFhNxyJygV5PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCA3GXfgkE8NpXE9yB7dLXs2p0duFM49pTHvKG2EnoBwLYpkwS
	N5QfXCGoCxVcM4SCwnqdOn3EDvU1HmKjADu3217EkPIRucSoMMYHjgwtvabV6SB0ta4fa/B6EjR
	KBbGuq47xs/Nbhwm2qSFbtITVHjjtRG6n8g9lBwvVGh9rCmxBxysbZ1TSMp0XFZeVBkk=
X-Gm-Gg: ASbGncsCk2xkX8rSj+3bWwTCdhl73/867sBbQDHHLJ6/O+sdAdrlbODghKub9AoQF25
	lqoVZ+YgqwotDMs5qIMN7klOu76bDZ1Ct/W31TYu49DBj15pban1WdGbFLUJ/qB9RogieWgwXfq
	yqex9ItjCOZYS94gGxRCeL37ia38JK/KUmQ1Rd1zPiJnWm2OChvhbKorodSdosKK4zCgqJDc9oz
	qrflUciQhAsfTPNaqMamzyGu1Hz5VPdsa/9hYb1WuGlh5ug4FSf2flw+MJB1SWo2qRUdNjBpkio
	ZHbwjjnOPsM6PHaDH7yfHkKn28kWxoJNmOtKwSxiAHFqEr14+R3yXPLhSmGC/QW+0lcYjJl8rFT
	2pRmOq/MBaWgrcGUXeFBbMFN6Rp6s
X-Received: by 2002:a17:90b:1a86:b0:32e:e186:726d with SMTP id 98e67ed59e1d1-3342a2e08a1mr6706630a91.31.1758910756417;
        Fri, 26 Sep 2025 11:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlsoXvXI/7zk1yAQi3F3KN8R32lykMOeT61Rp7qbtH1i2VYM90nP0ueH+y0+T94R0288ihug==
X-Received: by 2002:a17:90b:1a86:b0:32e:e186:726d with SMTP id 98e67ed59e1d1-3342a2e08a1mr6706595a91.31.1758910755892;
        Fri, 26 Sep 2025 11:19:15 -0700 (PDT)
Received: from [10.71.112.90] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347224b76csm6137691a91.9.2025.09.26.11.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 11:19:15 -0700 (PDT)
Message-ID: <4cbcf312-7697-4725-8fd8-45f2b5b0584f@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 11:19:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] usb: typec: ucsi_glink: Increase buffer size to
 support UCSI v2
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com>
 <20250924232631.644234-3-anjelique.melendez@oss.qualcomm.com>
 <t3hfr33t76ckecatro5gheycb2phnch57m6zzdpm44ibykbubd@e6nffasyetib>
Content-Language: en-US
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
In-Reply-To: <t3hfr33t76ckecatro5gheycb2phnch57m6zzdpm44ibykbubd@e6nffasyetib>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX7cDGu3NyTqEa
 K2c/fp4q4W6g6CQ4ryw36SUiAYAP757mDXveir+Mnorqf2UdDe2oJAj2/ZSA3jBpNtt8zVEpA58
 ZOzqPym9T5QdJxUxG8ywtPwDxKFv83LPxHd/WVr6pnWKj2XezMyITEUbpXtqYfedLfvjwUeWI36
 a1zgrtXhjBVr/VLv9IIAcLaYXWgLKsgpRof4DACrANoR3GhLsx1kPpTUUNlGP3a+ja/5WLGXO4I
 Vr4g6Diwm6ytctzbITfVK8b6ME+6nH7sgw+8oAksoFh4928qa62l+svGjSkFJyPHe/XFIi0FPHP
 SKTvTBUGbseAA9V89b6vhGqpS689pKefP9crLjNSKuLM/ITHMeoOI9DJ7oE+Bqrn4lWl3w+XLaW
 Md6tSbqM6/7GaftrfFtaY0cxyy72Dg==
X-Proofpoint-GUID: ObqBrdqy7kf27YYo7E76yqWiX5au5_1p
X-Proofpoint-ORIG-GUID: ObqBrdqy7kf27YYo7E76yqWiX5au5_1p
X-Authority-Analysis: v=2.4 cv=JsX8bc4C c=1 sm=1 tr=0 ts=68d6d925 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=CGcnTnl5F4JIPjVE0FQA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171



On 9/25/2025 2:43 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 04:26:31PM -0700, Anjelique Melendez wrote:
>> UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
>> 16 bytes to 256 bytes each for the message exchange between OPM and PPM
>> This makes the total buffer size increase from 48 bytes to 528 bytes.
>> Update the buffer size to support this increase.
>>
>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> ---
>>   drivers/usb/typec/ucsi/ucsi_glink.c | 81 ++++++++++++++++++++++++-----
>>   1 file changed, 68 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
>> index 1f9f0d942c1a..7f19b4d23fed 100644
>> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
>> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
>> @@ -16,10 +16,10 @@
>>   
>>   #define PMIC_GLINK_MAX_PORTS		3
>>   
>> -#define UCSI_BUF_SIZE                   48
>> +#define UCSI_BUF_V1_SIZE		(UCSI_MESSAGE_OUT + (UCSI_MESSAGE_OUT - UCSI_MESSAGE_IN))
>> +#define UCSI_BUF_V2_SIZE		(UCSIv2_MESSAGE_OUT + (UCSIv2_MESSAGE_OUT - UCSI_MESSAGE_IN))
>>   
>>   #define MSG_TYPE_REQ_RESP               1
>> -#define UCSI_BUF_SIZE                   48
>>   
>>   #define UC_NOTIFY_RECEIVER_UCSI         0x0
>>   #define UC_UCSI_READ_BUF_REQ            0x11
>> @@ -30,15 +30,27 @@ struct ucsi_read_buf_req_msg {
>>   	struct pmic_glink_hdr   hdr;
>>   };
>>   
>> -struct __packed ucsi_read_buf_resp_msg {
>> +struct __packed ucsi_v1_read_buf_resp_msg {
>>   	struct pmic_glink_hdr   hdr;
>> -	u8                      buf[UCSI_BUF_SIZE];
>> +	u8                      buf[UCSI_BUF_V1_SIZE];
>>   	u32                     ret_code;
>>   };
>>   
>> -struct __packed ucsi_write_buf_req_msg {
>> +struct __packed ucsi_v2_read_buf_resp_msg {
>>   	struct pmic_glink_hdr   hdr;
>> -	u8                      buf[UCSI_BUF_SIZE];
>> +	u8                      buf[UCSI_BUF_V2_SIZE];
>> +	u32                     ret_code;
>> +};
>> +
>> +struct __packed ucsi_v1_write_buf_req_msg {
>> +	struct pmic_glink_hdr   hdr;
>> +	u8                      buf[UCSI_BUF_V1_SIZE];
>> +	u32                     reserved;
>> +};
>> +
>> +struct __packed ucsi_v2_write_buf_req_msg {
>> +	struct pmic_glink_hdr   hdr;
>> +	u8                      buf[UCSI_BUF_V2_SIZE];
>>   	u32                     reserved;
>>   };
>>   
>> @@ -72,7 +84,7 @@ struct pmic_glink_ucsi {
>>   	bool ucsi_registered;
>>   	bool pd_running;
>>   
>> -	u8 read_buf[UCSI_BUF_SIZE];
>> +	u8 read_buf[UCSI_BUF_V2_SIZE];
>>   };
>>   
>>   static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
>> @@ -131,18 +143,34 @@ static int pmic_glink_ucsi_read_message_in(struct ucsi *ucsi, void *val, size_t
>>   static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned int offset,
>>   					const void *val, size_t val_len)
>>   {
>> -	struct ucsi_write_buf_req_msg req = {};
>> -	unsigned long left;
>> +	struct ucsi_v2_write_buf_req_msg req = {};
>> +	unsigned long left, max_buf_len;
>> +	size_t req_len;
>>   	int ret;
>>   
>> +	memset(&req, 0, sizeof(req));
>>   	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
>>   	req.hdr.type = MSG_TYPE_REQ_RESP;
>>   	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;
>> +
>> +	if (ucsi->ucsi->version >= UCSI_VERSION_2_0) {
>> +		req_len = sizeof(struct ucsi_v2_write_buf_req_msg);
>> +		max_buf_len = UCSI_BUF_V2_SIZE;
> 
> I'd prefer it to be more explicit. Define an union of v1 and v2, fill
> common parts and version-specific parts separately.
Konrad also left a similar comment in this function "This code keeps the 
'reserved' field zeored out for v1, but it does so in a fragile and 
implicit way :/" 
(https://lore.kernel.org/all/df671650-a5af-4453-a11d-e8e2a32bd1ab@oss.qualcomm.com/#t)

So I figured I would try to get thoughts from the both of you :)

We could have a union defined like so:
struct __packed ucsi_write_buf_req_msg {
	struct pmic_glink_hdr   hdr;
	union {
		u8 v2_buf[UCSI_BUF_V2_SIZE];
		u8 v1_buf[UCSI_BUF_V1_SIZE];
	} buf;
	u32                     reserved;
};

and then ucsi_locked_write() pseudo would be something like this:

pmic_glink_ucsi_locked_write()
{
	struct ucsi_write_buf_req_msg req = {};
	u8 *buf;

	req.hdr.owner = PMIC_GLINK_OWNER_USBC;
	req.hdr.type = MSG_TYPE_REQ_RESP;
	req.hdr.opcode = UC_UCSI_WRITE_BUF_REQ;

	if (version >= UCSI_VERSION_2_0)
		buf_len = UCSI_BUF_V2_SIZE;
		buf = req.buf.v2_buf;
	else if (version)
		buf_len = UCSI_BUF_V1_SIZE;
		buf = req.buf.v1_buf;
	else
		return -EINVAL;
	req_len = sizeof(struct pmic_glink_hdr) + buf_len + sizeof(u32);

	memcpy(&buf[offset], val, val_len);

	ret = pmic_glink_send(ucsi->client, &req, req_len);
	if (ret < 0)
		return ret;

	left = wait_for_completion_timeout(&ucsi->write_ack, 5 * HZ);
	if (!left)
		return -ETIMEDOUT;

	return 0;
}

Since we are adding the union we still end up initializing space for the 
larger UCSI v2 buffer and when we have UCSI v1 we are only expected to 
send a request with buffer size = UCSI v1. With this we would still be 
keeping a reserved field zeroed for v1 but it still is not the 
req.reserved field being explicitly sent.

The only other solution I can think of that would be fully explicit is 
if we created pmic_glink_ucsi_v2_locked_write() which basically just did 
the exact same thing as the original pmic_glink_ucsi_locked_write() but 
instead used ucsi_v2_write_buf_req_msg struct. 
pmic_glink_ucsi_async_control() would then decide which locked_write 
function to call based on version. However that would include a lot of 
code copying.

Let me know what your thoughts are - I'm more than happy to go the way 
of the union but just want to make sure that we are all on same page and 
can agree on best steps forward :)

Thanks,
Anjelique

