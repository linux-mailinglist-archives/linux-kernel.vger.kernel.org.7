Return-Path: <linux-kernel+bounces-737675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F97B0AF3A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DDE3BA5DE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181242367C5;
	Sat, 19 Jul 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NF20g5WE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF1236A79
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752919032; cv=none; b=oz8hiMkdvEQiOtbAjYYhiz7ehnPiD/ip7eZDmkZbkBgM2mhUqqgiUBhbsp+s3GAFyO5QyIsMqq65SPKGljv8VELaKrD4ycHzO0P+AUZMLh2q7QYmdynWFwB+OLwtYa1vtIjpRWI71hUi7UJ3H7D2VMPSm8nKFRqSt0L6GF6JJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752919032; c=relaxed/simple;
	bh=pDwwg1I4yPDdKw4UaBB5//5QiSiC09GG7UaOjVyY5kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyHWn2rfoJGdXReRD1zFwNEIg6G9Ck+XJju2GMQ8dX5wGT1tLJvNcOA9UmehjYbt+UPey1MIhpLYM5bgom0kjHG1XZTjvEC0a4tIXXRxrjxgNlUrSDgfSXoQVL/ZPkCCZXc8R2IMHdFjIprE5RujQjhUxfyK5vw2E5BkL6LzxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NF20g5WE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4EF5w009358
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Qpm5LUOYW0NbIz9x0SUrjDatoCsm9pFh9pKabVgSEI=; b=NF20g5WEdy/g7XZF
	2T4fIVuUgSxx9Na/p6U4BZC3cg7Ztmztc4AF90rtU6UjLiyoEGJphS2WhXHu1eRf
	DbgmugngRoTuCGtEgkzkhO9SGQVA34qPgJ0lRznK+K77rO6DGD20+Z1U//BlhLyv
	8F5Ap+459zYbYbX/Qb61U7oxYLBVT6gpdjRclPwQ/d0+TdrEv+/3d8ferxCH+MWq
	Pso0CMHxQM0kS+DCbNVs5OnJabg2Q/hOpZD2Y5Ue4p4pA/CPPDioysri0kT42hQd
	pkv9COF0ySQFPyckOZ8AYCu+pmkw1GqzX5IHnaYaHHiWggsKeXLrKhtzyHzEfaCe
	GUVKkg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804518enf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:57:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d413a10b4cso387520685a.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 02:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752919028; x=1753523828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qpm5LUOYW0NbIz9x0SUrjDatoCsm9pFh9pKabVgSEI=;
        b=ffkz7EjtikT7yWsb2M8Pnw6Fq6ARzPrmRAHjf41qJsoU53L/tCf17gRBpQx2GrDbmi
         vjfi7YFom4/UJVqrSPf33kfTS+TSlk1URiXvDDpwK7uterUwqKiTWFhwKxHmzerfJtjs
         zwHz2dxcTckbnCJSLC6rGVgEVDODeoypsCCX88+31vL+7hVs9kwC4kJtOqgnTW37Qkap
         7u8IOMVsspUu2PbiT6ynPCaO7Em84uDwmEzPbLAsSeHBeMXlGJhG4UADEF9sbr6L6RGa
         680RebjdfPh0liH1PpjTM9ChGsg2ajPnUGDA/Y3F+F0KTesSDa89P+xleUo98M0UmyYR
         SG8g==
X-Forwarded-Encrypted: i=1; AJvYcCUQN59rF2OwORw+OpjBL2LC0W/9U6UxO4q1RgUeqHXoRMEPYyXfhTn+PhobXQpNLfWtg1rj2qMF3C8+qSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Uvyges2Ql6xAF3FkwtJyBqYSb2SC6SQzdkMT8fqT5DLeqvAw
	NbGNcRnQedU849njmP92TuVRLb6J2XgozlbKdotk+W+pSeKrtyDegkU+8j9HCX0tmdPcS2ddBwA
	Bo6RBvCWppyNbTx9EmL1VLJg1nNeF89MXAUJKDS3TtCObnSRIzYuwsxqWOC424ROhZOvNESZaav
	4=
