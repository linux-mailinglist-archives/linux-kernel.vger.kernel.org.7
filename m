Return-Path: <linux-kernel+bounces-726897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D4B01284
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA955851D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA518BB8E;
	Fri, 11 Jul 2025 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B9xo24QQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1049013AA2A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210360; cv=none; b=lrRUo0TuNKW4m9XABtN6VQvGlBOY3jnQ5OrU7FnWm6zHwNbEx4aXt4QfeXp9q7gg3ft/AxWZTVfV7G7RGKTSTztCzcDcqPJBVZc1C7X9tepSjpPI1ajZcKV7r/7uzVjCcTZQ75YtHnv/4EEMUAj3BqiKV4eYFAUa9F+NjR2FD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210360; c=relaxed/simple;
	bh=ZiQ3Fv8gmz6RId3auba0EbdkWD4thp4jNvTHfKbkpmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqySXyjn6wDlw9eAah7xuDyYksj65o4rMInwPoBYtz+FZ2MnKSkhAqFT/+40sUx/ZlkrtNvbWcKenB+QxpYJEKJXdUDvwZ4VZiQTEAz4WGW2pN0/4KF9Sn+OL144kxpZZvKUFAVnVhQcWh6HUQyxlaoGwM8pRzH0kJ9UQpURVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B9xo24QQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1XLhr017448
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ON4p5KKmBIR3FGHX5880lk4pL/vyxFoXHm7nsMOOrHc=; b=B9xo24QQrEIy7vY7
	2H/4mBPA3lz09M1dFW1fwOCkLhQfAW7ZCNoO5BPE83/2joulY+bKdcmmx1buzB4N
	DJ/k0jMO4qVOPlg9gxsmsShYUDwx4+Tkh5hVzS+GqIQA6tnG6jwrpqRQiwm6b9RS
	XPBK0WcYvjRKsCFErTQqZ8xDU9gfETVVz772t9enoch6qBI1PW/ivByxjkm8ZNhE
	V0l/K9PWd8NBcsTNpnzDVg2pVE4TydTdDmZEskeyhotPZmCkHAhrBUl8EulOipbr
	2hFqH7AF6YTK/z5hJYO5lxELm+g7qlasIirEqu+f1a1xEQdDlh6mI8QGPKeqqOBC
	j50esQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap7b4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:05:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-237e6963f70so25819125ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752210356; x=1752815156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ON4p5KKmBIR3FGHX5880lk4pL/vyxFoXHm7nsMOOrHc=;
        b=GVsBwY/eB6PpAM4b+lQu1zQG1rbxIUt16TvN60Li46m1Zt08LU3AXwNKAEotgU23Ff
         ZS6dSR3JpYj8NnzPTFcoKqKd0kuK3ZalevLfijRtgsQedyf30IUOwpuDWFHfVUqseD2l
         AIKoZnAJlGDqE4Gc9zYQ0PJWY4x4EGWAixyCRFSWmO6PLXWI79vjIROpKbr9jfhwVwNG
         sCgjUXdDXvYhzZHuaMJo3y8FwV2HqIy6DJfOiWqNZdiVQSngGDi1es+IpA3zbgERRNw0
         F8S5YCP0bTXso/nWCA3/vEDzmJafLxcsnp0Xr5Ri6oscOSpnCEREZa+jbCThkUj6+Vs/
         wcmg==
X-Forwarded-Encrypted: i=1; AJvYcCUZqRY84YK8F5uEsm6Jh2omlASyF6l99V4jfVnqzOGIdMBL9AU0FKTzyFqnD/edvz+S/UeiOkWhx3MgFpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvdJnvNUH1NEWagNBAft5+sjjtQlEcWnDalEiSsUPwpGRGtcCE
	xM87ASxj78slkg7+NuxzQpcCvjW2y2tj7AguK9VTgha/rx0DPyqPDTRiO8l71rZ+SNta/Bsa31R
	/snwAqaDuFYoqiTxZPBjpGe6zTZGbDHupPII7dDwgOFmmBsIj5qjXL7U8zRRvc7vIVw==
