Return-Path: <linux-kernel+bounces-847185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFFBCA300
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548943A4D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D25225397;
	Thu,  9 Oct 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8glPT7A"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B4223DCF
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027405; cv=none; b=rJ3aYQzxO2ZSA0nmNoNFpGlXFeJBbjliFRtrCmmt7SE+XsGDCiGXwCrdqjLWrD2U27lkDP1hP2UHRIAKZkXVon6LgN1tXbz61R3vJUqaH3M+rcNWe3lJGKJe23yfBI9cfZK8E6arG/ZnKB9+UfpBLB1odgUCR17hrbLkH5l+Ijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027405; c=relaxed/simple;
	bh=N1O4Nk9Ec0MlRpNjq0jE3OHVzGsSylTFSwu3DeWCFZ4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CBsKZoUf+1dns8baQez7p4svqJiLpj5AeLOKKAf29WL2CZij+IetPDj/2GtWdjA1bke7F94lrFM+2liDKEBsuZL1C3TGEBdxW/YPo0jtSxrz7/tFCt76BA2633tpB+Fl8yyhFMM7lisIiUxUUXe9TU41caDr1bH9HLSsaVG6J1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8glPT7A; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-373a56498b9so23488271fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760027400; x=1760632200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfTblhbdvZ1z4w7zKFKUFNblGvrujEoE+I1nJ7Up5dU=;
        b=A8glPT7AE0ByHM9/4iDu3iz9R61MSCv/InDciQZGmi2zGgx0M4E4gyEMFZWejr71Rh
         L2KZ7sYDOb7AK41QGrQ4Dpu1QWbtXDPevtETFGVcbltNoK2KO9zTdXIYKWqAEiHflbnl
         LTqOM9Ov03u+U/AbkV3EdvieN2KwrGHNiTbyT1YVE984t1vp/6KdYECOrHL57CODE7uC
         kgSSIghdNcNuuelGsSgs2Z9rXd2XCkKbBNvQhYmL6zLaE+7AuUELxTkEopOBPLGEZxvQ
         bHi41jK+zY4O0lWp4lBCy0PuPWfAeA8GfLL53EMYahICZhSXkAOsd8kqhCht2Ecg/1QO
         3WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027400; x=1760632200;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfTblhbdvZ1z4w7zKFKUFNblGvrujEoE+I1nJ7Up5dU=;
        b=GbjQP06ZsHd3SmiFnuTpMfl57D3iKnWh3/pUpBvdNfmHoqrOtcFErk/01JU/lxGuDK
         hFfSWR+lMC+R2+Qy0p/y0hHcv8xzqpV3DxdMRL4DuYwOOSm1RQd9i4ZA+c82FFjzG2Or
         lTSbD15Nqy+G5sI+ifFptxDTrdRDdfLeAqyxQ24sPBgC4FqENTE8VxnnWAH475w1FNOy
         W5bxqZ+Cw13C/6j67vTzBA0d9M8WH8FvDghe4hG2KKao0xcWtODRLnsZKDabIpTERxDb
         +O3Q9TLQelH9UScH1uF7eu97I+G3eCxo+WmM7G09fpROftXtwOohnjKpdoctrVJRWnfB
         NjIA==
X-Gm-Message-State: AOJu0Yw/j8dA8spnzqdYEbqSBrMYdrClq0kJUlEoqEW3P/Vct53kMUVA
	p16Q7Z/q5ZSo51n1p+Qbp1DZoBnGFl1qG2QaMbKvQgXF3X4c2F9g0zXs
X-Gm-Gg: ASbGncv4S9V7pqSEar2wVoQcgJpoGF0zbAywKi6E7p7hMivdGAwOVwOKbw3i5Ra0qZj
	dg6J2Zt54MAiLgCpfB6uQRhOuyNB45QFBhW+dwB9WU1Z8HvstXq/czzUsP+IC+XKHn29hQmzV6n
	QlDZxb6uqyy5jTWoCaoY4/6CaATLq/Q+vaVT84N1WPdN2zQFAU9xJU0OXH3gvufeHj6bVG/GGMc
	G18iPFocGB/g++soI21vmQ5p3tAkrgG40kCeYSepGE0xOrDAEt2k5Hrubzob/wH3hW8RK+ZoVyr
	eyTNegC555H2eSdUCBodI0OmnRn9G1QREdi4fuE7v7s1YwfljC9af3KdqXaUGkGcrV6WQtF62s/
	xhE8boVrkljxfjdl/45fxPPerI3xxh/WhEz/Pf7x1aS1OdVXOnPoJnUfa1WEpoo/UCCODKPg=
