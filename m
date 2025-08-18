Return-Path: <linux-kernel+bounces-774278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CC2B2B0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11539684F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92362749C5;
	Mon, 18 Aug 2025 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MaW9zsrq"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE60273D83
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542857; cv=none; b=W+WRHnUmBCcL0aj1ZRi9ogtrK/nBeEpDP9bT/H3SNJBg/RGp3gxyhfj63ngnUDpU2GyGZMMuS0aLnxeuQIEyG199086dHiiK/fW3avztPusXkYKl95vaoIULQUzvAZn7GgOq2sXe7hO3ZAryt5eYnlJ49YAhZtXlEHWJvEYAWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542857; c=relaxed/simple;
	bh=xxwKmPntmdPYeXoW8B5MEfzGcyaFwReTpOOhKA18hDM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qZZlK59dfgX04/PIBIAhUWYmuD9EYuZ1gjzMuplMsNFENXN2jMlBrDHp+U6l/oj1JEDJ5GRiRQa0Ur2jVxHCZWVePKCn10hNC5SYCfaIOg79CxsAOpeqZSpSodn/8RDqjb/s0wyXwIPVdH5BpB1XoaIluzm5l3vbuOCSrKBkGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MaW9zsrq; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755542818; x=1756147618; i=markus.elfring@web.de;
	bh=xxwKmPntmdPYeXoW8B5MEfzGcyaFwReTpOOhKA18hDM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MaW9zsrqWsMmJeNxIv2Ss9AEriq0RMiat9aNsDQ/vBO1YTcVaa58T5zhTSJVKC5D
	 T/alYLVzrGKIK2a9HugAPT324JeE6ntM9H0XHscHfLdaGHRlb6tXryApZOCczoDLj
	 Ex70bqd/hm9laJmhxsGPWJtwc4C4cUR4Kb290ShCspbHT2ri3E4Z7n9rU1rcCAT6s
	 WmGOQdNiiCOmYBfHAykYhygpGyii0PI5rOsPe4JdAPFM+uxwwOyh8zS0BA9kF23Rc
	 tazPkDntnIOBBbI+AwDR7/ww0GmIT1WQ4X6p24o7LtFDPmQK8nlBlp/21A3+LBCgv
	 VDl9zwih/7w+pobcOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.231]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaW1-1uXvuU3WDz-015cHv; Mon, 18
 Aug 2025 20:46:57 +0200
Message-ID: <f4656def-1ba5-451c-b881-e439f6aa2fd6@web.de>
Date: Mon, 18 Aug 2025 20:46:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, x86@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
 Coiby Xu <coxu@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Bohac <jbohac@suse.cz>, Thomas Gleixner <tglx@linutronix.de>
References: <20250818123530.635234-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] x86/crash: Remove redundant 0 value initialization
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250818123530.635234-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZIRt+6MZiQa3D71J8UGRKZg+tgCl6V0jD/y5ZDTMgGmeo2oXZFq
 tGGbw88g9cANnihdfX+aaCz2y8Hno3QGR/QVIa5OIEW8Gy+qhcBW2FCF+UleTehrbQcfbbX
 IcvarSkQuEEppKtDcxIoy+hZMDfGkBa0IEQPSDFJIoAYwbiCC6T4AO/MLfmEYsRgM5jiwja
 nHxkjWN0qw2+2BZXPwuiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hPUcCcFkChI=;I7TtNkFbYM0NX9cLhTOc2t7v4PR
 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
 bFnNZc7YHREopzew=

> The crash_mem struct is already zeroed by vzalloc(). It's redundant to
> initialize cmem->nr_ranges to 0.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc2#n94

Regards,
Markus

