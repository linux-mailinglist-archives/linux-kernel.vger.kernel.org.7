Return-Path: <linux-kernel+bounces-767825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635FFB2598C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6337D5A0D63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E24121257D;
	Thu, 14 Aug 2025 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jjb+VH9x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FC15746F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755139193; cv=none; b=Cbv0TOeG25VxvaLPJiwYqT+OLm/nmUUkb3Z75pCilZNtu4TXNVhTu/szRPwOst21F0RQeOf/2Ksn/gtu7JjRzcP7wKhfRHjU5yqPjGQ8kHlMpLHrJ5WxS8abCTV4Lk3Xvibeav3d3GivBWdXeJjQ3+pm+PQsR90X8EyaeYNB1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755139193; c=relaxed/simple;
	bh=kZBxCxwwuBypyz569GQAIINeywgbqq/2j3P0gkbFBLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDeyOBWBgqG7guzfHq5XxoMieA0J1eNDknymAK1NIlA6RtX5h0N2vjEgNgwfzre9yDbncJrsaCS+Pq6hivRcZoPup0DDVvuAl2NTP+NhC8JGX72Xtj483ZYFqBwVk8O9jW81b8lAq17YLaCRXJ/GyFwBqAlXn5vJ0wmlMT/4COQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jjb+VH9x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755139190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lmfqcZ52puICOqfYpqD3N/QRVedlIIDloCFgvva9KY=;
	b=Jjb+VH9xMT2eERDYthG1Nq3G2aXX7RQOWn9D5TOqNdtckEVPCVl7uIXvdgJLGnkgXS9AL+
	LWx8OO2Nn0A++OAtLW1O2LLsV8Y4r6uEkrRI7lyo1YpYE5AsyZKBMeyhNl3/Q/k/e2HgSN
	UwXY2JWOlNMzdmXRAwvCVqkxGqEJjxA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-8oGBpyq0OiSQ-YizA1p2zA-1; Wed,
 13 Aug 2025 22:39:47 -0400
X-MC-Unique: 8oGBpyq0OiSQ-YizA1p2zA-1
X-Mimecast-MFC-AGG-ID: 8oGBpyq0OiSQ-YizA1p2zA_1755139184
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A590618003FD;
	Thu, 14 Aug 2025 02:39:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67FF71800446;
	Thu, 14 Aug 2025 02:39:41 +0000 (UTC)
Date: Thu, 14 Aug 2025 10:39:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Brian Mak <makb@juniper.net>
Cc: Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: Carry forward the boot DTB on kexec
Message-ID: <aJ1MaPVWZCp0qpU2@MiWiFi-R3L-srv>
References: <20250805211527.122367-1-makb@juniper.net>
 <9B71EC74-D1F4-4F7D-837A-A43E53CEBB89@juniper.net>
 <CALu+AoQnXfYtuKQxVKK32sC4D98Y+Yn30TjTr2xmXhZcHe0x=A@mail.gmail.com>
 <A402BEF1-EB1A-48F0-997F-502429AAD92E@juniper.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A402BEF1-EB1A-48F0-997F-502429AAD92E@juniper.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/13/25 at 07:24pm, Brian Mak wrote:
> On Aug 12, 2025, at 8:54 PM, Dave Young <dyoung@redhat.com> wrote:
> 
> > Hi, The #ifdef CONFIG_* which can be replaced by #if defined(), but I
> > do not have a strong opinion.  other than that do you have kexec-tools
> > patch ready? It would be better to provide a link so that people can
> > try and test it.
> 
> Hi Dave,
> 
> Thanks for looking at this! The #ifdef CONFIG_* is used, as it matches
> the style of other ifdefs in this file. I'd like to keep it as-is for
> consistency.
> 
> I do have a prototype kexec-tools patch ready for testing. The changes
> can be found at this repo:
> 
> https://github.com/makb-juniper/kexec-tools.git
> 
> I've also placed the diff below.

Thanks, I will apply your patch and take a test.

Usually, Andrew will merge kexec/kdump patch if the patch is OK to him.
I will add comment if I have concern. Otherwise, I don't want Andrew to
bother to add my ACK.

> 
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index 9b17578..8419b23 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -124,6 +124,8 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
>  #define KEXEC_FILE_ON_CRASH	0x00000002
>  #define KEXEC_FILE_NO_INITRAMFS	0x00000004
>  #define KEXEC_FILE_DEBUG	0x00000008
> +#define KEXEC_FILE_NO_CMA	0x00000010
> +#define KEXEC_FILE_FORCE_DTB	0x00000020
>  
>  /* These values match the ELF architecture values. 
>   * Unless there is a good reason that should continue to be the case.
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 6bf12d7..0e13b6b 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1102,6 +1102,7 @@ void usage(void)
>  	       " --hotplug            Do in-kernel update of kexec segments on CPU/Memory\n"
>  	       "                      hot add/remove events, avoiding the need to reload\n"
>  	       "                      kdump kernel on online/offline events.\n"
> +	       " --force-dtb          Carry over the current boot's device tree blob (x86 only).\n"
>  	       " -d, --debug          Enable debugging to help spot a failure.\n"
>  	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
>  	       "                      0 if not.\n"
> @@ -1640,6 +1641,9 @@ int main(int argc, char *argv[])
>  		case OPT_HOTPLUG:
>  			do_hotplug = 1;
>  			break;
> +		case OPT_FORCE_DTB:
> +			kexec_file_flags |= KEXEC_FILE_FORCE_DTB;
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index a2e19c4..2235aa2 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -235,7 +235,8 @@ extern int file_types;
>  #define OPT_LOAD_LIVE_UPDATE	263
>  #define OPT_EXEC_LIVE_UPDATE	264
>  #define OPT_HOTPLUG		        265
> -#define OPT_MAX		266
> +#define OPT_FORCE_DTB		266
> +#define OPT_MAX		267
>  #define KEXEC_OPTIONS \
>  	{ "help",		0, 0, OPT_HELP }, \
>  	{ "version",		0, 0, OPT_VERSION }, \
> @@ -263,6 +264,7 @@ extern int file_types;
>  	{ "status",		0, 0, OPT_STATUS }, \
>  	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
>  	{ "hotplug",		    0, 0, OPT_HOTPLUG }, \
> +	{ "force-dtb",          0, 0, OPT_FORCE_DTB }, \
>  
>  #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
>  
> 
> base-commit: daa29443819d3045338792b5ba950ed90e79d7a5
> -- 
> 2.25.1
> 


