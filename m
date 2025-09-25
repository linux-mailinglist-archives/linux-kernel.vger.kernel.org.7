Return-Path: <linux-kernel+bounces-832540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BFBB9F9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778614C0D34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B332741A6;
	Thu, 25 Sep 2025 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eucOK8fH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7072727F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807675; cv=none; b=G+8pIXSb6YZr9sWB8tHx4dcgOTiaUpyMIPf1GEKsSGkE3joG48TxzoztdSVxxXRnYH9Dr0HTUWhRiqH19hymYZqGNbvAfMXEA4Xnflcusv6/Oa9LlVmSC0V1iEk8hV8cR6YAJG4MoqwTgdVu1WdLXyr1huqeBPzEqCBX887Ma4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807675; c=relaxed/simple;
	bh=k24TsHdSWeGcrDakZ5ZxZ4u26blxOVBlucfWSid3ZFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGHhsDLDSB7EOpj/+1+UZvz+OkO/RBs+Id4sdS7f1OhlYXuEgRJbU+TbGUBiVSi9YDK0zXTjJUsOK9Z2OcLIRHxa4HGcSjOAA+5q+cUng9MOepsG6hQ2BWXqyxYFadE0qODrP8w83rAXM9PdCiUyohSypr8HZYh6T3/QaWXkd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eucOK8fH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9YqPX021655
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZxuB5kT9QhvZV6VcXA7vRyRC6QPVlvbL5ixfpltHdps=; b=eucOK8fHI7HhgVa8
	3u5MMOZiHNnfVdURqAECjRHKZ7ExeVIJWHEeuEgxep4LuXhlBlpEnBR/EzmvXHos
	G+toHPzHRkAvSTEjqOR6LPGI7lyX9jRU+xkyzGAWPpjft6e/IrBrSAm0ITnqYaKq
	LPatB8rXP17OlhaP2ZtlEMZOn8bOnNE5ge5Z5LAz489BTMA60jD55IayqazRGlYQ
	pExZvl6BgHnu6QWVPnuvmj2S79PuMxVKuEWAm+xAKn/ROSbKzXsqLU7f0hFpCrJL
	myLZ+lrmcge1zbiBij+sJh8YKadcHFkKoMs5HsIrCuNkSTK93Zv9dF4YJXwWUY3j
	lpV/dQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budafuan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:41:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272ed8c106eso6910755ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807671; x=1759412471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxuB5kT9QhvZV6VcXA7vRyRC6QPVlvbL5ixfpltHdps=;
        b=VdHCVCnEw5JZbtHOWCoX8/hKlBR/VaHl5FMKrdqdqxrZ0uCfwVFQF4dxM4xGpJc9zw
         gtWTIqNN0EO0S02HJNRVBbh0C/wbrnjIy9PWf/PQq04c4ms2JyEoccsE6vxGClipYfpo
         uFGQsv+GI62VDcfUTe6figL1r6aZMuq1qhgBJ+OWgzTkCkd+J5ra0YRjB9DVk6wPXhmi
         DUitTt7E8MZT1LwsBLW6GBErijhNrqeLKGbSKl8Ioa5347Ke2K3IE7WNCu0j5rmPdvga
         fOeDw/GkHprN819gIBElE6n32H1aEGZQcyzUGlNJDAnGu62nHVgOGVUc8t+eUilpl9eg
         Wu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO5g4f5lvzSNTj+SzXZ/wv/9mlPM7agYFAeZ6SpSG+u+PpyXDK3kG3JmDJRtuJQ3h9HpE/yGylLST0NMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVjlkZetexpy8z/klIFblR5ec29tmUao+4s9pj6HhgKWBMvcg
	eycDn7MJNn0+c2XKQh9DHpsVLPXMy9GZM/Cmtyaz5nmxpzYroG3NmzA0QDgM9C+es4DzagrbgZt
	0/gYcOYHGKD4Nhd66jAB2ne/5YiuKLiir9d25XaWcjqDY39Cx5utFVKAk+QgP6jHBJXyzLR7X1o
	U=
