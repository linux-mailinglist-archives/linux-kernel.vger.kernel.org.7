Return-Path: <linux-kernel+bounces-750671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC29B15F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1077ADD98
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CC0271442;
	Wed, 30 Jul 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EY0p8jSE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B4DF49
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875136; cv=none; b=DBRSisPX5eP+wOglCmArwn0EQILFh6SzzrR7D3btA58jP3DurYiRC+Hv/ZWu8GMR6hMg9yI3fAm0lGggwfJYjb2WtgjLeVWmLd4C/FhuBjDmF24okfR89YZ1ecYw1YxPVQzxc4HXT2Eh0oKIZcaNwlQdV9F4tz//oWiUeTU75Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875136; c=relaxed/simple;
	bh=sA7CIKx9JtzmSMrlgZzAhDloWbQe41uj2nnOzD3lqC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQev4YkMgJpVodimpIm+0Hyzj0jmykn5WaS1uY20Pxwdon+vffkNsWEpsJgf7Lwy/ahlN+uqnzEpsVrCE8JNeRGTrQzvhaZKcOQxV5KB5rJHbJIM6ocJLtpKp8uCaJhdp6ffX5dgr9pKRZ7dundWCESL9ERNTpw8/5t8+aFTobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EY0p8jSE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U60ZDt023457
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QhSrLEfIXPGfZv83U+5DPeP/WgOAi6APpH7KJyBiwWM=; b=EY0p8jSEYUHt0xEM
	wT38sEMWwjirgHXIcobjApSZx0a1+N1tbZLT2A7ZKcSsI3yycqXLqVo1jLGTYjaX
	U7z1diKt688I3Q+7cKg7rrNBI8D5mQyqnG2KdqPz8aVYhX2XxQ0MJAqmbnwwE3i1
	alAfby0KBdYUN8kFRdhFeE2h8k9bkRatBrV8w9oibskcVFYaUquQ1Dl/lwr4rvrO
	UKwzWruk9hfsht3/eR2m0mUV3MMTQLLLikYdTSDMkkR29+W3QKbNm87RRMmA1xK6
	iFzzP2dTjORcAlDGygQrEln02qk9QJb+5kFRX0Hp41MCGH6zC6Q9El8wm6HhkQVR
	NjMyzQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6quje8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:32:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab7fb9c2d3so78608911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753875115; x=1754479915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhSrLEfIXPGfZv83U+5DPeP/WgOAi6APpH7KJyBiwWM=;
        b=wM47VIP2M+74a/QypPA6odVGiKNRsazerDi7xImbOxwlM5B0iepDMVBRkKHVBlxJWU
         yBL2odzgWlPkA6tLQZBnjVAtr3aTs+/fXhUviHrzONTm0z9WErEwVLrTOOhsNZhsgXEx
         S7NHtSzs4wx6vV5/jOvjFJcW2B/oBQDyFaf6Cg7N6XrjraFUh2sE0TY/OG0YjWcR6uUd
         CTa6xKOmFAZ08wYu6AsIetmIDXkmoALvvSo67kiCU+UHJW60zIQ4P66k/zKcx+PwAEpw
         acmAb4qjOOUH8BawlllLaFWRpLwgF3AVQeZdBhCpa3rqMyC71U2MnI8/b1+YOjcuWcJ/
         MDXw==
X-Forwarded-Encrypted: i=1; AJvYcCXJGE90PMMnDe9b+2bpHdLX4ejqLbFF2/1w1kGDg5/Mn3yw1FvWVoCZ0ANJuiDev3hRxZqCNU9UNc+Iidw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcR3nKLJV/10UfblG5W95+MrgMiBuVPtBI8uPWG6peaNS/UP0
	5uK96Q8+0Ysb7IouhAilkRaYTyDm2jWSCx+B2vPKUPZro3cijwRCWSOiqSLUN1MgYbysibzQqwG
	92kCPwz+DXmpUNh/wgb9Qupyzd6iLY7QqnqgWfBxvdnrY0nXnrFRf03TgT+Q3ISkn4ildbAkO2z
	9yzv8hgp4cV2G47KBB6+JoJPWvwMtzbh8Gm10L1FcDaw==
