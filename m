Return-Path: <linux-kernel+bounces-819045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4520B59AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B59A4A024B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7B3375C0;
	Tue, 16 Sep 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WP3p4bLA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1632ED36
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033548; cv=none; b=DnVx/Vs93Qr3oIBt0MPOyWvzz8YTmwA8HvZHcX9ZL9QuRk1xjj6vzY9BGJaX72risQzBlYdc5oi5WLeTEEGadtzYLzNWRhUXzc6ucAo+3qqL+BEdANT0Idt5ck3xZn9v4vhWqYN2VUSqKvb6tuPfpO6K0tO9Q9GMs3N259MtUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033548; c=relaxed/simple;
	bh=+ocfhQT7NwXOERXMtXoTCXssu/d1SUJ7XVECJSwDnRk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL9PNjtVdq3WP8fmx7uN66qn3DvvzpTmfi/wPti10ykkcvz3c03K4n026PYC1SPeYyX5Mfdo1o4YmaqbDWaMuuGrSbvZfE8GmMgrYFpL7pSDshNxg92S6pf6TMNyaxEmcNSsjC0dGBUjtaam2iRZCtB72yNDPFQdslrKEuHTlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WP3p4bLA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GABug0020444
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sXabbvrXkC6uXK9ljnuVN/q5OKELSKDgTRe/jo4HYXI=; b=WP3p4bLAI0pXBOYs
	2Th64g9uAS9LXMcPxKLwIcgqOC2YtfWQUg19qOH/bi+KYya3pzXqByXudlHSky+v
	CfjXP3sJFqfWluRA8O0sJjyRx3d1aWcVWT7ceEwUGEhKX6Od58Ats3gwsPdo2Xmr
	1sW9qTlFHzeoewyay9iJ1bLWL8Hi83hM3BR50dG2d/pktwNqtoSF47/5/phdFYhT
	YkUIU/x9Yx8rgg3bPiiFC0NwEUS+T2ZmLVgydmWymnNUzleZ0+ZNJDNI5cWp5zEq
	WHjI0E7ovLn5qe4uw+8cToNNyuBvTqzj8u9KmfdtIuPuFtEdsUZxHJsaToYr7Lcm
	NAwzUg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1smqje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:39:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b548745115so136360891cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033544; x=1758638344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXabbvrXkC6uXK9ljnuVN/q5OKELSKDgTRe/jo4HYXI=;
        b=bPJrmdZA9OczpY/O9Ptds+fUw5mSDsqce6nWizLBphHw7Y7Gg3PtRy0fChN6plmUnf
         doVmgyncg/TOGamdFGE5a1tz37sfhBeVMRUFwpDnIBk97x29UruhM8CHfE3dQvnau1VJ
         BQ8EEWkxkjQaM8f3zr04IwMZ3Teo4soZ2U9opSp3GKqcxN/13KgwivUhrf4kVvdxtFFm
         UhF8RHDFcnMKweVydpMF02fEbkLEy8xNyVKAyUMwQlEG0iN8E7KUwLo6yYdapM7PeNNM
         mg+D9oxkyHcUpNW/6HPwfT0RCTKhSTlOqWRODrmlVSxI0gfAXx1J2M2u++obkwA5hmh2
         Su0g==
X-Forwarded-Encrypted: i=1; AJvYcCVFWjWmnkFfx1c7drkeTwi0+Hu5HN0NzuLw1zs4+Yf9RUw9lB8l8BIIBcwru1Y+Gsj24ukYTB8PzWs6oQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdYvdYJRIwnhUvvAtUGbQaHRrSYdfKVyOdZ9FTJ0YeS7b6bHW
	ReOXSY2RN0heVaYFQuLN9ZzhTYP8BQJrjAISVZSJjHaZvcmaIhwMhanYhhr+k/ZCbcvbVQimSak
	zPioA7llnfB6K0cW/m78fpDKRpC6o7Rp67XvFGndpkWqMkm+TbU+FzEnMvjKlMSLfFP4=
X-Gm-Gg: ASbGncuriw6j/Utu3O7oqrfMIKhxJ6s+pYaoP9CA0QbpMJM+j64lZicPq0xMh0a2ajc
	Vh2vg9lKFyiK9wLYRAM66G22fhNcP7SZhVrbIII1aD+BFzG8LU29ucaQuxOHh/C2sTVo1ZP2eDk
	IVJXDbxYCArI/kCNkv7KbfgaJMkYLhBpC/DWIC6jk72S288xZKDyQihmpLHUtL/9Sskw7HIGm80
	RDDnOG2EtwQdfedX2Bd/NndxSb15MbATtKJM8xVoWO4faiMa+kRugi8/BYUGcFpxtqeqEAQH/ui
	V4xmNyygthLYNYGYbmDhrxLUfc4u+bLuxlzkdRwWG4kHFq0tUnzag97l3fBpcl1d/AeZCVhFx+w
	=