X-Gm-Gg: ASbGncsin7PJOU6ri4KULnuEsPjv7wWV4wQXKlk83jtgwrXxik1U1uUqvmmulud6RLO
	ktQj0zYQsZ6uGKdBPWwhqyaM939jrHyv1eH+l8HwqPlsGst8n5kdVJ66ZLgA5N07jQQdnY098D3
	zl6Srtsb2YQCxeOgV9ExlgzKZI6OJoIQ6k0iYKpsLeBfAZSSep3NghnnDHCBF13ht7ydfkwqMtn
	4BAn04VzXB/gO+am8ppmYPkiVP8zZsIBN4KNdDHTH0+qJwGHd9Dg2/E7kN0VlifaDyj3AEkHnka
	9XRYzBnBhpjW9jjG4AhR/+oZXvUQvsWex8bwkXFqWhHjtEiuN4yNTjxgp1vMrd8e0vRYw8OLUUJ
	ZT2s1Zn5oJx/9XQBga5rS7yZ5wt1PlMICaPGOo92rt/BbGJu2vK5g
X-Received: by 2002:a05:620a:192a:b0:7d5:e432:2d91 with SMTP id af79cd13be357-7e342b8a269mr1885030085a.49.1752919027488;
        Sat, 19 Jul 2025 02:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHnT+6uN4gH9tH0aBvRXhyWR+Hb3dJrYiOSss4O6n0KOcwbt7BeYE7VBVIlbXQg40IuxeUxw==
X-Received: by 2002:a05:620a:192a:b0:7d5:e432:2d91 with SMTP id af79cd13be357-7e342b8a269mr1885026985a.49.1752919026865;
        Sat, 19 Jul 2025 02:57:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b1dfsm653211e87.43.2025.07.19.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:57:05 -0700 (PDT)
Date: Sat, 19 Jul 2025 12:57:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v6 2/2] i2c: i2c-qcom-geni: Add Block event interrupt
 support
Message-ID: <4q3vlydi5xgltd3pcez54alxgrehhfn4pppg47ngwp6y5k7n33@d4d4htntj64k>
References: <ba7559c8-36b6-4628-8fc4-26121f00abd5@quicinc.com>
 <w6epbao7dwwx65crst6md4uxi3iivkcj55mhr2ko3z5olezhdl@ffam3xif6tmh>
 <5ed77f6d-14d7-4b62-9505-ab988fa43bf2@quicinc.com>
 <644oygj43z2um42tmmldp3feemgzrdoirzfw7pu27k4zi76bwg@wfxbtgqqgh4p>
 <dc7358a1-ddc5-402e-9024-283f8e46e3b6@quicinc.com>
 <CAO9ioeVuAO6mYpBSpiTW0jhFRPtkubZ5eEskd1yLBHVdR8_YMA@mail.gmail.com>
 <1b55d9d4-f3ff-4cd9-8906-5f370da55732@quicinc.com>
 <28d26c70-178f-413b-b7f8-410c508cfdd7@quicinc.com>
 <CAO9ioeXBwFYL8q7x7_fHvx5YO+qyAXk4wpnfPrku4iY9yBsk0Q@mail.gmail.com>
 <cac5e84b-fbdb-47a9-860d-16a7fa4dc773@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cac5e84b-fbdb-47a9-860d-16a7fa4dc773@quicinc.com>
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687b6bf4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=QKgs9u4qdCnUtHDJ4GcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: TIllkwSEoLzEPFldqJ81S9n69073XbxR
X-Proofpoint-GUID: TIllkwSEoLzEPFldqJ81S9n69073XbxR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA5OCBTYWx0ZWRfXwWtyFf2LFb2b
 U44meNUpYdxV5rysAUvzhdrUi7ycwA3Gmt+g4XNXyqVXeKLqv3a1+rlm0fQIbzMDXRyzpB8xX3h
 YK1RF5DbFieLWUWWG2BR8kcS9RtjR9yoAeJtZ9uOsxZTRDm+U5b7Is6F0C1Q6AtXiDX0Zc2Xc8o
 vVnmoAJMGCGU8Yooe5FjdATVaFlGxLfpgeEItGErjLfPYGROU2cK7xIHIGuXqyJ8XizQWoOvrM9
 LZcqAFB3ZHB36Ea/PMwf9TElgIPgJSgmL1UhwxfKZRxcZqEgVaCJfBbxqD5MJuyYIOSZ1UxATPw
 07Ibd2UPaDesDeTarlIh7ym1Sy598ixdACRJHZ0rxUkE6FrqgLuxYs42hG4i1H3ad/rPQk0JNRQ
 wpUEC7isaP2H9LbGgVxaQbznqScK8TX17k7prLaF44K8oSdkEnmsve2aKGyUzqRdbj2H/N4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507190098

