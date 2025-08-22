Return-Path: <linux-kernel+bounces-781268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09217B31031
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81DF5E129C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C942E2E7BD5;
	Fri, 22 Aug 2025 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GQUXIi90"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76F7261B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847314; cv=none; b=BEgmIqlCpaJyohIcvro6VHjp+itkFrzKtG+EiFAMkxuhnotHjcZtBqC80dJLX1pBKDPtMqqhTN3XiHVmk7KNc1nUP7l+r2D961KtPm5MeGfGftn7o22ZnSy/X0TIqE5Oo2be9f8yYNTuRRjmkLW1h3yOqa5DCFmK0YwwRZOI3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847314; c=relaxed/simple;
	bh=V4JPX43lceWgtpv1oK4d7uW3Xu4KaPczOPiIIa6laxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvKrQXimNK5J4ToY3r15gYctycLKrf5qB6GBHJe8mV8xdKW1asegmeVnuT6ZdkLyrT9q7O2m+Kyp5+NcanlcwajUHvQz4HT0EG/GsFYuavn7n8rGoD7qfK/Kh9hdyB8CrUWQ2nZp4nGFyrjzym5FW/IQ+vS4rqNwWbvgIR2+btQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GQUXIi90; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uS9Q020978
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CwMYhINTeHOMx2pjpR5qGtnw
	Sq2aRYrtJiqLa8LjGBE=; b=GQUXIi90WTdoyNI4WgCsrTFFczcJh0Dvor1GYwGI
	RKhwUjpbe+D5HcewVVkl0abs56c3fcsUB4dhmC8XZBJqBKheOb+atEs3DfNrdkAT
	n+Mn8pelhKScD+qkeMIDTrY2sj5dYqnRDEjsAx/fUjSrw3eVgNrg7Qsea1gPc4iP
	vFGxr0boMNBwpfWkPrHOH8fsDngQADzk0up8HsT6LJHP6A/pWVBDzHAYA5C+wJo/
	EyFHhFXqPifnuI1r1ljwiJyRpazMn5VcpVzgRUATrX00VuyRMzdOnjOAM7EYTUgg
	n7Jrvm6+hvr5cYjvFRKf3oLr8/NrIqqROLM0AmYNVApX9Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52ag8tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:21:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2461c537540so14467015ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847311; x=1756452111;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwMYhINTeHOMx2pjpR5qGtnwSq2aRYrtJiqLa8LjGBE=;
        b=H+RuYn+D/tecwMSzOSLloM/gMX9RRfU7cf/G8hUx/i0aEk5h5GAmZmWsjzTYQVajHp
         aDKTp9rdnGTd0jkyg/eZNAZokUlozaSKOb2mLs3zeaNRN7Siz0Vq6yTZI687wdvsPdye
         T40DLKaeGjMgQM8WpBUAEI1YQcrxvLr2yMW5XppEumyfExHQruBEjtXTabgJZBJgNRzw
         fHjv7OzwZ3oU6MQHyeoH2Ou2zNVBuEIK2HgNuNyyhRg5L1k4YtwcD4/S7uEYOMnYZMRU
         w3dJ04iB/HMyLfnMlimE0H1VOFDgaOmsoMKNhMlSk5h1UYrpzoK5pjn19bX64ACXrAgN
         YxRg==
X-Forwarded-Encrypted: i=1; AJvYcCU99QFVUlRuSCVqHmBVkMx1pAeWlWW6SzvPrU33HzkbD6yyux7+w7SGXBm4TfrI16/J/sPt5olv9Xpk0rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf3gKIk5nQET7KEoosxPxDApOrKNt0DHGFkdbOrjUUh200Mn+w
	lMeNPHgWT3iH8rNx4aglqACxk7G5VA5C2WWolg+JwslkPqySahg6T6lyyovEFS5OhR0kcm1gNHb
	365kNnNxyPI0NBOiGZLOnRUEHos59/Ohqtvf+42eGjKbiwRhwmFrlSIl+EtNYki9P8x8=
X-Gm-Gg: ASbGnctOg1GdX5Dt32yE58OtR+oONmqPO3YtRgimJ5aoHbgEHO6A/tz1XYibWcSiQsR
	NA3SfXVwOquc+/NmFCkVLV7ycqU3jNQQdYxWJ9MS2KjCIviqgXzHb0x9v/UydWakXVEe7JwtvzY
	XFR/GzvKzoOduSoCt2BeE64cUSqra1kE76M9ECDRZxubTRj01Yj2vZf+CID/p415ooSMxWHiJ+6
	8wFFe9wXuCgt3dKl8YWOtRdCSX2FnNvxWJ7VzcCJwrpEFDbxgrqs5/1ukTC9wXjqCkkSA5mbRBg
	AL0xe6PlY3eQRz89eCFjtldCQ4xG3mrA29pnKocNwvqbJZsXhu2hkm10GcXD5wJkIZ4=
