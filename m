Return-Path: <linux-kernel+bounces-788807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5DAB38A88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB65361BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5E2EAB6D;
	Wed, 27 Aug 2025 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="opw7qt1N"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11762857C7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324533; cv=none; b=ACwsAkBfzDogFi5mxihjov2ma1p8p9GfLVqXuw/6Gjov5ifiCF37xjUswhQiZyomvZnCgNGR0mTBsasJqcZLhG/kZ6CzaB5Tjmy53VW5QQ0+aE60J5/zKEv3tC75qE2Y5EkhPbbz5Jv+OcpTAqt1yyAnXYdCeEBVfcvvBOlLS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324533; c=relaxed/simple;
	bh=N09Lggw+BrEhUebvMDbNZVCFYWU967lqapi7gcfd2XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KAuMiDTXfy8yMlg9Vl4tgqbylpLnb1/7h3ZOFdGBT7aVbbHLRTDHNkC1fbwe6hC2Gy9JYFTGr0Sk0z028+ZFcLBctCbvnKlNa+ViGEKRZj8CzddzqH/GRMcc3RFZBXfKLoW40qMAiyLXv1jIlH4fT3kbbOMNTQIMrzPE1wsc4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=opw7qt1N; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88432e27c77so10497739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756324530; x=1756929330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8MUZaQIYG6BL6uW/+MzW11iO+Nd9sV80O7ktOqXKopk=;
        b=opw7qt1NRQvuclajfZ9250Of9XAJs1f3vCgXtI8j10KdNTDwr4BfDVWMRtYSpEsYkP
         poQ6WN1s7ycRvhTaz9pakzJYcKd1Vm4Yajclrlu6FwZIwDNvktSU11iCBK1/qjCG765i
         zhgvKObK+wPuUr4tPBXLkmuLbPVyQvRY2SRIXPkHZBSks38uxOQ3wEX/AoYS2ItOmDGH
         5IAGfQpBY/3HVXpQI/OfiG0gGb5UgCsbZGkWV0Hu2kFjE5T1SMLUIW+37VRQqEKqL+a6
         qe9zotoiuYnddG7MhRQT4CepUNW+Q+Dvz0369eO74b1ZJIbdkXM96v4FSq8VT6c8ApY9
         Wf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324530; x=1756929330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MUZaQIYG6BL6uW/+MzW11iO+Nd9sV80O7ktOqXKopk=;
        b=SS5qvJurXscvw8GzyKrm1/fKr4hQF6gFa/S8uZvVLb18wUC/4BlVPVmyMhLFHEOejz
         EHMQNwUit4YAEz7sP8+4MPh/fVtpY5cWk2YtBnMEPAuMNV3+5XlVjmtnrzkVYmzuDiv3
         zl7TGSxt1PCgkEJvg5gC6mwDXHMdqcDb7LVsEhFgj01RJdv/STsefJCdnU/ZVFFT1Xpm
         8tVZjKaDPpJX8WWEqbAZmpowit61iR4xi27Os6lW9wzAcIqfGUxALlyPRAsPQent5U0G
         Px+GaohK8tgcDu7yRigyGTerVwDp8gsGbpQj7SFhjf/YMuPhw3b0gtUKcbOXD2UmK1i7
         Dugw==
X-Forwarded-Encrypted: i=1; AJvYcCVk6oDEWtkpV9O/JvM6Z+l4RitKm3etGVJ+vN3mRvpM3QpQKHJLSslEC6ALbwn65XmwfXnzu0b8ijVatOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztm5Lv6YJvVs2es/we5xPgrhgrq4uED5dUbJEHMtkWKylwHGzu
	E26wFAiT8b3MAlLRA59ewcQ0kvsw6M5O0fTgb8CmzbUL06w58mokYgYy2a8NMg8QFw8=
X-Gm-Gg: ASbGncuQRqFJycSYRRMrUL5LdIQAODYDrsuoG6P4Isf+fsTEKDaw6DDflJiFWfZeOzz
	5kyMh17H8TXzRmRTKQuSI9RlTzwOnobA8aRZJ94NydpdHqDOD2SAyoef3vvQd0N9e6EgfQngKjH
	8SfKIiRfEiDpdPMxvEa46rX5s4CeJAllNrlKzuEpTB8e4xGpkRckNNtCqLGF6/RNLZuvlRmZXhn
	542TJiWWI9SjiCulbgnMACqS2XSOzh07YIpMjV1sHR5gxmLvTCcoDhbBwn5ShQQy2PcXY+6vlp+
	xGIX1IvXt1e1ZfdPo+AZ3IDcaT/mDT1uU4idqD5blx4zASc0MWcrj7FhWyAlydxE7K1/LX+GQdT
	COI3uPXC6iWHolT1DKtKdUCacyJQFOw==
X-Google-Smtp-Source: AGHT+IEsQmmJ+nFf1MkiGe++IkZlgHN6eqs940thF8/gYFel04yO1dSdjxBZQMNe5eKew3zIP+O6Ug==
X-Received: by 2002:a05:6e02:1a0f:b0:3eb:8e5a:8fd7 with SMTP id e9e14a558f8ab-3eb8e5a9145mr192453505ab.11.1756324529861;
        Wed, 27 Aug 2025 12:55:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c191550sm97846035ab.14.2025.08.27.12.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 12:55:29 -0700 (PDT)
Message-ID: <1182267c-d291-47bc-8e5f-2e11aa93421b@kernel.dk>
Date: Wed, 27 Aug 2025 13:55:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] loopback block device on top of block devices don't
 work anymore
To: Lennart Poettering <mzxreary@0pointer.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rajeev Mishra <rajeevm@hpe.com>
References: <aK9c5jJepHEWIONM@gardel-login>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aK9c5jJepHEWIONM@gardel-login>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 1:30 PM, Lennart Poettering wrote:
> Heya!
> 
> Recent kernels fail if it is attempted to create a loopback block
> device on top of a block device (rather than a regular file), which is a
> feature long supported on Linux kernels, and that systemd relies on
> (specifically, systemd-repart does).
> 
> For example, this used to work:
> 
> losetup --find --show --offset=4096 --sizelimit=409600 /dev/nvme0n1
> 
> But now it doesn't anymore...
> 
> This is on 6.17rc3. My educated guess is that this is caused by
> Rajeev's 8aa5a3b68ad144da49a3d17f165e6561255e3529, which tightened the
> screws on validating the backing file's size, which now fails if the
> backing file isn't actually a file, but a block device.
> 
> (But I didn't spend more time tracking this down.)

Yeah sorry about that, the problem is the followup to the commit
you mentioned, and the fix for that is here:

https://web.git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-6.17&id=d14469ed7c00314fe8957b2841bda329e4eaf4ab

and will land in -rc4.

-- 
Jens Axboe


