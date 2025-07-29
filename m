Return-Path: <linux-kernel+bounces-749065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53FBB14993
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1EF543321
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142526C3B7;
	Tue, 29 Jul 2025 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anK58dm1"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E426C398
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775623; cv=none; b=EBZXtIhZbNTo2xg2dXXk4ZaF/NFJ79khc5Cy+F1mOv+C0dBhfmxNdq8R4OzfK7Pm5ROFQSmBvDR18OGparbJu5tKlxqkaOvirpztRnrZ8LY/QhVUtk6s/Y6q7Ba5OK3h4ksrZ7gFkR7KNGe2F4dDWp4yOSCggw3Aqyl8IlLgMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775623; c=relaxed/simple;
	bh=Fx+6+/3ebhX7na2SapQkosd7KuiR593pWXSDAlCspHQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TCQ6FMNewQwYS8uvWFP7SRGfV02Q2KPST0NeBwXGQTbcRjyCOUIcOnXN/a2Wrd9To1Xtue0i6u+VFpEwyCmxOtiETZyVa2K7OW/2bgp5VJ6SozutrMKegsPZS9fkyLMxDPE+xYsbAKTu9w4TWjWWqyVKyub+9dgKptOMHVOZam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anK58dm1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so2068031a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753775620; x=1754380420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YhTRbONBVEDwqIp4cqr1/Ni86jGhaCN3kr7k05fYib4=;
        b=anK58dm1BnqW/Fl1wWpcnTz9oNk5TG//Bn+jcvI7GjJDrCcA6V9saK3TTJ7jxryHMc
         vcvNwDaptWt9y5Xn3452a/wJ5VsyhEsrvjAIOHXpYHNY04sEIDL5t6FDAGDG4+RcQU2K
         7G9ecjYzpw3vjUyIJeKgO54zbVZ4Lj2ew5htbuhpSAr8REPpEazhqdFIoD95AdndHDDC
         2b17hbOyJYnWzOJLKbdqFgTbc/whGdrxvLklGOUAKpzgCCJmBAdG3KWgRxXbM6GVqYTK
         9XqakkC3oiDZFbBU/9WlbZIrRfED5QU93JakSt2i2igQqPkVnr3nB2+Xf764tpG5qsIZ
         kzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775620; x=1754380420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhTRbONBVEDwqIp4cqr1/Ni86jGhaCN3kr7k05fYib4=;
        b=TWpo96SyEYH0dgqd4Ge9pM+7FJXqimn+iry3L9Kj1prLV/uT+q/x63+YjULK4v9EKY
         hS+jCPg6FDfLzsP0PRSnWJcBVOK7N0dxB0VwOyT5QtJ9DnhEZnbgR4R3e4lhPkE5ekCP
         4EFJgQLq0uSmZqwkeUd3s029n56Lf0S8KfWsuysNqql6s3PO0NW5UnAOl1Vx+VV/+9w1
         kOwAgnQpG4PbMVinGBu13z6Y65mCLsgPnN6Y80dX2IwcUL2qHiU08hHKU9COonVI9E8H
         0gitdTIdJP8blyD43EG5KdWpIaTkGurA+gO7lb8KMYaBLiZD2HZVNtlmHDFnFO2Rdfts
         8NLg==
X-Forwarded-Encrypted: i=1; AJvYcCV3McGjX/WvAoshYARTcN1JyvZcQJrv9SCm+BMMnXVOTtLoUddOBNkcKxKU72UWqan70MHkHXSxsbNuVkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPg8las6Shu2Nkn+rieBzLstYf0GO+90uVbTc30bplaQKxOFF
	Wc7gwxp7eBns5mUYfwCdDyOLdERi/8q1vjP1qN9iiV9JB29RB5PEJXOGnmmDdlDNJV0G/Y9isvE
	D6z63G2XkMJ4DKWwRl+6yLI5VvXhtARA=
