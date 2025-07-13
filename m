Return-Path: <linux-kernel+bounces-729051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73032B03116
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C4F1897FB4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A91E500C;
	Sun, 13 Jul 2025 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULnlX0DF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AD8F58
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752412605; cv=none; b=MM2m8A81WVh5CR9kXXVV/1NjuCY0XIOeIf4+IssiZDTkSE8PApeWtdEOynL8+xzndNAQRDgM+7Hsc6m8kHYagfAcdc7+Z6YoKx+9nliD+KwVT9Fg/Yp5j0HjAH1qJ/YUf/HS0X69Z9A/io0fTvoSwU1zqVIcfsNSAE3ThwehML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752412605; c=relaxed/simple;
	bh=bQRf+gZrYzxxj6RxPTQT/0OmyL+eq9kkMld0hhhnwXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E50uoIIwlKlrgcXqp+I7O/nSQ6zcFhgoEkkCFnc2e1RUEmS3HIf7HIc6wKqW/KLKXCXZCDDdX9T9OaHoO9w5pArqBU/kf/HxgPLkMOIJTWFp3Xzu/4iVsWayyAB7yWwJw6hIF8Q1VHFcAzhUQ25k/SPvgcD4RI0pWPiGo2MX8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULnlX0DF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DAPTe0031626
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 13:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=bTUx+VZ4YLVbV9D1AWkOK6pRuT0f7GMSlVwY3D452HQ=; b=UL
	nlX0DF5b+61nX7zTfN7F5d7ks+Plznjmaf/qz74NyHN2wQ5nyRAShZ9pAlPxsjQ6
	fbiHuCTENTFtvOZE05onoO1ePrwO7965IAKw6FFPIwlA337NwfZJG1/IFuX2w6t5
	+ONrzCTcK3rQ8S7jadlmYot6db5h3UpdXPjTYErRUF6Z+jHJY4DWhPhUupuXBl5X
	qBVCSewMyPU2IHCgM2ylBfK2XERhWJLGDEE7z9srf+gIubKagQ5bTMVUqMo9J8mB
	LoR95awqTj6LgyHJiZfujgYRoAXCihgStegcXdpO5u1CzCCWzj0ymJpw4PFXjpGg
	bCwZUeMxePFY3bHrQV/A==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufuej67a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 13:16:43 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-40b0096024eso4013198b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 06:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752412602; x=1753017402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTUx+VZ4YLVbV9D1AWkOK6pRuT0f7GMSlVwY3D452HQ=;
        b=tCL5/T4TEuDmeqjfZ7WHru0iXH6L4tI3Z7toF32drjcnvPiBct2kOt7TwbIZFRlrlK
         zhPasYnrIpbHLyaKABNqfRFZYedpcew30zhCywhtrZZ4+QVt5Gx9CDCsWuZzIQxRBcPx
         c5saHVTq7NIcl99RdlspYGzIGxYzXA9nhjei/wUGXRO3pYafHpZDWdlgajiF+AtOL2ud
         WaQO5sgEB004DjoFhrGmYRNSCA5/6TZfkgm05Kd1iEswN11McsfaWmnT6flNvd1qV+pj
         Z/DnKa2iH3kCCbXmztuR4Zxs6BlffVApUCbzlgPm4gIbNSS5HdubHw7hDYPbgGRi6XFb
         suhw==
X-Forwarded-Encrypted: i=1; AJvYcCXS8zG7/3pwlPhbTL+KIxTr9kNTjguTJ9mA/J89EqWNgA9J5rjMhHERPGkmqR2Km4RJgC8+XaWwekHvfo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyeh8O8l37Ub3BkdqwRHdoBjPUPprWJTRCY+CX1sUglRvW+WSR
	ZlSzboU9TexqNEo+fhBHVgTMzSEULvqyAncA+CavRSJM8yoO4gBywPV6THnexw3FWbFS6IAaJRF
	Ntz1XAnTdFt9gI/oYbkUVUVp6zGPoc9FroCqyK6pXx79ksQLwLXxr2xusnp7e8AjDf10rHfJdOb
	H1Ff7MIMxGQHYPWQzAnJMUSqO+3vhCAP9o11Uf/CqpCg==
X-Gm-Gg: ASbGncsewVN2Np4DjPjkww2JHPFxcIpZoa6ZYUoW7UNWcHY6z+4de2/uFBYt80HJo/q
	8wEln6q3BBAwN2NkhFECiaYWF9/ItrXppog+26Fk2BnBIxNdICqYf+2P7iVRNA8GDYqu5F9j7M0
	m4f6icDE1RoGnbM2vz/EEQIDPyTbB2nLYcyZXhr3oaBuWexIMLyx5h
