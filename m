Return-Path: <linux-kernel+bounces-858169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305FBE92FC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8B33ACD7F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096FB339717;
	Fri, 17 Oct 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="bodGXQkS"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D533970F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711146; cv=none; b=ME+xCaJVS5iMcpuBQJOa3Nr9g+QgVrVrZrSBubGMPjA4Yvzeh5ty/Zrt4IXj2D8yBsmoRsvsz8Iv0OeC+uAUpq+T04lR3XGoukLWGITphVOAsROQZEDayKQb3GbZuET87UZzzvcktDz6+L4c7pqxzUoasor8yEim85d5UR9owE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711146; c=relaxed/simple;
	bh=oq5lGoBqDaojXwGQhwg0L+GR5JoAjWhiA2VGSHnKhX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJeNjWaGML6YHDLSlnhXjWfmhaQAv2pTqjCqifqkr9SmpbtPd3d7RgF2s09G4wV5/iRjfTzQAiCEb9yCh1nj8a1hIy4cAjMwmxQ4fjMskW1OdXIN7wRETmJrc9KXjn9dPvS2mLzPBhSzYmouqoI+NEdjJhPE9gUHhYTThDWrmbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=bodGXQkS; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCiOnK017927;
	Fri, 17 Oct 2025 14:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=qHaUF+8ZC8fSBdL7vGk2MXVbGJ
	IIozPEpTrbIExuz2Q=; b=bodGXQkSLSHi9hJKHTIpgsb+Fdj+xm6NmRhjJeuD3/
	AjODZWW8GaMGVzK7h4dDxvaK+mz0CatyND0upj2gjc1pbbF5FBelUlTlPfGIrP7J
	pj9U9YtPoAlbFv9kGmYCRU8OBaF9qfCv+O8GOIy3OTP6j94IVZfQVDvJ3LMIZGyD
	IriUEL8Gwy3VtvgP0b+fdmroTqu+1N3oTq7y9Eb4iqPkCeVUqIrERAXmIBfShq1e
	P8fHR9nVtHaIGC66+nsWHIJ++8iLi6HVrS/8B6ydesJJ6ljef3EMVFhoPEW4VF3b
	UNCc5hXPzSKn4zbMj2VgIfg2yq+v9YF2vXST+Q3K2D3Q==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 49ubbtnkws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 14:23:13 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id EF3CB8059F1;
	Fri, 17 Oct 2025 14:23:11 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 368B780047C;
	Fri, 17 Oct 2025 14:23:09 +0000 (UTC)
Date: Fri, 17 Oct 2025 09:23:05 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steve Wahl <steve.wahl@hpe.com>, Justin Ernst <justin.ernst@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: Use str_enabled_disabled in
 uv_nmi_setup_hubless_intr
Message-ID: <aPJRClydphemPMjy@hpe.com>
References: <20251017093711.38194-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093711.38194-2-thorsten.blum@linux.dev>
X-Authority-Analysis: v=2.4 cv=U9ifzOru c=1 sm=1 tr=0 ts=68f25151 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MvuuwTCpAAAA:8 a=siYHsXygHmVQmmX3guMA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ofhZZ_sYM-c7PioxE-IrRApon-lgQSNh
X-Proofpoint-GUID: ofhZZ_sYM-c7PioxE-IrRApon-lgQSNh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDAwMiBTYWx0ZWRfXz1zmBD4TEfLk
 gG0j6C944ulTv8hFq1WdXP56p8uTwn22alxfD4gd60jQsUNokpHi9toOgda2nTd9A5mcOK1EFQd
 8bPweDpr0rr8zTm70M458E9qWCWiobAXZpWPRLeY4xyBCvh39fFlCdbrhoM/8pC1AjwmZlczf1m
 Y7sPw5jFdlJ/deGDVVUvJL8zZlslqoraSjyNRc9yK+J+GvDNciDiWRELO223r/c/n3coCGY8KMC
 NUt5osmxkhJ0fYYES96rsk7GpUFyp9wQ1b3tpSpp07dV4iTtGc9iThWKdOOL5e5nKpwzRcLDqCG
 YC4taI0CASfsm9B3m+1P1L23fra9SpUuYwdCyMuwV3pSNAWvpkaX3KMKbM8hSlVPNutMNZgeGER
 ZBOzvh+dsNObfJQrcRVoX2/U4SD7zQ==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510170002

On Fri, Oct 17, 2025 at 11:37:12AM +0200, Thorsten Blum wrote:
> Replace hard-coded strings with the str_enabled_disabled() helper. This
> unifies the output and helps the linker with deduplication, which can
> result in a smaller binary. Additionally, silence the following
> Coccinelle/coccicheck warning reported by string_choices.cocci:
> 
>   opportunity for str_enabled_disabled(uv_pch_intr_now_enabled)
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Reviewed-by: Kyle Meyer <kyle.meyer@hpe.com>

>  arch/x86/platform/uv/uv_nmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> index 5c50e550ab63..565ab43fa6b4 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -18,6 +18,7 @@
>  #include <linux/sched/debug.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/string_choices.h>
>  #include <linux/clocksource.h>
>  
>  #include <asm/apic.h>
> @@ -340,7 +341,7 @@ static void uv_nmi_setup_hubless_intr(void)
>  		uv_pch_intr_now_enabled ? GPIROUTNMI : 0);
>  
>  	nmi_debug("UV:NMI: GPP_D_0 interrupt %s\n",
> -		uv_pch_intr_now_enabled ? "enabled" : "disabled");
> +		str_enabled_disabled(uv_pch_intr_now_enabled));
>  }
>  
>  static struct init_nmi {
> -- 
> 2.51.0
> 