On Mon, Jul 07, 2025 at 09:58:30PM +0530, Jyothi Kumar Seerapu wrote:
> 
> 
> On 7/4/2025 1:11 AM, Dmitry Baryshkov wrote:
> > On Thu, 3 Jul 2025 at 15:51, Jyothi Kumar Seerapu
> > <quic_jseerapu@quicinc.com> wrote:
> > > 
> > > 
> > > 
> > > On 6/19/2025 9:46 PM, Jyothi Kumar Seerapu wrote:
> > > > 
> > > > 
> > > > On 6/18/2025 1:02 AM, Dmitry Baryshkov wrote:
> > > > > On Tue, 17 Jun 2025 at 17:11, Jyothi Kumar Seerapu
> > > > > <quic_jseerapu@quicinc.com> wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > On 5/30/2025 10:12 PM, Dmitry Baryshkov wrote:
> > > > > > > On Fri, May 30, 2025 at 07:36:05PM +0530, Jyothi Kumar Seerapu wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 5/21/2025 6:15 PM, Dmitry Baryshkov wrote:
> > > > > > > > > On Wed, May 21, 2025 at 03:58:48PM +0530, Jyothi Kumar Seerapu wrote:
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > On 5/9/2025 9:31 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > On 09/05/2025 09:18, Jyothi Kumar Seerapu wrote:
> > > > > > > > > > > > Hi Dimitry, Thanks for providing the review comments.
> > > > > > > > > > > > 
> > > > > > > > > > > > On 5/6/2025 5:16 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > > > On Tue, May 06, 2025 at 04:48:44PM +0530, Jyothi Kumar Seerapu
> > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > The I2C driver gets an interrupt upon transfer completion.
> > > > > > > > > > > > > > When handling multiple messages in a single transfer, this
> > > > > > > > > > > > > > results in N interrupts for N messages, leading to significant
> > > > > > > > > > > > > > software interrupt latency.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > To mitigate this latency, utilize Block Event Interrupt (BEI)
> > > > > > > > > > > > > > mechanism. Enabling BEI instructs the hardware to prevent
> > > > > > > > > > > > > > interrupt
> > > > > > > > > > > > > > generation and BEI is disabled when an interrupt is necessary.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Large I2C transfer can be divided into chunks of 8 messages
> > > > > > > > > > > > > > internally.
> > > > > > > > > > > > > > Interrupts are not expected for the first 7 message
> > > > > > > > > > > > > > completions, only
> > > > > > > > > > > > > > the last message triggers an interrupt, indicating the
> > > > > > > > > > > > > > completion of
> > > > > > > > > > > > > > 8 messages. This BEI mechanism enhances overall transfer
> > > > > > > > > > > > > > efficiency.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Why do you need this complexity? Is it possible to set the
> > > > > > > > > > > > > DMA_PREP_INTERRUPT flag on the last message in the transfer?
> > > > > > > > > > > > 
> > > > > > > > > > > > If i undertsand correctly, the suggestion is to get the single
> > > > > > > > > > > > intetrrupt for last i2c message only.
> > > > > > > > > > > > 
> > > > > > > > > > > > But With this approach, we can't handle large number of i2c
> > > > > > > > > > > > messages
> > > > > > > > > > > > in the transfer.
> > > > > > > > > > > > 
> > > > > > > > > > > > In GPI driver, number of max TREs support is harcoded to 64
> > > > > > > > > > > > (#define
> > > > > > > > > > > > CHAN_TRES   64) and for I2C message, we need Config TRE, GO TRE
> > > > > > > > > > > > and
> > > > > > > > > > > > DMA TREs. So, the avilable TREs are not sufficient to handle
> > > > > > > > > > > > all the
> > > > > > > > > > > > N messages.
> > > > > > > > > > > 
> > > > > > > > > > > It sounds like a DMA driver issue. In other words, the DMA
> > > > > > > > > > > driver can
> > > > > > > > > > > know that it must issue an interrupt before exausting 64 TREs in
> > > > > > > > > > > order
> > > > > > > > > > > to
> > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > Here, the plan is to queue i2c messages (QCOM_I2C_GPI_MAX_NUM_MSGS
> > > > > > > > > > > > or 'num' incase for less messsages), process and unmap/free
> > > > > > > > > > > > upon the
> > > > > > > > > > > > interrupt based on QCOM_I2C_GPI_NUM_MSGS_PER_IRQ.
> > > > > > > > > > > 
> > > > > > > > > > > Why? This is some random value which has no connection with
> > > > > > > > > > > CHAN_TREs.
> > > > > > > > > > > Also, what if one of the platforms get a 'liter' GPI which
> > > > > > > > > > > supports less
> > > > > > > > > > > TREs in a single run? Or a super-premium platform which can use 256
> > > > > > > > > > > TREs? Please don't workaround issues from one driver in another
> > > > > > > > > > > one.
> > > > > > > > > > 
> > > > > > > > > > We are trying to utilize the existing CHAN_TRES mentioned in the
> > > > > > > > > > GPI driver.
> > > > > > > > > > With the following approach, the GPI hardware can process N
> > > > > > > > > > number of I2C
> > > > > > > > > > messages, thereby improving throughput and transfer efficiency.
> > > > > > > > > > 
> > > > > > > > > > The main design consideration for using the block event interrupt
> > > > > > > > > > is as
> > > > > > > > > > follows:
> > > > > > > > > > 
> > > > > > > > > > Allow the hardware to process the TREs (I2C messages), while the
> > > > > > > > > > software
> > > > > > > > > > concurrently prepares the next set of TREs to be submitted to the
> > > > > > > > > > hardware.
> > > > > > > > > > Once the TREs are processed, they can be freed, enabling the
> > > > > > > > > > software to
> > > > > > > > > > queue new TREs. This approach enhances overall optimization.
> > > > > > > > > > 
> > > > > > > > > > Please let me know if you have any questions, concerns, or
> > > > > > > > > > suggestions.
> > > > > > > > > 
> > > > > > > > > The question was why do you limit that to
> > > > > > > > > QCOM_I2C_GPI_NUM_MSGS_PER_IRQ.
> > > > > > > > > What is the reason for that limit, etc. If you think about it, The
> > > > > > > > > GENI
> > > > > > > > > / I2C doesn't impose any limit on the number of messages processed in
> > > > > > > > > one go (if I understand it correctly). Instead the limit comes
> > > > > > > > > from the
> > > > > > > > > GPI DMA driver. As such, please don't add extra 'handling' to the I2C
> > > > > > > > > driver. Make GPI DMA driver responsible for saying 'no more for now',
> > > > > > > > > then I2C driver can setup add an interrupt flag and proceed with
> > > > > > > > > submitting next messages, etc.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > For I2C messages, we need to prepare TREs for Config, Go and DMAs.
> > > > > > > > However,
> > > > > > > > if a large number of I2C messages are submitted then may may run
> > > > > > > > out of
> > > > > > > > memory for serving the TREs. The GPI channel supports a maximum of
> > > > > > > > 64 TREs,
> > > > > > > > which is insufficient to serve 32 or even 16 I2C messages
> > > > > > > > concurrently,
> > > > > > > > given the multiple TREs required per message.
> > > > > > > > 
> > > > > > > > To address this limitation, a strategy has been implemented to
> > > > > > > > manage how
> > > > > > > > many messages can be queued and how memory is recycled. The constant
> > > > > > > > QCOM_I2C_GPI_MAX_NUM_MSGS is set to 16, defining the upper limit of
> > > > > > > > messages that can be queued at once. Additionally,
> > > > > > > > QCOM_I2C_GPI_NUM_MSGS_PER_IRQ is set to 8, meaning that
> > > > > > > > half of the queued messages are expected to be freed or deallocated
> > > > > > > > per
> > > > > > > > interrupt.
> > > > > > > > This approach ensures that the driver can efficiently manage TRE
> > > > > > > > resources
> > > > > > > > and continue queuing new I2C messages without exhausting memory.
> > > > > > > > > I really don't see a reason for additional complicated handling in
> > > > > > > > > the
> > > > > > > > > geni driver that you've implemented. Maybe I misunderstand
> > > > > > > > > something. In
> > > > > > > > > such a case it usually means that you have to explain the design
> > > > > > > > > in the
> > > > > > > > > commit message / in-code comments.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > The I2C Geni driver is designed to prepare and submit descriptors
> > > > > > > > to the GPI
> > > > > > > > driver one message at a time.
> > > > > > > > As a result, the GPI driver does not have visibility into the current
> > > > > > > > message index or the total number of I2C messages in a transfer.
> > > > > > > > This lack
> > > > > > > > of context makes it challenging to determine when to set the block
> > > > > > > > event
> > > > > > > > interrupt, which is typically used to signal the completion of a
> > > > > > > > batch of
> > > > > > > > messages.
> > > > > > > > 
> > > > > > > > So, the responsibility for deciding when to set the BEI should lie
> > > > > > > > with the
> > > > > > > > I2C driver.
> > > > > > > > 
> > > > > > > > If this approach is acceptable, I will proceed with updating the
> > > > > > > > relevant
> > > > > > > > details in the commit message.
> > > > > > > > 
> > > > > > > > Please let me know if you have any concerns or suggestions.
> > > > > > > 
> > > > > > Hi Dmitry, Sorry for the delayed response, and thank you for the
> > > > > > suggestions.
> > > > > > 
> > > > > > > - Make gpi_prep_slave_sg() return NULL if flags don't have
> > > > > > >      DMA_PREP_INTERRUPT flag and there are no 3 empty TREs for the
> > > > > > >      interrupt-enabled transfer.
> > > > > > "there are no 3 empty TREs for the interrupt-enabled transfer."
> > > > > > Could you please help me understand this a bit better?
> > > > > 
> > > > > In the GPI driver you know how many TREs are available. In
> > > > > gpi_prep_slave_sg() you can check that and return an error if there
> > > > > are not enough TREs available.
> > > > > 
> > > > > > > 
> > > > > > > - If I2C driver gets NULL from dmaengine_prep_slave_single(), retry
> > > > > > >      again, adding DMA_PREP_INTERRUPT. Make sure that the last one
> > > > > > > always
> > > > > > >      gets DMA_PREP_INTERRUPT.
> > > > > > Does this mean we need to proceed to the next I2C message and ensure
> > > > > > that the DMA_PREP_INTERRUPT flag is set for the last I2C message in each
> > > > > > chunk? And then, should we submit the chunk of messages to the GSI
> > > > > > hardware for processing?
> > > > > 
> > > > > No. You don't have to peek at the next I2C message. This all concerns
> > > > > the current I2C message. The only point where you have to worry is to
> > > > > explicitly set the flag for the last message.
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > - In geni_i2c_gpi_xfer() split the loop to submit messages until you
> > > > > > >      can, then call wait_for_completion_timeout() and then
> > > > > > >      geni_i2c_gpi_unmap() for submitted messages, then continue with
> > > > > > > a new
> > > > > > >      portion of messages.
> > > > > > Since the GPI channel supports a maximum of 64 TREs, should we consider
> > > > > > submitting a smaller number of predefined messages — perhaps fewer than
> > > > > > 32, such as 16?
> > > > > 
> > > > > Why? Just submit messages until they fit, then flush the DMA async
> > > > > channel.
> > > > > 
> > > > > > This is because handling 32 messages would require one TRE for config
> > > > > > and 64 TREs for the Go and DMA preparation steps, which exceeds the
> > > > > > channel's TRE capacity of 64.
> > > > > > 
> > > > > > We designed the approach to submit a portion of the messages — for
> > > > > > example, 16 at a time. Once 8 messages are processed and freed, the
> > > > > > hardware can continue processing the TREs, while the software
> > > > > > simultaneously prepares the next set of TREs. This parallelism helps in
> > > > > > efficiently utilizing the hardware and enhances overall system
> > > > > > optimization.
> > > > > 
> > > > > 
> > > > > And this overcomplicates the driver and introduces artificial
> > > > > limitations which need explanation. Please fix it in a simple way
> > > > > first. Then you can e.g. implement the watermark at the half of the
> > > > > GPI channel depth and request DMA_PREP_INTERRUPT to be set in the
> > > > > middle of the full sequence, allowing it to be used asynchronously in
> > > > > the background.
> > > > > 
> > > > 
> > > > Okay, will review it. Thanks.
> > > > 
> > > > 
> > > 
> > > Hi Dmitry,
> > > 
> > > Can you please check and confirm the approach to follow is something
> > > like the pseudo code mentioned below:
> > 
> > Yes, this is what I've had in mind.
> 
> So, Apart from the changes related to "submitting I2C messages until they
> fit" and "unmapping all processed I2C messages together", the rest of the
> code looks remains the same as in the v6 patch ?
> Also, in the GPI driver, we need to add logic to retrieve the number of
> available TREs.
> 
> I have a concern regarding throughput and achieving parallelism between
> software and hardware processing with this new approach. Since we need to
> unmap all processed messages together, the software cannot queue the next
> set of TREs while the hardware is still processing the current ones.

