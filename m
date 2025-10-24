Return-Path: <linux-kernel+bounces-868334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9066C04ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ABC24E5C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF42FDC41;
	Fri, 24 Oct 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A8RmEPm8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387D2FD7CE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293048; cv=none; b=SF3nldkMKxdpLf5U3Ux13BsaaOHJ6fsz4Ac6rAnjaiSUxJk1SYI0B4pyyptL2zOnqiqR86GEWM0Lq2qTfcZa4QUi+e9l259qGDpLhMoJgM5uBzHIHZ5M4+UNKGZDXpBJYYCnXo10yQgIyCs0SA980MZyZSvsYy5ljlVXu9vtW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293048; c=relaxed/simple;
	bh=5fNfGvab4opT7+M9+4gTh1brPpV0LMwCMnrjicPNLWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTsRNUxI4vKReuNkFX0a5+eofj/O2QxzRbBMGFiIYZA3Dbrdz0jvzZSDtfoFce3xXh+ifpKvFTI7fqe1sD6nXgEQXSWbVAIQM7tSyB4wNk3yKsC9t0aNi58Pki6z2dWmIBMYUQiY2xqj/gxAEdawVKIGvMOoqztdmyePN2Vtb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A8RmEPm8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FPQM003421
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/lRHixY5Nngi9VzXe+Ef0jXWxyKWxyYxZXM3NEjhCo=; b=A8RmEPm8bk9C9LFW
	e4krfDrB6inqBXLBKIZF+ahX9KY0JvPvTLAgVvIWlk4lsCOEYBbewcFTJY7u95ZF
	aATguBvwhaTsk3wzO4bSL2q9/xPB+hAH/IxqBnfDiJeUTlDpSw0PLC59r51cV6D5
	eYXq0SPHDCgtTgaGbOYLop5uBhmrfDryABVPHmTF0+JLL0YHVUcd3eL7z/D67IH2
	Z/hSFj0A/dA7hBRrSrHo919zU8+/Bnuts8S7bDtkkbAlkucPRvRZ75b0HfvtzGjt
	zRPcpFKytm+/QuvniXozFXqTP5JLdhX1CDBm21uRBFRSUPeN78lTLOBfQwRhSgA2
	PNA4qQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jb6gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:04:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ceba8968dso1294537a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293045; x=1761897845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/lRHixY5Nngi9VzXe+Ef0jXWxyKWxyYxZXM3NEjhCo=;
        b=C5Jydq3P2GcQEgyeECqaddqcp+K7GaY78gU08t7cChcQNWwHc8a7wzOLSZ12DmuuNY
         8sQv/egkNghssySTmzfaYn27jxV51leSyCBeLPG3GOg7YNzp9xXcfoqJ8L/wyVm0hLvQ
         8u9zMGrjEbjB/UYsx5WWHAKiP+VDsHy/vD3ab2nCwbh3ed+TTdJA4CSAQKJRYBQ5+cwX
         SpfntHiGiKUMGjGxyZ1RJMO4WQuuMBwNrHu6qnGzMPKVY/h2yxfptngwtW1ZF8MpTsxj
         6gJ8AcHNtSN3XAHeSU66sT3JUvZSfXg4ErlCCcxMoOyIFNqHcU2isL9zi+jybO++DBIu
         VErg==
X-Forwarded-Encrypted: i=1; AJvYcCUS5PL3fdKJr7i18OraizpOJ06AK/m5udghROkpdvR/F3Cka5c/34eH2MoOTny6VYqMXVIQoW4RWGlD+48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBacEYJYx4k7MpK0LtQNGywiwZsdr7O3eiIjpePQUGcW+q6OHA
	pgCwlrFSzcfIXOxccSJ4SheKcZKMk3SdnWXVfCgC9b32SLxiS+co65UuHzVWv9oubJTonsnVS7E
	akuzajzEOsHqCEUAIe7rUuMKiPgAZlp15DS1usjfULAe/O0kgEX65/yUJUkdVmvNj7rZPfy1ukf
	Y=
