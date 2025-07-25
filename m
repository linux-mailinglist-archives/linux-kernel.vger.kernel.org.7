Return-Path: <linux-kernel+bounces-745806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5940CB11F05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F345C7AE5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAA2ECD07;
	Fri, 25 Jul 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ABPYm67S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DCA1D54D8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447778; cv=none; b=Aw8959yVbemGQM1ntJw+oXnsEo7lKPXIXr/lZkIjTvPGrbtpymyGrqnZQc2YYr3JMUWpWixMwH0PTG1g2XNV7q+cfq6MBtgDL7akRpKtCycgxcwL8OVthi0rIkfB2KTDoUPw6t++xVDlpcyugYMBKm8FlvZkoqMtSV4WnafNA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447778; c=relaxed/simple;
	bh=xYpnLtBmmYFoV2Wf0O8DUo26fff34+DluhVeQud508o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAIgs1BNxRC/K0ZR0OHB3a8eNBROWE0KIDN9f+wlZWMHsKQeIB9cFTc2PKoNmPJeDJrCpATUauu5IRyanuuvwZD9a+h7YRvayEJlUVlX7rbvP4CqSX/ARxLS33WF4XuebIsDBAWnFDAMpYLQPwyKjCKriUGdneH8rufAY+lbt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ABPYm67S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8x0Et026719
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ktB9Clt7XUZb4vphTZxcSmXCe8grqlTXO7tGnfUfWKA=; b=ABPYm67SexCdXRE7
	rcMnk/on0toglwEoaYQKB198Ypn89/FV8NC945mpZLg47U/m3vFEIhmwQm16SrcN
	lPf4nBQ0qGIWkPZiLoO8WTB6+V90LSfOgD1I0ftRePM3lW/KFJdrfgqlPy+FmG4y
	yZaFV8afFWKkOXqsXdn9SZ4UUVXLR1+REpRL8gPD+oBvE4g9OvUdr/D9vHuA/rhK
	tv37xQQGdloIw70oko1Co3P51ZjLS6S4cOMTcmipMdxmITsNoDArGztfbj8F8UyK
	TO1NkwNg8m6Mtadzc5i3TKPydl6xk1VtS49qxFPtbp9RGjuNWa+NF4yj3UoWHu+l
	vsERoA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2u245v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:49:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e33af599bcso331087585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447773; x=1754052573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktB9Clt7XUZb4vphTZxcSmXCe8grqlTXO7tGnfUfWKA=;
        b=agNP1QLlhsA5TWsoKMtTgdbAfBKtsdBkZNpUrje+83H5ujRwOQyz+ads7cJyrQCVuf
         iJfuvgQj82sAhToKoLqOQ/kU4YbhBQdvsJoL9HfrvOCUxTwLYW1y8xhfFW8S22AdJx2b
         R0SfMnaIbJyUdHhgWrM3zTeaeyvwHCsm6dSsDamtpbZwCGP+0R0yqYcjfl9Lok69guA2
         jT0Qy3ve1t522c9b2maiTp8YQdgkvNtFl65Ye6D5scFjQpz+cWuOGLAC1Wl+6hYCoNEZ
         R+TtJqcmifpfvm4zF81W+RNs33hfVSfnv/QZlik2xcTCLqSQesTkOcxabvGpci4h/yBN
         EC1w==
X-Forwarded-Encrypted: i=1; AJvYcCXA7ajZIc7JqaWUq6sZvMlgIZ456mHFhLyUFqdawPZ7aFREeetfIkEZkzUydJH10TkMestRCFI/J6KY0h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEFtkI+J4QFSjTBhQdbNYneg2LTd3NaqpbQCl0+Yh0vsEDHa7
	WUxL5Zf7rmfd+frhoVPoKNEgeuE9lR3sseivUfGZeoM4aRT8ID12EuKdE8HTGuoh8hn+IcENww8
	AN7QRTCjGleTT3Tu3r52BUBc8ux97/8ngrrOkVDBuczouHDvD1oTiU9K6pj9ZYSoH4ievPVP3nF
	kJ6YIcew8feBIEs+Um09R41ry6/Zv3Ud5Mf2Ze3YGKcA==
