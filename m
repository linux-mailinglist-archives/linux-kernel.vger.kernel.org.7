Return-Path: <linux-kernel+bounces-843648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D984EBBFEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938AD3B8D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5751A314D;
	Tue,  7 Oct 2025 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErQo/FqH"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121F129A78
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799797; cv=none; b=T+m4qYfCDfSsfriIAstfqdJRG+gA4DkX7jDKVW+BPGRUjprm/JoBDxIEGN2DRuNLNCwAknmNx1nr/DZawrJMshXQOVFPVvrIfczArhLefN5XOw3tcvfeoqnZauPyzkaBAmROju4mIEUgu8+A+3agMJE3ocCwcehTSHtZr+4eQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799797; c=relaxed/simple;
	bh=6X3DsoXCXLXwSW6LHDG0N+geOJvq7dJh0/ciZA8oLKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbTNOv7ABW4tGO63ziDmWgwc+G5V0AJYoxY1SETyNFJMBkYpqgdOk0AuoHc8BnSpacYmPqvI+rQPgCn1aEm8Wx2cvXAMuHS1PkyL3YtDhO6wAjgai0Ehy0Sjwzeth3rysryITtqNRSJz2VcIPo0Gd/Me4PTqGVZt2KBqFW9vJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErQo/FqH; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5b59694136bso3720017137.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759799790; x=1760404590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghdf9TZNa228GXUapeik3l8BFyhmMAug+7tiKuSEW3w=;
        b=ErQo/FqH7+i48DhJx3rzDqaiFbPUfikgFFMgJLsb+kFM1dHWp9NJIZSrNPs7U30gCd
         l+9UBegU66SnEd3r1eG0omCSCut5nbBSOohIJi00BEJsCh5DdRJVclbof2QHd/6qMlOa
         hwgnZH/Sa6LMIrIxeswE6+ZgTX5H6YOy4PMtrpBs42ujRG3BfsskZ2pb7MTFK38BYPTK
         X/s6/Rg+APgILxm6p/oRWjEczpC+wW1/46gNwvXHGs+UU9wVO14jFN/QrbW1eT1RjRu8
         eKsgIPSFzkW5o2i+XJf9MfQfZC9aS2cCpdLv89Nxfux/VpTfSEi2goMn7zfBT/lKnx6O
         +XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759799790; x=1760404590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghdf9TZNa228GXUapeik3l8BFyhmMAug+7tiKuSEW3w=;
        b=bOuw8dj2EB0Q/H+2UMl1joKrNuKNM1lYdvT3BC0s3nTg5OuUfd6UMFAUt6ojzDcFx0
         jwJcGCRuTgyS0iYouu2DlFHrYYPppiTJS5Cl4/xON8P+qpp6FTSY8/8fc8qtUYRV+xqq
         AtAIf8Dy2LhLWk5Rqw7NF5ms/5cyuRDlWjVgJvGB1q4leXshEESh7vEZUPbWupSk1Yau
         EC5jZnAbOrr4xMfXqNut/0JF8gOn3HQH0vb6ytPvKnDpHggnIbPuDma87p2S3RVSGu+V
         BX/Vbi8u1BD0+6T2sDTSv9knijYcdQucBxf1rufWOjMv9Oj60kyfavnhzQs8Gn/Jqrm+
         vlsw==
X-Forwarded-Encrypted: i=1; AJvYcCVcHTToub/AbyKB+LV7wOruN//ajq37+w/ji6qi/AiU2nQJvWd2DhUHFMCurPdb1SA+l8UWDy5diQdgXjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+KBJTs+KaoHzhOAGxOkuwPtw6ag2iCKRZw745PNLIwvIvZTH
	dHGbe8VcH/Vli2UBt9fitV/NrgeE+ntMPPEMMDUyPpVoBPjOBSVqbbTMHoVW6g==
X-Gm-Gg: ASbGncthljh2V5riyfEdSXKwl92r+eOS/jBJeU1NCEjOPWKrbmom62ywz3pexQn7RAH
	ytQUDa8iI0wIbWusyy/TA15tTy9/ci5Om7L7pcFbN2H7PLAFQwfreJF0/ilsjvmRi1a0GgyfBtw
	/ZuU53uzlfjeCexjJtdsZUB6chLh9KRMO/vjU+T6qG7WJ/zsHGLq0VYb5IQbjZht2XqEMafPbYV
	8j2JTrvR4+0VdYaxgyE8/Hyl6K1bNn/y3/19B/jvSR1M7F/xbQOXD1WQJzSZYSBBZJAr1uVyAKN
	Aa/u4z06x+pDXMpFsqXRxFE92X19WFMKFCQSnaVQKM2JkSb+F3qfPId7EfGk/8PDUn8f3eQ1Voo
	JW0QUuwNq3iCFHeZP4zkgMp0hA4rrMCHSUVmh2edL00vUJoU8hc3B+pqiIAJM1ps=
X-Google-Smtp-Source: AGHT+IFQImR3Vj1kzGx2R+BGfWd215YKxySg4FhZPdn723hBKbycZMLDWwE88sLjbEEJGhlPaL5osg==
X-Received: by 2002:a05:6102:1606:b0:523:712d:44a1 with SMTP id ada2fe7eead31-5d41d10db13mr4412399137.19.1759799790449;
        Mon, 06 Oct 2025 18:16:30 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d39f1a2dsm435417137.15.2025.10.06.18.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 18:16:29 -0700 (PDT)
Message-ID: <8fea55a9-54f8-405b-9844-ee67b5e43ba3@gmail.com>
Date: Mon, 6 Oct 2025 21:16:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: serial: fix: trainling statements `break` should be
 on next line
To: vivekyadav1207731111@gmail.com, johan@kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
References: <20251004080123.98285-1-vivekyadav1207731111@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251004080123.98285-1-vivekyadav1207731111@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/25 04:01, vivekyadav1207731111@gmail.com wrote:

> +		case 300:
> +		case 600:
> +		case 1200:
> +		case 2400:
> +		case 4800:
> +		case 9600:
> +		case 19200:
> +		case 38400:
> +		case 57600:
> +		case 115200:
> +			break;

It is generally considered best practice to use the breaks after each
case. Here is a good article on this:

https://lwn.net/Articles/794944/


Also, same here. no top-posting:

https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

