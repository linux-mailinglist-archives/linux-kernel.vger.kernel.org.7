Return-Path: <linux-kernel+bounces-818601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB14B593C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A58316DD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA030507B;
	Tue, 16 Sep 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fB8G4bd9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBCD2F83D8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018659; cv=none; b=EhiZB7X9a8FKTEgD7PYk2caKpGRJwzC2zdbz5G7bzahgnJRyC7+vomAGsNt98b9KB5LsmqTP51U4P62urozgUDWtbGSJzR75ZtoTYsE2Uf524Api/tlk11MLp4CcgP9WU+9nIzKM4egxFt3yD1e8V4Z6EQOHvTnhIZiFbG9YVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018659; c=relaxed/simple;
	bh=d+jlDndG8PP0VyxXRuLeSowh6XAYCHEbZtNNt9LInjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awX6yRbxuZ0GCi9GrJd39818RVvN+yYGPcurpex2D2Un7pwOZtwh0cns8A50ndZVZJxWqFwUhVnkFG5P7480RrZ2/+4f/pvWW0qpFkjmpAJ/unnsjlK8oxJUjDswYkMXeakG9OvaQeLpo6sh8C10N4xWj4RS+HZXf0Mwnafp3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fB8G4bd9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA3GBL010797
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hFFUoRiJ78Rh8btpYL7GdR2P
	u0JpEw7JoBrZPpXAZnY=; b=fB8G4bd9aD9w406wGvEWnNt8+rBWANai4uGMUWz/
	VGNjGRH7UH9QXP7vsQbavyKLtcZdCTtw2gn26NQfFAXyqNa5lfHKAU2vZZOBX3XO
	hF4iJ5/zs4INnBZzovffbtR7fHlm0QiFqIKlVPu7GkYuw9n1lpJjUXxL9qniNEtr
	ckFyO84Q1uEmQDb3ppTcN79DEbg46eHMVcgiNeB49g8XH3RL1D4PQvBZszgoevPj
	CneMBF4bLp8FDf4Tb0f7EqnmZ1H+bn5zANLrIXbd155gF2jvqYAF4QfjxB57jNys
	r3dWZ20NqTNepZLAF/mPFmDtT/kaKex07AyIEyBoLJviEg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snrat3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:30:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b60d5eca3aso127498041cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018655; x=1758623455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFFUoRiJ78Rh8btpYL7GdR2Pu0JpEw7JoBrZPpXAZnY=;
        b=hiruqvmMcduvYzdIlom1HqtvVudvbd5PQj7/AXfWthD9Etdo5vBsET9Qh9WuOFmoFP
         vlUVPdDq8OCBEeSDgU1kcynFh9+vTN58jus71aYePI/js9XGllouHGdF133kJXml0rzb
         nGBq/FuxMinu5gO61XcnxDldIQMABwwcS1DoQmGbRxdjJrRoNs+bIHDzfqXIh9KRe7Bw
         CeRbqEQkqkWIfFiEQh6p/n3WOSt0/G/Dq+eSOG1KoXVQtpMhVK6E8Ew3oIbvhoiMUhkt
         Qj8hHjaIMymOir2OPDtydCXL8Od26l49bNq5pLE+cxEhUIP9MmuzaQv10+GH/Q3LcugA
         1w0g==
X-Forwarded-Encrypted: i=1; AJvYcCUasuc8MQJ64KviJdZZfcww11i3yly1SVsYMbTrEEC/rRAe1uaCm/bCC9bhUQI6kOzTKvb/OU8yoRFd8lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEW1IPcT6gj37h37hu7SbILP9+OrIzbyFq8k2IxS1vXHlb4GU
	p2yZebMIr7E5OkB9I4IVTJAqulXkCqp46Q7OIYFuntlEDqe9EwqL1+KyPP4EC0xqaI13mUIK67X
	jROQ5KFMrNarrpuvb7tpg+WtT1uz5UNLjRmKj6XaxU0Xrof9DOcHRUjk841i5VmLoDPo=
X-Gm-Gg: ASbGnct8siB9kxh0G6vfRisRRUcJhzXlcRlkC+fPC8l6k4MLp6efZrmCsNVWaiKytVb
	6xQU0r/0wA5SRQJYgc+ZY1hto9Ar3vsIPF1dCksJTZPkl7VK3AfUr4dAXw9bH45Fg60Jy5AARkJ
	om1FJMfgjtUam2aFYRQVw4j8m3x5jzq6+5Jx+32w/3bQUcUgi8zwPOkJGQEELCBuhabfyoR0nHL
	1C5cfR2Y53uI9SQzuN84DSIb4SPechW0SFwT4gbHWdgtJJBJLln+aXNA23xMlY/r+dCLqXwEEqp
	W2IIi2hSATAaD+64mzgT9ID0ftP5bBd8wLna70h0Xu8Ecuo26j6ppUl22/kNI/dClNAiOrwR3w2
	KX4vfpTHNoPBKI2DTUxnm4vgXbRVTBFswRReKCQIzyV9SDVcdUe5Q
X-Received: by 2002:a05:622a:4a88:b0:4b5:f1e0:2a6 with SMTP id d75a77b69052e-4b77d149fe8mr238375581cf.58.1758018654830;
        Tue, 16 Sep 2025 03:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdY1Dpsn8FimyyZ6UijUGgh2Ys02k7KvtgljBEo3Py8dqNj3GXgL5jFMIYMFu4+u73BXFHUA==
