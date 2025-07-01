Return-Path: <linux-kernel+bounces-711103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD1AEF62E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 13:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD11C00118
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB02727F7;
	Tue,  1 Jul 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2x0jLM3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91A2727F5
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368257; cv=none; b=BHM+n+tiy7EaLy6oIMhsTI4In40Rdi8fwIHTs7tN3+uY/F9pcH4VYCI7aQzkE8otcnQai5AwgtdvkpsLrZF5ACYMN2D2SC240B/mgMbzgz0GsYrQBoFAKeEC/I0QOH85oPOyy03hl4LVpHuoxWyGmXsRWbcwPjqnuYnuNM6h5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368257; c=relaxed/simple;
	bh=ebaxhitP2XeVANtdKB9VsXlAR1GQ9/EdwbydMSQkTJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biIbtLRJJnjDMwrx07ogVysrarE8GJCrMkS2hCyXTC+p9foqSFA1MtX/ndMhcjQ1ZG06QM6sVlTsl0A8tPZsqlS6r0yPAdBlwOEHaxukQYQA8jrNUhD+IkXSq1CpfSzvhqszLHkNACX51Q3UfN/FI8oKP4koEolMiLFF0oySWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W2x0jLM3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561AAnCn024904
	for <linux-kernel@vger.kernel.org>; Tue, 1 Jul 2025 11:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7qvvoXd4DPAxwNrTX/Jr5xFg
	T9bOG00iDZW2UQY6+3Y=; b=W2x0jLM3DxykSK/5hjk4MhM3QPAper60yEKWJ1kM
	Ozxy2/iLUnwDtqIxErPu02urASGpkhYAC3cb3PzsMwrsYHiFZybeStqqp9OKr0py
	t0YkaKAvW4eWoCGLWnyHuROfZr9bzfXeLSW4DLoxr21hB56U5qlpS87+tDghy3Nv
	pEPmRsifO2JVmnHnLjuYvSVDVvp7CY86heradc6aU7bKQkr1c4H8CIvYp3jXsxgi
	FBg0zKQsD1B6JGZTVyUmDJ3DbA3iBtp4GKQ2PU2Fo57dzUYxFYAJxjJG4/t5svuu
	+/G3YRCFJaNsOS25FQfk9381/x/t2E9rHBpYA29cyrMPrg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8020h6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 11:10:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d44d773e23so855647085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 04:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751368253; x=1751973053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qvvoXd4DPAxwNrTX/Jr5xFgT9bOG00iDZW2UQY6+3Y=;
        b=cRdJYUeFDJuxw8JtFVU2hliG0JqB7vVOzBcSLBQtFGZdX+ywjSAhyCiqAtoYxBVe/d
         i0krmIPnuFg/d2JqWuHPtckLdTrKaVbIgMfEv3yiBC2ZVSCb7vUjV0IjzysWObZywQ69
         4e6tM906GbSnJFUHnSivQnurisnKqD1lT539dCqfKyV4fVqV8oI5w2TqPs3TPXyNBOsG
         dQSara7bN/bo9y5aHBqOiSqTy/4WFZgDuyELNU1Oq8fsXTcbUEckCsDXh8jqMNdOtaSe
         xt/0wXuiC3JSv89KT8z7O/1xpRrkPWKKEcZFysH+j/ABdhmm3y5gDctXjf96zeOqXBIE
         3YkA==
X-Forwarded-Encrypted: i=1; AJvYcCWITmiSF3G4aIyVvN164WDZ0EVKVRXzlnr04C/ch/fRHu+8ETe0QpKyTojC0D7khKLFz7vFwLPYwEBEVUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU0a8TBpUE6VtWc8glTEMN69S7sSxOrW5/C5iRrVXePl8eloDs
	I16e1jXj/+kVixvn2XlJirBDsYG+9nbsdJs9cFcU4bZaX0qKrgsQJPs+anWlT/cbLfZl2fq+AUb
	kX17ZfONkgDuR27oMjBWOzz1meV6oqGMfS0Bwgb965RmQCqtrAQDPPjv8yGVfRbEu7tU=
X-Gm-Gg: ASbGncvzYj73Z68pNpYbkI+/uiGKVlM82t0OrjYbekuNkqQHaGCd27h4v86uwnFtO5a
	2p6d++WDFnukryS6xeXqN76XIBsJu9G4cu2YpGPop1fMV6LIzkIT6YNd67II8cB5OXoQzMxuo6H
	C4OpLKxBGxPk4a7yyNSAiWqKJHCfNR62PgKIsQab6q6l9SSpatUAkHV1uRA7j1TfXYFV6/T0fW4
	q1g7KPfsP2RWPOev6Dp7hF/gTwBGJhlhTtaKBWIf16A2htOAwxQ6raPYsxZvZF8hxBSs3nEC+Bt
	SsqIKu85Bh/g7vMC6rutnBL0NL/E7QmxdsNyqdHysP4WAUYjpAJCYkHKIPmY9aR/0l4Z5IyPmIW
	HbBlfpnjPBmCkjaqNK3cVwbR2LGObh5kMBxU=
