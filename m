Return-Path: <linux-kernel+bounces-721303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C884AFC75D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ADA1BC309C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54914267732;
	Tue,  8 Jul 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIUWvQKo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD58227E83
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968082; cv=none; b=QdOmUXepQ7R7LRcTsK5qrJmXeLC40viHiI4QgkHXQzE4PmRWK9CbpzRcrjb7XYBd0HZp7e26xzCWpnx6xJQNUAftg5V7IOsH1knjYNsMQgbI8FU1VgCn+ZTOD+GkO2F5O5AELrakvf2yclN9L9sTGs/aaHQgJUZ07wPOTq0AUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968082; c=relaxed/simple;
	bh=CP4SRGjBuWIbV/zkWEs61kqCHOr0mrANevngSd/vBGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJ416TE/n4OTd9sQi3im/FSY1MQRIQqii1VrlI1TdIUCsaVcTqrEzmqS5Pu0b2/61kb+hHMcIjZZIqWex1WudQUEwF61uuLrkaukkF4lviros6FR01XVQxyj5DNumnnIB2tlIfxS4F2uOJ99vrYKyy4fGpcc/Unqfm9COFeiG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iIUWvQKo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5683bacm029014
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 09:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	njs/a9YmbrfSj8TquqSQGFpLy4CGvLcOR4JivFTYSx0=; b=iIUWvQKokSiVX8TB
	3rPi1zEiEhuAiEBDT0pmC0KkughyW6E13JZLbd/+VznBLC0EkLnLfiKqmdZCKCzO
	DvBVXnoEqTVv11A6wKupehF+UuTmkJ6Xc4ai9MrR9/73NxBzSHMQB3i7MJKP7oZV
	SqvpOFIItR4PUIJHCW494zdyWMoJjszqHoBaB7IIcF5g7X1S0BiDZXEjILKABz9H
	qtoclGmI8AB+9oeQNDkux/Rc54tKzoDSMbqTgWKuMbww/RBP34Eejxml0VxF4bXF
	Ybzs5r1GI5pDeiTr8CTbnx7Qu4GhZJ3CSCjDPK9VWx1e71BbUJcfs3fp2sAo0NKw
	MG3NFw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47rfq2xkps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:47:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b34fa832869so3823883a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 02:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751968077; x=1752572877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njs/a9YmbrfSj8TquqSQGFpLy4CGvLcOR4JivFTYSx0=;
        b=d47naYufb/CoUXDXJmtGej79m+6j8aNST3Q4UgkV56ptvQpRMPXBmOvtVMbYGJ3Ov0
         F6ULTmMnB7IhvGOuMTKomBuqdegr7DolPUNAgt5hpu0KN/1SlkX0VXi7798uaiXA+ivF
         UTafoCR6cuJqxVaFg9pIihxHD2icPc+o+9qO7g70iG9phtVeAcHvCQtJFbXAHSEX+4ef
         jhIQ1OIp7tWs0dtFMXB5jLZJpnDvJQDzZfgPTeOfMtOd9oIPcYZjy0/An8NdfjWu5xtR
         Ixx7eT5lVBP5KaxawBkjOjgrfuRRFGPoyfOJc2WeMP5LYI6Ud4nLe9aCVblWnAkBcM5w
         w4CA==
X-Forwarded-Encrypted: i=1; AJvYcCUV8UMIk4o42Ccm0SWgaxlAmQ1ktEA/D4nGcRlKO2//La59reOniw4Kzm323rFB0t/QTls93rAY7GHKSjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKhrlvZYoXmV3odJ+7pNcTnKiUK2y9P09qmPm1AQ9bsWVOjGb
	mPhg9ou6VorP9raefqHxasGEMHiUuzVb5QHzPkV1S5fC4zwArhrvAARiVbXQwlruAGo8TG3Okeu
	/bbTL2ihgws7aIYN2e/rnYGmxKfmSMYm5dZsSWx9XZ+DPlH74oTmlgEqYgibfko/mu30=
X-Gm-Gg: ASbGnctaxMH2xNgTO9Axbt5cVIHi34Ij+VFXEcv41d8fmR2FROv0eLTqe2GFlgUCnRB
	sGHwH2nWc+l0V1dzPzfhDIrk7IDz6vGzSXG1xBLD3Rr6bPJynZv7EGrj56YcNuqpHi17YA9486B
	g3kcpkMY5cemLttWM1EYnSMR1QYJQKLZu2s/KiO7aZz9S7BNJTjQyMTL+mVTqPUSRQ5QM/+wGpQ
	NXw9W1Q7q7J9Hg8zjHuAlizuyRXy4rkpbCMJ8x6T+IL+hmpUZ4dMt2m6eI/BexmxPvkoOxEraK6
	ygveVr5G6YmuWEcs/1QGiR1083r8jkhtGR/yuGls+kShDi+dfYZN
