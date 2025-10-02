Return-Path: <linux-kernel+bounces-840627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C4BB4D81
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F393B7BFA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB989276059;
	Thu,  2 Oct 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V5bEcIVn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B7272E72
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428584; cv=none; b=km22064M2b2mhSaISbhCjFSi6j4DvVxw5i8r3tjvxy7uiLUvvEy9lX5zj2A+oToLrtZUbucd1H1cH1hR+0ZCWi7wdiZ39lQlLXtE6IcGgvuJ/5+L07gJIwaOFujHMhHDBZ7PCaLOdfGMlRpZ8Pf9uLX2MqNfpJzrLnCKpz8Umyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428584; c=relaxed/simple;
	bh=o5mfAXgg1QLGGLzLNE6hN3/gl5asAY64iBoz5FTdpR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFbGw/aPLqxABOvpHDnXdJJZI0hVX3qg0bishhnB9VexfJNO9uBJJ9IVT35YLU8Yp5XoksKitEnh9mDyVP0H0FoUSWfNSVY9aplMspIFqXTnA/g8sp7OKX7UNe8xOWQmihS4spqoPA6PWu56LoEhP5Tv4Sv8OWWX2yu6BfcE7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V5bEcIVn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5928s4Kx009721
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 18:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o5mfAXgg1QLGGLzLNE6hN3/gl5asAY64iBoz5FTdpR4=; b=V5bEcIVnpEEGSW/K
	sswMJNBXvlTgsDi0tXuhJnoWZcHHhYt6TaH/F7svLIzzs9tWuFhizbWjettpnoN8
	3OP6TYD9t9fP5dtbI234ciJJskTjhipA4pOHGMhGTZqgjACRjq83/3uwcPDto74X
	G2LFep8V4Rx5cVk6CSFtAmgV1cSwpAmmPbwLrrM74k6QWDHmS9LtdbQwfXVeCaI8
	P6nky/iaAtcsH8d4JzBx0zNj3yqOPXZUZ5qM6Hd50wV7G67sxW70M6JBEJjw3qcy
	EHAlRKuIVhl+eLU5nKN8Cbr89wqtW39rFbVEE73tUaYtmET2OnvuSUVM59XdzIdV
	jO8SvQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hranp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:09:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6fc6so27809155ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428581; x=1760033381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5mfAXgg1QLGGLzLNE6hN3/gl5asAY64iBoz5FTdpR4=;
        b=g3dRUgYd37rRBKWIBOFEBETw8Omck0dllHPv5qm+kxZANsx6xg6NNXhfcLU6QKMbZP
         LNq0DKuajNwXb6VuB/ub5Pd9JTAkavWS+rdcn77ttOTSnnwX4nogxr9TxQbHvj4oYMYr
         KPmISRVHaEt5bPn28ct3Lz6pW2DE3xE9j4WMv8TzWVQLqqb05cN68Y4sFvmW3QId8wwz
         ISR9zm9f9dpFgkgnsBoxAasrW3BEN7/yVMvBiBQOqoVD1TKqq7lWzDZF2kAVTxA3NPNl
         jH3BRbqKg/6iKF6Irm11Psv3arfdgiEb92u5SM3NeJkOVJ21bPdYGbW6SYk+rkKAkLaN
         9PYA==
X-Forwarded-Encrypted: i=1; AJvYcCVPyirMoAlmmki9GsZ2iqRZFMIqtxeM/7v8Rkb1+NIhJ8PI8mV7dOnU5NRF30D8ucrIT8OKxVTn4kEMX6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylrc8AZ2MKJuRsMnEpznW2FdbjVaEcqq61yBrq7F/7Pvm91LE4
	ggWXtdC7E6lIzOnWv0e5RxXy4ijVEiVU+zsbX0bykrEdMl8cAGdh8QVqKvRihnBUPcellEzMZvW
	OLZAbUOmfqZAYwcywKb6LEE9fGd0H2/garC4UvZFQdNhkkACjYrcOPyx1aT9jyrBv2axOfD5i+5
	fyDnavPHPhOdmcU+DQaiDaoxKwe1O7F4dE2IFsroxcGw==
