Return-Path: <linux-kernel+bounces-805061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C441B48399
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A553178A56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E6225414;
	Mon,  8 Sep 2025 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g424Npyj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C53FE5F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309170; cv=none; b=Yu+SBWfQvzUddTu32tcTdsZSPgIIxPdXUqT/TbCMcfQ6xU8XSghROzAv8mW/Vfo9niD+FrwzwHQrVRY6ml4AdpvFEfff6dW4pilGJzEkTnHhBoKRn+UPalTytX2zLOpTcy/5AFs9fhRwRFefjpr+HM4VOwUyrpgenWo4FrKU+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309170; c=relaxed/simple;
	bh=mQ2XoJ6YrlXBOOmEQpQykZgQU78ZVN/iUS8B2jI7kgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzgYii7mDieFVrtWKTY/MMxdCZzRnFTm5bl8NNXm87RQQYyiiwsJcwFEUCDfvp3d0JxMr5YOSThAPyS9P83jxnLb2o1EBtNLhMOLbdPzdx4IH4tgKgWbQs76F1wzU3W/a1vCCKLbnaOlr4y+zPyEbNM1r6ud3sEqar9I455Grl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g424Npyj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LnGqx003961
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 05:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DcVLuODCpHT9DZQ4iAOI1YeR5daI/UPfmFpZv7882EQ=; b=g424NpyjYygfoSwp
	t2Yu4LasKbPWnGUJDBXNuRQ+sM3ZflaBvurYGCQftdnli5Xn0nR/kOGVkmSOCsZq
	x/o4d/k+RCes4FPxiFb7Mu4i6RS8fE6f55kD1ObHC369NNP71OqtrcJGvdCh4t5R
	OwnQrb6fcuEw11OZOB8ms2UBU8MCBDJcnGZLgM6fLgNeoNrrDc80Qo7q1xw5WoJA
	y5ejfeDNGpF13dhWkhAcmi9m+6/JAjAfWXYI8enhD3hzJwHIZzT/GmrQtvZIBy71
	U0MH8BeKatOkdUEcBJuEibeZNtxs7+OwHnclhH74qg/6/5EsCvw4BxujfzRJ8cQ3
	gBlJKA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1vbbhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:26:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329ee88fb47so7787443a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 22:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309166; x=1757913966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcVLuODCpHT9DZQ4iAOI1YeR5daI/UPfmFpZv7882EQ=;
        b=Pn4xLuxW7lixiocbwdSFf/IPjJN8euTQ6aigpHpkdoNlcALWwuA7VMRCGtmZTPX8l3
         Fxu81b1fAA7uWfcUaTnfx78CLYPYCghwv6PesizB86tXy70jZiCH4ueniBY170QiJ9lK
         S4OXgk0/27Gl4ktg6TDdRmF2zrAA/GNvxp46c0BrYUpTMKwGQjKFz+X/IefeCLE1mE1/
         GJN4qHdN5KbKuuri0C52mRbygNyXDG3peV2Fm8zVhGszpeGW11AUQcXx4F6ZW9Uh30gx
         gRtaIdpH7v7sSzPb92nSpA693yidHaUA/wTo4E4NUNVmvSAuGlDd3XV1YJZr1CLowGkY
         2MhA==
X-Forwarded-Encrypted: i=1; AJvYcCUMjIGtiZwmGE17xA5WtKfHEheMLOSbOkmv9UQ1IkpLvCBQtVRzo/3jx/O/ste7/3p+5A5wTBjHj15VIZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQ0oCNuD+44d0pvT4WzAw7dAN7T7fA78apY0lglVSDYQFwpUN
	tQqL6oylZODmZZbzHkTPSUu13bYKj2OWIif9l63go93Pe4QZWSOZj3Gt3eujAqYZ9sHoEcV5jx0
	0WSw1Jh6qYkmIasvrblmn8v5U4ldQAwHkL8npU4AvAYeKNEFcNS918KbpRw57wfov2sk=