X-Received: by 2002:ac8:5755:0:b0:4b3:e964:7872 with SMTP id d75a77b69052e-4b7b444cf2amr29652461cf.16.1758033544083;
        Tue, 16 Sep 2025 07:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKcuFPHKTNjQLrBsUIKz1/F6zLgBUetzb5xsrN82HAzqysn96R5zIZRG3xbS5wX4Wc3gorig==
X-Received: by 2002:ac8:5755:0:b0:4b3:e964:7872 with SMTP id d75a77b69052e-4b7b444cf2amr29651721cf.16.1758033543222;
        Tue, 16 Sep 2025 07:39:03 -0700 (PDT)
Received: from trex (152.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32085823sm20752265e9.0.2025.09.16.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:39:02 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 16 Sep 2025 16:39:00 +0200
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_shazhuss@quicinc.com, krzk@kernel.org
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
Message-ID: <aMl2hOYTjBuCo4AM@trex>
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
 <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
 <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>
 <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
 <2c5fd01a-543b-4108-ac54-80d1d87b65a3@oss.qualcomm.com>
 <DCT9VWQYD4VM.1NV5FJJCJG4PI@linaro.org>
 <cb96f3cd-7427-4644-b7ca-26b763867db4@oss.qualcomm.com>
 <df05da7e-fd9d-48a6-bffc-e84749cd8e96@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df05da7e-fd9d-48a6-bffc-e84749cd8e96@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: yqE43dZEXuzLKF3XXDXdRkddfu3z9WP8
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c97689 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=UlsMzGb/nx+Jy78HFkoo8g==:17
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=hCPX3FfTKdnzJZTWp4kA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yqE43dZEXuzLKF3XXDXdRkddfu3z9WP8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfXz2g3ftM9JN4+
 T6Cwjp7UJWeeOUuJs3IabNkOOh5pG+oZACiZNXHNu/IWdzGp9nkO/9Ewus5qN7Vrexx0IWODG92
 OYe+BTVANOb1aUG+VkL34qh7yZjVhhaI8i3Se0oSDoSy/IWXv23NMlROFu9WGlGGZ8DOPd3Enha
 pqHcn3JTT0UcBIYJLomQ5g13zHVz4Ey9KpbMXh6yr19rV9hz6Zx3jAK0lUMd5cyNyOF+iuCPiKc
 KTf7SjPQIZRk1EEnZ6hq6mQuLKVblXrw2OWgmFlxQ/1Xs2192SwxZpevxJAkMYXyLiVtmM7HnAy
 juLPqoqpEBDvvHYO4luldtOw1cO0ujdYlXBTPVktK3mL81Z6CNLDyAmsinSyNosbv1ZM9XrIwfj
 7yiibyzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

On 16/09/25 12:20:25, Praveen Talari wrote:
> Hi Alexey
> 
> Thank you for your support.
> 
> On 9/15/2025 7:55 PM, Praveen Talari wrote:
> > Hi Alexey,
> > 
> > On 9/15/2025 3:09 PM, Alexey Klimov wrote:
> > > (removing <quic_mnaresh@quicinc.com> from c/c -- too many mail not
> > > delivered)
> > > 
> > > Hi Praveen,
> > > 
> > > On Mon Sep 15, 2025 at 7:58 AM BST, Praveen Talari wrote:
> > > > Hi Alexey,
> > > > 
> > > > Really appreciate you waiting!
> > > > 
> > > > On 9/11/2025 2:30 PM, Alexey Klimov wrote:
> > > > > Hi Praveen,
> > > > > 
> > > > > On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
> > > > > > Hi Alexy,
> > > > > > 
> > > > > > Thank you for update.
> > > > > > 
> > > > > > On 9/10/2025 1:35 AM, Alexey Klimov wrote:
> > > > > > > 
> > > > > > > (adding Krzysztof to c/c)
> > > > > > > 
> > > > > > > On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
> > > > > > > > On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
> > > > > > > > > A deadlock is observed in the
> > > > > > > > > qcom_geni_serial driver during runtime
> > > > > > > > > resume. This occurs when the pinctrl
> > > > > > > > > subsystem reconfigures device pins
> > > > > > > > > via msm_pinmux_set_mux() while the serial device's interrupt is an
> > > > > > > > > active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
> > > > > > > > > __synchronize_irq(), conflicting with the active wakeup state and
> > > > > > > > > causing the IRQ thread to enter an uninterruptible (D-state) sleep,
> > > > > > > > > leading to system instability.
> > > > > > > > > 
> > > > > > > > > The critical call trace leading to the deadlock is:
> > > > > > > > > 
> > > > > > > > > ������ Call trace:
> > > > > > > > > ������ __switch_to+0xe0/0x120
> > > > > > > > > ������ __schedule+0x39c/0x978
> > > > > > > > > ������ schedule+0x5c/0xf8
> > > > > > > > > ������ __synchronize_irq+0x88/0xb4
> > > > > > > > > ������ disable_irq+0x3c/0x4c
> > > > > > > > > ������ msm_pinmux_set_mux+0x508/0x644
> > > > > > > > > ������ pinmux_enable_setting+0x190/0x2dc
> > > > > > > > > ������ pinctrl_commit_state+0x13c/0x208
> > > > > > > > > ������ pinctrl_pm_select_default_state+0x4c/0xa4
> > > > > > > > > ������ geni_se_resources_on+0xe8/0x154
> > > > > > > > > ������ qcom_geni_serial_runtime_resume+0x4c/0x88
> > > > > > > > > ������ pm_generic_runtime_resume+0x2c/0x44
> > > > > > > > > ������ __genpd_runtime_resume+0x30/0x80
> > > > > > > > > ������ genpd_runtime_resume+0x114/0x29c
> > > > > > > > > ������ __rpm_callback+0x48/0x1d8
> > > > > > > > > ������ rpm_callback+0x6c/0x78
> > > > > > > > > ������ rpm_resume+0x530/0x750
> > > > > > > > > ������ __pm_runtime_resume+0x50/0x94
> > > > > > > > > ������ handle_threaded_wake_irq+0x30/0x94
> > > > > > > > > ������ irq_thread_fn+0x2c/xa8
> > > > > > > > > ������ irq_thread+0x160/x248
> > > > > > > > > ������ kthread+0x110/x114
> > > > > > > > > ������ ret_from_fork+0x10/x20
> > > > > > > > > 
> > > > > > > > > To resolve this, explicitly manage the wakeup IRQ state within the
> > > > > > > > > runtime suspend/resume callbacks. In the
> > > > > > > > > runtime resume callback, call
> > > > > > > > > disable_irq_wake() before enabling resources. This preemptively
> > > > > > > > > removes the "wakeup" capability from the IRQ, allowing subsequent
> > > > > > > > > interrupt management calls to proceed
> > > > > > > > > without conflict. An error path
> > > > > > > > > re-enables the wakeup IRQ if resource enablement fails.
> > > > > > > > > 
> > > > > > > > > Conversely, in runtime suspend, call
> > > > > > > > > enable_irq_wake() after resources
> > > > > > > > > are disabled. This ensures the interrupt is configured as a wakeup
> > > > > > > > > source only once the device has fully
> > > > > > > > > entered its low-power state. An
> > > > > > > > > error path handles disabling the wakeup IRQ
> > > > > > > > > if the suspend operation
> > > > > > > > > fails.
> > > > > > > > > 
> > > > > > > > > Fixes: 1afa70632c39 ("serial: qcom-geni:
> > > > > > > > > Enable PM runtime for serial driver")
> > > > > > > > > Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> > > > > > > > 
> > > > > > > > You forgot:
> > > > > > > > 
> > > > > > > > Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> > > > > > > > 
> > > > > > > > Also, not sure where this change will go, via
> > > > > > > > Greg or Jiri, but ideally
> > > > > > > > this should be picked for current -rc cycle since regression is
> > > > > > > > introduced during latest merge window.
> > > > > > > > 
> > > > > > > > I also would like to test it on qrb2210 rb1 where this regression is
> > > > > > > > reproduciable.
> 
> Since I don't have this board, could you kindly validate the new change and
> run a quick test on your end?
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c
> b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 83eb075b6bfa..3d6601dc6fcc 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -215,7 +215,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev
> *pctldev,
>          */
>         if (d && i != gpio_func &&
>             !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
> -               disable_irq(irq);
> +               disable_irq_nosync(irq);
> 
>         raw_spin_lock_irqsave(&pctrl->lock, flags);


sorry Praveen, didnt see this proposal. testing on my end as well.


