Return-Path: <linux-kernel+bounces-765764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25767B23DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6AE07B5169
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DA189F43;
	Wed, 13 Aug 2025 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6K/66g3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117F1A23A6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049935; cv=none; b=jrjw9MjW6ISWD9tPs7tylfnZGtCEa1l6GZCWX5HOHCRLwRYhcy119rXXQMGq8GFf7D81dlC123885yoPKu7O/HdpMNXq8X9L0TdWm4y/inMu3sDS5IBkTAJ9S461BBonn8FScZI/pBC6WdGDLWsuw2xuL07efhJhLqGcL0geR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049935; c=relaxed/simple;
	bh=Ll38zC0TgNNSiE/fnE9zoGdtVW9LNB6w2+NMjU+NjC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sj0xdK42Glz+sEfhmVchZwE+yJuiFcsW+wawRVL5NQ7UvXPCJkp6e437Y80ljxlIwW2d8kUJllyawe3GCyOuLsIIqO3lpZQo0f2ZhqzQ0JxbU7dx0IO3gmMb3RXOFEQkFfr1tzQylUCmbm7sHm+O8sHRQ9r7toLit8TdyWsqt+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6K/66g3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CM6l5E032241
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=azzIjnnFrhGZepf8cF63On31tVI6l+R0n7SE8DktVtY=; b=B6
	K/66g3ltbZTioLlekcBRWaDkXKx5FaDf29+mwd6bhANi2CiCGfU/pSSR0t1FwC+p
	/iEKACkRvSPcaiJVxDDu/SPP+qLBEp5+AMSbbXX4sldx6dqBLx/lgwIpVEcunWOQ
	4Tti/eM8A9U/rqgDs9cBWNgzx4qvIVFYPlxWvZeOK6Ck1qfR/2Z/C72SPPNDJIl7
	m5BVknnQhhKkwz+82zvQ3Bwmht0Yq3ci2NIIMJ/8RGgI6jgUJ4KtLUfGU2te+jha
	YQ2161nV9Z1wFmmaSQpvez/7MQ6k3qgPbM+cdUedVBrdTtr1PNEqasPezSRk2hfr
	f7UQIuTY4HYiHLgx/bMw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vmynv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:52:12 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-74194815b75so1606726a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755049932; x=1755654732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azzIjnnFrhGZepf8cF63On31tVI6l+R0n7SE8DktVtY=;
        b=QV3aM0DCrFZQZSrjdJxq1fE2tu7lL6j6Nprs5atWb8PPInbyY4Ph5LV7odEjsJRqEW
         n9arN04PoFkuJqKCRN0jOyipC4vMq7xTf8aQ8EDmEzzlSxhhJvqEUFWXg8L9bPkREpfH
         bsTnW+kKvOHAAvVG0+AwGs4N4H3PUPur2FVw5Wp4GVcYpmfG+8zHnCTwUx+4VDYmW3K9
         WcuFZDv9U7KX6+gOg/gAcpmCjEqrpyc9kvBkLZvdaLSFi59vVjbyVvsIYDYFRIlng+I8
         JPm5gW9sD8/Rf+63lc7h0sCWFAvmn+SH1DAWd/VGh2E1npwO/l00TucHekEiZoFOK5MH
         cnXw==
X-Forwarded-Encrypted: i=1; AJvYcCXd1hvcyIMpoAIstZKq04cnHHPdmr8Cj/JhwWVPQAfms+RvkHK1SlS2fr7qh+NKkTPAEAfW32i3D3nwiio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQ03Y/Z9lSnCR9LcUBWgrtyjaXHzVW9+pPG3O7Z9WV9b9luZW
	Cfy0VUBaPgIseOmoPo3/rS/tKqemN1/Ns786eGNqPX9CWR0s3spULos8unONfbNwEalIdhdsgWO
	ld/+MQpzGlFuZNWi6GNZBI1sKvlnHpnAqbBmbKg3B3Jio5REzCQQxBAE9tJFYlFhZCXhDZrhgCU
	3f/Hw7bR0ghYFF7/w+JNIXx1bwcDHVsbDr1SvlJmiQLg==
X-Gm-Gg: ASbGncsOr+Pp/Itu+lQgi/m8OpwW20FpEJiizYPMUefNgD6Z+3oqLU6gJ1BgMENP7UA
	f7B65sVhwc+Sr9Lfnn+FRhV/Mz6f2Fu429y9oUaQJtgTu/pdGQlP3p+5pq7yTmkOz9++XOIC3nV
	X5cWQVdmJPd4PccQ7Wr7I=
