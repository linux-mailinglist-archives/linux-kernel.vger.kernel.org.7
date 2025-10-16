Return-Path: <linux-kernel+bounces-856389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6430BE405C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EB7935941B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5EB345753;
	Thu, 16 Oct 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oK0IvGUF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215A3451C4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626358; cv=none; b=KusTMYWWxEAFQdViHoIsAowok4Ob6yyQLdDZ2Z1T7EoureETQCTCi0OgQcO/TveDdg+3GV6FReDThDxoagnALkTN+4cU8eHNTYsRDaOs+OBhSigydEp5UfDM74l/zUpk3HEw4mSFkj6+71YKzRoSWXtQXADfLXxBg8tE5Wni4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626358; c=relaxed/simple;
	bh=bb2uPhrku27uZPv/Jf75e5nhpowUMYOiMnBB5KihFPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxhlaSJUTB1m+9znMV2u+o6stRXmRAbmUjD4Qy4Ev8paMB3XLoIhJClRJQMZCz04/ClmhYxE5m4UNYdJFpCEWnvtWFzwUbezNxkGk3qvskxqF2sVihA9u25/tnfm8cqxx1ZMCASkmk8Wq5zXXzPBicGv7g/VIw7EuIoUy7EFEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oK0IvGUF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEQuim024854
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=jPmtY2bWstZxGYrHD2oLA4kDgMlBAGLM7cSsgPby8R8=; b=oK
	0IvGUFq5Jpvs+nDFM/Il2MpT/ilhF7MHPLO+EQjXbkTN5WAB2rI0VHOSOOV+Qzxv
	sRtsBKGetq9wWxLEcY2lXvRoMYL7LPpZ9pIVBfAimdy6R2mv9p6gAudwk8iSrs25
	65FvBqQsyi+Yt4UDL56r1HgrPj1Jwtkn5AOnrPf0622q69XSNno8TLBKC0CUEYol
	ixpON2jXbKn9SfLTwAQqtm6rDhMB2kh0BfyW/hagjxvIxYHeAEDIseAWzJedm9W+
	vK8BUcdjcOH0s4pKDHXdtZfLjAruVuPpD/VTQr//0Fa2Z6QX9Ou1aNUUAQRav4qz
	6q8Ce5vsU3zTX1Onw0lQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff10mkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:52:36 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-3c96de7fe34so233322fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626355; x=1761231155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPmtY2bWstZxGYrHD2oLA4kDgMlBAGLM7cSsgPby8R8=;
        b=gifJjPATJSCuecWH9iIc2up7zy1DJ/GjRKw3GmjrIWYnqiTKD70w+z0b7uSMmOAyBL
         S4q5qaJWhUtESOnqpQ5ZQN2Julwyw4QvQeWC080qdCYsaWg4QGISsR58ZF5wC6NXJZC2
         VTIv4wcNZi4ZMKcgMKiLADQfMG1bbAXciB08JxZpA1lGc+FI8zgI2Vv9Zsq/VCDGRsgm
         XmdSte9qjMviULUNJUqroMj5No0sc+VQRg9b4TTJ3ppyONnogZpVObStgqzTeLEQnfHa
         JHUblIuI1z92q1a16tY+zwfmIXypD+Hd2bjMB0Gjje5UumqNg3A01m162Iwak5B1njjv
         AdhA==
X-Forwarded-Encrypted: i=1; AJvYcCVqRhMZDi5HO9XaKd2mb5zSZtCHlN6TzpEjMg0/X7gqsS1ALn9wdiAqH0p6GXRX8+hXVFExZEWbkhfM9bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAt6jHl8v/dU5jlpBCg+8fbRQryS1rqUWrjHVgc1PYxPPvfZlA
	GgfrJd2ikC+j4YyVHCqLyV95x/Ssy0OCPVf4WjdY22NrwysXL4TG/oaaawFJ+jHvQ8lOibshJX5
	qR9oAQhjAoVFwlTIIAsCnygSHY3fCvVNC2a8Guo3/zIYXUvGVxXvECdx+N61POicHug4bDDpURE
	wDiZ9yNRjTisb+jrwf3oJjvZcvyaj14+sRuVQZBg7TXw==
