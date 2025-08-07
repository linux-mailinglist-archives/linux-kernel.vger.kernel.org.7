Return-Path: <linux-kernel+bounces-758708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6883EB1D2F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108C6726D48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C222D9F7;
	Thu,  7 Aug 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TZQ9APmb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42311D5ABA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550337; cv=none; b=Ksm6MdNAGemUhMWTHOA7nlyKoIBPYL+fLTyXJUqktod706jBmYrVZY4TRb+g1aur4qbycKhaRwHmN75wl75mr7vGz+VoaYaXmnGm+O4Y95qseDG2M2H/sIG+J2eWxK6YXcTAl4ltzGP92xw23SQSVzeLnaUWkuKvRmMP3HCZIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550337; c=relaxed/simple;
	bh=Kgx7RqlnCo/Do8jGKVBn1jWSSS9hNeZIxS8bpdit484=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrzKZSo6gRt5HLlfYzANMB3E4oAM/UxJQwqIR15p31u4/UPPH740gey/KieRGCXYDfB7/8oXsQO6Ie+jJHN7fdpu8PzsI/9iZC9w3Y1tK/PDQgJGjELPfn29Hq8fZOfekk2gD9rlkrvyi8ZWqt22GqJWIX1VcKui4XBB3013qnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TZQ9APmb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5775YUbd012331;
	Thu, 7 Aug 2025 07:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=UGgZPqwfgoUb3FUlEOMOs
	j4NuTWgvSdptoWgx08oWgU=; b=TZQ9APmbgZnNtgh6y7KPIiWdbYBTUE0TGiwrd
	SPy1G5K5W1ZHOq5lLwcYuxqfzFUVHjrC+av6h1ZAKfRqIR/wEhkAnECuNCWb5EIC
	/E8pIRsUzO/GfJP7/eKwWvZyFbmQlCZXfTS+fiNrLOrz2gRcLFZ7aNmY51fKR/7X
	Nr8GCHn9Lu1891t6BYy+1VFUqqIlAX+9bP+6ks3niKAkHcz8rJ3oIJXSTPD5O/+z
	40ibi7x9pUgaDJoF1xwasBkYeks07XALNbIQZKK42xTWgRNBNBDbKdSMSDS8Wl+g
	jQjxOKpgUDd3L7bFBoW8IoFrtN7qKzsn237nt1+E8rUsEriVg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63rhb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:05:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577753gr002323;
	Thu, 7 Aug 2025 07:05:03 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63rhb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:05:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5775o8mp025899;
	Thu, 7 Aug 2025 07:05:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn7du3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:05:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57774x1051773888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 07:04:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3252C20049;
	Thu,  7 Aug 2025 07:04:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01FD52004B;
	Thu,  7 Aug 2025 07:04:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  7 Aug 2025 07:04:56 +0000 (GMT)
Date: Thu, 7 Aug 2025 12:34:56 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH] pseries/lparcfg: Add resource group monitoring
Message-ID: <aJRQGGr0E5Z9Fqjw@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20250716104600.59102-1-srikar@linux.ibm.com>
 <da3a0717-fe3a-49db-bebd-f231a7fdedb7@linux.ibm.com>
 <aJGZ5_Sf4c1ByCeb@linux.ibm.com>
 <b2e88230-84ed-4b2a-b097-1b813fb42e2a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b2e88230-84ed-4b2a-b097-1b813fb42e2a@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA1MiBTYWx0ZWRfXyXc7JPVTH3CF
 GlHtMuE0tXwwWztY/BfUPj422RDEKmYo9tdmWTKN+Q6Q3rwK+kAUKrIjC2TmNrjOmS9VEa8QNBD
 /Lb6WNJ3qb5DUv9ht9yPQAofxkf7TYOma5XNdtaUomBpBXjrNDlBOAI55kqan2KqvY2m12CvpTa
 BIhcSlYeDurnE41w5LM/6T0jPFoyK43m+uWcIhrzTt5KiAGZMhUpxDldwqaermSBDhaQBxFF7qX
 kCdxXkq8+Sywvbrdu9o/FkDSLGyQ2n0m2Tgz4lskYEL/kupoFTCQHAH5nlXCZUDQPAoIGxsqbWR
 r2EC6Qfb6Ma9l1ghaB0LloFsOzF0OCzzi9cZKXifDkvdqdbrbqDaHJQZ9/BtnbMeHVgqsUXgybk
 1VrUCc2yR6xXTWwDIiXmulw+6vIFXttejp1qfFUlB/aWdzgUTp19+JAOQcI4RFdTiUgv0Ws+
X-Proofpoint-ORIG-GUID: 92DFMifLVMEtyCLB6HMF5bsGv6EH0L73
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=68945020 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=VgkgaohVKf-vvqSBLYMA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: YQZDuHdl6EoFe6JuTBtixTAuqOvpVhzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070052

* Shrikanth Hegde <sshegde@linux.ibm.com> [2025-08-06 19:49:13]:

> 
> 
> On 8/5/25 11:13, Srikar Dronamraju wrote:
> > * Shrikanth Hegde <sshegde@linux.ibm.com> [2025-08-01 19:27:22]:
> > 
> 
> > > 
> > > Could you please add a link to patch on power utils on how it is being consumed?
> > 
> > I am not sure I understood your query, it looks a bit ambiguous.
> > 
> > If your query is on how lparcfg data is being consumed.
> > All tools that are consuming lparcfg will continue to use the same way.
> > Since this is not changing the way lparcfg is being consumed, I think it is
> > redundant information that need not be carried in all the changes/commits to
> > lparcfg. Such an information would be required when lparcfg file was
> > created.
> 
> I was saying you could point to power utils patch that you have sent which says how
> one would consume this.
> 
> https://groups.google.com/g/powerpc-utils-devel/c/8b2Ixk8vk2w