X-Gm-Gg: ASbGncsFja+69p5dknHo9iT3JNLKaXh6ndn/OTXyHwXY/1b4OAbtsr43mHIHxGHnvOV
	EfHeX10OEtwXXlz78VczCagWJ+gegOlIkFthzZ+qUeymBBptzLLNYobQBqZrz+T2cNBtkN2aWxN
	NoPvG7QxdQQlO6da6L23bIShOWcIF6mkmBryrfp1/djZdqhiucKcD2u+fI6luuFM7RW9F5jtEYX
	5T8co33y4ppg3i6iUKJy/9a5WRup3ThSyx5bXFL2Frlwm1SyFTxtiareuHvIQmFIoBaFdow6h9w
	B0SVcjlXLkZJmAcP/vZtTC84cfpg+thIUL9qCUaadz9YmAX0o5l5fVNuIDrBsygoX88hDnyt3Ej
	ofXh/vkppYZgF1k2q8W8aNLUD5rpkRQpdzITIOQ==
X-Received: by 2002:a17:902:e54a:b0:234:8a16:d62b with SMTP id d9443c01a7336-23dede38615mr28066705ad.12.1752210356354;
        Thu, 10 Jul 2025 22:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc9IdZCzOQJSKnApzYY4Ey9QwM3RLDd7RZBRwcYVcIK2ljlo/TA59XUzUEdTJNZzy9kf6SxQ==
X-Received: by 2002:a17:902:e54a:b0:234:8a16:d62b with SMTP id d9443c01a7336-23dede38615mr28066255ad.12.1752210355851;
        Thu, 10 Jul 2025 22:05:55 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de432289bsm37082315ad.118.2025.07.10.22.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 22:05:55 -0700 (PDT)
Message-ID: <ad88258e-dc44-4b82-b49c-e327609ab774@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 15:05:46 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] Documentation: tee: Add Qualcomm TEE driver
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
 <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-12-024e3221b0b9@oss.qualcomm.com>
 <aGu7boxOTB3TFRNU@sumit-X1>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <aGu7boxOTB3TFRNU@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=68709bb5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=XIjxTgID6P44-LRwrwcA:9 a=QEXdDO2ut3YA:10 a=M0EVDjxxv-UA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: gc1FSfAiTCL1VndYfiprexbnfSWMGIcf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAzMyBTYWx0ZWRfXyJpHYNYfPElx
 07LS22zsy6s57uY4VhbMx7zPyxOicMhIxnH3R9bAHgu3OtwQNu/xCub2hRrlRjkTJvRRa9Nk5rg
 r1omRsbqZcni7gOFWq7uELWZw4M6viJ2kW8RlKQL32x/vcs1KTyzhyZBOcLKnU9TuEBVYF1UMMi
 CctcQb9H/URCO2ZAabruivMiNXLMPiSbHguKqvsNdtF73mD2yiltekH0M8u23VLqC0tI4Zkads5
 GlOQ/E2p+HH/af4L61ggHG5SxPINSxIY1e2lV7f5U2hlks0toGz/3rCMsP8RSkTxXuAp5nVRkqQ
 ggOGUbHiltK+FHQ2e1wICRag+s9Ssd14IikcR0U8+WhO2I2V7FZjLmOH/V85/Mlpf6f671OdN1z
 mTzK6NCvEYc/kn9A9/Jde4TTWsI6i90a5CKgsAUVb+5JgE4Phpv3jzPA9HQ+AsTyzGAJxXrd
X-Proofpoint-GUID: gc1FSfAiTCL1VndYfiprexbnfSWMGIcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110033

Hi Sumit,

