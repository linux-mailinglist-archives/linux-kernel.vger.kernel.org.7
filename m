Return-Path: <linux-kernel+bounces-808517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D169DB500C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846C2446824
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A60E35209C;
	Tue,  9 Sep 2025 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QJLJCZ4s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1D350847
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430832; cv=none; b=P8TKPZ93OwOwvYil40aMt+wtK9Xlkdn9PEadinDIDhBjf7jcUknfxSJWMAiMgxFUuBz6nc/WX88stfjoLeoy5NIv7plU7eaCr6mD7XQL9Y9W1NxbaJV21GTkf8upouqniSdMFvOIEyZg+14+iXaI/+ibL0bMoYp7KHzYbmqe1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430832; c=relaxed/simple;
	bh=tBUZulCM1QmYag/rYO1gJeRa4CPakZQb8P0yx0qaPpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5TEXCQfpVuQNHKcTWMXK2GdAzFHLRq2bYgmiK7o8eCP37R7ZuQqrVmH82FguIXtk77k7UHNPIXoVR2sH/sXa9tBLuLd03s2qVeUC4jdO8pYv/0PdpazrkmqQcvDAkrH71cz1rKO8ZUd2jdscft5uj7Zdn7GLmZYIyODUf7w3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QJLJCZ4s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899M2kj002327
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 15:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tBUZulCM1QmYag/rYO1gJeRa4CPakZQb8P0yx0qaPpA=; b=QJLJCZ4sqDs8saa3
	NEDg0HB7QVplC5FmWvBH0bQt5bRe+DCYWaEfZ1r/Yf8fIn4sNeH07nWf5MgyM160
	CMVE2YkCCRWAX/7IPf74A86bR2YBFfARvlCRKrMZz/KWKTJDiKa+YqhcgFNOVA3I
	PA917cbbFFdqopTiN8r3Y/CkZ0DaXnGOZvAHn6dRYkpvPqqM3z+hQ65e+eSozMd3
	7y8EBrF4XkLPkJNazcnkl94rsrYosmiY+NEPCcLFf/fY3NetQsXkvLmcbhRe2K7x
	qHDtOONgnkncLJKwUQb3ixwAssSRxVUsqkhofCZbThx+U2izRUXMtmJoX12jmkeu
	KTJgUA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg0gd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:13:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-80b27b09051so1334291885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430829; x=1758035629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBUZulCM1QmYag/rYO1gJeRa4CPakZQb8P0yx0qaPpA=;
        b=FQ6lHzSe7SP9IURnShy8OvXx82fLfCq+q6Ll6M2DPuz79D4bX1mxAODzJfOKp/cXdU
         8nESITLJpKEuNWSefUbmJIV0XdnCBg2pfJppZYKowCMPtK9FEd6GkaFp26WxlQ+/KNYH
         wFGWUFrWRLKbATYBlKAr2d54J/PiUv5Q7w+ojWvqpR2zMBoQNVGWPxFyj54V+K5MMyDY
         ACREFItbBAE6uKL3A9mxVEPeb0JKEX3qIW7qoW1G2tnKKK4QbFt/Qedua36XAgB7q0Ht
         FiFunm4dr3Ygc5gMcuheN/efJtOHlZHK+UIJ3FSOFsOITDMlZJK9AqL4+J9IsI1N11c6
         nJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCV++gELhTbw2iyqgwLRXq92zyeyW0GGaX5rrFA7PO/x7tvf5HXNKCqZiEgWwk+pY90MkifnQuTp/xxweN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHNt2qe+yt1IoCa7VefpqN5/gDNRT2Dini/XV6nTkpFlcHFf3
	eNUmdkLDo69xf///GXpmOFQPxqMfKTFqALs7Uh2usUPovD+kOvujbi0whZbA6e2yfRCcwGMk7eG
	5Obf/6f2D7PWru2fbBdWutpfRyT+OMh+5vLLdxqe53llEB5R9k+AEfriXJ1OGeMUWgaetIgjodj
	PZp7QgKjJzAIYuPHdZSGx5gdtwGgPoo1rXvTxEUdzdTw==
