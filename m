Return-Path: <linux-kernel+bounces-780411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D608B3018C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4212517A9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636F2D63E1;
	Thu, 21 Aug 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="OfR9WoZT"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D4338F57
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798990; cv=none; b=LY30wuQiAEF47rDJmN6RgKzFvS6qtc8UD8dfYRVxHlEC7h1WICWHGOwmnXnefeOE56BUxIiyLNJqtzuOuGsuQVRKuIyJHwEY4qTXea2Yl5CpFaTpShQ2+WBSPzwMT070JfxWhvoiwz/YnxsR5igAellYPEKLcU9SjEc6tyXVTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798990; c=relaxed/simple;
	bh=SDVSLNBJCMdwEWeI7JgbGYzj1vsmsUm0fQasIzfW10c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtMlOLY7wbetysZEJMV/jqnsEFg697fwXx39H8I+iCHzk/NLBVAAmpKeMKqPqW7ZWqr3ggvQDmBZZPM/oTQvWG87hnzbo26hOxQP5Y1owFsqTpntpaRNy1vTux4oZyDPJAbOo+ZsDdvWwf0tIFinQ7aV4zFlxSDGSgCO3ppiHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=OfR9WoZT; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LHGG4Q021852;
	Thu, 21 Aug 2025 17:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=nziH13nLoiPN/0AY+wOqqUX1ja
	Wg4wGdkS6UJnaggUk=; b=OfR9WoZTPyFqhcup90BjwEqB1ERO5f/QsoWbaAwKUN
	Ijoo6+LyUj9TmisjKBEfEpZS1X/1u7BR4eXuu7IsdzuPOicgqpioH2uqP79uMTtC
	jS1AXwdYD3e4TlZZx3Y5hfEZANJFy2RsbXns8rj49IN4qqo3y+xlnOTN13IBzJPU
	hgB3T1AVhUezY+ReycdHgGjZj7O8++NQSt5cb3ai3LKj7xpZJhYgMPWR5j/1AOvB
	GYReGzG3BGCReTLNx+8/TJE5tFKhjoHb1yMjzJf9u5Gc2W32VK2M4XqpXDbvCF7f
	EGnpvHsDum+yh22Qg85FPouF0EAl1ijj2drD2HiorA3Q==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48nyjgd12j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 17:55:54 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 19E3C805E7F;
	Thu, 21 Aug 2025 17:55:53 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id A8205810AFA;
	Thu, 21 Aug 2025 17:55:51 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:55:50 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: steve.wahl@hpe.com, justin.ernst@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: Fix UBSAN array-index-out-of-bounds
Message-ID: <aKddpjJnmcuhrH6T@hpe.com>
References: <20250709192641.128872-1-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709192641.128872-1-kyle.meyer@hpe.com>
X-Authority-Analysis: v=2.4 cv=YNXGCRGx c=1 sm=1 tr=0 ts=68a75daa cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8
 a=kmVDn4j1dfFF3Or5H6cA:9 a=CjuIK1q_8ugA:10 a=phs4urI-Bf8A:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: er3GRVB291Bp-F4gMV-z5FLJU7h3uTco
X-Proofpoint-ORIG-GUID: er3GRVB291Bp-F4gMV-z5FLJU7h3uTco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE0OCBTYWx0ZWRfX9PrRzRYy2Upd
 2gmuiw1FQpz90oxnpGxY1VhSFR+GC3XwYogcsV9/r8c0+X6hWSvbPuqaJoJabHSdi182+t77UAN
 w0kG9kUiiE6LH5BRYfU+LzLYBnrGhx8PQkZH8KCOGdB46Z10eyB3L2EwLZCytK7Kn4eSp0nagSg
 dVJ8sZfD8vlnauqFsJB7XgaFBMo0aGAgrcldXgCthhJAmIoRjwlBJ1LcCEobDqIJuHSNOjnbZNw
 KlZoM5n56Fb+qatgWBnU6BM0lKI/dQNLgJwFaxDUYibJvUXTVl6yQ1lesyews8QR6Pm2RVSX/dX
 mfv4VzFWi1lyN9Ub5qBuAg0FW8gN9SO5Bfd9rrHpSOYYf0FuAUytiGrU0TODN7Y6X4l5/3U9gTl
 vjQOLfs9r4h/d6mtWi9JH/9PPyc/tcGsgkQlBcP9Sg9AJtEGUnJlCdz0ypZz8ybePxnyPN4k
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508210148

On Wed, Jul 09, 2025 at 02:26:41PM -0500, Kyle Meyer wrote:
> When UBSAN is enabled, multiple array-index-out-of-bounds messages are
> written to the ring buffer:
> 
> [    0.000000] [     T0] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:276:23
> [    0.000000] [     T0] index 1 is out of range for type '<unknown> [1]'
> ...
> [    0.000000] [     T0] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:277:32
> [    0.000000] [     T0] index 1 is out of range for type '<unknown> [1]'
> ...
> [    0.000000] [     T0] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:282:16
> [    0.000000] [     T0] index 1 is out of range for type '<unknown> [1]'
> ...
> [    0.515850] [     T1] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:1344:23
> [    0.519851] [     T1] index 1 is out of range for type '<unknown> [1]'
> ...
> [    0.603850] [     T1] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:1345:32
> [    0.607850] [     T1] index 1 is out of range for type '<unknown> [1]'
> ...
> [    0.691850] [     T1] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:1353:20
> [    0.695850] [     T1] index 1 is out of range for type '<unknown> [1]'
> 
> One-element arrays have been deprecated [1]. Switch entry
> in struct uv_systab to a flexible array member to fix UBSAN
> array-index-out-of-bounds messages.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
> 
> sizeof(struct uv_systab) is passed to early_memremap() and ioremap(). The
> flexible array member is not referenced until the entire UV system table is
> remapped, so this changes to sizeof(struct uv_systab) would have no impact
> anyway.
> 
>  arch/x86/include/asm/uv/bios.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
> index 6989b824fd32..d0b62e255290 100644
> --- a/arch/x86/include/asm/uv/bios.h
> +++ b/arch/x86/include/asm/uv/bios.h
> @@ -122,7 +122,7 @@ struct uv_systab {
>  	struct {
>  		u32 type:8;	/* type of entry */
>  		u32 offset:24;	/* byte offset from struct start to entry */
> -	} entry[1];		/* additional entries follow */
> +	} entry[];		/* additional entries follow */
>  };
>  extern struct uv_systab *uv_systab;
>  
> -- 
> 2.50.0
> 

Just a friendly ping.

Thanks,
Kyle Meyer