X-Received: by 2002:a17:903:384f:b0:244:6c39:336a with SMTP id d9443c01a7336-2462ee0b49amr27801035ad.3.1755847310936;
        Fri, 22 Aug 2025 00:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9jlpoT7r0e0ooZymJDetRkq8dj6rKg+LabazXU04BhuTfjbcXjE4AuKsBYx7BSSyebrJYDQ==
X-Received: by 2002:a17:903:384f:b0:244:6c39:336a with SMTP id d9443c01a7336-2462ee0b49amr27800725ad.3.1755847310512;
        Fri, 22 Aug 2025 00:21:50 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed517beesm74996805ad.134.2025.08.22.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:21:50 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:51:43 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 07/11] firmware: qcom_scm: Add
 qcom_scm_pas_get_rsc_table() to get resource table
Message-ID: <20250822072143.3amvvxjwldmphtis@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-8-mukesh.ojha@oss.qualcomm.com>
 <4a60c3d3-11fb-40fb-8686-3d83539f250b@kernel.org>
 <20250821172043.fh6sr6w4bwyhov5q@hu-mojha-hyd.qualcomm.com>
 <0741fed1-33d3-431d-8cf3-04b47fe80b03@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0741fed1-33d3-431d-8cf3-04b47fe80b03@kernel.org>
X-Proofpoint-ORIG-GUID: zJ0P6TDvGk6235cBMU8Cp2vNqjyGflOt
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a81a8f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=jCfzradNRyBWwID4TT4A:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: zJ0P6TDvGk6235cBMU8Cp2vNqjyGflOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyeDawNruyS8N
 Aj5LN5/55zHmRIDlha3nuuhiD1wjgSIoW0mgL3yJYjbFJlbFTBxmM97WMwzJgZ8/THgJIwXOq/Y
 GtUnWwZJ1KIeWZtqAisl4aU9urrKu1ThAN/puGu1JBKuVfDRcKdj3ZV40uqC/cTZy+e+sw8Qpk6
 hn73/cIHDuFPTblH5OM/mS70Z/vslTkfZ3ADgYPqTE4uCv8dvhTrjhh7WtPU8+kXUGJVxS7e2fZ
 fk8xg92gyXiE75GcSXlAcXxIM6RhigFOHOQkG5A6yh6czYABShnhVjHV1snQmTmbMtN/1PJacLT
 7g2+pcfdDQdTVHyfODJsGH5WeVxGgncghby7CbyFr+TwJBBHjhZYW1OjSC31J2pkePRsHqhW6s/
 gyovxWbFTYlIXcNZ9sw3NPASn4Z2ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 08:22:10AM +0200, Krzysztof Kozlowski wrote:
> On 21/08/2025 19:20, Mukesh Ojha wrote:
> >>
> >> Srsly, what sort of AI hallucinated slop it is?
> >>
> >> I think this is pretty close to proof that your submission does not meet
> >> criteria of open source contribution.
> >>
> >> Did you run any of this through your legal process in Qualcomm?
> >>
> >> I don't trust any part of this code.
> > 
> > I don't know what made you think that way. There could be confusion with
> > my writing and may not have expressed the thing i wanted.
> Commits were written by two different people, but signed only by you.
> They have 100% different style and the other looks like taken out of
> ChatGPT.

I am not expert here how things written and understand by them and
ChatGPT are not used by my organisation.

> 
> Editing patches post factum is another reason.
> 
> Reasoning here is typical for LLM - first claim something ("static is
> possible"), then claim another ("dynamic are always") and then connect
> these two to create false third statement (static and dynamic are always).

Again, I am not an english expert as it is not my first language but I am
explaining again about my thought process, writing for some of devices
where this is the case hence it is written in separate paragraph and the
reason behind, "static is possible" written with chrome in mind which
is true, and "dynamic is always" going to come from EL2(gunyah) and from
TZ on Gunyah absence and this is also true as they are decided on runtime
and not all devices have this dynamic resource requirement.

And writing behind this "This indicates that for Qualcomm devices, all
resources (static and dynamic) will be provided by TrustZone via the SMC
call." is in context of this commit where we are going to get this resources
via SMC call with this series in mind which may be slightly confusing to
someone to understand and I will clarify this in next version.

I believe the mistake I did in this patch is that I did not include
Gunyah/QHEE absence which I have done in other parts of series but this
SMC call in future would be used even in case of Gunyah hence, it was
not used.

I know that I will have to declare these things if I use such tool and if it
falls within my company legal framework.

> 
> You got three strong indications. So this is what made me think that way.
> 
> Best regards,
> Krzysztof

-- 
-Mukesh Ojha

