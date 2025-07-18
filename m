Return-Path: <linux-kernel+bounces-737224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017EAB0A976
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C864E3008
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C44B2E7BA4;
	Fri, 18 Jul 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DzobpW+x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512302E7181
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859623; cv=none; b=kv7ASxpq5LwvYAq6oLtKq5fJr5UgM6u6RiTkxhSB+0MZUKftyi+zWvTtPyMr2MfhkJ3vUErRrobTy9eGiLMtUpAbvgrn0zvXCJYbrz+49I/eMd1+hUz9uQX1DUFr3/M7iydjIU+OaQeaK/fkpnkwNdgcbR8r0C0o7Jeb5XJJLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859623; c=relaxed/simple;
	bh=PNmspk2fu/IR2dTOXna+ISz0MMt+wWO3tpb86klVnyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ7iFWgn3K0Xi/5j4sEuwLHtJHkjycQwYERiCIYFlH7jneLYR1N4Va/wIPS1NT5Iyts9lIp3sfAnj5aCpW3y58wBZKDHpFMquEWhAGxZh3pnSV2mAaeyIxOZD8s+7G3PMzOU6gBbcBcm7mpQHqqQvnDDkr/+aHIRTFFA76QIaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DzobpW+x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ICL4tS029884
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+kObH4cbteXwLfeWdFmGrxDm
	MfZ/gQ1F30gvtsINTQo=; b=DzobpW+x4Sh8HuTb8Br5Y4W+K5FzLi3MZPbDfkFZ
	MOfcuNouCk8DaeQ1fb1jO4tI3wfNVKHQcEnGzkUkTGNIFO0HaZGpsxjragGUs2gB
	fCQpzl0OH3l212xZk5/IZSdhs6QX5fHuZFQ2P14fIxtuAznDWYsoctXbC7mjHDGH
	duH4t5jOAWVowBRzq1PyzWERehL82idn6iodHao1Mg6xczlo+fbQP/UgIklgKME7
	pkTGb/ZFwuK/Qp9NGuYwqPaexxjMMiwZlorCxexWpNkNiUdu6y8HVcHAblkcAbTh
	Z2xVIdbhUqGe1u+vr1Hmx4Tc29sCX7Q1tleGm3zn2awuBQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7s8xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:27:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e3452c060eso205223485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752859620; x=1753464420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kObH4cbteXwLfeWdFmGrxDmMfZ/gQ1F30gvtsINTQo=;
        b=l1C1aOyfegF+dXpVlbZGsZrwQ46ePjZcemsU+5uita1+hNmkqktCYxvbRn1QhDpkoi
         zGN7CiZ7jbGC/rKFzpwNDBbkjLDiaaT0dOw3HEt8ExmiZXJ5UIImK/U2p1AJhPhkX0+K
         UbzxQlMUHWxxb4NKZY5EeeMIzR+dlx3qQjXpDzbooqaNwRcaI3SUAPX1CHnd+nIWOf0C
         lTp4K84PMQX8P74mqpycyOwD0hZDiRhlWtGZoorgJkkNeDHp6W/+XjJbWtHQ8P09+HoY
         6Pvd0JxMQdLS4v9xtktcvldA+GV9qRlEqU5YHYmaYw4t+JjR+43obM/6/pblIVrGQuSA
         MxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcHSxFMNbd6D8F5BPx0oZpjMOecOgYfU7PP8E0/xso6Q0ekWmQuKT1uml0IKcH6nVFM1mrfI8jMZ9OTts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbsEB+4leVJzxvbVTykv7nKBCnV5FiRYipj/b8qI4NcIZvnoB
	Py+l6oDzMOnj5HkuZ57HIrEQSQjN7lFEzYfFr3yJbywvVn7TfcMd+BByv+Cpiag2CmX4fJkIKUb
	Hiu1pU/ckBm52JZO77UAJBZ/KDme6kaYdZjyQTZrIGLvEA1lSRxYE7Ki8tErV5tS5860=
X-Gm-Gg: ASbGnct5FVZlIZBuPqPtUiNdZao1CukfMEsoTyOx9ILsP7Ah7ga04QI7VgDeqDYN5mL
	qDrPiJuilbRne97PCpx6ngOPO7Ws/i9/JFAzLGiKfl4ZCP/1pNpdTBIZjRP/FBZSuu8950wlL72
	KwkBwaTFxZ/gZavaYpSSBZ3QXI5X3bndDti6ZarUQ117kL9eOLI8PnU6XUXbcEGzxgNQs4FYyq/
	MnY45dCptaMV3s7XF9g2QTj3olCvT2em5YrYDtWODhBzFx6moWKV/F20Z9u3hpflHzkLbCV/UQl
	017M2p/n2gjL+B8Tb0nZeo3vW7h1ftzTSYrsZc8a7BhNd2KnWw07BpPk3HyI1LBNVBNHk4vnlsS
	YfMbfaDO1PtUXwh1irtGbS/GLIFzq777AhXwHeTdCUzRW1cmazf0K
X-Received: by 2002:a05:620a:3d89:b0:7e3:4416:fd6 with SMTP id af79cd13be357-7e344165874mr1273078485a.61.1752859620311;
        Fri, 18 Jul 2025 10:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ/ik+O1GI49O6qiePOhD7kpa6iYGBKoCjB8vuyMr6LyH7Wks4unXKok1B6hJX1V6SOF0HVg==
