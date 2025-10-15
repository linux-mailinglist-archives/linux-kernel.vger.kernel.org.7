Return-Path: <linux-kernel+bounces-853955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF1BDD29E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA64B5089E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BE8314A8A;
	Wed, 15 Oct 2025 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUuFuxkS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06D313E39
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513578; cv=none; b=n6jNeYbCUkussCThLmkBGUkwstXBhjIWB1QR+KEbQw8uc3YFwsJLbJdq/kXoWag3q1DyS4IVBm2J5ISI/uVQvNQvKfFp7ts0TVhrZk6OtYi3qEI18DvgoQ/KJkaXe18eN9Fd6r91mu6iwhWKB8Q7S7y4vqzvuMqcjvsTsIaB+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513578; c=relaxed/simple;
	bh=TqkvX9sJJn6FlWWWGRKJNsMYEF37qY1Fai6quimjzjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab5rB62X3QpnvVZwtrdfTpYgOEeVvNDSd0JE5nKO1wBm0UtZVsx0bzH6QvAp9gZyZTWFfzOGRwxuk+vbSdg1iSSNOJAuR6RBijzowvFU+MePLFnwxfYKWS+59VgaVdlCK7B3SiFIJ7WJIfjCJ0WHgIbCxbWs8/EEsb3dUkDkw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUuFuxkS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3c2db014easo332173266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760513575; x=1761118375; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu/zEiC7ds7XeHZ44gt1r4dEzp1UHt8UKyKXP93tZdc=;
        b=EUuFuxkSEA3XP3PeiWfyH8tOZu4pok3Yjv566DkVwzYzNYZjtb2+p3oO3aeZ11vPiF
         TZK56rswic+vbQIHuOGRL9ATkYBUVunk5TJ6NXzgvr+W2LfS/QKmCPC1LWn5aKRC2ejJ
         kd8Mu3iuIBoaeGtcpOe+8RbulygVvmEXECFCpf4oWu+SPgBJuAggeSC+H28Pp1B+wCb3
         cRuRolyxrDXjVsxcvoKYbsZHUjs/HbZZiexGsxAnxOhG49ykzaGKGyJ2bJpbpm1FfO0c
         m7gtPGB46DvnoTc+6DHXGztAivDlD0+oxzgf9Ag6W+oPVXao+/5BveuBgwTI4l0ldRn5
         sbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760513575; x=1761118375;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cu/zEiC7ds7XeHZ44gt1r4dEzp1UHt8UKyKXP93tZdc=;
        b=PqWLGUBREhV9uFZJ9Mrsl+d6rcW46dcaACl8icz8+WruWOc+co3k9/TLmgh5gjNCf8
         FRf+0BO8xPhZOUSc/amALe6QdCZE8UWg/ezaRMbi2vOfpmlqtAM7N7V9rfuNFZj1uitK
         m5zcbW6Mn4eKbH+Abyis+rVj9mFySaVyg7Uvx7eHvDhZDG+RHgWxFJttmGBhRPUTuOK1
         PVM/tQQ+dQIXFck3Y2xCTdCNRqJI1dHHYTztiCTN2uQ1B7URGqG+/iA5hmuQeJT7uLev
         gnFhkPbgDPnwbE8qIpjuU8MouWQ2GPy8aFScxuxX105o8w5GCMaGJJCVgt6Pt3L1cajq
         GFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Vqt9eYFI2fKdxr/NzHItFewb7b3qzF815F772q6L0I+eQM6+KDxT36ep1VaKp748ZLpJagzNmysNk/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf00e4LWFyPQR2ZADGsB6wiuGcmSHQuV+xS03elV/c8oKVltay
	Em/HgE02MkjsJgxPDIlxswlWW6enwVZ+Dl1fc9HmC+WpDYyVFkXHnP8e
X-Gm-Gg: ASbGncuyER7gxiMuvLMjBQM4ZnR1iC6+W97S4CL9P6kr62p66rC93b0OzGFHJUPoo6W
	icCJSHJ6KpQPxIUW2CIjwZura7Vzr4o/+nILbEsP2qnjcftDpAhiiskMPdL4QwYr2lsYCCvTwQB
	g5AV27ojKuSPZ89cF8uLO8Wdo5sYhH1AczXdDHmE3U8SgvjOz5WJ3hH7j+Of3ygs/NkCoV/4JNr
	DSYvGKEOiWU1GHVR7UK1b5MiAjV95XRQoj6SI73+Qwzqy1Z57lR+nQrb8D10bPvPOga38+fIKAa
	h/mEaNjtbBgPWWyEI8MvipJqlKbYjS+LrKZODSwd1AEpji3uM8DvLLLs9T5Ps2wQKiKJQ1vFMrv
	ZhsEtWgMlmsBmlsOn1uzL7ZqKVu0AJJGuO//NFzi7
X-Google-Smtp-Source: AGHT+IE03KE2pSI4rTJDmqhEodHZuWeu+5M1Rq7LihYajBzN/AObneWDEFvxo2MFDZhDavivsyt/kQ==
X-Received: by 2002:a17:907:d08:b0:b3f:f822:2d9b with SMTP id a640c23a62f3a-b50a9c5b3a4mr2744828166b.9.1760513574611;
        Wed, 15 Oct 2025 00:32:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63bdfd73dcbsm2176899a12.27.2025.10.15.00.32.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Oct 2025 00:32:54 -0700 (PDT)
Date: Wed, 15 Oct 2025 07:32:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix comment for default scan sleep
 duration
Message-ID: <20251015073253.aqyz6dhgion443hl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251015064333.31274-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015064333.31274-1-lianux.mm@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 15, 2025 at 02:43:33PM +0800, wang lian wrote:
>The comment for khugepaged_scan_sleep_millisecs incorrectly states
>the default scan period is 30 seconds. The actual default value in the
>code is 10000ms (10 seconds).
>
>This patch corrects the comment to match the code, preventing potential
>confusion. The incorrect comment has existed since the feature was
>first introduced.
>
>Fixes: ba76149f47d8 ("thp: khugepaged")
>Signed-off-by: wang lian <lianux.mm@gmail.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