X-Gm-Gg: ASbGncsM18P5PeZP7Mld9/f2kFnDbtsUR1zel5GewKcsOvwZOnDAJV0/lTOrczhLb4R
	9p91elk+3HH6T08VBMtE1hAEBOwv9v8L78BGuOkQrzJfMXxdDQoH7INQVMWGNLCN1IQzlIaz0jb
	wWyPVHfrKsH6Npk+jgiIH96EpvtpU=
X-Received: by 2002:a17:903:4b50:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-28e9a7031c4mr1578985ad.61.1759428580630;
        Thu, 02 Oct 2025 11:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp+nzr4kOaiK9pHKoBe7y+pNgMV1+KMM5h/aSQpFMdxD2b/L9xkPrqEo1lFclOnfCQtSnXjjCgAmMou37yiBw=
X-Received: by 2002:a17:903:4b50:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-28e9a7031c4mr1578615ad.61.1759428580113; Thu, 02 Oct 2025
 11:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com> <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
 <043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev> <aN629m1MlMXYh1te@x1>
 <CO1PR02MB84601693B2ECBB323297B4ECB8E7A@CO1PR02MB8460.namprd02.prod.outlook.com>
 <aN69RSQQ8agXOBDH@x1> <87wm5dtc7q.fsf@gentoo.org>
In-Reply-To: <87wm5dtc7q.fsf@gentoo.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 11:09:28 -0700
X-Gm-Features: AS18NWBnpmJoQOPbNXZCG7gxNfGYH9tAmT0-_sb-ZrHu9aZmPY32BVGyYsUoNW8
Message-ID: <CALvbMcC3fT8sz=45Ncf_Lydyyas57Jje-erLBKTaM-m87+jbLQ@mail.gmail.com>
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC compatibility
To: Sam James <sam@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Pinski <apinski@quicinc.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX+hYsS+eCleCa
 EkhRV5buzCz2HThVhEJPguEVpXIPpq5Ece/1J8KkU7f7q1rdvwoQNh35J1N0yptd7F4lDbvErqe
 YWJKVAXc+h0rGgZNKtdsRP68V4j1TX75Odz5rbDK1fYAdyjNbhuRQzk8CU3ZEk54pFSSU1PPYu+
 5eKyRGDosx/VOsV/Z1dV9qumDJQuFNf/e85O4fbqwMJQJtKAN3WL2aoCvpycyrOsHYlJaI70spa
 4EpJHCWNFB4zeha5IgdAOhovKwn9f2Qup15n6KR8+N8eby033bbc0AvaD50aimzKBuY0xHjddAs
 CFXcaHjhrqZfMrGG4bW+p44BrBLAhmg1x7nvt8Vr5ZzgHImZFyIWuTMNe/A72b0ze/LzQWle16E
 +OaqdwLguC6784dGbekcBjmjfWv26A==
X-Proofpoint-GUID: RlfUD5WDCK6wTgBdMGDjrVUjNdoNHy7n
X-Proofpoint-ORIG-GUID: RlfUD5WDCK6wTgBdMGDjrVUjNdoNHy7n
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68debfe5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=7mOBRU54AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=nzY_nJytDTGGSvjW54AA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=wa9RWnbW_A1YIeRBVszw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Thu, Oct 2, 2025 at 11:01=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>
> > On Thu, Oct 02, 2025 at 05:35:09PM +0000, Andrew Pinski wrote:
> >> > From: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> > So I'm taking the patch as-is, ok?
> >
> >> > But first we need the Signed-off-by tag from Andrew Pinski as
> >> > he is listed in a Co-authored-by, that I replaced with Co-
> >> > developed-by as its the term used for this purpose in:
> >
> >> > Yonghong, can I add an Acked-by: you since you participated in
> >> > this discussion agreeing with the original patch (If I'm not
> >> > mistaken)?
> >
> >> Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> >
> >> Note my email address for doing Linux and GCC development is
> >> Andrew.pinski@oss.qualcomm.com . It was apinski_quic@quicinc.com but
> >> that changed last month.
> >
> > This is what I have in the patch now:
> >
> > Co-developed-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> > Signed-off-by: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
>
> Looks good if Andrew is happy. Thanks!

I am.

>
> >
> > - Arnaldo