X-Gm-Gg: ASbGnctzT+uSh7WFg3sMeuMIpUOtwqRtjCUb4tAW4cugSp+IZjTn/XRoRfa1Wk6iBd7
	057roOIzM5Pv30gPo3RIsoq2IRPdWg2qifI1hpaPaFrlQo+m2tg1CX8bACXT4B2K52pBZzCJrc+
	KClKLLh5E9AFIpn3YydA+vgdiVJ7Lzd0jgowFKmr5GBuq2gWlpafwLOTuqiV5ER7xydyWN0Oov9
	nFjnFZRSz2bVSsyCk0qJyVNqHOQNjFTRJ6X2ajCV8Wi0Pu1yy3H9BEOMDCkGIoLnboPSfqpPYQf
	UdcNoXEgzOoEp2JX92q3rUYCvy/b8zpg+HORexX46y6kApGHccf/f7A4EAdOJL6m4S2fEm0=
X-Received: by 2002:a17:90b:1d4c:b0:32b:70a7:16d4 with SMTP id 98e67ed59e1d1-32d43f8f992mr10343397a91.17.1757309165832;
        Sun, 07 Sep 2025 22:26:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfQIdemlD57I/dkTQtU0E2j971uVJ/dwYkgbbvqR2qALG9A+MdzdpTk4MueXTBGMRoBs7E1A==
X-Received: by 2002:a17:90b:1d4c:b0:32b:70a7:16d4 with SMTP id 98e67ed59e1d1-32d43f8f992mr10343369a91.17.1757309165301;
        Sun, 07 Sep 2025 22:26:05 -0700 (PDT)
