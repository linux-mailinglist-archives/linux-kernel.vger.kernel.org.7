Return-Path: <linux-kernel+bounces-806238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FE5B493F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672021BC0B04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F73128A0;
	Mon,  8 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PkfM9Yu+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9BA312801
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346078; cv=none; b=o93zp6mqVXSIQ6AlxxIwRVSfsIV9paf5MitPk5srYz/gzUSc6xtylHsCfpQ11ftPrMdl04XKDVxbdjg66fknGdu9X2BNzHcLJr3zeWjx6zGXe4ZFRVmAcSlENQPlPnuepl7ULo+ci/0pnSwSRjtDvYrO1Rcs+3hHGaq0Fqs5kZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346078; c=relaxed/simple;
	bh=G2fs2nKN2ZhgBjC25RM41Kh9rDq7tT3JvNkxLut32sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMW1ooYpbqOrhQ+CYHs8hnTyYtroBZdipUvvnu1/xi3uwaM8rbLZnBI8zpxXY74qjZztz45dytgtgZXohaLPj4scaQo8jYCqSRj6mhK7FlmPEPEROUZcaUfIkQtg0rCT3PE5WMg6jyHEphTW1wGb4hYtg5VN1/zJRbj0kuKdBOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PkfM9Yu+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889ILhN010653
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gUNywjEFdmTkr5x1l5m+XCGsRzCZz5+0YY3gu0GUprQ=; b=PkfM9Yu+/rv2MnZl
	juMEblxaJs+I6c+tH9adT04naeezqLbdt3+0KRkf+CBpg479N1M1Xc7CW7Y4pzBu
	Tpyfsj/vEb2UH7ZYficaX9JEdlJdMkDTUfhf0exzJDx3y+FgZLMIs20zu3UVPUrx
	sXLWQ5pkT3AMLqlfTXxBr0Gm63BZlSPWOfKoP/h+LesanJOsoRyh7x6VpGNcbthO
	KUd9xawEPStYPb6axXwBCdG5yPeY7Aj3t89D6bz9hNKcvgn6ajm0TFRm3bVI34Pb
	JaNqJRAnBzMex4V848mv6p1S3KTEjMfyycOxCSKIqFNQ/Q0PK0nX1xqd/Y6rAKvG
	GP6jUg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kvxmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:41:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b33e296278so7741441cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346075; x=1757950875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUNywjEFdmTkr5x1l5m+XCGsRzCZz5+0YY3gu0GUprQ=;
        b=eHjkEwsjdVmWEta4ziwaAaZLat/qGrUr3NUs0/WsQGlPpI3Bsgku4ev4Jr7g2Ww/5k
         sOo/yvLFHqzoY6uXmM9udH8NNv4ROmyA/aylkjIxWdyJH3NHbuXMdivNPGIY87/XlS7J
         JDUQNAyVvOMRJt1BD80FyFVpBBrpTs20Ow6nEryfAUbIRln/dAAKyYiPh4sjptDaYG/p
         bO3UrIZzcFWPWj07cEI1POy5F9VkfZ5EAjZh446AvQPYwaFXlNo0IrAc0IbUmIVTjliM
         XjiSr6tTA618b6YRbtLCAXw6LqlFQd4ZbzXbzAhnoudxpMnu43QN5mo0/Ks7FF0O1as0
         d31Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT5sl55k4sNM2WnCa3pFU0wrK836nmpKLY3gdotyqaAsDeWkTwNDUFI8Vp71mf+l6gED49WVQyPVKUDKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMa1xcT9VLPSFUMpovyorYv7ECUxrf2gmifHHn24/rL8QvUxh
	HRlkoXdzbOSGwdplWckOGB8nSBjj6AlwD3JzhJxtG5Y8dlK4RkgnGJCrm45Hsdj+13QuNyPoTtl
	YcoiSTLTR6fiN0Wff44GR3uulepuMfutA6+1gVLw+yLxX73jDTsvz9D+pCZzWmHo5w0o=
X-Gm-Gg: ASbGncurZ1n9GeRGB1IXOwiDA6PInjZTwScPRGWquOayzgbj2j6rt+f9iusHxVeqD5C
	KEn0UjIg58RHdOPLfD6SAH7n3Y1SlldwpDwEzvw7xnSXkJjjy3HTp7yHQROHkXIFbuo9L2PS9xB
	gbZMmMkKJ9xywHqYmQV+uvJApdG1CgHdiF/ehb68jsRiLFDFaQog6FBkArWh6b7JMSv3l2Ch3l1
	4lweN9W32waLkiUqSoSPxvEVYyV0SYyEdaisXiJD5PL3xuIvsYbDIeXmrxVvhaXEC3kxQcfZ3qf
	D8XYazim5C66In8qzObsWxFDy9cgdqH3YEIo0z3PpSTGm6q4ELGUwwQ4mRGfdxxor3JvQK5AwZ7
	YfY09EaaDftPBrGX/4ewYow==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr59239711cf.0.1757346075067;
        Mon, 08 Sep 2025 08:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd5ZNZ50YBUchs3nuPz0LYnawAnj+cThrii0JYVr/emigl5wPPuJaCTU+N79pP56oMJTCaig==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr59239211cf.0.1757346074307;
        Mon, 08 Sep 2025 08:41:14 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040d44c9adsm2198301666b.9.2025.09.08.08.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:41:13 -0700 (PDT)
Message-ID: <2f95d508-34ba-4a29-9add-63909db22b60@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:41:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpuidle: qcom-spm: drop unnecessary initialisations
To: Johan Hovold <johan@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250908152213.30621-1-johan@kernel.org>
 <20250908152213.30621-3-johan@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908152213.30621-3-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX9fPYc/wtcY8v
 lhYmoDwsxOrBI8FpCXrM02XrNzuddIkw6om6PeirfVM8MDqWBWJ5P6+OpQvOGA98mG9iviz1Vi7
 7Ru9kFS5SHNAfw3CyPwIzuRtBNH9EWUE/FGcz/0iWkKVgcL+A+XWKJf5CcXBwGmTZ9c/yua1K9i
 m1s/1uJXNqg+IxzE4Z5h8gs+Bxn4fGxYS8yd+DQ0C9EYRGMtyHqdS0vpbPPQ6NbzzVLejbROTTS
 tf0OL1hI0tozUSLFGqwBKvzIKmFfzXWds8SWxe9ivh5WbAXKKR8Y457eC40OnMXozvpwk3glDyF
 BBYlUEvTjyHg3lErguCFKDCKjzaYN+CH/LC4i+Bwjf6wrVI9J1L/TX9RD0oAuhHxb+80BvRKpwq
 msOvl6By
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bef91c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=vJ8C-6PKK5JqxMKs-bcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: zVqvaiyzNkQc_z5Q7z39IQ6LoYKnvTjl
X-Proofpoint-ORIG-GUID: zVqvaiyzNkQc_z5Q7z39IQ6LoYKnvTjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On 9/8/25 5:22 PM, Johan Hovold wrote:
> Drop the unnecessary initialisations of the platform device and driver
> data pointers which are assigned on first use when registering the
> cpuidle device during probe.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

