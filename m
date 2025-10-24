Return-Path: <linux-kernel+bounces-868960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C63EC06961
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517E23B9110
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB631E0FD;
	Fri, 24 Oct 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hot0rH70"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456153195FE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314143; cv=none; b=J6LbZunUocQIAhmPZb3Ak9vAW5Z2Uv8lNGsM0D9/0x53GYZovLtGu2rJTVN7VnKba/ZItpKW6b05ViIrNwJY7oAnBaWnuRvmRsdm6W+4TkHZIPbiR6tT8SfDJX+bd0cWeaLqT+SR9tiPTprdM7BgNJR1qBRSZP0gk9bin3MRMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314143; c=relaxed/simple;
	bh=cs7+9pN+rGw/+2yYuwe+XPsHIbqSVHW2OegdM5KybeY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TfjlqJHV1ZCG4ZHJHSX1UeSsGtNyOyuBduO0JTm/jzpdUfhh9Z5Ea5QyxFgrI47fo283Tw5iqvmEqW4vZu9tdbcN+ZYlSjEIpgQ70/suOgrNyvXxsTFQoC5m0slF5josYl8pw+WF5I9bn+xqdFQ4i+q5vqiGzE5iW6nmU+FLklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hot0rH70; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so1533066a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761314141; x=1761918941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1mmYFOWJrmrd7zF8oo99zQ9GonVE6sUpTh9fiKeIIH4=;
        b=hot0rH70MZNE5ewIOsgaLPH0ulUB2PgWD0NyzsMGk9Td0hL+Wnl7lYZiz8yisCqBQu
         FmJ0eUpaFlHxJkkhoIPFjY2ebhNRnz3A3AR9Xz444HboDuDcGaKBokC/eUxO7g+w0cWP
         01TeHHl1loIab8M3wz+vxgN10Peq3OSh+lUXQew6zVFbXIPI5JC650mO5OWcbjrY7Fow
         /W1+frKVcYKpOmdbH1wuoWjjAmFf6nZGJjwHK1b8ndhIqWT6O+m3FbDHL9lXORcld73x
         gRpDppG6Mrp5xaZBNJDdZHKaFD+00yQ1fIzAUXLovNjdA4XIkMPeEw3FA2BwDypht0ge
         Eo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761314141; x=1761918941;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mmYFOWJrmrd7zF8oo99zQ9GonVE6sUpTh9fiKeIIH4=;
        b=RSSBe/xRq+ChtBtriPWiMTt5rn+656u2hQxvtzvEGA+/Wyaxtjg3QkYiih6eJ39JDL
         9Zhix3iVIVPxk5j74V6F8rMayMzz8mLNLRUqRS4M4/dfMu2s0+7MJoIkB52b74+AX5Q1
         UWJ1NI04DEPDV4aTHUSH2Mo6QPCNBmgPlToaU0JF42c5GuNod89F1CPDSlEliqnE/UR2
         M/WUV/ZiGy9SjyFYtK6/LuP4U1DWJUCogQ1kjMqJHIWGBqXVkcnfbF1bmdDOT7jkaqL9
         TYCHGoJbq7+2vLULXYighdjgYOsekaRfagAlxL+iJo8VPPoB3gtdbFNQXgzCr79INhua
         ntSg==
X-Gm-Message-State: AOJu0YzzLmgTAi3O8S3wYo/jIcwodx56RhipR0mSusxDUY2sC2SIWM14
	CHBnnIetZF+jGiMwdetY2lWE72J7FI5iIX+RHFuWfgmu/5MeQ/g0Buhv
X-Gm-Gg: ASbGncsydRbZg3Q1TQnqwRW96YwA6BS1HRtNPeunpqXYMz+s7jVvymmp1gv04oI2Iud
	D8iYKALwWyLPcdfEciaZMdlaMp1xXiq1TIjwlvRtcwrbfxsbAPS1+2G2KlOh63t6AMPN1FxwTF2
	omtxDKOK0sSLzADxWiVU17do7VlCbRxrg4l5hbTAcrvT9iNc7wpDDEtX5YH6ZQk+tJruHdR2p8N
	Yp3spRnOdpAZ6WuIB3kU9eP71b8xsKnjPUDEdDNMac4e223TsKquZiSiWMrDq9Jy8tDmo2ILLwI
	rwSo1Cb96UXNU4aqVXsO7WmC6+iGEyN+rqB7OnkChkU7Z9N1dHbUMR2AXN0v/mEJXwMwj3H0tJG
	47rcWpQmRMIwOwmjaryClAya3FL74Awrtj0lg71ePAQnSdZrQtYMlsDHsTWbYzXlV5izMi+nBR0
	B1XInQkDbBCcs7ZLLb788w0zyLZcLD9CkCcWN/gZWL+fbBNw==
X-Google-Smtp-Source: AGHT+IH6ZQ7XsgdLNzrpkVSTNHlrQvhfuOh+1KL2rQ3hQUg/UjKwCTfpXsYF5GGeZ2uELik7ETl8ww==
X-Received: by 2002:a17:902:e944:b0:290:a3b9:d4c6 with SMTP id d9443c01a7336-290caf831b6mr365592165ad.36.1761314141359;
        Fri, 24 Oct 2025 06:55:41 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda72d0sm57293905ad.16.2025.10.24.06.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 06:55:40 -0700 (PDT)
Message-ID: <123ab038-39b8-4632-9090-2c95cbc0130a@gmail.com>
Date: Fri, 24 Oct 2025 22:55:36 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Collect documentation-related tools under
 /tools/docs
From: Akira Yokosawa <akiyks@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <20251023161027.697135-1-corbet@lwn.net>
 <532dcafa-08a8-4e18-b904-53e061734b69@gmail.com>
Content-Language: en-US
In-Reply-To: <532dcafa-08a8-4e18-b904-53e061734b69@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 12:10:54 +0900, Akira Yokosawa wrote:
> Hi Jon,
> 
> On Thu, 23 Oct 2025 10:10:08 -0600, Jonathan Corbet wrote:
>> Our documentation-related tools are spread out over various directories;
>> several are buried in the scripts/ dumping ground.  That makes them harder
>> to discover and harder to maintain.
>>
>> Recently, the idea of creating a dedicated directory for documentation tools
>> came up; I decided to see what it would look like.  This series creates a
>> new directory, tools/docs, and moves various utilities there, hopefully
>> fixing up all of the relevant references in the process.
>>
>> At the end, rather than move the old, Perl kernel-doc, I simply removed it.
>>
>> The big elephant lurking in this small room is the home for Python modules;
>> I left them under scripts/lib, but that is an even less appropriate place
>> than it was before.  I would propose either tools/python or lib/python;
>> thoughts on that matter welcome.
>>
>> Changes in v2:
>>   - Rebase on top of all of Mauro's changes (the most painful rebase I've
>>     ever done, I think).
> 
> I tried to apply this series on top of current docs-next, and several earlier
> merge points, but haven't succeeded so far, even with "git am -3" ...
> 
> Where am I supposed to apply this?

OK, I have finally figured that out.
This can be applied on top of merge commit ee9a66919354 ("Merge branch
'mauro-pdf' into docs-mw"), dated back more than two months !

I suspect v2 is not what you had planned to submit ... ?

        Thanks, Akira


