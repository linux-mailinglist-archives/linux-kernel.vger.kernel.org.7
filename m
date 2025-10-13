Return-Path: <linux-kernel+bounces-849929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBC9BD159D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9C8D4E55B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30DC221282;
	Mon, 13 Oct 2025 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V+j1Hnb7"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F31CA84
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760328251; cv=none; b=VPOxeF2s7GQXTXJCvDgjUz6U+TXnGUHj+3CSX6GkIeVcXbf7QSq7HPYpTmm7G+FWfptyEFK+qMmYqz9C2r4v5BE0WhkAWhi7HIEZlWHfwQv246DxZmLN1awuNOfUzJ+7DkWTWSPlIhl+NzA4Id9rwGWHlTbGp1F7U8ags1kne/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760328251; c=relaxed/simple;
	bh=3eGY0AcUThBIod555E4HhcocUKebMojSUCKc4CiUKOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOQEe8Mx8pbxlE+cmDKjda50owIkq0kesDxndJ9Bz8eW0V4SwUUqSfevGCasUlsvY8VfqfSgU+Ne1quDSntV+GifKeT9jMWQnBiaDyRQr+747YcAGQgoQBsRuQn32Z8MjC5mPxpo+bKwTM1jQ0FuY4NQG5ZMTaMAmq75SQm43yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V+j1Hnb7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36bf096b092so38047401fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760328247; x=1760933047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eGY0AcUThBIod555E4HhcocUKebMojSUCKc4CiUKOE=;
        b=V+j1Hnb7bplevAjsA8ym83LLU2pgYMXJiM36l2sG0Cggb0pS2BTcWyKPo/Asrwikqe
         pkjx6OPfWpEzkJduvyyk3ZpUIEZBjjtgFTASak+Uy5Iw+BfzZTGmsZ5pFTUeLOXPK2eu
         5SE8XbhiYscNlz2kNwQxTYkCnA5cPx0b23TgGr919kVh1aUPkg24tDMrq4dSAgLvvcTY
         yqhWU2sS+7J+J3DNMfOfW2xqMkkSwbBQ551wXuAynmeSqXlWkmEaStxCTK2gmTLLx2/1
         r5uGTHnALBgWZHAtP657G06xrZj3bFAaX/g+fiijKcm3ZZ5nxYGeYTMIS0zXlhe+AExB
         fm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760328247; x=1760933047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eGY0AcUThBIod555E4HhcocUKebMojSUCKc4CiUKOE=;
        b=h5fzsw6kaLEUjCUhRAigbB85e/ca9qNXJ9djd5Ectr2GfhaHwpXHeey7lY6oDWni67
         QPJNjnYVgjodYOStZJ/3y9WPXpsnUUQhm1oT9XTJKV8rs2HHgjFrcQCu3LJKOMbqMoBe
         UK2nQ+icImf6w1+/jy9B/vHChUnOp6hrqZaNf1QR8DWNepwf0212uqGTwWf1WRT1ZC7C
         h6N/X9CkmFe4l5tDcxI0QVnywQyOTJD/Numbgsnp4WaS5ARKosiZowzwxnu9uGARBoaM
         ZTIa+RkinEMvSb78/zS8jgTs147GFAL6dsCdHFkuIpYzSWsTUUhbmDxCh0b1qwOQcych
         zhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvh9DB8+KseoiFmC8sBR0d1T7mh0OISvHZejLEH4sdkYlAxR/HaBPj5CMRjOSvxvs/fr3yT8VpmrNdJCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWkX0N2KgLBEHFrqfv3caYjHRDSEkNZSryeNXqTLz5SidADFQ
	0s98zthIUT+83GM4+DTPt1Wl2ByJL/7lhzqwQL1KpivmWHMl9HwvlxfMjba8ppKo2ebg9uPRdv9
	Alrt1Fwmb0yq4lbvDE0GiVUIUZ00+7KUXMs0nLSun8w==
X-Gm-Gg: ASbGncsIOFGhtC0RJlRvTpGQSuk7K5c1BF9fFn4jWhuK3AciU/zqUn+Ra/8bM8YkMz4
	gnEJv3zvgt5LcRHcIbAwwIFT7i0UOhVTurI4SXFE0XIw5EeNfq7hdZdHlg5nJGaKcq8UQq/8+ME
	XskKxLdoQMegTZ/p8+nanKROY9tqHaXFlRTTglub3STZeTcxVLQcs/DVi5FvKybDA1tthlDT8cX
	XNOR1TM3pvVVcU29Q+NPG2AMan6WXwoFAAjfoT3ecaaxw==
X-Google-Smtp-Source: AGHT+IE0rggG8rwZ9a1p14VnFxT/ZqFMnmZQQUmYWuoCAqef6nge1SXll1x478ZdTK1vw0muIbu/il7UNi3O/2Lgi+0=
X-Received: by 2002:a2e:be0d:0:b0:375:d4ab:b297 with SMTP id
 38308e7fff4ca-37609e9236amr48527381fa.40.1760328246874; Sun, 12 Oct 2025
 21:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz> <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com> <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com> <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
 <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
In-Reply-To: <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Mon, 13 Oct 2025 12:03:29 +0800
X-Gm-Features: AS18NWCowNR5GjE4I1fPqkrYdc53m-GbO09yFPHSPoOFxHc1tTSHu_k2a0vqpdU
Message-ID: <CACSyD1N0fb1H3_ssEyaAMh=2shQy-64gG_t3MqkedwfOLEExEA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: jbohac@suse.cz, Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: kas@kernel.org, riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>, 
	Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

We=E2=80=99re encountering the same issue that this patch series aims to ad=
dress,
and we also planned to leverage CMA to solve it. However, some implementati=
on
details on our side may differ, so we=E2=80=99d like to discuss our propose=
d approach we
have tried in this thread.

1. Register a dedicated CMA area for kexec kernel use
Introduce a dedicated CMA region (e.g., kexec_cma) and allocate the control
code page and crash segments from this area via cma_alloc. Pages for a
normal kexec kernel can also be allocated from this region [1].

2. Keep crashkernel=3Dxx unchanged (register CMA)
We introduced a flag in the kexec syscall to dynamically enable
or disable memory reuse without system reboot. For example, with
crashkernel=3D500M (a 500M cma region), cma_alloc may use 100M for the
kernel,initrd and others data. This region could then be reused for the cur=
rent
kernel if the reuse flag is set in the syscall, or left unused for dumping =
user
pages in case of a crash.

3. Keep this CMA region inactive by default
The CMA region should remain inactive until kexec is enabled with the reuse=
 flag
(or fully reused when the kdump service is not enabled). It can then
be activated for
use by the current kernel.

4. Introduce a new migratetype KEXEC_CMA
Similar to the existing CMA type, this would be used to:
1)Prevent page allocation from this zone for get_user_pages (GUP).
2)Handle page migration correctly when pages are pinned after allocation.

We would like to discuss the feasibility and potential implications of
this approach with the community.

[1]:https://lore.kernel.org/all/20250610085327.51817-1-graf@amazon.com/

Best regards,
Zhongkun He