Does that warrant the over-complexity of the driver or close-coupling of
I2C and GPE drivers?

The I2C is a slow bus and it is not expected to be used for
high-throughput data.

> 
> As I mentioned earlier, the previous approach allowed partial unmapping
> where half of the messages processed by the hardware could be
> freed/unmapped. This enabled the hardware to continue processing the
> remaining TREs while the software simultaneously prepared the next batch.
> This parallelism helped in better hardware utilization and improved overall
> system performance.

Measurements / values / impact?

> 
> Could you please confirm if can go with the similar approach of unmap the
> processed TREs based on a fixed threshold or constant value, instead of
> unmapping them all at once?

I'd still say, that's a bad idea. Please stay within the boundaries of
the DMA API.

> > 
> > > 
> > > GPI driver:
> > > In gpi_prep_slave_sg() function,
> > > 
> > > if (!(flags & DMA_PREP_INTERRUPT) && !gpi_available_tres(chan))
> > >          return NULL;
> > > 
> > > 
> > > I2C GENI driver:
> > > 
> > > for (i = 0; i < num; i++)
> > > {
> > >      /* Always set interrupt for the last message */
> > >      if (i == num_msgs - 1)
> > >          flags |= DMA_PREP_INTERRUPT;
> > > 
> > > 
> > >      desc = dmaengine_prep_slave_single(chan, dma_addr, len, dir, flags);
> > >      if (!desc && !(flags & DMA_PREP_INTERRUPT)) {
> > >            /* Retry with interrupt if not enough TREs */
> > >            flags |= DMA_PREP_INTERRUPT;
> > >            desc = dmaengine_prep_slave_single(chan, dma_addr, len, dir,   flags);
> > >      }
> > > 
> > > 
> > >      if (!desc)
> > >          break;
> > > 
> > > 
> > >       dmaengine_submit(desc);
> > >       msg_idx++;
> > > }
> > > 
> > > dma_async_issue_pending(chan));
> > > 
> > > time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
> > > if (!time_left)
> > >          return -ETIMEDOUT;
> > > 
> > > Now Invoke "geni_i2c_gpi_unmap" for unmapping all submitted I2C messages.
> > > 
> > > 
> > > Thanks,
> > > JyothiKumar
> > > 
> > > 
> > > 
> > 
> > 
> 

-- 
With best wishes
Dmitry

