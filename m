Return-Path: <linux-kernel+bounces-750738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0DEB1607D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A74F18C78BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AE5284B46;
	Wed, 30 Jul 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FV2xlWgv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5B4C62
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879339; cv=none; b=Il2kfb4ssqC/Jb7MTWw8rKE08hhiD6AMs1hDg170SklAXJXwlRlZxV1QXnl4O7pM3hF0M52npkxLJIvcQuV1kXXXEONJ4nARrJo6Jy8La7VNSKW1TLyiPlEV/BGQ8ZuPoRK/8LwkzpZtPnurwE44ZuGAEy0igKCtVAe/VemiC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879339; c=relaxed/simple;
	bh=ej2jAZXHD3CR51aB6MhT2IrGL51IuHJFJjrTmCg8PBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHnPe04AeYdpr27GMX+ucccC6newWEpaGVEvyzXgro2bDKoWBk4M/XIRVerSnvIUtN0tuRkbgFLclBhpNbJZKQWJbMFgjcbkeYYnnuJY8v3ILS8uqj6nqBOIyCtvR1tCtnywAf5sufZXR/2MZy9B+5StrLX0OSTIdPVtk1bRCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FV2xlWgv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbf5l013128
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fw0Nq//8TJeaMcoqBVD1XDiUZJiNPaWvyceervP8S50=; b=FV2xlWgvoFrtrTl4
	0FUccwK41s9YKcMWn/9H8oDqequJWxvn5uz4x3pKKU9709esbw9aQ3jUe5YsAe9T
	2Cam41VqIHyQjCv2lJiaYNcyhoRJzZW2dn+nIMguS6tP6KPZRc0uvi/evsXXGfEw
	aY/CT1oaSLhzaeOopzspWAg5jhx4YaZ5OIV9o4YWmpiSApwnryuBWTADiqQU8L0z
	j0ElIfhUdRP1RzGzmoJ+d8Be/H+3Z/rVyfkgbUzbc87J/YDFKKPDSj8UCxmRsqC2
	LlODJ6yVRuaw4jWvsA7lqyBkkHETAfQZcVsthd+r/pZghaJymnchQ8+C+ei4RT+d
	7wF/Xw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm3n8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:42:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70744318bdfso87111926d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753879314; x=1754484114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fw0Nq//8TJeaMcoqBVD1XDiUZJiNPaWvyceervP8S50=;
        b=e0rGo8h/ymMFN8J5lhLt0NtzqzDA8mPxLIv3bvxuPDOWkbmdEBviflwSqpZMx17CNG
         afKZtlx5+leTwqPeW72qdv7rKzCE9c/wPoWJCMHuqbZgGParYxuu6v1qQN5WuB4NFelI
         1293ATfzw8h4bChJn4jsm9XxUA10eGrVoaSw54fMzwuz2ZOU7yEyiYPvDhSVtr0Vtm6C
         RnfiV3dCW4DbBverppEFlKETwe28sQUCFkkQG4lmf/bU7cgdfaEJQaYWzgVnQ+i//E1S
         DhHSPGAjL8oehxd+KbMeCp3qP+BFecuh/7T2/p4jszyzVOTYqAvjdTWr2yx+0AE1uqdz
         ealA==
X-Forwarded-Encrypted: i=1; AJvYcCUTtwEEKU/xVIhzc1lPj4bE4Twzui4QRb6bolA3g6a1ABTnjC/wc2lPhwIItll/9/nv+R/OIUgWpCiod8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVCNr+IVCIB10vVSXBQI0hyRdzTluE04lsaqLzKhuSIWfF14Yj
	ZdQ+QgwX31zrQYul5xPuShZaDz9E/iKRoqSmj4OW/Ih+HGcGuMM5r+kh3HM+ikosFT3GfVD4I3T
	4wC+8HEZBJWMSia0ZsDYE111refV53sD64PSlDZ9uSQRTawfUBCu1acJH3kFGjhST8jg=