X-Received: by 2002:a05:620a:1987:b0:7d0:a243:d5c5 with SMTP id af79cd13be357-7d44390231dmr2382166885a.5.1751368253032;
        Tue, 01 Jul 2025 04:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnmqd3sa9HszIT11UEJ1cWsY3O4ly328cLugwQlVpIW+NiV7VChgwpnSLRwLj6H1ZXlNv/UQ==
X-Received: by 2002:a05:620a:1987:b0:7d0:a243:d5c5 with SMTP id af79cd13be357-7d44390231dmr2382162285a.5.1751368252459;
        Tue, 01 Jul 2025 04:10:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b255a51sm1800139e87.88.2025.07.01.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:10:51 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:10:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] firmware: qcom: scm: add modparam to control
 QSEECOM enablement
Message-ID: <af553qttxd6tqkypokqkgki3dceatsbqfw5botjrcesvg22nyr@zogoseo3j7hc>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
 <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
 <aF1EDMsw1KQTlteX@hovoldconsulting.com>
 <cjinqyqn7qgvdoltoywxa2lq6bjyfrotmon3iv24tqt3bpdlpe@3xb2k42ffegj>
 <aF6Srse7BhDJkQiH@hovoldconsulting.com>
 <7jjxjkk6qwym2mt6xp7t2t4wckyrvwaj2ydubkimnx2oybitab@u4nhj5mib64l>
 <aGKGHvDzlKrBDrjN@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGKGHvDzlKrBDrjN@hovoldconsulting.com>
X-Proofpoint-GUID: xJSSaCnLw-sZyg6xGhO2H1YURhIR8i1l
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=6863c23e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=JjxlrjXdNPBxzYv9-tkA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: xJSSaCnLw-sZyg6xGhO2H1YURhIR8i1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2OCBTYWx0ZWRfXypReXuB7qTY/
 8tRvGu0tYkGtKotjoW0PYCiNSt+W9k2zP9d0frc6EujRtBEIKoQsogm/ZuIXGjX5X63Cb/j7W9o
 4SpOrxUx8403NdsrlKD30b7luurP4nPRXP1h+1LCYE59tST+iarlYAodolWTqnPUT2yV+QNWPXI
 VALfGfk6SglBtqJ6qmTDlqR70gFfqSG3UeIvPdWUhAHn/0KSLxIAnbeP2l19YX+nNJaLLQNHGjP
 +YjNxWvIs8tAPtCqI2pTP7epcc2W4/3tw5iyNlnNNVCU3e7XukCFb9A0o2g398p1mraLpyuDxLG
 l3IBRq2gRHuyltQqUCuCvIM6k8EG+DhWOjplrH35Xn0jZ2Lffaq84YmXCZrl0NUDQxpYLkLejvb
 SP2WwYOYhWqk4csvNXRBevorTwDJqk8KeQ0eiW+NbTvj9k911EjS0vSCpfaj8tGbELogB8/0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010068

On Mon, Jun 30, 2025 at 02:42:06PM +0200, Johan Hovold wrote:
> On Sat, Jun 28, 2025 at 06:03:40PM +0300, Dmitry Baryshkov wrote:
> > On Fri, Jun 27, 2025 at 02:46:38PM +0200, Johan Hovold wrote:
> > > On Fri, Jun 27, 2025 at 02:33:27AM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Jun 26, 2025 at 02:58:52PM +0200, Johan Hovold wrote:
> > > > > On Thu, Jun 26, 2025 at 02:08:23PM +0300, Dmitry Baryshkov wrote:
> > > > > > On Thu, Jun 26, 2025 at 12:11:20PM +0200, Johan Hovold wrote:
> 
> > > > > You basically know by now which machines supports qseecom and which do
> > > > > not, right (e.g. UFS storage means non-persistent EFI vars)?
> > > 
> > > Do you have a theory about why on some platforms, like the one you're
> > > currently adding support for, writing UEFI variables does not work?
> > > 
> > > Can you please include that information in the series so we can consider
> > > alternate routes for replacing the current whitelist with this black and
> > > white thing you're going for.
> > > 
> > > Is it related to UFS at all, for example?
> > 
> > Strictly speaking I have no confirmation (yet), but there are two
> > theories:
> > 
> > - UFS vs SPI-NOR
> 
> Someone with time and the sc8280xp and x1e CRDs should be able to set
> them up for booting from either UFS or SPI-NOR and see if that makes a
> difference to confirm this.
> 
> So far my sc8280xp CRD with UFS fails, while Konrad's work with SPI-NOR
> (NVMe).
> 
> My x1e CRD works but also boots from SPI-NOR (NVMe).
> 
> The Yoga C630 booting from UFS is also known to fail.
> 
> > - a edk2 PCD which controls whether SetVariable commits immediately or
> >   whether it just buffers data until EBS (or other call).
> > 
> > > 
> > > > > And it's a pretty bad user experience to have people trying to write
> > > > > efivariables when setting up a machine and then spend hours trying to
> > > > > debug why they don't persist after a reboot.
> > > > > 
> > > > > I don't think that's fair to users.
> > > > 
> > > > So, is it a user or a developer, trying to port Linux to a new hardware?
> > > > Also, R/O implementation makes it obvious, that the variables do not
> > > > persist.
> > > 
> > > A developer enabling support for a new platform can patch the driver and
> > > does not need a command line option.
> > 
> > Yes. But it's easier to debug things this way. Consider all ACPI-related
> > or UEFI-related kernel options that we have.
> 
> That's because there is a common kernel implementation used across a
> host of fw implementations.
> 
> Here it's just Qualcomm doing something funny that affects their own
> platforms. We should be able to figure this out without forcing users or
> distros to pass command line parameters.

