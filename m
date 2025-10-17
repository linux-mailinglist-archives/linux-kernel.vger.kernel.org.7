Return-Path: <linux-kernel+bounces-857974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E897BE86EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CD96E3DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F5332EA3;
	Fri, 17 Oct 2025 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RJh6R/sE"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44409332EA8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701111; cv=none; b=YuDuIW12KeaBv74hdIe4UopgDeOK6LZ07lwmRs7Y8p+8gDNfk0lfbaisoFD3/aJo9mdUbOZ8r/CgcXwnFFpUQy/YiWiSTBxCdxdP4xYdX3bHj7QQcW6i+7+x+7CAB77ZjINrUQzOaezsgDrnkgr01y2LIHGid45hOVcOQ9J+KwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701111; c=relaxed/simple;
	bh=9msVu+SUBbsb9PBWG/xro47qnP6i3+BAjZkvCCDx/DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXX+wf0CBIA/QlQ7Ew8APJbx/XHqmJNktLnDD7+t30J4VeScxB9fkxjDJGa0Xt0qZyhFJdmH157t72I16vYQB5KwokhOfh5XbXPxSADt/VrBbaKtXTLQ5nhMfFNJPwYUzYtW4I7KXzA8SNXKjNwHfoyqOVss2eNpJZrNjdPl0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RJh6R/sE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42701b29a7eso843732f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760701107; x=1761305907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSsGSmsIxqB5hm0PfffZYkH5rW/rAwPHgsZUjkbnJ5U=;
        b=RJh6R/sE10jnJYI2cU1wwkRhFzykzZGWp9LPdHSEeeO96YDrImRezsdFp0mpwRSrhT
         YTWf4kEhpI9aZMm3tM6qEuT62PTCfww9U0oLE1bpm7mX4tXFV2O/letJd1H1wfraACHu
         VlOgURQfsjHEwZW/xvOdo/IPjgaW7+OA9X1ZnrXmoHWtO+eUYnZi1w2Vr3jbmsVKvn7B
         INMZr+jl7DRRvYfzY9qtQJVcIBWBu2yb3YEbw+3elRRC9gxNo88HuefbEYi8mZBaCA6U
         FzcWW6VQEGWW3s8q3Mmo866xxrUtL/shOgc/P7H7y8GH/9Dj6g6gT02h4F0qxPITEnkc
         1gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760701108; x=1761305908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSsGSmsIxqB5hm0PfffZYkH5rW/rAwPHgsZUjkbnJ5U=;
        b=fThDi0hepxwWs5CAws6AZNctuMOdUKS+axAwKcsAS9bDOjPOaIPO2TVQmKvezCPePP
         MWTsO+7+oNi1bjq+bPfutDiLoRV58yKaO1nCPu0AJQg8/J9xC8RnvLUyqUML148MjbQ6
         q77lAwRt+U+8YtZTpydLQSd33XqcVpOyp2wrUm5nC5UA2drDr88uSWlsP4vs/5PPukol
         WzGAiSVDn6YAgw/3/JZFcZBHp0ofhDcG/wbBThXI20AdwACbTJ10KAeW/9LERA5fvVT/
         tXjZhglMdKKZvX0KEnFazp/wewSvVkPngWzSu4Ijkk6rFnPSfxSCiPLzGhnb/thRh+zG
         thfA==
X-Forwarded-Encrypted: i=1; AJvYcCWHhrmDqtz7NDtDptsrX4VDbcT8gkxGfBExaK6Xi5RzQbkiMOAVzGXDJ5OyyI30F/ANXejuJOpKZ5JYT7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNSMZHcoNkufa4MqZ6oUOAf0i/KqjStZmHJ/vW9J/wJvRo9v8
	c9/cqoTVByb3F7X/8h4FI1v5LS/hnKTteI2eYKPkZ9Zq7w/xMgMJ5V9l8QRODwFGz/s=