X-Google-Smtp-Source: AGHT+IFAMwtvZCzUVy9Ehrpy2gLOgaqb6fBMp+d4njeONzipyZ+GVHJuLEjJ8vVjeKb++L+26ojrYQ==
X-Received: by 2002:a05:651c:4392:20b0:376:2802:84b9 with SMTP id 38308e7fff4ca-37628028c18mr4681751fa.24.1760027400043;
        Thu, 09 Oct 2025 09:30:00 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39d2fe6sm29892321fa.1.2025.10.09.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:29:59 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Ulf Hansson <ulf.hansson@linaro.org>,  Shawn Guo <shawnguo@kernel.org>,
  "Rob Herring (Arm)" <robh@kernel.org>,  Angelo Dureghello
 <angelo@kernel-space.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<87zfa016bd.fsf@osv.gnss.ru>
	<CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
Date: Thu, 09 Oct 2025 19:29:59 +0300
In-Reply-To: <CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
	(Fabio Estevam's message of "Thu, 9 Oct 2025 12:50:46 -0300")
Message-ID: <87v7ko11iw.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> Hi Sergey,
>
> On Thu, Oct 9, 2025 at 11:46 AM Sergey Organov <sorganov@gmail.com> wrote:
>
>> > I tried booting 6.17 on an imx6sx-sdb board and it booted
>> > successfully:
>>
>> Now after further investigations of the issue I find that success
>> a bit surprising.
>>
>> I've found that my problem is cured by a commit in
>>
>> https://github.com/nxp-imx/linux-imx
>>
>> that works-around an issue that looks like imx6sx generic problem, and
>> should probably cause troubles on imx6sx-sdb board as well, but doesn't?
>> The commit is:
>>
>> commit 65cf3a49ab15cdbbede3c97fd6bba731a3cd366f
>> Author:     Anson Huang <b20788@freescale.com>
>> AuthorDate: Tue Aug 18 15:53:54 2015 +0800
>> Commit:     Octavian Purdila <octavian.purdila@nxp.com>
>> CommitDate: Thu Feb 23 14:21:42 2017 +0200
>>
>>     MLK-11375-2 ARM: imx: disable cpuidle for imx6sx
>>
>>     i.MX6SX CPUIdle with ARM core power down has issue
>>     and cause system hang during kernel boot up, disable
>>     it for now and will enable it when busfreq driver
>>     is ready.
>>
>> Later (by the DAG, not by date) on the same imx_4.9.11_1.0.0_ga
>> branch at that repo, there is:
>>
>> commit 816978f83b1d8dd6ce3bd5dd62223dbfdf74bdd3
>> Author:     Anson Huang <b20788@freescale.com>
>> AuthorDate: Mon Oct 20 16:16:20 2014 +0800
>> Commit:     Octavian Purdila <octavian.purdila@nxp.com>
>> CommitDate: Thu Feb 23 14:21:42 2017 +0200
>>
>>     MLK-9708 arm: imx: add low power idle support for i.mx6sx
>>
>> that effectively reverts the aforementioned commit while adding a lot of
>> other stuff. The resulting kernel also boots fine on my hardware.
>>
>> Curiously enough, neither of these commits are there in the latest
>> branch lf-6.12.y there (and that kernel hangs on my board as well.)
>>
>> Provided the latter commit is indeed the right fix for imx6sx support in
>> the kernel, what's the procedure to get it to the mainstream Linux
>> kernel?
>
> It seems that your observation matches what Angelo (added on Cc)
> reported a long time ago:
>
> https://community.nxp.com/t5/i-MX-Processors/imx6sx-kernel-hangs-at-rootfs-mount/td-p/964920
>
> I'd like to know if the bootloader version plays a role in the
> different behavior that we see on the imx6sx-sdb versus your board.
>
> I used U-Boot 2024.07 on my imx6sx-sdb. Which version did you use? Is
> it based on an old NXP U-Boot tree?
>
> Does using a recent bootloader make the hang disappear?

Uhh... U-Boot is very old and is heavily modified anyway. I figure our
local history starts at:

rel_imx_4.1.33_7ulp_beta
commit 43bff39513ae89c476751caff427b9855af78f7e
Author: Ye Li <ye.li@nxp.com>
Date:   Fri Apr 14 13:44:48 2017 +0800

  MLK-14693 mx7ulp: Change PLL rate calculation to avoid div 0

that looks like NXP tree to me indeed, likely taken once upon a time
from:

https://gitlab.com/jcgit/uboot-imx.git

that was a mirror of original NXP repository 

git://git.freescale.com/imx/uboot-imx.git

That said, I wanted to get to recent kernel using working u-boot, then
maybe try to upgrade u-boot as well, but maybe even not. No reason as of
yet, especially as it's difficult for me to recover from a brick state
should boot-loader fail.

-- Sergey Organov