X-Gm-Gg: ASbGnctzMKArrFs/4c8Ly5+tJ5iMitTzwx3NoQHcZa14i1wRdFP79IS0E+3DxY6V2VV
	O4eMwSrFo65bS5rmfKurfeItoIgW2zZp6kTO+pBLfV2YQxc04FzqZO0I4wQoyrEHQsWh2oFLzsp
	pMzBJ/4AZmHhddgJMgEohen8mDNl48asGJYCuTQOvnrkacw5SeKtQoC+3CgP5XlKWizoCuEFGki
	QUU63jLoW/zyA2xfPUDlfmtUIzA/R/aAOPfwwthFyAY602mYvypz9hLXG5Hlb9S+DdI1RqA76JQ
	HKJ54Qp3/UdxIyzh9/wxmy9BwvIQC0UA8PgqGaTR5PdX94BZ+VmmyQ==
X-Received: by 2002:ad4:5748:0:b0:704:7fd7:c06b with SMTP id 6a1803df08f44-70766a306f1mr41865466d6.0.1753879314435;
        Wed, 30 Jul 2025 05:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwxqKkPYbo6gXYoqf4jwmpjKXAD+kDy6CQkkaDMpJcj/hKiqPHZkPvdDAci01xd9R9KaCuUA==
X-Received: by 2002:ad4:5748:0:b0:704:7fd7:c06b with SMTP id 6a1803df08f44-70766a306f1mr41865076d6.0.1753879313996;
        Wed, 30 Jul 2025 05:41:53 -0700 (PDT)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635860103sm752819666b.14.2025.07.30.05.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:41:53 -0700 (PDT)
Message-ID: <1c10917a-c035-4cc5-9b83-b98f009b5f5c@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:41:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 1/3] virtio: Add ID for virtio SPI
To: Haixu Cui <quic_haixcui@quicinc.com>, quic_msavaliy@quicinc.com,
        broonie@kernel.org, virtio-dev@lists.linux.dev,
        viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdanton@sina.com,
        qiang4.zhang@linux.intel.com, alex.bennee@linaro.org
Cc: quic_ztu@quicinc.com, matti@qti.qualcomm.com
References: <20250725094144.1783243-1-quic_haixcui@quicinc.com>
 <20250725094144.1783243-2-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <20250725094144.1783243-2-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688a1328 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bs-e4Z8cAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=ArcK2n1sfW-e6Le9QZEA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=YFpLQiK6rFjqGb8m0bXF:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5MSBTYWx0ZWRfX/qhD8ahGh3ZW
 fis7nHZ7iwNqA72FmVEiYHbplpQmbbdaZ0N8Z3m04H8z4nwS4/yf8y5xEcD7QBM9teT3aS0bFg4
 AYrARBALtQaPBPQrbup5Rt+etBxUqXJ2bCjJ/V4K9O6MPFcpZPpxpAVhZ9JCYH61SUV4zSS8PYL
 kU8nURMVF9vxdR0pQh6jKlkKFlO31cAKyQHf2H+cUVi+62ArstMvPy7g66hHe47LxPEaz+d4rys
 Fciax3qybB5kUlSkCeQPippxEmSIL9k9YLTmhkY+xazAY7O6xL4EuZT3ewfcTpcou6yYhPz5QG0
 s+vRsRXx49FGAM6Jf1Kpz37W7NEDIiKd5bV92yJOP4fOnc6OjGYieq3bj7jwsR18HDnhxvu9g56
 frKYEaW8jOircyhva+WYTMxZaFZj4CPQbf+CSBVVvFlkV7kkCAo69YizmeKYl/xyi6u0RU3S
X-Proofpoint-ORIG-GUID: _BW5ARwAvNd9NXVAZbGB1riPP3h3jrSM
X-Proofpoint-GUID: _BW5ARwAvNd9NXVAZbGB1riPP3h3jrSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=966 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300091



On 7/25/25 11:41, Haixu Cui wrote:
> Add VIRTIO_ID_SPI definition for virtio SPI.
> 
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>

My new E-Mail address: Harald Mommer <harald.mommer@oss.qualcomm.com>

My old OpenSynergy E-Mail address is defunct now, nothing is forwarded. Thought a moment about this but it does really not make any sense to keep the old E-Mail address in the Signed-off-by for historical reasons. Best is to update this everywhere where it occurs in this thread.

> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 7aa2eb766205..6c12db16faa3 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>  #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_SPI			45 /* virtio spi */
>  
>  /*
>   * Virtio Transitional IDs