X-Received: by 2002:a05:6808:22a9:b0:435:7090:b652 with SMTP id 5614622812f47-435d42a2575mr1191294b6e.34.1755049931465;
        Tue, 12 Aug 2025 18:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+oxwqW5ocHWrqoj/uh9nhQTzkltL6bf5O3y495PvLUQY65I8XhC+SpjSkN+0X4azk5mUzEknXbe5Iorw4nT8=
X-Received: by 2002:a05:6808:22a9:b0:435:7090:b652 with SMTP id
 5614622812f47-435d42a2575mr1191273b6e.34.1755049931074; Tue, 12 Aug 2025
 18:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629201530.25775-1-robin.clark@oss.qualcomm.com>
 <20250629201530.25775-15-robin.clark@oss.qualcomm.com> <b0a36f3d-706a-4622-89a1-f88c6255e4fb@dakr.org>
In-Reply-To: <b0a36f3d-706a-4622-89a1-f88c6255e4fb@dakr.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 18:52:00 -0700
X-Gm-Features: Ac12FXxxd6WCPyXXb8MbyAX1gkPmIUnWgdFOtYCj3v3CcVsNgXCk29Md82IFzps
Message-ID: <CACSVV02+hE1j9vN_BU5pwz_4cnJjj==j-L5oPeFWCvEr+1HiFQ@mail.gmail.com>
Subject: Re: [PATCH v9 14/42] drm/msm: Convert vm locking
To: Danilo Krummrich <kernel@dakr.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Connor Abbott <cwabbott0@gmail.com>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Danilo Krummrich <dakr@redhat.com>, Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX3xYqGP7j6UY1
 lXeAAKtEDYJdSEx6JtzBDSkK7hLpCE1j3gb2/2Cw4mTHOlrd5LCaNrAM5Y/8bhsdz6jWKH1UJyb
 AHU9RsOTlllrvtT+e0J6ofoJZ0eKuR5t7Tl89POUsL2amh9XQeUjsmD4I44O/IL2+m5LfVEDuda
 qtGnULO9L5YpdLms5NCp+2wsiGkaDzwc1pXz0yXDXqRdE7vgcK4RwnL5gy79LH8bI9jpiUwPu7X
 ZzcTL1teREIrdb9Vemn8Dh6moXcfdwvoJo3OVHhIgHDJ7Epscdq/1M1Jv5DhAxR6/hN2gY7uWKx
 i57fmLs4CItsIR8irbDHaGSzsfWaSqpYrAVD7oTz3/dyLYB/+70puYZtIwPGjqaxM/bLX/MhQh/
 5bIlFqQM
X-Proofpoint-GUID: a789vhA9IYdeIRNGttmJB9oD4-3JvTEc
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689befcc cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=P-IC7800AAAA:8 a=pbUkqq1XAAAA:8 a=Dc8E7AEoan46jiKjpnQA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=d3PnA9EDa4IxuAV0gXij:22 a=F7rrpbw-2xKc1p48v2RB:22
X-Proofpoint-ORIG-GUID: a789vhA9IYdeIRNGttmJB9oD4-3JvTEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

On Tue, Aug 12, 2025 at 1:58=E2=80=AFAM Danilo Krummrich <kernel@dakr.org> =
wrote:
>
> On 6/29/25 10:12 PM, Rob Clark wrote:
> > +     /*
> > +      * We mostly want to use DRM_GPUVM_RESV_PROTECTED, except that
> > +      * makes drm_gpuvm_bo_evict() a no-op for extobjs (ie. we loose
> > +      * tracking that an extobj is evicted) :facepalm:
> > +      */
>
> Yeah, it's a consequence of this locking scheme and I really hate it. How=
ever,
> you don't entirely loose tracking:
>
> The next time you call drm_gpuvm_prepare_objects() it will be added to th=
e list
> [1] and hence picked up by subsequent validation through drm_gpuvm_valida=
te().
>
> [1] https://elixir.bootlin.com/linux/v6.16/source/drivers/gpu/drm/drm_gpu=
vm.c#L1154

Hmm, maybe the issue was with legacy (non-vm_bind) contexts, which use
drm_exec directly for locking?  I guess I can try to revisit that..

BR,
-R