X-Gm-Gg: ASbGncvcjcHLkp1wXveYBdVmr3OnJoivdSYE77cWCvA1Y187Zt6+m2Q50CFgitIjZRi
	MS3uGkG7HZOQpPv534d5kPFaukAopLCH7W9ShE33PLq3sGgTi9Fmbavm6M9635iewvozVb0WlvU
	/syfd7rQZhLkvI8dwcUbfwVsvkzrvea8VBubLnMimLIQCg2LZV9dxpZRG2h6w4tIXuDk5KFqqS0
	TfweMZCHUtcd+24f2+sCwzYmgM8gjPuHOYj+M4eMadyw5qSG2G12/FDySNj8DNRjxVEeWltVjCm
	j9kEx3wh+i/Zgd1e2XI9YZe6BZ+kZ6lJ+OPT8GAsfTYRLZiPSOMuT1xSfAhiXmt2Lrr4ZALXZbo
	Bp7XGzWg7VTx2QHpBtbOGvWtU6IRzEVUDgy8ziQMdlJQ1C2i/VptmSEaX8NjY
X-Received: by 2002:a05:6a20:3d8a:b0:2e2:3e68:6e36 with SMTP id adf61e73a8af0-334a8629dddmr34343904637.49.1761293044604;
        Fri, 24 Oct 2025 01:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF35NHW6xu5CI8mSOAYj2Vl5REzTdO/6tS4YtA3X5EIGWASTK4r2zlUt6ksnxa+VRSwtBWf1w==
X-Received: by 2002:a05:6a20:3d8a:b0:2e2:3e68:6e36 with SMTP id adf61e73a8af0-334a8629dddmr34343860637.49.1761293044088;
        Fri, 24 Oct 2025 01:04:04 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2640sm8198763a91.16.2025.10.24.01.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:04:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:33:58 +0530
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] regulator: rpmh-regulator: Fix PMIC5 BOB bypass
 mode handling
Message-ID: <20251024080358.rkebbvg7louwbo6k@hu-kamalw-hyd.qualcomm.com>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
 <on4zcfs5qdaekc7teo2iq6vpw7o2mp6yiqjkbznxo7wcxgutj3@nb35f55fkugv>
 <61c299af-c4f8-47a0-8803-306c08792b17@oss.qualcomm.com>
 <xlki5jwurnixdxaph5mtxg7sfks2cww3xbswgtf6dbn2z72o2r@smx5hxo6obxj>
 <c3fac2a3-dc89-440a-9958-f2e904c42f5a@sirena.org.uk>
 <7wiionjbjot5psapobmwcflecyu7pz3pzc44c3horsvjfj6yfp@f2iig6hyb5a6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7wiionjbjot5psapobmwcflecyu7pz3pzc44c3horsvjfj6yfp@f2iig6hyb5a6>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXwNR4M+UJMEFg
 5NE2xw4HwBh3skJ/610gJM8JtMtfban+Nmcmaj86VM1uwbrOWf01IsORPJ5NxFw4R19c8xKI1oM
 wTb/WxX0GNO28pCFz1SvNkoNCHffKagw66xbPTfJPEjwra9qxGsATqPnoyxPGicKqssPITUg82f
 xNH2gGYQ7vN1sP5E3G6QvjBJpt2n0mhZxeXC65UWjIncWb4wLE/x7qX93BYufpP1O+RDHmLw7Cj
 r9ApvSVweb/uxLvrrA6NuKwL3Cnt/Ax59iwbCtcDXdXSgDt6F0TWQSBpyfVObXs+y5DaoONbCdn
 sTRsmB6Dd09ngzDpVtOcUThWcio4gFpuZFsDm2C+RC/z/A8CTYoLjDJmm/p85AT7pDG9M7nuA9t
 5uFDFCYoWNkD7GYB2wG/Id+Hnfn3rw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fb32f6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4voTl2E216AQtERj9a0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 2HtJrJ-rT7l-20_IfwEKnGNJZraUZM_t