X-Gm-Gg: ASbGncviQUa3mr8fE7v+NFz1LADzqU3WyWn1KYXXS+wukwUqAwJjVRQRS1UiRNOLWsI
	irf4hbTGDryJwvoOT55dFy+O1txPPMNivf/6sQUuUvunBwe2AEaJeIA5iCVeBV6N6Vu9yhmavdX
	lfdyqtxDnDFGlde4kWbavOLcpBIDj9ofI+nj+GiSmyQxGF/zYoET8/kN4O8EM/B7Dzeb1RzaMOI
	hvOoubcamY87+Q=
X-Received: by 2002:a05:6871:2e88:b0:35d:a9e2:fbd1 with SMTP id 586e51a60fabf-3c98cfa8295mr10101fac.21.1760626355310;
        Thu, 16 Oct 2025 07:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF39ocujuIwT0Et62sHrBT+rRRN4wBRxOHxmKLmre65EnhOwqDPEsCuGBua+8VJiCAAa15gVkxk2D9mH6TwzQ8=
X-Received: by 2002:a05:6871:2e88:b0:35d:a9e2:fbd1 with SMTP id
 586e51a60fabf-3c98cfa8295mr10075fac.21.1760626354773; Thu, 16 Oct 2025
 07:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718105407.32878-1-vignesh.raman@collabora.com> <20250718105407.32878-2-vignesh.raman@collabora.com>
In-Reply-To: <20250718105407.32878-2-vignesh.raman@collabora.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 07:52:23 -0700
X-Gm-Features: AS18NWBmqrEUHFQlSWdIGqm2-_tBPDNsmr766wJpJByzaFclGFLQ0RGnzuLEsPQ
Message-ID: <CACSVV029ueL_4Y5irmmOwy_9QDQGqDe_1wCGUe22FdefQiNjkw@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] drm/ci: disable apq8016 and apq8096 bare-metal jobs
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
        helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
        robdclark@gmail.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, valentine.burley@collabora.com,
        lumag@kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXy2wsUH+79Tjm
 RKF5QvE7Mvth8ssI7J9hDSymAoa8DG1J4iZorXIOkfdcpUNT3wdpp4XOI6MxwRzJMonWnZlr2Ih
 tTLFvTWGHOQEx6D7P+XOghv79vFrFElmq1aiFsGo1WLOy3scyF7vNjR++iDSHAr599hTz62tvJF
 UDpuP1H1yHbFirWdSbk5sXxQWXbHNyp63ZJOTm6JUeOjSqeBhl1u6evry2ZS8KQuLq9k4bo3QCC
 2QEs3FUKpJATs3to4STn3npm/mD9IFPvxsPRWFgI2ljF001fLFDy9vr0IzpeZqQcycRTQnPbEjI
 zkanPDCyFjAP2q+DIpJoYDm8b3Z6hh7YMhPmuW9Fg==
X-Proofpoint-GUID: UYAKr_F3UodpSJqUxpA9CQZY7c85GnUC
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f106b4 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QX4gbG5DAAAA:8 a=Gxbm4VOBLxWGKnsTXboA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: UYAKr_F3UodpSJqUxpA9CQZY7c85GnUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Fri, Jul 18, 2025 at 3:54=E2=80=AFAM Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> These devices are being moved to LAVA. The jobs will be enabled and the
> job definitions will be updated once the move is complete.

fwiw, the runners are up and running in LAVA now

BR,
-R

> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/test.yml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 81147e86bfd0..53d19ffaaf61 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -148,7 +148,9 @@ msm:sc7180-trogdor-kingoftown:
>      GPU_VERSION: ${DEVICE_TYPE}
>      RUNNER_TAG: mesa-ci-x86-64-lava-sc7180-trogdor-kingoftown
>
> -msm:apq8016:
> +# FIXME: Disable the bare-metal jobs. These devices are being moved to L=
AVA.
> +# Once the move is complete, update the job definitions accordingly.
> +.msm:apq8016:
>    extends:
>      - .baremetal-igt-arm64
>    stage: msm
> @@ -165,7 +167,7 @@ msm:apq8016:
>    script:
>      - ./install/bare-metal/fastboot.sh || exit $?
>
> -msm:apq8096:
> +.msm:apq8096:
>    extends:
>      - .baremetal-igt-arm64
>    stage: msm
> --
> 2.47.2
>

