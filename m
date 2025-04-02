Return-Path: <linux-kernel+bounces-585679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E4A7960E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 21:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526731894DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 19:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AD41EDA04;
	Wed,  2 Apr 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mjGutCdW"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2FD1E8325
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622931; cv=none; b=G+lozXPL7mPOwgY3odmUicDD2xVCBHzQV2LdCaLTasTWF1kpNWPySf2ODg8gVIzN5gP8i7PcDvfqdP5MwsQNrIfqTvJjvChE4tnbq+DliQMlSvZDHQ97YKAhZBCd/Cf1WrQpEALTixYv9+l9mqA6ys3Dx4DA1mTFz//TVVKJuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622931; c=relaxed/simple;
	bh=CM9zmYJGZnZs7kUAuKyeUucWwmasrOdVlk80HRPRmXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3tPFn1rixrbEoE4Us7dnEMDy3qvRyVBKVogJTbhoxItiplIKLkmw38m7Q0n8cuP7kWVcnv/jUWebHapamCHr23Nxth8puj/iGMD72x7fLUc0KIZxKAeI5GpPDGefoovcd2hm0rus9+cJkjNsRw0CjLsbd5X+9AFFQRu/z/JBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mjGutCdW; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85ea482e3adso38977539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743622929; x=1744227729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmmFPo/oQkKrk4qBgcoqHzb2/uLFhooznPACRDehBps=;
        b=mjGutCdWx/vpT3zcs4xlKVwftBZLLYUjFB8ETGKGbiTpIyPG4ltBg41p/2Seug/uw8
         SSN+cdsfJQr4FIjwWnnaZGd3Hp6b+/gILJfTRMBA0fTDmeh5rEKKhTEJ/Ns9TqcLZ1qb
         TnIhWFX+hOhoY9zD170sN9y+6FLVTUXNEOMOaqRaxsxqztqtOyXf3YKzvC5MXH4Pq5Jf
         xofadt09KeIwUNSI4acWD46SlLb7bEfzdNp1wfqq0d2ZKiEtb+A5ulV3zN3HgavfzjHU
         MgSFX/8Zx3F6WL02PyuhHJVAl5lJ+0sKoHf3NC/T/DKQiHccHggthzlGQtnAfoEPbKIG
         OYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743622929; x=1744227729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmmFPo/oQkKrk4qBgcoqHzb2/uLFhooznPACRDehBps=;
        b=CIanz5mPJaO9Jkf+uh0mSxG1okta8rVphUnwvEKorbEFawJna6/vwox7nxqDPsx+Fg
         CANJ4AS6B73VyuYuXrVpMvEAcny+4pbhim4kRaR9cu4c8TD/z0rz5W8d0qfrxyj9On/7
         7jAWf+X4ANTsdM7ctcaZKAKMRCOZkBKfbP5WHF4v9gvBWto1Uvg4VLnm8GoPtalQ2m/i
         U7shkfpVqgOKhQLnlBo2Plm+7DKo4gOqFo3TT5PUF5bJ3bYecJ8ATkO4hpjeyMGK2o6B
         o2+HJHRWC0xQoMDSFPVYqla1hYQasxtz/lQt1+EVPz37LnCwGjqTFqIF3lDS+qif6eds
         giNA==
X-Forwarded-Encrypted: i=1; AJvYcCXpRXQuNY4jtAbQHvzBlqcRoJYBgMtj2puzgAFdmxmLnUWmguELaOTgI5qB9LGwHfL6PJZV5zuZK6C6yhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5NQabRq9yvKlnTzTLXPIvVHcdkEOvBWHVWd6ea54VsORZ5K8x
	ppMVg1c9zTajf2hJJfadn0ZSNBCynWnL6nFtb6248VNoHr/JM4FDN5RagteDz+k=
X-Gm-Gg: ASbGncu6uXvVo8t0nYhAI76X8zp9OQOC5KcB9mNw73Q/SAvQPaB4QfKSiJgBLHsF5Bc
	jwNy9HnVm8qoaHikQEbTSxcYp40pflo57Knf8Lltim95XUXyVpuSjD4W8jLQIUgP2X5q8/95qqB
	2c3EAkq5WC1AW0A+rZKMtRIbLZ6ggAjPX8Swq/ErkYHqPwqZbGEDFiZ/ZrwFIJ68HRp0S2NvL5K
	KYdK6hRy86hcsKAU48kyl8NglPJiGz/a2P2n2gw+X/647Lieyhgi2c03lP4/LqixdAPGdaxXbTm
	aI+sgrKYf9aOmeJJcCRXF3Rb+3OYegZAZitQMRiY
X-Google-Smtp-Source: AGHT+IFq7nqGwaJTgKFWpd26u7TsGGXL3SChIeP/K+8QvIyMmdvg2/SMiNKjMYbc3aJMTRODTVLpEQ==
X-Received: by 2002:a05:6e02:12cd:b0:3d6:c2ff:eee2 with SMTP id e9e14a558f8ab-3d6dcb7c764mr11873895ab.6.1743622929047;
        Wed, 02 Apr 2025 12:42:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f46475107dsm3065158173.43.2025.04.02.12.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 12:42:08 -0700 (PDT)
Message-ID: <03f61a5a-15e6-4096-8b2e-5d09b741cb1d@kernel.dk>
Date: Wed, 2 Apr 2025 13:42:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: fixes for selftests
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
 <174359956539.20480.17105268115889494986.b4-ty@kernel.dk>
 <Z+2RPI1GC9NoE/w4@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z+2RPI1GC9NoE/w4@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 1:34 PM, Uday Shankar wrote:
> On Wed, Apr 02, 2025 at 07:12:45AM -0600, Jens Axboe wrote:
>>
>> On Tue, 01 Apr 2025 14:49:07 -0600, Uday Shankar wrote:
>>> Fix a couple of issues I saw when developing selftests for ublk. These
>>> patches are split out from the following series:
>>>
>>> https://lore.kernel.org/linux-block/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com/T/#t
>>>
>>>
>>
>> Applied, thanks!
>>
>> [1/2] selftests: ublk: kublk: use ioctl-encoded opcodes
>>       (no commit info)
>> [2/2] selftests: ublk: kublk: fix an error log line
>>       (no commit info)
> 
> Jens, MAINTAINERS parsing didn't add you to this email - I had to do it
> manually. Do we need to add you somewhere so you get a copy of all ublk
> patches (since you maintain its tree)?

It's under ublk, so it should go to linux-block. That should be good
enough, I'll see them.

-- 
Jens Axboe