X-Proofpoint-ORIG-GUID: 2HtJrJ-rT7l-20_IfwEKnGNJZraUZM_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Thu, Oct 23, 2025 at 02:37:07PM +0300, Dmitry Baryshkov wrote:
> On Wed, Oct 22, 2025 at 04:15:51PM +0100, Mark Brown wrote:
> > On Wed, Oct 22, 2025 at 06:11:46PM +0300, Dmitry Baryshkov wrote:
> > > On Wed, Oct 22, 2025 at 04:58:15PM +0200, Konrad Dybcio wrote:
> > > > On 10/22/25 12:23 AM, Dmitry Baryshkov wrote:
> > > > > On Wed, Oct 22, 2025 at 02:38:53AM +0530, Kamal Wadhwa wrote:
> > 
> > > > >> Currently, when `rpmh_regulator_set_mode_bypass()` helper function
> > > > >> is called to set bypass mode, it sends PMIC4's BOB bypass mode
> > > > >> value for even if its a PMIC5 BOB.
> > 
> > > > > The universe will end, the Sun will explode and Ragnarök will be upon
> > > > > us. Please describe the issue, why sending bypass value is bad.
> > 
> > > > I think you misread, it sends the magic value which corresponds
> > > > to BYPASS, but one that worked for the previous generation
> > 
> > > I just wanted to point out that the commit message makes a statement
> > > that it sends some value. It should document, why the sent value is bad.
> > 
> > It seems fairly clear to me from the above that the driver is sending
> > the value for the wrong device type which is something so obviously
> > wrong I'm not sure it requires further explanation.
> 
> Okay. I'm sorry if I'm overreacting.
> 
> The bypass_supported field still needs to go away in my opinion.

@Dmitry - one way to avoid it is if i re-use `.pmic_bypass_mode` and
keep it  `= -EINVAL` for the checking if the bypass mode is not
supported? and drop the `.bypass_supported`.

But do note that currently only BOB type regulator supports bypass
mode, and this above change will also require modifying all of the
existing (and future) configs for regulator types that do not support
bypass control.

In all below 28 structures we will have to define
`.pmic_bypass_mode = -EINVAL` 

static const struct rpmh_vreg_hw_data pmic4_pldo = {
static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
static const struct rpmh_vreg_hw_data pmic4_nldo = {
static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
static const struct rpmh_vreg_hw_data pmic4_lvs = {
static const struct rpmh_vreg_hw_data pmic5_pldo = {
static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
static const struct rpmh_vreg_hw_data pmic5_pldo502 = {
static const struct rpmh_vreg_hw_data pmic5_pldo502ln = {
static const struct rpmh_vreg_hw_data pmic5_nldo = {
static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
static const struct rpmh_vreg_hw_data pmic5_nldo502 = {
static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
static const struct rpmh_vreg_hw_data pmic5_ftsmps510 = {
static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
static const struct rpmh_vreg_hw_data pmic5_ftsmps525 = {
static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
static const struct rpmh_vreg_hw_data pmic5_hfsmps515_1 = {
static const struct rpmh_vreg_hw_data pmic5_nldo530 = {
static const struct rpmh_vreg_hw_data pmic5_pldo530_mvp150 = {
static const struct rpmh_vreg_hw_data pmic5_pldo530_mvp300 = {
static const struct rpmh_vreg_hw_data pmic5_pldo530_mvp600 = {
static const struct rpmh_vreg_hw_data pmic5_ftsmps530 = {

while in the current patch i dont need to touch any of these above
structures and just add new property and define it whereever
`bypass_supported` is set to true.

i.e just change these 2 bob nodes only.

static const struct rpmh_vreg_hw_data pmic5_bob = {
static const struct rpmh_vreg_hw_data pmic4_bob = {

Please suggest, if we can do this in a better way.

Regards,
Kamal