I guess, power utils patch would need a linuxppc-dev mail reference and not
vice-versa. Since this patch would sent first and the reviewers of the power
utils patch would a need a reference to this patch.

Since this patch needs to be sent first, how do I generate a url for the
second / subsequent patch?

> 
> > 
> > If your query is on how resource group data is being consumed by users.
> 
> > > 
> > > Does MODULE_VERS need to increased?
> > 
> > All tools that are consuming lparcfg will continue to use the same way.
> > If there was some conditional changes that need to be done by the tools,
> > then we should have updated the same.
> > Hence there is not need to update MODULE_VERS.
> > 
> 
> Since there are two new fields user scripts might need change is why i was suggesting
> we might need to increase MODULE_VERS

I still dont see a reason for increasing the MODULE_VERS

> 
> > > 
> > > > @@ -78,6 +78,8 @@ struct hvcall_ppp_data {
> > > >    	u8	capped;
> > > >    	u8	weight;
> > > >    	u8	unallocated_weight;
> > > > +	u8      resource_group_index;
> > > > +	u16     active_procs_in_resource_group;
> > > >    	u16	active_procs_in_pool;
> > > >    	u16	active_system_procs;
> > > >    	u16	phys_platform_procs;
> > > > @@ -86,7 +88,7 @@ struct hvcall_ppp_data {
> > > >    };
> > > >    /*
> > > > - * H_GET_PPP hcall returns info in 4 parms.
> > > > + * H_GET_PPP hcall returns info in 5 parms.
> > > >     *  entitled_capacity,unallocated_capacity,
> > > >     *  aggregation, resource_capability).
> > > >     *
> > > > @@ -94,11 +96,11 @@ struct hvcall_ppp_data {
> > > >     *  R5 = Unallocated Processor Capacity Percentage.
> > > >     *  R6 (AABBCCDDEEFFGGHH).
> > > >     *      XXXX - reserved (0)
> > > > - *          XXXX - reserved (0)
> > > > + *          XXXX - Active Cores in Resource Group
> > > >     *              XXXX - Group Number
> > > >     *                  XXXX - Pool Number.
> > > >     *  R7 (IIJJKKLLMMNNOOPP).
> > > > - *      XX - reserved. (0)
> > > > + *      XX - Resource group Number
> > > >     *        XX - bit 0-6 reserved (0).   bit 7 is Capped indicator.
> > > >     *          XX - variable processor Capacity Weight
> > > >     *            XX - Unallocated Variable Processor Capacity Weight.
> > > > @@ -120,9 +122,11 @@ static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
> > > >    	ppp_data->entitlement = retbuf[0];
> > > >    	ppp_data->unallocated_entitlement = retbuf[1];
> > > > +	ppp_data->active_procs_in_resource_group = (retbuf[2] >> 4 * 8) & 0xffff;
> > > >    	ppp_data->group_num = (retbuf[2] >> 2 * 8) & 0xffff;
> > > >    	ppp_data->pool_num = retbuf[2] & 0xffff;
> > > > +	ppp_data->resource_group_index = (retbuf[3] >> 7 *  8) & 0xff;
> > > >    	ppp_data->capped = (retbuf[3] >> 6 * 8) & 0x01;
> > > >    	ppp_data->weight = (retbuf[3] >> 5 * 8) & 0xff;
> > > >    	ppp_data->unallocated_weight = (retbuf[3] >> 4 * 8) & 0xff;
> > > > @@ -236,6 +240,13 @@ static void parse_ppp_data(struct seq_file *m)
> > > >    	seq_printf(m, "unallocated_capacity=%lld\n",
> > > >    		   ppp_data.unallocated_entitlement);
> > > > +	if (ppp_data.active_procs_in_resource_group)  {
> > > 
> > > ppp_data.active_procs_in_resource_group can ever be zero?
> > > 
> > > If the entry is absent in lparcfg, then lparstat will print it as 0 (which happens to be
> > > default RG, while default RG may have processors)
> > 
> > If active_procs_in_resource_group is 0, then we are not printing the
> > resource group information. If active_procs_in_resource_group is non-zero
> > and resource_group_index is wrong, we need to report a bug to the firmware
> > to update it. Kernel is very transparent with respect to this information.
> > It can neither verify the information received nor should we even be doing
> > this.
> > 
> > > 
> The comment was more on the necessity of if statement there.
> 
> +	if (ppp_data.active_procs_in_resource_group)  {
> 
> If one runs lparstat in the LPAR, that means ppp_data.active_procs_in_resource_group is non zero. and when
> ppp_data.active_procs_in_resource_group is zero, i don't think one can run lparstat in any of such LPAR.
> 
> btw, ppp_data.active_procs_in_resource_group can be fraction between 0,1 or is it always an integer number?
> 

ppp_data.active_procs_in_resource_group being 0 is valid, it means its running
on an hypervisor, that doesn't support Resource group.

if ppp_data.active_procs_in_resource_group is non zero and
ppp_data.resource_group_index is not present, then its a bug.

ppp_data.active_procs_in_resource_group can only be integers.

-- 
Thanks and Regards
Srikar Dronamraju