X-Gm-Gg: ASbGncvxjr6n+NginAjorH31GzEos20RmeCuhuR3i9M2KHyFSA8wx8xm+hiFjuAaVlP
	PvDo6gp7wXEg1rOQ4SfNtaIu74Zthn7lvmsjFe8SJFOT/IC3Zx6vl4+6zApwe5xc5U1pW+l1x1T
	4VcRnDXjZTILPb3K8VrlPrHg==
X-Received: by 2002:a05:620a:390f:b0:7d0:9782:9b05 with SMTP id af79cd13be357-7e63bf95349mr242089585a.25.1753447773409;
        Fri, 25 Jul 2025 05:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3B3Slxw3dmstEGvQ2lqJWGYuHcRhehYoPFna2fVt6rcGfPvfJfwPkWozxxa+WwxMVWoB4203Tnjs2zKJO99o=
X-Received: by 2002:a05:620a:390f:b0:7d0:9782:9b05 with SMTP id
 af79cd13be357-7e63bf95349mr242084785a.25.1753447772817; Fri, 25 Jul 2025
 05:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-eud_mode_manager_secure_access-v7-1-40e9a4569895@oss.qualcomm.com>
 <2025072446-ensnare-hardhead-12f5@gregkh>
In-Reply-To: <2025072446-ensnare-hardhead-12f5@gregkh>
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 18:19:21 +0530
X-Gm-Features: Ac12FXxPQD_LsGbXmGNASbWosoLHJRg9wgIWhieGk75R8qev9bW7u1QVAGGMa3c
Message-ID: <CAPHGfUMnaJ8HPX=CC_q6m2nbq-ODP=MY_NkcvHjXR8mD9b=tBQ@mail.gmail.com>
Subject: Re: [PATCH v7] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through
 secure calls
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEwNyBTYWx0ZWRfX7NskUAqqpXBE
 Ro/qnUk2/n3rqgY+0+4gELkiPdryNXKCjLrtzKsO6jiJ+UIbyetqiAxfxF0nZWmX78E+eKHP462
 y7dV7GY3mfTpe3qImgiP9OVXSNxDVEngNpy7ZIM3JHD61J9kboA7GkUozbFrf4JH0GGTLAiuLdc
 n3FWJ6fairOvdrx5gygHThf6ix47HKMYWYsS4/Ka33LGiLHGqRAfMKeI+cThKBaDONP1Ytzi0OV
 /j9WZh9F0bb7hbk3ocFk28MLlV0hpjLQ1LaKdAWYZbutJk7+6I+HABg2u7vCYrPc98OrpChfTuM
 XhmeRK2TOMKTqzaJQu1SXp4/CTpj0WyLTADubQCv7hwtnyDgpyiwZFQ38Lpdbml36x/jmX/1Ses
 SgIQen1QBNBZiZDDmKvQTWJu9FGogMs7YL56MC9Wu6RzM2LpPXhPKpf3izCIXbQ0jStkZq0N
X-Proofpoint-ORIG-GUID: W0WX2UBlFd2Ga3Z57odGulMaYefVTj9I
X-Authority-Analysis: v=2.4 cv=FcA3xI+6 c=1 sm=1 tr=0 ts=68837d5f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=ag1SF4gXAAAA:8
 a=PQXWc0QCHC5KbQU7H1QA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=TjNXssC_j7lpFel5tvFf:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: W0WX2UBlFd2Ga3Z57odGulMaYefVTj9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250107

