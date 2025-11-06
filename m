Return-Path: <linux-kernel+bounces-888381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8CAC3A9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689C21A43451
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175F30F92F;
	Thu,  6 Nov 2025 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb9oEDm9"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99530CDBA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429059; cv=none; b=GQldA2g8LQm5rL2fdR6eTG2pN41tpFRUnSOnAO7HblZya2Rz2EmohnuarxRWr31Ma5WmxzqOzU+qvkDi6AvOaBG5FH24yBkThh/pd4YRwqm+8DzqRiiIg5UpPLyZF95wHQ7vf0U5d4nr47GIq+fJE6k2h2eHofPcUAZvGT419/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429059; c=relaxed/simple;
	bh=ialkjfXPUU6X8FC+SzJ3KVgS8vsqr4ixyFVj95i+7Cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rk7rSfq31sdSqmMjfMKzSfpoXFai6Uenhdm+DQ+3SdQ3NboBgvkh11oB6OTN+irbHgsh0TTjMHRq1nKkCJDtmAo2y8paBeY1jRe4ZAkiY4OmNUMkxAXbDu/wMjudfGRK8nPkGqgdj1ayb2LKvd0cmqEaz/AgWfMnn+X+vnEomtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb9oEDm9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-793021f348fso744114b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762429057; x=1763033857; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjvib5l1jl7c+bMGrAcG+xXz8naE9IfiWdK2rk+q+nw=;
        b=Tb9oEDm9IhdqBTLycnasxJIJ6/EAwEdCYWRvMOgasSMXyaKUTRHGT2u9lDnUbrAKDc
         N8y4RxA3jxPoCwwy3svCZaQYjLgCxv2Pqjq0BZk8AOQ3AxZ1DJXke917Yo2RvxvlIPh3
         0AgWF7t8KNuepM9mdyjmUWsE50BwQ0A72SS726c8ic3MzI/0qdCbDfa5t9KRIKpyeeCs
         0IVio3UOI30ZHTBO368EwknFZuaAslf3C5HC9bn0B2SVt3Qt9saxJkGx9mtn5NrQPfzz
         IWnp4ZOfqIZK6z1wLfFl5g8ZM6db9KIKvjbNfYkKkust97YI/SmmT14g4dNvnM9eDSm1
         faLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429057; x=1763033857;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjvib5l1jl7c+bMGrAcG+xXz8naE9IfiWdK2rk+q+nw=;
        b=MPtxSf0dnTG+jCXwYnGcITx+NLko38qJm0SZc5w/2n2v79Co/h0FM/njE7qMet1qVi
         5wI5lt1HbN+qklipYJdoKH5vPNrdK0daNKiZWpxg9cfV/Qy49wZ3DTC+i9xlmx2LxOO9
         2wrE4Su3Bc7K8amAin94swEfL9NZxCANbCMghLNuAlFwKN3ZffxCRW0ilYWdXOo+pfiR
         K1pyaVe26Ls5tX/6PuFi5DWmnkooUwqH3kfdmr2oJSA7MEjbYTSzsbG0IqL9/A1uJMjf
         3lC1FSnJptnQGSO5ZcxUBsHTAnFtZOd1nN2LOh/aJwI/D2EwLfFZ3XjMaRE2z/1d6XJm
         cIpg==
X-Forwarded-Encrypted: i=1; AJvYcCWrYEAmnvcTLvB9VCLS2fqLo5RpHO8qkrEFVb1EAyJfJCcjqn7t5Nqz3EpxvJPDLzMX2z12arzCToWIMtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGC7xN0HeQcmVRP1bdpmqhK5RfKzu2BA4cvMgytz0O9oFRva2v
	zBB+wiy1gzH6gb/gXiymncU9MmIYjpdgmuOkirFSFJHr8XPon4G2MWR8geDbkHOv
X-Gm-Gg: ASbGncsQSbl3Jwwu1p6mzBRv1rn76fXvQs9JuMcusQp1pFvv0b1M+slXPH846hLw4yR
	2ixKquD6zqPbMKHOHlSAQJgrVBInYid52yzKsTqRg/JiBP6By94HD9ibSDbHT7RdCBSAM66pkcl
	h7eOXRAiTbVxeud7oyCJhqxWlzefQgC0UVeSa0D6KMGRZOMXeNfU52xvHDbWDJ98mXbK71Mkyqw
	WlRLlR6I+IIEQgXVNdpOahdTH4VqeXrLj3wIlWc8xDq7pPE4IwhUMlpXc2a5zaLbvRI3lXy5hWH
	qezZi8Eg1BMT1JTghB9pjP3E5tkuTmOa+nZAR95QLuWNliCYEBJokyBcoYSOmRIsa9T8atzfKDC
	YGHLfHKM9Z5nOrY49yRC8pnxLR6H8jaFXtCPrJLQC57/by67KMOzAfm1USrjhjhQp9ulwPUAfCx
	VQOgSChcXJB58fmzynTlt9/bSv9eL4IJbzkA0mG1E9QQaXoGt1
X-Google-Smtp-Source: AGHT+IE49q3UoW4OFpWbNglvInQNVRlN+yhDQFQFunxA5RskR8zFPZ2d8CXgzPfWY0cjgsF/X3MOtg==
X-Received: by 2002:a05:6a00:4601:b0:7a2:74e5:a4a4 with SMTP id d2e1a72fcca58-7ae1eda0949mr8034636b3a.19.1762429057535;
        Thu, 06 Nov 2025 03:37:37 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:5041:b658:601d:5d75? ([2401:4900:88f4:f6c4:5041:b658:601d:5d75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af826f9520sm2452518b3a.56.2025.11.06.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:37:37 -0800 (PST)
Message-ID: <f3c89a9182387cd0df012726fc30841aae8d330d.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] net: ethernet: fix uninitialized
 pointers with free attr
From: ally heev <allyheev@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang	
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "Cui, Dexuan"	
 <decui@microsoft.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	 <linux-hyperv@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 06 Nov 2025 17:07:29 +0530
In-Reply-To: <DS4PPF7551E6552E6053CC02144D0987191E5C2A@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: 
	<20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com>
	 <DS4PPF7551E6552E6053CC02144D0987191E5C2A@DS4PPF7551E6552.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 10:18 +0000, Loktionov, Aleksandr wrote:
[..]
> Code style:
> The new declaration + initializer is good, but please ensure both hunks s=
tay within ~80 columns in drivers/net/*.
> Wrapping like this is fine:
>=20
> struct ice_flow_prof_params *params __free(kfree) =3D
>         kzalloc(sizeof(*params), GFP_KERNEL);

I ran checkpatch with `$max_line_length` set to 80. It didn't throw any err=
ors/warnings

Regards,
Ally


