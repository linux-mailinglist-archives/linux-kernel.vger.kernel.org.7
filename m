Return-Path: <linux-kernel+bounces-843677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C1BBFF98
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD3E24E16BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31C31D5AC0;
	Tue,  7 Oct 2025 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcLReOUx"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF291946DF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801334; cv=none; b=TT3l84JKpVvLXYqGQXvHgaihbiu7cMrlT9s/uqXm9MMTcRHlfZ9NR+yq7Dm6Lj0FxoFKTEVeMfm8NXiiNtQTyATApUgG31PC0XfjqQ/v0exGkcJV+oF+JxXaW7ircVoBzNX8k+lrq4nmH1JdBSdW+gE8Z87YV9QqkTdQgKVUyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801334; c=relaxed/simple;
	bh=dTonZkeP2W8xwq64wKDM7p+9fYOwb5HtyFurNb6VBkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvNvsJuC4MO5woBmGNDm2xJo1lzKb5m5DxrizhxLVxA6GDeh/DIir871wq8BmKaw3TRNrYtn5/3+S8QvEirII9fwfOzYrZCGUubZyxO3nmXMTV+3160wRE7DYii80xAf9pZF/Yv7vAOwdL6DMOx+xgiEwDE00l1PyVx/9kHBkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcLReOUx; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-890190c7912so2397048241.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759801328; x=1760406128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTonZkeP2W8xwq64wKDM7p+9fYOwb5HtyFurNb6VBkA=;
        b=NcLReOUxuAHcNn66evN/ubwrP1r+1H4oFCWI37nPALkuwrwJDY54nq+YvWG90SJ2th
         fYeg0rwcPxJxdLcONBipO/zckjQCbmZbSDAOSo7/JTrGV6gi461Fn5g/kz1yYQIJYECS
         /Q3Uy9aeYm3qSM1Fzgy5P4x2INprAcgbu6t2DrjE8+ZgB6jVu7T824l2rau0UEwVth8v
         syHSuYFG+u5Q4z4C1bYT9ho97D0xOmDv/ogRRvlvYWZ6JkJaJIt2anT90LUPdG2otS3S
         ev66T1hyJfcczE3XzldyuxKxQESQqL+kEFLLaNiMtH2xj32DJ+NgVBq6b42kxIHnUbXe
         dDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759801328; x=1760406128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTonZkeP2W8xwq64wKDM7p+9fYOwb5HtyFurNb6VBkA=;
        b=byOVrjGSPTLuEAHU+dfbHQKrE5Ndte4oWgji7dnc6OCFt1PysunE4ktSATdmjP+p1q
         +g+KrOO3xqGbQaYy5TMA+fN1ELMm7T3YtjrfLPFf2JY/9kjWLEK0dPSKeDVsNNBFNqhS
         j/IhIycQLGYarRHjp2z69gzPhX2Qky1BAlfWuCLv4Vr2ih/y9QbT1W2gnOCVgn8gEjOY
         wcLFuFViHCMzqnmenqJFEfahICLsOAeelQPJRId4XfD3il+vOuBGM0YS57tA1pFjG1OB
         4rG0xLx9dwmnLY5xUShB2YriJxrcQ87l/K7VOa+KNJvji7jBov5C4ST+9+LszwOAy7kJ
         OPyg==
X-Forwarded-Encrypted: i=1; AJvYcCXtQa0y7mdj0c/mWZSjOhk0p969LlIr2EURum0aDbLROrUXuHjsrRN3Ndk9mAaAb1tj6Qf8P+UmTadwnjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhMuJy0bJHNI+iAE1aM9lzOhhLrJOcqjKzP9HVO5nj3EYDj6g
	Z1bHPg+gLa5Yfa7mk+SJEKBa3TLq8jlmiWTxq4B6atILT0T0u15acJ4a
X-Gm-Gg: ASbGncsu18jqhNVsWl6yVAyeo2rI+Bw9k5zUWw7TX5ozMFS4zS6xAzNyCnKVbrxBjUP
	unNg4zWD6RzGBtWVi3zNMdX1LVpSyYvW8StytJO1ikOvxqth3KNEh0fIREwG+ZSeByCvbxlV1OL
	lrAbCQg/LjTe7qtTy9LcdaWpTXdygDVeEif/f3u5uuRb4Gmn2DcGOaEEQD2BDshRAVuIGVtCDJ+
	4g4j3CN6o2CYlY6kbze2CcHMeOwSwW1YkGb+kaSgxmW3jfL5WscjskmTUxS4sPC7bbp3kvTEOqX
	7j+IAh+HmgIltcJIGuCGcR8oTfbD5Cpvlrkyv9j26lzlpC2LL19n5qtfK9rD4gMzYkxNJtMErUt
	sf+C9NnFdjyJ8pvUkF94eWhgz5e61wl5T+ibAMqsqp93QfpjYr6vbgeMUTLhHzpc=
X-Google-Smtp-Source: AGHT+IG/CuZVAES3BSHynINML/GYB9ctain2pBZEnoUSZafLAz/JojezFxB/4HIhRy7e/u9iBABY0w==
X-Received: by 2002:a05:6122:3bc9:b0:54a:a874:6e4e with SMTP id 71dfb90a1353d-5524e902014mr4641182e0c.8.1759801327865;
        Mon, 06 Oct 2025 18:42:07 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf64c29sm3436147e0c.20.2025.10.06.18.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 18:42:07 -0700 (PDT)
Message-ID: <8135af96-528a-4aca-8e11-7cdf038f1454@gmail.com>
Date: Mon, 6 Oct 2025 21:42:04 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: fix shift out-of-bounds in sg_build_indirect The
 num variable is set to 0. The variable num gets its value from
 scatter_elem_sz. However the minimum value of scatter_elem_sz is PAGE_SHIFT.
 So setting num to PAGE_SIZE when num < PAGE_SIZE.
To: Kshitij Paranjape <kshitijvparanjape@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 skhan@linuxfoundation.org, khalid@kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org, syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
References: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 13:46, Kshitij Paranjape wrote:
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=270f1c719ee7baab9941
> Signed-off-by: Kshitij Paranjape <kshitijvparanjape@gmail.com>

Hey Kshitij,

the formatting didn't quite work out the way you intended. For the next
version, please try to send it to Shuah and I first.

