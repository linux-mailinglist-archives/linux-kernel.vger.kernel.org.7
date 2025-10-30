Return-Path: <linux-kernel+bounces-877330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544AC1DE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923CA4E1FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415D13DDAE;
	Thu, 30 Oct 2025 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt1DagFT"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68FA13A265
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783175; cv=none; b=dZ32ykwFRGDc/SbNzcaGAFGQnrOjif66/qBwZGtjqbsnaoUdBgQp3TVwGqand98ctvHROvEbWKJIVS2RPRYt9cd67jf0+6JAX1r0ITcu6StSM8QZv6Ov1VO02EKqvbd2bCLzeBWK3hetke7BYAO4W/JTSUIDQIB6ucZI8XENMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783175; c=relaxed/simple;
	bh=Pt+XWVpX7W4+wpuWhwGPAsTClncvQbYcOUcfu0ntAWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FejoxylyW2ItVYAWwnv1uW2kU2s3Celvkc8Frd2FE8SnuiVtfiFnDrsMeSuUwn9pHdZ7Y8RBTNIYejWjf4EBNdUPMOjXTs0LmJvJh4c2WYo4xKqbQiJ7Hx6dkOzil3RLQuES7VQxb5TViJ3cPrWGawn8pRd/zrnq+lmV5I321oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt1DagFT; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e1c0fd7ddso601864d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783173; x=1762387973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt+XWVpX7W4+wpuWhwGPAsTClncvQbYcOUcfu0ntAWk=;
        b=gt1DagFTIEunIXXIOkOAgNqOmYo3zlgeR/je+tBx/FAKS/ZDZlNDFvfn36Gyz9wMTk
         sUHbr8F6/dxLOgw3lh51DW8Yzo3BAE8wBWJjPtkrC5yeOmLD7Lk/W2nB4vpzie1sKAtg
         XPGWpSbP/CLftAoANFwvTDQhp0ZJc4UWAh6pHba8ctPJsxZ3QZENRMwJV5kOipG47jGd
         Ti0bjZ2tyso/dOgX8NLPO+mPMGiaiWNaJun04oPylRjh+3bqYMP8i7gBXRLRgXgRLlT8
         S5EwVKCuTqENWTb59aKmRggY+d0r+ivF283LFjyohUb+gc+dLXTQV4owONLolC//VLCP
         /0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783173; x=1762387973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pt+XWVpX7W4+wpuWhwGPAsTClncvQbYcOUcfu0ntAWk=;
        b=bTMA9EtYpSEFOpul5IYEFU7AHCluSo+lButxOfo5RaMjkUDHHFYZb5H3aOYtauGs5o
         PpALOtVLSBKz86V1EpcK6CYsNsPziq/NWbJkzihnBIUb+q+1X5kt1l5oWzXXN0cHmkgx
         HIidJp484TKHMMrdNfDqChPV0YGDM9knbwC8M0oNJz+1gRmD3UtUwCCpco1xE2IBToHx
         WlEBO2MMnp7+0cueIbL9AUz0R+3VX0Zc7sQGN5QE9yYUjaRY5+nJ5sStDryNruUfw5DZ
         J5dIVmXNQm+pjRYBHZ9j2EDUeQzII1dqMdDNwmKT/P1HGwmnrl5US6ffautg3qKZ0HDP
         jmjA==
X-Forwarded-Encrypted: i=1; AJvYcCW1Zmy8EvLMTREPauhoxQi+aMcX1SZyjXRX7lRPKiv+HALDPDcLVUmPgpB/C7ix1+dMRPoKYOz8GsafPgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5vpA9L8rj0b2xT9RxXwqJymxZjoftstbTMqSaSDbttuaqzvmH
	Wqq8EagDt3pDxdIAimJub+I2Q2zFoEHigHEx+PVskAizzDVY6m2xrD1i5RCc2WWMNh/oBocX1qY
	sXXunPp98bs8zZueoKM86u5mPlEWax+SQcSBt2WE=
X-Gm-Gg: ASbGncveMDr9vzCWYTIP+vrfv6/wnj8Zhci36SXfuf94TwSScDcset/btdzW+3W0TDe
	Jz03zBLpzbi+XJYSCsSSmMv1wmqxeTSEo8Kw1sYpXZRbguuNSrXDmwCNJE3z78EIIis7xc6A6W6
	FvlMJrUtaxTP7b8uFUV+7Wrkmp9/aOn/nuXEc1wx60AKyyuZwc2hUSW1VIt1b9IYg7z1NveD9FS
	gyB8lHLRYRfL2tpSD9bLRV+/CFDNCupSSoG0o3bCX90Y/6QhrNLUEHlaIBkcEPRKex0x6oVHQrs
	x4NMTOiOk6eBiDbHmq/ipI5+1Q==
X-Google-Smtp-Source: AGHT+IGkcPVeUHOyzzeaDCgQVV7N1DsbtwKzZjCLECXQw783opykaLZ09jb2jif+KNRmNzEauIlnK78eUmwkI+IK53E=
X-Received: by 2002:a05:690c:6d8f:b0:782:69fc:3911 with SMTP id
 00721157ae682-78628e531d6mr50674607b3.21.1761783172633; Wed, 29 Oct 2025
 17:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020060936.474314-1-kartikey406@gmail.com>
In-Reply-To: <20251020060936.474314-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 30 Oct 2025 05:42:40 +0530
X-Gm-Features: AWmQ_bnMfR5x5ZdWlkGeeYXa0-DzGpDM7pDrxlQdwW98XmHQJqd2qfcHjX0iTHM
Message-ID: <CADhLXY4GzRDC0ReKwhy50UAfwugvmBb5ffsuCQG_7GNDk3NcUw@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: refresh inline data size before write operations
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Theodore and ext4 maintainers,

I submitted this patch on October 20th to fix a race condition in
inline data handling that causes BUG_ON crashes:

https://lore.kernel.org/linux-ext4/20251020060936.474314-1-kartikey406@gmail.com/T/#u

I wanted to gently ping to see if there are any concerns or if any
changes are needed. I understand maintainers are busy and happy to
wait, just wanted to ensure the patch didn't get lost.
The patch addresses a similar issue to commit a54c4613dac1 by
refreshing i_inline_size after taking the xattr lock.

Thank you for your time!

Best regards,
Deepanshu Kartikey