X-Gm-Gg: ASbGncuN2z96UwDJ8Jkrtuafv4SuqlJq5FYE2V3TE9z7EEQb+iWMIhPUjf+ZVZZympW
	uE7XtZcOGy4k0Cstw39DUArGryr8kKJL1VIVJ/NWhyIk3am6kne72l4DGdDhWH2HZ13oME3V2Lt
	iexIdj36cLCUi5iviIif7W8Q==
X-Received: by 2002:a05:620a:1914:b0:80e:ea60:5ab5 with SMTP id af79cd13be357-813bdf6573cmr1065361485a.5.1757430828937;
        Tue, 09 Sep 2025 08:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP3m8TQXurtP7EDNoZFjviZYeRLBktqofFy6NzKQ58AmpuPf7TH8c5DGH/g48atlE9EDXdL4RKC+aicughQAs=
X-Received: by 2002:a05:620a:1914:b0:80e:ea60:5ab5 with SMTP id
 af79cd13be357-813bdf6573cmr1065323685a.5.1757430823532; Tue, 09 Sep 2025
 08:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519094745.32511-1-loic.poulain@oss.qualcomm.com> <4bldj7jjsi4o2wz4wij2ggog4no2nndavk4r7frvd6fv5fjtfn@4unsvlv2mdl7>
In-Reply-To: <4bldj7jjsi4o2wz4wij2ggog4no2nndavk4r7frvd6fv5fjtfn@4unsvlv2mdl7>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 17:13:32 +0200
X-Gm-Features: Ac12FXzTNyQG9gZZK-bmNMKPyGvG8QLL-KjBIb-H6FUgWO4cQO4LwfZ749ugKXs
Message-ID: <CAFEp6-1naKYksWBSeAFSPeWvsaZXYxsMvXrGN6R4bJZNMzsiYQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: qcom-cci: Document QCM2290 compatible
To: andi.shyti@kernel.org
Cc: rfoss@kernel.org, Bjorn Andersson <andersson@kernel.org>, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: aj2m31cc-1t1dA0nHGUR4Dd_8wCGxIsz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX6Nrqg+8/j5uE
 clWPvJOYLvw7FWA00pniPCV7kyFvmFjsdsZZ5l49zPBekC8P6BZK6F/fw7HBbbdh3JOrxYQyj2y
 J+TP1kFbokq0+brABzP6b+KD9XuNfWo7XSHLcsyf0ebvKgLh4F6MsK6+xDyxzW7NqKLTCowUUQv
 eJYbyemOzgaiGlnIPeDdvd+lNjP5SE53AFxGs0f/THFcXcMxFzzC5ejah1YbBSbmYzK756x3UnY
 ARRBuXlm2FzIYI3K7m6VdXV6CnQ330jH9rvhqcAwX8LylBFVALxyC5K3x2f/KK9HOpAmVQ34dTi
 sMDM400cNrmcXnhh58fK0NX9fcG9SMEw+K1l4oNm5vku5tnbD6gbGpil6sgJQVbiScAxOotIrCf
 noHJvRzj
X-Proofpoint-GUID: aj2m31cc-1t1dA0nHGUR4Dd_8wCGxIsz
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c0442e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=KBZmAnGqXSic2IO25hUA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

Hi Andi,

On Mon, Aug 11, 2025 at 9:46=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Mon, May 19, 2025 at 11:47:44AM +0200, Loic Poulain wrote:
> > The CCI on QCM2290 is the interface for controlling camera sensor over =
I2C.
> > It requires only two clocks.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>
> Andi, can you please pick this binding, so I can pick the dts change?

This patch is reported as NOT APPLICABLE in patchwork, should I resend
the series?