X-Gm-Gg: ASbGncsm4pSO1EI427TC/l09QjnGvAeesrPYVDF+Q6cf5TDvRwFnwH4XOBPpEjZ2Yv5
	Gb1ihQ8Xmvquf0QXvPXeygNRYn8MY2G3KyzCxCKkUfzaGjZbrWUqXLSaEgCv3VEIKPnodZJzrJ5
	fO4rtN8TOU5acMQslquXyi0kcHCzMqBko2Hq8U00keqQ6sW351DVN68f8u8quRSJXYsWW4EhA15
	l3R6hxSCDYjfTbY8KEdpToBaLhjrgjA6dVzCzaS1NiRyTfswK5PVmALnwB/GlnJ9XHjaw5R4JJw
	l4ugJN4jDZ8DOfPDldgjNnXcf0PdlMaLvJQ4Ikr4haIzCZ/QwFRMALBNJB+57LQ+nOOe
X-Received: by 2002:a17:903:8c8:b0:269:9446:8e45 with SMTP id d9443c01a7336-27ed4a7ebaemr37331055ad.34.1758807670476;
        Thu, 25 Sep 2025 06:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc0Iz3ZnWQ7KLTGI1sXvRmOPwr9wL6X2M5C7upUNaBrMM/aDz21PI8yG4UpXaXxAe3VMbrYg==
X-Received: by 2002:a17:903:8c8:b0:269:9446:8e45 with SMTP id d9443c01a7336-27ed4a7ebaemr37330445ad.34.1758807669493;
        Thu, 25 Sep 2025 06:41:09 -0700 (PDT)
Received: from [192.168.29.198] ([49.37.133.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3df7sm26066295ad.1.2025.09.25.06.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:41:09 -0700 (PDT)
Message-ID: <9066c8b1-bf25-4ce1-a0ee-16e9ab44dcad@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 19:10:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: gcc-glymur: Update the halt check flags for
 pipe clocks
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-glymur_gcc_usb_fixes-v2-1-ee4619571efe@oss.qualcomm.com>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20250925-glymur_gcc_usb_fixes-v2-1-ee4619571efe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wIq8DVdw_X3XYYPSemhQhYFeBZARyson
X-Proofpoint-ORIG-GUID: wIq8DVdw_X3XYYPSemhQhYFeBZARyson
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d54678 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=5wqTxrHxgjUWVXd7k2kF3w==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=encx6hSPGTGxlSLovxUA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfXy2oUsNd7XVhi
 ALD8tsGClvnDLHdJOUpzVVZTWVQ+I4YMpVonrAk1VSoy83bAKk2Gru+HgE8/DHmPs4/FJp9nDHp
 IsZCuvTEurS/Y0QSgXRSIpA7oqI7YidVEoCtJArYERdFbsYXUzOGnGB3kI9p871ULGBtSwcyc/P
 Iej5GHkRowgloMJ1I73Dix/jPP1KGm141ctQcE8KCS+iH0uQHkrLfQfukjupd7VqwsB6jdUHOgh
 5/hy49BiKUikm2O2nZtnatJTLa8uj9IihYiJx5fdaZX/svNTYHQ9dm0fYg5nfIBIHgxDP6xlpfV
 wqHRb3n1AuTE2zJkhOSK5DTAxhQPajRFJsJpLkeIlgNF2yY+6ULBhwriG5t/MjY4Ham7zdrA82m
 eVUywgNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113



On 9/25/2025 3:49 PM, Taniya Das wrote:
> The pipe clocks for PCIE and USB are externally sourced and they should
> not be polled by the clock driver. Update the halt_check flags to 'SKIP'
> to disable polling for these clocks.
> 
> This helps avoid the clock status stuck at 'off' warnings, which are
> benign, since all consumers of the PHYs must initialize a given instance
> before performing any operations.
> 
> Fixes: efe504300a17 ("clk: qcom: gcc: Add support for Global Clock Controller")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
> Changes in v2:
> - Update the commit text to add the SoC name "glymur" [Konrad]
> - Update the commit subject to add more details [Konrad]
> - Add RB [Konrad]
> - Fix a typo [Markus Elfring]
> - Link to v1: https://lore.kernel.org/r/20250924-glymur_gcc_usb_fixes-v1-1-a90568723e64@oss.qualcomm.com
> ---
>  drivers/clk/qcom/gcc-glymur.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> Reviewed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>

Thanks,
Imran