X-Gm-Gg: ASbGncsUeIEpm1ABnTYujx2igokQOZ34WDsU9VImSc4gVbKL+G0a6eqvtRb5z/JqhEU
	yWuBvbSJfRnMEVAD8SNoErCGZXD+RWvZar5Q/hbb0+TzaPw7fIqpJgOkS9QxnIpCB0OGAL8F0jK
	d5PFgaNe0EWK/XA0cc6pXNJfI=
X-Received: by 2002:a05:622a:48:b0:4a9:cff3:68a2 with SMTP id d75a77b69052e-4aedbc3c0dbmr45844351cf.37.1753875115145;
        Wed, 30 Jul 2025 04:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgI5SCKV8YtZM/zSBddSyK33G/A0zZdCkH+fwXiqzGFN+iNvRWAG/BAy5IoAavwJ1ONWgDHWYMIrONjqdvfzY=
X-Received: by 2002:a05:622a:48:b0:4a9:cff3:68a2 with SMTP id
 d75a77b69052e-4aedbc3c0dbmr45843831cf.37.1753875114586; Wed, 30 Jul 2025
 04:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-eud_mode_manager_secure_access-v7-1-40e9a4569895@oss.qualcomm.com>
 <2025072446-ensnare-hardhead-12f5@gregkh> <CAPHGfUMnaJ8HPX=CC_q6m2nbq-ODP=MY_NkcvHjXR8mD9b=tBQ@mail.gmail.com>
 <fo4hek5twtgl7fa5ncqefatowz5nw64iwifaibl3yyzonucpqz@uwwxf5jdke2x>
 <CAPHGfUOusGDDumM81ZwfWCT+4H6ku2rTgYw4Wuz3KduZ96KhXg@mail.gmail.com> <2ee9a4c7-f971-4b73-8c83-cbb26c7072fd@oss.qualcomm.com>
In-Reply-To: <2ee9a4c7-f971-4b73-8c83-cbb26c7072fd@oss.qualcomm.com>
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 17:01:43 +0530
X-Gm-Features: Ac12FXzgLcQ2yizHuwssmnQfXHgYZ2NUuPDYJso_5m2s0XS8PzpGLEfywe7jhjE
Message-ID: <CAPHGfUMcuXNtGiTmEFi0BvFkc9CvC9JfX8SFVKDg0-qytC2KPA@mail.gmail.com>
Subject: Re: [PATCH v7] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through
 secure calls
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4MiBTYWx0ZWRfX7A9BFBJ/LJ6F
 /VfAWJ70MH9bXa/MYi1f9k+I8jPQIuqtlA8q8wLvxOmK8jVuVSDN+ajhn49mzGAm/xMTQ56VwdT
 Z5m+aTefu1AqUP17PS5/Cbfl2aPveb8PAsuzWYzYrGyXPYUnflc4wieREt0K9DYH+e80C8rIkI+
 IbJFx3AyI9VmuFtVmZgl69A9UhAwxUXGt6aLgbzfgnF+Xe93Wu+Irtq+jLJ7aRJ5ngZ6t8DmUdu
 WK3IKA7qBZ6Frvn46zl5rlEJo3rUeX7RA4JeUs4ICk396JejQ1W+2+bAmqcBEr2lyt0bImSkoCv
 xpRUFCzE4C/9LJtN/l8rWGmweowzN384y4HrkDi2PHqfEJ2jJY8+R2nXZP4TxeqdEC7l2Um4yi7
 UdAWD9Nf35ohe9s5FFVG7MThH+L2q6RH+ckUPGQPMLXm3fq40dpY4afVw4/eOOuLPfBHPz0S
X-Proofpoint-ORIG-GUID: Kl3HOqlYv_ApfsIPJ1jUpr4swJzGsZHm
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=688a02bc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=ag1SF4gXAAAA:8 a=COk6AnOGAAAA:8 a=nCA0bClemygIX1r7OBYA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Kl3HOqlYv_ApfsIPJ1jUpr4swJzGsZHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=957 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300082