X-Received: by 2002:a17:903:2c5:b0:235:e94b:62dd with SMTP id d9443c01a7336-23dd1b2834bmr33312475ad.12.1751968077196;
        Tue, 08 Jul 2025 02:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqQCn0zBoj5m+uABIv+hHMtgAY7o4x29kvnu/P7PJA1PO0G36QZYi2DbfeTjQzqaz+bQRXqA==
X-Received: by 2002:a17:903:2c5:b0:235:e94b:62dd with SMTP id d9443c01a7336-23dd1b2834bmr33312085ad.12.1751968076664;
        Tue, 08 Jul 2025 02:47:56 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455cf60sm104858925ad.98.2025.07.08.02.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:47:56 -0700 (PDT)
Message-ID: <b76cfe82-b977-4166-85d8-368539b392fd@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:17:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] bus: mhi: host: keep bhi buffer through suspend cycle
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Sujeev Dias <sdias@codeaurora.org>,
        Julia Lawall <julia.lawall@lip6.fr>, John Crispin <john@phrozen.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250630074330.253867-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA4MCBTYWx0ZWRfXxsSbU08Sv84W
 Y3PnLSjTBHleWg7BG0VMEvYWYVwKIjNUoSiAAoOxIyWQac7K4ftUm0VgmnXN01pFYK9EBNEMWNc
 UxIHndRM0N9LGosM8YBdPAX6eqr3WgVYuaHn9GmFHEGFWZcGiRaZxdaIBHh4JHSIft85kslzX+h
 MjiIghweaCSNMuNNiICixMuzGMoLUoLyGajKgE3QoLRGU+n7XQ7/Uqk2Z93xfEqZgTPXNI6bz1N
 qMmYKMQ1oxhRTTrwEDLXaaBZjw4gNwIrlxBieeWH0FP4rnAVBxNkKVry5uzhI5slvw1MCT9TqPw
 s6OXm3ixuGMtaKzCN5ci0XqplYG4RVue1b6EiqbznLhJngSfU7ODx0PSPuhSzH3u2SbXlRIKs9s
 6S4slqa78rw+dLpAohJF8jROT5rDc+crBAOUCU3kJtSbE8mWmEBt5JCl/HuYdyV3w9gFXHT7
X-Proofpoint-ORIG-GUID: 7f4-cNTwpH7k0GZRa7Ni9UxFXW1uKcKQ
X-Proofpoint-GUID: 7f4-cNTwpH7k0GZRa7Ni9UxFXW1uKcKQ
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686ce94e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8
 a=B232akhBMsyPXTXv-t0A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080080