On 7/7/2025 10:19 PM, Sumit Garg wrote:
> On Mon, May 26, 2025 at 11:56:57PM -0700, Amirreza Zarrabi wrote:
>> Add documentation for the Qualcomm TEE driver.
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  Documentation/tee/index.rst |   1 +
>>  Documentation/tee/qtee.rst  | 150 ++++++++++++++++++++++++++++++++++++++++++++
>>  MAINTAINERS                 |   1 +
>>  3 files changed, 152 insertions(+)
>>
>> diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
>> index 4be6e69d7837..62afb7ee9b52 100644
>> --- a/Documentation/tee/index.rst
>> +++ b/Documentation/tee/index.rst
>> @@ -11,6 +11,7 @@ TEE Subsystem
>>     op-tee
>>     amd-tee
>>     ts-tee
>> +   qtee
>>  
>>  .. only::  subproject and html
>>  
>> diff --git a/Documentation/tee/qtee.rst b/Documentation/tee/qtee.rst
>> new file mode 100644
>> index 000000000000..8ae4da17c3a7
>> --- /dev/null
>> +++ b/Documentation/tee/qtee.rst
>> @@ -0,0 +1,150 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=============================================
>> +QTEE (Qualcomm Trusted Execution Environment)
>> +=============================================
>> +
>> +The QTEE driver handles communication with Qualcomm TEE [1].
>> +
>> +The lowest level of communication with QTEE builds on the ARM SMC Calling
>> +Convention (SMCCC) [2], which is the foundation for QTEE's Secure Channel
>> +Manager (SCM) [3] used internally by the driver [4].
>> +
>> +In a QTEE-based system, services are represented as objects with a series of
>> +operations that can be called to produce results, including other objects.
>> +
>> +When an object is hosted within QTEE, executing its operations is referred
>> +to as direct invocation. QTEE can invoke objects hosted in the kernel or
>> +userspace using a method known as callback requests.
>> +
>> +The SCM provides two functions for direct invocation and callback request:
>> +
>> +- QCOM_SCM_SMCINVOKE_INVOKE for direct invocation. It can return either
>> +  a result or a callback request.
>> +- QCOM_SCM_SMCINVOKE_CB_RSP submits a response for a previous callback request.
>> +
>> +The QTEE Transport Message [5] is stacked on top of the SCM driver functions.
>> +
>> +A message consists of two buffers shared with QTEE: inbound and outbound
>> +buffers. The inbound buffer is used for direct invocation, and the outbound
>> +buffer is used to make callback requests. This picture shows the contents of
>> +a QTEE transport message::
>> +
>> +                                      +---------------------+
>> +                                      |                     v
>> +    +-----------------+-------+-------+------+--------------------------+
>> +    | qcomtee_msg_    |object | buffer       |                          |
>> +    |  object_invoke  |  id   | offset, size |                          | (inbound buffer)
>> +    +-----------------+-------+--------------+--------------------------+
>> +    <---- header -----><---- arguments ------><- in/out buffer payload ->
>> +
>> +                                      +-----------+
>> +                                      |           v
>> +    +-----------------+-------+-------+------+----------------------+
>> +    | qcomtee_msg_    |object | buffer       |                      |
>> +    |  callback       |  id   | offset, size |                      | (outbound buffer)
>> +    +-----------------+-------+--------------+----------------------+
>> +
>> +Each buffer is started with a header and array of arguments.
>> +
>> +QTEE Transport Message supports four types of arguments:
>> +
>> +- Input Object (IO) is an object parameter to the current invocation
>> +  or callback request.
>> +- Output Object (OO) is an object parameter from the current invocation
>> +  or callback request.
>> +- Input Buffer (IB) is (offset, size) pair to the inbound or outbound region
>> +  to store parameter to the current invocation or callback request.
>> +- Output Buffer (OB) is (offset, size) pair to the inbound or outbound region
>> +  to store parameter from the current invocation or callback request.
>> +
>> +The QTEE driver provides the qcomtee_object, which represents an object within
>> +both QTEE and the kernel. To access any service in QTEE, a client needs to
>> +invoke an instance of this object. Any structure intended to represent a service
>> +for export to QTEE should include an instance of qcomtee_object::
>> +
>> +	struct driver_service {
>> +		struct qcomtee_object object;
>> +		...
>> +	};
>> +
>> +	#define to_driver_service_object(o) container_of((o), struct driver_service, object)
>> +
>> +	static int driver_service_dispatch(struct qcomtee_object *object, u32 op,
>> +					   struct qcomtee_arg *args)
>> +	{
>> +		struct driver_service *so = to_driver_service_object(object);
>> +
>> +		switch(op) {
>> +		case OBJECT_OP1:
>> +			...
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	static void driver_service_object_release(struct si_object *object)
>> +	{
>> +		struct driver_service *so = to_driver_service_object(object);
>> +		kfree(so);
>> +	}
>> +
>> +	struct si_object_operations driver_service_ops = {
>> +		.release = driver_service_object_release;
>> +		.dispatch = driver_service_dispatch;
>> +	};
>> +
>> +	void service_init(void)
>> +	{
>> +		struct driver_service *so = kzalloc(sizeof(*so), GFP_KERNEL);
>> +
>> +		/* Initialize so->object as a callback object. */
>> +		qcomtee_object_user_init(&so->object, QCOMTEE_OBJECT_TYPE_CB_OBJECT,
>> +					 &driver_service_ops, "driver_service_object");
>> +
>> +		/* Invoke a QTEE object and pass/register 'so->object' with QTEE. */
>> +		...
>> +	}
>> +	module_init(service_init);
> 
> Lets drop any reference for kernel client/services since they aren't
> supported by this patch-set yet.

Will do.

Regards,
Amir

> 
> -Sumit
> 
>> +
>> +The QTEE driver utilizes qcomtee_object to encapsulate userspace objects. When
>> +a callback request is made, it translates into calling the dispatch operation.
>> +For userspace objects, this is converted into requests accessible to callback
>> +servers and available through generic TEE API IOCTLs.
>> +
>> +Picture of the relationship between the different components in the QTEE
>> +architecture::
>> +
>> +         User space               Kernel                     Secure world
>> +         ~~~~~~~~~~               ~~~~~~                     ~~~~~~~~~~~~
>> +   +--------+   +----------+                                +--------------+
>> +   | Client |   |callback  |                                | Trusted      |
>> +   +--------+   |server    |                                | Application  |
>> +      /\        +----------+                                +--------------+
>> +      ||  +----------+ /\                                          /\
>> +      ||  |callback  | ||                                          ||
>> +      ||  |server    | ||                                          \/
>> +      ||  +----------+ ||                                   +--------------+
>> +      \/       /\      ||                                   | TEE Internal |
>> +   +-------+   ||      ||                                   | API          |
>> +   | TEE   |   ||      ||   +--------+--------+             +--------------+
>> +   | Client|   ||      ||   | TEE    | QTEE   |             | QTEE         |
>> +   | API   |   \/      \/   | subsys | driver |             | Trusted OS   |
>> +   +-------+----------------+----+-------+----+-------------+--------------+
>> +   |      Generic TEE API        |       |   QTEE MSG                      |
>> +   |      IOCTL (TEE_IOC_*)      |       |   SMCCC (QCOM_SCM_SMCINVOKE_*)  |
>> +   +-----------------------------+       +---------------------------------+
>> +
>> +References
>> +==========
>> +
>> +[1] https://docs.qualcomm.com/bundle/publicresource/topics/80-70015-11/qualcomm-trusted-execution-environment.html
>> +
>> +[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
>> +
>> +[3] drivers/firmware/qcom/qcom_scm.c
>> +
>> +[4] drivers/tee/qcomtee/qcom_scm.c
>> +
>> +[5] drivers/tee/qcomtee/qcomtee_msg.h
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 99fe1ae22ae0..42823d33cc03 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20515,6 +20515,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
>>  M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>  L:	linux-arm-msm@vger.kernel.org
>>  S:	Maintained
>> +F:	Documentation/tee/qtee.rst
>>  F:	drivers/tee/qcomtee/
>>  F:	include/linux/firmware/qcom/qcom_tee.h
>>  
>>
>> -- 
>> 2.34.1
>>


