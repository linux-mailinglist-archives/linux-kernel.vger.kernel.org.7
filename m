Return-Path: <linux-kernel+bounces-774593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78053B2B4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59071B28279
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FA82765C1;
	Mon, 18 Aug 2025 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cjl32QE3"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698D17C21E;
	Mon, 18 Aug 2025 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755559596; cv=none; b=b/LXHhK8pygaDsnmHW0Buu2VUSycsRzXWY77OMo2PAINo9ts2QDKkzSIrJOBqAqyIqvf3tNfxJHOiOZqi9ClO3rYIBdN+5U9NoUebWq34VC5olDlTjtpg9+D+D8n8OuRw62x12otd1MlepDkQ80HuP9nXQdfSaOkGJGXTECtyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755559596; c=relaxed/simple;
	bh=vIQVUFpkHlHTktm2VZscii1zbtdM9hqJ5/cIRLEwWNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNISHSobrmRc4c7tnkiBoTmHQ2kFlsQv+3FwFx+D9FjZLOdkzK4hxbq0DDUY4eWbl+zHzEbfzzqkeP9+zkzeMtW9b0+aAIYCyD7rdDiMRYVzzwyIq2DYFVJowHh0A4eqJ1kPAEUGnz9DD91EvDMCat5eMkb48PzIhojXFZN7LDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cjl32QE3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32372c05b79so1413065a91.0;
        Mon, 18 Aug 2025 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755559594; x=1756164394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9HFLqyMWB6ZtOQpT++xU0p6HHSfeFmkYAKgATP4ya8=;
        b=Cjl32QE3FGVgfM0lanyMrTkBmU5Uu4xNF7+MDfg1/t7NEuCtD1tMCH5J5XqW1lGfka
         PzSTxKFUAT+aeeNPacB5g6c+xjamupSovoadZWJ+DE8CCkJEj9YqQdIaQM+he+nY50Y9
         +P/Ts1oX8409gvfKLsTiU2cDr2Qb8mBWfgcDG2X9W8S9pkZ1JuTxJ3GqFWj4k4eimzdN
         VvaAHXtLilYUqhv1h8Np3NAvx4wJfRVxKKZME0bA8VV55xMN9alv7jDLYkiqAJLjBcCX
         +MBvXu3A4YSrBxKtnroTHZkRxR/NNMd878Z7J7KYi19U/iSxFLwT36CaQ69wmLN8ytBD
         t3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755559594; x=1756164394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9HFLqyMWB6ZtOQpT++xU0p6HHSfeFmkYAKgATP4ya8=;
        b=R7ZIPrJwmpBcoKfkvaiUlcYkF1095rJzRZS46Bohkf+X9CeILaoPS7w31Ovyew4LAA
         aAt0jpxtCCmzjYHi7ZIJX3F9SUazHOykX47F0dbl4gcmUjx+fYg2DK4hsSqg1V9mrIJQ
         GxO1uA0r3HH0sLldNVMmH1/D/+G6BdIqt2FIsD1yga04o1kQULxXuo6cEkFEkiOYVq5I
         1x/FEM7XI6GZ7LZXldRm2+6MA9ZO5Y4gRYVfOy9vTTmUgHhBlEgjGQ+/zQ55sSceHm5H
         7xPF7mp7DCQeAgLM65brb/k2F5qE6d3jWcdz4y+9Sa8oqLS/iPK9mZIjUqCN8xpG/Jws
         QNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyYoypL+q27lnRZjImFQMEdI895qVxIKm+e8N5wN2MzDqIlpAsIkAf951T/VWQ3jsB31LSpNhUxVgIaOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeXp6uA4DTYzsJhhO5kWaQg9nP40NHo/wFHO0HSyLS8DTKS38R
	pUgDLADf/8Kp0LBbjJL6HmZMl7j+LHhUiEIlc9XopH+ESDeGpKr5jqgUQE2ahQ==
X-Gm-Gg: ASbGncu0yIQ2mB54m7mtdRROXxhaS0SpAHq5gGPB3StUmXqeSCyv2RQh1MJBgz5lcVF
	wVn0bim2CVU5EyX/ftlb4vBQffUAHP/zs+i5TdFtLn9XaZWCtaJjQOs4OhyTiJKULo/CAq3gone
	4J3HdiKBXfJf7eKSdNaWa7cKskr4ymuJS9GN42A32K6iIb74J8S1qqJoNRHNT5VcQ9wNJUub8mm
	+m39s/L5GrQ7VZMp4OCvzOvInvaeKJeBP64jQ2730Fk7umPZNB3KdJAUzj3niQrIU9/qPjinXyQ
	VCyf/OA+I7qaz724Zn1tJCRbQEwogrBy9U4HlL4hUAbgBFl4oetGfKMUme1tD4bCtjB1lVEPFsc
	fhM2YyXxYuyuFsSRktXbGnLJRP2INdVuHa2B0TWtOGB9RJPdm1di1XyIFaXPnBCzrr1nS
X-Google-Smtp-Source: AGHT+IGMzEXRX4WY6KqP6P7RfYwxUuHW4DDl6KrNKn3KnBc0FOKhItkWyiuuKjmeK5U5eg54OOI+bQ==
X-Received: by 2002:a17:90b:3d02:b0:31f:762c:bc25 with SMTP id 98e67ed59e1d1-32476aea6d3mr851024a91.25.1755559594305;
        Mon, 18 Aug 2025 16:26:34 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e4040aesm1001179a91.25.2025.08.18.16.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 16:26:33 -0700 (PDT)
Message-ID: <16b48826-6634-4ec9-86a0-7ddb59ce3bed@gmail.com>
Date: Tue, 19 Aug 2025 08:26:31 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
 <20250817133606.79d968ed@sal.lan>
 <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
 <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
 <87y0rg7e35.fsf@trenco.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87y0rg7e35.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 11:07:58 -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Ah, I have finally understood what 5/11 is trying to do.
>>
>> Its changelog mainly talks about an issue you saw after adding options
>> to xindy in that same commit, and you added
>>
>>    \newfontfamily\headingfont{DejaVu Serif}
>>
>> to resolve it.
>>
>> Current changelog didn't make sense at all for me.
>>
>> Can you please reword it and make it easier to follow?
>>
>> With that, feel free to add my
>>
>> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> 
> So, if I have managed to understand this conversation, this reword is
> all we need to get this series merged..?

Well, after some thoughts on the conversation took place on xindy,
I think I have to withdraw my Reviewed-by: tag.

I was the one who was totally confused.

Please disregard it.

Mauro, I can't review on 5/11 unless you provide me exact steps to reproduce
the font discovery issue you said you have observed under debian at 4/11 of
this series.  That is, without assuming your other series of build-wrapper.

The build-wrapper should be upper compatible with the current way of
running sub-make, without any change in conf.py.

I don't think this is too much to ask.  Moving both the goal post
and the build script at the same time is the wrong thing to do
in my opinion.

Regards,
Akira