On Thu, Jul 24, 2025 at 3:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 22, 2025 at 05:01:53PM +0530, Komal Bajaj wrote:
> > EUD_MODE_MANAGER2 register is mapped to a memory region that is marked
> > as read-only for operating system running at EL1, enforcing access
> > restrictions that prohibit direct memory-mapped writes via writel().
> >
> > Attempts to write to this region from HLOS can result in silent failure=
s
> > or memory access violations, particularly when toggling EUD (Embedded
> > USB Debugger) state. To ensure secure register access, modify the drive=
r
> > to use qcom_scm_io_writel(), which routes the write operation to Qualco=
mm
> > Secure Channel Monitor (SCM). SCM has the necessary permissions to acce=
ss
> > protected memory regions, enabling reliable control over EUD state.
> >
> > SC7280, the only user of EUD is also affected, indicating that this cou=
ld
> > never have worked on a properly fused device.
> >
> > Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded U=
SB Debugger(EUD)")
> > Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> > Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> > Changes in v7:
> > - Updated the commit message as per Greg's comment
> > - Link to v6: https://lore.kernel.org/r/20250721-eud_mode_manager_secur=
e_access-v6-1-fe603325ac04@oss.qualcomm.com
> >
> > Changes in v6:
> > - Propagating the error code from disable_eud(), per Dmitry's suggestio=
n
> > - Link to v5: https://lore.kernel.org/r/20250715-eud_mode_manager_secur=
e_access-v5-1-e769be308d4a@oss.qualcomm.com
> >
> > usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through secure calls
> >
> > Changes in v5:
> > * Changed select QCOM_SCM to depends on QCOM_SCM in Kconfig per Greg's =
review
> > * Link to v4: https://lore.kernel.org/all/20250709065533.25724-1-komal.=
bajaj@oss.qualcomm.com/
> >
> > Changes in v4:
> > * Added error logging in disable_eud() for SCM write failures, per Konr=
ad=E2=80=99s suggestion
> > * Link to v3: https://lore.kernel.org/all/20250708085208.19089-1-komal.=
bajaj@oss.qualcomm.com/
> >
> > Changes in v3:
> > * Moved secure write before normal writes
> > * Added error checking in disable_eud()
> > * Use ENOMEM error code if platform_get_resource() fails
> > * Select QCOM_SCM driver if USB_QCOM_EUD is enabled
> > * Link to v2: https://lore.kernel.org/all/20250627125131.27606-1-komal.=
bajaj@oss.qualcomm.com/
> >
> > Changes in v2:
> > * Drop separate compatible to be added for secure eud
> > * Use secure call to access EUD mode manager register
> > * Link to v1: https://lore.kernel.org/all/20240807183205.803847-1-quic_=
molvera@quicinc.com/
> > ---
> >  drivers/usb/misc/Kconfig    |  1 +
> >  drivers/usb/misc/qcom_eud.c | 33 ++++++++++++++++++++++++---------
> >  2 files changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 6497c4e81e951a14201ad965dadc29f9888f8254..73ebd3257625e4567f33636=
cdfd756344b9ed4e7 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
> >  config USB_QCOM_EUD
> >       tristate "QCOM Embedded USB Debugger(EUD) Driver"
> >       depends on ARCH_QCOM || COMPILE_TEST
> > +     depends on QCOM_SCM
>
> You now are preventing this code from ever being able to be built in any
> testing systems, including mine, so I don't even know if this patch
> builds or not.
>
> You did not even document this in the changelog :(

QCOM_SCM is essential for QCOM_EUD for its functionality.
One option I'm considering is using select QCOM_SCM, which ensures
dependency is enabled when QCOM_EUD is selected. QCOM_SCM facilitates
communication with secure world, this approach should not cause issues even
when COMPILE_TEST is enabled on non-ARCH_QCOM platforms.

Alternatively, I could use a conditional depends expression like:
depends on (ARCH_QCOM && QCOM_SCM) || COMPILE_TEST

This would allow the driver to be built under COMPILE_TEST while ensuring
QCOM_SCM is present on actual QCOM platforms. However, this would
require proper stubbing in the qcom_scm driver to avoid build failures duri=
ng
compile testing.

Thanks
Komal

>
> {sigh}
>
> greg k-h

