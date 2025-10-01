Return-Path: <linux-kernel+bounces-838990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A3BB0951
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A9C3B6F5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C12FD1A1;
	Wed,  1 Oct 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1LKbfYf"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4692FCBF1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327101; cv=none; b=BxX/0SoCNu1ZQ1kaPdY521QJWIi1fw93XOFHGiyAA2Z7ukirvTRmg6fAWtIBxlF7mz+azgIubgHU+pBjTeXGDwIaEf4NND7WY/nB9t5dx+/ut4TW15QM93wicjq3Ypa8IixwBF4XIKJ6OxWVnxRe7Ld5QHfQff1bLGMOsjGLZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327101; c=relaxed/simple;
	bh=AErz9DRE4zvoV1QAhCMy5Ce5EIwMk6a2u/GPbn+LmQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EY6gUYbwAfKdoZ4S2w+z3XA9/ibdrI+SHDQVK19rIQp02WCxzA0cdRxNsT3XRX8d59eNSrmPNFROscduaUqoLxXK/nSD+RVqO6eevq2Q8KUu+dEgCjsyAEg6kq+pgZRIYq50YZO8+UKMScQQpih2LgAzDD9ZTh7hPjLzccyvsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1LKbfYf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782e93932ffso3973576b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759327099; x=1759931899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHICQ9kYf8w+w6O3p0zJJOxecrN+M89vOZ1OdrVwWEc=;
        b=K1LKbfYfUGXFWYvfX9kmYN4cWonxTWwRsQHoZ/jqJmu2PUT3AZ+tIn6EUVgftXh8tB
         4WXSJ2H2fGyw4k2cz5iknj4W9+t4WvIgkeQAZChB4l+giybjKfJDerXnTOpfPNbAglXC
         tj82md1n4DRn171jFJGeQs6jGmklWW4Rlg3Gy0dViy+sW44/D0J862hcZaf6X+V6ysu3
         /6e1ag5aAFU+CM4J3aewn6HBL74th60oJYAGw2MiR7R6jLXlkQE+UzN2Ptj9lcCX1JvD
         uc5cFR9Efhdo1E+n0KB9ZzUz9vPQ6CHBWFSUY4ttEqc7yeeEeEIHvmkVNPrh64/CGTNt
         z51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327099; x=1759931899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHICQ9kYf8w+w6O3p0zJJOxecrN+M89vOZ1OdrVwWEc=;
        b=KR6Uc4iFy7mdHR67RHoD7rFKBAk+NHfeiBxyLNdY7ryLDl1YzL3e8ajYJmoC+eLStT
         PkFBNi9hRO7wcMbHHkVDJf3QJTN+eo1EG1RgPA8BTU8g3kSjVvqeW43zXf3C16KoC2rv
         IRXDvHw9Me3ycN8P2VnZ5Qd9ZxkdlcZcAvZstAVHqOhRFSijzUtzO5YC97TcPnIBVBey
         ysyERNTsVGMpXAuaz1uvNE9dINULSlHG/oidvRR0ay7AL4Cdvgr+iDRkvBlhN847VvWq
         WNXGU7hFMe5zaGRsQW/q+P1AtenkdZdEmxzU0HyxLsvvhOmSqA8v8Dr2WR3/BL3J7pp+
         bFbw==
X-Forwarded-Encrypted: i=1; AJvYcCV7XnwSaXX8tqjsTwFnQSCnFKd2J7JN7ib3TW9MmKEtcdchb8DWfHFqDACWS68FKT6Hao/ubmv2P1zNngw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzql/1UcgVFTJMOhmF+Q+fZbiCF9npxN2FnsGquoxoX6zComcOG
	V60UvzJwB3qoUt3K7/BPnPIPY5XYGID5RFJFWOT+GdzQo+hsHtN2ThfO
X-Gm-Gg: ASbGnctjJZS0CL178C/32UoVCQdZmcAuEHanw10xK8r1azxV1GpxnjATbOI1NoJOva8
	yW/yceIh0IdDPgAnVPp/FKY5GYnuzmLgY/Rj9UNg8AahdGc4gcscmMxrcxDL97Et9lvMJ5QecbN
	kigjtjy0GeAd4Lg0yab4T6+lbk79kcjGVm7mdchn93woDoKbZgNuqHn/DbJzTTWb8J5DvlAh9YC
	ODM31E0de8imxjEshTz9EF8m51dZbA57tKUsfMDrygbNlxE+C7eLsctuccD7A02bHldCm0ZVXDB
	aK+0I+KWTq94n5ADZSyRMz+XfCFVWQ7OBG5YgPRgOZgenJgESlRSS+LkhEpxDW2n/Hv3ecTRqDx
	Intc08g5O1vGKJmCIQlDEvfoSEMxN7cUUuFdQF18rB15r9Zayfx6z8pcN0aQnfT9cNQ/+0A==
X-Google-Smtp-Source: AGHT+IEVrUrSHnJxKWleti3ip/7ssnZbESbu792noCsfEcKl9fEdE1xbBALgSKgo50vIeSR68LO4xQ==
X-Received: by 2002:a17:90b:2249:b0:330:852e:2bcc with SMTP id 98e67ed59e1d1-339a6f38013mr4558738a91.21.1759327099110;
        Wed, 01 Oct 2025 06:58:19 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.95.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399be87425sm2129797a91.1.2025.10.01.06.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:58:18 -0700 (PDT)
Message-ID: <425ef7bd-011c-4b05-99fe-2b0e3313c3ce@gmail.com>
Date: Wed, 1 Oct 2025 19:19:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: doc: Fix typos
To: Carlos Maiolino <cem@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-bcachefs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <DrG_H24-pk-ha8vkOEHoZYVXyMFA60c_g4l7cZX4Z7lnKQIM4FjdI_qS-UIpFxa-t7T_JDAOSqKjew7M0wmYYw==@protonmail.internalid>
 <20251001083931.44528-1-bhanuseshukumar@gmail.com>
 <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 17:32, Carlos Maiolino wrote:
> On Wed, Oct 01, 2025 at 02:09:31PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> Fix typos in doc comments
>>
>> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> 
> Perhaps would be better to split this into subsystem-specific patches?
> 
> This probably needs to be re-sent anyway as bcachefs was removed from
> mainline.
> 
I just did a google search and understood about frozen state of bcachefs
in linux kernel since 6.17 release onward. It is going to be maintained 
externally. 

Thanks for your comment. I will resend the patch excluding bcachefs.

Thanks.



