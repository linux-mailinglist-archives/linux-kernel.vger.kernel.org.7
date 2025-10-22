Return-Path: <linux-kernel+bounces-865296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C0CBFCBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548551A60D49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117034BA52;
	Wed, 22 Oct 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBcf4hY6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8823451C9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145101; cv=none; b=o0CiWbxmzhDRRpgZeJd25iIE5uWo3744VNT9owxJDzmnLyO2fTUofsogqKf0O81pTmSKqO0+vqiDmn9SxRrzI9tEfX9SVl9mwjM20PCGjIxKRWOoyJ2Hn0XQ/SDt16bB96t2mHTfOfb8D/37Kt8NFa5BGpaduCzpAu1izl6maQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145101; c=relaxed/simple;
	bh=UA7FZ7E09YCCwNWVXtHh35Tj2Kh2ruJ5zTVls+xKLW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeMd+kQMQAPQysmMyC6QpRWWjGlZHlp0E7opfC7V063DOTDUTscEm5Dnsn2vltMdF3k1rROBCTcfVsDdIuU4vXSzkfeTYQc1yIVOIK8OWWO9rsnKpmtdJoqKtanRnRsnWJO/5h6uFWwGyXodY49QoRRD+3HXksfvXfn/IRuZSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MBcf4hY6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8ZmoI006415
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pgqjTbpnFaE0hcBetVMhGWTjxas9QOG0G/pOXwEzoy8=; b=MBcf4hY6zoRatuO7
	WUdbyvvxobU+IwO4Zzc6NvhTr/q7Ny4dXZivEgI+2HrSyvEoWwzTYwxUO6Sw7nOh
	WeIcwG4YvUQdTs/w3YWlHnXxjhjzWHpDyFHYt4P3DiZsyQBUAEUsje3YeOwekmto
	HA/NKOYESvMyqsx4Y1dbX1Wxb/6NQ5rizxKRgWKP1Kk014sKbfcZRegRdS83BBxY
	U1Kb3RMm1Ifb5vfsS8AxsUX/pVhSigNHV4A9oX/NB4nymN/eqAxePU6dE5kCVdRM
	THdBOlV5r0XVoAMNCAN0WUIz4wMTTv3F9EmfkqbewdBCg6xogL8CC3ogJkwDp/et
	A+IDUw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsam4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:58:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a35e1923so3182061cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145098; x=1761749898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgqjTbpnFaE0hcBetVMhGWTjxas9QOG0G/pOXwEzoy8=;
        b=bGYAaG2uaN2iiRu3QaDgi/2WsHm4nf3jirVDU56n7r7a1r0fQzECNmt/hrxD/p+Vgt
         AUegzABjSJZIIz+bmn4nJtHT3x6SSsY+r2fY1242tLfK9xOuu9KVijEMkULpIPFzHumi
         VDX65CcokbjumOG73LoKIyztbbs9HDiCCOrB2rMkhkosZcR7F5Vq1utWWRw/50JSiOCj
         eVPPfIG8HHdm/MvOk533lEqRe/ibZKTAirEOnwJeeEtfPM4fSg29rHJhUioONisw4Eww
         86tC+ssiIqSAHOTWFykmuADT3sTOxuJxUyTdZT5YupuNyf4VBh8MNjXScoRtaBUHXcTW
         FbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGU6yLn3ALFlSWHZu7QaHrZG2+JAqFlyom8SuG3LqNdIbryXp6HNRjxr9zv4DJDL+pzw9xHpqSzUvuMoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegAuq9dzUZgl1bTfUmecjagq/SfgVh+mxRKfMkwnm4u+kKT/C
	bpzJfUazy0A202WSvHu6z4c6LBmo3fiNUOCEJTkhWgpfzXgxe5AaFPN9np+ukU+wjEaaFsb+Q60
	XBx4AOsCXilnF0F29SSKy8U0IQACgRdyM+hOjksSpraA2tn1XIpSkZESjy9JPUjz4OiI=