On Mon, Jul 28, 2025 at 4:00=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On 28/07/2025 13:19, Komal Bajaj wrote:
> > On Fri, Jul 25, 2025 at 7:07=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>
> >> On Fri, Jul 25, 2025 at 06:19:21PM +0530, Komal Bajaj wrote:
> >>> On Thu, Jul 24, 2025 at 3:06=E2=80=AFPM Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> On Tue, Jul 22, 2025 at 05:01:53PM +0530, Komal Bajaj wrote:
> >>>>> EUD_MODE_MANAGER2 register is mapped to a memory region that is mar=
ked
> >>>>> as read-only for operating system running at EL1, enforcing access
> >>>>> restrictions that prohibit direct memory-mapped writes via writel()=
.
> >>>>>
> >>>>> Attempts to write to this region from HLOS can result in silent fai=
lures
> >>>>> or memory access violations, particularly when toggling EUD (Embedd=
ed
> >>>>> USB Debugger) state. To ensure secure register access, modify the d=
river
> >>>>> to use qcom_scm_io_writel(), which routes the write operation to Qu=
alcomm
> >>>>> Secure Channel Monitor (SCM). SCM has the necessary permissions to =
access
> >>>>> protected memory regions, enabling reliable control over EUD state.
> >>>>>
> >>>>> SC7280, the only user of EUD is also affected, indicating that this=
 could
> >>>>> never have worked on a properly fused device.
> >>>>>
> >>>>> Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedd=
ed USB Debugger(EUD)")
> >>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> >>>>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> >>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> [...]
> >>
> >>>>> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> >>>>> index 6497c4e81e951a14201ad965dadc29f9888f8254..73ebd3257625e4567f3=
3636cdfd756344b9ed4e7 100644
> >>>>> --- a/drivers/usb/misc/Kconfig
> >>>>> +++ b/drivers/usb/misc/Kconfig
> >>>>> @@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
> >>>>>   config USB_QCOM_EUD
> >>>>>        tristate "QCOM Embedded USB Debugger(EUD) Driver"
> >>>>>        depends on ARCH_QCOM || COMPILE_TEST
> >>>>> +     depends on QCOM_SCM
> >>>>
> >>>> You now are preventing this code from ever being able to be built in=
 any
> >>>> testing systems, including mine, so I don't even know if this patch
> >>>> builds or not.
> >>>>
> >>>> You did not even document this in the changelog :(
> >>>
> >>> QCOM_SCM is essential for QCOM_EUD for its functionality.
> >>> One option I'm considering is using select QCOM_SCM, which ensures
> >>> dependency is enabled when QCOM_EUD is selected. QCOM_SCM facilitates
> >>> communication with secure world, this approach should not cause issue=
s even
> >>> when COMPILE_TEST is enabled on non-ARCH_QCOM platforms.
> >>
> >> QCOM_SCM is not user-selectable, to it is not correct to depend on it.
> >> Have you had used `git grep`, you'd have seen that absolute majority o=
f
> >> the drivers uses `select QCOM_SCM`.
> >
> > I had initially used select QCOM_SCM in an earlier patch, but based on
> > the concern
> > raised about enabling it under COMPILE_TEST on non-ARCH_QCOM platforms,
> > I revised it to use a depends on condition.
>
> QCOM_SCM can be selected on non-QCOM platforms, so there should be no
> concerns for that.

Understood. I will update the next patch to use select QCOM_SCM accordingly=
.

Thanks
Komal

>
> >
> >>
> >>> Alternatively, I could use a conditional depends expression like:
> >>> depends on (ARCH_QCOM && QCOM_SCM) || COMPILE_TEST
> >>>
> >>> This would allow the driver to be built under COMPILE_TEST while ensu=
ring
> >>> QCOM_SCM is present on actual QCOM platforms. However, this would
> >>> require proper stubbing in the qcom_scm driver to avoid build failure=
s during
> >>> compile testing.
> >>
> >> --
> >> With best wishes
> >> Dmitry
>
>
> --
> With best wishes
> Dmitry