On 6/30/2025 1:13 PM, Muhammad Usama Anjum wrote:
> When there is memory pressure, at resume time dma_alloc_coherent()
> returns error which in turn fails the loading of firmware and hence
> the driver crashes:
> 
why only bhi? bhie can also have same issue.
> kernel: kworker/u33:5: page allocation failure: order:7,
> mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
> kernel: CPU: 1 UID: 0 PID: 7693 Comm: kworker/u33:5 Not tainted
> 6.11.11-valve17-1-neptune-611-g027868a0ac03 #1
> 3843143b92e9da0fa2d3d5f21f51beaed15c7d59
> kernel: Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
> kernel: Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  dump_stack_lvl+0x4e/0x70
> kernel:  warn_alloc+0x164/0x190
> kernel:  ? srso_return_thunk+0x5/0x5f
> kernel:  ? __alloc_pages_direct_compact+0xaf/0x360
> kernel:  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
> kernel:  __alloc_pages_noprof+0x321/0x350
> kernel:  __dma_direct_alloc_pages.isra.0+0x14a/0x290
> kernel:  dma_direct_alloc+0x70/0x270
> kernel:  mhi_fw_load_handler+0x126/0x340 [mhi
> a96cb91daba500cc77f86bad60c1f332dc3babdf]
> kernel:  mhi_pm_st_worker+0x5e8/0xac0 [mhi
> a96cb91daba500cc77f86bad60c1f332dc3babdf]
> kernel:  ? srso_return_thunk+0x5/0x5f
> kernel:  process_one_work+0x17e/0x330
> kernel:  worker_thread+0x2ce/0x3f0
> kernel:  ? __pfx_worker_thread+0x10/0x10
> kernel:  kthread+0xd2/0x100
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x34/0x50
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork_asm+0x1a/0x30
> kernel:  </TASK>
> kernel: Mem-Info:
> kernel: active_anon:513809 inactive_anon:152 isolated_anon:0
>      active_file:359315 inactive_file:2487001 isolated_file:0
>      unevictable:637 dirty:19 writeback:0
>      slab_reclaimable:160391 slab_unreclaimable:39729
>      mapped:175836 shmem:51039 pagetables:4415
>      sec_pagetables:0 bounce:0
>      kernel_misc_reclaimable:0
>      free:125666 free_pcp:0 free_cma:0
> 
> In above example, if we sum all the consumed memory, it comes out
> to be 15.5GB and free memory is ~ 500MB from a total of 16GB RAM.
> Even though memory is present. But all of the dma memory has been
> exhausted or fragmented.
> 
> Fix it by allocating it only once and then reuse the same allocated
> memory. As we'll allocate this memory only once, this memory will stay
> allocated.
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: cd457afb1667 ("bus: mhi: core: Add support for downloading firmware over BHIe")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Reported here:
> https://lore.kernel.org/all/ead32f5b-730a-4b81-b38f-93d822f990c6@collabora.com
> 
> Still a lot of more fixes are required. Hence, I'm not adding closes tag.
> ---
>   drivers/bus/mhi/host/boot.c     | 19 ++++++++++---------
>   drivers/bus/mhi/host/init.c     |  5 +++++
>   drivers/bus/mhi/host/internal.h |  2 ++
>   include/linux/mhi.h             |  1 +
>   4 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index b3a85aa3c4768..11bb8c12ac597 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -302,8 +302,8 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
>   	return -EIO;
>   }
>   
> -static void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
> -				struct image_info *image_info)
> +void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
> +			 struct image_info *image_info)
>   {
>   	struct mhi_buf *mhi_buf = image_info->mhi_buf;
>   
> @@ -455,18 +455,19 @@ static enum mhi_fw_load_type mhi_fw_load_type_get(const struct mhi_controller *m
>   
>   static int mhi_load_image_bhi(struct mhi_controller *mhi_cntrl, const u8 *fw_data, size_t size)
>   {
> -	struct image_info *image;
> +	struct image_info *image = mhi_cntrl->bhi_image;
>   	int ret;
>   
> -	ret = mhi_alloc_bhi_buffer(mhi_cntrl, &image, size);
> -	if (ret)
> -		return ret;
> +	if (!image) {
> +		ret = mhi_alloc_bhi_buffer(mhi_cntrl, &image, size);
> +		if (ret)
> +			return ret;
>   
> -	/* Load the firmware into BHI vec table */
> -	memcpy(image->mhi_buf->buf, fw_data, size);
> +		/* Load the firmware into BHI vec table */
> +		memcpy(image->mhi_buf->buf, fw_data, size);
> +	}
>   
>   	ret = mhi_fw_load_bhi(mhi_cntrl, &image->mhi_buf[image->entries - 1]);
if mhi fw load fails didn't we need to free bhi buffer.

- Krishna Chaitanya.
> -	mhi_free_bhi_buffer(mhi_cntrl, image);
>   
>   	return ret;
>   }
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 6e06e4efec765..2e0f18c939e68 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -1228,6 +1228,11 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>   		mhi_cntrl->rddm_image = NULL;
>   	}
>   
> +	if (mhi_cntrl->bhi_image) {
> +		mhi_free_bhi_buffer(mhi_cntrl, mhi_cntrl->bhi_image);
> +		mhi_cntrl->bhi_image = NULL;
> +	}
> +
>   	mhi_deinit_dev_ctxt(mhi_cntrl);
>   }
>   EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 1054e67bb450d..60b0699323375 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -324,6 +324,8 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
>   			 struct image_info **image_info, size_t alloc_size);
>   void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
>   			 struct image_info *image_info);
> +void mhi_free_bhi_buffer(struct mhi_controller *mhi_cntrl,
> +			 struct image_info *image_info);
>   
>   /* Power management APIs */
>   enum mhi_pm_state __must_check mhi_tryset_pm_state(
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 4c567907933a5..593012f779d97 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -391,6 +391,7 @@ struct mhi_controller {
>   	size_t reg_len;
>   	struct image_info *fbc_image;
>   	struct image_info *rddm_image;
> +	struct image_info *bhi_image;
>   	struct mhi_chan *mhi_chan;
>   	struct list_head lpm_chans;
>   	int *irq;