X-Received: by 2002:a05:622a:4a88:b0:4b5:f1e0:2a6 with SMTP id d75a77b69052e-4b77d149fe8mr238375171cf.58.1758018654360;
        Tue, 16 Sep 2025 03:30:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-572a5cde069sm2566664e87.13.2025.09.16.03.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:30:53 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:30:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: qcom: qcm6490: Introduce Particle Tachyon
Message-ID: <22qi2loql3zbxrpxlu6hfxxeesxloxxmt7ohit5qtp6awpnzky@tplw7mirrk3r>
References: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
 <2tnzsjw3xy5jct4bcmahcwhjbzlmyxgcx6fzlz5qrzxume2uoy@phpcz6mnydlt>
 <nweaxuma3dkhzcc46ztfhmxxrchgidxjprc2tz5eahle6sxsuy@qvczmexs4qnn>
 <2bc767td7gw4bxts4k4xwhdiv5tgxmpyjwwv6nqeatvncdov6c@u7gfilzxgomp>
 <4gx66y2oncjppqjhap5q2fmwlgkhv74rupeo4iwbyqw6ipoddn@fpp56byglnwe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4gx66y2oncjppqjhap5q2fmwlgkhv74rupeo4iwbyqw6ipoddn@fpp56byglnwe>
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c93c60 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=7AODkVuKAAAA:8 a=Dt7FPFtFWm7D6XesEFMA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=sRHRY8H3vKB1GfNvUtpx:22
X-Proofpoint-ORIG-GUID: T1nnRBirrznq7Tslnft919jVYWOoyeQZ
X-Proofpoint-GUID: T1nnRBirrznq7Tslnft919jVYWOoyeQZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfXzqwh18KLVkdt
 vMZ5LvnDykYNnb2DXXTg6EPztoPtv9Ju2TqTlMpzdYhWKCJyaphTWRCzk9GtQI2xJO8lo/e3it9
 hlqD1nQkXqdR51IFd9TGe9Tf9vLfnaKhicDwF3PSb9tGeaqa31bAagTUYcHiswGUDbBZIo9E3be
 tDAr4kaQPDiO5vqtr2qDnEqf50gMJYlXpC93S3J9S/mQBB21txouLKBLvJ2rFvwIn8NhZAucfj9
 19na7o4GHE/LS29w9wwGMqVyppP6Bsl6qS5cFjlm1X2NedpMG0LDuHut4hzHlTVQGaFsqDNM8xL
 HT1KazQ0P35tdy2qiNm31o/fer7KZfmMou5G7Po0AUaGbjiE+CsGMGLkXILjqUeredZCK9U2d1y
 mTQrLkwK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On Mon, Sep 15, 2025 at 10:26:30PM -0500, Bjorn Andersson wrote:
> On Fri, Sep 12, 2025 at 04:22:18AM +0300, Dmitry Baryshkov wrote:
> > On Thu, Sep 11, 2025 at 02:19:39PM -0500, Bjorn Andersson wrote:
> > > On Thu, Sep 11, 2025 at 03:01:35AM +0300, Dmitry Baryshkov wrote:
> > > > On Wed, Sep 10, 2025 at 06:05:36PM -0500, Bjorn Andersson wrote:
> > > > > Introduce the Particle Tachyon board (https://www.particle.io/tachyon/),
> > > > > a single board compute with 5G connectivity and AI accelerator.
> > > > > 
> > > > > The boards currently ships with the Android Boot Loader, but replacing
> > > > > this with abl2esp allows writing a EFI System Parition and OS partitions
> > > > > to all of LUN0, and a more UEFI boot experience. A prebuilt version of
> > > > > abl2esp is provided at [1], as abl2esp-v6.elf.
> > > > > 
> > > > > With a (very) recent version of QDL, a flash programmer from a Tachyon
> > > > > software release, and a full distro image, this can be achieved with:
> > > > > 
> > > > >   qdl prog_firehose_ddr.elf write abl_a abl2esp-v6.elf write abl_b abl2esp-v6.elf write 0 image.raw
> > > > > 
> > > > > The following firmware files are currently used, on top of what's in
> > > > > linux-firmware already:
> > > > >   qcom/qcm6490/particle/tachyon/a660_zap.mbn
> > > > >   qcom/qcm6490/particle/tachyon/adsp.mbn
> > > > >   qcom/qcm6490/particle/tachyon/cdsp.mbn
> > > > >   qcom/qcm6490/particle/tachyon/ipa_fws.mbn
> > > > >   qcom/qcm6490/particle/tachyon/modem.mbn
> > > > 
> > > > Is it locked?
> > > 
> > > It doesn't look that way.
> > 
> > Then anything preventing us from using the default, non-signed FW?
> > 
> 
> Looking at the version, they are not from the same branch or year.
> 
> I suggest that we stick with the firmware that the vendor has validated
> on their piece of hardware together with the other pieces of firmware,
> at least for now.
> 
> Once/if we built confidence in the QLI firmware, we can replace these
> paths.


Ack.


-- 
With best wishes
Dmitry

