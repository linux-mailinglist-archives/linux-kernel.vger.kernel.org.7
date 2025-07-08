Return-Path: <linux-kernel+bounces-721831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E0AFCE4E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF7E3A5035
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC82DEA78;
	Tue,  8 Jul 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBKBZHPE"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C121C9E4;
	Tue,  8 Jul 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986565; cv=none; b=niHqOVV48JSa2jvHIH7xXUS85NkEw83lUD9CAiMUPTjOFgsLvREM+7MqQ+ZC+7dA+qlTcoauDVXBY7rouHObAHwJdrl1DUTnNLMRxWHCLsOS9S69jv6FWFBK2VXU5XQcDOIy9jHPFl3scsSFQlFGaJa5nzSgYzeCpymTj/FkzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986565; c=relaxed/simple;
	bh=QvcvBKdOqvN+FdtFM4i8mXL4RHfEqu+iCKwDwsYIHE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcEay9TgEySjIeqfbEA5qxiKXiTBOAiZYbzUDm/WnoJKuvJgA3gyAQfEcRhYv4gho5tUbqMvpDVHSlYA73EPYzYIEns/zLiTsOQfCzIswPtdV7WdKaEPud3W1QDRhTq6+b5bsD5latezdBZ0Ge2JNUSjs/Ubdd954GNRZyI6Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBKBZHPE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167b30so45093495ad.1;
        Tue, 08 Jul 2025 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751986564; x=1752591364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QigxD5Wv/KUlCgWSFremf+xJ9wVBD9RM+HfTWagLkck=;
        b=UBKBZHPElzKR3+Qt44i/caxvFs3nitDvgxjhjI84CoQOTxdESNxf57SKRJ/i4Sa1eX
         rIu49oC6mP5U50kPjkpMfQ1z1GIABskcyUkmJNXsSvofmVjff/GzVM80L+djQePPFFIC
         j0n7HIDi+vFT78/66HWc61kDiEDxY5KknlCNXPpu7Ih47LYL0dQZVXjtC73g75PHN5ks
         0Eipw7FmiskXUmKpUPw4Upfhmpf5N+rvkbEMskZjw9jPspsdm8tlbWNwdDGpLQV2+oCf
         p4MYL8VvfnG+6EgiCeQyhF+QZbfQ+mKs1VUkBjtQ8WWBfy45UgNL0c8L5xLMl4iCgW+5
         6xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986564; x=1752591364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QigxD5Wv/KUlCgWSFremf+xJ9wVBD9RM+HfTWagLkck=;
        b=ReH7FvZBmN7kD0U8ru4SzWdKZyTCDTJC9h/kzoQasYdyWAKSzsXwPbsXkL1L+mWd28
         u7KFayjqJbdmRqaGi1+d8ZkZz3QTc9N0FUFGwicgHS5J554B09BEoCszzubG9h4SCsIa
         qteZoVTVgyGZos4I301gwt62Jgx7PhCM0Wdd5QYOqVVIoE23yjak8NxzqOeOgd+k5Z5+
         HbIj4/w6BmuD8koKFZf/NbAb5C9WtL718tZsQazuXuwT/jMwa1l2/WYTp/HHJHUwDnCA
         71eFS3+PTAV+NK6qdnQ2qlJ2vzVoXiiBxoCUv4KtXODOVqmP0LXKXS9iodEJnUYLICHF
         mjyg==
X-Forwarded-Encrypted: i=1; AJvYcCW6CLaf7E9urtGgoIz3+/R4oHd7j15WLD6UIBhYIghrJ+coHTUvb5fO6eWN4elfVeGu1PE10mmwr6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvZiQl1yIWDhnSja4kKEWaEexaON7sdHWc9uBrXAME1OGxm/S
	oFZ86sgBs2dtW8IFbJGrygh75gkKeoLcSDLMQop7WQZXDTAJAjmPfP0EUFwSnA==
X-Gm-Gg: ASbGncvmeSEGkIosdc8+CwZI3nVaCft4NTg5XRj7hlFsZ1VBzGLstrnZVc/X8rIu6N2
	dkJBX2CQxki48e0287N341xzypHWyQBJhdahvV8a+8QQM0Qf2HEQ4/wT/tQ9nX1iQZ6MeVMsQQy
	hXoAI4QfdFne5mRQS//xq/6H3XZxwpA3L0B+ifEukusj5RDapbrE6134FxVGaImkxK+sQ2qJx3f
	qV2//EoLruTRzMUL9qDnpe9APkzL1XASDORi73/VkS8fKMoEcJ3gqgGiei50h8RI7eWylVAgE7t
	i1nuYiaBNa+q8AJ1Nd4E2WyyUL8Zg6h59a+UN6zLLjwQQ6gOkEJUNTZi5q3flgZfd1Nmobrqbfa
	SIY6cil0TUfpA11kfPS7cjAZ6vV2GMbeb
X-Google-Smtp-Source: AGHT+IHaAv0J975M7rh01eFOjJsc2Am4egwF+PFq3Rt5RGei9oC1sz39Liyd+QdzD80HzituvgiK9w==
X-Received: by 2002:a17:903:27cc:b0:235:225d:30a2 with SMTP id d9443c01a7336-23c85ec7329mr209536735ad.48.1751986563698;
        Tue, 08 Jul 2025 07:56:03 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a381sm111621565ad.20.2025.07.08.07.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:56:03 -0700 (PDT)
Message-ID: <9148ae7f-7954-421e-b5dc-366651f0bc48@gmail.com>
Date: Tue, 8 Jul 2025 23:56:01 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Translate sphinx-pre-install to Python
To: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, Sai Vishnu M <saivishnu725@gmail.com>,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1751318230.git.mchehab+huawei@kernel.org>
 <d37eab74-a034-4be6-b92b-e0da60a99477@gmail.com>
 <87bjpu69q3.fsf@trenco.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87bjpu69q3.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, 08 Jul 2025 08:25:08 -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Hi Mauro,
>>
>> On Mon, 30 Jun 2025 23:34:48 +0200, Mauro Carvalho Chehab wrote:
>> [...]
>>
>>> The test script also ran the install procedure for system,
>>> venv and native Sphinx install.
>>
>> Which install procedure did you test?  The short one with the "--no-pdf"
>> option?
>>
>> I am asking because installing the full list of packages in podman run
>> of opensuse/leap:15.6 didn't complete successfully for me.
>>
>> And by the look of things, you stopped at installation, because you are
>> well aware of all the issues in running "make htmldocs" and its friends
>> after the install.
>>
>> I assume you (or somebody else) are going to update the script once this
>> series is applied to make the suggested lists of packages be useful for
>> newcomers.
> 
> Thanks for testing this out.
> 
> My question would be: are the results somehow worse than those provided
> by the existing, Perl script?

Not at all.  Mauro made some improvements WRT opensuse/leap over the perl
one, but there remain a lot of rooms for improvements here and there. 

I've been ignoring sphinx-pre-install all these years, but the impressive
test results presented in this cover-letter made me test it.

>                                If this change regresses things, we
> obviously do not want to proceed.  If it reproduces the old behavior in
> a more maintainable language, then hopefully it is a step toward fixing
> things in the long run ... ?

Yes, translation into python would help a lot, I guess.

        Thanks, Akira


