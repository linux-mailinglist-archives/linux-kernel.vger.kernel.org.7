Return-Path: <linux-kernel+bounces-770803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7EB27F19
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5308FAE07E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A314284B42;
	Fri, 15 Aug 2025 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="TBLGQSg/"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995321422B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256776; cv=none; b=TKuAVWZEHde+5n66FR/p9gVuAgSA3UJCrWhA/9fyTLPcKs2TVZ+c+att4tCPkVwi8b+xymIGw9USg5ZKmzieLhdhvxK9PR+cU5Xt1ZHIyS/oAPSI6qnYvNvOVHtGyCxIvd8nGJWysMTRZvzbRf+s4LNbAdSUNeXYXimqpu/jL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256776; c=relaxed/simple;
	bh=SFOGsfApj3m7tLi8W16wuymY20wy2ewxvGInLEa/+1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbmLRWIfEeu0yPbiKtsADX5e3CWADNlBoZAgY057TUlbh61DvfawSmFEij9MfNn+YYF+gXulV8SbDlwaBBGxzOA42v4X8GyupzDBI6TG0DEMmvSHPsSTeRPn3xbYxkCUFcbgoFedD0fztCZ5Bx7VLXNj23dsXrp0eAQC/LPnPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=TBLGQSg/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0b42d5so13289665e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1755256773; x=1755861573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SFOGsfApj3m7tLi8W16wuymY20wy2ewxvGInLEa/+1k=;
        b=TBLGQSg/vYx0hYygCYxWxL44n8B/sNpjwHjXDSKKSkS4HK2fZWZEzyMyTV/40liHo7
         Gdc0ITaZXB+zyH/iHTUxQ/QvWUbazXEJDjz1KYlPKBpsFUz1ztn65Kd/gfv89k5TT3Pi
         OmLGMS94dYIgGqD0o5euLJyt/KQltbLgj17Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755256773; x=1755861573;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFOGsfApj3m7tLi8W16wuymY20wy2ewxvGInLEa/+1k=;
        b=fBFDocD1ywC4tYf/DMbJgBYf6wQ0dBu302GeL6+zLCcqJnfJGAmb6VOgB+v96DVnU7
         RTGoaSUIcScS9vIpbSMRLzPUBZYCteqZyIQ1It8OrtVgdrKzvAiskEVlPScWKXG9Q+Iy
         xgObqO8jCd92YYJIyEwbNfziQohAxJRCtR2YtVPW7mnNcialqwKhFeXURZJ4+6V+WffM
         D/+tmAiFXevAy5iXVokMi98Uqooy2gsTO5CAyGVi/ruTIC0T12MUYpR5kG0HHdDUm3x6
         sgQJ9/jBepEHh/IpFI1qW4PxSaKeLNfKMzpSXmABD9SGy3CvZl6hwT744ZF/xOCLSwJy
         jE0g==
X-Forwarded-Encrypted: i=1; AJvYcCV9fEJFqAoMgWxL01mhBqkYITNKwCA4bdaGCh+45J+Rq5WB30kCQ4yZ/cv9/wNMGN2iXdQasiRfTUVxL7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/DiGZ0+4XTAdqOOvCqwbLZmblkOA0J1F1szxolxcnKAPJisTy
	a5QSkVpD8kcfOR+70Tvf3qcx/zkBJAHXA+6Nc9o6H//Ij0+QTZovXvPO41NsJSU9l9M=
X-Gm-Gg: ASbGncshE+58JOkEYAN2+Hp15gYL/VYxkh0sS0ElIUXLE03VKWr0uNxGN3QsuULx838
	2+O+Syypf1mrdzEt2/GaipcZ94PCMoFKB8b357ENTFFSe76zrf6j8VrV+cSkcNRl1XR1xsMcybm
	oqZsfq2bS0s1OtTHPpsmG/DnsBmkcP4JoRiGYY6N88RL29ltFgEtobzL/lXkmuMbhNWD6aeQ3vy
	eqCiJpc7OfJlelmHJwCZV11kO95Xh5nxmM875SIMzYRfZrWdE4EPNxMX7mg7ADczmYdE/SLS2R6
	+Y5gxKWM5W56oOWNbn3xLKKh1Azh5/9wRR2soPs4CO3qwBQpPqkVjD7oGubBZdPWKYBeUOot25K
	uNz9prIrFqFGWfkob1FeHJEk+fN+XAPoBGxebAo/g1RIkusPfYIQbuoIX7+2PS/E0t+PF
X-Google-Smtp-Source: AGHT+IF0HTkasnS4/M41g0aTTKVxtsg6ShLztfrp2dNagcRX7J/4es6hEzpRibi850A7A11vs9cHuA==
X-Received: by 2002:a05:600c:19d3:b0:459:df25:b839 with SMTP id 5b1f17b1804b1-45a2186e2c2mr12685825e9.33.1755256772938;
        Fri, 15 Aug 2025 04:19:32 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2232fea4sm15295815e9.28.2025.08.15.04.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 04:19:32 -0700 (PDT)
Message-ID: <055f4c2b-0e7f-44ae-92ff-a1025a217208@citrix.com>
Date: Fri, 15 Aug 2025 12:19:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
To: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kees@kernel.org,
 alyssa.milburn@intel.com, scott.d.constable@intel.com,
 joao@overdrivepizza.com, samitolvanen@google.com, nathan@kernel.org,
 alexei.starovoitov@gmail.com, mhiramat@kernel.org, ojeda@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>
 <20250815074939.GA3419281@noisy.programming.kicks-ass.net>
 <20250815102839.GD4068168@noisy.programming.kicks-ass.net>
 <20250815103055.GE4068168@noisy.programming.kicks-ass.net>
 <fc0715e0-42f2-4b5d-be31-ac44657afc56@citrix.com>
 <20250815105908.GB3245006@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250815105908.GB3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/08/2025 11:59 am, Peter Zijlstra wrote:
> On Fri, Aug 15, 2025 at 11:43:11AM +0100, Andrew Cooper wrote:
>
>>>> I've had to use cs prefixed jcc.d32, because our older toolchains don't
>>>> like the ,pn notation.
>>> And then I forgot to move that cs prefix around in the bhi1 case...
>>> fixed that.
>> Dare I ask what ,pn notation is?  It's not only the older toolchains
>> that don't know it :)
> Some fancy notation for the CS/DS branch hints.
>
> CS Jcc, decodes to Jcc,pn for non-taken
> DS Jcc, decodes to Jcc,pt for taken

Ah, thanks.  I was looking at the hex in one of the comments and still
couldn't figure it out.

So with this notation, we also have the dual meaning of ,pt between the
P4 and LNC.  At least the encoding is the same.

~Andrew