X-Gm-Gg: ASbGncvBuhVm3me7q9HKpI0hJJqpivwYs/tvgl/PKtEgAuJf1Hkxf2m9rLfCJC9is9X
	LNV1eK5ZII+B4rDqpk+YPUjdKOI6efT4BgMkeEHU15OAp26XQV1Se/fU4uAMx4ACbRdUj/uvF44
	rA8d6HwHqxzD2tz/UdbmtKadgS9J3Q4mZ+rUFDZWk5En+23tROzcudW1aCPc3999zIZLRmXmCl8
	ccmgjyF
X-Google-Smtp-Source: AGHT+IFZJqIczhmVZAxwwEHOO2otFASvzj5BJWOQ0R6afxrR8aT5PD1q+XV59JiVraZp9NiXKgjN4CoiUWOJVp6blek=
X-Received: by 2002:a17:907:8691:b0:ae3:7113:d6f1 with SMTP id
 a640c23a62f3a-af61cf9830fmr1710160966b.25.1753775619591; Tue, 29 Jul 2025
 00:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hc Zheng <zhenghc00@gmail.com>
Date: Tue, 29 Jul 2025 15:53:27 +0800
X-Gm-Features: Ac12FXzaciMe-Iw_TIepYd9hkH6uYf5V1l3OPNXFSvNWzuYl8Okv5Vuslc8CRnI
Message-ID: <CAHCEFEyd0Y+wTrLWNMUNvwgJrCxAi66D17w3Zg-ikH5005k1-w@mail.gmail.com>
Subject: [Bug] x86/resctrl: unexpect mbm_local_bytes/mbm_total_bytes delta on
 AMD with multiple RMIDs in the same domain
To: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

We have enable resctrl on container platform. We notice some unexpect
behaviors when multiple containers running in the same L3 domain.
the  mbm_local_bytes/mbm_total_bytes for such mon_groups return
Unavailable or delta with two consecutive reads is out of normal range
(eg: 1000+GB/s)

after reading the AMD pqos manual(), it says
"""
Potential causes of the =E2=80=9CU=E2=80=9D bit being set include
(but are not limited to):

=E2=80=A2 RMID is not currently tracked by the hardware.
=E2=80=A2 RMID was not tracked by the hardware at some time since it was la=
st read.
=E2=80=A2 RMID has not been read since it started being tracked by the hard=
ware.
"""

but no explanations for unexpect large delta between 2 reads of the
counters. After exam the kernel code, I suspect this would more likely
to be a hardware bugs

here are the steps to reproduce it

1. create mon_groups

$ for i in `seq 0 99`;do mkdir -p /sys/fs/resctrl/amdtest/mon_groups/test$i=
;done

2. run stress command and assigned such pid to each mon_groups , (I
have run such test on AMD Genoa. cpu 16-23,208-215 is on CCD 8)

$ cat stress.sh
nohup numactl -C 16-23,208-215 stress -m  1 --vm-hang 1 > /dev/null &
lastPid=3D$!
echo $lastPid > /sys/fs/resctrl/amdtest/tasks
echo $lastPid > /sys/fs/resctrl/amdtest/mon_groups/test$1/tasks
$ for i in `seq 0 99`;do bash stress.sh $i ;done

3. watch the resctrl counter every 10 seconds

$ while true ;do cat
/sys/fs/resctrl/amdtest/mon_groups/test9/mon_data/mon_L3_08/mbm_local_bytes=
;sleep
10;done

...
Unavailable
Unavailable
Unavailable
61924495182825856
64176294690029568
Unavailable
Unavailable
Unavailable
...

at some point the delta for 2 consecutive reads is out of normal
range,  (64176294690029568 - 61924495182825856) / 1024 / 1024 / 1024 /
10 =3D  209715 Gb/s

if I lower the concurrecy to like 59 or lower, the delta is in normal
range, and never return Unavailable. I have also tested on amd Rome
cpu, the problem still existed.
I have try this on intel platform, It does not have such problem, with
even over 200+ RMIDs concurrently being monitored.

I can not find any documents about max RMID for AMD hardware can
concurrently holds, or a explanations for such problems.
I believe this could become even severe on AMD with more threads in
the future, as we will run more workloads on a single server

Can some one help me to solve this problem, thanks


Best Regards
Huaicheng Zheng

