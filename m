Return-Path: <linux-kernel+bounces-890234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBF5C3F920
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BC03A998F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCB931A542;
	Fri,  7 Nov 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BiLLG45/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53130F7FD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512577; cv=none; b=sl7OMVtye0rROvdgAW3YYAdgc0pn9x7WU1Tp42gVVeItJGQk5QpEjd9c4bKIrF6HkRVgNRgV6TZShChFufxud+Nuf1YTuKRuTrmTpbLMrDgA+AhFazQIZN8OMTW0+qMninWt24Vv43sTvO976XkuNrRlOWv27nsf/C9VapYf64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512577; c=relaxed/simple;
	bh=dAsaPC5IxnFMSg7+nhWX4vcS0ecUTFueEx5fAC/E58Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCfPbdGS5pFnI4GbhDVNEoOH1MaC5SevU/12Uw7fYAXW5kx0Sx5Yt6p3pLR3zXBq+ITJoYw66bWIFoDKW+EXc8QBmS33IorXPWni5EJGSF6XWFjCPbmz+3zS4CAz+MXX0ONMY59YxNE3goJZaftG3zGYRi56b2sNVYHoho/jTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BiLLG45/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59390875930so869692e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762512573; x=1763117373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAsaPC5IxnFMSg7+nhWX4vcS0ecUTFueEx5fAC/E58Y=;
        b=BiLLG45/lmsEEq2c/OW/B7QpJ7Ge9UE5lAh/xwpwNwBjUBTCM7vnjHum8l/R1lpyc9
         LjC4Rw4xtDrP+0BpdF5QMA704kvapop2vJ7V1pf/fap0J444gc01S5h2WDvrWLzXDqhM
         1/oK6ntuX/qb7CetJgJdE7K12jClWRRnUGrzE+rl3hNPS4EfEUlqcTb93riLREU5+hE/
         hyBbH2ib+HQ7rTnZKTcy24q59+DlJKXZlXQQLFY1oI/e5RchtGCuTDNvMNFu3uV73sVq
         fT6d52+bYg1U5iaRjHbQqZqoBW/cPVND322ZRkx/LBkUNz9QkoxFR4HfbszYm8yz49K6
         ivKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512573; x=1763117373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dAsaPC5IxnFMSg7+nhWX4vcS0ecUTFueEx5fAC/E58Y=;
        b=NMA81MFYsrHqbiRYaNXuVwOJW0nVcHXu/bgRWMDjFgtDwTE6W8cPuBEeEJgPLhevaC
         5NbErXYYORKQ8Mb1F48QdP42ift9TRAQHxHQOFa0NMnZOwnyrK0gMjFkJ0IqexFo7Baw
         7JNBo/HiDVDlLZfq4p9KUom/Tcd5Kb0nZkdgpSvaXvHjUf9FTMG7fualMkDUIWLC0zjq
         FpmcSSAfs5oo4b2shAbKbU8iLu8JSXbLJ8SFpSpcb4WJ+deip+e6dtZwhNWR1MQ1t0CB
         hNYeyXeiO4TLbRRKQXgSS3yaDJqZJIdGmlGoh2Xc9XegUFH7EGim7369b4RimkPBgph5
         OYVw==
X-Gm-Message-State: AOJu0Yydd15c394T7KORAqXrASsTT9bdvc0sSCigURzZuNDZ6a+7N4XN
	VJdrcJOzsEttGmghjwzeMdmXR5ouOSZJxrPtdbtRLy/2CFUvhR2OINWGqJCNehFrYpmhKtlbmgs
	T1PSUkySy6snQG9daRDYM/pbfiazcbe07YMEcufEQoQ==
X-Gm-Gg: ASbGncstXyizzWRVBT+rUqRZ5OTHa6x72Re1vi/DLw3THTCI2lVJ4KxHW+DXWF+AW5g
	fFklJOl6JswvRsSDQb01HEDWq5cW0cv+zyje9miNkelYDTBHAomYRmrYDhJJ7k0SaYSkM4p9g3x
	JhpHWCqeUaQY3bvV9iYX9W+okAKowsBp2TQB7TvXYwL/RoJgRkadmjNIlv3fm9FrRuZW3nlP9ZT
	U+UXUFAirj4UH0DH2Muj5Ps7hHhibyY+J8ZZSvrj12cXMlzNdrqTKbYnaZAMGD1KtGlzWKtu1pS
	nlDJEJdck1u+d3ZPXA==
X-Google-Smtp-Source: AGHT+IGyEFUxynmzX8HDeXWwOCoTXSc4ibMJkbVABQGK/fWroXf4ieJEv1u4hQVriSfBmzUO7Wua/SSJAXLQ8DN0YF0=
X-Received: by 2002:a05:6512:234a:b0:594:55ab:5800 with SMTP id
 2adb3069b0e04-59456b7f36amr848641e87.30.1762512573203; Fri, 07 Nov 2025
 02:49:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105162736.320591-1-marco.crivellari@suse.com> <20251107094409.GT2912318@black.igk.intel.com>
In-Reply-To: <20251107094409.GT2912318@black.igk.intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 7 Nov 2025 11:49:21 +0100
X-Gm-Features: AWmQ_bnDF2CGrMS0S-84Rgvg9q2bOcjihp3igpPRiWrvE0fyOuQiBP0KAZ789xs
Message-ID: <CAAofZF6ohh+5GvXiruLJTNoveydSLDacwyG1ovnuTcVv-+kUOg@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: replace use of system_wq with system_percpu_wq
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 10:44=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>[...]
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
>
> Applied to thunderbolt.git/next, thanks!

Many thanks!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