X-Gm-Gg: ASbGncsGdCFW2h8FP19agnrVWsD2dV/jAwL4RFWx1j52mQEx/eMvsUiRpcjm+Kxyx1c
	2Oc+8w1IovqFt/HWfKvRHT05aR3YcV/804ZNFT6sRwjJQ15IxJsrSISpuB7dyHECawyGvbpR8vL
	kRrhdS0gUeIUC/qLng5pNFUzMNJgEcjmePJjObAvwn/K2yL0/HHkX88L9u7lmOdHkiGUjt2HbKc
	Ix+p6FaAIDBImivBgCQ2DGo+MSxMx0hmIfgqdEnXtpdmXkPOtCKrDBcCPzvwpT9mskGf9oNXEGK
	JhZjoqa072ECqpEJ04lKqOLyVSMokaDVSTBPkQ53R8ZqhQwB2D0KJA5VjEyMzGxGbsZFog5uY26
	66KSSyTJqSLBGUGYH8PQcInWMXbhMRANaqUVJ63veylZ1qyCtTeYFdapH0GsIfJZ2w1+4YO5dui
	q/1UNM1n7aboKy+Y50xxoG
X-Google-Smtp-Source: AGHT+IEvltr4XQUBvXbO5/DAcfM0KgT+zHuTMTdsx4BX5yj88NzF+xLsMdBh0+sxiVD7nd1L1YhGYw==
X-Received: by 2002:a05:6000:2287:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42704a62705mr2909583f8f.0.1760701107569;
        Fri, 17 Oct 2025 04:38:27 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm19030555f8f.0.2025.10.17.04.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 04:38:27 -0700 (PDT)
Message-ID: <c58152f1-0fbe-4f50-bb61-e2f4c0584025@suse.com>
Date: Fri, 17 Oct 2025 13:38:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ABI: sysfs-module: list all taint flags
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20251015221348.1125295-1-rdunlap@infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251015221348.1125295-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 12:13 AM, Randy Dunlap wrote:
> The list of module taint flags has not been updated lately as the
> taint flags list grows. Instead of trying to keep multiple lists
> updated, just refer to the list of kernel taint flags since they are
> the same.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: linux-modules@vger.kernel.org
> ---
>  Documentation/ABI/testing/sysfs-module        |   10 ++--------
>  Documentation/admin-guide/tainted-kernels.rst |    2 ++
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> --- linux-next-20251014.orig/Documentation/ABI/testing/sysfs-module
> +++ linux-next-20251014/Documentation/ABI/testing/sysfs-module
> @@ -52,14 +52,8 @@ What:		/sys/module/*/taint
>  Date:		Jan 2012
>  KernelVersion:	3.3
>  Contact:	Kay Sievers <kay.sievers@vrfy.org>
> -Description:	Module taint flags:
> -			==  =====================
> -			P   proprietary module
> -			O   out-of-tree module
> -			F   force-loaded module
> -			C   staging driver module
> -			E   unsigned module
> -			==  =====================
> +Description:	Module taint flags: same as the kernel taint flags.
> +		See: :ref:`taint_flags` in Documentation/admin-guide/tainted-kernels.rst

The module taint flags that can appear in /sys/module/*/taint are
a subset of the kernel taint flags. By looking at the calls to
add_taint_module(), they are as follows:

Present:
TAINT_PROPRIETARY_MODULE
TAINT_OOT_MODULE
TAINT_FORCED_MODULE
TAINT_CRAP
TAINT_UNSIGNED_MODULE

Missing:
TAINT_LIVEPATCH
TAINT_TEST

+ potentially TEST_AUX.

Since this text specifically documents what can appear in
/sys/module/*/taint, I think we should still maintain a list of these
flags for accuracy.

Additionally, Documentation/admin-guide/tainted-kernels.rst provides
taint descriptions for the kernel as a whole, which can be misleading
for individual modules. For instance, for TAINT_LIVEPATCH, the document
says "kernel has been live patched", but in the context of
/sys/module/*/taint, it means "this is a livepatch module".

-- 
Thanks,
Petr

