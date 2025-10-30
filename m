Return-Path: <linux-kernel+bounces-877642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF9C1EA63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456EC1880266
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70E330B3A;
	Thu, 30 Oct 2025 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCjV2d6O"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E98331A6F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807383; cv=none; b=dyizvwiLc1m9lS+qKLYuB+Jn3MeqEKRNkjAsRcLJzpALb80/6WGmmUxNAHmrT2pE8A3IOPpDcXS57Ba73pf4qbp+/54QeAqTk/h+6lWRU4ksvfOZVPcb/Ee2glfQ+T3tXP/mrTeRvjk3WK4H+9qkRAwgK8MdIqoOXAekL5UKUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807383; c=relaxed/simple;
	bh=RcmdipCEoLttFXQjaqGQSM+eB6wmgvWsf+vSRe4ywrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2d3AdmFtP3iznzE+tu1E5WNJA/q49IWWg4Gd2wpbZFoTTNzVQiWj0Lrr2dLcfBIQc5cX5Q641Oom1qrCot2HUcxj9xfnqGeQjJ3JuUZvLiE3yxomiAWYIfJQm4FOtBLehG1VzueNh+X8gprLjX+eG4eBKMQNabd+5oftKG97e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCjV2d6O; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso489812a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761807381; x=1762412181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcmdipCEoLttFXQjaqGQSM+eB6wmgvWsf+vSRe4ywrQ=;
        b=iCjV2d6O+gcaXx81s+Vh/UjXl7BHF1EslE+fYPIDtv1hU+fsXUo5kwTSplRZdDLS5Y
         V/F7kNvbADgVm0rIRtsMndOOBOI/UbPS1l3gdT/ju9TVCSrVxp7EPFYFI6eESdABwrh3
         fiNGhULVkutw8wVlh4uvJXKriBGDO3d8XLrrkDwMRavepdkczEP5ymxBRnB99fspneX7
         ZoR75iiPnFL7i5hQ4J0OFHtQAWI6RALwV1H+AD9wm/b4MPTmgnyjCdJVulSE4/frV+b1
         gMEMdScMtANTVU2XQBR+bwXtD9W5HfjVBZcJ1dllIBE1HlujJE9ChVEVqmJhk1Qy/GlL
         TmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807381; x=1762412181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcmdipCEoLttFXQjaqGQSM+eB6wmgvWsf+vSRe4ywrQ=;
        b=b8JU1togAc96wusum3IZpUn3R7alPWrgirITO2CPFLjjKensISN9F0xhnmO6gv9Arx
         YW8Zz9vjqpoUuisRDEdRby7Orfmtdt/oO2+XBhCymbJiZ7dwj8CjqAyvjmYYN217a6B/
         h1A4qLl7/DfbNiPOOxe33cerX6UTa4/XpVdRkPG5rPvH2jd+pTVzgHdLfzi4G2fH5W0c
         DWfdUr+q2G1F035qjKOTiyXKmfS/5IbXow2sI7RiVi23coDAFi1qkNwQYFUNlQiwl20u
         VB4v83/FX61DAln7yeeDWav1FvvmcxPsHZ5oH623rNXAR/jCGAdl6l7BSzYsnm/sFAG4
         EdHg==
X-Forwarded-Encrypted: i=1; AJvYcCVDViAW3b+GmkFwUy/rnepXngRKRJBdvcs7hDP7C9T00NnGWTq2WUuXSJC7wB+blCJvohDuVCvBOEcyecg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnWyC3/Fs4Z9V4bqYFZrr1bW3uu8XOeSCgx9y+vbB6IKzV2j7
	klB5sOCX8IrhQe4e7wj8naSxL/1ibpkQ2rnMXiJyTFHb5Gl1eAjr8BtTye6Pkdk9kQ7kPW7qe1k
	R4MWDVeLXehQzGfQNg3O+9Y8wRivXmKYlvK/3pHg=
X-Gm-Gg: ASbGncuNI/aMuM5XRjoEalsXwrNHngHwppgsjymsM5hKoV3ypp+xcwJ4CWx1fw9ua1Y
	+qXgE3asb7edZV2sYM/Zbm6Tv8ASlTm/Q5nUOaDHQVYdBzbpNu2cdC555hH0A8vQIoRjrti8XzY
	YDJS3G7eJHBewAtqDKac/vhO/n/bIYHdNBZ4GCYXiRhrhi2IDQ6Psskl/Lqucza35qK743Y4zh5
	JMA8xLpE0htUQDmk5Aflye+V+JUZQGEmIyPQ43SGzOiXAFgR6cdw7mICf7qw67mTaB5G28h
X-Google-Smtp-Source: AGHT+IFBIkIFXtorNFDLnjIpYZzPxz9yBZSS+F8cf/xVMev+G6oJ0yS2hVsvXsQ0n8HbNBwbg+BNY+W8Ma2XnREvlGI=
X-Received: by 2002:a17:902:e80e:b0:269:9a8f:a4ab with SMTP id
 d9443c01a7336-294ee0c2300mr19378385ad.60.1761807380973; Wed, 29 Oct 2025
 23:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7-1dMwPQ4mirrRjsOkKKyLchkBR+7qMVqxjo7Bbr1T=A@mail.gmail.com>
 <c311789b-a6be-42c9-acfe-c1fdd9f4e3e1@intel.com>
In-Reply-To: <c311789b-a6be-42c9-acfe-c1fdd9f4e3e1@intel.com>
From: chuang <nashuiliang@gmail.com>
Date: Thu, 30 Oct 2025 14:56:09 +0800
X-Gm-Features: AWmQ_blC_KGd3tZarXEiT8AZFBEAb-25KW14U21_RbHlWb4ikgJLS1_TFshzaOY
Message-ID: <CACueBy4MTDesg_icWRYrAEJxZ3m3_Qo-joQUdgV0tqRWFe8Y4A@mail.gmail.com>
Subject: Re: x86/fpu: Inaccurate AVX-512 Usage Tracking via arch_status
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:26=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 10/27/25 00:50, chuang wrote:
> > On AVX-512 capable systems, the implementation appears to record the
> > current timestamp into 'task->thread.fpu.avx512_timestamp' upon any
> > task switch, irrespective of whether the task has actually executed an
> > AVX-512 instruction.
>
> The timestamp update ultimately has _zero_ to do with executing
> AVX-512 instructions. It's all about the state in the ZMM registers, not
> AVX-512 instructions.

Got it, thanks.

> Those registers are inherited at fork and I don't see avx512_timestamp
> being zeroed anywhere. So I suspect what you are seeing is that some
> _parent_ used AVX512, and its children are getting stuck with
> avx512_timestamp.

I have tested with the attached patch. The behavior remains the same
as previously reported: after fpu_clone(), the new process still has a
non-zero avx512_timestamp, and it continues to be updated in
subsequent task switches, irrespective of AVX-512 instruction
execution.

I traced the code path within fpu_clone(): In fpu_clone() ->
save_fpregs_to_fpstate(), since my current Intel CPU supports XSAVE,
the call to os_xsave() results in the XFEATURE_Hi16_ZMM bit being
set/enabled in xsave.header.xfeatures. This then causes
update_avx_timestamp() to update fpu->avx512_timestamp. The same flow
occurs in __switch_to() -> switch_fpu_prepare().

Given this, is the issue related to my specific Intel Xeon Gold? Is
the CPU continuously indicating that the AVX-512 state is in use?

> You could probably confirm this by dumping ->avx512_timestamp in
> fpu_clone().
>
> Or, try the attached patch and see if it makes things work more like
> you'd expect.

Best regards,