This is not intended for the normal working course, but for the initial
bringup / nailing out issues after the bringup (e.g. after firmware
upgrade).

> 
> > > If you enable it by default, suddenly a bunch of end-users are going to
> > > have to debug why storing efi variables silently fails. That would not
> > > be fair to them.
> > 
> > I'm enabling this only for platforms where all existing devices are
> > listed in the current whitelist.
> 
> Do we know if there are any sc8280xp or x1e machines that boot off UFS?
> 
> If not (even with the exception of the CRDs) then it should be fine to
> just whitelist the SoCs without any command line parameters.

I'm not aware of such platforms.

> 
> > > > > Let whoever brings up a new machine figure this out. It's just one
> > > > > entry, no scaling issues, and we get accurate information (unless
> > > > > Qualcomm, who sits on the documentation, is willing to provide it
> > > > > upfront).
> > > > 
> > > > And that's not really scallable. All other parts of a particular device
> > > > are described by the DT only (that's especially true on the PMIC GLINK
> > > > machines). If we are to support new laptop in e.g. distro kernel, we
> > > > need to provide a DT... and a patch for qcom-scm driver. I'd very much
> > > > prefer to do it other way around: provide a DT and patch qcom-scm if the
> > > > laptop is any way different from other laptops. E.g. we know that all
> > > > X1Elite laptops support R/W EFI variables.
> > > 
> > > But this is just kicking the can and putting the burden on someone else.
> > > Now a user or distro would need to pass command line parameters after
> > > spending time debugging why efi variable updates do not persist after a
> > > reboot.
> > 
> > The original developer for new DTS will have to do that anyway, if
> > something fails. And once it is done, we can add a quirk for that pure
> > platform. However the majority of the case can go without extra quirks.
> 
> Adding to a blacklist is bound to be overlooked, while adding to a
> whitelist is not.

You can't overlook it since it is required as a part of almost any
distro setup - point UEFI boot sequence to your new bootloader entry.

> 
> > As you can see, all X-Elite / X-Plus and majority of SC8280XP platforms
> > already are in the whitelist. Once we sort out SC8280XP-CRD issue, all
> > SC8280XP platforms supported upstream will have an entry in the
> > allowlist, which means we can convert them to the wildcard + quirks.
> 
> I'd rather see you get to the bottom of the UFS boot issue and whether
> there is some way to determine this programmatically.

I don't see a good way to do that - UFS might be probed very late, it
might be unused for the boot at all, etc.

> 
> > > If we know with reasonable certainty that all, say X1E, devices works,
> > > then that that's one thing.
> > 
> > Yes, we do. You can hand-compare the lists too (I did).
> 
> If everything that's currently upstream boots from NVMe that may not
> necessarily mean it works for devices using UFS.

And? I don't care that much about theoretical devices here.

> 
> > > But if this series now enables broken EFI variable support on every
> > > other device then I don't think that's ok (even if you provide a command
> > > line parameter that each user now have to pass).
> > > 
> > > Then I'd rather see a proposal for how to determine which machines
> > > support this or not, information which was not available when this
> > > interface was reverse engineered and where a conservative whitelist
> > > approach made perfect sense.
> > 
> > WIP
> 
> Good. We can manage with adding new entries for a while still while you
> guys at Qualcomm work this out.

You (we) guys at Linaro could have figured that out too ;-)

-- 
With best wishes
Dmitry

