Return-Path: <linux-kernel+bounces-881622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02538C2894C
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 03:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC2189782E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3176014B96E;
	Sun,  2 Nov 2025 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1jpKEx8q"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A851022
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762049137; cv=none; b=XQbsbHwpXlW+pXW+u9orOoZqIMA9ZVb7kMQ3DyRBViAqOObqltBIkbfJKnQwxNBTfIoqnQvSiS6ZjxFS5EdMlpgk87/8WhNXwwphZG8xxCocfDXtezWdJTFM0ov3p4CL8XEc/bPvw5OKJ0KsPlwx4XYCgyyO9YlOoO4/TMwelLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762049137; c=relaxed/simple;
	bh=5JNqMVBy4glto3/E447gOut+UiSy2POuFSmwlFR+QCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YPrI2G4Rva1T8nWy+wS7ysY5KSpYP9U4ajP2rJUzZGLaIbtXYzM+3zbkVJcyN5OtYq2oBiRy3V7SzdnfRxDanzVbNWXJs9xTyXZT9honnV5P7KSSTLJGxPLX9XNfYE57XrbMPfiSU3j1c1Ag7uTIefHx4+N/cOV/ZvCI4dRFFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1jpKEx8q; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-9482ba6fc24so144944339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 19:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762049134; x=1762653934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gu2n0sHcfbeAOZk71KmAbrhzHpdNeix6s3INTo4MZbU=;
        b=1jpKEx8qSUOYaLvZCRpSI+0aPFcj5tm8Oy/QsXkLYSaWJT8BhFR897b38/aPIouTRE
         9desOywGtUszRuaqPnCto+7020FHt+UWuC4DZJtcwvpNTkYhMQ7onWLA48ixJh7KFgx/
         ZjQGe43O6K+/qkq5ECHo1lGKVO++M8B3/TIXgfVJ615GuIq/lajUF3XOI8uO0185mfbm
         i+Q7HDqUKjd+bEdas4BiB80TmD6QhK+Q0Tyo/U3CQiCDcmItBk6/yz/4k9Mj8JybECAU
         a8gI5FFuL18LLO+o2u0fvge7Xk4e3aMjNQ1KkoKOPPFkX7EorcMry8liMD5jbtR5Jc2l
         fyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762049134; x=1762653934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu2n0sHcfbeAOZk71KmAbrhzHpdNeix6s3INTo4MZbU=;
        b=v/1RhqeMXimXF9GzcgLRDIT+vIQQg1Ws6mL6uNZjPnU469tyMWmj93b4e0QsayRwAv
         gIOJ1A5mXR6jq1SNyZoz2qyw0na6bFRmF9HnuF1SQe1jnbEEtNiX46pElDTt7mfapawP
         1WB2mV4RV1tp6csQFg8O1YyP6H/qiPEmtHXcVKVA23HxxKD+macM0ijUpFcxmFG+EWxY
         Tc2rfC5HJ3QMa0o/opKsLKS3lmFYUK9uiROCKXeBSO/yrAHu2NXq3sfnNzCWkJFNG2TJ
         zXzSJT6ilMd1Zm8wVlM/evNSzqhc6Jo0VvtPmkAIzhryhW/pkjHk1WX8wUzlvJCL51KI
         QsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTMDchQBDCUhFBNN591MWOGyj5OGK9alq2HmFGD9nHJZefjciexep2nJbpP/oTDIK2ljC6YmD8O4oM6Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2OEPPWbwz3MM7TNR/jAVnugw+cqJAL/m2XY51ynWQIDwUVtuF
	5N7yPVJZE9MxGbLhRvJb/faXIIEP83lPapbOjZPzzL9xQTXSwpTrmidl9/6sXEfnZGM=
X-Gm-Gg: ASbGncv7gYvcPSDx9muTbTCuGz7q2ZTyAz4fefCwoaS4gwJnzKEoSj6VnzbOqy+jF7A
	hI1ByJyuZeliGgH/UUiZyiu8dn3Dadujo8ixJ9scfbTd2fmHYMADM0fojVovaUz/Lr6KKWIANAS
	QNJ/ZNajhrMP6Gq44nxlamoaERvHgR9XUP0vat0E1EngBOFb1RnbMCypetPVGrG8sT2Z4aN96x1
	xxApHC41qN3Iw4SMMaOljIVyfvXklUj4QsM5tfJnDTdddgpL69oKVmzZEXIlbSm8GZALcvZ2NA8
	DJUwadM5H9gdYbiyMD2mYsljnxRO4AN7nA4TJA9mLRjKU+9V/3Xm+B7i9w9wTgT1hvSGXcuYJMR
	7QaPdk4QvDwh7EJcKexujQ51XaeHkKuH6ukOvPIe7ZAt5LXUK4EKorAG8DqtgqNQ/AaMBE8ZzpI
	t9sarY/2/a
X-Google-Smtp-Source: AGHT+IGjMI1rKpG7CijB7s0irk8MN/wZQwzi5MM80pP4THiIReRrkAxicJFqmepnEDD0WGpc7yab+A==
X-Received: by 2002:a05:6602:2b05:b0:940:d4aa:a34d with SMTP id ca18e2360f4ac-9482291e21fmr1360299239f.1.1762049133969;
        Sat, 01 Nov 2025 19:05:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a55b1b27sm2289836173.41.2025.11.01.19.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 19:05:32 -0700 (PDT)
Message-ID: <9f8428a1-ab65-4baf-8f46-af2531cd65ec@kernel.dk>
Date: Sat, 1 Nov 2025 20:05:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] INFO: task hung in
 io_uring_alloc_task_context (6)
To: syzbot <syzbot+898dd95c02117562d35a@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6906b77f.050a0220.29fc44.0013.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6906b77f.050a0220.29fc44.0013.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 7:44 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f7d2388eeec2 Add linux-next specific files for 20251028

Old one again:

#syz fix: io_uring/fdinfo: cap SQ iteration at max SQ entries

-- 
Jens Axboe