Received: from [10.206.107.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327daeebe16sm29779170a91.26.2025.09.07.22.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 22:26:04 -0700 (PDT)
Message-ID: <1f5daa38-51c6-4546-a9e3-3a91f7b3fc5b@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 10:56:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
 <20250901053336.3939595-4-ekansh.gupta@oss.qualcomm.com>
 <hqbazo62hdfwgxoevzkchfddvjpr2ttp7wltpkoooou5anongs@5ncpjec3egjh>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <hqbazo62hdfwgxoevzkchfddvjpr2ttp7wltpkoooou5anongs@5ncpjec3egjh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hCZYL6uDTBXpXGKmHwDSWqmgfbk0M8EZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfXzDvtqosOUo+v
 CeOY2wunKC542jyglnUFOPXrtLvM8swVQ5VQM4VQsmY1af9fmNQuDxw0NyDIBJKrw8+QsHxpKow
 h87dW+BMCieAOfy2ku3smAHG9Ojnyw0tjEA5Bx4xis3iAC4EF9VJZ8x0xFcXHG/ArA0mWZI65Dm
 3CkZLoFbiLSo3BJZ/MgWQ2sYpWuq74EadvHCUHdnpoVC83VVQ56tFm23+V8muKjybBhl9iffWu4
 0/0S0CKa2aDAs6B0Nf+4jmaj1Tco1Pr1rvEkGWEJ7i+Gtvox7xAwgVrSTMYWMzwizfWIw9SUPWu
 dOWj24LU1T/2mOY+iFGSgfzehupnAmKA1KpR3Plkq5sTVMYYhZOGqRKx4RccvV0jZiwAZCm+IkO
 e+cAFZI5
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68be68ef cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=n5CWrXbSiRi7pyfJxhkA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: hCZYL6uDTBXpXGKmHwDSWqmgfbk0M8EZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027



On 9/2/2025 2:51 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 01, 2025 at 11:03:36AM +0530, Ekansh Gupta wrote:
>> For any remote call to DSP, after sending an invocation message,
>> fastRPC driver waits for glink response and during this time the
>> CPU can go into low power modes. This adds latency to overall fastrpc
>> call as CPU wakeup and scheduling latencies are included.  Adding a
> s/Adding/Add/, see Documentation/process/submitting-patches.rst
Ack.
>
>> polling mode support with which fastRPC driver will poll continuously
>> on a memory after sending a message to remote subsystem which will
>> eliminate CPU wakeup and scheduling latencies and reduce fastRPC
>> overhead.
> Describe your design decisions: when it is enabled, why, etc.
Yes, also planning to enable it from userspace in v2 due to power consumption
concerns.
>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c | 121 ++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 114 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 57e118de6e4a..939a3e3d29e2 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -22,6 +22,8 @@
>>  #include <linux/firmware/qcom/qcom_scm.h>
>>  #include <uapi/misc/fastrpc.h>
>>  #include <linux/of_reserved_mem.h>
>> +#include <linux/compiler.h>
>> +#include <linux/iopoll.h>
>>  
>>  #define ADSP_DOMAIN_ID (0)
>>  #define MDSP_DOMAIN_ID (1)
>> @@ -37,6 +39,7 @@
>>  #define FASTRPC_CTX_MAX (256)
>>  #define FASTRPC_INIT_HANDLE	1
>>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
>> +#define FASTRPC_MAX_STATIC_HANDLE (20)
> What is this?
Static handles in FastRPC refer to handles that are statically defined and
associated with modules in the DSP image at build time, rather than being
dynamically created or loaded at runtime. These are typically used for
system-level services or core module.

Defined this to limit the polling mode only for user calls.

>
>>  #define FASTRPC_CTXID_MASK (0xFF00)
>>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>>  #define INIT_FILE_NAMELEN_MAX (128)
>> @@ -105,6 +108,20 @@
>>  
>>  #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>>  
>> +/* Poll response number from remote processor for call completion */
>> +#define FASTRPC_POLL_RESPONSE (0xdecaf)
>> +
>> +/* Polling mode timeout limit */
>> +#define FASTRPC_POLL_MAX_TIMEOUT_US (10000)
>> +
>> +/* Response types supported for RPC calls */
>> +enum fastrpc_response_flags {
>> +	/* normal job completion glink response */
>> +	NORMAL_RESPONSE = 0,
>> +	/* process updates poll memory instead of glink response */
>> +	POLL_MODE = 1,
>> +};
> bool is_polled;
>
> OR
>
> unsigned long is_polled : 1;
>
>> +
>>  struct fastrpc_phy_page {
>>  	u64 addr;		/* physical address */
>>  	u64 size;		/* size of contiguous region */
>> @@ -235,8 +252,14 @@ struct fastrpc_invoke_ctx {
>>  	u32 sc;
>>  	u64 *fdlist;
>>  	u32 *crc;
>> +	/* Poll memory that DSP updates */
>> +	u32 *poll;
>>  	u64 ctxid;
>>  	u64 msg_sz;
>> +	/* work done status flag */
>> +	bool is_work_done;
>> +	/* response flags from remote processor */
>> +	enum fastrpc_response_flags rsp_flags;
>>  	struct kref refcount;
>>  	struct list_head node; /* list of ctxs */
>>  	struct completion work;
>> @@ -891,7 +914,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
>>  		sizeof(struct fastrpc_invoke_buf) +
>>  		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
>>  		sizeof(u64) * FASTRPC_MAX_FDLIST +
>> -		sizeof(u32) * FASTRPC_MAX_CRCLIST;
>> +		sizeof(u32) * FASTRPC_MAX_CRCLIST +
>> +		sizeof(u32);
>>  
>>  	return size;
>>  }
>> @@ -987,6 +1011,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>>  	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
>>  	pages = fastrpc_phy_page_start(list, ctx->nscalars);
>>  	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
>> +	ctx->crc = (u32 *)(ctx->fdlist + FASTRPC_MAX_FDLIST);
> Why?
DSP considers the poll memory to be at the end of metadata buffer. The contents
of metadata are in the order as added in fastrpc_get_meta_size
>
>> +	ctx->poll = (u32 *)(ctx->crc + FASTRPC_MAX_CRCLIST);
>>  	args = (uintptr_t)ctx->buf->virt + metalen;
>>  	rlen = pkt_size - metalen;
>>  	ctx->rpra = rpra;
>> @@ -1155,6 +1181,83 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>>  
>>  }
>>  
>> +static inline u32 fastrpc_poll_op(void *p)
>> +{
>> +	struct fastrpc_invoke_ctx *ctx = p;
>> +
>> +	dma_rmb();
>> +	return READ_ONCE(*ctx->poll);
> Is this enough? Is the write by the DSP side going to invalidate the
> cache for this memory location? Think about older platforms which
> usually don't have dma-coherent property in the DSP / FastRPC nodes.
Yes, DSP will take care of invalidating the cache after writing to this memory.
>
>> +}
>> +
>> +static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	/*
>> +	 * Poll until DSP writes FASTRPC_POLL_RESPONSE into *ctx->poll
>> +	 * or until another path marks the work done.
>> +	 */
>> +	ret = read_poll_timeout_atomic(fastrpc_poll_op, val,
>> +				       (val == FASTRPC_POLL_RESPONSE) ||
>> +				       ctx->is_work_done, 1,
>> +				       FASTRPC_POLL_MAX_TIMEOUT_US, false, ctx);
>> +
>> +	if (!ret && val == FASTRPC_POLL_RESPONSE) {
>> +		ctx->is_work_done = true;
>> +		ctx->retval = 0;
>> +	}
>> +
>> +	if (ret == -ETIMEDOUT)
>> +		ret = -EIO;
>> +
>> +	return ret;
>> +}
>> +
>> +static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx *ctx,
>> +					    u32 kernel)
>> +{
>> +	int err = 0;
>> +
>> +	if (kernel) {
>> +		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
>> +			err = -ETIMEDOUT;
>> +	} else {
>> +		err = wait_for_completion_interruptible(&ctx->work);
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
>> +				       u32 kernel)
>> +{
>> +	int err;
>> +
>> +	do {
>> +		switch (ctx->rsp_flags) {
>> +		case NORMAL_RESPONSE:
>> +			err = fastrpc_wait_for_response(ctx, kernel);
>> +			if (err || ctx->is_work_done)
>> +				return err;
>> +			break;
>> +		case POLL_MODE:
>> +			err = poll_for_remote_response(ctx);
>> +			/* If polling timed out, move to normal response mode */
>> +			if (err)
>> +				ctx->rsp_flags = NORMAL_RESPONSE;
>> +			break;
>> +		default:
> What kind of response type can it be? Have you had checked for the flag
> being set, you wouldn't have a false possibility of having another
> response type.
Sorry, couldn't exactly understand your point here. Are you suggesting that as the
rsp_flags is getting set by the driver itself, there isn't a possibility of having any
unsupported response type?
>
>> +			err = -EBADR;
>> +			dev_dbg(ctx->fl->sctx->dev,
>> +				"unsupported response type:0x%x\n", ctx->rsp_flags);
>> +			break;
>> +		}
>> +	} while (!ctx->is_work_done);
>> +
>> +	return err;
>> +}
>> +
>>  static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>>  				   u32 handle, u32 sc,
>>  				   struct fastrpc_invoke_args *args)
>> @@ -1190,16 +1293,19 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>>  	if (err)
>>  		goto bail;
>>  
>> -	if (kernel) {
>> -		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
>> -			err = -ETIMEDOUT;
>> -	} else {
>> -		err = wait_for_completion_interruptible(&ctx->work);
>> -	}
>> +	if (handle > FASTRPC_MAX_STATIC_HANDLE && fl->pd == USER_PD)
>> +		ctx->rsp_flags = POLL_MODE;
> This definitely needs to be explained.
Ack.

Thanks for the review.

//Ekansh
>
>>  
>> +	err = fastrpc_wait_for_completion(ctx, kernel);
>>  	if (err)
>>  		goto bail;
>>  
>> +	if (!ctx->is_work_done) {
>> +		err = -ETIMEDOUT;
>> +		dev_dbg(fl->sctx->dev, "Invalid workdone state for handle 0x%x, sc 0x%x\n",
>> +			handle, sc);
>> +		goto bail;
>> +	}
>>  	/* make sure that all memory writes by DSP are seen by CPU */
>>  	dma_rmb();
>>  	/* populate all the output buffers with results */
>> @@ -2462,6 +2568,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>>  
>>  	ctx->retval = rsp->retval;
>>  	complete(&ctx->work);
>> +	ctx->is_work_done = true;
>>  
>>  	/*
>>  	 * The DMA buffer associated with the context cannot be freed in
>> -- 
>> 2.34.1
>>


