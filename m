Return-Path: <linux-kernel+bounces-847250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34455BCA5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424E81A63CE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C33022576E;
	Thu,  9 Oct 2025 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dbEp7dvw"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F71426C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030192; cv=none; b=QCtMeQK0EsioZMEDfGNh3uDaisavnLeR3lBw3ZZkIpjOLMDhx4JjJosZ7nf7vkhvr6MEEZK9Gt24rrZoTRUhA+Jni1Nh0ceN/zGlGI3xlDZHJ+9mXBVd76jGd6glkU1PQmkxKpYNtHG6jBENZjayh5L60fDeECiQJqm+L5jvHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030192; c=relaxed/simple;
	bh=eTvKsfZWSIZw1/7QA+vIwYbOlKcm+qbfHpFsYq87r74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LhJDe6UtRDlBpp8srjnXT1jQln2Zf8UQE/u9QriiOhGqxsdI7lJbtjUBNrqVEi04wrEi31xwfLNDt1NZAoZ28U489ncV6KU4lM/mXYZU3qPOB2FnR8OCv3SPWvspgUcd/ZphNAkrP5z5wkeJhcPvhiddINSrjzwLOg6rBB2v0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dbEp7dvw; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso113271639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760030189; x=1760634989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1dgrxHtWEHMr9Hmc1PtIDiyAxbzIwd/8rFxzt/ZgVmg=;
        b=dbEp7dvwqQbNVafvpXMQZFK6gAft0KKeAijJ5hQLIxT3t7G6B0CfZEvpl4JjsEGe7e
         NDh4R+I4XhuzEQ79KdFlm/zVL2IlXZWi0hGO56ka9PpV34RPeszDfxC63U6q/R12UOvD
         j3iHHtSqLH8b4Q1I2zeMAkGqn3Jlvn5CI3yzMzZbSZdVBYtCue0Uh5Qq10AuAiCAgf1o
         TbXeeXh8yUQ9b6jGbrs1onH6po0m9YDkgAGxx+vxY0hL0or4BN2q4BqDpBN1DtieKXNv
         VZRV2qEg2cBCFFn2650EL4fZq9uUZcdHEU2acegfuok21XCELdp5AZ7GuH8/YmcFAf5s
         7TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030189; x=1760634989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dgrxHtWEHMr9Hmc1PtIDiyAxbzIwd/8rFxzt/ZgVmg=;
        b=Yc69PYupKYIqK0+NK/Ro7qYyD5RGyLHG/eUrrFjIWSwEPhETEd4bSjkprIwoiggalq
         7WVdd+uWQtRwBLOdLvu89QTlIt712dM8ExLsQ0+CN4Q19oHf6jLJWxlEDC15B02zH4d9
         kckBDQ72vA1VlLYegI5fdlXjvMn17S3LUyLdwPIELuW+s3npZlr9d2k6w1ATP+8RJQyE
         aQPXgsWA+osDEDvKNQN3yVKZYNWoDhy0G+laKT3N62AYblIsnOmMLgUSq8xakEtSEsyl
         24yaIzwq3WS6+JxZ+wAOv5VhitvBplDOlwGymoTfgOLhyP0ShjQLz4UPNSrvZXgfAZA5
         FpSw==
X-Forwarded-Encrypted: i=1; AJvYcCVkWjKVzQy04B0o5ZHK1oXYt7p7U3ODy1li3wxryyuSqdaYvav8x1qob2qr3ug6FlB6/LWDHMVyx1KhaVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp32AwhB8nuw6DMwqr6KwWQrn6G8siUnA67ygHYrVwTzEoDD2R
	GAuZDYeSIdDrjVEa9XgOG1o4th1V6sOHG7XAUaeANjYWaqurREyaLd4aYOwh0ikM7/g=
X-Gm-Gg: ASbGncvTvbSVuU8OVNxZaZ+vsCWWcLsQ1O0CUwvBYwn2/cC85OWmJDWhozbf7phAdLX
	4wAOCuNrInc1xHqxHqc6BfuJe4SaOSDZQFBfh7w9cgywOHAwrb/m78jfjnTQ7tkcutGHdAzvFHz
	EMHBG1XqZX6R6Eub9aYlshiUCbT0Gq9oBzoKNmYgaO08LQIxl7KSK8bUJpqRm7jkaHJlasC9Jez
	ni9lp912e23juWR+jqaLrAux6tsfGLKR6ZItsz6qKXziE4nb2/R0Jt+mutulv6coy9ankUSAWVK
	F8+PV/HktGVEQVxWpUK/3iqmlOiZfm8KIwbwAjjHXWGCGIThk3WFAK72xKaOV7H4e3pvEFe6bGZ
	BTuGw42+yF7sB3hH4/Iw4e7C9hWqLfW3FpqivM3k/Dy7HC5Ph32dRbg==
X-Google-Smtp-Source: AGHT+IGKPdE2x2LdF7TdjzoNbTWXrqAezlnnNapsUBSI3DIyl8MC6bA6FwIbz3FT3WNkp1tcJdzaQw==
X-Received: by 2002:a05:6e02:1488:b0:42e:2c30:285b with SMTP id e9e14a558f8ab-42f873d1c4bmr70129165ab.20.1760030189113;
        Thu, 09 Oct 2025 10:16:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f90278522sm12625795ab.13.2025.10.09.10.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 10:16:28 -0700 (PDT)
Message-ID: <d9f47040-4a12-4584-8293-8bc2719cf263@kernel.dk>
Date: Thu, 9 Oct 2025 11:16:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in
 io_waitid_wait
To: syzbot <syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68e7eca6.050a0220.1186a4.0002.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <68e7eca6.050a0220.1186a4.0002.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git syztest

-- 
Jens Axboe