X-Received: by 2002:a05:620a:3d89:b0:7e3:4416:fd6 with SMTP id af79cd13be357-7e344165874mr1273073985a.61.1752859619766;
        Fri, 18 Jul 2025 10:26:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aac72csm335768e87.58.2025.07.18.10.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 10:26:58 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:26:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/28] interconnect: qcom: rpmh: make nodes a
 NULL_terminated array
Message-ID: <efvyk4ojddr3emsdavex4uqrl476sj5hz3ihd6kditdxd373jm@wu2av4fvqc4h>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
 <859be3e3-be14-411d-b5ef-07bdad91a878@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <859be3e3-be14-411d-b5ef-07bdad91a878@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzOCBTYWx0ZWRfX5YeY0RvV4QTd
 BDaEft0NiAIMTlRt8BUI/sNHXer0Om7DFTQ9iLY+1/BFEbd8cOQKHReUyo+buX5o6/+/+9kSAzS
 MAP1Cu+PiK+zqVtOdeZgMx/TQHKKK2OWFGbnBZnGn9a+Ce64fqq3RzXbQbPXGFeOc5wL6/hjAdo
 rq/zyUZx+7jcvlNeAkIreIXxWXNG9WRDa3rVyzoYnBpQVzsn77wdcZNRS9imvjxwtGVoF/pKj++
 OOHRSrWyYGdAABYpRWxgLogUGyTvNlnH7nvNrr9IwaOViSQh7AClx4qQMmjEQLx1pD/U20FCAtD
 FvKMohKGUm/UYAiTOk8hNhOfLAGFdCezxgn1Pmra3JdwbG2PzMfO5okYXW/lXmMIp0CDKiIlrP/
 cHDwNB+X6SWAcpwH0/Hw4OwEttGJ2fFIVCvr7eOLhXuxUC+a8aAx3lNnwJEbW3nSO+Mblmh1
X-Proofpoint-GUID: 2BTjxYXoeSgRS_6kjyWNsiyZmWMF5u3V
X-Proofpoint-ORIG-GUID: 2BTjxYXoeSgRS_6kjyWNsiyZmWMF5u3V
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=687a83e5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=aAPYKyr1qmF_MXq4w6AA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180138

On Fri, Jul 18, 2025 at 04:38:02PM +0300, Georgi Djakov wrote:
> Hi Dmitry,
> 
> On 7/4/25 7:35 PM, Dmitry Baryshkov wrote:
> > Having the .num_nodes as a separate struct field can provoke errors as
> > it is easy to omit it or to put an incorrect value into that field. Turn
> > .nodes into a NULL-terminated array, removing a need for a separate
> > .num_nodes field.
> 
> I am not entirely convinced that an error in the termination is more
> unlikely than an error in the num_nodes. Aren't we trading one kind of
> error for another? Also if we omit the num_nodes i expect that just the
> QoS of a specific path will fail, but if we miss the NULL - worse things
> might happen.

Exactly, that's the point. It is easy to miss num_nodes, while omitting
NULL will crash the driver. So the error will be noted during
development.

> 
> [..]
> >   27 files changed, 541 insertions(+), 1119 deletions(-)
> 
> The negative diffstat is nice.
> 
> > 
> > diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> > index a2d437a05a11fa7325f944865c81a3ac7dbb203e..4fa960630d28f338f484794d271a5b52f3e698d3 100644
> > --- a/drivers/interconnect/qcom/bcm-voter.c
> > +++ b/drivers/interconnect/qcom/bcm-voter.c
> > @@ -68,7 +68,7 @@ static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
> >   		bcm->vote_x[bucket] = 0;
> >   		bcm->vote_y[bucket] = 0;
> > -		for (i = 0; i < bcm->num_nodes; i++) {
> > +		for (i = 0; bcm->nodes[i]; i++) {
> >   			node = bcm->nodes[i];
> 
> I like better the single memory access and the two registers comparison
> that we already have, but both are fine as we are not in some critical
> section.
> 
> [..]
> > diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> > index bd8d730249b1c9e5b37afbee485b9500a8028c2e..0018aa74187edcac9a0492c737771d957a133cc0 100644
> > --- a/drivers/interconnect/qcom/icc-rpmh.h
> > +++ b/drivers/interconnect/qcom/icc-rpmh.h
> > @@ -126,7 +126,6 @@ struct qcom_icc_node {
> >    * communicating with RPMh
> >    * @list: used to link to other bcms when compiling lists for commit
> >    * @ws_list: used to keep track of bcms that may transition between wake/sleep
> > - * @num_nodes: total number of @num_nodes
> >    * @nodes: list of qcom_icc_nodes that this BCM encapsulates
> >    */
> >   struct qcom_icc_bcm {
> > @@ -142,7 +141,6 @@ struct qcom_icc_bcm {
> >   	struct bcm_db aux_data;
> >   	struct list_head list;
> >   	struct list_head ws_list;
> > -	size_t num_nodes;
> 
> So no change in memory footprint, as now instead of the num_nodes, there
> will be an additional NULL pointer for termination.
> 
> [..]
> 
> Well, this approach is also good. The existing one just follows the pattern
> used by other frameworks, that seemed more common and thus make the code
> easier to read and review.
> 
> I don't see a strong argument to switch to a NULL terminated arrays (yet),
> as it does not make things any better for performance/memory, so I'm not
> sure if it's worth reshuffling the 10k+ LoC in drivers. Is there any other
> argument that i miss?

Well, two arguments:

- Two first patches in the series (which fix num_links / num_nodes).

- I think we should drop the old (static IDs) code path. Switching to
  dynamic IDs would require reshuffling of the drivers (and these
  arrays) anyway.

> 
> Thanks,
> Georgi
> 

-- 
With best wishes
Dmitry