X-Received: by 2002:a05:6808:23cd:b0:404:dbf3:5b0d with SMTP id 5614622812f47-4151d5914e7mr6575398b6e.3.1752412601972;
        Sun, 13 Jul 2025 06:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1VaQK9wqnz+FxTANYpJ62FB5qEMASGOmEnkAQmxm/t7Rjz3H1kfZoKlFbnHST+MqaPlzvrU9rnDXUzvdkudo=
X-Received: by 2002:a05:6808:23cd:b0:404:dbf3:5b0d with SMTP id
 5614622812f47-4151d5914e7mr6575381b6e.3.1752412601552; Sun, 13 Jul 2025
 06:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711191014.12a64210@canb.auug.org.au> <e744987a-2fed-4780-a9c6-fd1175698da8@infradead.org>
In-Reply-To: <e744987a-2fed-4780-a9c6-fd1175698da8@infradead.org>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 06:16:30 -0700
X-Gm-Features: Ac12FXzFPCGagOTtBoMZgRaN1L0GwHmRIThJgFjwywyiNvm8JhFCpXjsqSe1SlY
Message-ID: <CACSVV011qEHt5Srx4QdP5=L9WqxTg9yjY63rTUGwbXawq899gQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 11 (drivers/gpu/drm/msm/msm_gem.c)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: kMJPPgKWi4nUPe0rUcErUvCaMTrjl8wY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDA5MiBTYWx0ZWRfX+gX7kvPYmvkF
 feQnwa+/vmWLL8j43OkpZCm2sVG1IeAfwRvj4mtHOLpJ/yReWb2JrGvk46pr6suR3gvQGLZyrOj
 X5EEkw49AyEX2qtYIZ25nETK4huCMq7YIVbpCmAVwpxLid/ikuhsTkDMaoFQAwOo2wToq2Stupd
 vflyCi5fCWvUMFbKupGguDKBxsv1aL66rc6Tzj3dW5p8YbX2QDGmWgPvmr6k6PvGSVrwvfNJSJk
 ax/vEKfsSv+CleuCVX7B99wGZ0prGI7jXgvSuIk7yJqWf/DfVHE0ybXKW3ed+Up2iP5JvMC4PWA
 o5nUA8OBy70yxLj09HtHMTNtQPu8AUHkROI4Rru6e+WAy3U1/0UlinYbVHqFXA=
X-Proofpoint-GUID: kMJPPgKWi4nUPe0rUcErUvCaMTrjl8wY
X-Authority-Analysis: v=2.4 cv=TL9FS0la c=1 sm=1 tr=0 ts=6873b1bb cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=PbJyB38NimUM2AyV3J8A:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 classifier=spam
 authscore=0 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507130092

On Sat, Jul 12, 2025 at 11:49=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 7/11/25 2:10 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20250710:
>
> on i386, when:
>
> CONFIG_DRM_MSM=3Dy
> CONFIG_DRM_MSM_GPU_STATE=3Dy
> CONFIG_DRM_MSM_GPU_SUDO=3Dy
> # CONFIG_DRM_MSM_VALIDATE_XML is not set
> # CONFIG_DRM_MSM_MDP4 is not set
> # CONFIG_DRM_MSM_MDP5 is not set
> # CONFIG_DRM_MSM_DPU is not set
>
> so DRM_MSM_KMS is also not set:
>
> ../drivers/gpu/drm/msm/msm_gem.c: In function =E2=80=98msm_gem_vma_put=E2=
=80=99:
> ../drivers/gpu/drm/msm/msm_gem.c:106:54: error: invalid use of undefined =
type =E2=80=98struct msm_kms=E2=80=99
>   106 |         msm_gem_lock_vm_and_obj(&exec, obj, priv->kms->vm);
>       |                                                      ^~
> ../drivers/gpu/drm/msm/msm_gem.c:107:39: error: invalid use of undefined =
type =E2=80=98struct msm_kms=E2=80=99
>   107 |         put_iova_spaces(obj, priv->kms->vm, true, "vma_put");
>       |                                       ^~
> ../drivers/gpu/drm/msm/msm_gem.c: In function =E2=80=98is_kms_vm=E2=80=99=
:
> ../drivers/gpu/drm/msm/msm_gem.c:668:39: error: invalid use of undefined =
type =E2=80=98struct msm_kms=E2=80=99
>   668 |         return priv->kms && (priv->kms->vm =3D=3D vm);
>       |                                       ^~
>
> --
> ~Randy
>

fixed by https://lore.kernel.org/all/20250709140838.144599-1-robin.clark@os=
s.qualcomm.com/

BR,
-R

