Return-Path: <linux-kernel+bounces-833161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11636BA150C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7537AC6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091D31FEFA;
	Thu, 25 Sep 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0hnIkrV"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5531B824
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830779; cv=none; b=Ca3jyJUiRsF1ZsDdNdXNsNbzESpnGXMnyTyrk+K2hv6Klp0z8b5eV4jb6UWo5HXjE5FwV+QiheF0anLNSrtxA2lXMYFBL2rYG+VKlia7y/NuqLLd6tbfAoJEQaWnz9YimB787bSxOk7+QHWI5FlO/O0bK/asVqG9LSqWWdF4wlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830779; c=relaxed/simple;
	bh=Xx1KeRMb8qASSXQQi6oPfzSHjtino2Erc6qXBCGf8kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsP1Rj5nbxI8fqD+T+UPZ9QH/Q5V0o+ZF501jcO5dHFMdbCRUTW67sfZx2r0pXh1GCTUispgBvoAylPlHZ58V7fg4pqi51hOfF125NlVRi4CmSQjhWu0YQI4I41LGRzkJS4FSdnoxJ78VdY8QZJOlsA2UdN4lzaGHqQLmTB1NcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0hnIkrV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8d593793af1so57692739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758830775; x=1759435575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZ4J+q8Jl9uXHJWsnYE6h3kFUoOp3/nCTgLQNbxMPJA=;
        b=Q0hnIkrV6h3MtwHvFdc6EgugqVJ0mjjALtcl+To9m9yTQZwpcsBmoI6j66jQY75sAB
         w3VVp8KAAhQIIqIXhAZcpFmAO3dUJQJlzHMDOz4asW4BPBvfYLyGqS62b1VYT4WHuqaD
         daEIAv1Fs84+IJL3zu/FcnzWglxJPMIGDXMeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830775; x=1759435575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ4J+q8Jl9uXHJWsnYE6h3kFUoOp3/nCTgLQNbxMPJA=;
        b=htnJLQkuK97zb8rxJ66dbZ5F5nL2RnxQCPMzaUrXvm0XpJ8Ia9zVeE9wfOMwXIBAfp
         kPkC/jUmIWRg3GUjoOTW3ri9nm/7uoDbAmJAdwFRd6N8896D/MTQFjRDFW6i+SMp0zId
         yE/2lxelRuYtPjWpFqptfQ98ODQAOwbaoR7NPJRTRJGCP/5tBVDSrbACBJOi89b+a0aQ
         NqE0Pz3IuJ2H8in8CgmqrXOUzERwNNPswM0yY9dQJwwvGilwdCI/stLiX1xrnXZWG+JY
         oOL5/YHvJjhQguCrMcGeWzQMJk4mz4OS+l37VkcYNU7Fv4FVTtkGTl7AE/rAKtq2UniE
         hyEA==
X-Forwarded-Encrypted: i=1; AJvYcCVOUpMKOWF/p9dKofSZ1xIPB4/FRZfcZv/FLwmo2MOhoCOG2PzWNyQqqE6iTsp5ghojMup7i8C4bQSJC7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5lpgEmA3gbiLEc72xkimae1co9J/RN5lAkSvRpsuF5F21YlV
	m11DSj7aXkWjgQVlUfuEZ8sezNiKvZVi4XKShrWEc+yah0hs7O057yjuo+lyX/seoTw=
X-Gm-Gg: ASbGncsJ7H3Z2N02vFeX08s7R4UvXsRDEJHnO1Bnry2B9mKU2QrGmbtk9ly2aFZm28b
	NjGiM9wS1dxHSAX+GMi8q2PZlxSICIfsToqHt9CqwZ+BqvILRAXjwPQDgRWqHhbSjyKuCwQh7Bf
	ja/5csEOvlm9uuf3t09IWTc7dDvDhN0f4KvwKywS/7XDqgDIuAwtK+iUxNikTfWfYEUrglyDmTj
	FOh1KGiocgDRUCWDO+wvq8XtmjbR1klW4ZYIlyVQSwK24jMDtgWk0J/6bpaV5zVIb6F2mQUhWLI
	IEEeEDijjyTnLUdnS/pCSpW3SBnJkty+s2JBwCYmzDV+aWPoH1DGOEtqcN56orN2HUrWFMaDSxD
	tBvRHMCIiZu5MKAtu/vmyC4FSdTnsO50wHwk=
X-Google-Smtp-Source: AGHT+IGgoqo4FexGR81T+2V+UyC7F009+mx6SQ2pBJCOPIpWzVqCjsnAHekbeNq05hlbCiQ/ymxj7A==
X-Received: by 2002:a05:6e02:441a:20b0:427:5aa:4570 with SMTP id e9e14a558f8ab-42705aa4687mr13249845ab.3.1758830775392;
        Thu, 25 Sep 2025 13:06:15 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a648d1aeesm1082556173.8.2025.09.25.13.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 13:06:14 -0700 (PDT)
Message-ID: <650a4711-1d33-4582-be84-19ab99ff7f82@linuxfoundation.org>
Date: Thu, 25 Sep 2025 14:06:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: perf: cleanup fujitsu_uncore_pmu.rst and fix
 htmldocs warnings/errors
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, corbet@lwn.net,
 fj2767dz@fujitsu.com, will@kernel.org, yangyicong@hisilicon.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250925195442.71997-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250925195442.71997-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 13:54, Gopi Krishna Menon wrote:
> - Adjust spacing around list and sections for better readability.
> - Use definition lists for defining events.
> - Replace block quotes with code blocks where appropriate.

The bullet list type format used above isn't right format for
change log. Refer to a few change logs and also check submitting
patches documentation.

Sounds like you are combining formatting changes and warning
fixes. These are better done as separate patches.
> 
> Fixes the following htmldocs errors/warnings:
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:20: ERROR: Unexpected indentation.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:23: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:28: ERROR: Unexpected indentation.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:29: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:81: ERROR: Unexpected indentation.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:82: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
>   .../admin-guide/perf/fujitsu_uncore_pmu.rst   | 130 ++++++++++++------
>   1 file changed, 87 insertions(+), 43 deletions(-)
> 

thanks,
-- Shuah