X-Gm-Gg: ASbGncufo612PveVgPQcosImbj8bBvTg8JBAeXVd+41Up8CsRpT60mLgMyfAN/5zGu/
	Aq/Ruwt9XqpB8UUTElB/ACOnmMq7D0A5AkOAZY4W7y650ucxefnn7UvN64p0SQyVyhr1Drwq6cb
	58u0yk9UH8hbqPutUcVJahlFWNmyHZ5j5KdNdN7UuyPH5mA4YbKlsy34hfnvW1nyNn7EX+ag9+y
	mKy3sSgdXpe60nEYAtPzVJ/S/QVb2MRxyeDyNUbXDXlxyORStO8zqkCYrmFyDSN/4TsdBT+R2IF
	iTRC0VL8mflYeL3CV6Ojs4UgH4OrXzQxkCLRqjcAMmFSn3Oh+EYwlIx1joywiZOHmX5EjuiRDci
	92khup9/551+NauwHkke2Tvp9+az9ZftVeBC8UA3mRNiaBw9R9AZ8j8JB
X-Received: by 2002:a05:622a:60d:b0:4e8:9ed2:790f with SMTP id d75a77b69052e-4ea1177d7a5mr58969981cf.10.1761145097749;
        Wed, 22 Oct 2025 07:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUR9bnbGHJDmSjsGFP17dQVzXSza6HHoSAKI6AUZ1xGMLyDyNfS6OtKnS3TvxPA0S0TIGYKw==
X-Received: by 2002:a05:622a:60d:b0:4e8:9ed2:790f with SMTP id d75a77b69052e-4ea1177d7a5mr58969651cf.10.1761145097194;
        Wed, 22 Oct 2025 07:58:17 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb035d48sm1350290866b.53.2025.10.22.07.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:58:16 -0700 (PDT)
Message-ID: <61c299af-c4f8-47a0-8803-306c08792b17@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 16:58:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] regulator: rpmh-regulator: Fix PMIC5 BOB bypass
 mode handling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
 <on4zcfs5qdaekc7teo2iq6vpw7o2mp6yiqjkbznxo7wcxgutj3@nb35f55fkugv>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <on4zcfs5qdaekc7teo2iq6vpw7o2mp6yiqjkbznxo7wcxgutj3@nb35f55fkugv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX5CP5Zj55Xp7q
 h6mUZrJrdM9tdCQH4Nhhcaoz65xInlWrNR9LBbYBFF5T931UF8g0fmMnfcaPau7n6uSn6UIh5cB
 YEaJS9WebsdNDlXEo2T6Z1yjkNIwz8I2lLHPbtlH2eHtGuF9z/ybhp/MYF9KtTdjB1BKdQM03jT
 34DrgYYUPHn08iVmSv6105siqOS/7G1Vj4tNB/DlDZSHmnFo+D52z5Y9QU07oUoZt6uwE0Zvgzl
 ToWgiB/wFFxYyXsOPWgO5xp3Mcy9QUhoBbf50BOf7AoRwDaQwpuEUtFPU4wH6WGt5u9F12zspkD
 lG/oiM+vvCwH19WbzjQwpHXxuWuim2W/UDeYjnQh90/vXiQ6QQgNvaKCU1ufg49tuQ0JEGZJZXb
 ApzymE0GtSl+Lnw92hoEm10flF/K4g==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f8f10b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kCPPLUCfYJNoUqFreaIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: xZOu7ObqoCgGWy6pVw0f2CusEsOYt7LT
X-Proofpoint-ORIG-GUID: xZOu7ObqoCgGWy6pVw0f2CusEsOYt7LT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On 10/22/25 12:23 AM, Dmitry Baryshkov wrote:
> On Wed, Oct 22, 2025 at 02:38:53AM +0530, Kamal Wadhwa wrote:
>> Currently, when `rpmh_regulator_set_mode_bypass()` helper function
>> is called to set bypass mode, it sends PMIC4's BOB bypass mode
>> value for even if its a PMIC5 BOB.
> 
> The universe will end, the Sun will explode and Ragnarök will be upon
> us. Please describe the issue, why sending bypass value is bad.

I think you misread, it sends the magic value which corresponds
to BYPASS, but one that worked for the previous generation

Konrad

